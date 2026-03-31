--玄武岛 云决决
--脚本号
x893053_g_scriptId = 893053

--所拥有的事件ID列表
x893053_g_eventList={ 893041,893042,893043,893044 }	

--完成后不可进入玄武岛镜的任务号
x893053_g_MissionId = 2063

--可进入玄武岛镜的等级
x893053_g_MissionLevel = 85

x893053_g_AcceptNPCPosition_X=107
x893053_g_AcceptNPCPosition_Z=87
x893053_g_AcceptNPCSceneID=39
--**********************************
--事件列表
--**********************************
function x893053_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SHYD_20211227_47}")
		for i, eventId in x893053_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		--如果完成了某个任务，则不再允许进入
		if IsMissionHaveDone(sceneId,selfId,x893053_g_MissionId) <= 0 then
			AddNumText( sceneId, x893053_g_scriptId, "#{SHYD_20211227_48}", 9, 1 )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893053_OnDefaultEvent( sceneId, selfId,targetId )
	x893053_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893053_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		--这里有一部分前置校验条件
		if GetLevel(sceneId,selfId) < x893053_g_MissionLevel then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_100}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if sceneId ~= x893053_g_AcceptNPCSceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_104}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		local playerX, playerZ = GetWorldPos(sceneId, selfId)
		local distance = floor(sqrt((playerX-x893053_g_AcceptNPCPosition_X)*(playerX-x893053_g_AcceptNPCPosition_X)+(playerZ-x893053_g_AcceptNPCPosition_Z)*(playerZ-x893053_g_AcceptNPCPosition_Z)))
		if distance > 6 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_102}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if IsMissionHaveDone(sceneId,selfId,x893053_g_MissionId) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_109}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--正在进入玄武岛·镜。	
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_111}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 40, 243, 147 )
		return
	end

	for i, findId in x893053_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893053_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893053_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x893053_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x893053_g_eventList do
		if missionScriptId == findId then
			x893053_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x893053_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893053_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x893053_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x893053_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x893053_OnDie( sceneId, selfId, killerId )
end
