
--脚本邮件的脚本文件

--脚本号
x888889_g_scriptId = 888889


function x888889_ExecuteMail( sceneId, selfId, param0, param1, param2, param3, param4 )

	--CallScriptFunction(DEBUGHOOK_SCRIPT, "DebugBegin", sceneId)	
	if param0 == MAIL_REPUDIATE then
		x888889_Mail_Repudiate( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_BETRAYMASTER then
		x888889_Mail_BetrayMaster( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_EXPELPRENTICE then
		x888889_Mail_ExpelPrentice( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_UPDATE_ATTR then
		LuaFnUpdateAttr(sceneId, selfId, param0, param1, param2, param3)
	elseif param0 == MAIL_UNSWEAR then
		x888889_Mail_Unswear(sceneId, selfId, param0, param1, param2, param3)
	elseif param0 == MAIL_PRENTICE_EXP then
		x888889_Mail_PrenticeProfExp(sceneId, selfId, param0, param1, param2, param3)
	elseif param0 == MAIL_COMMISIONSHOP then
		x888889_Mail_CommisionShop( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_HUASHANJIANGLI then
		x888889_Mail_HuaShanJiangLi( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_SHITUPRIZE then
		x888889_Mail_ShiTuPrize( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_SHITUPRIZE_GOODBAD then
		x888889_Mail_Prize_ExpAndGoodBad( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MIAL_SHITU_CHUSHI then
		x888889_Mail_ShiTuChuShi( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_FINDFRIEND_DELINFO then
		x888889_FindFriendDelInfo( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_YBMARKET_MAIL then
		x888889_Mail_YbMarketMail( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_QIXITOPLIST_MAIL then
		x888889_Mail_QixiTopList( sceneId, selfId, param0, param1, param2, param3 )
	elseif param0 == MAIL_PLAYERSHOP_SALEOUT then
		x888889_Mail_PlayerShopSaleOut( sceneId, selfId, param1, param2, param3 )
	elseif param0 == MAIL_BINGXINGSIXIANG then
--		x888889_Mail_NewRaidPrize( sceneId, selfId, param1, param2, param3 )
	elseif param0 == MAIL_FASHION_AUCTION then
		x888889_Mail_FashionAuctionOp( sceneId, selfId, param1, param2, param3,param4 )
	elseif param0 == MAIL_FASHION_AUCTION_OVER then
		x888889_Mail_FashionAuctionOver( sceneId, selfId, param1, param2, param3 )
	elseif param0 == MAIL_FASHION_AUCTION_GET then
		x888889_Mail_FashionAuctionGet( sceneId, selfId, param1, param2, param3 )
	elseif param0 == MAIL_FASHION_AUCTION_PRIZE then
		x888889_Mail_FashionAuctionPrize( sceneId, selfId, param1, param2, param3 )	
	end


	--CallScriptFunction(DEBUGHOOK_SCRIPT, "DebugEnd", sceneId)

end


--点击NPC没有请求特殊类型可执行邮件提示信息
--没找到
function x888889_NoScriptTypeMail( sceneId, selfId, scripttype)

	if scripttype == MAIL_COMMISIONSHOP then
		x888889_NotifyFailBox( sceneId, selfId, -1, "    对不起，您当前没有可收取的元宝或金币。" )
	elseif scripttype == MAIL_SHITUPRIZE then
		x888889_NotifyFailBox( sceneId, selfId, -1, "    你没有奖券可以领取，快去督促你的徒弟好好升级吧！" )
	elseif scripttype == MAIL_HUASHANJIANGLI then
		x888889_NotifySystemMsg( sceneId, selfId, "#{HSLJ20080221_01}")
	elseif scripttype == MAIL_PLAYERSHOP_SALEOUT then
		x888889_NotifySystemMsg( sceneId, selfId, "#{WJSD_110124_2}")
	elseif scripttype == MAIL_BINGXINGSIXIANG then
--		x888889_NotifySystemMsg( sceneId, selfId, "#{XSLDZ_210128_11}")
--		x888889_NotifyFailBox( sceneId, selfId, -1, "#{XSLDZ_210128_10}" )
	elseif scripttype == MAIL_FASHION_AUCTION_PRIZE then
		--SZPM_230913_33	您当前没有可领取的拍品。	
		x888889_NotifySystemMsg( sceneId, selfId, "#{SZPM_230913_33}")
	end
end

--找到了
function x888889_FindScriptTypeMail( sceneId, selfId, scripttype)

	if scripttype == MAIL_COMMISIONSHOP then
		x888889_NotifyFailBox( sceneId, selfId, -1, "    您的元宝和金币已经成功收取，请查收邮件。" )
	elseif scripttype == MAIL_SHITUPRIZE then
		--x888889_NotifyFailBox( sceneId, selfId, -1, "    您的名师抽奖相关的奖品已经成功收取，请查收。" )
	elseif scripttype == MAIL_HUASHANJIANGLI then
		x888889_NotifySystemMsg( sceneId, selfId, "#{HSLJ20080221_02}")
	end
end

--找到了要检查的邮件
function x888889_CheckScriptTypeMailFind( sceneId, selfId, scripttype)
	--时装拍卖行
	if scripttype == MAIL_FASHION_AUCTION_PRIZE then
		--更新主页面UI
		BeginUICommand( sceneId )
		local nCurYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO)
		if nCurYuanBao > 0 then
			UICommand_AddInt( sceneId, 1)
		else
			UICommand_AddInt( sceneId, 0)
		end
		UICommand_AddInt( sceneId, 1)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881801 )
	end
end

--没找到要检查的邮件
function x888889_NoScriptTypeMailCheck( sceneId, selfId, scripttype)
	if scripttype == MAIL_FASHION_AUCTION_PRIZE then
		--更新主页面UI
		BeginUICommand( sceneId )
		local nCurYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO)
		if nCurYuanBao > 0 then
			UICommand_AddInt( sceneId, 1)
		else
			UICommand_AddInt( sceneId, 0)
		end
		UICommand_AddInt( sceneId, 0)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881801 )
	end
end

--事件列表提示
function x888889_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--七夕排行榜脚本邮件
function x888889_Mail_QixiTopList( sceneId, selfId, nTopListId, nRank, isSendTopList, param3 )
	--nTopListId:
	local mailStr = ""
	if nTopListId == 0 then
		--0 花序榜·步花间
		if isSendTopList == 1 then
			if nRank == 1 then
				mailStr = "#{QXHB_20210701_56}"
			elseif nRank == 2 then
				mailStr = "#{QXHB_20210701_57}"
			elseif nRank == 3 then
				mailStr = "#{QXHB_20210701_58}"
			elseif nRank >= 4 and nRank <= 10 then
				--根据实际情况调整
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_59}",tostring(nRank) )
			else
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_60}",tostring(nRank) )
			end
		else
			if nRank == 1 then
				mailStr = "#{QXHB_20210701_234}"
			elseif nRank == 2 then
				mailStr = "#{QXHB_20210701_235}"
			elseif nRank == 3 then
				mailStr = "#{QXHB_20210701_236}"
			elseif nRank >= 4 and nRank <= 10 then
				--根据实际情况调整
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_237}",tostring(nRank) )
			else
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_238}",tostring(nRank) )
			end
		end
	elseif nTopListId == 1 then
		--1 花序榜·鸳鸯梦
		if isSendTopList == 1 then
			if nRank == 1 then
				mailStr = "#{QXHB_20210701_72}"
			elseif nRank == 2 then
				mailStr = "#{QXHB_20210701_73}"
			elseif nRank == 3 then
				mailStr = "#{QXHB_20210701_74}"
			elseif nRank >= 4 and nRank <= 10 then
				--根据实际情况调整
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_75}",tostring(nRank) )
			else
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_76}",tostring(nRank) )
			end
		else
			if nRank == 1 then
				mailStr = "#{QXHB_20210701_250}"
			elseif nRank == 2 then
				mailStr = "#{QXHB_20210701_251}"
			elseif nRank == 3 then
				mailStr = "#{QXHB_20210701_252}"
			elseif nRank >= 4 and nRank <= 10 then
				--根据实际情况调整
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_253}",tostring(nRank) )
			else
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_254}",tostring(nRank) )
			end
		end
	elseif nTopListId == 2 then
		--2 花序榜·醉花阴
		if isSendTopList == 1 then
			if nRank == 1 then
				mailStr = "#{QXHB_20210701_64}"
			elseif nRank == 2 then
				mailStr = "#{QXHB_20210701_65}"
			elseif nRank == 3 then
				mailStr = "#{QXHB_20210701_66}"
			elseif nRank >= 4 and nRank <= 10 then
				--根据实际情况调整
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_67}",tostring(nRank) )
			else
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_68}",tostring(nRank) )
			end
		else
			if nRank == 1 then
				mailStr = "#{QXHB_20210701_242}"
			elseif nRank == 2 then
				mailStr = "#{QXHB_20210701_243}"
			elseif nRank == 3 then
				mailStr = "#{QXHB_20210701_244}"
			elseif nRank >= 4 and nRank <= 10 then
				--根据实际情况调整
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_245}",tostring(nRank) )
			else
				mailStr = ScriptGlobal_Format( "#{QXHB_20210701_246}",tostring(nRank) )
			end
		end
	end
	
	LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
	
