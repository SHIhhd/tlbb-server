--恶人谷NPC
--岳老三
--普通

x018039_g_ScriptId = 018039

--所拥有的事件ID列表
x018039_g_eventList = {891219,891220,228905,893259,229011,1018880,1018881,1018882,1018883,1018884,1018885,1018886,1018887,1018888,1018889,1018890}

--**********************************
--事件列表
--**********************************
function x018039_UpdateEventList( sceneId, selfId, targetId )
	local playerMenpai = GetMenPai(sceneId, selfId)
	if playerMenpai ~= MP_ERENGU then
		BeginEvent(sceneId)
		AddText(sceneId, "#{ERMP_240620_27}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	else
		BeginEvent(sceneId)
		AddText(sceneId, "#{ERMP_240620_05}")
		for i, eventId in x018039_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId, MP_MANTUO )
		end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	end
end

--**********************************
--事件交互入口
--**********************************
function x018039_OnDefaultEvent( sceneId, selfId, targetId )
	x018039_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x018039_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x018039_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId, MP_MANTUO, GetNumText() )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x018039_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x018039_g_eventList do
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
function x018039_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x018039_g_eventList do
		if missionScriptId == findId then
			x018039_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x018039_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x018039_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x018039_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x018039_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x018039_OnDie( sceneId, selfId, killerId )
end

--**********************************
--任务检查
--**********************************
function x018039_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	for i, findId in x018039_g_eventList do
		if scriptId == findId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
			return
		end
	end
end
