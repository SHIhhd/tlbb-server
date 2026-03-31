--恶人谷NPC
--探情
--普通

x018040_g_ScriptId = 018040

--所拥有的事件ID列表
x018040_g_eventList = {500073}

--**********************************
--事件列表
--**********************************
function x018040_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	AddText(sceneId, "#{ERMP_240620_28}")
	for i, eventId in x018040_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件交互入口
--**********************************
function x018040_OnDefaultEvent( sceneId, selfId, targetId )
	x018040_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x018040_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x018040_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId, GetNumText(), x018040_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x018040_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x018040_g_eventList do
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
function x018040_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x018040_g_eventList do
		if missionScriptId == findId then
			x018040_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x018040_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x018040_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x018040_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x018040_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x018040_OnDie( sceneId, selfId, killerId )
end
