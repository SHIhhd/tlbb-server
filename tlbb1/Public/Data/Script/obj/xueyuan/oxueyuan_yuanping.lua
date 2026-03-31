--NPC
--袁平
--普通
x021202_g_scriptId = 021202
x021202_g_HusongScript = 006671
x021202_g_HusongList = {1050006}
--**********************************
--事件交互入口
--**********************************
function x021202_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)

--**********************************
--NPC对话
--**********************************
		AddText(sceneId,"你见过被封在冰块里的巨人吗？真想知道他是怎么来的……")
		for i, Husongidx in x021202_g_HusongList do
			CallScriptFunction( x021202_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x021202_OnDefaultEvent( sceneId, selfId,targetId )
	x021202_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x021202_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i, Husongidx in x021202_g_HusongList do
		if eventId == x021202_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x021202_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i, Husongidx in x021202_g_HusongList do
		if missionScriptId == x021202_g_HusongScript then
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
function x021202_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x021202_g_eventList do
		if missionScriptId == findId then
			x021202_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x021202_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i, Husongidx in x021202_g_HusongList do
		if missionScriptId == x021202_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x021202_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i, Husongidx in x021202_g_HusongList do
		if missionScriptId == x021202_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x021202_OnDie( sceneId, selfId, killerId )
end
