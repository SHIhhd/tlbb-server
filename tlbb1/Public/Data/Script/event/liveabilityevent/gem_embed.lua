-- 宝石镶嵌

-- 脚本号
x701614_g_scriptId = 701614

-- 硬性设定的装备最大可镶嵌宝石数
x701614_g_MaxEquipGemCount = 3

-- 装备允许镶嵌的宝石类型表
x701614_g_EquipGemTable = {}
x701614_g_EquipGemTable[HEQUIP_WEAPON] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[HEQUIP_CAP] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[HEQUIP_ARMOR] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[HEQUIP_CUFF] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[HEQUIP_BOOT] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[HEQUIP_SASH] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[HEQUIP_RING] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[HEQUIP_NECKLACE] = { 1, 2, 3, 4, 11, 12, 13, 14, 21 }
x701614_g_EquipGemTable[HEQUIP_RING_2] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[HEQUIP_CHARM] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[HEQUIP_CHARM_2] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[HEQUIP_WRIST] = {1, 2, 3, 4, 21  }
x701614_g_EquipGemTable[HEQUIP_SHOULDER] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[HEQUIP_DARK] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 }
x701614_g_EquipGemTable[HEQUIP_KFS] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 }
x701614_g_EquipGemTable[HEQUIPEX_SHENBING] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 26 }

-- 镶嵌不同等级宝石的金钱消耗表
x701614_g_EquipGemCost = {}
x701614_g_EquipGemCost[1] = 5000
x701614_g_EquipGemCost[2] = 6000
x701614_g_EquipGemCost[3] = 7000
x701614_g_EquipGemCost[4] = 8000
x701614_g_EquipGemCost[5] = 9000
x701614_g_EquipGemCost[6] = 10000
x701614_g_EquipGemCost[7] = 11000
x701614_g_EquipGemCost[8] = 12000
x701614_g_EquipGemCost[9] = 13000

-- 宝石镶嵌符表
x701614_g_AssisMat = { { idx = 30900009, odds = 50 }, { idx = 30900010, odds = 100 } }

-- 宝石强化符
x701614_g_FastenMat = 30900011

x701614_GemEmbed_four_ID = {
														50113004,50213004,50313004,50413004,50513004,50613004,50713004,50813004,50913004,50113006,
														50213006,50313006,50413006,50513006,50613006,50713006,50813006,50913006
													}		
--宝石转移配置													
x701614_g_EquipGemTable[0] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[1] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[2] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[3] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[4] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[5] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[6] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[7] = { 1, 2, 3, 4, 11, 12, 13, 14, 21 }
x701614_g_EquipGemTable[11] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[12] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[13] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[14] = { 1, 2, 3, 4, 21 }
x701614_g_EquipGemTable[15] = { 11, 12, 13, 14 }
x701614_g_EquipGemTable[17] = { 1, 2, 3, 4, 11, 12, 13, 14, 21 }
x701614_g_EquipGemTable[18] = { 1, 2, 3, 4, 11, 12, 13, 14, 21 }
x701614_g_EquipGemTable[HEQUIPEX_SHENBING] = { 1, 2, 3, 4, 11, 12, 13, 14, 21 }
--**********************************************************************
-- 任务入口函数
--**********************************************************************
function x701614_OnDefaultEvent( sceneId, selfId, targetId )
end

--**********************************************************************
-- 列举事件
--**********************************************************************
function x701614_OnEnumerate( sceneId, selfId, targetId )
end

--**********************************************************************
-- 判断是否宝石
--**********************************************************************
function x701614_IsGem( itemIndex )
	if floor( itemIndex / 10000000 ) == 5 then
		return 1
	end

	return 0
end

