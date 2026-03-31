--月卡逻辑

x998526_g_ScriptId = 998526
x998526_g_MinLevel = 15
x998526_g_MinYueKaLevel = 70
x998526_g_MinYueKaBuyPointLevel = 80
x998526_g_ActiveYuanBoaoCost = 2488
x998526_g_ActivePrize = 30103088	--表情包：小狐仙
x998526_g_ZhanLingMax = 8000
x998526_g_PerpageProgressNunMax = 5
x998526_g_tRMBPrizeDataIndex = {
	MDEX_YUEKA_RMBAWARDPROCESS_1,
	MDEX_YUEKA_RMBAWARDPROCESS_2,
	MDEX_YUEKA_RMBAWARDPROCESS_3,
	MDEX_YUEKA_RMBAWARDPROCESS_4
}
--**********************************
--点击红点
--**********************************
function x998526_ClickHotPoint(sceneId,selfId)
	SetMissionFlag(sceneId,selfId,MF_ZHOUHUOYUE_PRIZE_HOTPOINT,1)
end

--**********************************
--打开增加进度的UI
--**********************************
function x998526_AskOpenAddProgressUI(sceneId,selfId)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if GetLevel(sceneId,selfId) < x998526_g_MinYueKaBuyPointLevel then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_37}" )
		return
	end
	local nCurZhanLingLevel = x998526_GetCurActivePoint(sceneId,selfId)
	if nCurZhanLingLevel >= x998526_g_ZhanLingMax then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_38}" )
		return
	end
	local nCurState = GetMissionData(sceneId,selfId,MD_ZHOUHUOYUE_PRIZE)
	if nCurState == 0 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_114}" )
		return
	end

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1);
		UICommand_AddInt(sceneId,x998526_GetCurActivePoint(sceneId,selfId) )
		UICommand_AddInt(sceneId,(x998526_g_ZhanLingMax - x998526_GetCurActivePoint(sceneId,selfId)));
		UICommand_AddInt(sceneId,1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 99852603)
end

--**********************************
--请求增加月卡进度
--**********************************
function x998526_AskAddProgress(sceneId,selfId,nAddNum)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if GetLevel(sceneId,selfId) < x998526_g_MinYueKaBuyPointLevel then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_37}" )
		return
	end
	local nCurZhanLingLevel = x998526_GetCurActivePoint(sceneId,selfId)
	if nCurZhanLingLevel >= x998526_g_ZhanLingMax then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_66}" )
		return
	end
	local nCurState = GetMissionData(sceneId,selfId,MD_ZHOUHUOYUE_PRIZE)
	if nCurState == 0 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_114}" )
		return
	end
	if nAddNum < 0 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_39}" )
		return
	end
	local nCanAddMax = x998526_g_ZhanLingMax - x998526_GetCurActivePoint(sceneId,selfId)
	nCanAddMax = ceil(nCanAddMax/200)
	if nAddNum > nCanAddMax then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_40}" )
		return
	end
    --拥有绑定元宝
	local curBYB= BindYuanBao(sceneId,selfId,selfId,3,0)
	--拥有元宝
	local curYB=YuanBao(sceneId,selfId,selfId,3,0)
    local nNeedYuanbao = nAddNum * 100
	if curBYB + curYB < nNeedYuanbao then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_41}" )
		return
	end
	local UserBYBCnt=0
	local UserYBCnt=0
	if curBYB>=nNeedYuanbao then
		--绑定元宝足够
		UserBYBCnt=nNeedYuanbao
	else
		UserBYBCnt=curBYB
		--元宝够不
		nNeedYuanbao = nNeedYuanbao-UserBYBCnt
		if curYB >= nNeedYuanbao then
			UserYBCnt = nNeedYuanbao
		else
			--钱不够啊
			x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_41}" )
			return
		end
	end
	--扣除元宝
	if UserBYBCnt > 0 then
		BindYuanBao(sceneId,selfId,selfId,2,UserBYBCnt);
	end
	if UserYBCnt > 0 then
		LuaFnCostYuanBao(sceneId,selfId,UserYBCnt,998526,"AskAddProgress",0,-1);
	end
	local nCurExtZhanLing = GetMissionDataEx(sceneId,selfId,MDEX_NEWZHANLING_HAOLING)
	nCurExtZhanLing = nCurExtZhanLing + nAddNum * 200
	if nCurExtZhanLing > x998526_g_ZhanLingMax then
		nCurExtZhanLing = x998526_g_ZhanLingMax
	end
	SetMissionDataEx(sceneId,selfId,MDEX_NEWZHANLING_HAOLING,nCurExtZhanLing)
	
	x998526_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{ZLSJ_231106_72}",tostring(nAddNum * 200)) )
	
	LuaFnUpdateNewYueKaInfo(sceneId,selfId,2)
	--关闭购买页面
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,0);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 99852603)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end

