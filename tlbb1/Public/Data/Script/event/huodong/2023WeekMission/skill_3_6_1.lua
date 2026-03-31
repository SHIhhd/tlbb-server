--周任务
--打探消息

x890097_g_ScriptId = 890097
x890097_g_MinLevel = 85
x890097_g_TransBuff = {
	[0] = 45523,
	[1] = 45522,
}
x890097_g_MissionId = 2149
x890097_g_SceneID=1292
--参数1空
x890097_g_MissionListen = 1
x890097_g_MissionPut = 2
x890097_g_MissionTar = 3

x890097_g_LisionTarget = {
	[1] = {name = "墨如",posx = 130,posz = 190,msg = "#{BLCC_20221214_567}"},
	[2] = {name = "墨晓清",posx = 125,posz = 178,msg = "#{BLCC_20221214_568}"},
	[3] = {name = "杨老三",posx = 194,posz = 81,msg = "#{BLCC_20221214_569}"},
	[4] = {name = "孙虎",posx = 196,posz = 85,msg = "#{BLCC_20221214_570}"},
}
--**********************************
--条件检测
--**********************************
function x890097_OnConditionCheck( sceneId, selfId,targetId )
	if sceneId ~= x890097_g_SceneID then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_341}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890097_g_MinLevel then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_60}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890097_g_TransBuff[nSelfSex]) ~= 1 then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_354}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890097_g_MissionId) <= 0 then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_354}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890097_g_MissionId )
	if GetMissionParam( sceneId, selfId,misIndex, x890097_g_MissionListen ) > 0 then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_74}" )
		return 0
	end
--	if GetMissionParam( sceneId, selfId,misIndex, x890097_g_MissionPut ) > 0 then
--		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_529}" )
--		return 0
--	end
	local nCurTarget = GetMissionParam( sceneId, selfId,misIndex, x890097_g_MissionTar )
	--确保容错
	if x890097_g_LisionTarget[nCurTarget] == nil then
		nCurTarget = 1
	end
	local tarTab = x890097_g_LisionTarget[nCurTarget]
	if GetName(sceneId,targetId) ~= tarTab.name then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_73}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, targetId);
	local distSqNpcToPlayer = floor(sqrt((selfPosX-tarTab.posx)*(selfPosX-tarTab.posx)+(selfPosZ-tarTab.posz)*(selfPosZ-tarTab.posz)))
	if distSqNpcToPlayer >= 3 then
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_73}")
		return 0
	end
	
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890097_SkillOnUnitOne(sceneId,selfId, nSkillId)
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_206}",0)
end
--**********************************
--引导等动作结束后会回调此入口
--**********************************
function x890097_OnActionFinished( sceneId, selfId, targetId )	
--	设置已放置好
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890097_g_MissionId )
	SetMissionByIndex( sceneId, selfId, misIndex, x890097_g_MissionListen,1 )
	--对话内容显示
	local nCurTarget = GetMissionParam( sceneId, selfId,misIndex, x890097_g_MissionTar )
	--确保容错
	if x890097_g_LisionTarget[nCurTarget] == nil then
		nCurTarget = 1
	end
	local tarTab = x890097_g_LisionTarget[nCurTarget]
	x890097_NotifyBox( sceneId, selfId,targetId, tarTab.msg)
--	打听过后标记完成
	if GetMissionParam( sceneId, selfId,misIndex, x890097_g_MissionPut ) > 0 then
		SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
		x890097_NotifyTip( sceneId, selfId, "#{BLCC_20221214_558}" )
	end
end
--**********************************
--对话框提示
--**********************************
function x890097_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--醒目提示
--**********************************
function x890097_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end