--**********************************************************************
-- 进行宝石镶嵌
-- 直接客户端CALL
--**********************************************************************
function x701614_EnchaseEx_3( sceneId, selfId, GemBagIndex, EquipBagIndex, MatBagIndex1, MatBagIndex2,nHole )
	local gemIdx, equipIdx, matIdx1, matIdx2 = -1, -1, -1, -1
	local odds = 25														-- 成功率
	local szTransferItem = ""
	local	GemIsBind = 0;
	local EquipIsBind = 0;
	local CharmIsBind = 0;
	local OddsIsBind = 0;

	
	--!!
	if(LuaFnGetItemBindStatus( sceneId, selfId, GemBagIndex ) == 1) then
		GemIsBind = 1;
	end
	
	local itemTableIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, EquipBagIndex )
	-- 褚少微，2008.7.1。重楼戒、重楼玉的机制修改：1、可以打孔；2、可以镶嵌宝石，但只能镶嵌不绑定的宝石
	-- 修改这项规则，可以打全部宝石
--	if(GemIsBind == 1) then
--	  	if(itemTableIndex == 10422016 or itemTableIndex == 10423024) then
--			LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
--	  		return 
--	  	end
--	end
	
	if(LuaFnGetItemBindStatus( sceneId, selfId, EquipBagIndex ) == 1) then
		EquipIsBind = 1;
	end
  
  if MatBagIndex1 ~= -1 then
     if(LuaFnGetItemBindStatus( sceneId, selfId, MatBagIndex1 ) == 1) then
		    CharmIsBind = 1;
	   end
	end
	
	if MatBagIndex2 ~= -1 then
	   if(LuaFnGetItemBindStatus( sceneId, selfId, MatBagIndex2 ) == 1) then
		    OddsIsBind = 1;
		 end
	end
	
	
	-- 判断宝石合法性
	if LuaFnIsItemAvailable( sceneId, selfId, GemBagIndex ) < 1 then	-- 使用有问题的物品则退出流程
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
		return
	else
		gemIdx = LuaFnGetItemTableIndexByIndex( sceneId, selfId, GemBagIndex )
		szTransferItem = GetBagItemTransfer(sceneId,selfId,GemBagIndex)
		if x701614_IsGem( gemIdx ) == 0 then
			LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
			return
		end
	end

	-- 判断装备合法性
	local equipType = LuaFnGetBagEquipType( sceneId, selfId, EquipBagIndex )
	if LuaFnIsItemLocked( sceneId, selfId, EquipBagIndex ) ~= 0
	or equipType == -1 then												-- 使用有问题的物品则退出流程
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
	else
		equipIdx = LuaFnGetItemTableIndexByIndex( sceneId, selfId, EquipBagIndex )
	end
	
	-- 判断是否还可以镶嵌更多宝石
	local equipMaxGemCount = GetBagGemCount( sceneId, selfId, EquipBagIndex )
	local equipEmbededGemCount = GetGemEmbededCount( sceneId, selfId, EquipBagIndex )
	if equipEmbededGemCount >= 3 and nHole == 3 then
		--这种属于第四孔镶嵌
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_EMBED_LACK)
		return
	end
	-- 判断当前位置是否有宝石了
	if nHole < 0 or nHole > 3 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_EMBED_LACK)
		return
	end
	local gemEmbededIdx = GetGemEmbededType( sceneId, selfId, EquipBagIndex, nHole )
	if gemEmbededIdx > 0 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_EMBED_LACK)
		return
	end
	
	-- 判断和装备上的现有宝石是否有冲突
	local gemType = LuaFnGetItemType( gemIdx )
	for i = 0, equipMaxGemCount - 1 do
		gemEmbededIdx = GetGemEmbededType( sceneId, selfId, EquipBagIndex, i )
		if gemEmbededIdx ~= -1 then
			-- 对比两颗宝石的类型（宝石大类）
			if gemType == LuaFnGetItemType( gemEmbededIdx ) then
				LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_CONFLICT)
				return
			end
		end
	end

	-- 判断宝石和装备的匹配性
	if not x701614_g_EquipGemTable[equipType] then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NOT_FIT_EQUIP)
		return 
	end

	local passFlag = 0
	for i, gt in x701614_g_EquipGemTable[equipType] do
		if gt == gemType then
			passFlag = 1
			break
		end
	end

	if passFlag == 0 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NOT_FIT_EQUIP)
		return
	end

	-- 判断辅助材料的有效性
	if MatBagIndex1 == -1 or LuaFnIsItemAvailable( sceneId, selfId, MatBagIndex1 ) < 1 then
		MatBagIndex1 = -1
	else
		local findFlag = 0
		matIdx1 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, MatBagIndex1 )
		for i, matInfo in x701614_g_AssisMat do
			if matInfo.idx == matIdx1 then
				findFlag = 1
				odds = matInfo.odds
				break
			end
		end

		if findFlag == 0 then													-- 这个东西不是镶嵌符
			MatBagIndex1 = -1
			matIdx1 = -1
		end
	end
	
	-- 必须镶嵌符
	if MatBagIndex1 == -1 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NEED_STUFF)
		return
	end

	if MatBagIndex2 == -1 or LuaFnIsItemAvailable( sceneId, selfId, MatBagIndex2 ) < 1 then
		MatBagIndex2 = -1
	else
		matIdx2 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, MatBagIndex2 )

		if matIdx2 ~= x701614_g_FastenMat then											-- 这个东西不是强化符
			MatBagIndex2 = -1
			matIdx2 = -1
		end
	end

	-- 判断金钱数量
	local gemQual = GetItemQuality( gemIdx )
	local cost = x701614_g_EquipGemCost[gemQual]
	if not cost then
		cost = 0
	end

	-- 第一个孔原价，镶嵌第二个孔收费×2，镶嵌第三个孔收费×3
	cost = cost * ( equipEmbededGemCount + 1 )

	-- 按照规则进行消耗
	-- 不管成功失败都消耗金钱、特殊材料
	if GetMoney(sceneId, selfId) + GetMoneyJZ(sceneId, selfId) < cost then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_NOTENOUGH_MONEY)
		return
	end
	local ret1, ret2 = LuaFnCostMoneyWithPriority( sceneId, selfId, cost )
	if ret1 == -1 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_NOTENOUGH_MONEY)
		return
	end
	
	if MatBagIndex1 > -1 then
	    LuaFnDelAvailableItem(sceneId,selfId,matIdx1,1)
	end

	if MatBagIndex2 > -1 then
	    LuaFnDelAvailableItem(sceneId,selfId,matIdx2,1)	
	end

	-- 如果成功
	local randRet = LuaFnGemEmbedRandom();
	if odds >= randRet then
		local ret = GemEnchasing( sceneId, selfId, GemBagIndex, EquipBagIndex,nHole )
		if ret and ret == 1 then
		
			if(GemIsBind == 1 or CharmIsBind == 1 or OddsIsBind == 1) then
				LuaFnItemBind( sceneId, selfId, EquipBagIndex);
			end
		
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
			LuaFnSendAbilitySuccessMsg( sceneId, selfId, 3, -1, equipIdx )

			local name = GetName( sceneId, selfId )

			--公告精简，小于4级的宝石镶嵌不发公告消息
			if (gemQual >= 4) then
				local szTransferEquip = GetBagItemTransfer( sceneId, selfId, EquipBagIndex )
				local message = ScriptGlobal_Format("#{XTGG_171109_01}", name, szTransferEquip, szTransferItem);
				BroadMsgByChatPipe( sceneId, selfId, message, 4 )
			end

			--[重复提示]
