--天山NPC
--符敏仪
--普通

--所拥有的事件ID列表
x017008_g_eventList={229006,228000,228001,228002,228003,228004,228005,228006,228007,228008,228009,228010,228011,228012,228020,228900,050061,891279}
x017008_g_DeliveryScript = 006668
x017008_g_DeliveryList = {1010228,1018809,1018810,1018811,1018812,1018813,1018814,1018815,1018816,1018817,1018818}
x017008_g_LootItemscript = 006667
x017008_g_LootItemList = {1039811}
--**********************************
--事件交互入口
--**********************************
function x017008_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是符敏仪，我发布天山派师门任务。")
		
		CallScriptFunction( 891279, "OnEnumerate",sceneId, selfId, targetId )
		
		for i, Deliveryidx in x017008_g_DeliveryList do
			CallScriptFunction( x017008_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x017008_g_LootItemList do
			CallScriptFunction( x017008_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		CallScriptFunction( x017008_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 228900, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 229011, "OnEnumerate",sceneId, selfId, targetId, MP_TIANSHAN )
		CallScriptFunction( 229013, "OnEnumerate",sceneId, selfId, targetId, MP_TIANSHAN )
		CallScriptFunction( 050025, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 050061, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x017008_OnDefaultEvent( sceneId, selfId,targetId )
	x017008_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x017008_OnEventRequest( sceneId, selfId, targetId, eventId )

	if eventId == 229011 then
		CallScriptFunction( 229011, "OnDefaultEvent",sceneId, selfId, targetId, MP_TIANSHAN, GetNumText() )
		return
	elseif eventId == 229013 then
		CallScriptFunction( 229013, "OnDefaultEvent",sceneId, selfId, targetId, MP_TIANSHAN, GetNumText() )
		return
	elseif eventId == 050025 then
		CallScriptFunction( 050025, "OnDefaultEvent",sceneId, selfId, targetId, MP_TIANSHAN)
		return
	elseif eventId == 050061 then
		CallScriptFunction( 050061, "OnDefaultEvent",sceneId, selfId, targetId,MP_TIANSHAN)
		return
	end
	--配表任务
	for i,Deliveryidx in x017008_g_DeliveryList do
		if eventId == x017008_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x017008_g_LootItemList do
		if eventId == x017008_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x017008_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x017008_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x017008_g_DeliveryList do
		if missionScriptId == x017008_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x017008_g_LootItemList do
		if missionScriptId == x017008_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x017008_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x017008_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x017008_g_eventList do
		if missionScriptId == findId then
			x017008_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x017008_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x017008_g_DeliveryList do
		if missionScriptId == x017008_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x017008_g_LootItemList do
		if missionScriptId == x017008_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x017008_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x017008_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x017008_g_DeliveryList do
		if missionScriptId == x017008_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x017008_g_LootItemList do
		if missionScriptId == x017008_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x017008_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x017008_OnDie( sceneId, selfId, killerId )
end

--**********************************
--提交物品
--**********************************
function x017008_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	
	for i, findId in x017008_g_eventList do
		if scriptId == findId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
			return
		end
	end
end
