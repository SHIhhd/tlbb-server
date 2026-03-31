--敦煌 曹延惠

--脚本号
x008004_g_scriptId = 008004

--所拥有的事件ID列表
x008004_g_eventList={}--210808} --212603,212606,210807
x008004_g_KillMonsterScript = 006666
x008004_g_KillMonsterList = {1000023}
--**********************************
--事件列表
--**********************************
function x008004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"#{OBJ_dunhuang_0003}")
	for i,KillMonsteridx in x008004_g_KillMonsterList do
		CallScriptFunction( x008004_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x008004_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x008004_OnDefaultEvent( sceneId, selfId,targetId )
	x008004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x008004_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,KillMonsteridx in x008004_g_KillMonsterList do
		if eventId == x008004_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x008004_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x008004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i,KillMonsteridx in x008004_g_KillMonsterList do
		if missionScriptId == x008004_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x008004_g_eventList do
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
function x008004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			x008004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x008004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,KillMonsteridx in x008004_g_KillMonsterList do
		if missionScriptId == x008004_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x008004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,KillMonsteridx in x008004_g_KillMonsterList do
		if missionScriptId == x008004_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x008004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x008004_OnDie( sceneId, selfId, killerId )
end