--			x701614_MsgBox( sceneId, selfId, "#Y恭喜你，镶嵌成功！" )
			--Add Log
			LogInfo	= format( "[EMBED]: sceneId=%d, GUID=%0X, bSuc=%d, idOldGem=%d, idEqp=%d, idMat0=%d, idMat1=%d, idNewGem=%d",
				sceneId,
				LuaFnObjId2Guid( sceneId, selfId ),
				1,
				gemIdx,
				equipIdx,
				matIdx1,
				matIdx2,
				gemIdx )
			WriteDebugLog( sceneId, selfId, LogInfo )
		end
		-- 如果失败
	else
		-- 如果玩家有宝石强化符，镶嵌失败之后宝石将会降M=1级，为0就消失。
		local qualDec			= 1
		local	gemIdx_new	= -1

		-- 如果玩家没有宝石强化符，那么镶嵌失败之后宝石将会降N=2级，为0就消失。
		if MatBagIndex2 == -1 then
			qualDec = qualDec + 1
		end
		--扣除改为扣1个
		LuaFnDelAvailableItem(sceneId,selfId,gemIdx,1)

		if gemQual - qualDec > 0 then
			gemIdx_new = gemIdx - 100000 * qualDec
			local GemBagIndex = LuaFnTryRecieveItem( sceneId, selfId, gemIdx_new, QUALITY_MUST_BE_CHANGE )
			if(GemIsBind == 1 or CharmIsBind == 1 or OddsIsBind == 1) then
				LuaFnItemBind(sceneId, selfId, GemBagIndex)
			end
			x701614_MsgBox( sceneId, selfId, "#Y很遗憾，镶嵌失败，宝石降了"..qualDec.."级！" )
		else
			x701614_MsgBox( sceneId, selfId, "#Y很遗憾，镶嵌失败，宝石损坏！" )
		end
		--Add Log
		LogInfo	= format( "[EMBED]: sceneId=%d, GUID=%0X, bSuc=%d, idOldGem=%d, idEqp=%d, idMat0=%d, idMat1=%d, idNewGem=%d",
			sceneId,
			LuaFnObjId2Guid( sceneId, selfId ),
			0,
			gemIdx,
			equipIdx,
			matIdx1,
			matIdx2,
			gemIdx_new )
		WriteDebugLog( sceneId, selfId, LogInfo )
		
		if(GemIsBind == 1 or CharmIsBind == 1 or OddsIsBind == 1) then
			LuaFnItemBind( sceneId, selfId, EquipBagIndex);
		end

		return --OR_FAILURE
	end

	-- 按照成功率进行合成
	return --OR_OK
