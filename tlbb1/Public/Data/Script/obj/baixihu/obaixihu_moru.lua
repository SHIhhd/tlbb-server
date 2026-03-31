--墨如
x890233_g_ScriptId	= 890233
--所拥有的事件ID列表
x890233_g_eventList={
	--天鉴·冰湖狼患
	890065,
	--天鉴·冰湖之危
	890066,
	--天鉴·冰蚀木魇
	890105,
	--材料合成
	998257
}

--**********************************
--事件列表
--**********************************
function x890233_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{CJGH_221223_20}");
	for i, eventId in x890233_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x890233_OnDefaultEvent( sceneId, selfId,targetId )
	x890233_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x890233_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x890233_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x890233_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890233_g_eventList do
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
function x890233_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x890233_g_eventList do
		if missionScriptId == findId then
			x890233_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x890233_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890233_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x890233_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x890233_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x890233_OnDie( sceneId, selfId, killerId )
end

