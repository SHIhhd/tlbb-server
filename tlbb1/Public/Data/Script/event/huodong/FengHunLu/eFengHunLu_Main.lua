--封魂录主系统

--脚本号
x791010_g_scriptId = 791010
-- 每个玩家封魂录的持续时间
x791010_g_nTotalDays				= 14
-- 最大活动天数	
x791010_g_nMaxTotalDay			= 8 
-- 每天最大Event数量	
x791010_g_nMaxEventPerDay			= 5
-- 最大MD存储量	
x791010_g_nMaxSavePos				= 32
-- 最大点数奖励等级
x791010_g_nMaxPointRewardLevel	= 5
-- 最大点数
x791010_g_nMaxPoint				= 40
-- 埋点的索引信息
x791010_g_MDIndex = {MDEX_PETSOUL_FENGHUNLU_POS1,MDEX_PETSOUL_FENGHUNLU_POS2}
-- 埋点的奖励领取索引信息
x791010_g_MDPrizeIndex = {MDEX_PETSOUL_FENGHUNLU_AWORD1,MDEX_PETSOUL_FENGHUNLU_AWORD2}

-- 埋点事件的存储索引信息
-- nSaveMD 存储MD nSavePosStart 埋点在本MD的起始索引 
-- nSaveLen 埋点占用的bit数 nMaxValue 埋点数据最大值(严格小于等于(2^nSaveLen) - 1，并且留出了一定得弹性空间)
-- 参考1 回流英雄之路 #define HEROESRETURNS_TASK_INDEX_0		0	// 添加1个好友 等
-- 参考2 战江湖 892664
x791010_g_tabMaiDianSaveInfo = 
{
	[1] 	= {nSaveMDIndex = 1, nSavePosStart = 0, 	nSaveLen = 12, 	nMaxValue = 2500, },-- 1] 累计杀怪数量 4095 cpp埋点
	[2] 	= {nSaveMDIndex = 1, nSavePosStart = 12, 	nSaveLen = 5, 	nMaxValue = 20, },	-- 2] 老三环 31	
	[3] 	= {nSaveMDIndex = 1, nSavePosStart = 17, 	nSaveLen = 5, 	nMaxValue = 15, },	-- 3] 帮会任务 31
	[4] 	= {nSaveMDIndex = 1, nSavePosStart = 22, 	nSaveLen = 5, 	nMaxValue = 10, },	-- 4] 师门任务 31
	[5] 	= {nSaveMDIndex = 1, nSavePosStart = 27, 	nSaveLen = 5, 	nMaxValue = 9, },	-- 5] 燕子 31
	[6] 	= {nSaveMDIndex = 2, nSavePosStart = 0, 	nSaveLen = 3, 	nMaxValue = 4, },	-- 6] 棋局 7
	[7] 	= {nSaveMDIndex = 2, nSavePosStart = 3, 	nSaveLen = 3, 	nMaxValue = 4, },	-- 7] 快活三 7
	[8] 	= {nSaveMDIndex = 2, nSavePosStart = 6, 	nSaveLen = 3, 	nMaxValue = 2, },	-- 8] 跑商 7
	[9] 	= {nSaveMDIndex = 2, nSavePosStart = 9, 	nSaveLen = 3, 	nMaxValue = 2, },	-- 9] 科举 7
	[10] 	= {nSaveMDIndex = 2, nSavePosStart = 12, 	nSaveLen = 3, 	nMaxValue = 2, },	-- 10 前世今生 7
	[11] 	= {nSaveMDIndex = 2, nSavePosStart = 15, 	nSaveLen = 3, 	nMaxValue = 2, },	-- 11 逞凶打图 7
	[12] 	= {nSaveMDIndex = 2, nSavePosStart = 18, 	nSaveLen = 2, 	nMaxValue = 1, },	-- 12 校场比武 3 cpp埋点
	[13] 	= {nSaveMDIndex = 2, nSavePosStart = 20, 	nSaveLen = 2, 	nMaxValue = 1, },	-- 13 百变脸谱 3
}


