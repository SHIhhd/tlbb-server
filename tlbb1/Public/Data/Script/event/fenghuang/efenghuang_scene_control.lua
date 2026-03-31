--凤凰古城 场景控制器
x403004_g_ScriptId	= 403004
--主心跳周期
x403004_g_HeartBeatTime = 1000
--场景特殊音效
x403004_g_SoundTable = {
	flag_take = 2090,		--拔起旗帜
	flag_submit = 2096,		--提交旗帜
	flag_refresh = 2093,	--旗帜刷新
	crystal_destory = 2094,	--水晶摧毁
	crystal_refresh = 2095,	--水晶刷新
	war_begin= 2091,		--城战结束
	war_end = 2092,			--城战开始
}
--玩家进入场景的位置
x403004_g_InitPosData = 
{	--对应1-8号营地
	{x = 68,z = 33,capmId = 500,scoreIdx = 0,parapmIdx = 22},
	{x = 251,z = 27,capmId = 501,scoreIdx = 1,parapmIdx = 23},
	{x = 289,z = 64,capmId = 502,scoreIdx = 2,parapmIdx = 24},
	{x = 292,z = 252,capmId = 503,scoreIdx = 3,parapmIdx = 25},
	{x = 258,z = 291,capmId = 504,scoreIdx = 4,parapmIdx = 26},
	{x = 66,z = 292,capmId = 505,scoreIdx = 5,parapmIdx = 27},
	{x = 28,z = 262,capmId = 506,scoreIdx = 6,parapmIdx = 28},
	{x = 35,z = 60,capmId = 507,scoreIdx = 7,parapmIdx = 29}
}
--普通场景的凤凰战旗
x403004_g_CommonFlagDataId = 14011	
--凤凰战旗的ImpactId	凤凰战旗的Impact是专用BUFF，特殊的一些逻辑在c++完成，lua只负责buff的给予
x403004_g_FlagImpactId = 10542
--此次启动的ANSI时间
x403004_g_ParamHasReady = 0

--**********************************
--脚本入口函数
--**********************************
function x403004_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	--参数说明：场景ID，活动ID，时间间隔，公告类型（可以不传，默认普通公告类型）
	StartOneActivity( sceneId, actId, x403004_g_HeartBeatTime, iNoticeType )
end

--**********************************
--心跳函数（周期1000ms）
--**********************************
function x403004_OnTimer( sceneId, actId, uTime )
	--检测活动是否过期
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity( sceneId, actId )
	end
	
	
end
--**********************************
--凤凰古城争夺战主逻辑回调
--**********************************
function x403004_OnSceneTimer(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount < 1 then
		return
	end
	--准备期处理
	if x403004_IsInActivityReadyTime(sceneId) == 1 then
		for i = 1,nHumanCount do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i-1)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
				--送至入口
				--由于您处于凤凰古城争夺战的预备期，因此被传送到了束河古镇。	
				x403004_NotifyTip(sceneId,nHumanId,"#{FHZD_090825_6}")
				CallScriptFunction(403003, "GoToShuHe",sceneId, nHumanId)
			end
		end
		--没有准备则进入准备逻辑
		if LuaFnGetCopySceneData_Param(sceneId,x403004_g_ParamHasReady) ~= 1 then
			x403004_OnFengHuangReady(sceneId)
		end
		return
	end



end
--**********************************
--凤凰古城争夺战预备期
--**********************************
function x403004_OnFengHuangReady(sceneId)
	--开启前清理中心旗帜及传送NPC
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local nMonsterObjId = GetMonsterObjID(sceneId,i)
		local nMonsterDataId = GetMonsterDataID( sceneId, nMonsterObjId )
		--清理凤凰战旗
		if nMonsterDataId == x403004_g_CommonFlagDataId then
			LuaFnDeleteMonster(sceneId, nMonsterObjId)
		end
		--清理黄龙天
		if nMonsterDataId == 101 then
			LuaFnDeleteMonster(sceneId, nMonsterObjId)
		end
	end
	--清理历史的一些数据及管理器状态
	LuaFnResetPhoenixPlainManager(sceneId)
	--通知程序逻辑开始执行
	--LuaFnPhoenixPlainManagerRun(sceneId)

	--标记准备完成
	LuaFnSetCopySceneData_Param(sceneId,x403004_g_ParamHasReady,1)
	--Log
	local recordMsg = format("[PhoenixPlain]Ready...OK sceneId=%d", sceneId)
	ScriptGlobal_AuditGeneralLog(LUAAUDIT_PHOENIX_PLAIN_WAR, -1, recordMsg)