end

--**********************************
--信息提示
--**********************************
function x701614_MsgBox( sceneId, selfId, str )

	--醒目提示
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
	--频道提示
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )

end
		
--**********************************************************************
-- 进行第四个宝石镶嵌
-- 客户端直接CALL
--**********************************************************************
function x701614_EnchaseEx_4( sceneId, selfId, GemBagIndex, EquipBagIndex, MatBagIndex1, MatBagIndex2,nHole )
	local gemIdx, equipIdx, matIdx1, matIdx2 = -1, -1, -1, -1
	local odds = 25														-- 成功率
	local szTransferItem = ""
	local	GemIsBind = 0;
	local EquipIsBind = 0;
	local CharmIsBind = 0;
	local OddsIsBind = 0;
	local IsRedGem = 0;	
	--!!
	
	if(LuaFnGetItemBindStatus( sceneId, selfId, GemBagIndex ) == 1) then
		GemIsBind = 1;
	end
	
	local itemTableIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, EquipBagIndex )
	-- 褚少微，2008.7.1。重楼戒、重楼玉的机制修改：1、可以打孔；2、可以镶嵌宝石，但只能镶嵌不绑定的宝石
	-- 修改这项规则，可以打全部宝石
--	if(GemIsBind == 1) then
--	  	if(itemTableIndex == 10422016 or itemTableIndex == 10423024) then
--			LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
--	  		return OR_STUFF_LACK
--	  	end
--	end
	
	if(LuaFnGetItemBindStatus( sceneId, selfId, EquipBagIndex ) == 1) then
		EquipIsBind = 1;
	end
  
  if MatBagIndex1 ~= -1 then
     if(LuaFnGetItemBindStatus( sceneId, selfId, MatBagIndex1 ) == 1) then
		    CharmIsBind = 1;
	   end
	end
	
	if MatBagIndex2 ~= -1 then
	   if(LuaFnGetItemBindStatus( sceneId, selfId, MatBagIndex2 ) == 1) then
		    OddsIsBind = 1;
		 end
	end
	
	
	-- 判断宝石合法性
	if LuaFnIsItemAvailable( sceneId, selfId, GemBagIndex ) < 1 then	-- 使用有问题的物品则退出流程
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
		return OR_STUFF_LACK
	else
		gemIdx = LuaFnGetItemTableIndexByIndex( sceneId, selfId, GemBagIndex )
		szTransferItem = GetBagItemTransfer(sceneId,selfId,GemBagIndex)
		
		if x701614_IsGem( gemIdx ) == 0 then
			LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
			return OR_STUFF_LACK
		end
		
	end

	-- 判断装备合法性
	local equipType = LuaFnGetBagEquipType( sceneId, selfId, EquipBagIndex )
	
	if LuaFnIsItemLocked( sceneId, selfId, EquipBagIndex ) ~= 0	or equipType == -1 then												-- 使用有问题的物品则退出流程
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_STUFF_LACK)
		return OR_STUFF_LACK
	else
		equipIdx = LuaFnGetItemTableIndexByIndex( sceneId, selfId, EquipBagIndex )
	end
	
	-- 判断是否还可以镶嵌更多宝石
	local equipMaxGemCount = GetBagGemCount( sceneId, selfId, EquipBagIndex )
	local equipEmbededGemCount = GetGemEmbededCount( sceneId, selfId, EquipBagIndex )


	if equipMaxGemCount < 4 then --打孔数不能小于4个
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NO_FOUR_SLOT)
		return OR_GEM_NO_FOUR_SLOT
	end 
		
	if equipEmbededGemCount > 3 then --镶嵌宝石不能大于3
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_ENCHASE_FOUR)
		return OR_GEM_ENCHASE_FOUR
	end
		
	if equipEmbededGemCount < 3 then --镶嵌宝石不能小于3
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_MUST_ENCHASE_THREE)
		return OR_GEM_MUST_ENCHASE_THREE
	end
	
	if nHole < 0 or nHole > 3 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_EMBED_LACK)
		return
	end
	
	-- 如果是血精石或者红宝石，则放入失败
	for i, Data in x701614_GemEmbed_four_ID do
		if x701614_GemEmbed_four_ID[i] == gemIdx then
				
			IsRedGem = 1
		end
	end
		 
	if IsRedGem == 1 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NOT_ENCHASE)
	 	return OR_GEM_NOT_ENCHASE
	end
	 
	
	-- 判断宝石和装备的匹配性
	if not x701614_g_EquipGemTable[equipType] then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NOT_FIT_EQUIP)
		return OR_GEM_NOT_FIT_EQUIP
	end

	
	local gemType = LuaFnGetItemType( gemIdx )
	
	local passFlag = 0
	for i, gt in x701614_g_EquipGemTable[equipType] do
		if gt == gemType then
			passFlag = 1
			break
		end
	end

	if passFlag == 0 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NOT_FIT_EQUIP)
		return OR_GEM_NOT_FIT_EQUIP
	end


	
	-- 判断辅助材料的有效性
	if MatBagIndex1 == -1 or LuaFnIsItemAvailable( sceneId, selfId, MatBagIndex1 ) < 1 then
		MatBagIndex1 = -1
	else
		local findFlag = 0
		matIdx1 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, MatBagIndex1 )
		for i, matInfo in x701614_g_AssisMat do
			if matInfo.idx == matIdx1 then
				findFlag = 1
				odds = matInfo.odds
				break
			end
		end

		if findFlag == 0 then													-- 这个东西不是镶嵌符
			MatBagIndex1 = -1
			matIdx1 = -1
		end
	end
	
	-- 必须镶嵌符
	if MatBagIndex1 == -1 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_GEM_NEED_STUFF)
		return OR_GEM_NEED_STUFF
	end

	if MatBagIndex2 == -1 or LuaFnIsItemAvailable( sceneId, selfId, MatBagIndex2 ) < 1 then
		MatBagIndex2 = -1
	else
		matIdx2 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, MatBagIndex2 )

		if matIdx2 ~= x701614_g_FastenMat then											-- 这个东西不是强化符
			MatBagIndex2 = -1
			matIdx2 = -1
		end
	end

	-- 判断金钱数量
	local gemQual = GetItemQuality( gemIdx )
	local cost = x701614_g_EquipGemCost[gemQual]
	if not cost then
		cost = 0
	end

	-- 第一个孔原价，镶嵌第二个孔收费×2，镶嵌第三个孔收费×3
	cost = cost * ( equipEmbededGemCount + 1 )

	local PlayerMoney = GetMoney( sceneId, selfId ) +  GetMoneyJZ(sceneId, selfId)  --交子普及 Vega
	if PlayerMoney < cost then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_NOTENOUGH_MONEY)
		return OR_NOTENOUGH_MONEY
	end
	-- 按照规则进行消耗
	-- 不管成功失败都消耗金钱、特殊材料
	local ret = LuaFnCostMoneyWithPriority( sceneId, selfId, cost )      --交子普及 Vega
	if ret < 0 then
		LuaFnSendOResultToPlayer(sceneId,selfId,OR_NOTENOUGH_MONEY)
		return OR_NOTENOUGH_MONEY
	end

	if MatBagIndex1 > -1 then
	    LuaFnDelAvailableItem(sceneId,selfId,matIdx1,1)
	end

	if MatBagIndex2 > -1 then
	    LuaFnDelAvailableItem(sceneId,selfId,matIdx2,1)	
	end

	-- 如果成功
	local randRet = LuaFnGemEmbedRandom();
	if odds >= randRet then
		local ret = GemEnchasing( sceneId, selfId, GemBagIndex, EquipBagIndex,nHole )
		if ret and ret == 1 then
		
			if(GemIsBind == 1 or CharmIsBind == 1 or OddsIsBind == 1) then
				LuaFnItemBind( sceneId, selfId, EquipBagIndex);
			end
		
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
			LuaFnSendAbilitySuccessMsg( sceneId, selfId, 3, -1, equipIdx )

			local name = GetName( sceneId, selfId )

			local szTransferEquip = GetBagItemTransfer( sceneId, selfId, EquipBagIndex )
			local message = ScriptGlobal_Format("#{XTGG_171109_01}", name, szTransferEquip, szTransferItem);
			BroadMsgByChatPipe( sceneId, selfId, message, 4 )

			--[重复提示]