-- 每天的事件信息 完成依赖的埋点id 埋点数据值 活得的总活动点数 最后一个暂时废弃
-- 所有负数都是特殊处理的事件，目前-1是每日活跃值
x791010_g_tabEventInfo = 
{
	-- 第1天
	-- 击杀100个怪物	1
	-- 参加1次棋局	1
	-- 完成1次我爱幸运快活三	1
	-- 完成5次帮会任务	1
	-- 今日活跃值达到100点	1
	[1] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 100, 	nGetPoint = 1, nEventIndex = 1, },
		[2] = {nMaiDianID = 6, 	nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 2, },
		[3] = {nMaiDianID = 7, 	nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 3, },
		[4] = {nMaiDianID = 3, 	nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 4, },
		[5] = {nMaiDianID = -1, nMaiDianValue = 100, 	nGetPoint = 1, nEventIndex = 5, },
	},
	-- 第2天	
	-- 击杀200个怪物	1
	-- 完成5次老三环	1
	-- 完成1次校场比武	1
	-- 完成1次跑商	1
	-- 完成5次帮会任务	1
	[2] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 200, 	nGetPoint = 1, nEventIndex = 6, },
		[2] = {nMaiDianID = 2, 	nMaiDianValue = 5, 		nGetPoint = 1, nEventIndex = 7, },
		[3] = {nMaiDianID = 12, nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 8, },
		[4] = {nMaiDianID = 8, 	nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 9, },
		[5] = {nMaiDianID = 3, 	nMaiDianValue = 5, 		nGetPoint = 1, nEventIndex = 10, },
	},

	-- 第3天	
	-- 击杀400个怪物	1
	-- 完成1次逞凶打图	1
	-- 完成1次百变脸谱	1
	-- 完成2次我爱幸运快活三	1
	-- 完成3次燕子	1
	[3] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 400, 	nGetPoint = 1, nEventIndex = 11, },
		[2] = {nMaiDianID = 11, nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 12, },
		[3] = {nMaiDianID = 13, nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 13, },
		[4] = {nMaiDianID = 7, 	nMaiDianValue = 2, 		nGetPoint = 1, nEventIndex = 14, },
		[5] = {nMaiDianID = 5, 	nMaiDianValue = 3, 		nGetPoint = 1, nEventIndex = 15, },
	},

	-- 第4天	
	-- 击杀700个怪物	1
	-- 完成10次老三环	1
	-- 完成2次棋局	1
	-- 完成1次科举	1
	-- 完成1次前世今生	1
	[4] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 700, 	nGetPoint = 1, nEventIndex = 16, },
		[2] = {nMaiDianID = 2, 	nMaiDianValue = 10, 	nGetPoint = 1, nEventIndex = 17, },
		[3] = {nMaiDianID = 6, 	nMaiDianValue = 2, 		nGetPoint = 1, nEventIndex = 18, },
		[4] = {nMaiDianID = 9, 	nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 19, },
		[5] = {nMaiDianID = 10, nMaiDianValue = 1, 		nGetPoint = 1, nEventIndex = 20, },
	},

	-- 第5天	
	-- 击杀1000个怪物	1
	-- 完成5个师门任务	1
	-- 完成2次跑商	1
	-- 完成3次我爱幸运快活三	1
	-- 完成10次帮会任务	1
	[5] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 1000, 	nGetPoint = 1, nEventIndex = 21, },
		[2] = {nMaiDianID = 4, 	nMaiDianValue = 5, 		nGetPoint = 1, nEventIndex = 22, },
		[3] = {nMaiDianID = 8, 	nMaiDianValue = 2, 		nGetPoint = 1, nEventIndex = 23, },
		[4] = {nMaiDianID = 7, 	nMaiDianValue = 3, 		nGetPoint = 1, nEventIndex = 24, },
		[5] = {nMaiDianID = 3, 	nMaiDianValue = 10, 	nGetPoint = 1, nEventIndex = 25, },
	},

	-- 第6天	
	-- 击杀1500个怪物	1
	-- 完成15次老三环	1
	-- 完成3次棋局	1
	-- 完成2次逞凶打图	1
	-- 完成6次燕子	1
	[6] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 1500, 	nGetPoint = 1, nEventIndex = 26, },
		[2] = {nMaiDianID = 2, 	nMaiDianValue = 15, 	nGetPoint = 1, nEventIndex = 27, },
		[3] = {nMaiDianID = 6, 	nMaiDianValue = 3, 		nGetPoint = 1, nEventIndex = 28, },
		[4] = {nMaiDianID = 11, nMaiDianValue = 2, 		nGetPoint = 1, nEventIndex = 29, },
		[5] = {nMaiDianID = 5, 	nMaiDianValue = 6, 		nGetPoint = 1, nEventIndex = 30, },
	},

	-- 第7天	
	-- 击杀2000个怪物
	-- 完成10个师门任务
	-- 完成4次我爱幸运快活三
	-- 完成2次科举
	-- 完成2次前世今生
	[7] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 2000, 	nGetPoint = 1, nEventIndex = 31, },
		[2] = {nMaiDianID = 4, 	nMaiDianValue = 10, 	nGetPoint = 1, nEventIndex = 32, },
		[3] = {nMaiDianID = 7, 	nMaiDianValue = 4, 		nGetPoint = 1, nEventIndex = 33, },
		[4] = {nMaiDianID = 9, 	nMaiDianValue = 2, 		nGetPoint = 1, nEventIndex = 34, },
		[5] = {nMaiDianID = 10, nMaiDianValue = 2, 		nGetPoint = 1, nEventIndex = 35, },
	},

	-- 第8天	
	-- 击杀2500个怪物
	-- 完成20次老三环
	-- 完成4次棋局
	-- 完成9次燕子
	-- 完成15次帮会任务
	[8] = 
	{
		[1] = {nMaiDianID = 1, 	nMaiDianValue = 2500, 	nGetPoint = 1, nEventIndex = 36, },
		[2] = {nMaiDianID = 2, 	nMaiDianValue = 20, 	nGetPoint = 1, nEventIndex = 37, },
		[3] = {nMaiDianID = 6, 	nMaiDianValue = 4, 		nGetPoint = 1, nEventIndex = 38, },
		[4] = {nMaiDianID = 5, 	nMaiDianValue = 9, 		nGetPoint = 1, nEventIndex = 39, },
		[5] = {nMaiDianID = 3, 	nMaiDianValue = 15, 	nGetPoint = 1, nEventIndex = 40, },
	},
}