end
--**********************************
--请求进入凤凰古城
--**********************************
function x403004_GoToPhoenixPlain(sceneId,selfId,targetId)
	--城战期间
	if x403004_IsInActivityTime(sceneId) == 1 then
		--申请阵营
		LuaFnAllocPhoenixPlainCamp(sceneId,selfId)
	else
	--平常时期
		local nRandom = random(getn(x403004_g_InitPosData))
		CallScriptFunction(400900, "TransferFunc",sceneId, selfId, SCENE_PHOENIXPLAIN,x403004_g_InitPosData[nRandom].x,x403004_g_InitPosData[nRandom].z)
	end
end
--**********************************
--服务器回调阵营数据
--**********************************
function x403004_RetGoToPhoenixPlain(sceneId,selfId,nCampIndex)
	if nCampIndex == -3 then
		--凤凰古城争夺战已经开始，由于场景人数达到了上限，因此被传送到了束河古镇。	
		x403004_NotifyTip(sceneId,selfId,"#{FHZD_090825_17}")
		return
	end
	--人员已满
	if nCampIndex == -2 then
		--由于您的帮会或同盟参与凤凰古城争夺战的人数已达上限，所以您无法参与凤凰古城争夺战。	
		x403004_NotifyTip(sceneId,selfId,"#{FHZD_090908_8}")
		return
	end
	--分配失败，程序异常
	if nCampIndex == -1 then
		local recordMsg = format("x403004_RetGoToPhoenixPlain Error!!! sceneid=%d, objid=%d nCampIndex=%d", sceneId,selfId,nCampIndex)
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_PHOENIX_PLAIN_WAR, -1, recordMsg)
		return
	end
	CallScriptFunction(400900, "TransferFunc",sceneId, selfId, SCENE_PHOENIXPLAIN,x403004_g_InitPosData[nCampIndex].x,x403004_g_InitPosData[nCampIndex].z)
end
--**********************************
--玩家进入凤凰平原战场
--**********************************
function x403004_OnScenePlayerEnter(sceneId,selfId)
	--城战期间
	if x403004_IsInActivityTime(sceneId) == 1 then
		local nCampIndex = LuaFnGetCurPhoenixPlainCamp(sceneId,selfId)
		if nCampIndex == -1 then
			local recordMsg = format("x403004_OnScenePlayerEnter Error!!! sceneid=%d, objid=%d nCampIndex=%d", sceneId,selfId,nCampIndex)
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_PHOENIX_PLAIN_WAR, -1, recordMsg)
			return
		end
		--设置阵营
		SetUnitCampID(sceneId,selfId,selfId,x403004_g_InitPosData[nCampIndex + 1].capmId)
		--设置玩家战斗模式因是普通场景
		SetPlayerPvpMode(sceneId,selfId,4)
		--玩家进入场景设置进入场景复活点
		SetPlayerDefaultReliveInfo(sceneId,selfId,"%100","%100","%100", SCENE_PHOENIXPLAIN,x403004_g_InitPosData[nCampIndex + 1].x,x403004_g_InitPosData[nCampIndex + 1].z);
		--音效提醒
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 2092)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 403004)
	else
	--平常时期
		--找有无凤凰战旗
		local nHaveFlag = 0;
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local nMonsterObjId = GetMonsterObjID(sceneId,i)
			local nMonsterDataId = GetMonsterDataID( sceneId, nMonsterObjId )
			if nMonsterDataId == x403004_g_CommonFlagDataId then
				nHaveFlag = 1
				break
			end
		end
		--没有创建凤凰战旗和传送出去的NPC
		if nHaveFlag == 0 then
			--创建普通场景下的凤凰战旗
			x403004_CreateCommonFlag( sceneId)
			--创建NPC黄龙天
			x403004_CreateTransportNpc( sceneId)
		end
	end
end
--**********************************
--玩家在凤凰古城死亡或杀人
--**********************************
function x403004_OnSceneHumanDie(sceneId,selfId,nKillerId)
	if selfId == nKillerId or nKillerId == -1 then
		return
	end
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x403004_g_FlagImpactId) ~= 1 then
		return
	end
	--将旗子转移给击杀者
	LuaFnSendSpecificImpactToUnit(sceneId,nKillerId,nKillerId,nKillerId,x403004_g_FlagImpactId,0) 
	--tips FHZD_090708_58	丢掉了凤凰战旗。
	x403004_HumanTips(sceneId,format("#{_INFOUSR%s}#{FHZD_090708_58}",GetName(sceneId,selfId)))
	--场景广播信息
	-- FHZD_090708_19	一掌击中	
	-- FHZD_090708_20	面门，	
	-- FHZD_090708_21	顿时气绝身亡，手中的凤凰战旗掉落下来。	
	local strBoard = format("#{_INFOUSR%s}#{FHZD_090708_19}#{_INFOUSR%s}#{FHZD_090708_20}#{FHZD_090708_21}",GetName(sceneId,nKillerId),GetName(sceneId,selfId));
	x403004_SceneChat( sceneId,strBoard)
	--本阵营的广播信息 
	--FHZD_090708_58	丢掉了凤凰战旗。	
	x403004_CampChat(sceneId,selfId,format("#{FHZD_090915_12}#{_INFOUSR%s}{FHZD_090708_58}",GetName(sceneId,selfId)))
	--FHZD_090915_13	#W力挽狂澜，夺取了凤凰战旗，为我方得到了#G120分#W。	
	x403004_CampChat(sceneId,nKillerId,format("#{FHZD_090915_12}#{_INFOUSR%s}{FHZD_090915_13}",GetName(sceneId,nKillerId)))
	LuaFnAddCurPhoenixPlainScore(sceneId,nKillerId,120)
