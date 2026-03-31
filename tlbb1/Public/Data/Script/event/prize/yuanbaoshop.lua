--新的元宝商店

x888902_g_scriptId = 888902
--元宝商店列表 要与客户端界面对应
x888902_g_shoplist = {}
x888902_g_shoplist[1]	= {188, 189, 197}				--大卖场
x888902_g_shoplist[2]	= { 150, 254,255,178, 198, 193}			--宝石商城,添加"大理宝石斋--149",czf,2009.07.21
x888902_g_shoplist[3]	= {194, 135, 152, 195}			--珍兽商城
x888902_g_shoplist[4]	= {136, 137, 248,144}				--南北杂货
x888902_g_shoplist[5]	= {120, 247, 181, 145, 182, 134}			--形象广场
x888902_g_shoplist[6]	= {133}				--190, 191, 192, 花舞人间
x888902_g_shoplist[7]	= {146}						--武功秘籍
x888902_g_shoplist[8]	= {156, 157, 158, 159, 160, 161, 162, 163}	--打造图
x888902_g_shoplist[9]	= {149,150, 178, 198, 194, 136}			--我要更强大
x888902_g_shoplist[10]	= {134, 120, 181, 145, 182}			--我要更有魅力
x888902_g_shoplist[11]	= {149,150, 178, 193, 137}			--我要打造极品装备
x888902_g_shoplist[12]	= {194, 135, 152, 195}				--我要打造极品珍兽
x888902_g_shoplist[13]	= {134, 144}					--我要移动的更快
x888902_g_shoplist[14]	= {191, 192, 133, 120, 134}			--我要向别人表白
x888902_g_shoplist[15]	= {146, 135, 152}				--我要学习新技能
--绑定元宝商店列表
x888902_g_BindShopList = {}
x888902_g_BindShopList[1] = {209}
x888902_g_BindShopList[2] = {212,211,210,215}
x888902_g_BindShopList[3] = {216}
x888902_g_BindShopList[4] = {217,218,219}	--南北奇货

--**********************************
-- 检查此随身NPC的功能
-- op是请求类别，比如1代表元宝相关的随身操作……
--**********************************
function x888902_OpenYuanbaoShop( sceneId, selfId, targetId , shopA ,shopB )

-- LuaFnItemBind(sceneId,selfId,0)

-- local strMail = format("你种植的植物已经成熟了，请在%d分钟内，在#G%s(%d,%d)#W处收获。",( 300000 / 60000 ), GetSceneName(sceneId), 123, 155 )
-- LuaFnSendMailToGUID( sceneId, "100000004", strMail )

		-- print(LuaFnGetEquipAttrHidden(sceneId, selfId, 2))
-- SetMissionData(sceneId, selfId, 388,277)
 -- SetMissionData(sceneId, selfId, 388,271)
 -- print(GetMissionData(sceneId, selfId, 388))
-- SetMissionData(sceneId, selfId, MD_QIEGE_SH,500)

-- LuaFnGMForceDestroyGuildOffline(sceneId, 100000002, 2)
-- LuaFnDestroyGuild(sceneId, selfId, 3)
-- LuaFnSetEquipEnhanceLevel(sceneId, selfId, 0,99)
	-- for i=0,4096 do
		-- DelMission( sceneId, selfId, i )
	-- end

-- MissionCom( sceneId, selfId, 2359 )

-- LuaFnJoinMenpai(sceneId, selfId, selfId,11)

 -- LuaFnModifyMenPaiToNew(sceneId,selfId,11)

-- LuaFnDestroyGuild(sceneId, selfId)