-- 累计点数奖励信息
x791010_g_tabPointRewardInfo = 
{
	[1] = {nNeedPoint = 5, 	nRewardItemID = 38002535, nRewardItemNum = 2, nNeedBagSpace = 2, nNeedMatSpace = 0, },
	[2] = {nNeedPoint = 10, nRewardItemID = 38002535, nRewardItemNum = 2, nNeedBagSpace = 2, nNeedMatSpace = 0, },
	[3] = {nNeedPoint = 15, nRewardItemID = 38002535, nRewardItemNum = 3, nNeedBagSpace = 3, nNeedMatSpace = 0, },
	[4] = {nNeedPoint = 25, nRewardItemID = 38002535, nRewardItemNum = 3, nNeedBagSpace = 3, nNeedMatSpace = 0, },
	[5] = {nNeedPoint = 35, nRewardItemID = 38002536, nRewardItemNum = 4, nNeedBagSpace = 4, nNeedMatSpace = 0, },
}

--=========================================================
-- 客户端请求UI启动
--=========================================================
function x791010_AskOpenMainUI( sceneId, selfId )
	local nState,strTips = x791010_CheckActivityBasic(sceneId,selfId)	
	if nState == 0 then
		x791010_NotifyTips( sceneId, selfId, strTips)
        return
	end
	
	--test
--	local nTestData = GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS1)
--	
--	nTestData = LuaFnSetBitValueInUINT(nTestData,0,12,423);
--	x791010_NotifyTips( sceneId, selfId, "nTestData "..nTestData)
--	SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS1,nTestData)
	--test
	
	local _,nEndY,nEndM,nEndD = x791010_GetEndTime(sceneId,selfId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )-- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
		UICommand_AddInt( sceneId, x791010_GetCurrentDayIndex(sceneId,selfId) )--day index
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS1) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS2) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD1) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD2) )
		UICommand_AddInt( sceneId, LuaFnGetTodayActivePoint(sceneId,selfId) )
		UICommand_AddInt( sceneId, nEndY )
		UICommand_AddInt( sceneId, nEndM )
		UICommand_AddInt( sceneId, nEndD )
		
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79101001 )
end

--=========================================================
-- 玩家登录
--=========================================================
function x791010_OnPlayerLogin( sceneId, selfId )
	if GetLevel(sceneId, selfId) < 85 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0)---0是关闭1是显示
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 79101002 )
        return
    end
	--全部领取了
