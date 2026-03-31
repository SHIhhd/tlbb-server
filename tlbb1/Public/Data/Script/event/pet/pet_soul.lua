--兽魂系统

x800127_g_ScriptId = 800127
x800127_g_OpMinLevel = 85
x800127_g_PetSoul_LevelUp_MaxPetSoulLevel=100
x800127_g_PetSoul_LevelUp_Material = {38002530,38002677}

x800127_g_NeedItem = {
	[0] = 38002534,	--淬魂水
	[1] = 38002533,	--淬魂液
	[2] = 38002532,	--淬魂髓
}
x800127_g_NeedRMBItem = {
	[1] = 38002541,	
	[2] = 38002540,	
}
x800127_g_WashTimeMD = {
	[0] = MDEX_XILIAN_SHEN,
	[1] = MDEX_XILIAN_HUANG,	--
	[2] = MDEX_XILIAN_LING,
}
x800127_g_WashCost = 50000
x800127_g_MAX = 100
x800127_g_WashTimeErrTips = {
	[0] = "#{SHCX_20211229_44}",
	[1] = "#{SHCX_20211229_45}",	--
	[2] = "#{SHCX_20211229_46}",
}
--锁定判定
x800127_g_ShenShouData = {
	[1] = {total = 200,   locknum = 1, needitemcount = 2,},
	[2] = {total = 500,   locknum = 2, needitemcount = 2,},
	[3] = {total = 1000,  locknum = 3, needitemcount = 3,},
	[4] = {total = 2000,  locknum = 4, needitemcount = 3,},
	[5] = {total = 5000,  locknum = 5, needitemcount = 4,},
	[6] = {total = 10000, locknum = 6, needitemcount = 5,},
}
--
x800127_g_YiShouData = {
	[1] = {total = 100,   locknum = 1, needitemcount = 2,},
	[2] = {total = 200,   locknum = 2, needitemcount = 2,},
	[3] = {total = 500,   locknum = 3, needitemcount = 3,},
	[4] = {total = 1000,  locknum = 4, needitemcount = 3,},
	[5] = {total = 2000,  locknum = 5, needitemcount = 4,},
}
x800127_g_BaodiItem = {
	[1] = {itemId = 38002633, nType = 2, baodi = 3,},--神兽锁灵符佳
	[2] = {itemId = 38002634, nType = 2, baodi = 4,},--神兽锁灵符珍
	[3] = {itemId = 38002635, nType = 2, baodi = 5,},--神兽锁灵符绝
	[4] = {itemId = 38002636, nType = 1, baodi = 3,},--荒兽锁灵符佳
	[5] = {itemId = 38002637, nType = 1, baodi = 4,},--荒兽锁灵符珍
	[6] = {itemId = 38002638, nType = 1, baodi = 5,},--荒兽锁灵符绝
}
--返魂丹
x800127_g_LevelDownItem = 38002531
--通用魂玉
x800127_g_PetSoul_BloodLevelUp_CommonPiece = {
	[38002741] = 10,
	[38002742] = 100,
}
--**********************************
--兽魂育魂
--**********************************
function x800127_OnPetSoulBloodLevelUp(sceneId,selfId,targetId,bagPos,itemBagPos,bWaste,bBind)
	if sceneId ~= SCENE_SUZHOU then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_207}")
		return
	end
	if GetLevel(sceneId,selfId) < x800127_g_OpMinLevel then
		x800127_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_27}" )
		return
	end
	if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end
	if LuaFnIsItemAvailable(sceneId, selfId, itemBagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, itemBagPos) ~= 0 then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end
	
	local nPetSoulIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, bagPos )
	local nPetSoulItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemBagPos )
	local nItemCount = LuaFnGetItemCountInBagPos(sceneId,selfId,itemBagPos);
	if nPetSoulItemID == nil or nItemCount == nil or nItemCount<=0 then
		x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_82}")
		return
	end
	--检查是否为兽魂
	local nLevel=LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "LEVEL")
	local nBloodRank =LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "BR")
	local nBloodConcentrate =LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "BC")
	local nMaxBloodConcentrate =LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "MAXBC")
	if nLevel == nil or nBloodRank == nil or nBloodConcentrate == nil or nMaxBloodConcentrate == nil then
		x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_79}")
		return
	end
					
	--检查兽魂魂境等级是否满级
	if nBloodRank >= 5 then
		if bItemChanged == 0 then
			x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_80}" )
		end
		return
	end
	
	--当前拥有的魂意值是否大于该兽魂当前等级升级所需魂意值
	if nBloodConcentrate >= nMaxBloodConcentrate then
		x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_81}" )
		return
	end
	
	local nPsIndex, nPsQual = LuaFnGetPetSoulPieceInfo( nPetSoulItemID );
	if (nPsIndex == nil or nPsQual == nil) and  x800127_g_PetSoul_BloodLevelUp_CommonPiece[nPetSoulItemID] == nil then
		x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_82}")
		return
	end
	
	--检查兽魂和魂玉是否同品质
	
	local nPetSoulQual = LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos,  "QUAL")
	if x800127_g_PetSoul_BloodLevelUp_CommonPiece[nPetSoulItemID] == nil then
		if(nPetSoulQual == 3 and nPsQual ~= 2)then
			x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_84}" )
			return
		elseif(nPetSoulQual < 3 and nPsQual ~= nPetSoulQual)then
			x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_84}" )
			return
		end
	end
	--计算到顶级时需要的魂意值
	local nMaxNeedCon = LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "MAXNEED")
	if nMaxNeedCon == nil or nMaxNeedCon < 0 then
		return
	end
	
	local nAddConPerPiece = 10;
	if(nPsQual ~= nil)then --这里分成两种道具 放入的是通常的魂玉还是通用魂玉（通用魂玉实际是个普通道具不在兽魂表里所以查不到魂玉信息）
		if(nPetSoulQual == 3 and nPsQual == 2)then
			nAddConPerPiece = 10;
			nAddConValue = 10 * nItemCount;
		elseif(nPetSoulQual == nPsQual)then
			if nPsIndex == nPetSoulIndex then
				nAddConPerPiece = 20;
				nAddConValue = 20 * nItemCount;
			else
				nAddConPerPiece = 10;
				nAddConValue = 10 * nItemCount;
			end	
		end
	elseif(x800127_g_PetSoul_BloodLevelUp_CommonPiece[nPetSoulItemID] ~= nil)then
		nAddConPerPiece = x800127_g_PetSoul_BloodLevelUp_CommonPiece[nPetSoulItemID] 
		nAddConValue = x800127_g_PetSoul_BloodLevelUp_CommonPiece[nPetSoulItemID]  * nItemCount
	end
			
	--x800127_NotifyTip( sceneId, selfId,"nAddConValue "..nAddConValue.."  "..nMaxNeedCon )
	local ishave = 0
	if nAddConValue > nMaxNeedCon then
	    nItemCount = nItemCount - floor((nAddConValue - nMaxNeedCon) / nAddConPerPiece)
		nAddConValue = nAddConValue - floor((nAddConValue - nMaxNeedCon) / nAddConPerPiece) * nAddConPerPiece;
		ishave = 1
		if bWaste ~= 1 then
			--给客户端一个额外的提示信息
			BeginUICommand( sceneId )
				UICommand_AddString( sceneId, 
				ScriptGlobal_Format("#{SHXT_20211230_219}",
				ScriptGlobal_Format("#{SHXT_20211230_220}",nItemCount,GetItemName(sceneId,nPetSoulItemID)),
				nMaxNeedCon) ) --淬魂髓
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 80012712 )
			return
		end
	end
 
	--材料绑定则物品绑定
	if LuaFnGetItemBindStatus( sceneId, selfId, itemBagPos ) then
		if bBind == 1 then
			LuaFnItemBind( sceneId, selfId, bagPos )
		else
			--给客户端一个提示
			DispatchUICommand( sceneId, selfId, 80012722 )
			return
		end
	end
	--bBind
	
	--x800127_NotifyTip( sceneId, selfId,"nAddConValue "..nAddConValue )
	--销毁位置里的物品
		
	if ishave > 0 then 
	   -- x800127_NotifyTip( sceneId, selfId,"LuaFnDelAvailableItem nItemCount "..nItemCount )
		LuaFnDelAvailableItem(sceneId,selfId, nPetSoulItemID,nItemCount)
    else
	    EraseItem( sceneId, selfId, itemBagPos )
	end
 
	--增加魂意经验，升级等逻辑程序实现即可
	local nNewRank = LuaFnAddPetSoulBloodConcentrate(sceneId,selfId,bagPos,nAddConValue);
	--更新物品信息
	LuaFnRefreshItemInfo( sceneId, selfId, bagPos )
	x800127_NotifyTip(sceneId, selfId, "#{SHXT_20211230_88}");
	
	if nNewRank ~= nil and nNewRank > 0 and nBloodRank ~= nNewRank then
		x800127_NotifyTip(sceneId, selfId, ScriptGlobal_Format("#{SHXT_20211230_89}",tostring(nNewRank + 1)));
		--nNewRank 0-5
		if nNewRank >= 5 then
			BroadMsgByChatPipe( sceneId, selfId, ScriptGlobal_Format("#{SHXT_20211230_90}",
			GetName(sceneId,selfId),GetBagItemTransfer(sceneId,selfId,bagPos),tostring(nNewRank + 1)), 4 )
		end
	end
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	
	--任务标记完成
	CallScriptFunction(893049,"OnFinish",sceneId, selfId)