end

--玩家商店盘出收益
function x888889_Mail_PlayerShopSaleOut(sceneId, selfId, bSaleType, uShopPrice, buyGUID)
	if bSaleType == 0 then
		--金币盘出
		AddMoney( sceneId, selfId, uShopPrice );
		x888889_NotifySystemMsg( sceneId, selfId, ScriptGlobal_Format( "#{WJSD_110124_4}",tostring(uShopPrice) ))
	elseif bSaleType == 1 then
		--元宝盘出
		YuanBao(sceneId,selfId,selfId,1,uShopPrice)
		x888889_NotifySystemMsg( sceneId, selfId, ScriptGlobal_Format( "#{DPPC_150327_17}",tostring(uShopPrice) ))
	end
end

--设置徒弟出师
function x888889_Mail_ShiTuChuShi( sceneId, selfId, command, PrenticeGuid, zero )
	
	--开除徒弟
	LuaFnExpelPrentice( sceneId, selfId, PrenticeGuid )
	--LuaFnShiTuChuShi( sceneId, selfId,PrenticeGuid )
end



--徒弟给师傅经验和善恶值
function x888889_Mail_Prize_ExpAndGoodBad( sceneId, selfId, command, PrenticeGuid, Exps, GoodBad )
	--PrenticeGuid给了selfId，Exps这么多经验
	if Exps > 0 then
		LuaAddPrenticeProExp( sceneId, selfId, PrenticeGuid, Exps )
	end
	
	--给师傅添加善恶值
	if GoodBad > 0 then
		local gb_value = LuaFnGetHumanGoodBadValue( sceneId, selfId )
		LuaFnSetHumanGoodBadValue( sceneId, selfId, gb_value + GoodBad )
	end