--**********************************
--获取当前的总号令值
--**********************************
function x998526_GetCurActivePoint(sceneId,selfId)
	return LuaFnGetWeekActivePoint(sceneId,selfId) + GetMissionDataEx(sceneId,selfId,MDEX_NEWZHANLING_HAOLING)
end
--**********************************
--打开整合UI
--**********************************
function x998526_OpenZhengHeUI(sceneId,selfId)
	if GetLevel(sceneId,selfId) < x998526_g_MinLevel then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_04}" )
		return
	end
	--更新整合UI的红点情况
	BeginUICommand( sceneId )
		for i = 1,5 do
			UICommand_AddInt(sceneId,0);
		end
	EndUICommand( sceneId)
	DispatchUICommand(sceneId,selfId,99852605)
	--打开主UI
	BeginUICommand( sceneId )
	EndUICommand( sceneId)
	DispatchUICommand(sceneId,selfId,99852604)
end

--**********************************
--请求月卡信息
--**********************************
function x998526_OpenUI(sceneId,selfId,nType)
	--客户端请求月卡信息
	if nType ~= 1 then
		return
	end
	LuaFnUpdateNewYueKaInfo(sceneId,selfId,nType)
end

--**********************************
--获取月卡奖励
--**********************************
function x998526_GetYueKaAward(sceneId,selfId,nCurPage,bIsRMB)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if GetLevel(sceneId,selfId) < x998526_g_MinYueKaLevel then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_05}" )
		return
	end
	--未激活
	local nCurState = GetMissionData(sceneId,selfId,MD_ZHOUHUOYUE_PRIZE)
	if nCurState == 0 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_73}" )
		return
	end
	local nEndTime = 0
	local nStartTime = {}
	nStartTime[1], nStartTime[2], nStartTime[3], nStartTime[4],nEndTime = LuaFnGetNewZhanLingOpenAddProcessTime(GetTime2Day())
	if nStartTime[nCurPage] == nil or GetTime2Day() < nStartTime[nCurPage] then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_100}" )
		return
	end
	local nRMBAwardProcess = {}
	for i = 1,4 do
		nRMBAwardProcess[i] = GetMissionDataEx(sceneId,selfId,x998526_g_tRMBPrizeDataIndex[i])
	end
	if nRMBAwardProcess[nCurPage] >= x998526_g_PerpageProgressNunMax then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_59}" )
		return
	end
	local nCurGetIndex = 0
	BeginAddItem(sceneId)
	for i = 1, x998526_g_PerpageProgressNunMax do
		local bRet,nPoint,
			nShow,nItemNum =LuaFnGetNewZhanLingPrizeInfo(GetTime2Day(),(nCurPage-1)*x998526_g_PerpageProgressNunMax+i)
		if nil == bRet or 0 == bRet then
			x998526_NotifyTip( sceneId, selfId, "内部错误 2" )
			return
		end
		--可领取
		if nPoint <= x998526_GetCurActivePoint(sceneId,selfId) and nRMBAwardProcess[nCurPage] < i then
			AddBindItem(sceneId,nShow,nItemNum)
			nCurGetIndex = i
		end
	end
	if nCurGetIndex == 0 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_60}" )
		return
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--添加物品
	AddItemListToHuman(sceneId,selfId)
	--更新领取状态
	SetMissionDataEx(sceneId,selfId,x998526_g_tRMBPrizeDataIndex[nCurPage],nCurGetIndex )
	--更新UI
	LuaFnUpdateNewYueKaInfo(sceneId,selfId,2)
	--提示
	for i = 1, x998526_g_PerpageProgressNunMax do
		local bRet,nPoint,
			nShow,nItemNum =LuaFnGetNewZhanLingPrizeInfo(GetTime2Day(),(nCurPage-1)*x998526_g_PerpageProgressNunMax+i)
		if nil == bRet or 0 == bRet then
			return
		end
		--可领取
		if nPoint <= x998526_GetCurActivePoint(sceneId,selfId) and nRMBAwardProcess[nCurPage] < i then
			x998526_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{ZLSJ_231106_64}",tostring(nItemNum),GetItemName(sceneId,nShow)) )
		end
	end
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end

