--NPC
--摩云天
--普通
--脚本号
x018112_g_scriptId = 018112

--所拥有的事件ID列表
x018112_g_eventList={}--210700, 210701, 210706}	
x018112_g_KillMonsterScript = 006666
x018112_g_KillMonsterList = {1009300}
--**********************************
--事件列表
--**********************************
function x018112_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  这摩崖洞乃是秦家寨匪聚集之所，如果功力不够，最好多找几个同伴一同进入比较安全。")
	for i,KillMonsteridx in x018112_g_KillMonsterList do
		CallScriptFunction( x018112_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x018112_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x018112_OnDefaultEvent( sceneId, selfId,targetId )
	x018112_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x018112_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,KillMonsteridx in x018112_g_KillMonsterList do
		if eventId == x018112_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x018112_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x018112_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i,KillMonsteridx in x018112_g_KillMonsterList do
		if missionScriptId == x018112_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x018112_g_eventList do
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
function x018112_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x018112_g_eventList do
		if missionScriptId == findId then
			x018112_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x018112_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,KillMonsteridx in x018112_g_KillMonsterList do
		if missionScriptId == x018112_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x018112_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x018112_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,KillMonsteridx in x018112_g_KillMonsterList do
		if missionScriptId == x018112_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x018112_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x018112_OnDie( sceneId, selfId, killerId )
end
