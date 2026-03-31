--珍兽技能学习UI 3

x311111_g_ScriptId = 311111;

x311111_g_MenPaiId = 0;
x311111_g_MenPaiSkillIds = {701,702,703}

x311111_g_itemList = {};
x311111_g_itemList[30503016] = {minLevel = 1, maxLevel = 85}	--终级珍兽还童卷轴
x311111_g_itemList[30503017] = {minLevel = 1, maxLevel = 35}	--低级珍兽还童天书
x311111_g_itemList[30503018] = {minLevel = 1, maxLevel = 65}	--中级珍兽还童天书
x311111_g_itemList[30503019] = {minLevel = 1, maxLevel = 85}	--高级珍兽还童天书
x311111_g_itemList[30503020] = {minLevel = 1, maxLevel = 95}	--超级珍兽还童天书

-- 完美还童的悟性等级对应元宝
x311111_g_YuanBaoCosts = {
	[1] = 2280,
	[5] = 2300,
	[15] = 2320,
	[20] = 2340,
	[30] = 2380,
	[45] = 3320,
	[55] = 3420,
	[65] = 3580,
	[75] = 4700,
	[85] = 4860,
	[95] = 18200,
}
--**********************************
--列举事件
--**********************************
function x311111_OnEnumerate( sceneId, selfId, targetId, sel )
	if(sel == 6) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId); --调用发布征友信息界面
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 5)
		
		local ret = DispatchPetPlacardList(sceneId,selfId,targetId,-1,-1,1);
		if(0 == ret) then
			Msg2Player( sceneId,selfId,"现在没有注册的珍兽",MSG2PLAYER_PARA)
		end
	elseif (sel == 1) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);	--调用新版珍兽技能学习界面 UI 223
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 223)
	else
		--珍兽还童特写
		if sel == 2 then
			--20090929
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId);
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 20090929)
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt(sceneId,sel)		--调用技能学习界面
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 3)
	end
end

--**********************************
--购买还童天书
--**********************************
function x311111_PetHuantong_Yuanbao_Pay( sceneId, selfId, nItemId,nCheck )
	local nNeedYuanbao = 0 --固定价格，这里偷个懒，先把功能完成了
	if nItemId == 30503017 then
		nNeedYuanbao = 39
	elseif nItemId == 30503018 then
		nNeedYuanbao = 55
	elseif nItemId == 30503019 then
		nNeedYuanbao = 72
	elseif nItemId == 30503020 then
		nNeedYuanbao = 300
	else
		return
	end
	if nNeedYuanbao <= 0 then
		return
	end
	local nNeedItemName = GetItemName(sceneId,nItemId)
	if nCheck == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 311111 )
			UICommand_AddInt( sceneId, nItemId )
			UICommand_AddString(sceneId,"PetHuantong_Yuanbao_Pay")
			--参数
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddString(sceneId,ScriptGlobal_Format("#{ZSYB_151109_07}", nNeedItemName,tostring(nNeedYuanbao),nNeedItemName,nNeedItemName))
			
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 255 )	--Server控制弹出的提示框的扩展版 --如果有第二个整形参数，表明有需要关心的NPC
		return
	end
	local nCurYuanbao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanbao < nNeedYuanbao then
		x311111_NotifyTip(sceneId, selfId, "#{ZSYB_151109_03}" );
		return
	end
	--检查背包空间
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x311111_NotifyTip(sceneId,selfId,"#{ZSYB_151109_05}")
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x311111_NotifyTip(sceneId, selfId, ScriptGlobal_Format("#{ZSYB_151109_04}",nNeedItemName) );
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,nNeedYuanbao,311111,"PetHuantong_Yuanbao_Pay",nItemId,1) ~= 1 then
		return
	end	
	--满足条件发送物品
	LuaFnTryRecieveItem(sceneId,selfId,nItemId,1)
	LuaFnSendShopBuySuccessMsg(sceneId,selfId,nItemId,1)
	x311111_NotifyTip(sceneId, selfId, ScriptGlobal_Format("#{ZSYB_151109_06}",tostring(nNeedYuanbao),nNeedItemName) );
