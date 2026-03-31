--掌事NPC
--普通

--脚本号
x998581_g_ScriptId = 998581

--所拥有的事件ID列表
x998581_g_eventList={
	--盟会引导任务
	998655,
	998656,
	998659,
	998657,
	998658,
	--盟会主脚本
	998583,
	--突破任务
	998586,
	998587,
	998588,
	998589,
	998590,
	998591,
	998592,
	998593,
	998594,
}	

--**********************************
--事件列表
--**********************************
function x998581_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	for i, eventId in x998581_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	AddNumText( sceneId, x998581_g_ScriptId, "#{YCGZ_231225_37}", 11, 100 )
	AddNumText( sceneId, x998581_g_ScriptId, "#{YCGZ_231225_15}", 11, 101 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x998581_OnDefaultEvent( sceneId, selfId,targetId )
	x998581_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998581_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{YCGZ_231225_38}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if GetNumText() == 101 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{YCGZ_231225_16}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	for i, findId in x998581_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x998581_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x998581_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x998581_g_eventList do
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
function x998581_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x998581_g_eventList do
		if missionScriptId == findId then
			x998581_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x998581_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x998581_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x998581_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x998581_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x998581_OnDie( sceneId, selfId, killerId )
end
