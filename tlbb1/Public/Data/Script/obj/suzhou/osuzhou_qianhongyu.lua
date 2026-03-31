-- 苏州NPC
-- 钱宏宇
-- 普通

-- 脚本号
x001065_g_ScriptId = 001065

--所拥有的事件ID列表
x001065_g_eventList = { 050100, 050102, 050106, 500609, 500611 }
x001065_g_DeliveryScript = 006668
x001065_g_DeliveryList = {1018710,1018711,1018712,1018850,1018852}
--**********************************
--事件列表
--**********************************
function x001065_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "    不错，苏州校尉钱宏宇就是我！找我有何贵干？" )
		
		for i, Deliveryidx in x001065_g_DeliveryList do
			CallScriptFunction( x001065_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		local i, findId
		for i, findId in x001065_g_eventList do
			CallScriptFunction( findId, "OnEnumerate", sceneId, selfId, targetId )
		end

		AddNumText( sceneId, x001065_g_ScriptId, "连环副本介绍", 11, 10 )
		AddNumText( sceneId, x001065_g_ScriptId, "楼兰连环副本介绍", 11, 11 )


	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件交互入口
--**********************************
function x001065_OnDefaultEvent( sceneId, selfId, targetId )
	x001065_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001065_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 10 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{function_help_078}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	elseif GetNumText() == 11 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{XSHBZ_80917_1}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--配表任务
	for i,Deliveryidx in x001065_g_DeliveryList do
		if eventId == x001065_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	local i, findId
	for i, findId in x001065_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001065_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x001065_g_DeliveryList do
		if missionScriptId == x001065_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x001065_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,targetId,missionScriptId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x001065_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001065_g_eventList do
		if missionScriptId == findId then
			x001065_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001065_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x001065_g_DeliveryList do
		if missionScriptId == x001065_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x001065_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001065_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x001065_g_DeliveryList do
		if missionScriptId == x001065_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x001065_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001065_OnDie( sceneId, selfId, killerId )
end