end

--徒弟给师傅经验
function x888889_Mail_PrenticeProfExp( sceneId, selfId, command, PrenticeGuid, Exps, zero )
	--PrenticeGuid给了selfId，Exps这么多经验
	if Exps > 0 then
		LuaAddPrenticeProExp( sceneId, selfId, PrenticeGuid, Exps )
	end
end

function x888889_Mail_Unswear( sceneId, selfId, command, betrayerGuid, alldismiss, zero )

	--(1) 降低好友度
	local FriendPoint = LuaFnGetFriendPointByGUID( sceneId, selfId, betrayerGuid )
	if FriendPoint > 500 then
		LuaFnSetFriendPointByGUID( sceneId, selfId, betrayerGuid, 500 )
	end

	--(2) 取消结拜
	LuaFnUnswear( sceneId, selfId, betrayerGuid )

	--(3) 如果全部解散，则删除称号
	if tonumber(alldismiss) == 1 then
		AwardJieBaiTitle( sceneId, selfId, "" )
		DispatchAllTitle( sceneId, selfId )
	end
end

function x888889_Mail_Repudiate( sceneId, selfId, param0, param1, param2, param3 )
	if not param1 or param1 == -1 then
		return
	end

	if param1 < 0 then
		param1 = 4294967296 + param1
	end

	SpouseGUID = LuaFnGetSpouseGUID( sceneId, selfId )

	-- 如果不是相同的 GUID 则不进行强制离婚处理
	if param1 ~= 0 and param1 ~= SpouseGUID then
		return
	end

	--删除称号；
	LuaFnAwardSpouseTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--删除婚姻技能
	Skills = {260, 261, 262, 263, 264, 265, 266, 267, 268 }
	for i, skillId in Skills do
		DelSkill( sceneId, selfId, skillId )
	end
	
	NewSkill = { 250, 251, 252, 253, 254, 255, 256, 257, 258, 259 }
	for _, skillId in NewSkill do
		DelSkill( sceneId, selfId, skillId )
	end
	
	--删除形影不离技能
	for _, skillId in { 269,270,271,272,273 } do
		DelSkill( sceneId, selfId, skillId )
	end

	--增加金钱N=100000做为补偿；
