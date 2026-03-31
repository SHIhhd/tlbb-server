--琼州NPC
--悠悠
--普通
x035001_g_scriptId = 035001
x035001_g_HusongScript = 006671
x035001_g_HusongList = {1050005}
x035001_g_KillMonsterScript = 006666
x035001_g_KillMonsterList = {1000200}
--**********************************
--事件交互入口
--**********************************
function x035001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  呜呜……这里有好多的鳄鱼啊，难道子衿哥哥天天就是生活在这样的环境里吗？")
		for i, Husongidx in x035001_g_HusongList do
			CallScriptFunction( x035001_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
		end
		for i,KillMonsteridx in x035001_g_KillMonsterList do
			CallScriptFunction( x035001_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x035001_OnDefaultEvent( sceneId, selfId,targetId )
	x035001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x035001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,Husongidx in x035001_g_HusongList do
		if eventId == x035001_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,Husongidx)
		end
	end
	for i,KillMonsteridx in x035001_g_KillMonsterList do
		if eventId == x035001_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x035001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Husongidx in x035001_g_HusongList do
		if missionScriptId == x035001_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,Husongidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x035001_g_KillMonsterList do
		if missionScriptId == x035001_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x035001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x035001_g_eventList do
		if missionScriptId == findId then
			x035001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x035001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Husongidx in x035001_g_HusongList do
		if missionScriptId == x035001_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,Husongidx)
		end
	end
	for i,KillMonsteridx in x035001_g_KillMonsterList do
		if missionScriptId == x035001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x035001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Husongidx in x035001_g_HusongList do
		if missionScriptId == x035001_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,Husongidx)
		end
	end
	for i,KillMonsteridx in x035001_g_KillMonsterList do
		if missionScriptId == x035001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x035001_OnDie( sceneId, selfId, killerId )
end