-- TryRecieveItem( sceneId, selfId, 10134765, 1)
-- TryRecieveItem( sceneId, selfId, 10134823, 1)
-- TryRecieveItem( sceneId, selfId, 10134877, 1)
-- TryRecieveItem( sceneId, selfId, 10134941, 1)
-- TryRecieveItem( sceneId, selfId, 10134943, 1)
-- TryRecieveItem( sceneId, selfId, 10134944, 1)
-- TryRecieveItem( sceneId, selfId, 10134950, 1)
-- TryRecieveItem( sceneId, selfId, 10134953, 1)
-- TryRecieveItem( sceneId, selfId, 10134954, 1)
-- TryRecieveItem( sceneId, selfId, 10134985, 1)
-- TryRecieveItem( sceneId, selfId, 10135054, 1)
-- TryRecieveItem( sceneId, selfId, 10135165, 1)
-- TryRecieveItem( sceneId, selfId, 10135239, 1)
-- TryRecieveItem( sceneId, selfId, 10135256, 1)
-- TryRecieveItem( sceneId, selfId, 10136036, 1)
-- TryRecieveItem( sceneId, selfId, 10136053, 1)
-- TryRecieveItem( sceneId, selfId, 10136132, 1)
-- TryRecieveItem( sceneId, selfId, 10136146, 1)
-- TryRecieveItem( sceneId, selfId, 10136147, 1)
-- TryRecieveItem( sceneId, selfId, 10136148, 1)
-- TryRecieveItem( sceneId, selfId, 10136149, 1)
-- TryRecieveItem( sceneId, selfId, 10136150, 1)
-- TryRecieveItem( sceneId, selfId, 10136151, 1)
-- TryRecieveItem( sceneId, selfId, 10136152, 1)
-- TryRecieveItem( sceneId, selfId, 10136153, 1)
-- TryRecieveItem( sceneId, selfId, 10136154, 1)
-- TryRecieveItem( sceneId, selfId, 10136155, 1)
-- TryRecieveItem( sceneId, selfId, 10136156, 1)
-- TryRecieveItem( sceneId, selfId, 10136157, 1)
-- TryRecieveItem( sceneId, selfId, 10136158, 1)
-- TryRecieveItem( sceneId, selfId, 10136159, 1)
-- TryRecieveItem( sceneId, selfId, 10136160, 1)
-- TryRecieveItem( sceneId, selfId, 10136161, 1)
-- TryRecieveItem( sceneId, selfId, 10136162, 1)
-- TryRecieveItem( sceneId, selfId, 10136163, 1)
-- TryRecieveItem( sceneId, selfId, 10136164, 1)
-- TryRecieveItem( sceneId, selfId, 10136180, 1)
-- TryRecieveItem( sceneId, selfId, 10136196, 1)
-- TryRecieveItem( sceneId, selfId, 10136219, 1)
-- TryRecieveItem( sceneId, selfId, 10136235, 1)
-- TryRecieveItem( sceneId, selfId, 10136236, 1)
-- TryRecieveItem( sceneId, selfId, 10136252, 1)
-- TryRecieveItem( sceneId, selfId, 10136268, 1)
-- TryRecieveItem( sceneId, selfId, 10136284, 1)
-- TryRecieveItem( sceneId, selfId, 10136310, 1)
-- TryRecieveItem( sceneId, selfId, 10136327, 1)
-- TryRecieveItem( sceneId, selfId, 10136356, 1)
-- TryRecieveItem( sceneId, selfId, 10136372, 1)
-- TryRecieveItem( sceneId, selfId, 10136388, 1)
-- TryRecieveItem( sceneId, selfId, 10136404, 1)
-- TryRecieveItem( sceneId, selfId, 10136420, 1)
-- TryRecieveItem( sceneId, selfId, 10136438, 1)
-- TryRecieveItem( sceneId, selfId, 10136460, 1)
-- TryRecieveItem( sceneId, selfId, 10136482, 1)
-- TryRecieveItem( sceneId, selfId, 10136498, 1)
-- TryRecieveItem( sceneId, selfId, 10136501, 1)
-- TryRecieveItem( sceneId, selfId, 10136525, 1)
-- TryRecieveItem( sceneId, selfId, 10136541, 1)
-- TryRecieveItem( sceneId, selfId, 10136570, 1)
-- TryRecieveItem( sceneId, selfId, 10136586, 1)
-- TryRecieveItem( sceneId, selfId, 10136603, 1)
-- TryRecieveItem( sceneId, selfId, 10136619, 1)
-- TryRecieveItem( sceneId, selfId, 10136635, 1)
-- TryRecieveItem( sceneId, selfId, 10136645, 1)
-- TryRecieveItem( sceneId, selfId, 10136669, 1)
-- TryRecieveItem( sceneId, selfId, 10136686, 1)
-- TryRecieveItem( sceneId, selfId, 10136702, 1)
-- TryRecieveItem( sceneId, selfId, 10136737, 1)
-- TryRecieveItem( sceneId, selfId, 10136753, 1)
-- TryRecieveItem( sceneId, selfId, 10136789, 1)
-- TryRecieveItem( sceneId, selfId, 10136813, 1)
-- TryRecieveItem( sceneId, selfId, 10136829, 1)
-- TryRecieveItem( sceneId, selfId, 10136853, 1)
-- TryRecieveItem( sceneId, selfId, 10136861, 1)
-- TryRecieveItem( sceneId, selfId, 10136887, 1)
-- TryRecieveItem( sceneId, selfId, 10136914, 1)
-- TryRecieveItem( sceneId, selfId, 10136941, 1)
-- TryRecieveItem( sceneId, selfId, 10136957, 1)
-- TryRecieveItem( sceneId, selfId, 10136975, 1)

