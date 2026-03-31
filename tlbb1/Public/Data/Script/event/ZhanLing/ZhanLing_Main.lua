--**********************************
-- 战令月卡
--**********************************
x890215_g_ScriptId	= 890215
x890215_g_OpMinLevel = 85
x890215_g_MissionInfoList = {
	[1] = {name = "#{SWXT_221213_125}", maxtime = 18, notfinshtext = "#{SWXT_221213_126}" ,finshtext = "#{SWXT_221213_127}", addpoint = 5},
	[2] = {name = "#{SWXT_221213_128}", maxtime = 18, notfinshtext = "#{SWXT_221213_129}" ,finshtext = "#{SWXT_221213_130}", addpoint = 5},
	[3] = {name = "#{SWXT_221213_137}", maxtime = 4, notfinshtext = "#{SWXT_221213_138}" ,finshtext = "#{SWXT_221213_139}", addpoint = 5},
	[4] = {name = "#{SWXT_221213_131}", maxtime = 2, notfinshtext = "#{SWXT_221213_132}" ,finshtext = "#{SWXT_221213_133}", addpoint = 20},
}
x890215_g_MAX_LEVEL = 12 --最da阶位
x890215_g_MAX_TODAY_GET_POINT = 200
x890215_g_EachLeveActivePoint = 10

x890215_g_RMBRewardTab = {
	--地珍注疏
	[1] = {needItem = 38002761,conType = 14,buytip = "#{SWXT_221213_256}",
		actedtip = "#{SWXT_221213_51}",mfexIdx = MFEX_ZHANLING_DI,actTip = "#{SWXT_221213_53}",
		notacttip = "#{SWXT_221213_46}"
	},
	--天宝注疏
	[2] = {needItem = 38002797,conType = 13,buytip = "#{SWXT_221213_258}",
		actedtip = "#{SWXT_221213_200}",mfexIdx = MFEX_ZHANLING_TIAN,actTip = "#{SWXT_221213_215}",
		notacttip = "#{SWXT_221213_198}"
	},
}
--**********************************
--完成一次战令要求任务
--**********************************
function x890215_OnFinishMission( sceneId, selfId, nMissionIdx )
	if GetLevel(sceneId,selfId) < x890215_g_OpMinLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_119}" )
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_120}" )
		return
	end
	if x890215_g_MissionInfoList[nMissionIdx] == nil then
		return
	end
	--SWXT_221213_218	#H本期天鉴神卷已达最高等级，研习心得无增长。	
	local nCurZhanLingLevel = x890215_GetZhanLingLevel(sceneId,selfId)
	if nCurZhanLingLevel >= x890215_g_MAX_LEVEL then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_218}" )
		return
	end
	local nCurTime = x890215_GetMissionDataByIndex(sceneId,selfId, nMissionIdx)
	if nCurTime >= x890215_g_MissionInfoList[nMissionIdx].maxtime then
		return
	end
	--更新完成次数
	x890215_SetMissionDataByIndex(sceneId,selfId, nMissionIdx,nCurTime + 1)
	local nAddPoint = x890215_g_MissionInfoList[nMissionIdx].addpoint
	local nCurMonthPoint = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH)
	local nCurDayPoint = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_DAY)
	
	SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH,nCurMonthPoint + nAddPoint)
	SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_DAY,nCurDayPoint + nAddPoint)
	--SWXT_221213_123	#H您完成了一项研习名录，获得了%s0点研习心得。	
	x890215_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{SWXT_221213_123}",tostring(nAddPoint)))
	--更新UI
	x890215_UpdateMainUI( sceneId, selfId ,2)
	--等级变动打开红点
	if x890215_GetZhanLingLevel(sceneId,selfId) ~= nCurZhanLingLevel then
		LuaFnUpdateQuickEnterTips(sceneId,selfId,13,1)
	end
