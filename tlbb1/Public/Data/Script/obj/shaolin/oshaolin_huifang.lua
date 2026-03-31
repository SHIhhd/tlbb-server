--少林NPC
--慧方
--普通

x009013_g_scriptId = 009013
--所拥有的事件ID列表
x009013_g_eventList={229000,220000,220001,220002,220003,220004,220005,220006,220007,220008,220009,220010,220011,220012,220013,220014,220015,220016,220017,220018,220019,220020,220021,220022,220023,220024,220025,220026,220027,220900,050061}
x009013_g_DeliveryScript = 006668
x009013_g_DeliveryList = {1010220,1018729,1018730,1018731,1018732,1018733,1018734,1018735,1018736,1018737,1018738}
x009013_g_LootItemscript = 006667
x009013_g_LootItemList = {1039803}
--**********************************
--事件交互入口
--**********************************
function x009013_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我是慧方，我发布少林寺师门任务。")
		for i, Deliveryidx in x009013_g_DeliveryList do
			CallScriptFunction( x009013_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x009013_g_LootItemList do
			CallScriptFunction( x009013_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		CallScriptFunction( x009013_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 220900, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 229011, "OnEnumerate",sceneId, selfId, targetId, MP_SHAOLIN )
		CallScriptFunction( 229013, "OnEnumerate",sceneId, selfId, targetId, MP_SHAOLIN )
		CallScriptFunction( 050025, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 050061, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x009013_OnDefaultEvent( sceneId, selfId,targetId )
	x009013_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x009013_OnEventRequest( sceneId, selfId, targetId, eventId )

	if eventId == 229011 then
		CallScriptFunction( 229011, "OnDefaultEvent",sceneId, selfId, targetId, MP_SHAOLIN, GetNumText() )
		return
	elseif eventId == 229013 then
		CallScriptFunction( 229013, "OnDefaultEvent",sceneId, selfId, targetId, MP_SHAOLIN, GetNumText() )
		return
	elseif eventId == 050025 then
		CallScriptFunction( 050025, "OnDefaultEvent",sceneId, selfId, targetId, MP_SHAOLIN)
		return
	elseif eventId == 050061 then
		CallScriptFunction( 050061, "OnDefaultEvent",sceneId, selfId, targetId, MP_SHAOLIN)
		return
	end
	--配表任务
	for i,Deliveryidx in x009013_g_DeliveryList do
		if eventId == x009013_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x009013_g_LootItemList do
		if eventId == x009013_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x009013_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x009013_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x009013_g_DeliveryList do
		if missionScriptId == x009013_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x009013_g_LootItemList do
		if missionScriptId == x009013_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x009013_g_eventList do
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
function x009013_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x009013_g_eventList do
		if missionScriptId == findId then
			x009013_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x009013_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x009013_g_DeliveryList do
		if missionScriptId == x009013_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x009013_g_LootItemList do
		if missionScriptId == x009013_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x009013_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x009013_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x009013_g_DeliveryList do
		if missionScriptId == x009013_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x009013_g_LootItemList do
		if missionScriptId == x009013_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x009013_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x009013_OnDie( sceneId, selfId, killerId )
end

--**********************************
--提交物品
--**********************************
function x009013_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	for i, findId in x009013_g_eventList do
		if scriptId == findId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
			return
		end
	end
end