end
--**********************************
--创建NPC黄龙天
--**********************************
function x403004_CreateTransportNpc( sceneId)
	local nMonsterId = CreateMonsterWithDir(sceneId,101,163,164,3,-1,403007,3.14)
	if nMonsterId > 0 then
		SetCharacterTitle(sceneId,nMonsterId,"#{FHZD_090915_36}") 
		SetCharacterName(sceneId,nMonsterId,"#{FHZD_090915_35}") 
	end
	local recordMsg = format("x403004_CreateTransportNpc sceneid=%d, objid=%d", sceneId,nMonsterId)
	ScriptGlobal_AuditGeneralLog(LUAAUDIT_PHOENIX_PLAIN_WAR, -1, recordMsg)
end

--**********************************
--创建普通场景下的凤凰战旗
--**********************************
function x403004_CreateCommonFlag( sceneId)
	local bHaveWiner,leagueName, guildName1, guildName2, guildIName3 = LuaFnGetPhoenixPlainWinerInfo(sceneId)
	local nFlagObj = CreateMonsterWithDir(sceneId,x403004_g_CommonFlagDataId,162,160.85,3,-1,403005,3.14)
	if nFlagObj > 0 then
		if bHaveWiner == 1 then
			SetCharacterTitle(sceneId,nFlagObj,"#{FHZD_090708_36}"..leagueName)
		else
			SetCharacterTitle(sceneId,nFlagObj,"#{FHZD_090915_34}")
		end
	end
	local recordMsg = format("x403004_CreateCommonFlag sceneid=%d, bHaveWiner=%d, objid=%d", sceneId, bHaveWiner,nFlagObj)
	ScriptGlobal_AuditGeneralLog(LUAAUDIT_PHOENIX_PLAIN_WAR, -1, recordMsg)
end
--**********************************
--本阵营广播信息
--**********************************
function x403004_CampChat(sceneId,selfId,strMsg)
	local nLeagueId = LuaFnGetHumanGuildLeagueID(sceneId,selfId);
	if nLeagueId == -1 then
		--纯帮会阵营
		local nGuildid = GetHumanGuildID(sceneId,selfId)
		if nGuildid == -1 then
			--这人什么都没有?????
			local recordMsg = format("x403004_CampChat sceneid=%d,objid=%d no guild and guild league", sceneId, selfId)
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_PHOENIX_PLAIN_WAR, -1, recordMsg)
		else
			BroadMsgByChatPipe(sceneId,selfId,strMsg,6)
		end
	else
		BroadMsgByChatPipe(sceneId,selfId,strMsg,12)
	end
end
--**********************************
--场景广播信息
--**********************************
function x403004_SceneChat( sceneId,str)	
	MonsterTalk(sceneId,-1,GetSceneName(sceneId),str)
end
--**********************************
--全屏玩家提示
--**********************************
function x403004_HumanTips( sceneId,str)	
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount < 1 then
		return
	end
	for i = 1,nHumanCount do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i-1)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			BeginEvent( sceneId )
				AddText( sceneId, str )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, nHumanId )
		end
	end
end
--**********************************
--音效播放
--**********************************
function x403004_BroadSound( sceneId,nSoundId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount < 1 then
		return
	end
	for i = 1,nHumanCount do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i-1)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, nSoundId)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, nHumanId, 403004)
		end
	end
end
--**********************************
--是否在活动准备期
--**********************************
function x403004_IsInActivityReadyTime(sceneId)
	local nWeek = GetTodayWeek();
	local nQuarter = mod(GetQuarterTime(),100);
	if (nWeek == 1 or nWeek == 3 or nWeek == 5 ) and nQuarter >= 76 and nQuarter < 80 then
		return 1
	end
	return 0
end
--**********************************
--是否在活动期间
--**********************************
function x403004_IsInActivityTime(sceneId)
	--240 244
	if CheckActiviyValidity( sceneId, 240 ) ~= 1 and CheckActiviyValidity( sceneId, 244 ) ~= 1 then
		return 0
	end
	return 1
end
--**********************************
--屏幕中间信息提示
--**********************************
function x403004_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403004_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