end
--**********************************
--请求领取奖励
--**********************************
function x890215_AskGetReward( sceneId, selfId, nIndex,nType )
	if GetLevel(sceneId,selfId) < x890215_g_OpMinLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_40}" )
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_41}" )
		return
	end
	--nType 0:普通 1:rmb1 2:rmb2
	local nCurrentLevel = x890215_GetZhanLingLevel(sceneId,selfId)
	if nIndex > nCurrentLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_42}" )
		return
	end
	local nPrizeState = -1
	if nType == 1 or nType == 2 then
		if x890215_g_RMBRewardTab[nType] == nil then
			return
		end
		local tCfg = x890215_g_RMBRewardTab[nType]
		local nActived = GetMissionFlagEx(sceneId,selfId,tCfg.mfexIdx)
		if nActived ~= 1 then
			x890215_NotifyTip( sceneId, selfId, tCfg.notacttip )
			return
		end
		if nType == 1 then
			nPrizeState = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB_PRIZE)
		elseif nType == 2 then
			nPrizeState = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB2_PRIZE)
		end
	else
		nPrizeState = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_PRIZE)
	end
	if nPrizeState == -1 then
		return
	end
	local tPrizeState = x890215_GetBitTable(nPrizeState)
	if tPrizeState[nIndex] == 1 then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_43}" )
		return
	end
	--查询奖励内容
	local bRet,nPoint,
	nShowB1,nItemNumB1,
	nShowB2,nItemNumB2,
	nShowB3,nItemNumB3,
	nShowB4,nItemNumB4,
	nShowB5,nItemNumB5,
	nShowA1,nItemNumA1,
	nShowA2,nItemNumA2,
	nShowA3,nItemNumA3,
	nShowA4,nItemNumA4,
	nShowA5,nItemNumA5,
	nShowA6,nItemNumA6,
	nShowC1,nItemNumC1,
	nShowC2,nItemNumC2,
	nShowC3,nItemNumC3,
	nShowC4,nItemNumC4,
	nShowC5,nItemNumC5,
	nShowC6,nItemNumC6
	=LuaFnGetZhanLingPrizeInfo(-1,nIndex)
	if bRet == nil or bRet <= 0 then
		return
	end
	BeginAddItem(sceneId)
	if nType == 1 then
		AddBindItem(sceneId,nShowA1, nItemNumA1)
	elseif nType == 2 then
		AddBindItem(sceneId,nShowC1, nItemNumC1)
	else
		AddBindItem(sceneId,nShowB1, nItemNumB1)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--添加物品
	AddItemListToHuman(sceneId,selfId)
	--更新领取状态
	tPrizeState[nIndex] = 1
	local nNewState = x890215_SetBitTable(tPrizeState)
	if nType == 1 then
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB_PRIZE,nNewState)
		x890215_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SWXT_221213_199}",tostring(nItemNumA1),GetItemName(sceneId,nShowA1)) )
	elseif nType == 2 then
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB2_PRIZE,nNewState)
		x890215_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SWXT_221213_199}",tostring(nItemNumC1),GetItemName(sceneId,nShowC1)) )
	else
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_PRIZE,nNewState)
		x890215_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SWXT_221213_199}",tostring(nItemNumB1),GetItemName(sceneId,nShowB1)) )
	end
	--更新UI
	x890215_UpdateMainUI( sceneId, selfId ,2)