-- TryRecieveItem( sceneId, selfId, 10136991, 1)
-- TryRecieveItem( sceneId, selfId, 10137024, 1)
-- TryRecieveItem( sceneId, selfId, 10137043, 1)
-- TryRecieveItem( sceneId, selfId, 10137060, 1)
-- TryRecieveItem( sceneId, selfId, 10137095, 1)
-- TryRecieveItem( sceneId, selfId, 10137169, 1)
-- TryRecieveItem( sceneId, selfId, 10137185, 1)
-- TryRecieveItem( sceneId, selfId, 10137220, 1)
-- TryRecieveItem( sceneId, selfId, 10137236, 1)
-- TryRecieveItem( sceneId, selfId, 10137254, 1)
-- TryRecieveItem( sceneId, selfId, 10137272, 1)
-- TryRecieveItem( sceneId, selfId, 10137290, 1)
-- TryRecieveItem( sceneId, selfId, 10137358, 1)
-- TryRecieveItem( sceneId, selfId, 10137418, 1)
-- TryRecieveItem( sceneId, selfId, 10137419, 1)
-- TryRecieveItem( sceneId, selfId, 10137477, 1)
-- TryRecieveItem( sceneId, selfId, 10137510, 1)
-- TryRecieveItem( sceneId, selfId, 10137544, 1)
-- TryRecieveItem( sceneId, selfId, 10137561, 1)
-- TryRecieveItem( sceneId, selfId, 10137611, 1)
-- TryRecieveItem( sceneId, selfId, 10137675, 1)
-- TryRecieveItem( sceneId, selfId, 10137725, 1)
-- TryRecieveItem( sceneId, selfId, 10137741, 1)
-- TryRecieveItem( sceneId, selfId, 10137822, 1)
-- TryRecieveItem( sceneId, selfId, 10138085, 1)
-- TryRecieveItem( sceneId, selfId, 10138117, 1)
-- TryRecieveItem( sceneId, selfId, 10138125, 1)
-- TryRecieveItem( sceneId, selfId, 10138215, 1)
-- TryRecieveItem( sceneId, selfId, 10138299, 1)
-- TryRecieveItem( sceneId, selfId, 10138319, 1)
-- TryRecieveItem( sceneId, selfId, 10138335, 1)
-- TryRecieveItem( sceneId, selfId, 10138371, 1)
-- TryRecieveItem( sceneId, selfId, 10138488, 1)
-- TryRecieveItem( sceneId, selfId, 10138520, 1)
-- TryRecieveItem( sceneId, selfId, 10138552, 1)
-- TryRecieveItem( sceneId, selfId, 10138618, 1)

-- print("周:\t",GetWeekTime())
-- print("天数和时刻:\t",GetQuarterTime())
-- print("时间戳:\t",LuaFnGetCurrentTime())
-- print("年月日:\t",GetTime2Day())
-- print("当前时间的天数:\t",GetDayTime())
-- print("秒:\t",GetSecond())
-- print("时:\t",GetHourTime())
-- print("World:\t",LuaFnGetCurrentWorldTime())

-- print("TodayWeek:\t",GetTodayWeek())
-- print("TodayMonth:\t",GetTodayMonth())
-- print("TodayYear:\t",GetTodayYear())
-- print("TodayDate:\t",GetTodayDate())

-- print("Current:\t",LuaFnGetCurrentDateTime())
-- print("Current:\t",LuaFnGetCurrentDateDiffTime ())
-- print("This:\t",LuaFnGetThisYear())
-- print("This:\t",LuaFnGetThisMonth())
-- print("This:\t",LuaFnGetThisWeekDay())
-- print("This:\t",LuaFnGetDayOfThisMonth ())


-- local currentTime = LuaFnGetCurrentTime(sceneId, selfId)  -- 获取当前时间戳
-- local count = LuaFnActiveAllExteriorWeapons(sceneId, selfId,-1)--,currentTime + 10
-- print(count)

-- for i=38010001,38010050 do
	-- TryRecieveItem(sceneId,selfId,i,1,0)
-- end

-- for i=38010051,38010100 do
	-- TryRecieveItem(sceneId,selfId,i,1,0)
-- end

-- for i=38010101,38010152 do
	-- TryRecieveItem(sceneId,selfId,i,1,0)
-- end

-- for i=38002608,38002621 do
	-- TryRecieveItem(sceneId,selfId,i,1,0)
-- end