--	if GetMissionDataFlag(sceneId,selfId,MF_PETSOUL_PRIZE_FINISHED) == 1 then
--		return
--	end
	--这里要取当前时间生成一个结束时间
	local nStarTime = GetMissionDataEx(sceneId,selfId,MDEX_FENHUNLUDAYINDEX);
	if nStarTime <= 0 then
		nStarTime = LuaFnGetCurrentTime()
		SetMissionDataEx(sceneId,selfId,MDEX_FENHUNLUDAYINDEX,nStarTime);
--		重置MD数据
		SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS1,0 )
		SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS2,0 )
		SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD1,0 )
		SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD2,0 )
--		默认前世今生完成
--		x791010_AddPointData( sceneId, selfId ,10)
--		x791010_AddPointData( sceneId, selfId ,10)
	end
	--超过领奖时间
	local nEndANSITime = x791010_GetEndTime(sceneId,selfId)
	if LuaFnGetCurrentTime() > nEndANSITime then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0)---0是关闭1是显示
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 79101002 )
        return
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1)---0是关闭1是显示
		UICommand_AddInt( sceneId, 0 )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79101002 )
end

--=========================================================
-- 获取事件奖励
--=========================================================
function x791010_GetRewardOfEvent( sceneId, selfId,nDayIndex,nDayTimes )
	if x791010_g_tabEventInfo[nDayIndex] == nil or x791010_g_tabEventInfo[nDayIndex][nDayTimes] == nil then
		return
	end
	local nState,strTips = x791010_CheckActivityBasic(sceneId,selfId)
	if nState == 0 then
		x791010_NotifyTips( sceneId, selfId, strTips)
        return
	end
	local nCurDayIndex = x791010_GetCurrentDayIndex(sceneId,selfId)
	if nCurDayIndex > x791010_g_nMaxTotalDay then
		x791010_NotifyTips( sceneId, selfId, "#{XYSHFC_20211229_132}")
        return
	end
	if nDayIndex > nCurDayIndex then
--		x791010_NotifyTips( sceneId, selfId, "#{XYSHFC_20211229_132}")
--      return
	end
	--读取点位数据，检查其是否有资格激活
	
	local nMaiDianID 			= x791010_g_tabEventInfo[nDayIndex][nDayTimes].nMaiDianID
	local nNeedMaiDianValue 	= x791010_g_tabEventInfo[nDayIndex][nDayTimes].nMaiDianValue
	local nGetRewardPoint 		= x791010_g_tabEventInfo[nDayIndex][nDayTimes].nGetPoint
	local nEventIndex 			= x791010_g_tabEventInfo[nDayIndex][nDayTimes].nEventIndex
	local bEventRewardFlag		=  x791010_GetEventRewardFlag(sceneId, selfId,nDayIndex, nIndexOfDay)
	if bEventRewardFlag == 1 then
		x791010_NotifyTips( sceneId, selfId, "#{XYSHFC_20211229_133}")
        return
	end
	local bFinish				= 0
	local nCurMaiDianValue		= 0

	if nMaiDianID > 0 then
		-- 正常埋点
		local tableMaiDianInfo = x791010_g_tabMaiDianSaveInfo[nMaiDianID]
		if nil == tableMaiDianInfo then
			return
		end

		nCurMaiDianValue = x791010_GetMaiDianValue(sceneId, selfId,nMaiDianID)
	elseif -1 == nMaiDianID then
		-- 特写 每日活跃点数
		nCurMaiDianValue = LuaFnGetTodayActivePoint(sceneId,selfId)
		-- 已经领取了 特写成完成
		if 1 == bEventRewardFlag then
			nCurMaiDianValue = nNeedMaiDianValue
		end
	else
		return
	end

	if nCurMaiDianValue >= nNeedMaiDianValue then
		bFinish = 1
		nCurMaiDianValue = nNeedMaiDianValue
	end
	if bFinish ~= 1 then
		x791010_NotifyTips( sceneId, selfId, "#{XYSHFC_20211229_134}")
        return
	end
	--标记已经完成
	x791010_SetEventRewardFlag(sceneId, selfId ,nDayIndex, nDayTimes)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	
	--刷新UI
	local _,nEndY,nEndM,nEndD = x791010_GetEndTime(sceneId,selfId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 2 )-- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
		UICommand_AddInt( sceneId, x791010_GetCurrentDayIndex(sceneId,selfId) )--day index
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS1) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS2) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD1) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD2) )
		UICommand_AddInt( sceneId, LuaFnGetTodayActivePoint(sceneId,selfId) )
		UICommand_AddInt( sceneId, nEndY )
		UICommand_AddInt( sceneId, nEndM )
		UICommand_AddInt( sceneId, nEndD )
		
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79101001 )
end

