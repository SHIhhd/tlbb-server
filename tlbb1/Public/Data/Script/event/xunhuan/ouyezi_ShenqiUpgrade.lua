--神器进阶

x500505_g_scriptId = 500505
x500505_UpgradeMoney = 50000 --神器进阶所需金币
--神兵符
x500505_ShenBingFu_Need = 5 --炼魂所需神兵符

--**********************************
--v3炼魂改造 临时属性保留
--**********************************
function x500505_DoRefreshSuperAttr(sceneId,selfId,nEquipPos)
--	CXYH_140813_45	#H尚未进行神器炼魂，无法替换炼魂后的神器属性。	
--	CXYH_140813_46	#H该属性无效，无法替换炼魂后的神器属性！	
--	CXYH_140813_47	#H该属性不是当前神器炼魂后的属性，无法替换炼魂后的神器属性。	
--	CXYH_140813_48	#H替换炼魂后神器属性成功！	
	local MenpaiID = GetMenPai(sceneId,selfId)
	local ItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nEquipPos )
	local g_NewId, g_NeedMoney = GetShenqiUpgradeInfo( ItemID, MenpaiID )
	if g_NewId == -1 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_46}" )
		return
	end
	local nRet = LuaFnShenqiUpgradeSaveAttr(sceneId,selfId,nEquipPos)
	if nRet == -1 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_45}" )
		return
	elseif nRet == -2 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_47}" )
		return
	elseif nRet == -3 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_46}" )
		return
	elseif nRet == 1 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_48}" )
		
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, nEquipPos )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 198311141 )
	end
end

--**********************************
--神器炼魂请求 这里直接呼叫客户端特殊提示
--**********************************
function x500505_ShenQiConfirm(sceneId,selfId,nEquipPos,nTargetID)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nEquipPos )
		UICommand_AddInt( sceneId, nTargetID )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 500505 )
end
--**********************************
--神器炼魂
--**********************************
function x500505_OnShenqiUpgrade(sceneId,selfId,nEquipPos,nTargetID)
	local MenpaiID = GetMenPai(sceneId,selfId)
	local ItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nEquipPos )
	local g_NewId, g_NeedMoney = GetShenqiUpgradeInfo( ItemID, MenpaiID )
	if g_NewId == -1 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_37}" )
		return
	end
	--钱是否够....
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < g_NeedMoney then
		x500505_NotifysTip( sceneId, selfId,  "#{CXYH_140813_40}" )
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId,nEquipPos) ~= 1 then
		x500505_NotifysTip( sceneId, selfId,"#{SQSJ_0708_03}")
		return
	end
	local MatID,MatNum = GetShenqiUpMaterial( ItemID, 0 )
	if LuaFnGetAvailableItemCount(sceneId, selfId, MatID) < MatNum then
		x500505_NotifysTip( sceneId, selfId,"#{CXYH_140813_39}")
		return
	end
	LuaFnCostMoneyWithPriority( sceneId, selfId, g_NeedMoney)
	LuaFnDelAvailableItem(sceneId,selfId,MatID,MatNum);
	--进阶
	--计算quality
	local nEquipLev = GetBagItemLevel(sceneId,selfId,nEquipPos)
	local nItemQuality = 5
	if nEquipLev < 90 then
		nItemQuality = 5
	elseif nEquipLev < 100 then
		nItemQuality = 6
	elseif nEquipLev < 110 then
		nItemQuality = 7
	end
	--生成属性即可
	LuaFnShenqiUpgradeGenAttr(sceneId,selfId,nEquipPos,g_NewId,nItemQuality)
	--audit
--	LuaFnAuditShenQiUpgrade(sceneId,selfId,ItemID)
	--公告
	x500505_NotifysTip( sceneId, selfId,"#{CXYH_140813_41}")
--	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	
--	local szEquipTrans = GetBagItemTransfer( sceneId, selfId, nEquipPos )
--	local nGlobalText = format("#{_INFOUSR%s}#{SQSJ_0708_06}#{_INFOMSG%s}#{SQSJ_0708_07}",GetName(sceneId,selfId),szEquipTrans)
--	AddGlobalCountNews( sceneId,nGlobalText);
end
--**********************************
--醒目提示
--**********************************
function x500505_NotifysTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end