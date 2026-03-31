--梅岭NPC
--克里斯蒂安
--普通
x033011_g_scriptId = 033011
x033011_g_HusongScript = 006671
x033011_g_HusongList = {1050004}
--**********************************
--事件交互入口
--**********************************
function x033011_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  亲爱的朋友！快来帮帮我啊！")
		for i, Husongidx in x033011_g_HusongList do
			CallScriptFunction( x033011_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x033011_OnDefaultEvent( sceneId, selfId,targetId )
	x033011_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x033011_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i, Husongidx in x033011_g_HusongList do
		if eventId == x033011_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x033011_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i, Husongidx in x033011_g_HusongList do
		if missionScriptId == x033011_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x033011_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x033011_g_eventList do
		if missionScriptId == findId then
			x033011_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x033011_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i, Husongidx in x033011_g_HusongList do
		if missionScriptId == x033011_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x033011_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i, Husongidx in x033011_g_HusongList do
		if missionScriptId == x033011_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x033011_OnDie( sceneId, selfId, killerId )
end