--LuaFnAddMoney( sceneId, selfId, 100000 )

	--增加一个物品相思糖做为补偿；（如果空间够，不够算了）
--LuaFnBeginAddItem( sceneId )
--LuaFnAddItem( sceneId, 30002002, 1 )
--ret = LuaFnEndAddItem( sceneId, selfId )
--if ret == 1 then
--	LuaFnAddItemListToHuman( sceneId, selfId )
--end

	--和对方的好友度设置成N=X（10）
	LuaFnSetFriendPointByGUID( sceneId, selfId, SpouseGUID, 10 )

	CallScriptFunction(250036, "OnAbandon", sceneId, selfId);
	CallScriptFunction(250037, "OnAbandon", sceneId, selfId);

	--删除结婚状态；
	LuaFnDivorce( sceneId, selfId )

end

function x888889_Mail_BetrayMaster( sceneId, selfId, param0, param1, param2, param3 )
	--开除徒弟
	LuaFnExpelPrentice( sceneId, selfId, param1 )
end

function x888889_Mail_ExpelPrentice( sceneId, selfId, param0, param1, param2, param3 )
	--删除徒弟称号
	AwardShiTuTitle( sceneId, selfId, "" )
	DispatchAllTitle( sceneId, selfId )

	--离开师门
	LuaFnBetrayMaster( sceneId, selfId )
end

function x888889_Mail_CommisionShop( sceneId, selfId, param0, param1, param2, param3 )

	--CSOP1 ~ CSOP8
	--1.寄售元宝     -- 元宝减少
	--2.购买元宝     -- 元宝增加，金钱减少
	--3.寄售元宝卖出 -- 金钱增加
	--4.寄售元宝退还 -- 元宝增加
	--5.寄售金钱     -- 金钱减少
	--6.购买金钱     -- 元宝减少，金钱增加
	--7.寄售金钱卖出 -- 元宝增加
	--8.寄售金钱退还 -- 金钱增加	

	if param1 == 1 then									-- 退回寄售金钱
		-- param2 是序列号
		-- param3 是数量
		local ret = CSAddBankMoney( sceneId, selfId, param3, "CSOP8" )
		local strAppend = ""
		if ret == 0 then
			return
		else
			if ret == 1 then
				strAppend = ""
			elseif ret == 2 then
				strAppend = "#{Mail_TooMuchMoney}"
			end
		end

		local mailStr = format( "您寄售的#{_MONEY%d}到期没有售出，返还的金钱已经存到了您的银行户头。%s", param3, strAppend )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Recvback type:1 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	elseif param1 == 0 then								-- 退回寄售元宝
		-- param2 是序列号
		-- param3 是数量
		CSAddYuanbao( sceneId, selfId, param3, "CSOP4" )
		local mailStr = format( "您寄售的%d点元宝到期没有售出，商店已经将点数返还给您。", param3 )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Recvback type:0 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	elseif param1 == 2 then								-- 发送寄售金钱
		-- param2 是序列号
		-- param3 是数量
		local ret = CSAddBankMoney( sceneId, selfId, param3, "CSOP3" )
		local strAppend = ""
		if ret == 0 then
			return
		else
			if ret == 1 then
				strAppend = ""
			elseif ret == 2 then
				strAppend = "#{Mail_TooMuchMoney}"
			end
		end

		local mailStr = format( "您寄售的元宝成功地售出，您获得的#{_MONEY%d}已经存入您的银行户头。%s", param3, strAppend )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Gain type:1 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	elseif param1 == 3 then								-- 发送寄售元宝
		-- param2 是序列号
		-- param3 是数量
		CSAddYuanbao( sceneId, selfId, param3, "CSOP7" )
		local mailStr = format( "您寄售的金钱成功地售出，您获得的%d点元宝已经加到您身上。", param3 )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local logStr = format( "Gain type:0 sn:%d value:%d", param2, param3 )
		LogCommisionDeal( sceneId, selfId, logStr )
	end
	
	--调整人物的寄售数量
	DecCommisionNum(sceneId,selfId)
