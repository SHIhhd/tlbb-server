--洛阳NPC
--瑞福祥
--普通

--药店

x000099_g_scriptId = 000099

x000099_g_shoptableindex=16
x000099_g_DeliveryScript = 006668
x000099_g_DeliveryList = {1018719}
x000099_g_LootItemscript = 006667
x000099_g_LootItemList = {1039801}
--**********************************
--事件交互入口
--**********************************
function x000099_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "  众人熙熙，皆为利来，众人攘攘，皆为利往。" )
		AddNumText( sceneId, x000099_g_scriptId, "买卖杂货", 7, 1 )
		for i,Deliveryidx in x000099_g_DeliveryList do
			CallScriptFunction( x000099_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x000099_g_LootItemList do
			CallScriptFunction( x000099_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
			--for i, eventId in x000099_g_eventList do
				--	CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId)
			--end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x000099_OnDefaultEvent( sceneId, selfId,targetId )
	x000099_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x000099_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1	then
		DispatchShopItem( sceneId, selfId, targetId, x000099_g_shoptableindex)
	end
	--配表任务
	for i,Deliveryidx in x000099_g_DeliveryList do
		if eventId == x000099_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x000099_g_LootItemList do
		if eventId == x000099_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
--	for i, findId in x000099_g_eventList do
--		if eventId == findId then
--			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
--			return
--		end
--	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000099_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x000099_g_DeliveryList do
		if missionScriptId == x000099_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x000099_g_LootItemList do
		if missionScriptId == x000099_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000099_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000099_g_eventList do
		if missionScriptId == findId then
			x000099_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000099_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x000099_g_DeliveryList do
		if missionScriptId == x000099_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x000099_g_LootItemList do
		if missionScriptId == x000099_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000099_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x000099_g_DeliveryList do
		if missionScriptId == x000099_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x000099_g_LootItemList do
		if missionScriptId == x000099_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000099_OnDie( sceneId, selfId, killerId )
end
