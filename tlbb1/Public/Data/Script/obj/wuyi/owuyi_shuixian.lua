--鲁平


--脚本号
x032003_g_scriptId = 032003

--所拥有的事件ID列表
x032003_g_eventList={}
x032003_g_LootItemscript = 006667
x032003_g_LootItemList = {1030130}
x032003_g_KillMonsterScript = 006666
x032003_g_KillMonsterList = {1000133,1000134,1000135}
--**********************************
--事件列表
--**********************************
function x032003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  你好，远方来的客人，祝你在武夷山玩得开心。")
	for i, LootItemidx in x032003_g_LootItemList do
		CallScriptFunction( x032003_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i,KillMonsteridx in x032003_g_KillMonsterList do
		CallScriptFunction( x032003_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x032003_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x032003_OnDefaultEvent( sceneId, selfId,targetId )
	x032003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x032003_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,LootItemidx in x032003_g_LootItemList do
		if eventId == x032003_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x032003_g_KillMonsterList do
		if eventId == x032003_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x032003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x032003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, LootItemidx in x032003_g_LootItemList do
		if missionScriptId == x032003_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,LootItemidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x032003_g_KillMonsterList do
		if missionScriptId == x032003_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x032003_g_eventList do
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
function x032003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x032003_g_eventList do
		if missionScriptId == findId then
			x032003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x032003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,LootItemidx in x032003_g_LootItemList do
		if missionScriptId == x032003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x032003_g_KillMonsterList do
		if missionScriptId == x032003_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x032003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x032003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,LootItemidx in x032003_g_LootItemList do
		if missionScriptId == x032003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x032003_g_KillMonsterList do
		if missionScriptId == x032003_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x032003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x032003_OnDie( sceneId, selfId, killerId )
end
