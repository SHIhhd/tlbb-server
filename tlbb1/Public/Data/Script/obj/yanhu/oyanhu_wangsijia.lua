--盐湖NPC
--王思佳

x041503_g_ScriptId	= 041503
x041503_g_eventList={}
x041503_g_DeliveryScript = 006668
x041503_g_DeliveryList = {1018571}
x041503_g_LootItemscript = 006667
x041503_g_LootItemList = {1039661}
--**********************************
--事件交互入口
--**********************************
function x041503_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{YANHU_20070924_003}" )
		for i, Deliveryidx in x041503_g_DeliveryList do
			CallScriptFunction( x041503_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x041503_g_LootItemList do
			CallScriptFunction( x041503_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		for i, eventId in x041503_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件交互入口
--**********************************
function x041503_OnDefaultEvent( sceneId, selfId,targetId )
	x041503_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x041503_OnEventRequest( sceneId, selfId, targetId, eventId )
	local	arg	= GetNumText()
	if arg == 6 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 415, 45,34 )
		return
	end
	if eventId == x041503_g_scriptId  then
		BeginEvent(sceneId)
			if x041503_nDescIndex == 1 then
				AddText(sceneId, "#{Lua_Shilin_002}")
				AddNumText(sceneId, x041503_g_scriptId,"什么？恐怖的瘟疫！那后来呢？", 8, 1)
			elseif x041503_nDescIndex == 2 then
				AddText(sceneId, "#{Lua_Shilin_003}")
				AddNumText(sceneId, x041503_g_scriptId,"看来是偃师救了圆月村，对吗？", 8, 1)
			elseif x041503_nDescIndex == 3 then
				AddText(sceneId, "#{Lua_Shilin_004}")
			end
			x041503_nDescIndex = x041503_nDescIndex +1
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		
		if x041503_nDescIndex == 4 then
			-- 读到这里就算完成任务了
			local misIndex=GetMissionIndexByID(sceneId,selfId,602)
			local num0 = GetMissionParam(sceneId,selfId,misIndex,0)
			
			if num0 < 1 then				--如果不满足任务完成得条件
				SetMissionByIndex(sceneId,selfId,misIndex,0,1)		--任务变量第一位增加1
				BeginEvent(sceneId)										--显示提示信息
					AddText(sceneId, "已经听完郑玄的故事：1/1");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
	end
		
	if	IsHaveMission(sceneId,selfId,602) <= 0	then
		CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	--配表任务
	for i,Deliveryidx in x041503_g_DeliveryList do
		if eventId == x041503_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x041503_g_LootItemList do
		if eventId == x041503_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x041503_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x041503_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x041503_g_DeliveryList do
		if missionScriptId == x041503_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x041503_g_LootItemList do
		if missionScriptId == x041503_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x041503_g_eventList do
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
function x041503_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x041503_g_eventList do
		if missionScriptId == findId then
			x041503_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x041503_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x041503_g_DeliveryList do
		if missionScriptId == x041503_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x041503_g_LootItemList do
		if missionScriptId == x041503_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x041503_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x041503_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x041503_g_DeliveryList do
		if missionScriptId == x041503_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x041503_g_LootItemList do
		if missionScriptId == x041503_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x041503_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x041503_OnDie( sceneId, selfId, killerId )
end