--=========================================================
-- 计算距离开始的天数
--=========================================================
function x791010_GetCurrentDayIndex(sceneId,selfId)
	local nSubTime = LuaFnGetCurrentTime() - GetMissionDataEx(sceneId,selfId,MDEX_FENHUNLUDAYINDEX);
	return ceil(nSubTime / (60 * 60 * 24))
end

--=========================================================
-- 计算截止日期
-- 返回集合时间，年，月，日
--=========================================================
function x791010_GetEndTime(sceneId,selfId)
	local nEndANSITime = GetMissionDataEx(sceneId,selfId,MDEX_FENHUNLUDAYINDEX)	+ x791010_g_nMaxTotalDay * 24 * 60 * 60
	local nYear,nMonth,nDay = ConvertAnsiTime2YearMonthDay(nEndANSITime)	
	return nEndANSITime,nYear,nMonth,nDay
end

--=========================================================
-- 获取总奖励
--=========================================================
function x791010_GetRewardOfPoint( sceneId, selfId )
	local nState,strTips = x791010_CheckActivityBasic(sceneId,selfId)
	if nState == 0 then
		x791010_NotifyTips( sceneId, selfId, strTips)
        return
	end
	BeginAddItem(sceneId)
	local nHaveItem = 0
	local nTotalPoint = x791010_FengHunLu_GetTotalPoint(sceneId, selfId)
	for i = 1,getn(x791010_g_tabPointRewardInfo) do
		if nTotalPoint >= x791010_g_tabPointRewardInfo[i].nNeedPoint then
			if x791010_GetPointRewardFlag(sceneId,selfId,i) ~= 1 then
				--没有领取
				AddItem( sceneId,x791010_g_tabPointRewardInfo[i].nRewardItemID,x791010_g_tabPointRewardInfo[i].nRewardItemNum)	
	
				nHaveItem = 1
			end
		end
	end
	if nHaveItem <= 0 then
		x791010_NotifyTips( sceneId, selfId, "#{XYSHFC_20211229_134}")
        return
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--给奖励列表
	AddItemListToHuman(sceneId,selfId)
	for i = 1,getn(x791010_g_tabPointRewardInfo) do
		if nTotalPoint >= x791010_g_tabPointRewardInfo[i].nNeedPoint then
			if x791010_GetPointRewardFlag(sceneId,selfId,i) ~= 1 then
				--没有领取
				x791010_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{XYSHFC_20211229_144}",x791010_g_tabPointRewardInfo[i].nRewardItemNum,GetItemName(sceneId,x791010_g_tabPointRewardInfo[i].nRewardItemID)))
			end
		end
	end
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	
	--标记领取信息
	for i = 1,getn(x791010_g_tabPointRewardInfo) do
		if nTotalPoint >= x791010_g_tabPointRewardInfo[i].nNeedPoint then
			if x791010_GetPointRewardFlag(sceneId,selfId,i) ~= 1 then
				x791010_SetPointRewardFlag(sceneId,selfId,i)
			end
		end
	end

	--刷新UI
	local _,nEndY,nEndM,nEndD = x791010_GetEndTime(sceneId,selfId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 2 )-- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
		UICommand_AddInt( sceneId, x791010_GetCurrentDayIndex(sceneId,selfId) )--day index
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS1) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_POS2) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD1) )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_FENGHUNLU_AWORD2) )
		UICommand_AddInt( sceneId, LuaFnGetTodayActivePoint(sceneId,selfId) )
		UICommand_AddInt( sceneId, nEndY )
		UICommand_AddInt( sceneId, nEndM )
		UICommand_AddInt( sceneId, nEndD )
		
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79101001 )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end