-- for i=38002626,38002630 do
	-- TryRecieveItem(sceneId,selfId,i,1,0)
-- end
-- TryRecieveItem(sceneId,selfId,38002963,1,0)
-- TryRecieveItem(sceneId,selfId,38002994,1,0)
-- TryRecieveItem(sceneId,selfId,38003019,1,0)
-- TryRecieveItem(sceneId,selfId,38003020,1,0)
-- TryRecieveItem(sceneId,selfId,38003021,1,0)
-- TryRecieveItem(sceneId,selfId,38003022,1,0)
-- TryRecieveItem(sceneId,selfId,38003023,1,0)
-- TryRecieveItem(sceneId,selfId,38003024,1,0)
-- TryRecieveItem(sceneId,selfId,38003322,1,0)
-- TryRecieveItem(sceneId,selfId,38003323,1,0)
-- TryRecieveItem(sceneId,selfId,38003707,1,0)
-- TryRecieveItem(sceneId,selfId,38003718,1,0)
-- TryRecieveItem(sceneId,selfId,38003728,1,0)
-- TryRecieveItem(sceneId,selfId,38003731,1,0)
-- TryRecieveItem(sceneId,selfId,38003767,1,0)
-- TryRecieveItem(sceneId,selfId,38003693,1,0)
-- TryRecieveItem(sceneId,selfId,38003669,1,0)
-- TryRecieveItem(sceneId,selfId,38003672,1,0)
-- TryRecieveItem(sceneId,selfId,38003671,1,0)
-- TryRecieveItem(sceneId,selfId,38003670,1,0)
-- TryRecieveItem(sceneId,selfId,38003609,1,0)
-- TryRecieveItem(sceneId,selfId,38003450,1,0)
-- TryRecieveItem(sceneId,selfId,38003449,1,0)
-- TryRecieveItem(sceneId,selfId,38003448,1,0)
-- TryRecieveItem(sceneId,selfId,38010141,1,0)
-- TryRecieveItem(sceneId,selfId,38003327,1,0)
-- TryRecieveItem(sceneId,selfId,38003215,1,0)
-- TryRecieveItem(sceneId,selfId,38003214,1,0)
-- TryRecieveItem(sceneId,selfId,38003216,1,0)
-- TryRecieveItem(sceneId,selfId,38003217,1,0)
-- TryRecieveItem(sceneId,selfId,38003377,1,0)
-- TryRecieveItem(sceneId,selfId,38003587,1,0)
-- TryRecieveItem(sceneId,selfId,38003604,1,0)
-- TryRecieveItem(sceneId,selfId,38003582,1,0)
-- TryRecieveItem(sceneId,selfId,38003664,1,0)
-- TryRecieveItem(sceneId,selfId,38003680,1,0)


	-- SetMissionData(sceneId,selfId,MD_BaiBingJingTong,0)
-- if GetName(sceneId, selfId) == "枫红" then
	-- print(LuaFnSetEquipSlot(sceneId, selfId, 0,2))
	-- print(LuaFnGetItemQual(sceneId, selfId, 0))
	-- LuaFnSetnotSayTime(sceneId, selfId, 66)
	-- LuaFnDelnotSayTime(sceneId, selfId)
	-- LuaFnClearAllXiuLianMijiLevel(sceneId, selfId,10)
	-- local strMail = format("你种植的植物已经成熟了，请在%d分钟内，在#G%s(%d,%d)#W处收获。",( 300000 / 60000 ), GetSceneName(sceneId), 123, 155 )
-- LuaFnSendMailToGUID( sceneId, GetHumanGUID(sceneId,selfId), strMail )
	 -- CityChangeAttr( sceneId, selfId, GUILD_CONTRIB_POINT, -2 );
	 -- -- LuaFnDestroyGuild(sceneId, selfId)
	 -- for i=38010105,38010150 do
	-- local nBagIndex = TryRecieveItem(sceneId,selfId,i,1,0)
	-- end
	-- print(nBagIndex)
	-- LuaFnItemBind(sceneId,selfId,nBagIndex)
	-- LuaFnSetItemCreator( sceneId, selfId,0,"&SQ2810011110000110000001")
	 -- LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,2274,0) --2274 109
	 

	 -- LuaFnReloadScript(sceneId,selfId)
