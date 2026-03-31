--新宋辽宝箱

--脚本号
x892786_g_scriptId = 892786
--这里的第一个一定要填
x892786_g_Gift = {
	{20500001,1},
	{20500002,1},
	{20500003,1},
	{20501001,1},
	{20501002,1},
	{20501003,1},
	{20502001,1},
	{20502002,1},
	{20502003,1},
}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x892786_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x892786_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x892786_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	--测试背包空间
	BeginAddItem(sceneId)
	AddItem( sceneId,x892786_g_Gift[1][1],x892786_g_Gift[1][2])	
	if EndAddItem(sceneId,selfId) <= 0 then
		return 0
	end
	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x892786_OnDeplete( sceneId, selfId )
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
function x892786_OnActivateOnce( sceneId, selfId )
	local nRandIndex = random(1,getn(x892786_g_Gift))
	BeginAddItem(sceneId)
	AddItem( sceneId,x892786_g_Gift[nRandIndex][1],x892786_g_Gift[nRandIndex][2])	
	if EndAddItem(sceneId,selfId) <= 0 then
		return 0
	end
	AddItemListToHuman(sceneId,selfId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	x892786_NotifyFailTips( sceneId, selfId, ScriptGlobal_Format("#{XSLDZ_210128_18}",tostring(x892786_g_Gift[nRandIndex][2]),GetItemName(sceneId,x892786_g_Gift[nRandIndex][1])) )
	return 1
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x892786_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x892786_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