end
--**********************************
--请求激活RMB奖励
--**********************************
function x890215_AskActRMBReward( sceneId, selfId, param1,param2 )
	if x890215_g_RMBRewardTab[param2] == nil then
		return
	end
	local tCfg = x890215_g_RMBRewardTab[param2]
	local nItemPos = LuaFnGetAvailableItemFirstPos(sceneId,selfId,tCfg.needItem)
	if nItemPos < 0 then		
		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,tCfg.conType,tCfg.needItem,1)
		if nNeedMoney ~= nil then			
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 2 )
				UICommand_AddInt( sceneId, nMoneyUnit )
				UICommand_AddInt( sceneId, nNeedMoney )
				UICommand_AddInt( sceneId, itemIndex )
				UICommand_AddInt( sceneId, 0 )
				UICommand_AddInt( sceneId, x891062_g_ScriptId )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddInt( sceneId, -1 )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddString(sceneId,tCfg.buytip)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20120222 )
		end
		return
	end
	local nActived = GetMissionFlagEx(sceneId,selfId,tCfg.mfexIdx)
	if nActived == 1 then
		x890215_NotifyTip( sceneId, selfId, tCfg.actedtip )
		return
	end
	--材料扣除
	LuaFnDelAvailableItem(sceneId,selfId,tCfg.needItem,1)
	SetMissionFlagEx(sceneId,selfId,tCfg.mfexIdx,1)
	x890215_NotifyTip( sceneId, selfId, tCfg.actTip )
	--更新UI
	x890215_UpdateMainUI( sceneId, selfId ,2)
end

--**********************************
--请求打开战令补充进度UI
--**********************************
function x890215_AskOpenAddProgressUI( sceneId, selfId )
	if GetLevel(sceneId,selfId) < x890215_g_OpMinLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_25}" )
		return
	end
	local nCurZhanLingLevel = x890215_GetZhanLingLevel(sceneId,selfId)
	if nCurZhanLingLevel >= x890215_g_MAX_LEVEL then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_26}" )
		return
	end
	local nBeginTime,nAddProcessOpenTime,nEndTime = LuaFnGetZhanLingOpenAddProcessTime(GetTime2Day())
	if GetTime2Day() < nAddProcessOpenTime then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_24}" )
		return
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1);
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH))
		UICommand_AddInt(sceneId,(x890215_g_MAX_LEVEL - nCurZhanLingLevel) * x890215_g_EachLeveActivePoint);
		UICommand_AddInt(sceneId,1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89021503)
end
--**********************************
--请求战令补充进度
--**********************************
function x890215_AskAddProgress( sceneId, selfId,  addNum,bCheck )
	local nBeginTime,nAddProcessOpenTime,nEndTime = LuaFnGetZhanLingOpenAddProcessTime(GetTime2Day())
	if GetTime2Day() < nAddProcessOpenTime then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_24}" )
		return
	end
	if GetLevel(sceneId,selfId) < x890215_g_OpMinLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_25}" )
		return
	end
	local nCurZhanLingLevel = x890215_GetZhanLingLevel(sceneId,selfId)
	if nCurZhanLingLevel >= x890215_g_MAX_LEVEL then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_26}" )
		return
	end
	local nCurMaxAddPoint = (x890215_g_MAX_LEVEL - nCurZhanLingLevel) * x890215_g_EachLeveActivePoint
	local nCurMinAddPoint = 1
	if addNum < nCurMinAddPoint or addNum > nCurMaxAddPoint then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_28}" )
		return
	end
	local nCost = addNum * 50
	local nCurYuanBao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanBao < nCost then
		x890215_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SWXT_221213_29}",tostring(nCost)) )
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nCost) ~= 1 then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_30}" )
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,nCost,890215,"AskAddProgress",0,0) ~= 1 then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_30}" )
		return
	end
	local nCurMonthPoint = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH)
	local nCurDayPoint = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_DAY)
	
	SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH,nCurMonthPoint + addNum)
	SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_DAY,nCurDayPoint + addNum)
	--更新UI
	x890215_UpdateMainUI( sceneId, selfId ,2)
