--鲁平


--脚本号
x024003_g_scriptId = 024003

--所拥有的事件ID列表
x024003_g_eventList={}
x024003_g_HusongScript = 006671
x024003_g_HusongList = {1050001}
--**********************************
--事件列表
--**********************************
function x024003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  我想回家，呜呜呜呜……好多野人，好可怕啊！")
	for i, Husongidx in x024003_g_HusongList do
		CallScriptFunction( x024003_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
	end
	for i, eventId in x024003_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x024003_OnDefaultEvent( sceneId, selfId,targetId )
	x024003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x024003_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, Husongidx in x024003_g_HusongList do
		if eventId == x024003_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
	for i, findId in x024003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x024003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Husongidx in x024003_g_HusongList do
		if missionScriptId == x024003_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
	for i, findId in x024003_g_eventList do
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
function x024003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x024003_g_eventList do
		if missionScriptId == findId then
			x024003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x024003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, Husongidx in x024003_g_HusongList do
		if missionScriptId == x024003_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
	for i, findId in x024003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x024003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, Husongidx in x024003_g_HusongList do
		if missionScriptId == x024003_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
	for i, findId in x024003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x024003_OnDie( sceneId, selfId, killerId )
end
