--云月留魂匣
--脚本号

x792008_g_scriptId = 792008
x792008_g_MinLevel = 15
x792008_g_ItemId = 38002493

x792008_g_itemids = {10141965,10141919,10141920,10141987}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x792008_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x792008_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x792008_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	--检测是否正确物品
	if nItemId ~= x792008_g_ItemId then
		return 0
	end
	if GetLevel(sceneId,selfId) < x792008_g_MinLevel then
		x792008_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_36}")
		return 0
	end
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x792008_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_31}")
		return 0
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79200801 )
	return 0
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x792008_OnDeplete( sceneId, selfId )
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
function x792008_OnActivateOnce( sceneId, selfId )
	return 1
end

--**********************************
--客户端选择
--**********************************
function x792008_OnSelectItem(sceneId,selfId,nSelect)
	if GetLevel(sceneId,selfId) < x792008_g_MinLevel then
		x792008_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_36}")
		return
	end
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	if nSelect < 1 or nSelect > getn(x792008_g_itemids) then
		x792008_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_44}")
		return
	end
	local tPrizeTable = x792008_g_itemids[nSelect];
	if tPrizeTable == nil then
		x792008_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_44}")
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
	x792008_NotifyFailTips(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_38}",GetItemName(sceneId,tPrizeTable)))
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	--UI关闭
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,0)
	EndUICommand( sceneId )
	DispatchUICommand(sceneId,selfId,79200801)
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x792008_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x792008_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
