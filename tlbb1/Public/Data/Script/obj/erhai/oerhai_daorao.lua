--鲁平


--脚本号
x024001_g_scriptId = 024001

--所拥有的事件ID列表
x024001_g_eventList={808099, 808100, 808101, 808094}
x024001_g_DeliveryScript = 006668
x024001_g_DeliveryList = {1010110}
x024001_g_HusongScript = 006671
x024001_g_HusongList = {1050001}
x024001_g_KillMonsterScript = 006666
x024001_g_KillMonsterList = {1000112,1000113,1000114}
--**********************************
--事件列表
--**********************************
function x024001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  年轻人，在这里可不要乱跑啊！#r  野人和狼人可都不是好惹的，看看我们村子现在的状况，你就知道那些侵略者有多凶狠了。#r  前面的那条大路叫茶马道，很多商人从这里运送茶叶去遥远的异国，以前时不时的就有马队从那里经过，马铃声可以传到好远好远……")
	for i, Deliveryidx in x024001_g_DeliveryList do
		CallScriptFunction( x024001_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, Husongidx in x024001_g_HusongList do
		CallScriptFunction( x024001_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
	end
	for i,KillMonsteridx in x024001_g_KillMonsterList do
		CallScriptFunction( x024001_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x024001_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x024001_OnDefaultEvent( sceneId, selfId,targetId )
	x024001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x024001_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x024001_g_DeliveryList do
		if eventId == x024001_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, Husongidx in x024001_g_HusongList do
		if eventId == x024001_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
	for i,KillMonsteridx in x024001_g_KillMonsterList do
		if eventId == x024001_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x024001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x024001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x024001_g_DeliveryList do
		if missionScriptId == x024001_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, Husongidx in x024001_g_HusongList do
		if missionScriptId == x024001_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
	for i,KillMonsteridx in x024001_g_KillMonsterList do
		if missionScriptId == x024001_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x024001_g_eventList do
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
function x024001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x024001_g_eventList do
		if missionScriptId == findId then
			x024001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x024001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x024001_g_DeliveryList do
		if missionScriptId == x024001_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, Husongidx in x024001_g_HusongList do
		if missionScriptId == x024001_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
	for i,KillMonsteridx in x024001_g_KillMonsterList do
		if missionScriptId == x024001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x024001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x024001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x024001_g_DeliveryList do
		if missionScriptId == x024001_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, Husongidx in x024001_g_HusongList do
		if missionScriptId == x024001_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
	for i,KillMonsteridx in x024001_g_KillMonsterList do
		if missionScriptId == x024001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x024001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x024001_OnDie( sceneId, selfId, killerId )
end
