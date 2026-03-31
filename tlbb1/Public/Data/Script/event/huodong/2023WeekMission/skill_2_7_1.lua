--周任务
--打探消息-西凉枫林

x890101_g_ScriptId = 890101
x890101_g_MinLevel = 85
x890101_g_TransBuff = {
	[0] = 45519,
	[1] = 45518,
}
x890101_g_MissionId = 2143
x890101_g_SceneID=1294
--参数1空
x890101_g_MissionListen = 1
x890101_g_MissionPut = 2
x890101_g_MissionTar = 3

x890101_g_LisionTarget = {
	[1] = {name = "墨离",posx = 54,posz = 58,msg = "#{BLCC_20221214_575}"},
	[2] = {name = "墨回",posx = 75,posz = 60,msg = "#{BLCC_20221214_576}"},
	[3] = {name = "赵大刀",posx = 150,posz = 210,msg = "#{BLCC_20221214_577}"},
	[4] = {name = "甄百岁",posx = 153,posz = 212,msg = "#{BLCC_20221214_578}"},
}
--**********************************
--条件检测
--**********************************
function x890101_OnConditionCheck( sceneId, selfId,targetId )
	if sceneId ~= x890101_g_SceneID then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_342}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890101_g_MinLevel then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_60}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890101_g_TransBuff[nSelfSex]) ~= 1 then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_352}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890101_g_MissionId) <= 0 then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_352}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890101_g_MissionId )
	if GetMissionParam( sceneId, selfId,misIndex, x890101_g_MissionListen ) > 0 then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_74}" )
		return 0
	end
--	if GetMissionParam( sceneId, selfId,misIndex, x890101_g_MissionPut ) > 0 then
--		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_529}" )
--		return 0
--	end
	local nCurTarget = GetMissionParam( sceneId, selfId,misIndex, x890101_g_MissionTar )
	--确保容错
	if x890101_g_LisionTarget[nCurTarget] == nil then
		nCurTarget = 1
	end
	local tarTab = x890101_g_LisionTarget[nCurTarget]
	if GetName(sceneId,targetId) ~= tarTab.name then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_73}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, targetId);
	local distSqNpcToPlayer = floor(sqrt((selfPosX-tarTab.posx)*(selfPosX-tarTab.posx)+(selfPosZ-tarTab.posz)*(selfPosZ-tarTab.posz)))
	if distSqNpcToPlayer >= 3 then
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_73}")
		return 0
	end
	
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890101_SkillOnUnitOne(sceneId,selfId, nSkillId)
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_85}",0)
end
--**********************************
--引导等动作结束后会回调此入口
--**********************************
function x890101_OnActionFinished( sceneId, selfId, targetId )	
--	设置已放置好
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890101_g_MissionId )
	SetMissionByIndex( sceneId, selfId, misIndex, x890101_g_MissionListen,1 )
	--对话内容显示
	local nCurTarget = GetMissionParam( sceneId, selfId,misIndex, x890101_g_MissionTar )
	--确保容错
	if x890101_g_LisionTarget[nCurTarget] == nil then
		nCurTarget = 1
	end
	local tarTab = x890101_g_LisionTarget[nCurTarget]
	x890101_NotifyBox( sceneId, selfId,targetId, tarTab.msg)
--	打听过后标记完成
	if GetMissionParam( sceneId, selfId,misIndex, x890101_g_MissionPut ) > 0 then
		SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
		x890101_NotifyTip( sceneId, selfId, "#{BLCC_20221214_557}" )
	end
end
--**********************************
--对话框提示
--**********************************
function x890101_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--醒目提示
--**********************************
function x890101_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end