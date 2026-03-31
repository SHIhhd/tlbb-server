--外观中心
--兽魂外观自由激活

x999903_g_scriptId = 999903
--兽魂
x999903_g_ExteriorType = 4
x999903_g_NPCPos = {92,134}
--**********************************
--激活兽魂外观
--**********************************
function x999903_UnlockExteriorPoss( sceneId, selfId, nExteriorID,bOk )
	if GetLevel(sceneId,selfId) < 85 then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_37}" )
		return
	end
	--只能在苏州激活
	if sceneId ~= 1 then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_38}" )
		return
	end
	--取距离
	local nPosX,nPosY = LuaFnGetUnitPosition(sceneId, selfId);
	local nKPosX,nKPosY = x999903_g_NPCPos[1],x999903_g_NPCPos[2]
	local nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
	if nDistance > 12 then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_39}" )
		return
	end
	--获取兽魂的基本信息
	local nID,nNeedItem,nNeedCount,nNeedMoney,szPossName = LuaFnGetExteriorPossInfo(sceneId,selfId,nExteriorID)
	if nID <= 0 then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_45}" )
		return
	end
	--查询是否已激活
	if LuaFnIsHaveExterior(sceneId,selfId,x999903_g_ExteriorType,nExteriorID) == 1 then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_46}" )
		return
	end
	--查询道具是否满足
	local nItemNum = LuaFnGetAvailableItemCount( sceneId, selfId, nNeedItem )
	if nItemNum < nNeedCount then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_47}" )
		return
	end
	--钱是否够
	local moneyJZ = GetMoneyJZ (sceneId, selfId);
	local money = GetMoney (sceneId, selfId);
	
	-- 物品和金钱检测都通过
	if (moneyJZ + money < nNeedMoney)	then
		x999903_NotifyTips( sceneId, selfId, "#{SHRH_20220427_48}" )
		return
	end
	if bOk ~= 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId,nExteriorID)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99990302 )   
		return
	end
	--扣钱扣物品
	LuaFnDelAvailableItem(sceneId,selfId,nNeedItem,nNeedCount)
	LuaFnCostMoneyWithPriority( sceneId, selfId, nNeedMoney);
	
	--激活
	LuaFnActiveExterior(sceneId,selfId,x999903_g_ExteriorType,nExteriorID,-1);

	x999903_NotifyTips( sceneId, selfId,ScriptGlobal_Format("#{SHRH_20220427_52}",szPossName) )
	--给个BUFF提示
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	--来个世界公告
	local globalNews = ScriptGlobal_Format( "#{SHRH_20220427_51}", GetName(sceneId,selfId),szPossName)
	BroadMsgByChatPipe( sceneId, selfId, globalNews, 4 )
end

--**********************************
--提示信息
--**********************************
function x999903_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
