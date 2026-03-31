--张叔夜

--脚本号
x030004_g_scriptId = 030004

--所拥有的事件ID列表
x030004_g_eventList={}--212100,212102,212104		
x030004_g_DeliveryScript = 006668
x030004_g_DeliveryList = {1010040}
--**********************************
--事件列表
--**********************************
function x030004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"#{OBJ_xihu_0003}")
	for i, Deliveryidx in x030004_g_DeliveryList do
		CallScriptFunction( x030004_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, eventId in x030004_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x030004_OnDefaultEvent( sceneId, selfId,targetId )
	x030004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x030004_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x030004_g_DeliveryList do
		if eventId == x030004_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, findId in x030004_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x030004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x030004_g_DeliveryList do
		if missionScriptId == x030004_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x030004_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x030004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x030004_g_eventList do
		if missionScriptId == findId then
			x030004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x030004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x030004_g_DeliveryList do
		if missionScriptId == x030004_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x030004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x030004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x030004_g_DeliveryList do
		if missionScriptId == x030004_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x030004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x030004_OnDie( sceneId, selfId, killerId )
end
