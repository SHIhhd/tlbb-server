--荒魂檀箱

--脚本号
x893079_g_scriptId = 893079
x893079_g_ShengHun = 38002530
x893079_g_HuangHun = {38002520,38002521,38002522,38002523,38002524}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x893079_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x893079_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x893079_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	if GetLevel(sceneId,selfId) < 85 then
		x893079_NotifyFailTips( sceneId, selfId, "#{ZSPVP_211231_08}" )
		return 0
	end
	--检测背包空间是否足够
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
		x893079_NotifyFailTips( sceneId, selfId, "您的背包空间不足，请至少空出2个道具栏。" )
		return 0
	end
	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x893079_OnDeplete( sceneId, selfId )
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
function x893079_OnActivateOnce( sceneId, selfId )
	-- 找到相应条目
	local nRandIdx = random(1,getn(x893079_g_HuangHun))
	LuaFnTryRecieveMultiItem(sceneId,selfId,x893079_g_ShengHun,1,2,1);
	LuaFnTryRecieveMultiItem(sceneId,selfId,x893079_g_HuangHun[nRandIdx],1,1,1);
	--您获得%s个%s。
	x893079_NotifyFailTips( sceneId, selfId, ScriptGlobal_Format("#{ZSPVP_211231_13}",2,GetItemName(sceneId,x893079_g_ShengHun)) )
	x893079_NotifyFailTips( sceneId, selfId, ScriptGlobal_Format("#{ZSPVP_211231_13}",1,GetItemName(sceneId,x893079_g_HuangHun[nRandIdx])) )
	
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 18, 0 )
	return 1
end
--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x893079_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x893079_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