end

function x888889_Mail_HuaShanJiangLi( sceneId, selfId, param0, param1, param2, param3 )
	-- PrintStr(GetName(sceneId, selfId))
	-- PrintNum(param1)
	-- PrintNum(param2)
	-- PrintNum(param3)
	local strLogCheck = ""
	if param2 == 1 then
		if param3 == 1 then			
			-- PrintStr(GetName(sceneId, selfId))
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 1 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
			
			strLogCheck = format(	"HuaShanLunJian_MissionData    FULL_NO.1=(id=%X, Param01=%d, Param02=%d, Param03=%d, Param04=%d)", LuaFnGetGUID(sceneId, selfId), 0, 0, 1, param1 )
			LuaFnLogCheck(strLogCheck)
			-- local	mailStr = "恭喜您获得本届华山论剑总积分第一名!您可以找华山论剑主持人苏剑岭（苏州193，138）领取丰厚奖励!注意：领取时间为1个小时，您如果超过1个小时仍没有领取奖励的话就只能下次再加油咯!"
			-- LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		elseif param3 == 2 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 0 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
			
			strLogCheck = format(	"HuaShanLunJian_MissionData    FULL_NO.2=(id=%X, Param01=%d, Param02=%d, Param03=%d, Param04=%d)", LuaFnGetGUID(sceneId, selfId), 0, 1, 0, param1 )
			LuaFnLogCheck(strLogCheck)
			-- local	mailStr = "恭喜您获得本届华山论剑总积分第二名!您可以找华山论剑主持人苏剑岭（苏州193，138）领取丰厚奖励!注意：领取时间为1个小时，您如果超过1个小时仍没有领取奖励的话就只能下次再加油咯!"
			-- LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		elseif param3 == 3 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 1 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
			
			strLogCheck = format(	"HuaShanLunJian_MissionData    FULL_NO.3=(id=%X, Param01=%d, Param02=%d, Param03=%d, Param04=%d)", LuaFnGetGUID(sceneId, selfId), 0, 1, 1, param1 )
			LuaFnLogCheck(strLogCheck)
			-- local	mailStr = "恭喜您获得本届华山论剑总积分第三名!您可以找华山论剑主持人苏剑岭（苏州193，138）领取丰厚奖励!注意：领取时间为1个小时，您如果超过1个小时仍没有领取奖励的话就只能下次再加油咯!"
			-- LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		end
	elseif param2 == 2 then
		if param3 == 1 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 0 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
			
			strLogCheck = format(	"HuaShanLunJian_MissionData    MenPai_NO.1=(id=%X, Param01=%d, Param02=%d, Param03=%d, Param04=%d)", LuaFnGetGUID(sceneId, selfId), 1, 0, 0, param1 )
			LuaFnLogCheck(strLogCheck)
			-- local	mailStr = "恭喜您获得本届华山论剑本门派第一名! 您可以找华山论剑主持人苏剑岭（苏州193，138）领取丰厚奖励! 注意：领取时间为1个小时，您如果超过1个小时仍没有领取奖励的话就只能下次再加油咯!"
			-- LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		elseif param3 == 2 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 0 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 1 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
			
			strLogCheck = format(	"HuaShanLunJian_MissionData    MenPai_NO.2=(id=%X, Param01=%d, Param02=%d, Param03=%d, Param04=%d)", LuaFnGetGUID(sceneId, selfId), 1, 0, 1, param1 )
			LuaFnLogCheck(strLogCheck)
			-- local	mailStr = "恭喜您获得本届华山论剑本门派第二名! 您可以找华山论剑主持人苏剑岭（苏州193，138）领取丰厚奖励! 注意：领取时间为1个小时，您如果超过1个小时仍没有领取奖励的话就只能下次再加油咯!"
			-- LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		elseif param3 == 3 then
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli01, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli02, 1 )
			SetMissionFlag( sceneId, selfId, MF_LunjianJiangli03, 0 )
			SetMissionData( sceneId, selfId, MD_HUASHANJIANGLI_TIME, param1 )
			
			strLogCheck = format(	"HuaShanLunJian_MissionData    MenPai_NO.3=(id=%X, Param01=%d, Param02=%d, Param03=%d, Param04=%d)", LuaFnGetGUID(sceneId, selfId), 1, 1, 0, param1 )
			LuaFnLogCheck(strLogCheck)
			-- local	mailStr = "恭喜您获得本届华山论剑本门派第三名! 您可以找华山论剑主持人苏剑岭（苏州193，138）领取丰厚奖励! 注意：领取时间为1个小时，您如果超过1个小时仍没有领取奖励的话就只能下次再加油咯!"
			-- LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		end	
	end
