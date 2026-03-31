--珍兽幻化

x800124_g_ScriptId = 800124
x800124_g_HHD = {30502005,30502006} --珍兽幻化丹
x800124_g_ChangeModelneedMoney = 50000
--灵性1-10的金钱消耗
x800124_g_m_money = { 10000 , 12000 , 14400 ,17280 , 20736,  24883 , 29860 , 35832 ,42998 , 51598}
--灵兽精魂
x800124_g_PetJingHun = {20310116,20310160}
-- 灵性等级对应元宝
x800124_g_YuanBaoCosts = {
	[0] = 298800,
	[1] = 297600,
	[2] = 295600,
	[3] = 292200,
	[4] = 286200,
	[5] = 276000,
	[6] = 260400,
	[7] = 235600,
	[8] = 193400,
	[9] = 129600,
}

--**********************************
--珍兽幻化
--**********************************
function x800124_Pet_HH(sceneId,selfId,hid,lid,bKeepModel)
--	悟性≥5#cfff263未幻灵的#G变异珍兽
--	珍兽宝宝
--	若珍兽#G携带等级≥85#cfff263，则可选择拥有#G特殊的外观#cfff263。
--	对于携带等级≥85的珍兽您也可选择继承原有珍兽外观。
	if hid == nil or lid == nil or bKeepModel == nil then
		return
	end
	--检查珍兽
	local checkPet = LuaFnIsPetAvailableByGUID(sceneId, selfId, hid, lid);
	if not checkPet or checkPet ~= 1 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_1}");
		return
	end
	
	--检查携带等级
	local takeLevel = LuaFnGetPetTakeLevelByGUID(sceneId,selfId,hid,lid)
	if takeLevel < 85 and bKeepModel == 0 then
		return
	end
	
	--是否有珍兽装备
	if LuaFnIsPetHaveEquip(sceneId,selfId,hid,lid) ~= 0 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_2}");
		return
	end
	
	--检查是否已经幻化
	local nGener = LuaFnGetPetGenerationByGUID(sceneId,selfId,hid,lid)
	if nGener >= 100 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_3}");
		return
	end
	
	--检查材料
	local availableItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x800124_g_HHD[1]);
	if not availableItemCount or availableItemCount < 1 then
		availableItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x800124_g_HHD[2]);
		if not availableItemCount or availableItemCount < 1 then
			x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_6}");
			return
		end
	end
	
	--判断珍兽类型
	--首先看看是不是宝宝珍兽 0 宝宝 1 变异 2 成年
	local nPetType = LuaFnGetPetTypeByGUID(sceneId,selfId,hid, lid);
	if nPetType ~= 0 and nPetType ~= 1 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_4}");
		return
	end
	--悟性大于等于5
	local nSavvy = GetPetSavvy(sceneId,selfId,hid,lid);
	if nSavvy < 5 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_4}");
		return
	end
	--执行幻化流程
	local nRet = LuaFnPetDoHoly(sceneId,selfId, hid, lid,bKeepModel);
	if nRet == 1 then
		--
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_8}");
		--给特效
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--上小电视
		local PetName = LuaFnGetPetTransferByGUID( sceneId, selfId, hid, lid )
		local nMsg = format("#{_INFOUSR%s}",GetName(sceneId,selfId)).."#{RC_5}#G"..GetItemName(sceneId,x800124_g_HHD[1]).."#{RC_6}"..format("#{_INFOMSG%s}",PetName).."#{RC_8}"
		AddGlobalCountNews( sceneId,nMsg)
		return
	end
end

--**********************************
--幻化珍兽灵性提升
--**********************************
function x800124_Pet_LXUP(sceneId,selfId,hid,lid)
	if hid == nil or lid == nil then
		return
	end
	--增加15级判断
	if GetLevel(sceneId,selfId) < 15 then
		x800124_NotifyTip( sceneId, selfId, "#{ZSKJT_130717_01}" )
		return
	end
	
	--检查是否已经幻化
	local nGener = LuaFnGetPetGenerationByGUID(sceneId,selfId,hid,lid)
	if nGener < 100 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_13}");
		return
	end
	--灵性检查
	local lingxing = LuaFnGetPetLingxingByGUID(sceneId,selfId,hid,lid)
	if lingxing >= 10 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_14}");
		return
	end
	
	--金钱检查
	local nNeedMoney = x800124_g_m_money[lingxing]
	if nNeedMoney == nil then
		nNeedMoney = x800124_g_m_money[10]
	end
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < nNeedMoney then
        x800124_NotifyTip( sceneId, selfId,  "#{WH_090729_18}" )
        return
	end
	
	--检查材料
	local availableItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x800124_g_PetJingHun[1]);
	if not availableItemCount or availableItemCount < 1 then
		availableItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x800124_g_PetJingHun[2]);
		if not availableItemCount or availableItemCount < 1 then
--			availableItemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x800124_g_PetJingHun[3]);
--			if not availableItemCount or availableItemCount < 1 then
				x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_6}");
				return
