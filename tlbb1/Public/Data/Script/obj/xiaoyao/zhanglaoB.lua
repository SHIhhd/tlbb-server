--武道A版NPC

--脚本号
x891233_g_ScriptId = 891233

--所拥有的事件ID列表
x891233_g_eventList = {
	--武道引导
	891220,891221,891222,891223,891224,
	--武道修行任务
	891272,
	891273,
	--武道修行
	292000,
	--武道商店
	--891271
	--武道二重
	893242,893243,
	--武道三重
	998352,998353
}	

--**********************************
--事件列表
--**********************************
function x891233_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	for i, eventId in x891233_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x891233_OnDefaultEvent( sceneId, selfId,targetId )
	x891233_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x891233_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x891233_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x891233_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x891233_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x891233_g_eventList do
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
function x891233_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x891233_g_eventList do
		if missionScriptId == findId then
			x891233_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x891233_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x891233_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x891233_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x891233_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x891233_OnDie( sceneId, selfId, killerId )
end
