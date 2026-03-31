--大理 萧峰

--脚本号
x998481_g_ScriptId = 998481
--所拥有的事件ID列表
x998481_g_eventList={
	--情刃引导·注法有求
	890272,
	--情刃引导·旧友相引
	890273
}
--**********************************
--事件列表
--**********************************
function x998481_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SBRC_20230627_2}")
		for i, eventId in x998481_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x998481_OnDefaultEvent( sceneId, selfId,targetId )
	x998481_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998481_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x998481_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
	
end

--**********************************
--接受此NPC的任务
--**********************************
function x998481_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x998481_g_eventList do
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
function x998481_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x998481_g_eventList do
		if missionScriptId == findId then
			x998481_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x998481_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x998481_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x998481_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x998481_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x998481_OnDie( sceneId, selfId, killerId )
end

--**********************************
--醒目提示
--**********************************
function x998481_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
