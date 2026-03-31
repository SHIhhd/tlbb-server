--塞上长歌礼盒

--脚本号
x505108_g_scriptId = 505108
--这里的第一个一定要填
x505108_g_Gift = {
	[38002586] = {
		{10124753,1},	--拾取绑定
		{20307207,1},
		{30008194,1},
	},
	[38002589] = {
		{10124745,1},
		{20307207,1},
		{30008194,1},
	},
}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x505108_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x505108_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x505108_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x505108_g_Gift[itemTblIndex] == nil then
		x505108_NotifyTips(sceneId,selfId,"物品非法");
		return 0 
	end
	--测试背包空间
	BeginAddItem(sceneId)
	for i = 1,getn(x505108_g_Gift[itemTblIndex]) do
		AddItem( sceneId,x505108_g_Gift[itemTblIndex][i][1],x505108_g_Gift[itemTblIndex][i][2])	
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return 0
	end
	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x505108_OnDeplete( sceneId, selfId )
	if LuaFnDepletingUsedItem( sceneId, selfId ) > 0 then
		return 1
	end

	return 0
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x505108_OnActivateOnce( sceneId, selfId )
	
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	BeginAddItem(sceneId)
	for i = 1,getn(x505108_g_Gift[itemTblIndex]) do
		AddItem( sceneId,x505108_g_Gift[itemTblIndex][i][1],x505108_g_Gift[itemTblIndex][i][2])	
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return 0
	end
	AddItemListToHuman(sceneId,selfId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	for i = 1,getn(x505108_g_Gift[itemTblIndex]) do
		--YNZJ_210127_13	#H您获得了%s0个%s1。	
		x505108_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{YNZJ_210127_13}",tostring(x505108_g_Gift[itemTblIndex][i][2]),GetItemName(sceneId,x505108_g_Gift[itemTblIndex][i][1])) )
	end
	return 1
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x505108_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x505108_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
