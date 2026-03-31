--2020回流活动
--已加的接口
--local nCount = GetHerosReturnsShopItemCount()
--local nIndex, nItemId, nItemShowId, nItemNum, nCredit, nLimit = GetHerosReturnsShopItem(i)
--local nCount = GetHerosReturnsRoadCountByDay( nDay-1 )
--local nIndex,TargetNum,BounsNum = GetHerosReturnsRoadInfo(nDay-1, i-1)
--AddHerosReturnsRecoed(sceneId,selfId,nClassId); nClassId->HerosReturnsRoad的第二列,如进行一次幸运快活三后就写 AddHerosReturnsRecoed(sceneId,selfId,1);


--最大活动天数
x808110_g_HerosReturns_MaxDayCount = 12

x808110_g_HerosReturns_Awards_7DayPrize =
{
	[1] ={
				[1]={ItemID = 10124255, num = 1,}, --雪羽霜衣7天
				[2]={ItemID = 38002162, num = 1,}, --70绑元		
				},
	[2] ={
				[1]={ItemID = 30008027, num = 2,}, --天灵丹*2
				[2]={ItemID = 38002163, num = 1,}, --75绑元
				},
	[3] ={
				[1]={ItemID = 10141872, num = 1,}, --翅膀冥羽7天
				[2]={ItemID = 38002164, num = 1,}, --80绑元		
				},
	[4] ={
				[1]={ItemID = 38000831, num = 2,}, --功力丹*2
				[2]={ItemID = 38002165, num = 1,}, --85绑元		
				},
	[5] ={
				[1]={ItemID = 20310168, num = 10,}, --金蚕丝*10
				[2]={ItemID = 38002166, num = 1,}, --90绑元		
				},
	[6] ={
				[1]={ItemID = 30900045, num = 1,}, --天罡强化露
				[2]={ItemID = 38002167, num = 1,}, --95绑元			
				},
	[7] ={
				[1]={ItemID = 50313004, num = 1,}, --红宝石（3级）
				[2]={ItemID = 38000060, num = 1,}, --100绑元		
				},	
};
--背包空间检测用
x808110_g_HerosReturns_Awards_7DayPrize_BagSize = 
{
	[1] = {2,0},
	[2] = {2,0},
	[3] = {2,0},
	[4] = {2,0},
	[5] = {1,1},
	[6] = {2,0},
	[7] = {1,1},
};
--荣归阁购买背包空间检测
x808110_g_HerosReturns_Shop_BagSize = 
{
	[1] = {1,0},
	[2] = {1,0},
	[3] = {1,0},
	[4] = {0,1},
	[5] = {1,0},
	[6] = {0,1},
	[7] = {1,0},
	[8] = {0,1}
};
--荣归阁已经购买数量的MD记录
x808110_g_HerosReturns_Shop_Limit_MD = 
{
	MDEX_2020_HUILIU_SHOP_BUY_1,
	MDEX_2020_HUILIU_SHOP_BUY_2,
	MDEX_2020_HUILIU_SHOP_BUY_3
}
--英雄之路第n天任务
x808110_g_HerosReturns_Mission = {
	MDEX_2020_HUILIU_MDAY_1,		-- 英雄之路第1天任务	00 00 00
	MDEX_2020_HUILIU_MDAY_2,		-- 英雄之路第2天任务
	MDEX_2020_HUILIU_MDAY_3,		-- 英雄之路第3天任务
	MDEX_2020_HUILIU_MDAY_4,		-- 英雄之路第4天任务
	MDEX_2020_HUILIU_MDAY_5,		-- 英雄之路第5天任务
	MDEX_2020_HUILIU_MDAY_6,		-- 英雄之路第6天任务
	MDEX_2020_HUILIU_MDAY_7,		-- 英雄之路第7天任务
}
--英雄之路第n天任务达成领取记录
x808110_g_HerosReturns_MissionPrizeFlag = 
{
	MDEX_2020_HUILIU_PRIZE_1,		-- 英雄之路第1天任务	0	0	0
	MDEX_2020_HUILIU_PRIZE_2,		-- 英雄之路第2天任务
	MDEX_2020_HUILIU_PRIZE_3,		-- 英雄之路第3天任务
	MDEX_2020_HUILIU_PRIZE_4,		-- 英雄之路第4天任务
	MDEX_2020_HUILIU_PRIZE_5,		-- 英雄之路第5天任务
	MDEX_2020_HUILIU_PRIZE_6,		-- 英雄之路第6天任务
	MDEX_2020_HUILIU_PRIZE_7,		-- 英雄之路第7天任务
}
--**************************************
-- 打开UI面板
--**************************************
function x808110_OnOpenUI(sceneId,selfId,nIndex)
	--打开英雄归来领奖主界面
	local IsVisible = 0
	if nIndex == 1 then
		local nLeftTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME) - LuaFnGetCurrentTime()
		local HeroLogin = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS)
		local PrizeFlag = GetMissionDataEx(sceneId,selfId,MDEX_HERO_PRIZEFLAG)
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,nLeftTime)
			UICommand_AddInt(sceneId,HeroLogin)
			UICommand_AddInt(sceneId,PrizeFlag)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811001)
		IsVisible = 1
	end
	--江湖告令任务
	if nIndex == 2 then
		local nLeftTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME) - LuaFnGetCurrentTime()
		local HeroLogin = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS)
		local nRecordData = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Mission[HeroLogin]);
		local nPrizeFlag = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_MissionPrizeFlag[HeroLogin]);
		local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,HeroLogin)
			UICommand_AddInt(sceneId,HeroLogin)
			UICommand_AddInt(sceneId,nLeftTime)
			UICommand_AddInt(sceneId,nCurDaiBi)
			UICommand_AddInt(sceneId,nPrizeFlag)
			UICommand_AddInt(sceneId,3)
			--打出数据记录点
			UICommand_AddInt(sceneId,floor(nRecordData / 1000000))
			UICommand_AddInt(sceneId,floor(mod(nRecordData,10000) / 1000))
			UICommand_AddInt(sceneId,mod(nRecordData,100))
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811002)
		IsVisible = 1
	end
	--荣归阁
	if nIndex == 3 then
		--打开商店
		local nLeftTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME) - LuaFnGetCurrentTime()
		local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,nLeftTime)	--LeftTime 距离结束的秒数
			UICommand_AddInt(sceneId,nCurDaiBi)			--荣归代币
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811003)
		--更新已购买的数量
		x808110_OnUpdateBuyCount(sceneId,selfId)
		
		IsVisible = 1
	end
	-- 页签红点显示
	if IsVisible == 1 then
		local nGetLingQu = 0
		local nTab = {}
		local HeroLogin = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS)
		local PrizeFlag = GetMissionDataEx(sceneId,selfId,MDEX_HERO_PRIZEFLAG)
		for i = 1,7 do
			nTab[i] = mod(floor(PrizeFlag/10 ^ (i - 1)),10)
			if nTab[i] ~= 0 then
				nGetLingQu = nGetLingQu + 1
			end
		end
		--江湖告令可领取
		local nMissionFlag = 0
		for i = 1,7 do
			local nRecordData = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Mission[i]);
			local MissionFlag_1 = floor(nRecordData / 1000000)
			local MissionFlag_2 = floor(mod(nRecordData,10000) / 1000)
			local MissionFlag_3 = mod(nRecordData,100)
			if MissionFlag_1 == 1 or MissionFlag_2 == 1 or MissionFlag_3 == 1 then
				nMissionFlag = 1
				break
			end
		end
		--荣归阁可兑换
		local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
		local nCount = GetHerosReturnsShopItemCount()
		local IsBuyOk = 0
		for i = 1,nCount do
			local _,nItemId,_,nItemNum,nCredit,nLimit = GetHerosReturnsShopItem(i)
			local nBuyCnt = x808110_HerosReturns_Shop_GetLimitCount(sceneId,selfId,i)
			if nCurDaiBi >= nCredit and nBuyCnt < nLimit then
				IsBuyOk = i;
				break
			end
		end
		BeginUICommand(sceneId)
			if nGetLingQu < HeroLogin then
				UICommand_AddInt(sceneId,1)
			else
				UICommand_AddInt(sceneId,0)
			end
			if nMissionFlag == 1 then
				UICommand_AddInt(sceneId,1)
			else
				UICommand_AddInt(sceneId,0)
			end
			if IsBuyOk > 0 then
				UICommand_AddInt(sceneId,1)
			else
				UICommand_AddInt(sceneId,0)
			end
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811005)
	end
