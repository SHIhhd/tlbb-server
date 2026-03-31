--软老太太

--脚本号
x020001_g_scriptId = 020001

--所拥有的事件ID列表
x020001_g_eventList={}--211101}	
x020001_g_LootItemscript = 006667
x020001_g_LootItemList = {1030080}
--**********************************
--事件列表
--**********************************
function x020001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"#{OBJ_caoyuan_0002}")
	for i, LootItemidx in x020001_g_LootItemList do
		CallScriptFunction( x020001_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i, eventId in x020001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x020001_OnDefaultEvent( sceneId, selfId,targetId )
	x020001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x020001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, LootItemidx in x020001_g_LootItemList do
		if eventId == x020001_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x020001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x020001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i, LootItemidx in x020001_g_LootItemList do
		if missionScriptId == x020001_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x020001_g_eventList do
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
function x020001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x020001_g_eventList do
		if missionScriptId == findId then
			x020001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x020001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, LootItemidx in x020001_g_LootItemList do
		if missionScriptId == x020001_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x020001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x020001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, LootItemidx in x020001_g_LootItemList do
		if missionScriptId == x020001_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x020001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x020001_OnDie( sceneId, selfId, killerId )
end
