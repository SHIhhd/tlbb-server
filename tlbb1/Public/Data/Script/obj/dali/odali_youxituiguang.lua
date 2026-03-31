-- 领奖NPC
--2024-3-24 23:20:21 重构

x002084_g_scriptId = 002084
--开启内测预充权限物品领取
x002084_g_TEST_CTUID = 1001000014
x002084_g_TestNeedPoint = 200

x002084_g_NewCard1_666 = 43
x002084_g_NewCard2_666 = 44
x002084_g_NewCard3_666 = 45
x002084_g_NewCard4_666 = 46
x002084_g_NewCard5_666 = 47
x002084_g_NewCard6_666 = 48
x002084_g_NewCard7_666 = 49
x002084_g_NewCard8_666 = 50
x002084_g_NewCard9_666 = 51
x002084_g_NewCard10_666 = 52
x002084_g_NewCard11_666 = 53
x002084_g_NewCard12_666 = 54

--天工开物
x002084_g_eventList={210244}

--财富卡666
x002084_g_NewCardListEx = {}
x002084_g_NewCardListEx[x002084_g_NewCard1_666] = {
	needLevel = -1,
	itemAward = { hashTable = {}, itemList = {10402081,10422153,10423062}},
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 3,
	MatBagSpaceNeed = 0,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard0_666,
	redundantMsg = "#{TLWS_20200908_30}",
	recvMsg = "#{TLWS_20200908_32}",
}
x002084_g_NewCardListEx[x002084_g_NewCard2_666] = {
	needLevel = 10,
	itemAward = { hashTable = {}, itemList = {10141025,10141035,10141208} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 3,
	MatBagSpaceNeed = 0,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard1_666,
	redundantMsg = "#{TLWS_20200908_34}",
	recvMsg = "#{TLWS_20200908_35}",
}
x002084_g_NewCardListEx[x002084_g_NewCard3_666] = {
	needLevel = 15,
	itemAward = { hashTable = {}, itemList = {10111056,10112056,10113056,10121016} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 4,
	MatBagSpaceNeed = 0,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard2_666,
	redundantMsg = "#{TLWS_20200908_37}",
	recvMsg = "#{TLWS_20200908_38}",
}
x002084_g_NewCardListEx[x002084_g_NewCard4_666] = {
	needLevel = 25,
	itemAward = { hashTable = {}, itemList = {30008103,30505076}},
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 2,
	MatBagSpaceNeed = 0,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard3_666,
	redundantMsg = "#{TLWS_20200908_40}",
	recvMsg = "#{TLWS_20200908_41}",
}
x002084_g_NewCardListEx[x002084_g_NewCard5_666] = {
	needLevel = 30,
	itemAward = { hashTable = {}, itemList = {10155004,30900059} },
	taozhuang = 
	{
		{10411002,10412002,10413002,10421002},
		{10411002,10412002,10413002,10421002},
		{10411002,10412002,10413002,10421002},
		{10411008,10412008,10413008,10421008},
		{10411008,10412008,10413008,10421008},
		{10411008,10412008,10413008,10421008},
		{10411002,10412002,10413002,10421002},
		{10411002,10412002,10413002,10421002},
		{10411008,10412008,10413008,10421008},
		--无门派
		{},
		--曼陀山庄
		{10411008,10412008,10413008,10421008},
	},
	petdata = 23472,
	moneyReward = 0,
	PropBagSpaceNeed = 6,
	MatBagSpaceNeed = 0,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard4_666,
	redundantMsg = "#{TLWS_20200908_43}",
	recvMsg = "#{TLWS_20200908_45}",
}
x002084_g_NewCardListEx[x002084_g_NewCard6_666] = {
	needLevel = 40,
	itemAward = { hashTable = {}, itemList = {30008102,30008027,30503133,30503133,30505800,30505800,30505800,30900006,30900006} },
	taozhuang = 
	{
		{10512003},
		{10520013},
		{10512023},
		{10512033},
		{10520043},
		{10521050},
		{10512083},
		{10512063},
		{10520073},
		--无门派
		{},
		--曼陀山庄
		{10520120}
	},
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 6,
	MatBagSpaceNeed = 0,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard5_666,
	redundantMsg = "#{TLWS_20200908_47}",
	recvMsg = "#{TLWS_20200908_48}",
}
x002084_g_NewCardListEx[x002084_g_NewCard7_666] = {
	needLevel = 50,
	itemAward = { hashTable = {}, itemList = {30505801,30505801,30505801,
	20310173,20310173,20310173,20310173,20310173,20310173,20310173,20310173,
	20310173,20310173,20310173,20310173,20310173,20310173,20310173,20310173,
	20310173,20310173,20310173,20310173,30120010,30503149} },
	taozhuang = 
	{
		{10513004,10515004},
		{10521014,10515014},
		{10513024,10520024},
		{10511034,10513034},
		{10513044,10515044},
		{10513054,10520054},
		{10523084,10552084},
		{10511064,10513064},
		{10511074,10513074},
		--无门派
		{},
		--曼陀山庄
		{10511120,10513119,10515120}
	},
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 5,
	MatBagSpaceNeed = 1,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard6_666,
	redundantMsg = "#{TLWS_20200908_50}",
	recvMsg = "#{TLWS_20200908_52}",
}
x002084_g_NewCardListEx[x002084_g_NewCard8_666] = {
	needLevel = 60,
	itemAward = { hashTable = {}, itemList = {10156003,10156004,20501003} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 2,
	MatBagSpaceNeed = 1,
	TaskBagSpaceNeed = 0,
	flagBit = MF_GetNewUserCard7_666,
	redundantMsg = "#{TLWS_20200908_54}",
	recvMsg = "#{TLWS_20200908_55}",
}
x002084_g_NewCardListEx[x002084_g_NewCard9_666] = {
	needLevel = 70,
	itemAward = { hashTable = {}, itemList = {30501361,30501361,30501361,20502003,30700241,30700241} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 2,
	MatBagSpaceNeed = 1,
	TaskBagSpaceNeed = 0,
	flagBit = MFEX_GetNewUserCard8_666,
	redundantMsg = "#{TLWS_20200908_57}",
	recvMsg = "#{TLWS_20200908_58}",
}
x002084_g_NewCardListEx[x002084_g_NewCard10_666] = {
	needLevel = 80,
	itemAward = { hashTable = {}, itemList = {20310168,20310168,20310168,20310168,20310168,30505804,30505804} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 1,
	MatBagSpaceNeed = 1,
	TaskBagSpaceNeed = 0,
	flagBit = MFEX_GetNewUserCard9_666,
	redundantMsg = "#{TLWS_20200908_60}",
	recvMsg = "#{TLWS_20200908_61}",
}
x002084_g_NewCardListEx[x002084_g_NewCard11_666] = {
	needLevel = 90,
	itemAward = { hashTable = {}, itemList = {20310168,20310168,20310168,20310168,20310168,20310168,20310168,20310168,20310168,20310168,
	50313004} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 0,
	MatBagSpaceNeed = 2,
	TaskBagSpaceNeed = 0,
	flagBit = MFEX_GetNewUserCard10_666,
	redundantMsg = "#{TLWS_20200908_63}",
	recvMsg = "#{TLWS_20200908_64}",
}
x002084_g_NewCardListEx[x002084_g_NewCard12_666] = {
	needLevel = 100,
	itemAward = { hashTable = {}, itemList = {50413004,20501003,20502003} },
	taozhuang = 0,
	petdata = 0,
	moneyReward = 0,
	PropBagSpaceNeed = 0,
	MatBagSpaceNeed = 3,
	TaskBagSpaceNeed = 0,
	flagBit = MFEX_GetNewUserCard11_666,
	redundantMsg = "#{TLWS_20200908_66}",
	recvMsg = "#{TLWS_20200908_67}",
}


--**********************************
--事件交互入口
--**********************************
function x002084_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{TLWS_20200908_01}" )

		for i, eventId in x002084_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		
		-- if LuaFnCTUCheckIsShutDown(sceneId,selfId,x002084_g_TEST_CTUID) == 0 then
			-- local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
			-- if nExchPoint >= x002084_g_TestNeedPoint then
				AddNumText( sceneId, x002084_g_scriptId, "神秘档口", 6,11001)
			-- end
		-- end
		
		if GetGuildPos( sceneId, selfId ) == GUILD_POSITION_CHIEFTAIN then
			AddNumText(sceneId,selfId,"#H购买20点帮派扩张值【价值2000元宝】",6,10008)
		end
		AddNumText( sceneId, x002084_g_scriptId, "#{TLWS_20200908_02}", 2, 101 )
		AddNumText( sceneId, x002084_g_scriptId, "#{TLWS_20200908_03}", 2, 102 )
		AddNumText( sceneId, x002084_g_scriptId, "#{TLWS_20200908_04}", 6, 520 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--财富卡666
function x002084_AddNewUserCardNumText666(sceneId, selfId, targetId)
	local eventNum = 0
	BeginEvent( sceneId )
	
		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard1_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取1级的奖励", 2, x002084_g_NewCard1_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard2_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard2_666].needLevel .. "级的奖励", 2, x002084_g_NewCard2_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard3_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard3_666].needLevel .. "级的奖励", 2, x002084_g_NewCard3_666 )
			 eventNum = eventNum + 1
		end
		
		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard4_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard4_666].needLevel .. "级的奖励", 2, x002084_g_NewCard4_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard5_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard5_666].needLevel .. "级的奖励", 2, x002084_g_NewCard5_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard6_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard6_666].needLevel .. "级的奖励", 2, x002084_g_NewCard6_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard7_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard7_666].needLevel .. "级的奖励", 2, x002084_g_NewCard7_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlag( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard8_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard8_666].needLevel .. "级的奖励", 2, x002084_g_NewCard8_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlagEx( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard9_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard9_666].needLevel .. "级的奖励", 2, x002084_g_NewCard9_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlagEx( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard10_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard10_666].needLevel .. "级的奖励", 2, x002084_g_NewCard10_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlagEx( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard11_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard11_666].needLevel .. "级的奖励", 2, x002084_g_NewCard11_666 )
			 eventNum = eventNum + 1
		end

		if GetMissionFlagEx( sceneId, selfId, x002084_g_NewCardListEx[x002084_g_NewCard12_666].flagBit ) == 0 then
			 AddNumText( sceneId, x002084_g_scriptId, "领取" .. x002084_g_NewCardListEx[x002084_g_NewCard12_666].needLevel .. "级的奖励", 2, x002084_g_NewCard12_666 )
			 eventNum = eventNum + 1
		end

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	
	if eventNum == 0 then
		x002084_NotifyFailBox( sceneId, selfId, targetId, "    你已领取所有的超级大力卡奖励。" )
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x002084_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	-- if LuaFnCTUCheckIsShutDown(sceneId,selfId,x002084_g_TEST_CTUID) == 0 then
		-- local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
		-- if nExchPoint >= x002084_g_TestNeedPoint then

			if GetNumText() == 11001 then
				BeginEvent( sceneId )
					AddText( sceneId, "    这里是我的神秘档口，少侠交了大米，那自然是要服务到位！#r    老夫特意为少侠准备了些许礼物，以便少侠能更好地行侠仗义。" )
					AddNumText( sceneId, x002084_g_scriptId, "手工材料领取", 14,10001)
					AddNumText( sceneId, x002084_g_scriptId, "领取打造相关材料", 14,10002)
					AddNumText( sceneId, x002084_g_scriptId, "领取武魂残篇礼盒", 14,10003)
					AddNumText( sceneId, x002084_g_scriptId, "领取神器材料", 14,10005)
					AddNumText( sceneId, x002084_g_scriptId, "领取兽魂及武道材料", 14,10009)
					AddNumText( sceneId, x002084_g_scriptId, "领取高级兽魂材料", 14,10010)
					AddNumText( sceneId, x002084_g_scriptId, "领取武魂技能书相关材料", 14,10012)
					AddNumText( sceneId, x002084_g_scriptId, "领取暗器冰魄神针", 14,10013)
					AddNumText( sceneId, x002084_g_scriptId, "领取雕纹相关材料", 14,10014)
					AddNumText( sceneId, x002084_g_scriptId, "领取长春玉", 14,10015)
					AddNumText( sceneId, x002084_g_scriptId, "领取七情刃礼盒", 14,10016)
					AddNumText( sceneId, x002084_g_scriptId, "领取雕纹精绘相关材料", 14,10017)
					AddNumText( sceneId, x002084_g_scriptId, "领取经验500W", 14,10006)
					AddNumText( sceneId, x002084_g_scriptId, "升级至102级", 14,10011)
					AddNumText( sceneId, x002084_g_scriptId, "下一页", 14,11002)
				EndEvent( sceneId )
				DispatchEventList( sceneId, selfId, targetId )
			elseif GetNumText() == 11002 then
				BeginEvent( sceneId )
					AddText( sceneId, "    这里是我的神秘档口，少侠交了大米，那自然是要服务到位！#r    老夫特意为少侠准备了些许礼物，以便少侠能更好地行侠仗义。" )
					AddNumText( sceneId, x002084_g_scriptId, "领取元宝和绑定元宝", 14,10004)
					AddNumText( sceneId, x002084_g_scriptId, "领取动作时装", 14,10018)
					AddNumText( sceneId, x002084_g_scriptId, "领取动作幻饰", 14,10019)
					AddNumText( sceneId, x002084_g_scriptId, "领取最新发型", 14,10020)
					AddNumText( sceneId, x002084_g_scriptId, "领取最新头饰", 14,10021)
					AddNumText( sceneId, x002084_g_scriptId, "领取最新背饰", 14,10022)
					AddNumText( sceneId, x002084_g_scriptId, "上一页", 14,11001)
				EndEvent( sceneId )
				DispatchEventList( sceneId, selfId, targetId )
			elseif GetNumText() == 10001 then
				 BeginAddItem(sceneId)
					 AddItem( sceneId, 20501004, 200 )
					 AddItem( sceneId, 20502004, 200 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
				 x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取4级棉布秘银。")
			elseif GetNumText() == 10002 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 30900057, 10 )
					AddItem( sceneId, 20502009, 250 )
					AddItem( sceneId, 30700232, 250 )
					AddItem( sceneId, 30503118, 250 )
					AddItem( sceneId, 38003055, 50 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
				 x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取打造相关材料。")
			elseif GetNumText() == 10003 then
				 BeginAddItem(sceneId)
					 AddItem( sceneId, 38002229, 250 )
					 AddItem( sceneId, 38002231, 250 )
					 AddItem( sceneId, 10156003, 5)
					 AddItem( sceneId, 10156004, 5)
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
				 x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取幻魂残篇礼盒。")
			elseif GetNumText() == 10009 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 38002397, 250 )
					AddItem( sceneId, 38002498, 250 )
					AddItem( sceneId, 38002499, 250 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取兽魂及武道材料")
			elseif GetNumText() == 10010 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 38002540, 250 )
					AddItem( sceneId, 38002541, 250 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"领取成功")	
			elseif GetNumText() == 10005 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 30505906, 1 )
					AddItem (sceneId,30505908,250)
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取连戎神节7级和神兵符3级。")
			elseif GetNumText() == 10012 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 30700226, 1 )
					AddItem( sceneId, 30700227, 1 )
					AddItem( sceneId, 30700228, 1 )
					AddItem( sceneId, 30700229, 1 )
					AddItem( sceneId, 30700222, 1 )
					AddItem( sceneId, 30700223, 1 )
					AddItem( sceneId, 30700224, 1 )
					AddItem( sceneId, 30700225, 1 )
					AddItem( sceneId, 30700214, 1 )
					AddItem( sceneId, 30700215, 1 )
					AddItem( sceneId, 30700216, 1 )
					AddItem( sceneId, 30700217, 1 )
					AddItem( sceneId, 30700218, 1 )
					AddItem( sceneId, 30700219, 1 )
					AddItem( sceneId, 30700220, 1 )
					AddItem( sceneId, 30700221, 1 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取武魂技能书相关材料。")	
			elseif GetNumText() == 10013 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 10155002, 1 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取暗器冰魄神针。")
			elseif GetNumText() == 10014 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 30120028, 1 )
					AddItem( sceneId, 30120023, 1 )
					AddItem( sceneId, 30120042, 1 )
					AddItem( sceneId, 30120041, 1 )
					AddItem( sceneId, 30120010, 1 )
					AddItem( sceneId, 30120008, 1 )
					AddItem( sceneId, 30120050, 1 )
					AddItem( sceneId, 30120014, 1 )
					AddItem( sceneId, 30120015, 1 )
					AddItem( sceneId, 30120016, 1 )
					AddItem( sceneId, 30120017, 1 )
					AddItem( sceneId, 30120035, 1 )
					AddItem( sceneId, 30120036, 1 )
					AddItem( sceneId, 30120037, 1 )
					AddItem( sceneId, 30120038, 1 )
					AddItem( sceneId, 30120066, 1 )
					AddItem( sceneId, 30120067, 1 )
					AddItem( sceneId, 30120068, 1 )
					AddItem( sceneId, 30120069, 1 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取雕纹相关材料。")
			elseif GetNumText() == 10015 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 20600000, 10 )
					AddItem( sceneId, 20600001, 10 )
					AddItem( sceneId, 20600002, 10 )
					AddItem( sceneId, 20600003, 10 )
					AddItem( sceneId, 20600004, 10 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取长春玉。")
			elseif GetNumText() == 10016 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 38002986, 10 )
					AddItem( sceneId, 38002969, 10 )
					AddItem( sceneId, 38002970, 10 )
					AddItem( sceneId, 38002971, 10 )
					AddItem( sceneId, 20900001, 100 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取七情刃礼盒。")	
			elseif GetNumText() == 10017 then
				BeginAddItem(sceneId)
					AddItem( sceneId,30900200,1)
					AddItem( sceneId,30900201,1)
					AddItem( sceneId,30900202,1)
					AddItem( sceneId,30900203,1)
					AddItem( sceneId,30900204,1)
					AddItem( sceneId,30900205,1)
					AddItem( sceneId,30900206,1)
					AddItem( sceneId,30900207,1)
					AddItem( sceneId,30900208,1)
					AddItem( sceneId,30900209,1)
					AddItem( sceneId,30900210,1)
					AddItem( sceneId,30900211,1)
					AddItem( sceneId,30900212,1)
					AddItem( sceneId,30900213,1)
					AddItem( sceneId,38003161,5)
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取雕纹精绘相关材料。")	
			
			elseif GetNumText() == 10018 then
				BeginAddItem(sceneId)
					AddItem( sceneId,10126718,1)
					AddItem( sceneId,10126034,1)
					AddItem( sceneId,10126850,1)
					AddItem( sceneId,10125383,1)
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取最新限定时装。")	
			elseif GetNumText() == 10019 then
				BeginAddItem(sceneId)
					AddItem( sceneId,38003679,1) --眠云卧月
					AddItem( sceneId,30505170,1) --飞火流星
					AddItem( sceneId,38003669,1) --怜骨生花
					AddItem( sceneId,38003215,1) --如意金箍棒
					AddItem( sceneId,38003216,1) --紫青宝剑
					AddItem( sceneId,38003217,1) --芭蕉灵扇
					AddItem( sceneId,38003707,1) --青龙偃月刀
					AddItem( sceneId,38003449,1) --断离愁
					AddItem( sceneId,38003450,1) --狼烟乱
					AddItem( sceneId,38003024,1) --混天玄戟
					AddItem( sceneId,38003670,1) --剑意浓
					AddItem( sceneId,38003671,1) --湖心曲
					AddItem( sceneId,38003680,1) --碎星垣
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取最新限定武器。")	
			elseif GetNumText() == 10020 then
				BeginAddItem(sceneId)
					AddItem( sceneId,20307291,1)  --百烈发型图
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取最新限定发型。")	
			elseif GetNumText() == 10021 then
				BeginAddItem(sceneId)
					AddItem( sceneId,38003345,1) --护耳绒帽
					AddItem( sceneId,38003466,1) --戍月神君
					AddItem( sceneId,38003558,1) --烁影浮光
					AddItem( sceneId,38003585,1) --繁花织夏
					AddItem( sceneId,38003586,1) --夏日豹豹冰
					AddItem( sceneId,38003659,1) --兰若幽帘
					AddItem( sceneId,38003694,1) --角龙滚滚
					AddItem( sceneId,38003696,1) --五载同行
					AddItem( sceneId,38003723,1) --熊赳赳
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取最新限定头饰。")	
			elseif GetNumText() == 10022 then
				BeginAddItem(sceneId)
					AddItem( sceneId,38003260,1) --月光宝盒
					AddItem( sceneId,38003321,1) --冰峰
					AddItem( sceneId,38003382,1) --美丽冻梨
					AddItem( sceneId,38003425,1) --赤夜凰影
					AddItem( sceneId,38003657,1) --龙佑九州
					AddItem( sceneId,38003583,1) --金羽剑匣
					AddItem( sceneId,38003584,1) --银霜剑匣
					AddItem( sceneId,38003586,1) --夏日豹豹冰
					AddItem( sceneId,38003656,1) --诗画录
					AddItem( sceneId,38003673,1) --无忧梦
					AddItem( sceneId,38003681,1) --金阙宝葫
					AddItem( sceneId,38003682,1) --紫霄宝葫
					AddItem( sceneId,38003690,1) --角龙圆圆
					AddItem( sceneId,38003724,1) --冬夜小熊
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取最新限定头饰。")	
			elseif GetNumText() == 10004 then
				local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
				-- if nExchPoint < x002084_g_TestNeedPoint then
					-- x002084_NotifyFailBox(sceneId,selfId,targetId,"尚未达到预充最低领取要求。")
					-- return
				-- end
				if YuanBao(sceneId,selfId,targetId,3,0) + 1000000 > 2000000000 then
					x002084_NotifyFailBox(sceneId,selfId,targetId,"所携带元宝过多，请消耗一些再来领取。")
					return
				end
				if BindYuanBao(sceneId,selfId,targetId,3,0) + 1000000 > 2000000000 then
					x002084_NotifyFailBox(sceneId,selfId,targetId,"所携带绑定元宝过多，请消耗一些再来领取。")
					return
				end
				YuanBao(sceneId,selfId,targetId,1,1000000)
				BindYuanBao(sceneId,selfId,targetId,1,1000000)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取100W元宝和绑定元宝。")
				return
			elseif GetNumText() == 10006 then
				AddExp(sceneId,selfId,5000000)
				x002084_NotifyFailBox(sceneId,selfId,targetId,"成功领取500W经验")
			elseif GetNumText() == 10011 then
				if GetLevel(sceneId,selfId) < 10 then
					x002084_NotifyFailTips( sceneId, selfId, "等级小于10级无法直升102级" )
					return
				end
				if GetMenPai(sceneId,selfId) == MP_WUMENPAI then
					x002084_NotifyFailTips( sceneId, selfId, "请你至少加入一个门派后再来直升102级" )
					return
				end
				if GetLevel(sceneId,selfId) >= 102 then
					x002084_NotifyFailTips( sceneId, selfId, "你的等级已经不需要直升了，请回吧" )
					return
				end
				LuaFnHumanLevelUpTo(sceneId,selfId,102)
			end
		-- end
	-- end
	
	if GetNumText() == 10008 then
		if GetGuildPos( sceneId, selfId ) == GUILD_POSITION_CHIEFTAIN then
			if YuanBao(sceneId,selfId,targetId,3,0) < 2000 then
				x002084_NotifyFailBox(sceneId,selfId,targetId,"所携带元宝不足2000点，无法购买帮派扩张值。")
				return
			end
			LuaFnCostYuanBao(sceneId,selfId,2000,2084,"OnEventRequest",0,0)
			x002084_NotifyFailBox(sceneId,selfId,targetId,"购买20点帮派扩张值成功。")
			CityChangeAttr( sceneId, selfId, GUILD_AMBI_LEVEL, 20 )
		else
			x002084_NotifyFailBox(sceneId,selfId,targetId,"你不是帮主，无法进行此操作。")
			return
		end
	end

	if GetNumText() == 520 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{TLWS_20200908_05}" )
			AddNumText( sceneId, x002084_g_scriptId, "#{TLWS_20200908_06}", 11, 521 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )		
	elseif GetNumText() == 521 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{TLWS_20200908_11}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )		
	end

	if x002084_g_NewCardListEx[GetNumText()] then
		x002084_GetNewCardPrize666( sceneId, selfId, targetId, GetNumText())
	elseif GetNumText() == 101 then