end

--**************************************
-- 是否显示在玩家头顶界面中
--**************************************
function x808110_HeroReturns(sceneId,selfId)
	local nLevel = GetLevel(sceneId,selfId)
	local nLeftTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME) - LuaFnGetCurrentTime()
	if nLevel >= 50 and nLeftTime > 0 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811000)
	else
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811006)
	end
end
--**************************************
-- 领取奖励
--**************************************
function x808110_Get7DayPrize(sceneId,selfId,g_HerosReturns_Awards_7DayPrize_Click)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_HERO_PRIZEFLAG)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
	if GetLevel(sceneId,selfId) < 50 then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_30}")
		return
	end
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,10541) ~= 1 then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_31}")
		return
	end
    if nTab[g_HerosReturns_Awards_7DayPrize_Click] == 1 then
	    x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_34}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS)
	if g_HerosReturns_Awards_7DayPrize_Click > nTime then
		x808110_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{HJHL_201224_33}",g_HerosReturns_Awards_7DayPrize_Click))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < x808110_g_HerosReturns_Awards_7DayPrize_BagSize[g_HerosReturns_Awards_7DayPrize_Click][1] then
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_35}"
			,x808110_g_HerosReturns_Awards_7DayPrize_BagSize[g_HerosReturns_Awards_7DayPrize_Click][1]
		))
		return
	end
	if nMaterialSize < x808110_g_HerosReturns_Awards_7DayPrize_BagSize[g_HerosReturns_Awards_7DayPrize_Click][2] then
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_36}"
			,x808110_g_HerosReturns_Awards_7DayPrize_BagSize[g_HerosReturns_Awards_7DayPrize_Click][2]
		))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,2 do
			AddBindItem(sceneId,x808110_g_HerosReturns_Awards_7DayPrize[g_HerosReturns_Awards_7DayPrize_Click][i].ItemID,x808110_g_HerosReturns_Awards_7DayPrize[g_HerosReturns_Awards_7DayPrize_Click][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_35}",
			x808110_g_HerosReturns_Awards_7DayPrize_BagSize[g_HerosReturns_Awards_7DayPrize_Click][1]
		))
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_36}",
			x808110_g_HerosReturns_Awards_7DayPrize_BagSize[g_HerosReturns_Awards_7DayPrize_Click][2]
		))
		return
	end
	for i = 1,3 do
		LuaFnAddExp(sceneId,selfId,700000)
	end
	LuaFnAddExp(sceneId,selfId,22353)
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	--醒目提示
	for i = 1,2 do
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_37}",
			x808110_g_HerosReturns_Awards_7DayPrize[g_HerosReturns_Awards_7DayPrize_Click][i].num,
			GetItemName(sceneId,x808110_g_HerosReturns_Awards_7DayPrize[g_HerosReturns_Awards_7DayPrize_Click][i].ItemID)
		))
	end
    --领取数据写入
	nTab[g_HerosReturns_Awards_7DayPrize_Click] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_HERO_PRIZEFLAG,nFinalData)
	--重新加载界面
	x808110_OnOpenUI(sceneId,selfId,1)