end
--**********************************
--更新时间状态:Login及时间更新时调用
--**********************************
function x890215_UpdateDate( sceneId, selfId )
	local nBeginTime,nAddProcessOpenTime,nEndTime = LuaFnGetZhanLingOpenAddProcessTime(GetTime2Day())
	local nCurEndTime = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_ENDTIME)
	if nEndTime ~= nil and nCurEndTime ~= nEndTime then
		--更新新的时间
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_ENDTIME,nEndTime)
		--清理旧的数据
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_MISSIONDATA,0)
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_AWARDDATA,0)
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH,0)
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_DAY,0)
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_PRIZE,0)
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB_PRIZE,0)
		SetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB2_PRIZE,0)
		
		SetMissionFlagEx(sceneId,selfId,MFEX_ZHANLING_TIAN,0)
		SetMissionFlagEx(sceneId,selfId,MFEX_ZHANLING_DI,0)
		--小红点点亮
		LuaFnUpdateQuickEnterTips(sceneId,selfId,13,1)
	end
end
--**********************************
--请求打开任务UI
--**********************************
function x890215_AskOpenMissionUI( sceneId, selfId )	
	if GetLevel(sceneId,selfId) < x890215_g_OpMinLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_116}" )
		return
	end
	BeginUICommand(sceneId)
		--任务数据
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_MISSIONDATA));
		--任务领取奖励数据
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_AWARDDATA))
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89021505)
end
--**********************************
--打开主UI
--**********************************
function x890215_AskOpenMainUI( sceneId, selfId )
	if GetLevel(sceneId,selfId) < x890215_g_OpMinLevel then
		x890215_NotifyTip( sceneId, selfId, "#{SWXT_221213_116}" )
		return
	end
	x890215_UpdateMainUI( sceneId, selfId ,1)
	--小红点熄灭
	LuaFnUpdateQuickEnterTips(sceneId,selfId,13,0)
end
--**********************************
--更新主UI
--**********************************
function x890215_UpdateMainUI( sceneId, selfId,nType )
	BeginUICommand(sceneId)
		--界面操作类型（0 关闭，1打开， 2刷新）
		UICommand_AddInt(sceneId,nType);
		--服务器当前天数时间
		UICommand_AddInt(sceneId,GetTime2Day())
		--玩家当月战令点数
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH))
		--玩家当日战令点数
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_DAY))
		--普通奖励MD
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_PRIZE))
		--付费1奖励MD
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB_PRIZE))
		--是否激活RMB1
		UICommand_AddInt(sceneId,GetMissionFlagEx(sceneId,selfId,MFEX_ZHANLING_DI))
		--是否显示红点
		UICommand_AddInt(sceneId,0)
		--付费2奖励MD
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_RMB2_PRIZE))
		--是否激活RMB2
		UICommand_AddInt(sceneId,GetMissionFlagEx(sceneId,selfId,MFEX_ZHANLING_TIAN))
		--nEndTime
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_ENDTIME))
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89021501)
	
	print(GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_ENDTIME))
end
--**********************************
--购买拓展
--**********************************
function x890215_BuyZhanLing( sceneId, selfId,  msg )
--	local bRet,nAddProcessOpenTime = LuaFnGetZhanLingOpenAddProcessTime(GetTime2Day())
--	print("nAddProcessOpenTime",bRet,nAddProcessOpenTime)
end
--**********************************
-- 计算当前等级
--**********************************
function x890215_GetZhanLingLevel(sceneId,selfId)
	local nMonthPoint = GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_POINT_MONTH)
	return floor(nMonthPoint/x890215_g_EachLeveActivePoint)
--	local nPointLevel = x890215_g_MAX_LEVEL
--	for i = 1, x890215_g_MAX_LEVEL do
--		local bRet,nPoint = LuaFnGetZhanLingPrizeInfo(-1,i)
--		print("nPoint",nPoint,nMonthPoint)
--		if nil == bRet or 0 == bRet then
--			return 0
--		end
--		if nMonthPoint < nPoint then
--			nPointLevel = i
--			break
--		end
--	end
--
--	return nPointLevel
end
function x890215_SetBitTable(BitTable)
    local nOct = 0
    for i = 1, x890215_g_MAX_LEVEL do
        -- 每个位置的值乘以 2^(i-1)（i=1时为最低位）
        nOct = nOct + (BitTable[i] or 0) * (2 ^ (i - 1))
    end
    return nOct
