--外观中心-幻饰武器

x893340_g_scriptId = 893340
x893340_g_NPCPos = {242,129}

--**********************************
--升级幻饰武器外观
--**********************************
function x893340_TryExteriorWeaponLevelUp( sceneId, selfId, nExteriorID )
	if sceneId ~= 0 then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_32}" )
		return
	end
	--取距离
	local nPosX,nPosY = LuaFnGetUnitPosition(sceneId, selfId);
	local nKPosX,nKPosY = x893340_g_NPCPos[1],x893340_g_NPCPos[2]
	local nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
	if nDistance > 12 then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_33}" )
		return
	end
	--获取幻饰武器
	local nID,szName = LuaFnGetExteriorWeaponInfo(nExteriorID)
	if nID < 0 then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_34}" )
		return
	end
	local nHave = LuaFnIsHaveExteriorWeapon(sceneId,selfId,nExteriorID)
	if nHave ~= 1 then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_35}" )
		return
	end
	--获取幻饰武器的等级
	local lv, nextlv, money, item, itemnum = LuaFnGetExteriorWeaponLevelData(sceneId,selfId,nExteriorID)
	if lv < 0 then
		return
	end
	if lv == nextlv then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_36}" )
		return
	end
	--检查物品是否足够
	local nItemNum = LuaFnGetAvailableItemCount( sceneId, selfId, item )
	if nItemNum < itemnum then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_37}" )
		return
	end
	--钱是否够
	local moneyJZ = GetMoneyJZ (sceneId, selfId);
	local nCurMoney = GetMoney (sceneId, selfId);
	
	-- 物品和金钱检测都通过
	if (moneyJZ + nCurMoney < money)	then
		x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_38}" )
		return
	end
	--扣除物品及金钱
	LuaFnDelAvailableItem(sceneId,selfId,item,itemnum)
	LuaFnCostMoneyWithPriority( sceneId, selfId, money);
	
	--升级
	LuaFnExteriorWeaponLevelUp(sceneId,selfId,nExteriorID)
	x893340_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_39}" )
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	
	lv, nextlv, money, item, itemnum = LuaFnGetExteriorWeaponLevelData(sceneId,selfId,nExteriorID)
	if lv == nextlv then
		--来个世界公告
		local globalNews = ScriptGlobal_Format( "#{HSWQ_20220607_46}", GetName(sceneId,selfId),szName)
		BroadMsgByChatPipe( sceneId, selfId, globalNews, 4 )
	end
end

--**********************************
--提示信息
--**********************************
function x893340_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