end
--**************************************
-- 江湖告令分页切换
--**************************************
--英雄之路第n天任务
--添加1个好友
--完成1次幸运快活三
--在帮会频道发言1次

--装备1件时装
--完成1次校场切磋
--装备1把神器

--添加5个好友
--完成1次苏州百变脸谱
--完成1次如下任意帮会任务：国防任务、工程任务、市集任务、科技任务、发展任务、扩张任务

--进行1次时装染色
--参加1次科举
--在主城领取1次双倍经验

--击败1次如下任意副本的最终BOSS：剿匪、熔岩之地、讨伐燕子坞、杀星、初战缥缈峰、挑战缥缈峰
--击败1次如下任意副本的最终BOSS：棋局、楼兰寻宝、贼兵入侵、偷袭门派、藏经阁
--制作1件装备

--在线时间达到半小时
--完成1次跑商
--进入1次寒玉谷

--完成1次组队珍兽繁殖
--完成1次师门任务
--与3个好友的友好度达到100
function x808110_OnAskHeroesRoadInfo(sceneId,selfId,nDay)
	if nDay < 1 or nDay > getn(x808110_g_HerosReturns_Mission) then
		return
	end
	--HJHL_201224_72	该页面在第%s0天可开启。
	local nLeftTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME) - LuaFnGetCurrentTime()	
	local nActDay = x808110_g_HerosReturns_MaxDayCount - floor(nLeftTime / (3600 * 24));	
	if nDay > nActDay then
		x808110_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{HJHL_201224_72}",tostring(nDay)))
		return
	end
	local nRecordData = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Mission[nDay]);
	local nPrizeFlag = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_MissionPrizeFlag[nDay]);
	local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nDay)
		UICommand_AddInt(sceneId,nLeftTime)
		UICommand_AddInt(sceneId,nCurDaiBi)
		UICommand_AddInt(sceneId,nPrizeFlag)
		UICommand_AddInt(sceneId,3)
		--打出数据记录点
		UICommand_AddInt(sceneId,floor(nRecordData / 1000000))
		UICommand_AddInt(sceneId,floor(mod(nRecordData,10000) / 1000))
		UICommand_AddInt(sceneId,mod(nRecordData,100))
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 80811021)
end
--**************************************
-- 江湖告令领取荣归令
--**************************************
function x808110_OnGetGaoLingPrize(sceneId,selfId,index)
	local nDayIndex = mod(index,3)
	local nDay = floor(index/3)
	local nCount = GetHerosReturnsRoadCountByDay(nDay)
	local nIndex,TargetNum,BounsNum = GetHerosReturnsRoadInfo(nDay,nDayIndex)
	local nRecordData = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Mission[nDay + 1]);
	local nPrizeFlag = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_MissionPrizeFlag[nDay + 1])
	local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
	--不是重返玩家
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,10541) ~= 1 then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_46}")
		return
	end
	if floor(nPrizeFlag/10 ^ nDayIndex) > 0 then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_73}")
		return
	end
	if nDayIndex == 0 then
		if floor(nRecordData/1000000) < TargetNum then
			x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_48}")
			return
		end
	elseif nDayIndex == 1 then
		if floor(mod(nRecordData,10000)/1000) < TargetNum then
			x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_48}")
			return
		end
	elseif nDayIndex == 2 then
		if mod(nRecordData,100) < TargetNum then
			x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_48}")
			return
		end
	end
	-- 领取成功，写入已领取数据
	SetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_MissionPrizeFlag[nDay + 1],nPrizeFlag + 10 ^ nDayIndex)
	-- 写入荣归令
	SetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI,nCurDaiBi + BounsNum)
	x808110_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{HJHL_201224_51}",BounsNum))
	x808110_OnAskHeroesRoadInfo(sceneId,selfId,nDay + 1)