-- end

	-- LuaFnHumanLevelUpTo(sceneId,selfId,119)
	-- LuaFnWashPoints(sceneId, selfId)
	-- LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,109,0)
	
	-- LuaFnRefreshViewChar( sceneId, selfId )
	
	
	
	-- SetMissionFlag( sceneId, selfId,MF_IS_BAN_EXCHANGE,1)
	
	-- LuaFnReloadBaoBuyBindYuanShopItems(sceneId,selfId)
	
		-- LuaFnJoinMenpai(sceneId, selfId, 0)
	
	
	-- LuaFnRefreshScript(sceneId,selfId,808339)
	-- LuaFnReloadDropTables(sceneId,selfId)
	-- LuaFnReloadShopTables(sceneId,selfId)
	-- print(LuaFnGetAccountName(sceneId,selfId))
	
	-- print(GetTime2Day())
	
	
	-- YuanBao(sceneId,selfId,-1,1,100000)  
	
	-- SetMissionDataEx(sceneId, selfId, SYS_MAX_HP,5001 )
	 
	-- for i=1,300 do
	-- TryRecieveItem( sceneId, selfId, 30504640, 1)
	-- end
	
	-- AddMoney(sceneId,selfId,111111111)
	-- for i=50,100 do
		-- LuaFnSetXinFaLevel( sceneId, selfId, i,119)
	-- end
	-- TryRecieveItem( sceneId, selfId, 38003383, 1)
	-- TryRecieveItem( sceneId, selfId, 10126034, 1)
	-- TryRecieveItem( sceneId, selfId, 10126850, 1)
	
	
	-- TryRecieveItem( sceneId, selfId, 38003215, 1)
	-- TryRecieveItem( sceneId, selfId, 38003679, 1)
	
	-- TryRecieveItem( sceneId, selfId, 38002900, 1)
	-- TryRecieveItem( sceneId, selfId, 10142873, 1)
	
	-- LuaFnCreateMonster(sceneId, 3882, 155, 155, 3, -1, 999999)
	
	
	-- local nMonsterNum = GetMonsterCount(sceneId)
		-- for i=0, nMonsterNum-1 do
			-- local MonsterId = GetMonsterObjID(sceneId,i)
            -- local MosDataID = GetMonsterDataID( sceneId, MonsterId )
            -- if MosDataID == 3882 then
                 -- LuaFnDeleteMonster(sceneId, MonsterId)
			-- end       
		-- end
	
	local bCheck = x888902_YuanbaoShopCheckOp(sceneId,selfId);
	
	if bCheck > 0 then
		if shopA > 0 and shopA < 16 and x888902_g_shoplist[shopA][shopB] ~= nil then
			--PrintStr(x888902_g_shoplist[shopA][shopB])
			if targetId == -1 then
				DispatchYuanbaoShopItem( sceneId, selfId, x888902_g_shoplist[shopA][shopB])
			else
				DispatchNpcYuanbaoShopItem( sceneId, selfId, targetId , x888902_g_shoplist[shopA][shopB])
			end
		end
		if shopA > 100 and shopA <= 104 then
			shopA = shopA - 100;
			if x888902_g_BindShopList[shopA][shopB] ~= nil then
				if targetId == -1 then
					DispatchYuanbaoShopItem( sceneId, selfId, x888902_g_BindShopList[shopA][shopB])
				else
					DispatchNpcYuanbaoShopItem( sceneId, selfId, targetId , x888902_g_BindShopList[shopA][shopB])
				end
			end
		end
	end
end

function x888902_YuanbaoShopCheckOp(sceneId,selfId)
	--地府
	if sceneId == 77 then 
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:地府里不能使用随身功能", 0);
		return 0
	end
	--组队跟随
	local selfHasTeamFlag = LuaFnHasTeam(sceneId, selfId);
	if selfHasTeamFlag and selfHasTeamFlag == 1 then
		local teamFollowFlag = IsTeamFollow(sceneId,selfId);
		local teamLeaderFlag = LuaFnIsTeamLeader(sceneId,selfId);
		if not teamLeaderFlag or not teamFollowFlag then
			return 0
		end
		if teamFollowFlag ~= 0 and teamLeaderFlag ~= 1 then
			return 0
		end
	end
	--双人骑乘
	local selfHasDRideFlag = LuaFnGetDRideFlag(sceneId, selfId);
	if selfHasDRideFlag and selfHasDRideFlag == 1 then
		local selfIsDRideMountOwner = LuaFnIsDRideMountOwner(sceneId, selfId);
		if not selfIsDRideMountOwner or selfIsDRideMountOwner ~= 1 then
			--处于双人骑乘状态，且是被动的，交给主动方来处理
			return 0
		end
	end
	--15级以上
	local level = GetLevel(sceneId,selfId);
	if nil == level or level < 15 then
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:此功能只有当您的等级大于等于15级的时候方可使用", 0);
		return 0
	else

		return 1
	end
	return 0
end
