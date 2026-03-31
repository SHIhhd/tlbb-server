-- 宝石合成

-- 脚本号
x701602_g_scriptId = 701602

-- 脚本名称
x701602_g_scriptName = "合成宝石"

-- 合成规则表
x701602_g_RuleTable = 
{
	[1] = { SpecialStuff = 30900015, MoneyCost = 5000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[2] = { SpecialStuff = 30900015, MoneyCost = 6000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[3] = { SpecialStuff = 30900015, MoneyCost = 7000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[4] = { SpecialStuff = 30900016, MoneyCost = 8000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[5] = { SpecialStuff = 30900016, MoneyCost = 9000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[6] = { SpecialStuff = 30900016, MoneyCost = 10000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[7] = { SpecialStuff = 30900128, MoneyCost = 11000, CountTable = { [4] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
	[8] = { SpecialStuff = 30900016, MoneyCost = 12000, CountTable = { [3] = { SuccOdds = 25, SuccOddsWithSpecStuff = 50, }, [4] = { SuccOdds = 50, SuccOddsWithSpecStuff = 75, }, [5] = { SuccOdds = 75, SuccOddsWithSpecStuff = 100, }, }, },
}

--材料合成数据表
x701602_CaiLiaoCompound_Data = 
{
	-- level1为碎片，level4为3级材料，这样
	[1] = { newlevel = 2, needlevel = 1, needcount = 5, needmoney = 500, },
	[2] = { newlevel = 3, needlevel = 2, needcount = 5, needmoney = 1000, },
	[3] = { newlevel = 4, needlevel = 3, needcount = 5, needmoney = 1500, },
	[4] = { newlevel = 5, needlevel = 4, needcount = 5, needmoney = 5000, },
}

x701602_CaiLiaoCompound_Item = 
{
	[1]=
	{
		{nItemID = 20502000, strShowName = "秘银碎片"},	--秘银碎片
		{nItemID = 20502001, strShowName = "1级秘银"},	--1级秘银
		{nItemID = 20502002, strShowName = "2级秘银"},	--2级秘银
		{nItemID = 20502003, strShowName = "3级秘银"},	--3级秘银
		{nItemID = 20502004, strShowName = "4级秘银"},	--4级秘银
	},
	
	[2]=
	{
		{nItemID = 20501000, strShowName = "棉布碎片"},	--棉布碎片
		{nItemID = 20501001, strShowName = "1级棉布"},	--1级棉布
		{nItemID = 20501002, strShowName = "2级棉布"},	--2级棉布
		{nItemID = 20501003, strShowName = "3级棉布"},	--3级棉布
		{nItemID = 20501004, strShowName = "4级棉布"},	--4级棉布
	},
	
	[3]=
	{
		{nItemID = 20500000, strShowName = "精铁碎片"},	--精铁碎片
		{nItemID = 20500001, strShowName = "1级精铁"},	--1级精铁
		{nItemID = 20500002, strShowName = "2级精铁"},	--2级精铁
		{nItemID = 20500003, strShowName = "3级精铁"},	--3级精铁
		{nItemID = 20500004, strShowName = "4级精铁"},	--4级精铁
	},
}
--============================================
--材料合成系统
--============================================
function x701602_CaiLiaoCompound_New(sceneId,selfId,npcId,nCurNum_PerTime,nIndex,nSubIndex,bIsOk)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if nIndex < 0 or nIndex > 3 then
		return
	end
	if nSubIndex < 0 or nSubIndex > 4 then
		return
	end
	--整理合成数据
	local tSubData = x701602_CaiLiaoCompound_Data[nSubIndex]
	if tSubData == nil then
		return
	end	
	local tItem = x701602_CaiLiaoCompound_Item[nIndex]
	if tItem == nil then
		return
	end	
	local needCount = tSubData.needcount
	if needCount == nil or needCount <= 0 then
		return
	end
	local needMoney = tSubData.needmoney
	if needMoney == nil or needMoney <= 0 then
		return
	end
	local needLevel = tSubData.needlevel
	if needLevel == nil or needLevel <= 0 then
		return
	end
	local needItemId = tItem[needLevel].nItemID
	if needItemId == nil or needItemId <= 0 then
		return
	end
	local newLevel = tSubData.newlevel
	if newLevel == nil or newLevel <= 0 then
		return
	end
	local newItemId = tItem[newLevel].nItemID
	if newItemId == nil or newItemId <= 0 then
		return
	end
	local newItemName = GetItemName(sceneId,newItemId)
	--CLHC_170824_35	#H背包中所携带的未锁定的%s0数量不足，无法合成%s1。
	local nHaveCount = LuaFnGetAvailableItemCount(sceneId, selfId,needItemId)
	if nHaveCount < needCount then
		x701602_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{CLHC_170824_35}",tItem[needLevel].strShowName,newItemName) )
        return
	end
	local nCanCompoundNum = floor(nHaveCount / 5)
	if nCurNum_PerTime > nCanCompoundNum then
		x701602_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{CLHC_170824_35}",tItem[needLevel].strShowName,newItemName) )
        return
	end
	--金币检查
	local nMoneyJZ = GetMoneyJZ(sceneId,selfId)
	local nMoneyJB = GetMoney(sceneId,selfId)
	local nMoneySelf = nMoneyJZ + nMoneyJB
	if nMoneySelf < tonumber(tSubData.needmoney) * nCurNum_PerTime then
        x701602_NotifyTips( sceneId, selfId,  "#{CLHC_170824_36}" )
        return
	end
	--最终需要的材料数量
	local totalNeededMaterials = nCurNum_PerTime * 5
	--计算最终绑定与非绑定材料的数量
	local nFinBindNum = 0;
	local nFinNotBindNum = 0;
	--优先寻找绑定材料
	local nBindMatNum = LuaFnGetBindItemCountInBag(sceneId, selfId, needItemId)
	local nNotBindMatNum = LuaFnGetNotBindItemCountInBag(sceneId, selfId, needItemId )
	-- 计算实际使用的绑定材料和非绑定材料数量
	local usedBindMatNum = min(totalNeededMaterials, nBindMatNum)
	local remainingMaterialsNeeded = totalNeededMaterials - usedBindMatNum
	local usedNotBindMatNum = min(remainingMaterialsNeeded, nNotBindMatNum)
	-- 计算最终的绑定材料和非绑定材料数量
	local finalBindMatNum = usedBindMatNum -- 最终使用的绑定材料数量，优先使用
	local finalNotBindMatNum = usedNotBindMatNum -- 最终使用的非绑定材料数量
	-- 计算最终合成物品的绑定状态
	local finalBoundItems = floor(usedBindMatNum / 5)
	local finalNonBoundItems = nCurNum_PerTime - finalBoundItems
	if nBindMatNum > 0 and nNotBindMatNum > 0 then
		if finalBoundItems > 0 and finalNonBoundItems > 0 and bIsOk ~= 1 then
			--这种情况下要二次确认
			local strTips = ScriptGlobal_Format("#{CLHC_170828_48}",finalBindMatNum,tItem[needLevel].strShowName,
				finalNotBindMatNum,tItem[needLevel].strShowName,
				tostring(finalBoundItems + finalNonBoundItems),newItemName,finalBoundItems)
			
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, npcId )
				UICommand_AddInt( sceneId, nCurNum_PerTime )
				UICommand_AddInt( sceneId, nIndex )
				UICommand_AddInt( sceneId, nSubIndex )
				
				UICommand_AddString( sceneId, strTips )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 920170826 )--新界面
			return
		end
	end
	--仅扣除绑定物品
	if finalBindMatNum > 0 then
		if LuaFnDelBindAvailableItem(sceneId,selfId,needItemId,finalBindMatNum) ~= 1 then
			return
		end
	end
	--仅扣除非绑定物品
	if finalNotBindMatNum > 0 then
		if LuaFnDelNotBindAvailableItem(sceneId,selfId,needItemId,finalNotBindMatNum) ~= 1 then
			return
		end
	end
	--扣钱
	if LuaFnCostMoneyWithPriority( sceneId, selfId, needMoney * nCurNum_PerTime) == -1 then
		return
	end
	--发放物品
	BeginAddItem(sceneId)
	if finalBoundItems > 0 then
		AddBindItem(sceneId,newItemId,finalBoundItems)
	end
	if finalNonBoundItems > 0 then
		AddItem( sceneId,newItemId,finalNonBoundItems)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	AddItemListToHuman(sceneId,selfId)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	x701602_NotifyTips( sceneId, selfId,  ScriptGlobal_Format("#{CLHC_170828_47}",nCurNum_PerTime,newItemName) )
	if newLevel >= 3 then
		--取消高级物品的公告
--		local strText = format("#{_INFOUSR%s0}#H经过一番努力，终于合成出了"..nCurNum_PerTime.."个"..GetItemName(sceneId,newItemId).."。",GetName(sceneId,selfId)) 
--		BroadMsgByChatPipe(sceneId, selfId, strText, 4)
	end
end
--**********************************************************************
-- 宝石以及材料合成接口
-- bagIndex1, bagIndex2 两个宝石或材料所在的格子
-- nsel选择的合成方式
--**********************************************************************
function x701602_GemCompound( sceneId, selfId, nGemTableId,g_ItemBagIndex, nSel )
	if nSel < 0 or nSel > 2 then
		return
	end
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if g_ItemBagIndex == nil or g_ItemBagIndex == -1 then
		x701602_NotifyTips(sceneId,selfId,"#{BSDJ_170811_10}")
		return
	end
	if nGemTableId == nil or nGemTableId == -1 then
		return
	end
	local nGemLevel = x701602_Gemcompose_GetGemLevel(nGemTableId)
	--检查材料是否是最高等级
	if nGemLevel >= 9 then
		x701602_NotifyTips(sceneId,selfId, "#{BSQHB_120830_04}" )
		return
	end
	--合成8，9级宝石功能关闭；放开8级宝石。[LiChengjie]
	if nGemLevel > 7 then
		x701602_NotifyTips(sceneId,selfId, "#{BSHC_090313_1}" )
		return
	end
	--数量检查
	local nGemNeedNumber = 0
	if nSel == 0 then
		nGemNeedNumber = 5
	elseif nSel == 1 then
		nGemNeedNumber = 4
	elseif nSel == 2 then
		nGemNeedNumber = 3
	end
	local nGemCount = LuaFnGetAvailableItemCount(sceneId, selfId,nGemTableId)
	if nGemCount < nGemNeedNumber then
		x701602_NotifyTips( sceneId, selfId,ScriptGlobal_Format( "#{BSDJ_170811_13}", tostring(nGemNeedNumber)))
		return
	end
	-- 检查身上的金钱是否足够
	local selfMoney = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if selfMoney < x701602_g_RuleTable[nGemLevel].MoneyCost then
		--您身上的金钱不足
		x701602_NotifyTips( sceneId, selfId,ScriptGlobal_Format( "#{BSDJ_170811_14}", x701602_g_RuleTable[nGemLevel].MoneyCost ) )
		return
	end
	-- 检查消耗的合成符是否合法
	local nMaterialId = LuaFnGetItemTableIndexByIndex( sceneId, selfId, g_ItemBagIndex )
	if x701602_g_RuleTable[nGemLevel].SpecialStuff ~= nMaterialId then
		x701602_NotifyTips( sceneId, selfId,"#{BSDJ_170811_15}")
		return
	end
	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		x701602_NotifyTips( sceneId, selfId, "#{BSDJ_170811_33}" )
		return
	end
	--概率计算
	local nOdds = 0
	if nSel == 0 and x701602_g_RuleTable[nGemLevel] ~= nil and x701602_g_RuleTable[nGemLevel].CountTable[5] ~= nil then
		nOdds = x701602_g_RuleTable[nGemLevel].CountTable[5].SuccOdds
		if g_ItemBagIndex ~= -1 then
			nOdds = x701602_g_RuleTable[nGemLevel].CountTable[5].SuccOddsWithSpecStuff
		end	
	elseif nSel == 1 and x701602_g_RuleTable[nGemLevel].CountTable[4] ~= nil  then
		nOdds = x701602_g_RuleTable[nGemLevel].CountTable[4].SuccOdds
		if g_ItemBagIndex ~= -1 then
			nOdds = x701602_g_RuleTable[nGemLevel].CountTable[4].SuccOddsWithSpecStuff
		end
	elseif nSel == 2 and x701602_g_RuleTable[nGemLevel].CountTable[3] ~= nil then
		nOdds = x701602_g_RuleTable[nGemLevel].CountTable[3].SuccOdds
		if g_ItemBagIndex ~= -1 then
			nOdds = x701602_g_RuleTable[nGemLevel].CountTable[3].SuccOddsWithSpecStuff
		end
	end
	
	local nFirstGemPos = LuaFnGetAvailableItemFirstPos(sceneId,selfId,nGemTableId)
	local nGemIdBind = LuaFnGetBindItemCountInBag(sceneId,selfId,nGemTableId)
	local nBindState = LuaFnGetItemBindStatus(sceneId, selfId, nFirstGemPos)
	local nGemTransfur = GetBagItemTransfer( sceneId, selfId, nFirstGemPos ) --宝石trans
	local nItemTransfur = GetBagItemTransfer( sceneId, selfId, g_ItemBagIndex ) --合成符trans
	
	--准备物品添加
	local newItemIndex = nGemTableId + 100000
	BeginAddItem(sceneId)
	if nBindState == 1 or nGemIdBind > 0 then
		AddBindItem( sceneId,newItemIndex,1)
	else
		AddItem( sceneId,newItemIndex,1)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		x701602_NotifyTips( sceneId, selfId, "#{BSDJ_170811_33}" )
		return
	end
	--先扣除物品
	LuaFnDelAvailableItem(sceneId,selfId,nGemTableId,nGemNeedNumber)
	if g_ItemBagIndex ~= -1 then
		LuaFnDelAvailableItem(sceneId,selfId,nMaterialId,1)
	end
	--目前暂时和宝石镶嵌用同一个生成器【注意，这里不要使用的lua自带的随机数，其分布的离散性不足】
	local nRand = LuaFnGemEmbedRandom();
	if nRand > nOdds then
		LuaFnCostMoneyWithPriority( sceneId, selfId, tonumber(x701602_g_RuleTable[nGemLevel].MoneyCost));
		x701602_NotifyTips( sceneId, selfId, "#{BSDJ_170811_24}" )
		return
	end
	--发送合成的宝石到背包
	AddItemListToHuman(sceneId,selfId)
	local szTransfer = LuaFnGetItemTransfer(sceneId,selfId,0)
	
	LuaFnSendAbilitySuccessMsg( sceneId, selfId, -1, -1, newItemIndex )		-- 提示生成物
	LuaFnAuditGemCompound( sceneId,selfId, 1,nGemTableId, g_ItemBagIndex, nSel, -1, -1, newItemIndex )
	LuaFnCostMoneyWithPriority( sceneId, selfId, tonumber(x701602_g_RuleTable[nGemLevel].MoneyCost));
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	x701602_NotifyTips( sceneId, selfId, "#{BSDJ_170811_21}" )
	x701602_NotifyTips( sceneId, selfId, ScriptGlobal_Format( "#{BSDJ_170811_22}",GetItemName(sceneId,nGemTableId + 100000)) )
	if nGemLevel >= 7 and nGemNeedNumber == 4 then
		local strText = ScriptGlobal_Format("#{BSQHB_120830_11}"
						,GetName(sceneId,selfId)
						,nGemTransfur
						,nItemTransfur
						,szTransfer
						,GetName(sceneId,selfId)) 
		BroadMsgByChatPipe(sceneId, selfId, strText, 4)
	else
		local strText = ScriptGlobal_Format("#{BSDJ_170811_23}",GetName(sceneId,selfId),szTransfer) 
		BroadMsgByChatPipe(sceneId, selfId, strText, 4)
	end
	
end
function x701602_Gemcompose_GetGemLevel(nSN)
	
	if nSN < 0 then
		return 0
	end

	local nLevel = floor(mod(nSN,10000000) / 100000)
	return nLevel

end
--**********************************
--醒目提示
--**********************************
function x701602_NotifyTips( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