end

function x888889_Mail_ShiTuPrize( sceneId, selfId, param0, param1, param2, param3 )
	local plevel = param1
	--9999,高两位为50级的领取次数,低两位99为40级的领取次数
	local ct = GetMissionData(sceneId, selfId, MD_SHITU_PRIZE_COUNT)
	local c40 = mod(ct,100)
	local c50 = floor(ct/100)

	--领取次数检查
	if 40 == plevel then
		if 10 < c40+1 then
			x888889_NotifySystemMsg(sceneId,selfId,"领取名师奖券失败，已经达到上限。")
			return
		end
	elseif 50 == plevel then
		if 10 < c50+1 then
			x888889_NotifySystemMsg(sceneId,selfId,"领取特级名师奖券失败，已经达到上限。")
			return
		end
	end

	--领取奖励
	local itemId = param2
	local itemNum = param3
	
	LuaFnBeginAddItem( sceneId )
		LuaFnAddItem( sceneId, itemId, itemNum)
	local ret = LuaFnEndAddItem( sceneId, selfId )
	if 1 == ret then
		--添加物品
		AddItemListToHuman(sceneId,selfId)
		x888889_NotifySystemMsg(sceneId,selfId,"领取奖券成功")
		--在抽奖日志中记录....
		--日志编号，玩家GUID，玩家名字，奖券物品ID
		local logstr = format("PL:%d,0x%X,%s,%d",
									 				PRIZE_LOG_XINSHOUSHITU,
									 				LuaFnGetGUID(sceneId,selfId),
									 				GetName(sceneId,selfId),
									 				itemId)
		LuaFnLogPrize(logstr)
	else
		x888889_NotifySystemMsg(sceneId,selfId,"没有足够的任务道具栏空间，领取失败")
		return
	end
	
	--领取奖励后修改领取次数
	if 40 == plevel then
		SetMissionData( sceneId, selfId, MD_SHITU_PRIZE_COUNT, ct+1)
	elseif 50 == plevel then
		SetMissionData( sceneId, selfId, MD_SHITU_PRIZE_COUNT, (c50+1)*100+c40)
	end
end