end
--**************************************
-- 更新已经购买数量的MD
--**************************************
function x808110_OnUpdateBuyCount(sceneId,selfId)
	BeginUICommand(sceneId)
		for i = 1,getn(x808110_g_HerosReturns_Shop_Limit_MD) do
			UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Shop_Limit_MD[i]))
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 80811031)
	
	local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nCurDaiBi)			--荣归代币
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 80811032)
end

--**************************************
-- 荣归阁购买
--**************************************
function x808110_OnBuyShopItem(sceneId,selfId,nIndex,bIsOk)
--	根据bIsOk要call客户端80811033来触发二次确认
	local nCurDaiBi = GetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI)
	local _,nItemId,_,nItemNum,nCredit,nLimit = GetHerosReturnsShopItem(nIndex)
	local nBuyCnt = x808110_HerosReturns_Shop_GetLimitCount(sceneId,selfId,nIndex)
	local nCount = GetHerosReturnsShopItemCount()
	local szText = "荣归令"
	if bIsOk == 0 then
		BeginUICommand(sceneId)
			UICommand_AddString(sceneId,
				ScriptGlobal_Format("#{HJHL_201224_67}"
				,nCredit
				,szText
				,nItemNum
				,GetItemName(sceneId,nItemId)
			))
			UICommand_AddInt(sceneId,nIndex)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 80811033)
		return
	end
	--等级不足
	if GetLevel(sceneId,selfId) < 50 then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_60}")
		return
	end
	--不是重返玩家
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,10541) ~= 1 then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_61}")
		return
	end
	if nIndex < 1 or nIndex > nCount then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_62}")
		return
	end
	--已经达到最大兑换数了
	if nBuyCnt >= nLimit then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_63}")
		return
	end
	--代币不足
	if nCurDaiBi < nCredit then
		x808110_NotifySystemMsg(sceneId,selfId,"#{HJHL_201224_64}")
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < x808110_g_HerosReturns_Shop_BagSize[nIndex][1] then
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_65}"
			,x808110_g_HerosReturns_Shop_BagSize[nIndex][1]
		))
		return
	end
	if nMaterialSize < x808110_g_HerosReturns_Shop_BagSize[nIndex][2] then
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_66}"
			,x808110_g_HerosReturns_Shop_BagSize[nIndex][2]
		))
		return
	end
	BeginAddItem(sceneId)
		AddBindItem(sceneId,nItemId,nItemNum)
	if EndAddItem(sceneId,selfId) <= 0 then
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_65}",
			x808110_g_HerosReturns_Shop_BagSize[nIndex][1]
		))
		x808110_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{HJHL_201224_66}",
			x808110_g_HerosReturns_Shop_BagSize[nIndex][2]
		))
		return
	end
	--扣除代币
	SetMissionDataEx(sceneId,selfId,MDEX_2020_HUILIU_DAIBI,nCurDaiBi - nCredit)
	--购买次数写入
	local MDData = nil
	local Flag = 0
	for i = 1,getn(x808110_g_HerosReturns_Shop_Limit_MD) do
		if nIndex > 3*(i-1) and nIndex <= 3*i then
			MDData = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Shop_Limit_MD[i])
			Flag = i
			break
		end
	end
	local newValue = 1 --购买剩余次数要加1
	if MDData ~= nil then
		local temp = mod(nIndex-1,3)
		if temp == 0 then
			SetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Shop_Limit_MD[Flag],MDData + newValue)
		elseif temp == 1 then
			SetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Shop_Limit_MD[Flag],MDData + newValue * 1000)
		elseif temp == 2 then
			SetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Shop_Limit_MD[Flag],MDData + newValue * 1000000)
		end
	end
	AddItemListToHuman(sceneId,selfId)
	x808110_NotifySystemMsg(sceneId,selfId,
		ScriptGlobal_Format("#{HJHL_201224_70}"
		,nItemNum
		,GetItemName(sceneId,nItemId)
	))
	--更新购买次数
	x808110_OnUpdateBuyCount(sceneId,selfId)
