--曼陀山庄庄主
--王夫人

--脚本号
x893261_g_scriptId = 893261

--所拥有的事件ID列表
x893261_g_eventList={229009, 229012, 808092,
	--武道三重
	998353}

--**********************************
--事件列表
--**********************************
function x893261_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{MPSD_220622_102}");
	for i, eventId in x893261_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893261_OnDefaultEvent( sceneId, selfId,targetId )
	x893261_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893261_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x893261_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_MANTUO )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893261_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893261_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x893261_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x893261_g_eventList do
		if missionScriptId == findId then
			x893261_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x893261_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893261_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x893261_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x893261_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x893261_OnDie( sceneId, selfId, killerId )
end