end
--**********************************
--完美还童
--**********************************
function x311111_OnQuickPropagate(sceneId,selfId,targetId,petHid,petLid)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	--增加15级判断
	if GetLevel(sceneId,selfId) < 15 then
		x311111_NotifyTip(sceneId, selfId, "#{ZSKJT_130717_01}" );
		return
	end
	--检查珍兽
	local checkPet = LuaFnIsPetAvailableByGUID(sceneId, selfId,petHid,petLid)
	if not checkPet or checkPet ~= 1 then
		x311111_NotifyTip(sceneId, selfId, "#{ZSKSSJ_081113_06}");
		return
	end
	local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
	--是否出战
	if petHid==pgH and petLid==pgL then
		x311111_NotifyTip(sceneId,selfId ,"#{ZSKJT_130428_23}")
		return
	end
	--检查是否已经幻化
	local nGener = LuaFnGetPetGenerationByGUID(sceneId,selfId,petHid,petLid)
	if nGener >= 100 then
		x311111_NotifyTip(sceneId, selfId, "#{RXZS_090804_29}");
		return
	end
	--有无配偶
	local spouseGUID_H, spouseGUID_L = LuaFnGetPetSpouseGUIDByGUID(sceneId, selfId, petHid, petLid);
	if not spouseGUID_H or not spouseGUID_L or spouseGUID_H ~= 0 or spouseGUID_L ~= 0 then
		x311111_NotifyTip(sceneId, selfId, "#{ResultText_73}");
		return
	end
	local petType = LuaFnGetPetTypeByGUID(sceneId, selfId, petHid, petLid);
	if not petType or petType == 1 then
		x311111_NotifyTip(sceneId, selfId, "#{ZSKJT_130428_24}");
		return
	end
	--到达上限不允许操作
	local nGrowLevel = LuaFnGetPetGrowRateByGUID( sceneId, selfId, petHid, petLid );
	local nGrowMaxLevel = LuaFnGetPetGrowRate4ByGUID( sceneId, selfId, petHid, petLid );
	if	nGrowLevel >= nGrowMaxLevel then
		x311111_NotifyTip(sceneId, selfId, "#{ZSKJT_130428_25}");
		return
	end
	local nTakeLevel = LuaFnGetPetTakeLevelByGUID( sceneId, selfId, petHid, petLid );
	local nNeedYuanbao = x311111_g_YuanBaoCosts[nTakeLevel]
	if nNeedYuanbao == nil then
		return
	end
	local nCurYuanbao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanbao < nNeedYuanbao then
		x311111_NotifyTip(sceneId, selfId, "#{ZSYB_151109_03}" );
		return
	end
	--能否还童
	if LuaFnPetCanReturnToChild( sceneId, selfId, petHid, petLid, 1, -1) == 0 then
		x311111_NotifyTip(sceneId, selfId, "#{HTQR_091010_2}");
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x311111_NotifyTip(sceneId, selfId, "#{HLYH_160120_34}" );
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,nNeedYuanbao,311111,"OnQuickPropagate",0,0) ~= 1 then
		return
	end	
	--进入还童程序
	local ret, newGrowVal = LuaFnPetReturnToChildPerfect( sceneId, selfId, petHid, petLid, 1, -1)
	if ret and ret == 1 then		
		--ZSKJT_130428_28	#H恭喜您，完美还童成功，该珍兽的成长率为完美%s0	
		x311111_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{ZSKJT_130428_28}",tostring(newGrowVal)) );
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0);		-- 特效
		--ZSKJT_130717_06	#G洛阳（275，294）#R云渺渺#H见来人追求灵兽之心甚切，遂向其推荐#Y珍兽完美还童#H之术，#{_INFOUSR%s0}#H听闻后，当即便以此法将珍兽直接还童为成长率#G%s1#H的#{_INFOMSG%s2}#H，当真妙不可言。	
		local selfName = LuaFnGetName(sceneId, selfId);
		local petTransfer = LuaFnGetPetTransferByGUID(sceneId, selfId, petHid, petLid);
		local strWorldChat = ScriptGlobal_Format("#{ZSKJT_130717_06}",selfName,tostring(newGrowVal),petTransfer);
		BroadMsgByChatPipe(sceneId, selfId, strWorldChat, 4);
	end
end
--**********************************
--珍兽还童new
--**********************************
function x311111_OnPropagate(sceneId,selfId,targetId,petHid,petLid,bLockPer,bGrowLock,nPos,nIsHuantongForCZLConfirm)
	if petHid == nil or petLid == nil or bGrowLock == nil or bLockPer == nil or nPos == nil then
		return
	end
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	--检查珍兽
	local checkPet = LuaFnIsPetAvailableByGUID(sceneId, selfId,petHid,petLid)
	if not checkPet or checkPet ~= 1 then
		x311111_NotifyTip(sceneId, selfId, "#{ZSKSSJ_081113_06}");
		return
	end
	--出战状态
	local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
	if petLid == pgL then
		x311111_NotifyTip( sceneId, selfId, "#{ZSKJT_130428_23}" )
		return
	end
	--检查是否已经幻化
	local nGener = LuaFnGetPetGenerationByGUID(sceneId,selfId,petHid,petLid)
	if nGener >= 100 then
		x311111_NotifyTip(sceneId, selfId, "#{RXZS_090804_29}");
		return
	end
	--是否附体
