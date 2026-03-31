--甘宝宝

--脚本号
x025002_g_scriptId = 025002

--所拥有的事件ID列表
x025002_g_eventList={}
x025002_g_DeliveryScript = 006668
x025002_g_DeliveryList = {1010121}
x025002_g_HusongScript = 006671
x025002_g_HusongList = {1050002}
x025002_g_LootItemscript = 006667
x025002_g_LootItemList = {1030121}
x025002_g_KillMonsterScript = 006666
x025002_g_KillMonsterList = {1000124}
--**********************************
--事件列表
--**********************************
function x025002_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  这里是苍山的观月亭，前面就是洱海，每当月夜，洱海风停水静，皎洁的月色溶入湖面，犹如万点星光，泛起万顷银波。#r  对面的山崖是望雪崖，从那山崖上可以看到点苍山峰白雪皑皑，素裹银装，在阳光照耀下，洁白晶莹。#r  可是这么美丽的景色现在已经没有人敢来观赏了……");
	for i, Deliveryidx in x025002_g_DeliveryList do
		CallScriptFunction( x025002_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, Husongidx in x025002_g_HusongList do
		CallScriptFunction( x025002_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
	end
	for i, LootItemidx in x025002_g_LootItemList do
		CallScriptFunction( x025002_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
	end
	for i,KillMonsteridx in x025002_g_KillMonsterList do
		CallScriptFunction( x025002_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x025002_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x025002_OnDefaultEvent( sceneId, selfId,targetId )
	x025002_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x025002_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x025002_g_DeliveryList do
		if eventId == x025002_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, Husongidx in x025002_g_HusongList do
		if eventId == x025002_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
	for i, LootItemidx in x025002_g_LootItemList do
		if eventId == x025002_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i,KillMonsteridx in x025002_g_KillMonsterList do
		if eventId == x025002_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x025002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x025002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x025002_g_DeliveryList do
		if missionScriptId == x025002_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, Husongidx in x025002_g_HusongList do
		if missionScriptId == x025002_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
	for i, LootItemidx in x025002_g_LootItemList do
		if missionScriptId == x025002_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i,KillMonsteridx in x025002_g_KillMonsterList do
		if missionScriptId == x025002_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x025002_g_eventList do
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
function x025002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x025002_g_eventList do
		if missionScriptId == findId then
			x025002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x025002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x025002_g_DeliveryList do
		if missionScriptId == x025002_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, Husongidx in x025002_g_HusongList do
		if missionScriptId == x025002_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
	for i, LootItemidx in x025002_g_LootItemList do
		if missionScriptId == x025002_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i,KillMonsteridx in x025002_g_KillMonsterList do
		if missionScriptId == x025002_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x025002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x025002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x025002_g_DeliveryList do
		if missionScriptId == x025002_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, Husongidx in x025002_g_HusongList do
		if missionScriptId == x025002_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
	for i, LootItemidx in x025002_g_LootItemList do
		if missionScriptId == x025002_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i,KillMonsteridx in x025002_g_KillMonsterList do
		if missionScriptId == x025002_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x025002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x025002_OnDie( sceneId, selfId, killerId )
end