--			x701614_MsgBox( sceneId, selfId, "#Y恭喜你，镶嵌成功！" )
			--Add Log
			LogInfo	= format( "[EMBED]: sceneId=%d, GUID=%0X, bSuc=%d, idOldGem=%d, idEqp=%d, idMat0=%d, idMat1=%d, idNewGem=%d",
				sceneId,
				LuaFnObjId2Guid( sceneId, selfId ),
				1,
				gemIdx,
				equipIdx,
				matIdx1,
				matIdx2,
				gemIdx )
			WriteDebugLog( sceneId, selfId, LogInfo )
		end
	-- 如果失败
	else
		-- 如果玩家有宝石强化符，镶嵌失败之后宝石将会降M=1级，为0就消失。
		local qualDec			= 1
		local	gemIdx_new	= -1

		-- 如果玩家没有宝石强化符，那么镶嵌失败之后宝石将会降N=2级，为0就消失。
		if MatBagIndex2 == -1 then
			qualDec = qualDec + 1
		end
		--改由程序内扣除
		LuaFnDelAvailableItem(sceneId,selfId,gemIdx,1)

		if gemQual - qualDec > 0 then
			gemIdx_new = gemIdx - 100000 * qualDec
			local GemBagIndex = LuaFnTryRecieveItem( sceneId, selfId, gemIdx_new, QUALITY_MUST_BE_CHANGE )
			if(GemIsBind == 1 or CharmIsBind == 1 or OddsIsBind == 1) then
				LuaFnItemBind(sceneId, selfId, GemBagIndex)
			end
			x701614_MsgBox( sceneId, selfId, "#Y很遗憾，镶嵌失败，宝石降了"..qualDec.."级！" )
		else
			x701614_MsgBox( sceneId, selfId, "#Y很遗憾，镶嵌失败，宝石损坏！" )
		end
		--Add Log
		LogInfo	= format( "[EMBED]: sceneId=%d, GUID=%0X, bSuc=%d, idOldGem=%d, idEqp=%d, idMat0=%d, idMat1=%d, idNewGem=%d",
			sceneId,
			LuaFnObjId2Guid( sceneId, selfId ),
			0,
			gemIdx,
			equipIdx,
			matIdx1,
			matIdx2,
			gemIdx_new )
		WriteDebugLog( sceneId, selfId, LogInfo )
		
		if(GemIsBind == 1 or CharmIsBind == 1 or OddsIsBind == 1) then
			LuaFnItemBind( sceneId, selfId, EquipBagIndex);
		end

		return --OR_FAILURE
	end

	-- 按照成功率进行合成
	return --OR_OK
