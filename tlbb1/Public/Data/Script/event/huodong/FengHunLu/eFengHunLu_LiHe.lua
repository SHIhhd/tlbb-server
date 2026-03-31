--封魂录礼包

--脚本号
x791011_g_scriptId = 791011
x791011_g_HunYuFuXia = {
	{38002528,2},
	{38002524,3},
	{38002519,4},
}
x791011_g_tableRewardInfo	=
{
	[1] = {nGiveItemID = 38002528, nGiveItemNum = 2, nGiveAddItemID = 0, nGiveAddItemNum = 0, nLogType = 0, nYBLogItemID = -1,  nNeedBagSpace = 1, nNeedMatSpace = 0, nCostYuanBao = 0, },
	[2] = {nGiveItemID = 38002528, nGiveItemNum = 2, nGiveAddItemID = 38002524, nGiveAddItemNum = 3, nLogType = 1, nYBLogItemID = 40004852, nNeedBagSpace = 2, nNeedMatSpace = 0, nCostYuanBao = 500, },
	[3] = {nGiveItemID = 38002528, nGiveItemNum = 2, nGiveAddItemID = 38002519, nGiveAddItemNum = 4, nLogType = 2, nYBLogItemID = 40004853, nNeedBagSpace = 2, nNeedMatSpace = 0, nCostYuanBao = 20000, },
}
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x791011_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x791011_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x791011_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	if GetLevel(sceneId,selfId) < 85 then
		x791011_NotifyFailTips( sceneId, selfId, "#{ZSPVP_211231_08}" )
		return 0
	end
	--魂玉福匣直接给东西
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if itemTblIndex == 38002536 then
		--模拟放4个魂玉检测背包空间
		BeginAddItem(sceneId)
		AddItem( sceneId,38002519,4)	
		if EndAddItem(sceneId,selfId) <= 0 then
			return 0
		end
		return 1
	end
	--打开客户端UI供玩家选择
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )-- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
		UICommand_AddInt( sceneId, nBagPos )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79101101 )
	
	return 0
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x791011_OnDeplete( sceneId, selfId )
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
function x791011_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if itemTblIndex ~= 38002536 then
		return 0
	end
	local nRandIndex = random(1,getn(x791011_g_HunYuFuXia))
	BeginAddItem(sceneId)
	AddBindItem( sceneId,x791011_g_HunYuFuXia[nRandIndex][1],x791011_g_HunYuFuXia[nRandIndex][2])	
	if EndAddItem(sceneId,selfId) <= 0 then
		return 0
	end
	AddItemListToHuman(sceneId,selfId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	
	x791011_NotifyFailTips(sceneId,selfId,ScriptGlobal_Format("#{XYSHFC_20211229_151}",tostring(x791011_g_HunYuFuXia[nRandIndex][2]),GetItemName(sceneId,x791011_g_HunYuFuXia[nRandIndex][1])))
	
	return 1
end

--**********************************
--客户端选择
--**********************************
function x791011_OnUIClickCallBack( sceneId, selfId,nItemPos,nSelect,nConfirm )
	--检测是否正确物品
	if LuaFnGetItemTableIndexByIndex(sceneId,selfId,nItemPos) ~= 38002535 then
		return
	end
	if nSelect > 1 and nConfirm ~= 1 then
		
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 3 )-- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
			UICommand_AddInt( sceneId, nItemPos )
			UICommand_AddInt( sceneId, nSelect )
			if nSelect == 2 then
				UICommand_AddString( sceneId, "#{XYSHFC_20211229_159}" )
			elseif nSelect == 3 then
				UICommand_AddString( sceneId, "#{XYSHFC_20211229_162}" )
			end
			
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 79101102 )
		return
	end
	local tPrizeTable = x791011_g_tableRewardInfo[nSelect];
	if tPrizeTable == nil then
		return
	end
	--背包空间检测
	BeginAddItem(sceneId)
	AddBindItem( sceneId,tPrizeTable.nGiveItemID,tPrizeTable.nGiveItemNum)	
	if tPrizeTable.nGiveAddItemID > 0 then
		AddBindItem( sceneId,tPrizeTable.nGiveAddItemID,tPrizeTable.nGiveAddItemNum)	
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--元宝数量检测
	if tPrizeTable.nCostYuanBao > 0 then
		local nYuanBao = YuanBao(sceneId,selfId,-1,3,0)
		if nYuanBao < tPrizeTable.nCostYuanBao then
			x791011_NotifyFailTips( sceneId, selfId, "#{XYSHFC_20211229_152}" )
			return
		end
		--元宝消耗
		LuaFnCostYuanBao(sceneId,selfId,tPrizeTable.nCostYuanBao,x791011_g_scriptId,"OnUIClickCallBack",tPrizeTable.nGiveItemID,tPrizeTable.nGiveItemNum)
	end
	--给东西
	AddItemListToHuman(sceneId,selfId)
	--礼包销毁
	EraseItem( sceneId, selfId, nItemPos )
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
	--提示
	x791011_NotifyFailTips(sceneId,selfId,ScriptGlobal_Format("#{XYSHFC_20211229_151}",tostring(tPrizeTable.nGiveItemNum),GetItemName(sceneId,tPrizeTable.nGiveItemID)) )
	if tPrizeTable.nGiveAddItemID > 0 then
		x791011_NotifyFailTips(sceneId,selfId,ScriptGlobal_Format("#{XYSHFC_20211229_151}",tostring(tPrizeTable.nGiveAddItemNum),GetItemName(sceneId,tPrizeTable.nGiveAddItemID)) )
	end
	--UI关闭
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 0 )-- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79101101 )
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x791011_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x791011_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
