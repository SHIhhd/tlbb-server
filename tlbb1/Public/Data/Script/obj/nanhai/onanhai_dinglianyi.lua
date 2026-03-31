--南海NPC
--丁涟漪
--普通
x034002_g_scriptId = 034002

--所拥有的事件ID列表
x034002_g_eventList={}
x034002_g_DeliveryScript = 006668
x034002_g_DeliveryList = {1010192}
x034002_g_KillMonsterScript = 006666
x034002_g_KillMonsterList = {1000190}
--**********************************
--事件交互入口
--**********************************
function x034002_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  师父、师娘……还有大师兄……就这样，就这样，都已经不在了吗？呜呜……别来管我，我不要活了……")
		for i, Deliveryidx in x034002_g_DeliveryList do
			CallScriptFunction( x034002_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i,KillMonsteridx in x034002_g_KillMonsterList do
			CallScriptFunction( x034002_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
		end
		for i, eventId in x034002_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x034002_OnDefaultEvent( sceneId, selfId,targetId )
	x034002_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x034002_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,Deliveryidx in x034002_g_DeliveryList do
		if eventId == x034002_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x034002_g_KillMonsterList do
		if eventId == x034002_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x034002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x034002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Deliveryidx in x034002_g_DeliveryList do
		if missionScriptId == x034002_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,Deliveryidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x034002_g_KillMonsterList do
		if missionScriptId == x034002_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x034002_g_eventList do
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
function x034002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x034002_g_eventList do
		if missionScriptId == findId then
			x034002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x034002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Deliveryidx in x034002_g_DeliveryList do
		if missionScriptId == x034002_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x034002_g_KillMonsterList do
		if missionScriptId == x034002_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x034002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x034002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Deliveryidx in x034002_g_DeliveryList do
		if missionScriptId == x034002_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x034002_g_KillMonsterList do
		if missionScriptId == x034002_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x034002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x034002_OnDie( sceneId, selfId, killerId )
end
