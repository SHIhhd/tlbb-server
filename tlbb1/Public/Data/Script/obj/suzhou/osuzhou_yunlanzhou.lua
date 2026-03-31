--青丘引导NPC
--云兰舟

--脚本号
x893033_g_ScriptId = 893033

--所拥有的事件ID列表
--893045:兽魂引导任务 天降大任赴青丘
--893046:兽魂引导任务 青丘四战澄赤心
--893047:兽魂引导任务 四性皆具习秘术
--893060 青丘商店
--998790 q3新版本引导任务
x893033_g_eventList={893020,893045,893046,893047,893060,998790}
--**********************************
--事件列表
--**********************************
function x893033_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		for i, eventId in x893033_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893033_OnDefaultEvent( sceneId, selfId,targetId )
	x893033_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893033_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x893033_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x893033_g_ScriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893033_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893033_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
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
function x893033_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x893033_g_eventList do
		if missionScriptId == findId then
			x893033_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x893033_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893033_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x893033_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x893033_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x893033_OnDie( sceneId, selfId, killerId )
end