end
--**********************************
--宝石转移操作
--**********************************
function x701614_DoGemDisplace( sceneId, selfId, nSourcePos,nTargetPos )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if nSourcePos == -1 then
		x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_04}")
		return
	end
	if nTargetPos == -1 then
		x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_08}")
		return
	end
	local equippointSrc = LuaFnGetBagEquipType(sceneId,selfId, nSourcePos)
	if (not x701614_g_EquipGemTable[equippointSrc]) or (equippointSrc == 16) then
		x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_30}")
		return
	end
	local equippointDst = LuaFnGetBagEquipType(sceneId,selfId, nTargetPos)
	if (not x701614_g_EquipGemTable[equippointDst]) or (equippointDst == 16) then
		x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_30}")
		return
	end
	--检测金币
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < 100000 then
		LuaFnSendGemDisplaceOperate(sceneId,selfId,7)
	    return
	end
--	local nDgem_count = GetGemEmbededCount(sceneId,selfId,nTargetPos);
--	if nDgem_count ~= 0 then
--		x701614_NotifyTips( sceneId, selfId, "当前不支持向已有宝石的装备进行乾坤移" )
--		return
--	end
	local nTarHoldCount = GetBagGemCount(sceneId,selfId,nTargetPos);
	local nSelfHoldCount = GetBagGemCount(sceneId,selfId,nSourcePos);
	if nSelfHoldCount > nTarHoldCount then
		LuaFnSendGemDisplaceOperate(sceneId,selfId,3)
		return
	end
	
	local nGem1,nGem2,nGem3,nGem4 = LuaFnGetGemInfoInEquip(sceneId,selfId,nSourcePos)
	local aItemIDSrc = {nGem1,nGem2,nGem3,nGem4}
	nGem1,nGem2,nGem3,nGem4 = LuaFnGetGemInfoInEquip(sceneId,selfId,nTargetPos)
	local aItemIDDest = {nGem1,nGem2,nGem3,nGem4}
	for i = 1,nSelfHoldCount do
		local gemEmbededIdx = aItemIDSrc[i]
		local gemTarEmbededIdx = aItemIDDest[i]