end
--**********************************
--兽魂洗练提交
--**********************************
function x800127_OnPetSoulXiShuXing(sceneId,selfId,bagPos,itemBagPos,baodiBagPos,nLockState,bConfrim)
	if sceneId ~= SCENE_SUZHOU then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if GetLevel(sceneId,selfId) < x800127_g_OpMinLevel then
		x800127_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_27}" )
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x800127_NotifyTip( sceneId, selfId, "#{SHCX_20211229_18}" )
			return
		end
	end
	if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end
	if LuaFnIsItemAvailable(sceneId, selfId, itemBagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, itemBagPos) ~= 0 then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end	
	
	local nPetSoulWashItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemBagPos )
	if nPetSoulWashItemID ~= x800127_g_NeedItem[0] and nPetSoulWashItemID ~= x800127_g_NeedItem[1] and nPetSoulWashItemID ~= x800127_g_NeedItem[2] and nPetSoulWashItemID ~= x800127_g_NeedRMBItem[1] and nPetSoulWashItemID ~= x800127_g_NeedRMBItem[2] then
		x800127_NotifyTip( sceneId, selfId, "#{SHCX_20211229_41}" )
		return
	end 
	--检测材料是否符合洗练条件
	local nPetSoulID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, bagPos )
	local iQual = LuaFnGetPetSoulDataInBag(sceneId,selfId, bagPos, "QUAL")
	if iQual == 3 then
		iQual = 2
	end
 	if (iQual > 0 and nPetSoulWashItemID ~= x800127_g_NeedItem[iQual] and nPetSoulWashItemID ~= x800127_g_NeedRMBItem[iQual] ) or 
 		(iQual == 0 and nPetSoulWashItemID ~= x800127_g_NeedItem[iQual]) then
 		x800127_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SHCX_20211229_42}", GetItemName(sceneId,nPetSoulID), GetItemName(sceneId,x800127_g_NeedItem[iQual])))
 		return
 	end
	--保底判定 x800127_g_BaodiItem
	local nBaoDiData = -1
	if baodiBagPos ~= -1 then
		local itemId = LuaFnGetItemTableIndexByIndex( sceneId, selfId, baodiBagPos )
		if itemId ~= x800127_g_BaodiItem[1].itemId and itemId ~= x800127_g_BaodiItem[2].itemId and itemId ~= x800127_g_BaodiItem[3].itemId 
			and itemId ~= x800127_g_BaodiItem[4].itemId and itemId ~= x800127_g_BaodiItem[5].itemId and itemId ~= x800127_g_BaodiItem[6].itemId then
			x800127_NotifyTip( sceneId, selfId,"#{SHCX_20211229_72}")
			return 
		end 
		local isFind = 0
		for i = 1, getn(x800127_g_BaodiItem) do
			if x800127_g_BaodiItem[i].itemId == itemId and x800127_g_BaodiItem[i].nType == iQual then
				isFind = 1
				nBaoDiData = x800127_g_BaodiItem[i].baodi
				break
			end
		end
		if isFind ~= 1 then
			x800127_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SHCX_20211229_73}", GetItemName(sceneId,nPetSoulID)))
			return 
		end
	end
	--判定金钱是否足够
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < x800127_g_WashCost then
        x800127_NotifyTip( sceneId, selfId, "#{SHCX_20211229_21}" )
        return
	end
	--首先判定是否不扣除洗脸次数
	local nSubTodayWashTime = 1;
	if x800127_g_NeedRMBItem[iQual] ~= nil and nPetSoulWashItemID == x800127_g_NeedRMBItem[iQual] then
		nSubTodayWashTime = 0
	end
	if nSubTodayWashTime == 1 then
		local nTodayWashTime = GetMissionDataEx(sceneId,selfId,x800127_g_WashTimeMD[iQual]);
		if nTodayWashTime >= x800127_g_MAX then
			x800127_NotifyTip( sceneId, selfId, x800127_g_WashTimeErrTips[iQual] )
			return
		end
	end
	--================================================================================
	local nLockNum = 0;
	local tLockState = {0,0,0,0,0,0}
	local g_Total = {0,0,0}
	g_Total[1] = GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSHUI)	--淬魂水使用数量
	g_Total[2] = GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNYE)		--淬魂液使用数量
	g_Total[3] = GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSUI)	--粹魂髓使用数量
	--x800127_NotifyTip( sceneId, selfId,format("洗练情况:淬魂水次数：%d,淬魂液次数：%d,粹魂髓次数：%d",g_Total[1],g_Total[2],g_Total[3]))
	if iQual >= 1 and iQual <= 2 then
		--计算可锁定性
		local g_AvailableLockNum = {0,0}
	
		for i = 1, getn(x800127_g_YiShouData) do
			if x800127_g_YiShouData[i].total <= g_Total[2] then
				g_AvailableLockNum[1] = x800127_g_YiShouData[i].locknum
			end
		end

		for i = 1, getn(x800127_g_ShenShouData) do
			if x800127_g_ShenShouData[i].total <= g_Total[3] then
				g_AvailableLockNum[2] = x800127_g_ShenShouData[i].locknum
			end
		end
		--计算可锁定性
		--获取当前预锁定的数量
		for i = 1,6 do
			tLockState[i] = mod(floor(nLockState/10 ^ (i - 1)),10)
			if tLockState[i] >= 1 then
				nLockNum = nLockNum + 1
			end
		end
		if nLockNum > g_AvailableLockNum[iQual] then
			x800127_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SHCX_20211229_38}", g_AvailableLockNum[iQual]))
			return
		end
	--	x800127_NotifyTip( sceneId, selfId, "nLockState "..nLockState )
	else
		--这种情况不可存在
		if nLockState > 0 then
			return
		end
	end
	--材料绑定则物品绑定
	if LuaFnGetItemBindStatus( sceneId, selfId, itemBagPos ) == 1
		and LuaFnGetItemBindStatus( sceneId, selfId, bagPos ) ~= 1 then
		if bConfrim == 1 then
			LuaFnItemBind( sceneId, selfId, bagPos )
		else
			--给客户端一个提示
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, bagPos )
				UICommand_AddInt( sceneId, itemBagPos )
				UICommand_AddInt( sceneId, baodiBagPos )
				UICommand_AddInt( sceneId, nLockState )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 80012709 )
			return
		end
	end
	--计算材料所需数量
	local nNeedItemNum = x800127_CalcNeedItemNum(iQual,nLockNum);
	if LuaFnGetAvailableItemCount(sceneId, selfId, nPetSoulWashItemID) < nNeedItemNum then
		x800127_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SHCX_20211229_47}", GetItemName(sceneId,nPetSoulWashItemID)))
		return
	end
	--调用程序进行洗练
	local nRet = LuaFnUpdatePetSoulExValue(sceneId,selfId,bagPos,
					tLockState[6],tLockState[5],tLockState[4],tLockState[3],tLockState[2],tLockState[1],
					nBaoDiData)
					--g_Total[1],g_Total[2],g_Total[3])
	if nRet == 0 then
		return
	end
	--扣除金币及材料
	LuaFnCostMoneyWithPriority(sceneId, selfId, x800127_g_WashCost)
	LuaFnDelAvailableItem(sceneId,selfId,nPetSoulWashItemID,nNeedItemNum)
	--保底材料扣除
	if baodiBagPos ~= -1 then
		local itemId = LuaFnGetItemTableIndexByIndex( sceneId, selfId, baodiBagPos )
		LuaFnDelAvailableItem(sceneId,selfId,itemId,1)
	end
	--增加洗练次数
	if nSubTodayWashTime == 1 then
		local nTodayWashTime = GetMissionDataEx(sceneId,selfId,x800127_g_WashTimeMD[iQual]);
		SetMissionDataEx(sceneId,selfId,x800127_g_WashTimeMD[iQual],nTodayWashTime + 1);
	end
	--增加粹魂髓及淬魂液的消耗
	if iQual >= 0 and iQual <= 2 then
		if iQual == 0 then
			SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSHUI,GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSHUI) + 1)
		end
		if iQual == 1 then
			SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNYE,GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNYE) + 1)
		end
		if iQual == 2 then
			SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSUI,GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSUI) + 1)
		end
	end
	--通知客户端
	x800127_NotifyTip( sceneId, selfId, "#{SHCX_20211229_22}")
	--更新客户端
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 2 )--1 Open 2 Update
		--UICommand_AddInt( sceneId, targetId )
		--已洗练次数
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_XILIAN_SHEN) ) --神
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_XILIAN_HUANG) ) --荒
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_XILIAN_LING) ) --灵
		--淬魂液 淬魂髓消耗
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNYE) ) --淬魂液
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSUI) ) --淬魂髓
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 80012708 )
	
	--任务标记完成
	CallScriptFunction(893050,"OnFinish",sceneId, selfId)
