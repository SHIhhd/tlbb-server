--每日副本-扫荡银符

x890289_g_ScriptId = 890289
x890289_g_dailyFuben =
{
	[1] = {
		[1] = { FuBenId = CAMPAIGN_QINGQIU, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_PIAOMIAOSMALL, FConNeed = 1, FYinbi = 50},
	},
	[2] = {
		[1] = { FuBenId = CAMPAIGN_PIAOMIAO, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_SHUIYUE, FConNeed = 1, FYinbi = 50},
	},
	[3] = {
		[1] = { FuBenId = CAMPAIGN_YANZIWU, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_WANGRIMENGJING, FConNeed = 1, FYinbi = 50},
	},
	[4] = {
		[1] = { FuBenId = CAMPAIGN_PIAOMIAOSMALL, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_SHUIYUE, FConNeed = 1, FYinbi = 50},
	},
	[5] = {
		[1] = { FuBenId = CAMPAIGN_QINGQIU, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_YANZIWU, FConNeed = 1, FYinbi = 50},
	},
	[6] = {
		[1] = { FuBenId = CAMPAIGN_PIAOMIAO, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_WANGRIMENGJING, FConNeed = 1, FYinbi = 50},
	},
	[0] = {
		[1] = { FuBenId = CAMPAIGN_SHUIYUE, FConNeed = 1, FYinbi = 50},
		[2] = { FuBenId = CAMPAIGN_PIAOMIAOSMALL, FConNeed = 1, FYinbi = 50},
	},
}
x890289_g_UiCommand_Type = {
	openUI = 1,
	UpdateUI = 2,
	disableBtn = 3,
}
x890289_g_DataIndex = {
	[1] = {getFlag = MFEX_FUBEN_DAILY_1,Condition = MDEX_FUBEN_DAILY_FINISH_1},
	[2] = {getFlag = MFEX_FUBEN_DAILY_2,Condition = MDEX_FUBEN_DAILY_FINISH_2},
}
x890289_g_YinFuDaiBiMax = 500 --最大银符数量
--**********************************
--领取奖励
--**********************************
function x890289_OnGetReward(sceneId, selfId,nNowDaily,nIndex)
	if nNowDaily ~= GetTodayWeek() then
		return
	end
	if x890289_g_DataIndex[nIndex] == nil then
		return
	end
	if x890289_g_dailyFuben[GetTodayWeek()] == nil then
		return
	end
	if GetMissionFlagEx(sceneId,selfId,x890289_g_DataIndex[nIndex].getFlag) == 1 then
		x890289_NotifyTip(sceneId, selfId, "#{YBSD_231107_33}")
		return
	end
	local todayCount = GetMissionDataEx(sceneId,selfId,x890289_g_DataIndex[nIndex].Condition)
	local needCount = x890289_g_dailyFuben[GetTodayWeek()][nIndex].FConNeed
	if todayCount < needCount then
		x890289_NotifyTip(sceneId, selfId, "#{YBSD_231107_34}")
		return
	end
	local _,_,_,_,_,nJinBiDaiBi,nYinBiDaiBi = LuaFnGetSecKillData(sceneId,selfId)
	if nYinBiDaiBi >= x890289_g_YinFuDaiBiMax then
		x890289_NotifyTip(sceneId, selfId, "#{YBSD_231107_35}")
		return
	end
	local canGetValue = x890289_g_dailyFuben[GetTodayWeek()][nIndex].FYinbi
	if canGetValue + nYinBiDaiBi > x890289_g_YinFuDaiBiMax then
		x890289_NotifyTip(sceneId, selfId, ScriptGlobal_Format("#{YBSD_231107_36}",
		 tostring(x890289_g_YinFuDaiBiMax -nYinBiDaiBi)))
		x890289_NotifyTip(sceneId, selfId, "#{YBSD_231107_38}")
		
		LuaFnSetSecKillYinBi(sceneId,selfId,x890289_g_YinFuDaiBiMax)
	else
		x890289_NotifyTip(sceneId, selfId, ScriptGlobal_Format("#{YBSD_231107_36}",
		 tostring(canGetValue)))
		
		LuaFnSetSecKillYinBi(sceneId,selfId,nYinBiDaiBi + canGetValue)
	end
	x890289_OnRefreshUI(sceneId, selfId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end
--**********************************
--完成副本
--**********************************
function x890289_OnFinish(sceneId, selfId ,nFuBenId)
	if x890289_g_dailyFuben[GetTodayWeek()] == nil then
		return
	end
	for i = 1,getn(x890289_g_dailyFuben[GetTodayWeek()]) do
		if x890289_g_dailyFuben[GetTodayWeek()][i].FuBenId == nFuBenId then
			local todayCount = GetMissionDataEx(sceneId,selfId,x890289_g_DataIndex[i].Condition)
			if todayCount < x890289_g_dailyFuben[GetTodayWeek()][i].FConNeed then
				todayCount = todayCount + 1
				SetMissionDataEx(sceneId,selfId,x890289_g_DataIndex[i].Condition,todayCount)
				break
			end
		end
	end
end
--**********************************
--刷新主UI
--**********************************
function x890289_OnRefreshUI(sceneId, selfId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,x890289_g_UiCommand_Type.UpdateUI)		
		UICommand_AddInt( sceneId,GetTodayWeek())		
		
		UICommand_AddInt( sceneId,GetMissionFlagEx(sceneId,selfId,MFEX_FUBEN_DAILY_1))		--IsBtn1Disable
		UICommand_AddInt( sceneId,GetMissionFlagEx(sceneId,selfId,MFEX_FUBEN_DAILY_2))		--IsBtn2Disable
		
		UICommand_AddInt( sceneId,GetMissionDataEx(sceneId,selfId,MDEX_FUBEN_DAILY_FINISH_1))		--Condition1
		UICommand_AddInt( sceneId,GetMissionDataEx(sceneId,selfId,MDEX_FUBEN_DAILY_FINISH_2))		--Condition2
		
		UICommand_AddInt( sceneId,0)		--QiYuTag	
		
		local _,_,_,_,_,nJinBiDaiBi,nYinBiDaiBi = LuaFnGetSecKillData(sceneId,selfId)
		UICommand_AddInt( sceneId,nYinBiDaiBi)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,89028901)
end
--**********************************
--打开主UI
--**********************************
function x890289_OnOpenUI(sceneId, selfId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,x890289_g_UiCommand_Type.openUI)		
		UICommand_AddInt( sceneId,GetTodayWeek())		
		
		UICommand_AddInt( sceneId,GetMissionFlagEx(sceneId,selfId,MFEX_FUBEN_DAILY_1))		--IsBtn1Disable
		UICommand_AddInt( sceneId,GetMissionFlagEx(sceneId,selfId,MFEX_FUBEN_DAILY_2))		--IsBtn2Disable
		
		UICommand_AddInt( sceneId,GetMissionDataEx(sceneId,selfId,MDEX_FUBEN_DAILY_FINISH_1))		--Condition1
		UICommand_AddInt( sceneId,GetMissionDataEx(sceneId,selfId,MDEX_FUBEN_DAILY_FINISH_2))		--Condition2
		
		UICommand_AddInt( sceneId,0)		--QiYuTag	
		
		local _,_,_,_,_,nJinBiDaiBi,nYinBiDaiBi = LuaFnGetSecKillData(sceneId,selfId)
		UICommand_AddInt( sceneId,nYinBiDaiBi)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,89028901)
end
--**********************************
--提示
--**********************************
function x890289_NotifyTip(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
