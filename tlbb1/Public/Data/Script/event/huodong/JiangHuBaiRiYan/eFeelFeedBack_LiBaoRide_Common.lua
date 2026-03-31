--通用七日脚本坐骑礼盒

--脚本号
x792014_g_scriptId = 792014
x792014_g_MinLevel = 15

x792014_g_itemgets_dress = {
[38002607]={ id={10141932,10141919,10141920,10141987}, 
						str={"#{EZNQQD_20220624_41}","#{EZNQQD_20220624_42}","#{EZNQQD_20220624_43}","#{EZNQQD_20220624_44}"},
--						bkimg = "set:FeelFeedBack700_1 image:FeelFeedBack700_BK2"
					 },
[38002791]={ id={10142037,10141919,10141920,10141987}, 
						str={"#{QRDL_20211229_40}","#{QRDL_20211229_41}","#{QRDL_20211229_42}","#{QRDL_20211229_43}"},
--						bkimg = "set:FeelFeedBack700_1 image:FeelFeedBack700_BK2"
					 },
[38002779]={ id={10142059,10141919,10141920,10141987}, 
						str={"#{QRDL_20211229_53}","#{QRDL_20211229_41}","#{QRDL_20211229_42}","#{QRDL_20211229_43}"},
--						bkimg = "set:FeelFeedBack700_1 image:FeelFeedBack700_BK2"
					 },			
}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x792014_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x792014_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x792014_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	--检测是否正确物品
	if x792014_g_itemgets_dress[nItemId] == nil then
		return 0
	end
	if GetLevel(sceneId,selfId) < x792014_g_MinLevel then
		x792014_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_36}")
		return 0
	end
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x792014_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_31}")
		return 0
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1)
		UICommand_AddInt( sceneId, nBagPos)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79201401 )
	return 0
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x792014_OnDeplete( sceneId, selfId )
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
function x792014_OnActivateOnce( sceneId, selfId )
	return 1
end

--**********************************
--客户端选择
--**********************************
function x792014_OnSelectItem(sceneId,selfId,nBagPos,nSelect)
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	if nItemId == nil or x792014_g_itemgets_dress[nItemId] == nil then
		return
	end
	if nSelect < 1 or nSelect > getn(x792014_g_itemgets_dress[nItemId].id) then
		return
	end
	local tPrizeTable = x792014_g_itemgets_dress[nItemId].id[nSelect];
	if tPrizeTable == nil then
		return
	end
	if GetLevel(sceneId,selfId) < x792014_g_MinLevel then
		x792014_NotifyFailTips(sceneId,selfId,"#{QRDL_20211229_36}")
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
	LuaFnEraseItem(sceneId,selfId,nBagPos)
	--提示
	x792014_NotifyFailTips(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_38}",GetItemName(sceneId,tPrizeTable)))
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	--UI关闭
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,0)
	EndUICommand( sceneId )
	DispatchUICommand(sceneId,selfId,79201401)
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x792014_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x792014_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