end
--**********************************
--计算消耗数量
--**********************************
function x800127_CalcNeedItemNum(iQual,nLock)
	if iQual == 0 then
		return 1
	elseif iQual == 1 then
		for i = 1, getn(x800127_g_YiShouData) do
			if x800127_g_YiShouData[i].locknum == nLock then
				return x800127_g_YiShouData[i].needitemcount
			end
		end
	elseif iQual == 2 or iQual == 3 then
		for i = 1, getn(x800127_g_ShenShouData) do
			if x800127_g_ShenShouData[i].locknum == nLock then
				return x800127_g_ShenShouData[i].needitemcount
			end
		end
	end

	return 1
end
--**********************************
--兽魂升级
--**********************************
function x800127_OnPetSoulLevelUp(sceneId,selfId,targetId,bagPos,bBind)
	if sceneId ~= SCENE_SUZHOU then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x800127_NotifyTip( sceneId, selfId,"#{SHXT_20211230_207}")
		return
	end
	if GetLevel(sceneId,selfId) < x800127_g_OpMinLevel then
		x800127_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_27}" )
		return
	end
	
	if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end
	
	local nLevel=LuaFnGetPetSoulDataInBag(sceneId,selfId, bagPos, "LEVEL")
	local nQual=LuaFnGetPetSoulDataInBag(sceneId,selfId, bagPos, "QUAL")
	local nPetSoulIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, bagPos )
	
	if nLevel == nil or nQual == nil or nPetSoulIndex == nil then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_64}" )
		return
	end
	--检查是否满级
	if nLevel >= x800127_g_PetSoul_LevelUp_MaxPetSoulLevel then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_66}" )
		return
	end	
	--得到升级消耗及提升资质信息
	if nQual == 3 then
		nQual = 2
	end
	local nCostItemCount, nCostMoney = LuaFnGetPetSoulLevelupCost( nLevel, nQual )
	if nCostItemCount == nil or nCostMoney == nil then
		x800127_NotifyTip( sceneId, selfId, "#{SHXT_20211230_64}" )
		return
	end
	
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < nCostMoney then
        x800127_NotifyTip( sceneId, selfId, format("金币不足，本次升级需要消耗#{_MONEY%d}！ ",nCostMoney) )
        return
	end
	
	--检查材料
	if LuaFnMtl_GetCostNum(sceneId,selfId,x800127_g_PetSoul_LevelUp_Material[1],x800127_g_PetSoul_LevelUp_Material[2]) < nCostItemCount then
		x800127_NotifyTip(sceneId, selfId, "#{SHXT_20211230_69}");
		return
	end
	
	
	local ret = LuaFnMtl_CostMaterial(sceneId,selfId,nCostItemCount,x800127_g_PetSoul_LevelUp_Material[1],x800127_g_PetSoul_LevelUp_Material[2])
	if ret ~= 1 then
	   x800127_NotifyTip(sceneId, selfId, "扣除失败，无法进行升级。")
	   return
	end
	
	
	--扣除金币及材料
	LuaFnCostMoneyWithPriority(sceneId, selfId, nCostMoney)
	--LuaFnDelAvailableItem(sceneId,selfId,x800127_g_PetSoul_LevelUp_Material,nCostItemCount)
	--执行升魂操作[升级一级]
	LuaFnPetSoulLevelUp(sceneId,selfId,bagPos)

	x800127_NotifyTip(sceneId, selfId, "#{SHXT_20211230_71}");
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	
	--任务标记完成
	CallScriptFunction(893048,"OnFinish",sceneId, selfId)
end

--**********************************
--醒目提示
--**********************************
function x800127_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