--		x002084_AddNewUserCardNumText(sceneId,selfId,targetId)
		--打开输入财富卡卡号界面
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20100118 )
	elseif GetNumText() == 102 then
		if GetMissionFlag(sceneId,selfId,MF_ActiveNewUserCard666) ~= 1 then
			x002084_NotifyFailBox( sceneId, selfId, targetId, "#{TLWS_20200908_26}" )
			return
		end
		BeginEvent( sceneId )
			AddNumText( sceneId, x002084_g_scriptId, "#{TLWS_20200908_74}", 2, 103 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )		
	elseif GetNumText() == 103 then
		x002084_AddNewUserCardNumText666(sceneId,selfId,targetId)
	end
		
	for i, eventId in x002084_g_eventList do		
		CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
		--return --警告：在没有条件处理的情况下，循环中慎用return
	end	
	
end

--**********************************
-- 领财富卡奖品666
--**********************************
function x002084_GetNewCardPrize666( sceneId, selfId, targetId, grade )
	local awardInfo = x002084_g_NewCardListEx[grade]
	if not awardInfo then
		return
	end
	if GetMissionFlag( sceneId, selfId, awardInfo.flagBit ) == 1 then
		x002084_NotifyFailBox( sceneId, selfId, targetId, awardInfo.redundantMsg )
		return													-- 领过了
	end

	if GetMissionFlag( sceneId, selfId, MF_ActiveNewUserCard666 ) ~= 1 then
		x002084_NotifyFailBox( sceneId, selfId, targetId, "    你暂时无法领取到奖励。" )
		return
	end

	if GetLevel( sceneId, selfId ) < awardInfo.needLevel then
		x002084_NotifyFailBox( sceneId, selfId, targetId, "    嗯，你的等级不够，待等级达到" .. awardInfo.needLevel .. "级再来找我吧。" )
		return
	end

	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < awardInfo.PropBagSpaceNeed then
		x002084_NotifyFailBox( sceneId, selfId, targetId, "    你的背包道具栏至少需要留出" .. awardInfo.PropBagSpaceNeed .. "格。" )
		return
	end

	if LuaFnGetMaterialBagSpace( sceneId, selfId ) < awardInfo.MatBagSpaceNeed then
		x002084_NotifyFailBox( sceneId, selfId, targetId, "    你的背包材料栏至少需要留出" .. awardInfo.MatBagSpaceNeed .. "格。" )
		return
	end

	if LuaFnGetTaskItemBagSpace( sceneId, selfId ) < awardInfo.TaskBagSpaceNeed then
		x002084_NotifyFailBox( sceneId, selfId, targetId, "    你的背包任务栏至少需要留出" .. awardInfo.TaskBagSpaceNeed .. "格。" )
		return
	end
	
	--if grade == x002084_g_NewCard3_666 then
		--if TryCreatePet(sceneId,selfId,1) <= 0 then
			--x002084_NotifyFailBox( sceneId, selfId, targetId, "    您携带的珍兽已满，您可以放生一个珍兽留出空位。" )
			--return
		--end
	--end
	--珍兽操作
	if awardInfo.petdata ~= 0 then
		--判断珍兽背包是否有空格。
		local checkCreatePet = TryCreatePet(sceneId, selfId, 1);
		if not checkCreatePet or checkCreatePet ~= 1 then
			x002084_NotifyFailBox(sceneId, selfId,targetId, "#{TLWS_20200908_44}。");
			return
		end
		LuaFnCreatePetToHuman(sceneId, selfId, awardInfo.petdata, 1, 0)
	end
	local itemSN, itemName, itemDesc, bBroadCast
	for i, row in awardInfo.itemAward.hashTable do
		local itemSN, itemName, itemDesc, bBroadCast = GetOneMissionBonusItem( row )
		if itemSN > -1 then							-- 放不下就没有了
			LuaFnTryRecieveSingleItem( sceneId, selfId, itemSN, QUALITY_MUST_BE_CHANGE,1)
		end
	end

	for i, itemSN in awardInfo.itemAward.itemList do
		LuaFnTryRecieveSingleItem( sceneId, selfId, itemSN, QUALITY_MUST_BE_CHANGE,1)
	end

	if awardInfo.moneyReward > 0 then
		if grade == x002084_g_NewCard4_666 or grade == x002084_g_NewCard5_666 or grade == x002084_g_NewCard6_666 or grade == x002084_g_NewCard7_666 or grade == x002084_g_NewCard8_666 then
			ZengDian(sceneId,selfId,targetId,1,awardInfo.moneyReward)
		else
			AddMoney( sceneId, selfId, awardInfo.moneyReward )
		end
	end
	--给套装得操作
	local nMenPai = GetMenPai(sceneId,selfId)
	if awardInfo.taozhuang ~= 0 then
		for i = 1,getn(awardInfo.taozhuang[nMenPai + 1]) do
			LuaFnTryRecieveSingleItem( sceneId, selfId, awardInfo.taozhuang[nMenPai + 1][i], QUALITY_MUST_BE_CHANGE,1)
		end
	end

	if grade >= 51 then
		SetMissionFlagEx( sceneId, selfId, awardInfo.flagBit, 1 )
	else
		SetMissionFlag( sceneId, selfId, awardInfo.flagBit, 1 )
	end
	x002084_NotifyFailBox( sceneId, selfId, targetId, awardInfo.recvMsg )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x002084_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x002084_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