--		print(gemEmbededIdx,gemTarEmbededIdx)
		if gemEmbededIdx > 0 then
			if gemTarEmbededIdx > 0 then
				LuaFnSendGemDisplaceOperate(sceneId,selfId,4)
				return
			end
			-- 这里需要调整一下, 只需要判断EquipSrc的前三个孔和EquipDest的前三个孔是否有重复
			local gemType = LuaFnGetGemTypeByIndex(gemEmbededIdx)
			if ( i < 4 ) then
				-- 得考虑目标装备实际打孔数量, 可能没有打够前3个
				local nMaxSlot = min( 3, nTarHoldCount );
				for k=1, nMaxSlot do
					local gemTypeDst = LuaFnGetGemTypeByIndex(gemTarEmbededIdx)
					if gemTypeDst ~= -1 and gemTypeDst == gemType then
						LuaFnSendGemDisplaceOperate(sceneId,selfId,6)
						return
					end
				end
				local passFlag = 0
				for i2, gt in x701614_g_EquipGemTable[equippointDst] do
					if gt == gemType then
						passFlag = 1
						break
					end
				end
				if passFlag == 0 then
					x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_18}")
					return
				end
			end
			--第四孔判断
			if i == 4 then
				for i2 = 1,getn(x701614_GemEmbed_four_ID) do
					if x701614_GemEmbed_four_ID[i2] == gemEmbededIdx then
						x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_18}")
						return
					end
				end
				local passFlag = 0
				for i2, gt in x701614_g_EquipGemTable[equippointDst] do
					if gt == gemType then
						passFlag = 1
						break
					end
				end
				if passFlag == 0 then
					x701614_NotifyTips( sceneId, selfId,"#{BSQKY_20110506_18}")
					return
				end
			end
		end
	end
	if LuaFnCostMoneyWithPriority( sceneId, selfId,100000) < 0 then
		return
	end
	--执行转移
	LuaFnDoGemDisplace(sceneId,selfId,nSourcePos,nTargetPos)
	--除非绑定重楼，一律绑定
	LuaFnItemBind( sceneId, selfId, nTargetPos );
	LuaFnSendGemDisplaceOperate(sceneId,selfId,0)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	--分场景提示
	local strTrans = GetBagItemTransfer( sceneId, selfId, nTargetPos )
	local nSrcItemTableId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nSourcePos)
	local strSrcItemName = GetItemName(sceneId,nSrcItemTableId)
	local strGlobal = ""
	if sceneId == SCENE_LUOYANG then
		strGlobal = ScriptGlobal_Format("#{BSQKY_20110506_33}",GetName(sceneId,selfId),strSrcItemName,strTrans)
	elseif sceneId == SCENE_SHUHE then
		strGlobal = ScriptGlobal_Format("#{BSQKY_20110506_34}",GetName(sceneId,selfId),strSrcItemName,strTrans)
	elseif sceneId == SCENE_LOULAN then
		strGlobal = ScriptGlobal_Format("#{BSQKY_20110506_35}",GetName(sceneId,selfId),strSrcItemName,strTrans)
	end
	AddGlobalCountNews(sceneId, strGlobal)
