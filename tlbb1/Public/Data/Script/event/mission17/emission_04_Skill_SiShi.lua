--乔装技能
x891100_g_ScriptId = 891100
x891100_g_MissionId = 2003			--任务ID号
function x891100_OnConditionCheck( sceneId, selfId )
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891100_g_MissionId)
	if IsHaveMission(sceneId,selfId,x891100_g_MissionId) <= 0 then
		x891100_NotifyTip(sceneId,"#{YXDHYD_20210205_26}")
		return 0
	end
	if GetMissionParam(sceneId,selfId,nMisIndex,0) > 0 then
		x891100_NotifyTip(sceneId,"#{YXDHYD_20210205_27}")
		return 0
	end
	if GetMissionParam(sceneId,selfId,nMisIndex,1) < 3 then
		x891100_NotifyTip(sceneId,"#{YXDHYD_20210205_28}")
		return 0
	end
	if GetMissionParam(sceneId,selfId,nMisIndex,1) > 3 then
		x891100_NotifyTip(sceneId,"#{YXDHYD_20210205_29}")
		return
	end
	local sceneType = LuaFnGetSceneType(sceneId)
	if sceneType ~= 1 then
		x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_30}")
		return 0
	end
	if LuaFnGetCopySceneData_Param(sceneId,0) ~= FUBEN_YETANSHUIYUESHANZHAUNG then
		x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_30}")
		return 0
	end
	--双人坐骑状态下
	if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
		x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_34}")
		return 0
	end
	--坐骑状态下
	if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
		x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_34}")
		return 0
	end
	--变身状态下
	if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
		x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_32}")
		return 0
	end
	if GetTeamId(sceneId,selfId) >= 0 then
		x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_33}")
		return 0
	end
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x891100_SkillOnUnitOne(sceneId,selfId, nSkillId)
	if nSkillId ~= 3245 then
		return
	end
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891100_g_MissionId)
	BroadMsgByChatPipe(sceneId,selfId,"#{YXDHYD_20210325_26}",0) --发送附近对话
	--给BUFF
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,10514,0)
	SetMissionByIndex(sceneId,selfId,nMisIndex,1,4) --设置新阶段
	x891100_NotifyTip(sceneId,selfId,"#{YXDHYD_20210205_35}")
	--创建十三和家丁
	CreateMonsterWithDir(sceneId,49005,124,127,3,-1,-1,0) --十三
	CreateMonsterWithDir(sceneId,49003,128,129,3,-1,-1,11) --家丁
	CreateMonsterWithDir(sceneId,49003,128,126,3,-1,-1,11) --家丁
	CreateMonsterWithDir(sceneId,49003,128,123,3,-1,-1,11) --家丁
	CreateMonsterWithDir(sceneId,49003,128,120,3,-1,-1,11) --家丁
end

--**********************************
--醒目提示
--**********************************
function x891100_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end