--NPC萨雪
--苍山
--普通
--脚本号
x025112_g_scriptId = 025112

--所拥有的事件ID列表
x025112_g_eventList={}--210700, 210701, 210706}	
x025112_g_KillMonsterScript = 006666
x025112_g_KillMonsterList = {1000353}
--**********************************
--事件列表
--**********************************
function x025112_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"每年冬天，这里的雪无边无际，席卷而来。它在暗示着什么呢？呵！这真是一个奇妙又略显恐怖的世界！")
	for i,KillMonsteridx in x025112_g_KillMonsterList do
		CallScriptFunction( x025112_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x025112_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x025112_OnDefaultEvent( sceneId, selfId,targetId )
	x025112_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x025112_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,KillMonsteridx in x025112_g_KillMonsterList do
		if eventId == x025112_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x025112_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x025112_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i,KillMonsteridx in x025112_g_KillMonsterList do
		if missionScriptId == x025112_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x025112_g_eventList do
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
function x025112_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x025112_g_eventList do
		if missionScriptId == findId then
			x025112_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x025112_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,KillMonsteridx in x025112_g_KillMonsterList do
		if missionScriptId == x025112_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x025112_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x025112_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,KillMonsteridx in x025112_g_KillMonsterList do
		if missionScriptId == x025112_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x025112_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x025112_OnDie( sceneId, selfId, killerId )
end
