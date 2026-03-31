--月卡主脚本

--脚本号
x892666_g_scriptId = 892666
--月卡有效期
x892666_g_LifeTime = 30 * 24 * 60 * 60
--允许使用的最低等级
x892666_g_MinLevel = 15
--月卡ID
x892666_g_YueKaItemID = 38000205
--赠与的绑定元宝
x892666_g_SendBindYB = 688
--**********************************
--客户端请求逻辑
--**********************************
function x892666_DoFunc( sceneId, selfId, nLogicId )
	if GetLevel(sceneId,selfId) < x892666_g_MinLevel then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_16}")
		return
	end
	--尚未激活御龙帖功能或功能已失效
	if x892666_InLifeTime(sceneId,selfId) == 0 then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_17}")
		return
	end
	--地府不允许使用
	if sceneId == SCENE_DIFU then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_46}")
		return
	end
--	x892666_NotifyTips(sceneId, selfId, "nLogicId:"..nLogicId)
	
	--冻结解冻双倍经验
	if nLogicId == 1 then
		x892666_OnOpDETime(sceneId,selfId)
		return
	end
	--随身珍兽商店
	if nLogicId == 2 then
		--最后一个参数为1则忽略场景限制，空或0则依然需要验证
		DispatchNoNpcShopItem( sceneId, selfId, 17 , 1 )
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_25}")
		return
	end
	--随身银行
	if nLogicId == 3 then
		BankBegin(sceneId, selfId, selfId)
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_26}")
		return
	end
	--随身装备修理
	if nLogicId == 4 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, selfId )
			UICommand_AddInt( sceneId, -1 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 19810313 )
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_29}")
		return
	end
	--增加装备可修理次数
	if nLogicId == 5 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,-1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1004)
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_30}")
		return
	end
	--延长武魂寿命
	if nLogicId == 6 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,-1)
	        UICommand_AddInt(sceneId,3)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090721)
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_31}")
		return
	end
	--随身神器修理
	if nLogicId == 7 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, -1 )
			UICommand_AddInt( sceneId, -1 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 101526358 )
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_33}")
		return
	end
	--随身衣柜【新程序已关闭该功能】
--	if nLogicId == 8 then
--		--打开衣柜
--		LuaFnOpenPlayerFashionDepot(sceneId,selfId,-1)
--	end
	--随身宠物银行
	if nLogicId == 9 then
		--不允许摆摊使用
		if LuaFnIsStalling(sceneId,selfId) == 1 then
			x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_51}")
			return
		end
		--不允许交易使用
		if LuaFnIsExchanging(sceneId,selfId) == 1 then
			x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_52}")
			return
		end
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_53}")
		PetBankBegin(sceneId, selfId, selfId)
	end
end
--**********************************
--冻结解冻双倍经验
--**********************************
function x892666_OnOpDETime(sceneId,selfId)
	local nCurHave = DEGetFreeTime(sceneId, selfId)
	nCurHave = nCurHave + DEGetMoneyTime(sceneId, selfId)
	if nCurHave <= 0 then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_20}")
		return
	end
	-- 先计算下当前玩家身上剩下的时间
	local nTrueTime = nCurHave;
	if nTrueTime < 0 then
		nTrueTime = 0
	end
	if DEIsLock(sceneId, selfId) > 0 then
		--解冻状态
		DESetLock(sceneId, selfId, 0)
		SendDoubleExpToClient(sceneId,selfId)
		x892666_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{HJYK_201223_24}",tostring(floor(nTrueTime/60))))
	else
		--冻结状态
		DESetLock(sceneId, selfId, 1)
		SendDoubleExpToClient(sceneId,selfId)
		x892666_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{HJYK_201223_22}",tostring(floor(nTrueTime/60))))
	end
	
end
--**********************************
--客户端请求打开月卡
--**********************************
function x892666_OnClickOpenBtn(sceneId,selfId)
	if GetLevel(sceneId,selfId) < x892666_g_MinLevel then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_16}")
		return
	end
	--尚未激活御龙帖功能或功能已失效
	if x892666_InLifeTime(sceneId,selfId) == 0 then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_17}")
		return
	end
	--地府不允许使用
	if sceneId == SCENE_DIFU then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_46}")
		return
	end
	local nLifeTime = GetMissionDataEx(sceneId,selfId,MDEX_MONTHCARD_LIFE_TIME)
	local nEndYear,nEndMonth,nEndDay = ConvertAnsiTime2YearMonthDay(nLifeTime)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nEndYear )
		UICommand_AddInt( sceneId, nEndMonth )
		UICommand_AddInt( sceneId, nEndDay )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89266604 )
end

--**********************************
--是否在有效期
--**********************************
function x892666_InLifeTime(sceneId,selfId)
	local nCurTime = LuaFnGetCurrentTime()
	local nLifeTime = GetMissionDataEx(sceneId,selfId,MDEX_MONTHCARD_LIFE_TIME)
	if nCurTime > nLifeTime then
		--过期了
		return 0
	end
	return 1
end
--**********************************
--正式使用月卡
--**********************************
function x892666_OnUseMonthCard( sceneId, selfId, bOk )
	if bOk ~= 1 then
		return
	end
	--判定道具有效与否
	if LuaFnGetItemIndexOfUsedItem(sceneId,selfId) ~= x892666_g_YueKaItemID then
		return
	end
	local nUsePos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId)
	if LuaFnGetItemTableIndexByIndex(sceneId,selfId,nUsePos) ~= x892666_g_YueKaItemID then
		return
	end
	--在期限内不续期
	if x892666_InLifeTime(sceneId,selfId) == 1 then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_03}")
		return
	end
	local nCurBindYuanBao = BindYuanBao(sceneId,selfId,-1,3,0)
	if nCurBindYuanBao + x892666_g_SendBindYB > 200000000 then
		x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_04}")
		return
	end	
	--增加绑定元宝
	BindYuanBao(sceneId,selfId,-1,1,x892666_g_SendBindYB)
	--更新到期时间
	local nCurTime = LuaFnGetCurrentTime()
	SetMissionDataEx(sceneId,selfId,MDEX_MONTHCARD_LIFE_TIME,nCurTime + x892666_g_LifeTime)
	--销毁物品
	local itemInfo = GetBagItemTransfer( sceneId, selfId, nUsePos )
	LuaFnEraseItem(sceneId,selfId,nUsePos);
	--通知使用成功等事宜
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	
	x892666_NotifyTips(sceneId, selfId, "#{HJYK_201223_08}")
	-- 发邮件
	local nEndYear,nEndMonth,nEndDay = ConvertAnsiTime2YearMonthDay(nCurTime + x892666_g_LifeTime)
	local szMailCont = ScriptGlobal_Format("#{HJYK_201223_13}",GetName(sceneId, selfId),nEndYear,nEndMonth,nEndDay);
	LuaFnSendSystemMail( sceneId, GetName(sceneId, selfId), szMailCont )   
	--世界公告
	local szNews = ScriptGlobal_Format("#{HJYK_201223_09}",GetName(sceneId, selfId),itemInfo);
	AddGlobalCountNews( sceneId, szNews )
	--刷新UI
	x892666_OnHumanLogin( sceneId, selfId )
end

--**********************************
--玩家登陆
--**********************************
function x892666_OnHumanLogin( sceneId, selfId )
	if x892666_InLifeTime(sceneId,selfId) == 0 then
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 89266603 )
	else
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 89266602 )
	end
end

--**********************************
-- 信息提示
--**********************************
function x892666_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
	AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
