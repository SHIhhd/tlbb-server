--周任务
--放置安神香炉

x890104_g_ScriptId = 890104
x890104_g_MinLevel = 85
x890104_g_TransBuff = {
	[0] = 45525,
	[1] = 45524,
}
x890104_g_MissionId = 2150
x890104_g_SceneID=1293
x890104_g_NeedPosX = 35
x890104_g_NeedPosZ = 100
--参数1空
x890104_g_MissionListen = 1
x890104_g_MissionPut = 2
--**********************************
--条件检测
--**********************************
function x890104_OnConditionCheck( sceneId, selfId )
	if sceneId ~= x890104_g_SceneID then
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_342}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890104_g_MinLevel then
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_60}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890104_g_TransBuff[nSelfSex]) ~= 1 then
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_357}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890104_g_MissionId) <= 0 then
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_357}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890104_g_MissionId )
--	if GetMissionParam( sceneId, selfId,misIndex, x890104_g_MissionListen ) > 0 then
--		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_74}" )
--		return 0
--	end
	if GetMissionParam( sceneId, selfId,misIndex, x890104_g_MissionPut ) > 0 then
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_536}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, selfId);
	local distSqNpcToPlayer = floor(sqrt((selfPosX-x890104_g_NeedPosX)*(selfPosX-x890104_g_NeedPosX)+(selfPosZ-x890104_g_NeedPosZ)*(selfPosZ-x890104_g_NeedPosZ)))
	if distSqNpcToPlayer >= 3 then
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_540}")
		return 0
	end
	
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_537}",0)
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890104_SkillOnUnitOne(sceneId,selfId, nSkillId)
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_538}",0)
	x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_539}" )
	--设置已放置好
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890104_g_MissionId )
	SetMissionByIndex( sceneId, selfId, misIndex, x890104_g_MissionPut,1 )
	--打听过后标记完成
	if GetMissionParam( sceneId, selfId,misIndex, x890104_g_MissionListen ) > 0 then
		SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
		x890104_NotifyTip( sceneId, selfId, "#{BLCC_20221214_559}" )
	end
end
--**********************************
--醒目提示
--**********************************
function x890104_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end