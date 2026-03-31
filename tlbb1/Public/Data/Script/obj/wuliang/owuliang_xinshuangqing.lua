--辛双清

--脚本号
x006006_g_scriptId = 006006

--所拥有的事件ID列表
x006006_g_eventList={}--210604,210605,210607,210609}  --210608	
x006006_g_DeliveryScript = 006668
x006006_g_DeliveryList = {1010001}
x006006_g_EnterareaScript = 006669
x006006_g_EnterareaList = {1020000}
x006006_g_KillMonsterScript = 006666
x006006_g_KillMonsterList = {1000001,1000003,1000004}
--**********************************
--事件列表
--**********************************
function x006006_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{OBJ_wuliang_0004}")
	--配表任务
	for i,Deliveryidx in x006006_g_DeliveryList do
		CallScriptFunction( x006006_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i,Enterareaidx in x006006_g_EnterareaList do
		CallScriptFunction( x006006_g_EnterareaScript, "OnEnumerate",sceneId, selfId, targetId ,Enterareaidx)
	end
	for i,KillMonsteridx in x006006_g_KillMonsterList do
		CallScriptFunction( x006006_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x006006_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x006006_OnDefaultEvent( sceneId, selfId,targetId )
	x006006_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x006006_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x006006_g_DeliveryList do
		if eventId == x006006_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i,Enterareaidx in x006006_g_EnterareaList do
		if eventId == x006006_g_EnterareaScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Enterareaidx)
		end
	end
	for i,KillMonsteridx in x006006_g_KillMonsterList do
		if eventId == x006006_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x006006_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x006006_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x006006_g_DeliveryList do
		if missionScriptId == x006006_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i,Enterareaidx in x006006_g_EnterareaList do
		if missionScriptId == x006006_g_EnterareaScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Enterareaidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Enterareaidx)
			end
		end
	end
	for i,KillMonsteridx in x006006_g_KillMonsterList do
		if missionScriptId == x006006_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x006006_g_eventList do
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
function x006006_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x006006_g_eventList do
		if missionScriptId == findId then
			x006006_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x006006_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x006006_g_DeliveryList do
		if missionScriptId == x006006_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i,Enterareaidx in x006006_g_EnterareaList do
		if missionScriptId == x006006_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Enterareaidx)
		end
	end
	for i,KillMonsteridx in x006006_g_KillMonsterList do
		if missionScriptId == x006006_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x006006_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x006006_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x006006_g_DeliveryList do
		if missionScriptId == x006006_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i,Enterareaidx in x006006_g_EnterareaList do
		if missionScriptId == x006006_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Enterareaidx)
		end
	end
	for i,KillMonsteridx in x006006_g_KillMonsterList do
		if missionScriptId == x006006_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x006006_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x006006_OnDie( sceneId, selfId, killerId )
end