end
--**************************************
-- 获取物品已兑换数
--**************************************
function x808110_HerosReturns_Shop_GetLimitCount(sceneId,selfId,nIndex)
	if nIndex < 1 then
		return -1
	end
	local MDData = nil
	for i = 1,getn(x808110_g_HerosReturns_Shop_Limit_MD) do
		if nIndex > 3*(i-1) and nIndex <= 3*i then
			MDData = GetMissionDataEx(sceneId,selfId,x808110_g_HerosReturns_Shop_Limit_MD[i])
			break
		end
	end
	local ret = -1
	if MDData ~= nil then
		local temp = mod(nIndex-1,3) --0,1,2
		if temp == 0 then
			ret = mod(MDData, 1000)
		elseif temp == 1 then
			ret = mod(floor(MDData/1000), 1000)
		elseif temp == 2 then
			ret = mod(floor(MDData/1000000),1000)
		end
	end
	return ret
end
--**************************************
-- 江湖告令显示帮助
--**************************************
function x808110_OnShowHelp(sceneId,selfId,nIndex)
	if nIndex == 1 then
		x808110_MsgBox(sceneId,selfId,"#{HJHL_201224_41}")
	end
end

function x808110_MsgBox(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId,msg)
	EndEvent( sceneId )
	DispatchEventList(sceneId,selfId,-1)
end
--**************************************
-- 屏幕中间提示
--**************************************
function x808110_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