--=========================================================
-- 计算已领取点数
--=========================================================
function x791010_FengHunLu_GetTotalPoint(sceneId, selfId)

	local nTotalPoint = 0
	local nOpenDays = x791010_GetCurrentDayIndex(sceneId,selfId)
	if nOpenDays > x791010_g_nMaxTotalDay then
		nOpenDays = x791010_g_nMaxTotalDay
	end
	for i = 1, nOpenDays do 
		for j = 1, x791010_g_nMaxEventPerDay do
			nTotalPoint = nTotalPoint + x791010_GetEventRewardFlag(sceneId, selfId,i, j)
		end
	end

	return nTotalPoint
end
--=========================================================
-- 设置累积积分奖励是否已领取标记 nPointRewardLevel[1,10] 第x个积分奖励等级
--=========================================================
function x791010_SetPointRewardFlag(sceneId, selfId ,nPointRewardLevel)

	if nil == nPointRewardLevel or nPointRewardLevel < 1 or nPointRewardLevel > x791010_g_nMaxPointRewardLevel then
		return -1
	end

	local nSaveMD = x791010_g_MDPrizeIndex[2]
	local nSavePos = x791010_g_nMaxSavePos - nPointRewardLevel
	local nMDData = GetMissionDataEx(sceneId,selfId,nSaveMD )
	-- 按位取标记[0,31]
	nMDData = LuaFnSetBitValueInUINT(nMDData, nSavePos, 1,1)
	SetMissionDataEx(sceneId,selfId,nSaveMD,nMDData-4294967296 )
end

--=========================================================
-- 获取累积积分奖励是否已领取标记 nPointRewardLevel[1,10] 第x个积分奖励等级
-- MD02 最高位开始使用
-- 参数非法返回-1 
--=========================================================
function x791010_GetPointRewardFlag(sceneId, selfId ,nPointRewardLevel)

	if nil == nPointRewardLevel or nPointRewardLevel < 1 or nPointRewardLevel > x791010_g_nMaxPointRewardLevel then
		return -1
	end

	local nSaveMD = x791010_g_MDPrizeIndex[2]
	local nSavePos = x791010_g_nMaxSavePos - nPointRewardLevel
	local nMDData = GetMissionDataEx(sceneId,selfId,nSaveMD )
	-- 按位取标记[0,31]
	local nRet, nRetValue = LuaFnGetBitValueInUINT(nMDData, nSavePos, 1)
	if nil == nRet or 1 ~= nRet then
		return 0
	end
	return nRetValue
end
--=========================================================
-- 设置事件奖励已领取标记 nDay 第x天[1,8]； nIndexOfDay[1,5] 本天的第x个事件
--=========================================================
function x791010_SetEventRewardFlag(sceneId, selfId ,nDay, nIndexOfDay)
	if nil == nDay or nDay < 1 or nDay > x791010_g_nMaxTotalDay then
		return
	end

	if nil == nIndexOfDay or nIndexOfDay < 1 or nIndexOfDay > x791010_g_nMaxEventPerDay then
		return
	end

	local nSaveMD = x791010_g_MDPrizeIndex[1]
	local nSavePos = x791010_g_nMaxEventPerDay * (nDay - 1) + nIndexOfDay - 1
	if nSavePos >= x791010_g_nMaxSavePos then
		nSaveMD = x791010_g_MDPrizeIndex[2]
		nSavePos = nSavePos - x791010_g_nMaxSavePos
	end

	-- 按位取标记[0,31]
	local nMDData = GetMissionDataEx(sceneId,selfId,nSaveMD )
	nMDData = LuaFnSetBitValueInUINT(nMDData, nSavePos, 1,1)
	SetMissionDataEx(sceneId,selfId,nSaveMD,nMDData-4294967296 )
end
--=========================================================
-- 获取事件奖励是否已领取标记 nDay 第x天[1,8]； nIndexOfDay[1,5] 本天的第x个事件
-- MD01 MD02 一起使用 每天最大5个点 最多8天 共计40个点 从低1位开始使用
-- 参数非法返回-1 
--=========================================================
function x791010_GetEventRewardFlag(sceneId, selfId ,nDay, nIndexOfDay)
	if nil == nDay or nDay < 1 or nDay > x791010_g_nMaxTotalDay then
		return -1
	end

	if nil == nIndexOfDay or nIndexOfDay < 1 or nIndexOfDay > x791010_g_nMaxEventPerDay then
		return -1
	end

	local nSaveMD = x791010_g_MDPrizeIndex[1]
	local nSavePos = x791010_g_nMaxEventPerDay * (nDay - 1) + nIndexOfDay - 1
	if nSavePos >= x791010_g_nMaxSavePos then
		nSaveMD = x791010_g_MDPrizeIndex[2]
		nSavePos = nSavePos - x791010_g_nMaxSavePos
	end

	-- 按位取标记[0,31]
	local nMDData = GetMissionDataEx(sceneId,selfId,nSaveMD )
	local nRet, nRetValue = LuaFnGetBitValueInUINT(nMDData, nSavePos, 1)
	if nil == nRet or 1 ~= nRet then
		return 0
	end
	return nRetValue