--元宝交易市场物品销毁补录元宝
function x888889_Mail_YbMarketMail( sceneId, selfId, param0, param1, param2, param3 )
	local opType = param1
	local iUnitData = param2	--物品ID或宠物DataID
	local iYuanBaoCount = param3
	--1.商品过期下架
	--2.商品过期被自动删除
	--3.售出商品超过7天未取
	--4.商品被成功卖出
	--5.成功充入元宝
	
	if opType == 1 then
		--YBSC_MAIL_2	#Y亲爱的玩家：#W#r #r    您售价#G%s0元宝#W的#Y%s1#W在48小时内未售出，请及时到#G钱庄（61，29）#R孙聚财#W处取回未售出的商品。	
		local itemName = ""
		if iUnitData > 10000000 then
			itemName = GetItemName(sceneId,iUnitData)
		else
			itemName = GetPetName(iUnitData)
		end
		local mailStr = ScriptGlobal_Format( "#{YBSC_MAIL_2}", tostring(iYuanBaoCount),itemName )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
	elseif opType == 2 then
		--YBSC_100111_60	#Y亲爱的玩家：#W#r #r    您在元宝交易市场出售的商品#Y%s0#W由于过期下架后长期没有认领，已经被系统删除！	
		local itemName = ""
		if iUnitData > 10000000 then
			itemName = GetItemName(sceneId,iUnitData)
		else
			itemName = GetPetName(iUnitData)
		end
		local mailStr = ScriptGlobal_Format( "#{YBSC_100111_60}",itemName )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
	elseif opType == 3 then
		--YBSC_100111_59	#Y亲爱的玩家：#W#r #r    您在元宝交易市场出售商品获得的#G%s0元宝#W长期没有认领，现请到#G钱庄（61，29）#R孙聚财#W处点击补收元宝认领！	
		local mailStr = ScriptGlobal_Format( "#{YBSC_100111_59}",tostring(iYuanBaoCount) )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
		local nCurYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_YBMARKET_CANBUSHOUCOUNT)
		SetMissionDataEx(sceneId,selfId,MDEX_YBMARKET_CANBUSHOUCOUNT,nCurYuanBao + iYuanBaoCount)
		
		local logstr = format("Auction:Op=%d,GUID=0x%X,Name=%s,CurBushou=%d,AddBushou=%d",
									 				opType,
									 				LuaFnGetGUID(sceneId,selfId),
									 				GetName(sceneId,selfId),
									 				nCurYuanBao,iYuanBaoCount)
		LogAuctionDeal(logstr)
	elseif opType == 4 then
		--YBSC_MAIL_1	#Y亲爱的玩家：#W#r #r    您售价#G%s0元宝#W的#Y%s1#W已售出，请及时到#G钱庄（61，29）#R孙聚财#W处收取元宝。点击#G管理我出售的商品#W打开管理界面即可收取元宝。	
		local itemName = ""
		if iUnitData > 10000000 then
			itemName = GetItemName(sceneId,iUnitData)
		else
			itemName = GetPetName(iUnitData)
		end
		local mailStr = ScriptGlobal_Format( "#{YBSC_MAIL_1}", tostring(iYuanBaoCount),itemName )
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
	--elseif opType == 5 then
		--这里貌似不需要这个逻辑
		--YBSC_MAIL_3	#Y亲爱的玩家：#W#r #r    您出售#Y%s0#W所得#G%s1元宝#W已经冲入您的账户，请打开背包查收！	
		
	end
	
end

function x888889_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


function x888889_FindFriendDelInfo( sceneId, selfId, param0, param1, param2, param3 )
	local nADType = param1
	local nDelInfoTime = param2
	
	if nADType > 4 or nADType < 1 then
		return
	end
	
	if nADType == 1 then
		SetMissionData(sceneId, selfId, MD_FINDFRIENDAD_DELTIME_MARRY, nDelInfoTime)
	elseif nADType == 2 then
		SetMissionData(sceneId, selfId, MD_FINDFRIENDAD_DELTIME_GUILD, nDelInfoTime)
	elseif nADType == 3 then
		SetMissionData(sceneId, selfId, MD_FINDFRIENDAD_DELTIME_TEACHER, nDelInfoTime)
	elseif nADType == 4 then
		SetMissionData(sceneId, selfId, MD_FINDFRIENDAD_DELTIME_BROTHER, nDelInfoTime)
	end
	
	Audit_FindFriendAD_DelInfo(sceneId, selfId, nADType)