end
--**********************************
--镶嵌材料购买
--**********************************
function x701614_EnchaseEx_YuanbaoPay( sceneId, selfId, nItemId,nCheck )
	
	local nConvenientType = 9
	local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,nConvenientType,nItemId,nCheck)
	if nNeedMoney == nil then
		return
	end
	local strItemName = GetItemName(sceneId,nItemId)
	local strTips = ScriptGlobal_Format("#{BSLCYH_130529_88}",
	strItemName,tostring(nNeedMoney),strItemName)
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nCheck )
		UICommand_AddInt( sceneId, nConvenientType )
		UICommand_AddInt( sceneId, nMoneyUnit )
		UICommand_AddInt( sceneId, nNeedMoney )
		UICommand_AddInt( sceneId, itemIndex )
		UICommand_AddInt( sceneId, 0 )
		UICommand_AddInt( sceneId, -1 )
		UICommand_AddString(sceneId,strTips)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 2013060605 )
end
--**********************************
--摘除材料购买
--**********************************
function x701614_SplitGemEx_YuanbaoPay( sceneId, selfId, nItemId,nCheck )
	
	local nConvenientType = 9
	local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,nConvenientType,nItemId,nCheck)
	if nNeedMoney == nil then
		return
	end
	local strItemName = GetItemName(sceneId,nItemId)
	local strTips = ScriptGlobal_Format("#{BSLCYH_130529_109}",
	strItemName,tostring(nNeedMoney),strItemName)
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nCheck )
		UICommand_AddInt( sceneId, nConvenientType )
		UICommand_AddInt( sceneId, nMoneyUnit )
		UICommand_AddInt( sceneId, nNeedMoney )
		UICommand_AddInt( sceneId, itemIndex )
		UICommand_AddInt( sceneId, 0 )
		UICommand_AddInt( sceneId, -1 )
		UICommand_AddString(sceneId,strTips)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 2013060606 )
end

--**********************************
--信息提示
--**********************************
function x701614_NotifyTips( sceneId, selfId, str )
	--醒目提示
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