--	local ret = CallScriptFunction(900009, "IsInPossessionEx", sceneId, selfId,petHid,petLid)
--	if ret == 1 then
--		x311111_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_06}" )
--		return
--	end
	--有无配偶
	local spouseGUID_H, spouseGUID_L = LuaFnGetPetSpouseGUIDByGUID(sceneId, selfId, petHid, petLid);
	if not spouseGUID_H or not spouseGUID_L or spouseGUID_H ~= 0 or spouseGUID_L ~= 0 then
		x311111_NotifyTip(sceneId, selfId, "#{ResultText_73}");
		return
	end
	local petType = LuaFnGetPetTypeByGUID(sceneId, selfId, petHid, petLid);
	if not petType or petType == 1 then
		x311111_NotifyTip(sceneId, selfId, "#{ZSKJT_130428_24}");
		return
	end
	local curPetTemplateId = LuaFnGetPetDataIDByGUID(sceneId, selfId, petHid, petLid);
	local curPetTakeLevel = GetPetTakeLevel(curPetTemplateId);
	local ItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nPos )
	local nCostMoney = x311111_GetHuanTongCostMoney(sceneId,curPetTakeLevel, ItemID);
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nCostMoney > nMoneySelf then
		x311111_NotifyTip(sceneId, selfId, "#{HTQR_091010_7}");
		return 
	end
	--还童书检查
	if x311111_g_itemList[ItemID] == nil then
		x311111_NotifyTip(sceneId, selfId, "未开放道具，无法使用。");
		return
	end
	--能否还童
	if LuaFnPetCanReturnToChild( sceneId, selfId, petHid, petLid, 1, -1) == 0 then
		x311111_NotifyTip(sceneId, selfId, "#{HTQR_091010_2}");
		return
	end
	if curPetTakeLevel > x311111_g_itemList[ItemID].maxLevel then
		if (curPetTakeLevel == 95) then
			x311111_NotifyTip(sceneId, selfId, "#{95ZSH_081121_01}");
			return
		else
			x311111_NotifyTip(sceneId, selfId, "不能对携带等级为"..x311111_g_itemList[ItemID].maxLevel.."级以上的珍兽进行还童。");
			return
		end
	end
	--进入还童程序
	local ret, perLevel = LuaFnPetReturnToChild( sceneId, selfId, petHid, petLid, 1, -1,bGrowLock,bLockPer)
	if ret and ret == 1 then
		--LuaFnEraseItem(sceneId,selfId,nPos)
		LuaFnDelAvailableItem(sceneId,selfId,ItemID,1)
		local szMsg = "珍兽还童成功！";
		x311111_NotifyTip( sceneId, selfId, szMsg );								-- 醒目提示
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0);		-- 特效
		
		local nGrowLevel = LuaFnGetPetGrowRateByGUID( sceneId, selfId, petHid, petLid );
		local selfName = LuaFnGetName(sceneId, selfId);
		local petTransfer = LuaFnGetPetTransferByGUID(sceneId, selfId, petHid, petLid);
		if perLevel and perLevel >= 6 and selfName and petTransfer then
			local strWorldChat = "#{_INFOUSR"..selfName.."}#H使用#Y还童天书#H后，#{_INFOMSG"..petTransfer.."}#H从天而降！";
			BroadMsgByChatPipe(sceneId, selfId, strWorldChat, 4);
		end
		
		-- 成长率在杰出（含）以上时播放系统公告
		if (nGrowLevel >= 4) then
			local strTbl = {"普通","优秀","杰出","卓越","完美"};
			-- AAA很喜欢小动物，将珍兽还童后竟然意外的得到了成长率为CCC的BBB！爱心的回报果然丰厚。
			-- AAA为玩家链接  BBB为还童后珍兽的链接	 CCC为成长率（杰出及以上）。
			local Msg = "#W#{_INFOUSR%s}#{HT14}#Y"..strTbl[nGrowLevel].."#{HT15}#{_INFOMSG%s}#{HT16}"
			local szPetTrans = GetPetTransString ( sceneId, selfId, petHid, petLid )
			local str = format( Msg, selfName, szPetTrans )
			BroadMsgByChatPipe (sceneId, selfId, str, 4)
		end
	elseif ret == 2 then
		--LuaFnEraseItem(sceneId,selfId,nPos)
		LuaFnDelAvailableItem(sceneId,selfId,ItemID,1)
		--这种是有锁的情况下失败的，要提示
		local szMsg = "珍兽还童失败！不要灰心，可再试一次！";
		x311111_NotifyTip( sceneId, selfId, szMsg );								-- 醒目提示
		x311111_NotifyTip( sceneId, selfId, "#{HTQR_091010_1}" );
	end
	