--			else
--				--材料扣除
--				LuaFnDelAvailableItem(sceneId, selfId, x800124_g_PetJingHun[3], 1);
--			end
		else
			--材料扣除
			LuaFnDelAvailableItem(sceneId, selfId, x800124_g_PetJingHun[2], 1);
		end
	else
		--材料扣除
		LuaFnDelAvailableItem(sceneId, selfId, x800124_g_PetJingHun[1], 1);
	end
	--金钱扣除
	LuaFnCostMoneyWithPriority( sceneId, selfId, nNeedMoney);
	--执行提升
	local nFinalLevel = LuaFnPetLXUP(sceneId,selfId, hid, lid);
	if nFinalLevel >= 1 then
		--
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_18}"..nFinalLevel.."#{RXZS_090804_19}");
		--给特效
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--上小电视
		local PetName = LuaFnGetPetTransferByGUID( sceneId, selfId, hid, lid )
		local nMsg = format("#{_INFOUSR%s}",GetName(sceneId,selfId)).."#{RC_9}#G"..GetItemName(sceneId,x800124_g_HHD[1]).."#{RC_10}"..format("#{_INFOMSG%s}",PetName).."#{RC_11}"..tostring(nFinalLevel).."#{RC_12}"
		if random(1,2) == 2 then
			nMsg = format("#{_INFOUSR%s}",GetName(sceneId,selfId)).."#{RC_13}#G"..format("#{_INFOMSG%s}",PetName).."#{RC_14}"..GetItemName(sceneId,x800124_g_HHD[1]).."#{RC_15}"..tostring(nFinalLevel).."#{RC_16}"
		end
		AddGlobalCountNews( sceneId,nMsg)
		return
	else
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_17}");
	end
end

--**********************************
--快捷提升灵性
--**********************************
function x800124_Quick_Pet_LXUP(sceneId,selfId,hid,lid)
	if hid == nil or lid == nil then
		return
	end
	--增加15级判断
	if GetLevel(sceneId,selfId) < 15 then
		x800124_NotifyTip( sceneId, selfId, "#{ZSKJT_130717_01}" )
		return
	end
	local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
	--是否出战
	if hid==pgH and lid==pgL then
		x800124_NotifyTip(sceneId,selfId ,"#{ZSKJT_130428_23}")
		return
	end
	--是否加锁
	if LuaFnIsPetLockedByGUID(sceneId, selfId, hid, lid) == 1 then
		x800124_NotifyTip(sceneId,selfId ,"#{ZSKSSJ_081113_06}")
		return
	end
	--检查是否已经幻化
	local nGener = LuaFnGetPetGenerationByGUID(sceneId,selfId,hid,lid)
	if nGener < 100 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_13}");
		return
	end
	--灵性检查
	local lingxing = LuaFnGetPetLingxingByGUID(sceneId,selfId,hid,lid)
	if lingxing >= 10 then
		x800124_NotifyTip(sceneId, selfId, "#{RXZS_090804_14}");
		return
	end
	local nNeedYuanbao = x800124_g_YuanBaoCosts[lingxing]
	local nCurYuanbao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanbao < nNeedYuanbao then
		x800124_NotifyTip(sceneId, selfId, "#{ZSKJT_130428_6}" );
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x800124_NotifyTip(sceneId, selfId, "#{HLYH_160120_34}" );
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,nNeedYuanbao,800124,"Quick_Pet_LXUP",0,0) ~= 1 then
		return
	end
	--直接设置灵性
	LuaFnSetPetLingxingByGUID( sceneId, selfId, hid, lid, 10 )	
	x800106_NotifyTip(sceneId, selfId, "#{ZSKJT_130428_11}" );
	--成功的光效
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0);
	--世界公告
	--ZSKJT_130717_03	#H#{_INFOUSR%s0}#H江湖事务繁多，时间颇为宝贵，便恳请#G苏州（175，240）#R云思儿#H施展#Y灵性快捷提升#H之法，将#{_INFOMSG%s1}#H的灵性直接提升至#G10#H，须臾间珍兽资质大为提升。	
	--ZSKJT_130717_04	#H#{_INFOUSR%s0}#H江湖事务繁多，时间颇为宝贵，便恳请#G楼兰（109，121）#R云兮兮#H施展#Y灵性快捷提升#H之法，将#{_INFOMSG%s1}#H的灵性直接提升至#G10#H，须臾间珍兽资质大为提升。	
	local szPetTrans = LuaFnGetPetTransferByGUID( sceneId, selfId, hid, lid )
	if sceneId == SCENE_LOULAN then
		local strText = ScriptGlobal_Format("#{ZSKJT_130717_04}",GetName(sceneId,selfId),szPetTrans)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	elseif sceneId == SCENE_SUZHOU then
		local strText = ScriptGlobal_Format("#{ZSKJT_130717_03}",GetName(sceneId,selfId),szPetTrans)
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end
end

--**********************************
--购买灵兽精魂
--**********************************
function x800124_PetLingxing_Yuanbao_Pay( sceneId, selfId, nItemId,nCheck )
	if nItemId ~= 20310116 then
		return
	end
	if nCheck == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 800124 )
			UICommand_AddInt( sceneId, nItemId )
			UICommand_AddString(sceneId,"PetLingxing_Yuanbao_Pay")
			--参数
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddString(sceneId,"#{ZSYB_151109_14}")
			
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 255 )	--Server控制弹出的提示框的扩展版 --如果有第二个整形参数，表明有需要关心的NPC
		return
	end
	local nNeedYuanbao = 100 --灵兽精魂固定价格，这里偷个懒，先把功能完成了
	local nCurYuanbao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanbao < nNeedYuanbao then
		x800124_NotifyTip(sceneId, selfId, "#{ZSYB_151109_03}" );
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x800124_NotifyTip(sceneId, selfId, "#{ZSYB_151109_11}" );
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,nNeedYuanbao,800124,"PetLingxing_Yuanbao_Pay",20310116,1) ~= 1 then
		return
	end
	TryRecieveItem( sceneId, selfId, 20310116, QUALITY_MUST_BE_CHANGE )
	LuaFnSendShopBuySuccessMsg(sceneId,selfId,20310116,1)
	x800124_NotifyTip(sceneId, selfId, "#{ZSYB_151109_13}" );
end

--**********************************
--醒目提示
--**********************************
function x800124_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
