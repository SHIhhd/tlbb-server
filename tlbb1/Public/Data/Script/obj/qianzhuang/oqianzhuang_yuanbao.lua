--元宝 NPC
--注意本脚本含有随身元宝相关功能，请一定参照现有的例子进行修改。

x181000_g_scriptId 	= 181000
--这里的比例调整是全局性的一定要非常注意，比例只改这里，不允许修改任何其他脚本以防数值错误
--5表示 5/10 = 0.5-> 1:2
x181000_g_buyrate 	= 1
--单次兑换最多元宝
x181000_g_buymaxYuanBao = 20000;

x181000_g_shoptableindex=120
x181000_g_zengdianshop=121

x181000_g_goodact		= 1		--元宝商店
x181000_g_buyact	 	= 2		--兑换元宝
x181000_g_ticketact = 3		--兑换元宝票
--4
--x181000_g_gotodali	= 5		--返回洛阳

x181000_g_newprize	= 17		--查看中奖
x181000_g_YuanBaoIntro	= 18	--元宝介绍

x181000_g_leave			= 20	--离开
x181000_g_return		= 21	--返回(主菜单)

x181000_g_czhl		= 22	--一掷豪礼千金情
x181000_g_czhlDesc		= 23	--关于一掷豪礼千金情
x181000_g_smybsdDesc		= 24	--关于神秘商店
x181000_g_bindybDesc		= 25	--关于绑定元宝
x181000_g_dhybDesc		= 26	--关于点数兑换元宝
x181000_g_qiandingShop	= 27	--乾鼎商会
x181000_g_qiandingDesc 	= 28	--关于乾鼎商会
--花榜特殊入口
x181000_g_TopListSpecialEnter = 29

