--兽魂系统

x800128_g_ScriptId = 800128

x800128_g_PetSoul_LevelUp_Material = 38002530
--返魂丹
x800128_g_LevelDownItem = 38002531
--凝魂所需的道具数量
x800128_g_PetSoul_Fusion_QNumber = {
	[0] = 20,
	[1] = 30,
	[2] = 40,
	[3] = 40,
}
--化玉的相关信息
x800128_g_PetSoul_Smash_CostList ={
	[0] = {piecesNumber = 20,moneyCost =100000},
	[1] = {piecesNumber = 30,moneyCost =300000},
	[2] = {piecesNumber = 40,moneyCost =1000000},
	[3] = {piecesNumber = 0,moneyCost =1000000},
}
--魂玉转化信息
x800128_g_PetSoul_ZhuanHua_Qual_Dest={
	-- 灵兽
	[0] = {
		[1] =38002525,
		[2] =38002526,
		[3] =38002527,
		[4] =38002528,
		[5] =38002529,
	},
	-- 荒兽
	[1] = {
		[1] =38002520,
		[2] =38002521,
		[3] =38002522,
		[4] =38002523,
		[5] =38002524,
	},
	-- 神兽
	[2] = {
		[1] =38002515,
		[2] =38002516,
		[3] =38002517,
		[4] =38002518,
		[5] =38002519,
	},
}

x800128_g_PetSoul_ZhuanHua_CommonPiece ={
	38002741,
	38002742,
}
--**********************************
--魂玉转化
--**********************************
function x800128_OnPetSoulPieceZhuanHua(sceneId,selfId,targetId,bagPos,bagPos2,nSelId)
	if sceneId ~= SCENE_SUZHOU then
		x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_207}")
		return
	end
	local nItem1Bind = 0
	local nItem2Bind= 0
	local nItem1Index = 0
	local nItem2Index = 0
	local nPs1Index = 0
	local nPs1Qual = 0;
	local nPs2Index = 0
	local nPs2Qual = 0;
	local nItemCount = 0
	
	if(bagPos ~= -1)then
		if LuaFnGetItemBindStatus( sceneId, selfId, bagPos ) then
			nItem1Bind = 1
		end
		nItem1Index = LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagPos);
		nPs1Index, nPs1Qual = LuaFnGetPetSoulPieceInfo( nItem1Index );
		if nPs1Qual == nil then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_283}")
			return
		end
		nItemCount	= LuaFnGetItemCountInBagPos(sceneId,selfId,bagPos);

		if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
			return
		end
		if PetSoul_ZhuanHua_IsCommonPiece(nItem1Index) > 0 then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_221104_14}")
			return
		end
		--超神兽魂不能被转化
		if(nPs1Qual == 3)then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_221104_1}")
			return
		end
	end

	if(bagPos2 ~= -1)then
		if LuaFnGetItemBindStatus( sceneId, selfId, bagPos2 ) then
			nItem2Bind = 1
		end
		nItem2Index = LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagPos2);
		nPs2Index, nPs2Qual = LuaFnGetPetSoulPieceInfo( nItem2Index );
		if nPs2Qual == nil then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_283}")
			return
		end
		nItemCount	= nItemCount + LuaFnGetItemCountInBagPos(sceneId,selfId,bagPos2);
		
		if LuaFnIsItemAvailable(sceneId, selfId, bagPos2) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos2) ~= 0 then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
			return
		end
		if PetSoul_ZhuanHua_IsCommonPiece(nItem2Index) > 0 then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_221104_14}")
			return
		end
		--超神兽魂不能被转化
		if(nPs2Qual == 3)then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_221104_1}")
			return
		end
	end
	if nItemCount < 2 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_274}")
		return
	end
	-- 是否同品质
	if bagPos2 > -1 and nPs1Qual ~= nPs2Qual then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_283}")
		return
	end
	--获取转化后的ID
	local nFinalItemID = x800128_g_PetSoul_ZhuanHua_Qual_Dest[nPs1Qual][nSelId]
	if nFinalItemID == nil then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_284}")
		return
	end
	--检测背包空间
	BeginAddItem(sceneId)
	if nItem1Bind == 1 or nItem2Bind == 1 then
		AddBindItem( sceneId,nFinalItemID,floor(nItemCount / 2))	
	else
		AddItem( sceneId,nFinalItemID,floor(nItemCount / 2))	
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--扣除
	LuaFnMtl_CostMaterial(sceneId,selfId,floor(nItemCount / 2) * 2 ,nItem1Index,nItem2Index)
	--给魂玉
	AddItemListToHuman(sceneId,selfId)

	x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_275}")
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

