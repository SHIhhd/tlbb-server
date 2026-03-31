--周任务
--放置竹灯

x890094_g_ScriptId = 890094
x890094_g_MinLevel = 85
x890094_g_TransBuff = {
	[0] = 45517,
	[1] = 45516,
}
x890094_g_MissionId = 2142
x890094_g_SceneID=1292
x890094_g_NeedPosX = 73
x890094_g_NeedPosZ = 44
--参数1空
x890094_g_MissionListen = 1
x890094_g_MissionPut = 2
--**********************************
--条件检测
--**********************************
function x890094_OnConditionCheck( sceneId, selfId )
	if sceneId ~= x890094_g_SceneID then
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_341}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890094_g_MinLevel then
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_60}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890094_g_TransBuff[nSelfSex]) ~= 1 then
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_350}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890094_g_MissionId) <= 0 then
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_350}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890094_g_MissionId )
--	if GetMissionParam( sceneId, selfId,misIndex, x890094_g_MissionListen ) > 0 then
--		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_74}" )
--		return 0
--	end
	if GetMissionParam( sceneId, selfId,misIndex, x890094_g_MissionPut ) > 0 then
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_529}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, selfId);
	local distSqNpcToPlayer = floor(sqrt((selfPosX-x890094_g_NeedPosX)*(selfPosX-x890094_g_NeedPosX)+(selfPosZ-x890094_g_NeedPosZ)*(selfPosZ-x890094_g_NeedPosZ)))
	if distSqNpcToPlayer >= 3 then
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_533}")
		return 0
	end
	
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_530}",0)
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890094_SkillOnUnitOne(sceneId,selfId, nSkillId)
--	BLCC_20221214_530	竹灯就偷偷放这里吧~	
--	BLCC_20221214_531	竹灯放好了，快溜~	
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_531}",0)
	x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_532}" )
	--设置已放置好
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890094_g_MissionId )
	SetMissionByIndex( sceneId, selfId, misIndex, x890094_g_MissionPut,1 )
	--打听过后标记完成
	if GetMissionParam( sceneId, selfId,misIndex, x890094_g_MissionListen ) > 0 then
		SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
		x890094_NotifyTip( sceneId, selfId, "#{BLCC_20221214_556}" )
	end
end
--**********************************
--醒目提示
--**********************************
function x890094_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end