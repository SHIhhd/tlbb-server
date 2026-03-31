--甘宝宝

--脚本号
x025004_g_scriptId = 025004

--所拥有的事件ID列表
x025004_g_eventList={212121}
x025004_g_DeliveryScript = 006668
x025004_g_DeliveryList = {1010120,1010392}
x025004_g_HusongScript = 006671
x025004_g_HusongList = {1050002}
x025004_g_KillMonsterScript = 006666
x025004_g_KillMonsterList = {1000122,1000123}
--**********************************
--事件列表
--**********************************
function x025004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"  苍山负雪，明烛天南。#r  自己的选择究竟是对还是错，谁又说的清楚呢？");
	for i, Deliveryidx in x025004_g_DeliveryList do
		CallScriptFunction( x025004_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, Husongidx in x025004_g_HusongList do
		CallScriptFunction( x025004_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
	end
	for i,KillMonsteridx in x025004_g_KillMonsterList do
		CallScriptFunction( x025004_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x025004_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x025004_OnDefaultEvent( sceneId, selfId,targetId )
	x025004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x025004_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x025004_g_DeliveryList do
		if eventId == x025004_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, Husongidx in x025004_g_HusongList do
		if eventId == x025004_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
	for i,KillMonsteridx in x025004_g_KillMonsterList do
		if eventId == x025004_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x025004_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x025004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x025004_g_DeliveryList do
		if missionScriptId == x025004_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, Husongidx in x025004_g_HusongList do
		if missionScriptId == x025004_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
	for i,KillMonsteridx in x025004_g_KillMonsterList do
		if missionScriptId == x025004_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x025004_g_eventList do
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
function x025004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x025004_g_eventList do
		if missionScriptId == findId then
			x025004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x025004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x025004_g_DeliveryList do
		if missionScriptId == x025004_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, Husongidx in x025004_g_HusongList do
		if missionScriptId == x025004_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
	for i,KillMonsteridx in x025004_g_KillMonsterList do
		if missionScriptId == x025004_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x025004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x025004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x025004_g_DeliveryList do
		if missionScriptId == x025004_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, Husongidx in x025004_g_HusongList do
		if missionScriptId == x025004_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
	for i,KillMonsteridx in x025004_g_KillMonsterList do
		if missionScriptId == x025004_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x025004_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x025004_OnDie( sceneId, selfId, killerId )
end
