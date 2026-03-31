--墨星翁

x890246_g_ScriptId	= 890246
--所拥有的事件ID列表
x890246_g_eventList={
	--天鉴·竹林之危
	890073,
	--天鉴·不堪其扰
	890107,
}
--**********************************
--事件列表
--**********************************
function x890246_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{CJGH_221223_05}");
	for i, eventId in x890246_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x890246_OnDefaultEvent( sceneId, selfId,targetId )
	x890246_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x890246_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x890246_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x890246_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890246_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId,targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x890246_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x890246_g_eventList do
		if missionScriptId == findId then
			x890246_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x890246_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890246_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x890246_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x890246_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x890246_OnDie( sceneId, selfId, killerId )
end