--**********************************
--兽魂化玉
--**********************************
function x800128_OnPetSoulSmash(sceneId,selfId,targetId,bagPos,nLevelConfirm,nQualConfirm)
	if sceneId ~= SCENE_SUZHOU then
		x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_207}")
		return
	end
	if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
		x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end
	--判断是不是魂兽
	local nLevel=LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "LEVEL")
	local nQual=LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "QUAL")
	local nPetSoulIndex = LuaFnGetItemTableIndexByIndex(sceneId,selfId,bagPos);
	if nLevel == nil or nQual == nil or nPetSoulIndex == nil or x800128_g_PetSoul_Smash_CostList[nQual] == nil then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_136}")
		return
	end
	if nQual == 3 and nQualConfirm ~= 1 then
		--远古神兽魂品质
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, bagPos )
			UICommand_AddInt( sceneId, nLevelConfirm )
			UICommand_AddInt( sceneId, nQualConfirm )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012716 )
		return
	end
	
	if nQual == 2 and nQualConfirm ~= 1 then
		--您确定化玉神兽魂品质的兽魂吗
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, bagPos )
			UICommand_AddInt( sceneId, nLevelConfirm )
			UICommand_AddInt( sceneId, nQualConfirm )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012726 )
		return
	end
	--Money
	local nNeedMoney = x800128_g_PetSoul_Smash_CostList[nQual].moneyCost
	--判定金钱是否足够
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < nNeedMoney then
        x800128_NotifyTip( sceneId, selfId, format("金币不足，本次操作需要消耗%d金交子！",nNeedMoney) )
        return
	end
	--计算可得到的魂玉数量
	--穷奇特写
	local piecesNumber = 0
	local piecesID = 0;
	if(nQual == 3)then
		piecesNumber,piecesID = LuaFnPetSoulSmashPiecesCount( sceneId,selfId,bagPos)
		local nPiecesNumberBig = floor( piecesNumber/100)	--珍品
		local nPiecesNumberSmall = floor( (piecesNumber - nPiecesNumberBig * 100)/10)	--凡品
		piecesNumber = nPiecesNumberBig + nPiecesNumberSmall		
	else
		_,piecesID = LuaFnPetSoulSmashPiecesCount( sceneId,selfId,bagPos)
		piecesNumber = LuaFnPetSoulSmashPiecesCount( sceneId,selfId,bagPos) / 20 + x800128_g_PetSoul_Smash_CostList[nQual].piecesNumber 
		piecesNumber = floor(piecesNumber);
	end
	if piecesNumber <= 0 and piecesID <= 0 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_136}")
		return
	end
	--检测背包空间
	BeginAddItem(sceneId)
	if LuaFnGetItemBindStatus( sceneId, selfId, bagPos ) then
		AddBindItem( sceneId,piecesID,piecesNumber)	
	else
		AddItem( sceneId,piecesID,piecesNumber)	
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--扣除金币及材料
	LuaFnCostMoneyWithPriority(sceneId, selfId, nNeedMoney)
	EraseItem( sceneId, selfId, bagPos )
	--给魂玉
	AddItemListToHuman(sceneId,selfId)

	x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_140}")
	x800128_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SHXT_20211230_141}",piecesNumber,GetItemName(sceneId,piecesID)))
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

