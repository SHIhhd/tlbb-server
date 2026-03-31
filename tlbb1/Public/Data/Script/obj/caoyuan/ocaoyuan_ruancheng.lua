--阮诚

--脚本号
x020000_g_scriptId = 020000

--所拥有的事件ID列表
x020000_g_eventList={}--211105,211106,211108}	
x020000_g_DeliveryScript = 006668
x020000_g_DeliveryList = {1010080,1010081}
x020000_g_HusongScript = 006671
x020000_g_HusongList = {1050000}
x020000_g_LootItemscript = 006667
x020000_g_LootItemList = {1030081}
--**********************************
--事件列表
--**********************************
function x020000_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"#{OBJ_caoyuan_0001}")
	for i, Deliveryidx in x020000_g_DeliveryList do
		CallScriptFunction( x020000_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, Husongidx in x020000_g_HusongList do
		CallScriptFunction( x020000_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
	end
	for i, LootItemidx in x020000_g_LootItemList do
		CallScriptFunction( x020000_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i, eventId in x020000_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x020000_OnDefaultEvent( sceneId, selfId,targetId )
	x020000_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x020000_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x020000_g_DeliveryList do
		if eventId == x020000_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, Husongidx in x020000_g_HusongList do
		if eventId == x020000_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
	for i, LootItemidx in x020000_g_LootItemList do
		if eventId == x020000_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x020000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x020000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x020000_g_DeliveryList do
		if missionScriptId == x020000_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, Husongidx in x020000_g_HusongList do
		if missionScriptId == x020000_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
	for i, LootItemidx in x020000_g_LootItemList do
		if missionScriptId == x020000_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x020000_g_eventList do
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
function x020000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x020000_g_eventList do
		if missionScriptId == findId then
			x020000_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x020000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x020000_g_DeliveryList do
		if missionScriptId == x020000_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, Husongidx in x020000_g_HusongList do
		if missionScriptId == x020000_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
	for i, LootItemidx in x020000_g_LootItemList do
		if missionScriptId == x020000_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x020000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x020000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x020000_g_DeliveryList do
		if missionScriptId == x020000_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, Husongidx in x020000_g_HusongList do
		if missionScriptId == x020000_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
	for i, LootItemidx in x020000_g_LootItemList do
		if missionScriptId == x020000_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x020000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x020000_OnDie( sceneId, selfId, killerId )
end
