--脚本号
x044805_g_ScriptId = 044805
x044805_g_eventList={}
x044805_g_DeliveryScript = 006668
x044805_g_DeliveryList = {1018855,1018856,1018857,1018860,1018861,1018862}
x044805_g_EnterareaScript = 006669
x044805_g_EnterareaList = {1020152}
x044805_g_HusongScript = 006671
x044805_g_HusongList = {1050010}
--**********************************
--事件列表
--**********************************
function x044805_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{QZRW_MR_090811_05}")
	for i, Deliveryidx in x044805_g_DeliveryList do
		CallScriptFunction( x044805_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i,Enterareaidx in x044805_g_EnterareaList do
		CallScriptFunction( x044805_g_EnterareaScript, "OnEnumerate",sceneId, selfId, targetId ,Enterareaidx)
	end
	for i, Husongidx in x044805_g_HusongList do
		CallScriptFunction( x044805_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
	end
	for i, eventId in x044805_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x044805_OnDefaultEvent( sceneId, selfId,targetId )
	x044805_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x044805_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x044805_g_DeliveryList do
		if eventId == x044805_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i,Enterareaidx in x044805_g_EnterareaList do
		if eventId == x044805_g_EnterareaScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Enterareaidx)
		end
	end
	for i, Husongidx in x044805_g_HusongList do
		if eventId == x044805_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
	for i, findId in x044805_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x044805_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x044805_g_DeliveryList do
		if missionScriptId == x044805_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i,Enterareaidx in x044805_g_EnterareaList do
		if missionScriptId == x044805_g_EnterareaScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Enterareaidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Enterareaidx)
			end
		end
	end
	for i, Husongidx in x044805_g_HusongList do
		if missionScriptId == x044805_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
	for i, findId in x044805_g_eventList do
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
function x044805_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x044805_g_eventList do
		if missionScriptId == findId then
			x044805_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x044805_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x044805_g_DeliveryList do
		if missionScriptId == x044805_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i,Enterareaidx in x044805_g_EnterareaList do
		if missionScriptId == x044805_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Enterareaidx)
		end
	end
	for i, Husongidx in x044805_g_HusongList do
		if missionScriptId == x044805_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
	for i, findId in x044805_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x044805_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x044805_g_DeliveryList do
		if missionScriptId == x044805_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i,Enterareaidx in x044805_g_EnterareaList do
		if missionScriptId == x044805_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Enterareaidx)
		end
	end
	for i, Husongidx in x044805_g_HusongList do
		if missionScriptId == x044805_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
	for i, findId in x044805_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x044805_OnDie( sceneId, selfId, killerId )
end
