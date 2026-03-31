--苏州NPC
--呼延豹
--普通

--脚本号
x001061_g_ScriptId	= 001061

--所拥有的事件ID列表
x001061_g_EventList	= { 232000, 232001, 500618 }

--缺省对话
x001061_g_dlg	= "  大事不好了，我们水寨的水牢里面的犯人暴动，士兵大部分都出湖训练去了，导致水寨人手不足，我这就要向苏州的知府求救呢，怎么？您愿意帮我们的忙去水寨平定犯人叛乱吗？"
x001061_g_DeliveryScript = 006668
x001061_g_DeliveryList = {1018720}
--**********************************
--事件列表
--**********************************
function x001061_UpdateEventList( sceneId, selfId, targetId )

	BeginEvent( sceneId )
		AddText( sceneId, x001061_g_dlg )
		for i,Deliveryidx in x001061_g_DeliveryList do
			CallScriptFunction( x001061_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, findId in x001061_g_EventList do
			if findId == 232000 or findId == 500618 then
				CallScriptFunction( findId, "OnEnumerate", sceneId, selfId, targetId )
			end
		end

		AddNumText( sceneId, x001061_g_ScriptId, "水牢任务介绍", 11, 10 )

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--事件交互入口
--**********************************
function x001061_OnDefaultEvent( sceneId, selfId, targetId )

	x001061_UpdateEventList( sceneId, selfId, targetId )

end

--**********************************
--事件列表选中一项
--**********************************
function x001061_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 10 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{function_help_074}" )
								
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	end

	--配表任务
	for i,Deliveryidx in x001061_g_DeliveryList do
		if eventId == x001061_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	local i				= 1
	local findId	= 0
	for i, findId in x001061_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end

end

--**********************************
--接受此NPC的任务
--**********************************
function x001061_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x001061_g_DeliveryList do
		if missionScriptId == x001061_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x001061_g_EventList do
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
function x001061_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001061_g_EventList do
		if missionScriptId == findId then
			x001061_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001061_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x001061_g_DeliveryList do
		if missionScriptId == x001061_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x001061_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001061_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x001061_g_DeliveryList do
		if missionScriptId == x001061_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x001061_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001061_OnDie( sceneId, selfId, killerId )
end
