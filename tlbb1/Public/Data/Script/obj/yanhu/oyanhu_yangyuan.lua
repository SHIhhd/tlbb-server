--盐湖NPC
--杨元
x041504_g_scriptId = 041504

--所拥有的事件ID列表
x041504_g_eventList={}
x041504_g_EnterareaScript = 006669
x041504_g_EnterareaList = {1020150}
x041504_g_LootItemscript = 006667
x041504_g_LootItemList = {1039660}
x041504_g_KillMonsterScript = 006666
x041504_g_KillMonsterList = {1009110,1009111}
--**********************************
--事件列表
--**********************************
function x041504_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{YANHU_20070924_001}" )
		for i,Enterareaidx in x041504_g_EnterareaList do
			CallScriptFunction( x041504_g_EnterareaScript, "OnEnumerate",sceneId, selfId, targetId ,Enterareaidx)
		end
		for i, LootItemidx in x041504_g_LootItemList do
			CallScriptFunction( x041504_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		for i,KillMonsteridx in x041504_g_KillMonsterList do
			CallScriptFunction( x041504_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
		end
		for i, eventId in x041504_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x041504_OnDefaultEvent( sceneId, selfId,targetId )
	x041504_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x041504_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,Enterareaidx in x041504_g_EnterareaList do
		if eventId == x041504_g_EnterareaScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Enterareaidx)
		end
	end
	for i, LootItemidx in x041504_g_LootItemList do
		if eventId == x041504_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i,KillMonsteridx in x041504_g_KillMonsterList do
		if eventId == x041504_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x041504_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x041504_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i,Enterareaidx in x041504_g_EnterareaList do
		if missionScriptId == x041504_g_EnterareaScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Enterareaidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Enterareaidx)
			end
		end
	end
	for i, LootItemidx in x041504_g_LootItemList do
		if missionScriptId == x041504_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i,KillMonsteridx in x041504_g_KillMonsterList do
		if missionScriptId == x041504_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x041504_g_eventList do
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
function x041504_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x041504_g_eventList do
		if missionScriptId == findId then
			x041504_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x041504_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Enterareaidx in x041504_g_EnterareaList do
		if missionScriptId == x041504_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Enterareaidx)
		end
	end
	for i, LootItemidx in x041504_g_LootItemList do
		if missionScriptId == x041504_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i,KillMonsteridx in x041504_g_KillMonsterList do
		if missionScriptId == x041504_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x041504_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x041504_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Enterareaidx in x041504_g_EnterareaList do
		if missionScriptId == x041504_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Enterareaidx)
		end
	end
	for i, LootItemidx in x041504_g_LootItemList do
		if missionScriptId == x041504_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x041504_g_KillMonsterList do
		if missionScriptId == x041504_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x041504_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x041504_OnDie( sceneId, selfId, killerId )
end
