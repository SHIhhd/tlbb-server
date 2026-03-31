--蝶舞流芳礼包
--脚本号
x791006_g_scriptId = 791006
x791006_g_itemids = {10124345,10124346,10124347}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x791006_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x791006_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x791006_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	--检测是否正确物品
	if nItemId ~= 38002218 then
		return 0
	end
	if GetLevel(sceneId,selfId) < 15 then
		x791006_NotifyFailTips(sceneId,selfId,"#{XLYXY_210126_35}")
		return 0
	end
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x791006_NotifyFailTips(sceneId,selfId,"#{XLYXY_210126_36}")
		return 0
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79100601 )
	return 0
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x791006_OnDeplete( sceneId, selfId )
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
function x791006_OnActivateOnce( sceneId, selfId )
	return 1
end

--**********************************
--客户端选择
--**********************************
function x791006_OnSelectItem(sceneId,selfId,nSelect)
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	if nSelect < 1 or nSelect > getn(x791006_g_itemids) then
		return
	end
	local tPrizeTable = x791006_g_itemids[nSelect];
	if tPrizeTable == nil then
		return
	end
	if GetLevel(sceneId,selfId) < 15 then
		x791006_NotifyFailTips(sceneId,selfId,"#{XLYXY_210126_54}")
		return
	end
	--背包空间检测
	BeginAddItem(sceneId)
	AddBindItem( sceneId,tPrizeTable,1)	
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--给东西
	AddItemListToHuman(sceneId,selfId)
	--礼包销毁
	LuaFnDelAvailableItem(sceneId,selfId,nItemId,1)
	--提示
	x791006_NotifyFailTips(sceneId,selfId,ScriptGlobal_Format("#{XLYXY_210126_42}",GetItemName(sceneId,tPrizeTable)))
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	--UI关闭
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,0)
	EndUICommand( sceneId )
	DispatchUICommand(sceneId,selfId,79100601)
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x791006_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x791006_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