--**********************************
--兽魂凝魂
--**********************************
function x800128_OnPetSoulFusion(sceneId,selfId,targetId,bagPos,bagPos2,bBind)
	if sceneId ~= SCENE_SUZHOU then
		x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_207}")
		return
	end
	local nItem1Bind = 0
	local nItem2Bind= 0;
	local nItemIndex = 0;
	local nPsIndex = 0
	local nPsQual =0;

	if(bagPos ~= -1)then
		if LuaFnGetItemBindStatus( sceneId, selfId, bagPos ) then
			nItem1Bind = 1
		end
		nItemIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagPos);
		nPsIndex, nPsQual = LuaFnGetPetSoulPieceInfo( nItemIndex );
		if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
			return
		end
	end

	if(bagPos2 ~= -1)then
		if LuaFnGetItemBindStatus( sceneId, selfId, bagPos2 ) then
			nItem2Bind = 1
		end
		nItemIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagPos2);
		nPsIndex, nPsQual = LuaFnGetPetSoulPieceInfo( nItemIndex );
		if LuaFnIsItemAvailable(sceneId, selfId, bagPos2) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos2) ~= 0 then
			x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
			return
		end
	end
	
	--判断当前魂玉是否是同一兽魂的碎片
	if bagPos ~= -1 and bagPos2 ~= -1 then
		if LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagPos) ~= LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagPos2) then
			x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_167}")
			return
		end
	end
	

	local nBind = 0;
	if(nItem1Bind == 1) or (nItem2Bind == 1)then
		nBind = 1;
	end
	if bBind ~= 1 and nBind ~= 1 then
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012714 )
		return
	end
	
	--判定数量是不是够的
	if LuaFnGetAvailableItemCount(sceneId, selfId, nItemIndex) < x800128_g_PetSoul_Fusion_QNumber[nPsQual] then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_113}")
		return
	end
	
	--背包空间检测
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 1 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_114}")
		return
	end
	
	--扣除材料
	LuaFnDelAvailableItem(sceneId,selfId,nItemIndex,x800128_g_PetSoul_Fusion_QNumber[nPsQual])
	
	local nNewPos = LuaFnTryRecieveSingleItem(sceneId,selfId,nPsIndex,1,nBind)
	if nNewPos ~= -1 then
		LuaFnRefreshItemInfo( sceneId, selfId, nNewPos )
	end
	
	x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_116}")
	x800128_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SHXT_20211230_117}",GetItemName(sceneId,nPsIndex)))
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

--**********************************
--兽魂返魂
--**********************************
function x800128_OnPetSoulLevelDown(sceneId,selfId,targetId,bagPos)
	if sceneId ~= SCENE_SUZHOU then
		x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_206}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_207}")
		return
	end
	
	if LuaFnIsItemAvailable(sceneId, selfId, bagPos) < 1  or LuaFnIsItemLocked(sceneId, selfId, bagPos) ~= 0 then
		x800128_NotifyTip( sceneId, selfId, "#{SHXT_20211230_65}" )
		return
	end
	--检查是否为兽魂
	local nLevel=LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "LEVEL")
	local nBloodRank =LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "BR")
	local nBloodConcentrate =LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "BC")
	local nMaxBloodConcentrate =LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "MAXBC")
	if nLevel == nil or nBloodRank == nil or nBloodConcentrate == nil or nMaxBloodConcentrate == nil then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_79}")
		return
	end
	
	--检查兽魂等级是否大于1
	if(nLevel <= 1)then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_125}")
		return
	end
	
	local nQual=LuaFnGetPetSoulDataInBag( sceneId,selfId,bagPos, "QUAL")
	if nQual == 3 then
		nQual = 2
	end
	local nGiveItemCount,nItemCount,nMoneyCount = LuaFnGetPetSoulLeveldownCost(nLevel,nQual)
	
	if LuaFnGetAvailableItemCount(sceneId, selfId, x800128_g_LevelDownItem) < nItemCount then
		x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_126}")
		return
	end
	
	--判定金钱是否足够
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < nMoneyCount then
        x800128_NotifyTip( sceneId, selfId, format("金币不足，本次操作需要消耗%d金交子！",nMoneyCount) )
        return
	end
	
	--检测背包空间
	BeginAddItem(sceneId)
	AddItem( sceneId,x800128_g_PetSoul_LevelUp_Material,nGiveItemCount)	
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	
	--扣除金币及材料
	LuaFnCostMoneyWithPriority(sceneId, selfId, nMoneyCount)
	LuaFnDelAvailableItem(sceneId,selfId,x800128_g_LevelDownItem,nItemCount)
	
	--给升魂丹
	AddItemListToHuman(sceneId,selfId)
	
	--等级重置
	LuaFnResetPetSoulLevel(sceneId,selfId,bagPos);
	
	x800128_NotifyTip( sceneId, selfId,"#{SHXT_20211230_129}")
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

function PetSoul_ZhuanHua_IsCommonPiece(nItemTableIndex)
	local nCount=getn(x800128_g_PetSoul_ZhuanHua_CommonPiece)
	for i=1,nCount do
		if nItemTableIndex == x800128_g_PetSoul_ZhuanHua_CommonPiece[i] then
			return 1
		end
	end
	return 0
end
--**********************************
--醒目提示
--**********************************
function x800128_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
