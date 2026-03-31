--陈德

--脚本号
x888819_g_ScriptId = 888819
--所拥有的事件ID列表
x888819_g_eventList={
}
--**********************************
--事件列表
--**********************************
function x888819_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SBFW_20230707_20}")
		for i, eventId in x888819_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddNumText(sceneId,x888819_g_ScriptId,"#{SGCX_20231227_39}",6,1)
		AddNumText(sceneId,x888819_g_ScriptId,"#{SGCX_20231227_40}",11,100)	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x888819_OnDefaultEvent( sceneId, selfId,targetId )
	x888819_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x888819_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x888819_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
	
	if GetNumText() == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88882001 )
		return
	end
	if GetNumText() == 100 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SGCX_20231227_41}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x888819_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x888819_g_eventList do
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
function x888819_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x888819_g_eventList do
		if missionScriptId == findId then
			x888819_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x888819_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x888819_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x888819_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x888819_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x888819_OnDie( sceneId, selfId, killerId )
end

--**********************************
--醒目提示
--**********************************
function x888819_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
