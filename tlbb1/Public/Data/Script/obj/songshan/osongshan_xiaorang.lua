--萧让

--脚本号
x003002_g_scriptId = 003002

--所拥有的事件ID列表
x003002_g_eventList={}--210303, 210307, 210308}
x003002_g_DeliveryScript = 006668
x003002_g_DeliveryList = {1010030,1010033,1010324}
x003002_g_KillMonsterScript = 006666
x003002_g_KillMonsterList = {1000220,1000221}
--**********************************
--事件列表
--**********************************
function x003002_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId);
	local PlayerName = GetName(sceneId,selfId);
	local nTask1 = IsHaveMission(sceneId, selfId, 463);
	
	AddText(sceneId, "#{OBJ_songshan_0001}")
	--配表任务
	for i,Deliveryidx in x003002_g_DeliveryList do
		CallScriptFunction( x003002_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i,KillMonsteridx in x003002_g_KillMonsterList do
		CallScriptFunction( x003002_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x003002_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate", sceneId, selfId, targetId );
	end

	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId);
end

--**********************************
--事件交互入口
--**********************************
function x003002_OnDefaultEvent( sceneId, selfId,targetId )
	x003002_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x003002_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,Deliveryidx in x003002_g_DeliveryList do
		if eventId == x003002_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x003002_g_KillMonsterList do
		if eventId == x003002_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x003002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x003002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Deliveryidx in x003002_g_DeliveryList do
		if missionScriptId == x003002_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,Deliveryidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x003002_g_KillMonsterList do
		if missionScriptId == x003002_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x003002_g_eventList do
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
function x003002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x003002_g_eventList do
		if missionScriptId == findId then
			x003002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x003002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Deliveryidx in x003002_g_DeliveryList do
		if missionScriptId == x003002_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x003002_g_KillMonsterList do
		if missionScriptId == x003002_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x003002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x003002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Deliveryidx in x003002_g_DeliveryList do
		if missionScriptId == x003002_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x003002_g_KillMonsterList do
		if missionScriptId == x003002_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x003002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x003002_OnDie( sceneId, selfId, killerId )
end