end

--*************************************************
--珍兽还童花费的金钱
--*************************************************
function x311111_GetHuanTongCostMoney(sceneId,petlevel, itemId)
	if(nil == petlevel or nil == itemId or -1 == itemId) then
		return 0
	end
	
	local costMoney = LuaFnGetPetHuanTongCost(sceneId,petlevel);
	--终级还童卷轴收费降至90%
	if 	   (itemId == 30503011 or
			itemId == 30503012) then
	--珍兽还童卷轴/高级珍兽还童卷轴
	elseif (itemId == 30503016 or
			itemId == 30503017 or
			itemId == 30503018 or
			itemId == 30503019 or
			itemId == 30503020) then

			costMoney = (costMoney * 90)/100
			if (costMoney <= 0) then
				costMoney = 1
			end
	else
	--类似 还童丹：兔子
			costMoney = costMoney/100
			if (costMoney <= 0) then
				costMoney = 1
			end
	end
	return costMoney
end

--条件检查，返回0 检查失败 ,1 检查成功
function x311111_PetSkillStudy_MenPaiCheck(sceneId, selfId)
	if(x311111_g_MenPaiId ~= tonumber(GetMenPai(sceneId, selfId))) then
		return 0;
	else
		return 1;
	end
end

--门派技能学习
function x311111_PetSkillStudy_MenPai_Learn(sceneId, selfId, petHid, petLid, skillId)
	local ret = PetStudySkill_MenPai(sceneId, selfId, petHid, petLid, skillId);
	if( 1 == ret ) then
		Msg2Player( sceneId,selfId,"珍兽门派技能学习成功",MSG2PLAYER_PARA)
	else
		Msg2Player( sceneId,selfId,"珍兽门派技能学习失败",MSG2PLAYER_PARA)
	end
end

--驯养费查询
function x311111_PetSkillStudy_Ask_Money(sceneId, selfId, petHid, petLid)
	local money	= x311111_CalcMoney_ha( sceneId, selfId, petHid, petLid )
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, money)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 4)
end

--驯养珍兽
function x311111_PetSkillStudy_Domestication(sceneId, selfId, petHid, petLid)
--local ret = PetDomestication(sceneId, selfId, petHid, petLid);
	local checkAvailable = LuaFnIsPetAvailableByGUIDNoPW(sceneId, selfId, petHid, petLid);
	if checkAvailable and checkAvailable == 1 then
		local money	= x311111_CalcMoney_ha( sceneId, selfId, petHid, petLid )
		local PlayerMoney = GetMoney( sceneId, selfId )  +  GetMoneyJZ(sceneId, selfId)  --交子普及 Vega
		if PlayerMoney < money then
			return
		end
		--给玩家的珍兽提升快乐度并删除金钱
		LuaFnCostMoneyWithPriority( sceneId, selfId, money )
		LuaFnSetPetHappiness( sceneId, selfId, petHid, petLid, 100 )
		Msg2Player( sceneId, selfId, "珍兽驯养成功", MSG2PLAYER_PARA )
	else
		Msg2Player( sceneId, selfId, "不能在交易状态进行该操作", MSG2PLAYER_PARA )
	end
end

--查看前一篇征友信息
function x311111_PetInviteFriend_Ask_NewPage(sceneId, selfId, npcId, guid1, guid2, dir)
	local ret = DispatchPetPlacardList(sceneId, selfId, npcId, guid1, guid2, dir)
	if(0 == ret) then
		Msg2Player( sceneId,selfId,"没有更多珍兽了",MSG2PLAYER_PARA)
	end
end

--**********************************
--计算恢复欢乐度费用
--**********************************
--单位血驯养价值：0.025+n*0.0005（n为珍兽等级）
--单位快乐度价值：0.373+0.44*n（n为珍兽等级）
function x311111_CalcMoney_ha( sceneId, selfId, petHid, petLid )
	local lv	= LuaFnGetPetLevelByGUID( sceneId, selfId, petHid, petLid )
	local	ha	= 100 - LuaFnGetPetHappiness( sceneId, selfId, petHid, petLid )
	if ha <= 0 then
		return 0
	end

	local	gld	= floor( ( 0.373+lv*0.44 ) * ha )
	if gld < 1 then
		gld			= 1
	end
	return gld
end

--**********************************
--醒目提示
--**********************************
function x311111_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
