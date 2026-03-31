--甘宝宝

--脚本号
x025001_g_scriptId = 025001

--所拥有的事件ID列表
x025001_g_eventList={}
x025001_g_LootItemscript = 006667
x025001_g_LootItemList = {1030120}
x025001_g_KillMonsterScript = 006666
x025001_g_KillMonsterList = {1000120,1000121}
--**********************************
--事件列表
--**********************************
function x025001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  哼！只要有我在，谁也别想动萨桑大人！#r  萨鲁那死胖子要是敢来，来一个我杀一个，来两个我杀一对！");
	for i, LootItemidx in x025001_g_LootItemList do
		CallScriptFunction( x025001_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i,KillMonsteridx in x025001_g_KillMonsterList do
		CallScriptFunction( x025001_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x025001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x025001_OnDefaultEvent( sceneId, selfId,targetId )
	x025001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x025001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,LootItemidx in x025001_g_LootItemList do
		if eventId == x025001_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x025001_g_KillMonsterList do
		if eventId == x025001_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x025001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x025001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, LootItemidx in x025001_g_LootItemList do
		if missionScriptId == x025001_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,LootItemidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x025001_g_KillMonsterList do
		if missionScriptId == x025001_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x025001_g_eventList do
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
function x025001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x025001_g_eventList do
		if missionScriptId == findId then
			x025001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x025001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,LootItemidx in x025001_g_LootItemList do
		if missionScriptId == x025001_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x025001_g_KillMonsterList do
		if missionScriptId == x025001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x025001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x025001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,LootItemidx in x025001_g_LootItemList do
		if missionScriptId == x025001_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x025001_g_KillMonsterList do
		if missionScriptId == x025001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x025001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x025001_OnDie( sceneId, selfId, killerId )
end