end
--时装竞拍系统操作
function x888889_Mail_FashionAuctionOp( sceneId, selfId, param1, param2, param3, param4 )
	local opType = param1
	--出价成功
	if opType == 1 then
		--SZPM_230913_77	出价成功，您已成为当前最高竞价。
		x888889_NotifySystemMsg(sceneId,selfId,"#{SZPM_230913_77}")		
		--刷新客户端
		LuaFnTryFashionAuctionBid(sceneId,selfId,1,param2,param3,0)
	elseif opType == 2 then
	--数据版本落后了 param2:price
		--SZPM_230913_76	其他侠士已抢先出价，请在界面刷新后重新出价。
		x888889_NotifySystemMsg(sceneId,selfId,"#{SZPM_230913_76}")
		--返还元宝
		YuanBao(sceneId,selfId,-1,1,param2)
	end
end
--时装拍卖行出价被超过
function x888889_Mail_FashionAuctionOver( sceneId, selfId, param1, param2, param3 )
	--SZBH_231103_20	#Y金阙:%s0号	
	local nSpecialCode = LuaFnGetNumberingFashionCode(param1)
	local strSpecialCode = ScriptGlobal_Format("#{SZBH_231103_20}",tostring(nSpecialCode))
	
	--param1 itemid, param2 itemnum, param3 price
	local strItemName = GetItemName(sceneId,param1)
	local ybOp = YuanBao(sceneId,selfId,-1,1,param3)
	--元宝成功增加
	if ybOp == 0 then
		x888889_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{SZPM_230913_78}",tostring(param2),strItemName,strSpecialCode,tostring(param3)))
		local mailStr = ScriptGlobal_Format("#{SZPM_230913_80}",tostring(param2),strItemName,strSpecialCode,tostring(param3))
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
	else
		--增加如后备可兑换数量
		local nCurYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO)
		SetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO,nCurYuanBao + param3)
		
		x888889_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{SZPM_230913_79}",tostring(param2),strItemName,strSpecialCode))
		local mailStr = ScriptGlobal_Format("#{SZPM_230913_81}",tostring(param2),strItemName,strSpecialCode)
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
	end
	--您的出价已被其他侠士超过，请及时查看。
	x888889_NotifySystemMsg(sceneId,selfId,"#{SZPM_230913_82}")
end
--成为最终拍卖归属玩家
function x888889_Mail_FashionAuctionGet( sceneId, selfId, param1, param2, param3 )
	--SZBH_231103_20	#Y金阙:%s0号	
	local nSpecialCode = LuaFnGetNumberingFashionCode(param1)
	local strSpecialCode = ScriptGlobal_Format("#{SZBH_231103_20}",tostring(nSpecialCode))
	
	--param1 itemid, param2 itemnum, param3 price
	local strItemName = GetItemName(sceneId,param1)
	local mailStr = ScriptGlobal_Format("#{SZPM_230913_83}",
		tostring(LuaFnGetThisMonth() + 1),
		tostring(LuaFnGetDayOfThisMonth()),
		tostring(param3),
		tostring(param2),
		strItemName,
		strSpecialCode)
	LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), mailStr )
end
--领取拍品
function x888889_Mail_FashionAuctionPrize( sceneId, selfId, param1, param2, param3 )
	local strItemName = GetItemName(sceneId,param1)
	LuaFnBeginAddItem( sceneId )
	LuaFnAddItem( sceneId, param1, param2)
	local ret = LuaFnEndAddItem( sceneId, selfId )
	if 1 == ret then
		--添加物品
		AddItemListToHuman(sceneId,selfId)
		x888889_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{SZPM_230913_34}",tostring(param2),strItemName))
	else
		x888889_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{SZPM_230913_35}",tostring(param2)))
		--重新发送回去
		LuaFnSendScriptMail(sceneId,GetName(sceneId,selfId),MAIL_FASHION_AUCTION_PRIZE,param1, param2, param3)
	end
end
