--琼州NPC
--凌忆慈
--普通
x035003_g_scriptId = 035003

--所拥有的事件ID列表
x035003_g_eventList={}
x035003_g_DeliveryScript = 006668
x035003_g_DeliveryList = {1010201,1010202}
x035003_g_LootItemscript = 006667
x035003_g_LootItemList = {1030201}
--**********************************
--事件交互入口
--**********************************
function x035003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  老三总是想要我来琼州，可是琉球的百姓正在遭受瘟疫之苦，我实在不能舍他们而去。#r  这次我来琼州，主要是听子衿说南海有一位神医岳仲秋，用异种树皮治癒了瘟疫。等我掌握了这门技术之后，我还要赶回琉球，治疗那里的百姓的。")
		for i, Deliveryidx in x035003_g_DeliveryList do
			CallScriptFunction( x035003_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x035003_g_LootItemList do
			CallScriptFunction( x035003_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		for i, eventId in x035003_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x035003_OnDefaultEvent( sceneId, selfId,targetId )
	x035003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x035003_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x035003_g_DeliveryList do
		if eventId == x035003_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x035003_g_LootItemList do
		if eventId == x035003_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x035003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x035003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x035003_g_DeliveryList do
		if missionScriptId == x035003_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x035003_g_LootItemList do
		if missionScriptId == x035003_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x035003_g_eventList do
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
function x035003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x035003_g_eventList do
		if missionScriptId == findId then
			x035003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x035003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x035003_g_DeliveryList do
		if missionScriptId == x035003_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x035003_g_LootItemList do
		if missionScriptId == x035003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x035003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x035003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x035003_g_DeliveryList do
		if missionScriptId == x035003_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x035003_g_LootItemList do
		if missionScriptId == x035003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x035003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x035003_OnDie( sceneId, selfId, killerId )
end