end
--=========================================================
-- 获取埋点的值
--=========================================================
function x791010_GetMaiDianValue(sceneId, selfId,nMaiDianID)
	if nil == nMaiDianID or nMaiDianID <= 0 then 
		return 0
	end

	local tableMaiDianInfo = x791010_g_tabMaiDianSaveInfo[nMaiDianID]
	if nil == tableMaiDianInfo then
		return 0
	end

	local nSaveMD = x791010_g_MDIndex[tableMaiDianInfo.nSaveMDIndex]
	if nSaveMD == nil then
		return 0
	end
	local nSaveMD = GetMissionDataEx(sceneId,selfId,nSaveMD )
	local nSavePos 	= tableMaiDianInfo.nSavePosStart
	local nSaveLen 	= tableMaiDianInfo.nSaveLen

	local nRet, nRetValue = LuaFnGetBitValueInUINT(nSaveMD, nSavePos, nSaveLen)
	if nil == nRet or 1 ~= nRet then
		return 0
	end

	return nRetValue
end
--=========================================================
-- 埋点信息更新
-- 这里是给LUA使用的cpp埋点要做判断去除
-- CallScriptFunction(791010, "AddPointData", sceneId, selfId, 3);
--=========================================================
function x791010_AddPointData( sceneId, selfId ,nIndex)
	--时间检测
	local nState,strTips = x791010_CheckActivityBasic(sceneId,selfId)
	if nState == 0 then
        return
	end
	if nIndex == nil or nIndex > getn(x791010_g_tabMaiDianSaveInfo) then
		return
	end
	local nMaxValue = x791010_g_tabMaiDianSaveInfo[nIndex].nMaxValue
	local nSaveMDIndex = x791010_g_tabMaiDianSaveInfo[nIndex].nSaveMDIndex
	if x791010_g_MDIndex[nSaveMDIndex] == nil then
		return
	end
	--这里要严格执行埋点数据更新的校验
	local nMDData = GetMissionDataEx(sceneId,selfId,x791010_g_MDIndex[nSaveMDIndex] )
	local nSavePosStart = x791010_g_tabMaiDianSaveInfo[nIndex].nSavePosStart
	local nSaveLen = x791010_g_tabMaiDianSaveInfo[nIndex].nSaveLen
	local nHave,nValue = LuaFnGetBitValueInUINT(nMDData,nSavePosStart,nSaveLen);
	if nValue + 1 > nMaxValue then
		return
	end
	nMDData = LuaFnSetBitValueInUINT(nMDData,nSavePosStart,nSaveLen,nValue + 1);
	SetMissionDataEx(sceneId,selfId,x791010_g_MDIndex[nSaveMDIndex],nMDData)
end

--=========================================================
-- 获取帮助
--=========================================================
function x791010_ShowHelp( sceneId, selfId )
	if GetLevel(sceneId, selfId) < 85 then
        return
    end
	local _,nEndY,nEndM,nEndD = x791010_GetEndTime(sceneId,selfId)
	BeginEvent( sceneId )
		AddText( sceneId, ScriptGlobal_Format("#{XYSHFC_20211229_105}",
		nEndY,nEndM,nEndD) )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end

--=========================================================
-- 活动基本信息检测
--=========================================================
function x791010_CheckActivityBasic(sceneId,selfId)
	if GetLevel(sceneId, selfId) < 85 then
        return 0,"#{XYSHFC_20211229_101}"
    end
	--活动时间检测
	--超过领奖时间
	local nEndANSITime = x791010_GetEndTime(sceneId,selfId)
	if LuaFnGetCurrentTime() > nEndANSITime then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0)---0是关闭1是显示
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 79101002 )
		
        return 0,"#{XYSHFC_20211229_131}"
	end
	
	return 1,""
end

--=========================================================
-- 醒目提示
--=========================================================
function x791010_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
