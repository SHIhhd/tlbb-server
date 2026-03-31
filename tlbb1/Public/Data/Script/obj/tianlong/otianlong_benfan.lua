--天龙寺NPC
--本凡
--普通

--所拥有的事件ID列表
x013007_g_eventList={229004,224000,224001,224002,224003,224004,224005,224006,224007,224008,224009,224010,224011,224012,224020,224900,050061,891279}
x013007_g_DeliveryScript = 006668
x013007_g_DeliveryList = {1010224,1018769,1018770,1018771,1018772,1018773,1018774,1018775,1018776,1018777,1018778}
x013007_g_LootItemscript = 006667
x013007_g_LootItemList = {1039810}
--**********************************
--事件交互入口
--**********************************
function x013007_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是本凡，我发布天龙寺师门任务。")
		
		CallScriptFunction( 891279, "OnEnumerate",sceneId, selfId, targetId )
		
		for i, Deliveryidx in x013007_g_DeliveryList do
			CallScriptFunction( x013007_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x013007_g_LootItemList do
			CallScriptFunction( x013007_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		CallScriptFunction( x013007_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 224900, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 229011, "OnEnumerate",sceneId, selfId, targetId, MP_DALI )
		CallScriptFunction( 229013, "OnEnumerate",sceneId, selfId, targetId, MP_DALI )
		CallScriptFunction( 050025, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 050061, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x013007_OnDefaultEvent( sceneId, selfId,targetId )
	x013007_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x013007_OnEventRequest( sceneId, selfId, targetId, eventId )

	if eventId == 229011 then
		CallScriptFunction( 229011, "OnDefaultEvent",sceneId, selfId, targetId, MP_DALI, GetNumText() )
		return
	elseif eventId == 229013 then
		CallScriptFunction( 229013, "OnDefaultEvent",sceneId, selfId, targetId, MP_DALI, GetNumText() )
		return
	elseif eventId == 050025 then
		CallScriptFunction( 050025, "OnDefaultEvent",sceneId, selfId, targetId, MP_DALI)
		return
	elseif eventId == 050061 then
		CallScriptFunction( 050061, "OnDefaultEvent",sceneId, selfId, targetId,MP_DALI)
		return
	end
	--配表任务
	for i,Deliveryidx in x013007_g_DeliveryList do
		if eventId == x013007_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x013007_g_LootItemList do
		if eventId == x013007_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x013007_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x013007_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x013007_g_DeliveryList do
		if missionScriptId == x013007_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x013007_g_LootItemList do
		if missionScriptId == x013007_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x013007_g_eventList do
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
function x013007_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			x013007_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x013007_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x013007_g_DeliveryList do
		if missionScriptId == x013007_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x013007_g_LootItemList do
		if missionScriptId == x013007_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x013007_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x013007_g_DeliveryList do
		if missionScriptId == x013007_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x013007_g_LootItemList do
		if missionScriptId == x013007_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x013007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x013007_OnDie( sceneId, selfId, killerId )
end

--**********************************
--提交物品
--**********************************
function x013007_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	for i, findId in x013007_g_eventList do
		if scriptId == findId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
			return
		end
	end
end
