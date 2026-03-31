--周任务
--放置知音匣

x890090_g_ScriptId = 890090
x890090_g_MinLevel = 85
x890090_g_TransBuff = {
	[0] = 45511,
	[1] = 45510,
}
x890090_g_MissionId = 2135
x890090_g_SceneID=1293
x890090_g_NeedPosX = 35
x890090_g_NeedPosZ = 100
--参数1空
x890090_g_MissionListen = 1
x890090_g_MissionPut = 2
--**********************************
--条件检测
--**********************************
function x890090_OnConditionCheck( sceneId, selfId )
	if sceneId ~= x890090_g_SceneID then
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_342}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890090_g_MinLevel then
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_60}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890090_g_TransBuff[nSelfSex]) ~= 1 then
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_72}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890090_g_MissionId) <= 0 then
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_72}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890090_g_MissionId )
--	if GetMissionParam( sceneId, selfId,misIndex, x890090_g_MissionListen ) > 0 then
--		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_74}" )
--		return 0
--	end
	if GetMissionParam( sceneId, selfId,misIndex, x890090_g_MissionPut ) > 0 then
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_347}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, selfId);
	local distSqNpcToPlayer = floor(sqrt((selfPosX-x890090_g_NeedPosX)*(selfPosX-x890090_g_NeedPosX)+(selfPosZ-x890090_g_NeedPosZ)*(selfPosZ-x890090_g_NeedPosZ)))
	if distSqNpcToPlayer >= 3 then
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_80}")
		return 0
	end
	
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_77}",0)
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890090_SkillOnUnitOne(sceneId,selfId, nSkillId)
--	BLCC_20221214_77	知音匣就偷偷放这里吧~ 	
--	BLCC_20221214_78	知音匣放好了，快溜~	
	BroadMsgByChatPipe(sceneId,selfId,"#{BLCC_20221214_78}",0)
	x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_79}" )
	--设置已放置好
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890090_g_MissionId )
	SetMissionByIndex( sceneId, selfId, misIndex, x890090_g_MissionPut,1 )
	--打听过后标记完成
	if GetMissionParam( sceneId, selfId,misIndex, x890090_g_MissionListen ) > 0 then
		SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
		x890090_NotifyTip( sceneId, selfId, "#{BLCC_20221214_554}" )
	end
end
--**********************************
--醒目提示
--**********************************
function x890090_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end