--**********************************
-- 一掷豪礼千金情奖励物品
--**********************************
x181000_g_TopChongZhi_Gifts = {
	--5级红宝石       3级秘银*5         3级棉布*5       连戎的神节1级*1
	[1] ={
			{GiftItemID = 50513004, num = 1,},{GiftItemID = 20501003, num = 5,},{GiftItemID = 20502003, num = 5,},{GiftItemID = 30505900 , num = 1,}
		,},
	--5级红宝石       3级秘银*5        3级棉布*5        残缺的神节6级
	[2] ={
			{GiftItemID = 50513004, num = 1,},{GiftItemID = 20501003, num = 5,},{GiftItemID = 20502003, num = 5,},{GiftItemID = 30505705, num = 1,}
		,},
	--红宝石5级*1     4级秘银*5        4级秘银*5       饰品身法雕纹图样*1
	[3] ={
			{GiftItemID = 50513004, num = 1,},{GiftItemID = 20501004, num = 5,},{GiftItemID = 20502004, num = 5,},{GiftItemID = 30120003, num = 1,}
		,},
	--高级宝石熔炼*2   4级秘银*5       4级棉布*5       饰品身法雕纹图样*1
	[4] ={
			{GiftItemID = 30900057, num = 2,},{GiftItemID = 20501004, num = 5,},{GiftItemID = 20502004, num = 5,},{GiftItemID = 30120003, num = 1,}
		,},
	-- 高级宝石熔炼*2    4级秘银*10     4级棉布*10         淬火玉*5
	[5] ={
			{GiftItemID = 30900057, num = 2,},{GiftItemID = 20501004, num = 10,},{GiftItemID = 20502004, num = 10,},{GiftItemID = 38003055, num = 5,}
		,},
	--高级宝石熔炼*3      武道丹*100     神魂檀箱*50      护符精绘手记*1   
	[6] ={
			{GiftItemID = 30900057, num = 3,},{GiftItemID = 38002397, num = 100,},{GiftItemID = 38002499, num = 50,},{GiftItemID = 30900213, num = 1,}
		,},
	--时装：金翎昭      武道丹*100      神魂檀箱*50        淬火玉*5
	[7] ={
			{GiftItemID = 10125727, num = 1,},{GiftItemID = 38002397, num = 100,},{GiftItemID = 38002499, num = 50,},{GiftItemID = 38003055, num = 5,}
		,}, 
	--坐骑：赤兔      秀草纹艺匣*1        重楼肩*1     乾鼎商会     
	[8] ={
			{GiftItemID = 10142399, num = 1,},{GiftItemID = 38003160, num = 1,},{GiftItemID = 10415055, num = 1,}
		,}, 
}
--**********************************
-- 一掷豪礼千金情达成要求
--**********************************
x181000_g_TopChongZhi_GetGiftsCondition =
{
	[1] = { Exch = 200000, Cost = 200000, },
	[2] = { Exch = 400000, Cost = 400000, },
	[3] = { Exch = 600000, Cost = 600000, },
	[4] = { Exch = 800000, Cost = 800000, },
	[5] = { Exch = 1000000, Cost = 1000000, },
	[6] = { Exch = 1200000, Cost = 1200000, },
	[7] = { Exch = 1600000, Cost = 1600000, }, 
	[8] = { Exch = 2000000, Cost = 2000000, }, 
}
--**********************************
-- 一掷豪礼千金情领取标记
--**********************************
x181000_g_TopChongZhi_Flag =
{
	[1] = MFEX_TopChongZhiFlag_1,
	[2] = MFEX_TopChongZhiFlag_2,
	[3] = MFEX_TopChongZhiFlag_3,
	[4] = MFEX_TopChongZhiFlag_4,
	[5] = MFEX_TopChongZhiFlag_5,
	[6] = MFEX_TopChongZhiFlag_6,
	[7] = MFEX_TopChongZhiFlag_7,
	[8] = MFEX_TopChongZhiFlag_8,
}
--**********************************
-- 一掷豪礼千金情等级要求
--**********************************
x181000_g_TopChongZhi_MinLevel = 15
--**********************************
-- 一掷豪礼千金情背包格子检测
--**********************************
x181000_g_TopChongZhi_BagSize =
{
	[1] = {1,1},
	[2] = {1,1},
	[3] = {0,2},
	[4] = {1,1},
	[5] = {1,1},
	[6] = {2,1},
	[7] = {2,1},
	[8] = {3,1},
}
--**********************************
--事件交互入口
--**********************************
function x181000_OnDefaultEvent( sceneId, selfId, targetId )	
	BeginEvent( sceneId )
		local strText = "    有钱能使鬼推磨，虽然江湖当中以武力为上，但是有了元宝可能会使原来很多比较难办的事情变得简单起来，您想做些什么呢？"
		AddText( sceneId, strText )
		AddNumText( sceneId, x181000_g_scriptId, "#{CZHL_200916_04}", 2, x181000_g_czhl)
		AddNumText( sceneId, x181000_g_scriptId, "我想购买商品", 2, x181000_g_goodact)
		AddNumText( sceneId, x181000_g_scriptId, "将点数兑换成元宝", 2, x181000_g_buyact)
		if IsEnableYuanBaoPiao() == 1 then
			AddNumText( sceneId, x181000_g_scriptId, "将元宝兑换成元宝票", 2, x181000_g_ticketact)
		end
		AddNumText( sceneId, x181000_g_scriptId, "每日充值", 6, 1994)
		AddNumText( sceneId, x181000_g_scriptId, "#{CZHL_200916_02}", 11, x181000_g_czhlDesc)
		--乾鼎商会
		if GetMissionFlagEx(sceneId,selfId,MFEX_QianDingShangHui) == 1 then
			AddNumText( sceneId, x181000_g_scriptId, "#{CZHL_200916_63}", 7, x181000_g_qiandingShop)
			AddNumText( sceneId, x181000_g_scriptId, "#{CZHL_200916_64}", 11, x181000_g_qiandingDesc)
		end
		AddNumText( sceneId, x181000_g_scriptId, "#{SMYBSD_091102_05}", 11, x181000_g_smybsdDesc)
		AddNumText( sceneId, x181000_g_scriptId, "元宝介绍", 11, x181000_g_YuanBaoIntro)
		AddNumText( sceneId, x181000_g_scriptId, "#{CZSBS_81218_2}", 11, 19)
		AddNumText( sceneId, x181000_g_scriptId, "#{BDYB_090714_03}", 11, x181000_g_bindybDesc)
		AddNumText( sceneId, x181000_g_scriptId, "#{DHYB_xml_XX(01)}", 11, x181000_g_dhybDesc)
