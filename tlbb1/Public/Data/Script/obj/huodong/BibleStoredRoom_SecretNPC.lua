--洱海、雁南、西湖场景内少林云游武僧NPC对话脚本
--脚本号
x402109_g_ScriptId	= 402109
--所拥有的事件ID列表
x402109_g_EventList	= {402107}

--**********************************
--事件列表
--**********************************
function x402109_UpdateEventList( sceneId, selfId, targetId )
	CallScriptFunction( x402109_g_EventList[1], "OnEnumerate", sceneId, selfId, targetId )
end

--**********************************
--事件交互入口
--**********************************
function x402109_OnDefaultEvent( sceneId, selfId, targetId )
	x402109_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x402109_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x402109_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x402109_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402109_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x402109_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x402109_g_EventList do
		if missionScriptId == findId then
			x402109_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x402109_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x402109_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x402109_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x402109_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x402109_OnDie( sceneId, selfId, killerId )
end