end
function x890215_GetBitTable(nOct)
	local BitTable = {}
	local oct = nOct
	for i = 1 , x890215_g_MAX_LEVEL do
		BitTable[i] = mod(oct , 2)
		oct = floor(oct / 2)
	end
	return BitTable
end
--**********************************
-- 取单个任务数据 DDCCBBAA AA：周常任务 BB：挖矿 CC：做一件天鉴装备 DD：长春谷pvp 
--**********************************
function x890215_GetMissionDataByIndex(sceneId,selfId, index)
	local nNum = 1
	if index == 1 then
		nNum = 1 
	elseif index == 2 then
		nNum = 100
	elseif index == 3 then
		nNum = 10000
	elseif index == 4 then
		nNum = 1000000
	end
	local nData = mod(floor(GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_MISSIONDATA)/nNum), 100)
	return nData
end
--**********************************
-- 取单个任务领取奖励数据 DDCCBBAA AA：周常任务 BB：挖矿 CC：做一件天鉴装备 DD：长春谷pvp 
--**********************************
function x890215_GetMissionGetAwardDataByIndex(sceneId,selfId, index)
	
	local nNum = 1
	if index == 1 then
		nNum = 1 
	elseif index == 2 then
		nNum = 100
	elseif index == 3 then
		nNum = 10000
	elseif index == 4 then
		nNum = 1000000
	end
	local nData = mod(floor(GetMissionDataEx(sceneId,selfId,MDEX_ZHANLING_AWARDDATA)/nNum), 100)
	return nData
end
--**********************************
-- 设置单个任务数据 DDCCBBAA 
-- AA：周常任务 
-- BB：挖矿 
-- CC：做一件天鉴装备 
-- DD：长春谷pvp 
--**********************************
function x890215_SetMissionDataByIndex(sceneId, selfId, index, newValue)
    if newValue < 0 or newValue >= 100 then
		return
    end

    local nNum = 1
    if index == 1 then
        nNum = 1 
    elseif index == 2 then
        nNum = 100
    elseif index == 3 then
        nNum = 10000
    elseif index == 4 then
        nNum = 1000000
    else
       return
    end
    -- 取出当前的任务数据（DDCCBBAA格式）
    local currentData = GetMissionDataEx(sceneId, selfId, MDEX_ZHANLING_MISSIONDATA)
    -- 计算该位置原有的两位数值
    local oldValue = mod(floor(currentData / nNum), 100)
    -- 清除旧值，再设置新值
    local newData = currentData - (oldValue * nNum) + (newValue * nNum)
    -- 写回新的任务数据
    SetMissionDataEx(sceneId, selfId, MDEX_ZHANLING_MISSIONDATA, newData)
end

--**********************************
-- 设置单个任务领取奖励数据 DDCCBBAA 
-- AA：周常任务 
-- BB：挖矿 
-- CC：做一件天鉴装备 
-- DD：长春谷pvp 
--**********************************
function x890215_SetMissionGetAwardDataByIndex(sceneId, selfId, index, newValue)
    if newValue < 0 or newValue >= 100 then
        return
    end
    local nNum = 1
    if index == 1 then
        nNum = 1 
    elseif index == 2 then
        nNum = 100
    elseif index == 3 then
        nNum = 10000
    elseif index == 4 then
        nNum = 1000000
    else
        return
    end
    -- 取出当前的奖励数据（DDCCBBAA格式）
    local currentData = GetMissionDataEx(sceneId, selfId, MDEX_ZHANLING_AWARDDATA)
    -- 计算该位置原有的两位数字
    local oldValue = mod(floor(currentData / nNum), 100)
    -- 清除旧值，再设置新值
    local newData = currentData - (oldValue * nNum) + (newValue * nNum)
    -- 写回新的奖励数据
    SetMissionDataEx(sceneId, selfId, MDEX_ZHANLING_AWARDDATA, newData)
end
--**********************************
--信息提示
--**********************************
function x890215_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