--		暂时不使用花榜
--		AddNumText( sceneId, x181000_g_scriptId, "#cfff263#{QXLS_150724_03}", 6, x181000_g_TopListSpecialEnter)
		
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x181000_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == x181000_g_buyact then
		--先询问自己的剩余点数
		CallScriptFunction( PRIZE_SCRIPT_ID, "AskPoint", sceneId, selfId )
		--打开客户端窗口等待程序反馈
		x181000_DispatchYuanbaoExchange(sceneId,selfId,targetId)
		return
	elseif GetNumText() == x181000_g_newprize then
		CallScriptFunction( PRIZE_SCRIPT_ID, "AskPrize", sceneId, selfId)
	elseif GetNumText() == x181000_g_return then
		x181000_OnDefaultEvent( sceneId, selfId, targetId )
	elseif GetNumText() == x181000_g_goodact then
--	新元宝商店
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, 1 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 888902)
	
--	elseif GetNumText() == x181000_g_gotodali then
--		NewWorld(sceneId,selfId,0,200,177)
--
	elseif GetNumText() == x181000_g_ticketact then
		local _yes = LuaFnOpenPWBox(sceneId,selfId);
		if(_yes~=1)then
			local nYuanBao = YuanBao(sceneId,selfId,targetId,3,0)
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 2002 )
		end
	--一掷豪礼千金情
	elseif GetNumText() == x181000_g_czhl then
		x181000_YBCost_OpenWindow(sceneId,selfId,targetId)
	elseif GetNumText() == x181000_g_leave then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )

	elseif GetNumText() == x181000_g_YuanBaoIntro	then
		BeginEvent( sceneId )
			AddText( sceneId, "#{INTRO_YUANBAO}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	
	elseif GetNumText() == 19 then          -- 换元宝送宝石
		BeginEvent( sceneId )
			AddText( sceneId, "#{CZSBS_81218_1}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == x181000_g_czhlDesc then
		BeginEvent( sceneId )
			AddText( sceneId, "#{CZHL_200916_03}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == x181000_g_smybsdDesc then
		BeginEvent( sceneId )
			AddText( sceneId, "#{SMYBSD_091102_03}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == x181000_g_bindybDesc then
		BeginEvent( sceneId )
			AddText( sceneId, "#{BDYB_090824_01}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == x181000_g_dhybDesc then
		BeginEvent( sceneId )
			AddText( sceneId, "#{DHYB_20090728_01}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == x181000_g_qiandingDesc then
		BeginEvent( sceneId )
			AddText( sceneId, "#{CZHL_200916_65}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )	
	elseif GetNumText() == x181000_g_qiandingShop then
		if GetMissionFlagEx(sceneId,selfId,MFEX_QianDingShangHui) ~= 1 then
			x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_66}")
			return
		end
		LuaFnOpenLangYuTianGeShop(sceneId,selfId,targetId)
	elseif GetNumText()==1994 then	
		CallScriptFunction(330083,"OpenPay",sceneId,selfId,1)
--	elseif GetNumText() == x181000_g_TopListSpecialEnter then
--		CallScriptFunction( 891396, "ClientAskQixiTopList", sceneId, selfId, 0)
	end
end

--**********************************
--客户端购买元宝接口
--**********************************
function x181000_BuyYuanbao( sceneId, selfId, nYuanBao )
	if nYuanBao and nYuanBao >= 1200 then
		if LuaFnGetMaterialBagSpace(sceneId, selfId) <= 0 and GetMissionFlag(sceneId, selfId, MF_GEM_PRIZE_FLAG) == 0 then
			x181000_NotifyTip(sceneId,selfId,"#{CZSBS_81218_3}")
			return
		end
	end
	--购买元宝
	if nYuanBao > 0 and nYuanBao <= x181000_g_buymaxYuanBao then
		CallScriptFunction( PRIZE_SCRIPT_ID, "AskYuanBao", sceneId, selfId, nYuanBao, nYuanBao*x181000_g_buyrate/10)
	end
end

--**********************************
--按需来弹出商店，分为随身商店和NPC商店
--**********************************
function x181000_NewDispatchShopItem(sceneId,selfId,targetId,shopId)
	if targetId >= 0 then
		DispatchShopItem( sceneId, selfId,targetId, shopId )
	else
		DispatchNoNpcShopItem( sceneId, selfId, shopId )
	end
end

--**********************************
--按需来弹出兑换窗口
--targetId<=0为随时兑换
--**********************************
function x181000_DispatchYuanbaoExchange(sceneId,selfId,targetId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		UICommand_AddInt( sceneId, x181000_g_buyrate)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 2001 )
end

--**********************************
--客户端请求随身兑换
--**********************************
function x181000_AskOpenDuihuanWindow(sceneId,selfId)
	if sceneId == 0 or sceneId == 1 or sceneId == 2 then
		--仅处于洛阳、苏州、大理时，方可兑换元宝。
		
		--先询问自己的剩余点数
		CallScriptFunction( PRIZE_SCRIPT_ID, "AskPoint", sceneId, selfId )
		--打开客户端窗口等待程序反馈
		x181000_DispatchYuanbaoExchange(sceneId,selfId,0)
	else
		BeginEvent(sceneId);
			AddText(sceneId, "#{DHYB_180524_20}");
		EndEvent(sceneId);
		DispatchMissionTips(sceneId, selfId);
	end
	
end
--**********************************
--一掷豪礼千金情上线喇叭提示
--**********************************
function x181000_YBCost_OnPlayerLogin(sceneId,selfId)
	local aMsgBallTypeId = {50,51,52,53,54,55,56,113}
	local nExchYuanBao = BuyYuanBaoCount(sceneId,selfId,-1,3,0) --查询兑换了多少元宝
	local nCostYuanBao = GetYuanBaoTotalCost(sceneId,selfId) --查询一共消耗了多少元宝
	for i = 1,getn(x181000_g_TopChongZhi_Gifts) do
		local nFlag = GetMissionFlagEx(sceneId,selfId,x181000_g_TopChongZhi_Flag[i])
		if nFlag ~= 1 then
			--未兑换
			if x181000_g_TopChongZhi_GetGiftsCondition[i] ~= nil then
				if nExchYuanBao >= x181000_g_TopChongZhi_GetGiftsCondition[i].Exch
				and nCostYuanBao >=  x181000_g_TopChongZhi_GetGiftsCondition[i].Cost then
					--达到条件
					--消息球
					if aMsgBallTypeId[i] ~= nil then
						DispatchMsgBall(sceneId,selfId,aMsgBallTypeId[i])
					end
				end
			end
		end
	end
	
end
--**********************************
--打开一掷豪礼千金情界面
--**********************************
function x181000_YBCost_OpenWindow(sceneId,selfId,targetId)
	if GetLevel(sceneId,selfId) < x181000_g_TopChongZhi_MinLevel then
		x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_22}" )
		return
	end
	local nExchYuanBao = BuyYuanBaoCount(sceneId,selfId,targetId,3,0) --查询兑换了多少元宝
	local nCostYuanBao = GetYuanBaoTotalCost(sceneId,selfId) --查询一共消耗了多少元宝
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
		UICommand_AddInt(sceneId,nExchYuanBao)
		UICommand_AddInt(sceneId,nCostYuanBao)
		UICommand_AddInt(sceneId,0)
		for i = 1,getn(x181000_g_TopChongZhi_Gifts) do
			local nFlag = GetMissionFlagEx(sceneId,selfId,x181000_g_TopChongZhi_Flag[i])
			if nFlag == 1 then
				UICommand_AddInt(sceneId,2) --兑换数据传输客户端
			else
				if x181000_g_TopChongZhi_GetGiftsCondition[i] ~= nil then
					if nExchYuanBao >= x181000_g_TopChongZhi_GetGiftsCondition[i].Exch
					and nCostYuanBao >=  x181000_g_TopChongZhi_GetGiftsCondition[i].Cost then
						UICommand_AddInt(sceneId,1)
					end
				else
					UICommand_AddInt(sceneId,0)
				end
			end
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,18100001)
end
--**********************************
--一掷豪礼千金情点击领取事件
--**********************************
function x181000_YBCost_GetPrize(sceneId,selfId,targetId,Index)
	--领取成功的屏幕提示
	local YBCost_OKNotify = 
	{
		"#{CZHL_200916_25}","#{CZHL_200916_28}","#{CZHL_200916_32}","#{CZHL_200916_35}",
		"#{CZHL_200916_38}","#{CZHL_200916_41}","#{CZHL_200916_44}","#{CZHL_200916_60}"
	}
	--领取成功的系统提示
	local YBCost_GlobalNews = 
	{
		"#{CZHL_200916_26}","#{CZHL_200916_29}","#{CZHL_200916_33}","#{CZHL_200916_36}",
		"#{CZHL_200916_39}","#{CZHL_200916_42}","#{CZHL_200916_45}","#{CZHL_200916_62}"
	}
	--未达成条件的屏幕提示
	local YBCost_FailNotify = 
	{
		"#{CZHL_200916_23}","#{CZHL_200916_27}","#{CZHL_200916_30}","#{CZHL_200916_34}",
		"#{CZHL_200916_37}","#{CZHL_200916_40}","#{CZHL_200916_43}","#{CZHL_200916_58}"
	}
	--重复领取奖励屏幕提示
	local YBCost_RepeatNotify = 
	{
		"#{CZHL_200916_46}","#{CZHL_200916_47}","#{CZHL_200916_48}","#{CZHL_200916_49}",
		"#{CZHL_200916_50}","#{CZHL_200916_51}","#{CZHL_200916_52}","#{CZHL_200916_57}"
	}
	if x181000_g_TopChongZhi_Gifts[Index] == nil then
		return
	end
	if GetLevel(sceneId,selfId) < x181000_g_TopChongZhi_MinLevel then
		x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_22}" )
		return
	end
	local nExchYuanBao = BuyYuanBaoCount(sceneId,selfId,targetId,3,0) --查询兑换了多少元宝
	local nCostYuanBao = GetYuanBaoTotalCost(sceneId,selfId) --查询一共消耗了多少元宝
	local nFlag = GetMissionFlagEx(sceneId,selfId,x181000_g_TopChongZhi_Flag[Index])
	if nFlag == 1 then
		x181000_NotifyTip(sceneId,selfId,YBCost_RepeatNotify[Index])
		return
	end
	--再次检查是否达成领取要求
	if nExchYuanBao >= x181000_g_TopChongZhi_GetGiftsCondition[Index].Exch
	and nCostYuanBao >=  x181000_g_TopChongZhi_GetGiftsCondition[Index].Cost then
		--发放回馈物品
		BeginAddItem(sceneId)
			for i = 1,getn(x181000_g_TopChongZhi_Gifts[Index]) do
				AddItem(sceneId,x181000_g_TopChongZhi_Gifts[Index][i].GiftItemID,x181000_g_TopChongZhi_Gifts[Index][i].num)
			end
		if EndAddItem(sceneId,selfId,1) <= 0 then
			local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
			if iBase ~= nil and iBase > 0 then
				x181000_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{BCLB_20201019_10}",tostring(iBase)))
			end
			if iMat ~= nil and iMat > 0 then
				x181000_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{BCLB_20201019_11}",tostring(iMat)))
			end
			return
		end
		AddItemListToHuman(sceneId,selfId)
		--写入记录
		SetMissionFlagEx(sceneId,selfId,x181000_g_TopChongZhi_Flag[Index],1)
		--乾鼎商会开启
		if Index == 8 then
			SetMissionFlagEx(sceneId,selfId,MFEX_QianDingShangHui,1)
			x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_61}")
		end
		--紫金游龙卡特殊处理
		if Index == 1 then
			SetMissionData(sceneId,selfId,MD_BaiBingJingTong,1)
			x181000_NotifyTip(sceneId,selfId,"紫金游龙卡特权-百兵精通已激活")
		end
		--系统提示也要独立处理一下。
		if Index > 5 then
			AddGlobalCountNews(sceneId,
				ScriptGlobal_Format(YBCost_GlobalNews[Index],
				GetName(sceneId,selfId),
				LuaFnGetItemTransfer(sceneId,selfId,0),
				x181000_g_TopChongZhi_Gifts[Index][2].num,
				LuaFnGetItemTransfer(sceneId,selfId,1)
			))
		else
			AddGlobalCountNews(sceneId,
				ScriptGlobal_Format(YBCost_GlobalNews[Index],
				GetName(sceneId,selfId),
				x181000_g_TopChongZhi_Gifts[Index][1].num,
				LuaFnGetItemTransfer(sceneId,selfId,0),
				x181000_g_TopChongZhi_Gifts[Index][2].num,
				LuaFnGetItemTransfer(sceneId,selfId,1)
			))
		end
		--成功屏幕提示
		x181000_NotifyTip(sceneId,selfId,YBCost_OKNotify[Index])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0) --成功的buff标记
		--更新UI面板
		x181000_YBCost_OpenWindow(sceneId,selfId,targetId)
	else
		x181000_NotifyTip(sceneId,selfId,YBCost_FailNotify[Index])
	end
end
--**********************************
--乾鼎商会购买
--**********************************
function x181000_buyitem(sceneId,selfId,targetId,buyItemId)
	if GetMissionFlagEx(sceneId,selfId,MFEX_QianDingShangHui) ~= 1 then
		x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_66}")
		return
	end
	--没有这个东西
	local nItemNum,szItemName,nYuanBao,nBindItem,nCanBuyCount = LuaFnGetLangYuTianGeShopInfo(sceneId,selfId,buyItemId)
	if nItemNum <= 0 then
		return
	end
	local curYB = YuanBao(sceneId,selfId,selfId,3,0)
	if curYB < nYuanBao then
		x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_72}")
		return
	end
	if nCanBuyCount ~= -1 and nItemNum > nCanBuyCount then
		x181000_NotifyTip(sceneId,selfId,"#{CZHL_200916_76}")
		return
	end
	BeginAddItem(sceneId)
	if nBindItem == 1 then
		AddBindItem(sceneId,buyItemId,nItemNum)
	else	
		AddItem(sceneId,buyItemId,nItemNum)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	AddItemListToHuman(sceneId,selfId )
	LuaFnCostYuanBao(sceneId,selfId,nYuanBao,181000,"x181000_buyitem",0,-1);
	LuaFnAddLangYuTianGeShopBuyCount(sceneId,selfId,targetId,buyItemId,nItemNum)
	x181000_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{CZHL_200916_79}",szItemName))
end
--**********************************
--屏幕中间提示
--**********************************
function x181000_NotifyTip(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
