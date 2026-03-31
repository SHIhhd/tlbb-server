--玉溪NPC
--萝卜
--普通
x027003_g_scriptId = 027003

--所拥有的事件ID列表
x027003_g_eventList={}--211101}	
x027003_g_LootItemscript = 006667
x027003_g_LootItemList = {1030170,1030171,1030172}
--**********************************
--事件列表
--**********************************
function x027003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  你好。#r  我的名字是萝卜。#r  我阿爸的名字是索姆拉。#r  我阿妈的名字是古鲁拉。#r  我妹妹的名字是阿依娜。#r  ……#r  处理完毕。")
	for i, LootItemidx in x027003_g_LootItemList do
		CallScriptFunction( x027003_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i, eventId in x027003_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x027003_OnDefaultEvent( sceneId, selfId,targetId )
	x027003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x027003_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, LootItemidx in x027003_g_LootItemList do
		if eventId == x027003_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x027003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x027003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i, LootItemidx in x027003_g_LootItemList do
		if missionScriptId == x027003_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x027003_g_eventList do
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
function x027003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x027003_g_eventList do
		if missionScriptId == findId then
			x027003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x027003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, LootItemidx in x027003_g_LootItemList do
		if missionScriptId == x027003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x027003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x027003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, LootItemidx in x027003_g_LootItemList do
		if missionScriptId == x027003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x027003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x027003_OnDie( sceneId, selfId, killerId )
end