--**********************************
--激活月卡
--**********************************
function x998526_ActiveYueKa(sceneId,selfId,nType)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if GetLevel(sceneId,selfId) < x998526_g_MinYueKaLevel then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_05}" )
		return
	end
	local nCurState = GetMissionData(sceneId,selfId,MD_ZHOUHUOYUE_PRIZE)
	if nCurState > 0 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_77}" )
		return
	end
	if nType == 0 then
		--二次确认
		local _, _,_,_,nEndTime = LuaFnGetNewZhanLingOpenAddProcessTime(GetTime2Day())
		if nEndTime == nil then
			x998526_NotifyTip( sceneId, selfId, "内部错误 1" )
			return
		end
		local nLeaveDay = x998526_GetMonthLeftDays(GetTime2Day(), nEndTime)
		BeginUICommand( sceneId )
			UICommand_AddString(sceneId,ScriptGlobal_Format("#{ZLSJ_231106_23}",tostring(nLeaveDay)))
		EndUICommand( sceneId)
		DispatchUICommand(sceneId,selfId,99852601)
		return
	end
	local nCurYuanBao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanBao < x998526_g_ActiveYuanBoaoCost then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_81}" )
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,x998526_g_ActiveYuanBoaoCost) ~= 1 then
		x998526_NotifyTip( sceneId, selfId, "#{ZSHF_20230705_108}" )
		return
	end
	--判断背包能否放入小狐仙
	BeginAddItem(sceneId)
	AddItem( sceneId,x998526_g_ActivePrize,1)	
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,x998526_g_ActiveYuanBoaoCost,998526,"ActiveYueKa",0,0) ~= 1 then
		x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_81}" )
		return
	end
	AddItemListToHuman(sceneId,selfId)
	--激活号令
	SetMissionData(sceneId,selfId,MD_ZHOUHUOYUE_PRIZE,1)
	--刷新UI
	LuaFnUpdateNewYueKaInfo(sceneId,selfId,2)
	
	x998526_NotifyTip( sceneId, selfId, "#{ZLSJ_231106_78}" )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end
--**********************************
--更新时间状态:Login及时间更新时调用
--**********************************
function x998526_UpdateDate( sceneId, selfId )
	local nEndTime = 0
	local nStartTime = {}
	nStartTime[1], nStartTime[2], nStartTime[3], nStartTime[4],nEndTime = LuaFnGetNewZhanLingOpenAddProcessTime(GetTime2Day())
	local nCurEndTime = GetMissionDataEx(sceneId,selfId,MDEX_NEWZHANLING_ENDTIME)
	if nEndTime ~= nil and nCurEndTime ~= nEndTime then
		--更新新的时间
		SetMissionDataEx(sceneId,selfId,MDEX_NEWZHANLING_ENDTIME,nEndTime)
		--清理旧的数据
		SetMissionData(sceneId,selfId,MD_ZHOUHUOYUE_PRIZE,0)
		--补充的号令值清理
		SetMissionDataEx(sceneId,selfId,MDEX_NEWZHANLING_HAOLING,0)
		--清理领取状态
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_RMBAWARDPROCESS_1,0)
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_RMBAWARDPROCESS_2,0)
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_RMBAWARDPROCESS_3,0)
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_RMBAWARDPROCESS_4,0)
		
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_AWARDPROCESS_1,0)
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_AWARDPROCESS_2,0)
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_AWARDPROCESS_3,0)
		SetMissionDataEx(sceneId,selfId,MDEX_YUEKA_AWARDPROCESS_4,0)
		--发送新的一期的邮件
		local nTime = nStartTime[1]
		local days = mod(nTime , 100)
		nTime = floor(nTime / 100)
		local month = mod(nTime , 100)
		local year = floor(nTime / 100)
		
		local nEndDays = mod(nEndTime , 100)
		nEndTime = floor(nEndTime / 100)
		local nEndMonth = mod(nEndTime , 100)
		local nEndYear = floor(nEndTime / 100)
		LuaFnSendSystemMail(sceneId, GetName(sceneId, selfId),
			ScriptGlobal_Format("#{ZLSJ_231106_58}",tostring(month),tostring(days),tostring(nEndMonth),tostring(nEndDays))
		)
	end
	--即将结束也要发送邮件
	local nLeaveDay = x998526_GetMonthLeftDays(GetTime2Day(), nEndTime)
	if nLeaveDay <= 7 then
		ScriptGlobal_Format("#{ZLSJ_231106_57}",tostring(nLeaveDay))
	end
end
--**********************************
--计算结束天数
--**********************************
function x998526_GetMonthLeftDays(nTime, nEndTime)
	nTime = tonumber(nTime)
    nEndTime = tonumber(nEndTime)
    if not nTime or not nEndTime then
        return 0
    end
	
	local days = mod(nTime , 100)
	nTime = floor(nTime / 100)
	local month = mod(nTime , 100)
	local year = floor(nTime / 100)
	
	local nEndDays = mod(nEndTime , 100)
	nEndTime = floor(nEndTime / 100)
	local nEndMonth = mod(nEndTime , 100)
	local nEndYear = floor(nEndTime / 100)
	
	if days < 1 or days >31 or month < 1 or month > 12 then
		return 0
	end
	
	if nEndDays < 1 or nEndDays >31 or nEndMonth < 1 or nEndMonth > 12 then
		return 0
	end
	
	if nEndMonth == month then
		return nEndDays - days 
	else
		if 4 == month or 6 == month or 9 == month or 11 == month  then
			return (30 + nEndDays - days )
		elseif 2 == month then
			if ( 0 == mod(year , 4) and 0 ~= mod(year,100) ) or 0 == mod(year , 400) then
				--闰年
				return (29 + nEndDays - days )
			else
				return (28 + nEndDays - days )
			end
		else
			return (31 + nEndDays - days )
		end
	end
	

	return 0
end
--**********************************
--醒目提示
--**********************************
function x998526_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end