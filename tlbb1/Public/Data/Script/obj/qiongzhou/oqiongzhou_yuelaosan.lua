--琼州NPC
--岳老三
--普通
x035004_g_scriptId = 035004

--所拥有的事件ID列表
x035004_g_eventList={}--211101}	
x035004_g_LootItemscript = 006667
x035004_g_LootItemList = {1030202}
x035004_g_KillMonsterScript = 006666
x035004_g_KillMonsterList = {1000201,1000202}
--**********************************
--事件列表
--**********************************
function x035004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  最近我在大理新拜了一位师父，本事非同小可。不说别的，单是这位师父的“淩波微步”绝技，相信世上便无第二人会得。#r  这次回琼州，主要就是来接我老婆的。")
	for i, LootItemidx in x035004_g_LootItemList do
		CallScriptFunction( x035004_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i,KillMonsteridx in x035004_g_KillMonsterList do
		CallScriptFunction( x035004_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x035004_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x035004_OnDefaultEvent( sceneId, selfId,targetId )
	x035004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x035004_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,LootItemidx in x035004_g_LootItemList do
		if eventId == x035004_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x035004_g_KillMonsterList do
		if eventId == x035004_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x035004_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x035004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, LootItemidx in x035004_g_LootItemList do
		if missionScriptId == x035004_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,LootItemidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x035004_g_KillMonsterList do
		if missionScriptId == x035004_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x035004_g_eventList do
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
function x035004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x035004_g_eventList do
		if missionScriptId == findId then
			x035004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x035004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,LootItemidx in x035004_g_LootItemList do
		if missionScriptId == x035004_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x035004_g_KillMonsterList do
		if missionScriptId == x035004_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x035004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x035004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,LootItemidx in x035004_g_LootItemList do
		if missionScriptId == x035004_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x035004_g_KillMonsterList do
		if missionScriptId == x035004_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x035004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x035004_OnDie( sceneId, selfId, killerId )
end
