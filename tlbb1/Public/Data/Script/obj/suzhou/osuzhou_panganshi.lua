--庞安时

--脚本号
x001012_g_scriptId = 001012

--所拥有的事件ID列表
x001012_g_eventList={200601,200602,200802,200803,212116,713503,713562}
x001012_g_DeliveryScript = 006668
x001012_g_DeliveryList = {1010242}
x001012_g_KillMonsterScript = 006666
x001012_g_KillMonsterList = {1000230}
--**********************************
--事件列表
--**********************************
function x001012_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	--AddText(sceneId,"  医生以救死扶伤为天职，但如果一个恶人身患重病该怎么办呢？救，还是不救，这是一个问题。");
	AddText(sceneId, "#{OBJ_dali_0034}");
	for i, Deliveryidx in x001012_g_DeliveryList do
		CallScriptFunction( x001012_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i,KillMonsteridx in x001012_g_KillMonsterList do
		CallScriptFunction( x001012_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
	end
	for i, eventId in x001012_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001012_OnDefaultEvent( sceneId, selfId,targetId )
	x001012_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001012_OnEventRequest( sceneId, selfId, targetId, eventId )
	if eventId == 713503 or eventId == 713562 then
		CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(), x001012_g_scriptId )
		return
	end
	for i,Deliveryidx in x001012_g_DeliveryList do
		if eventId == x001012_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x001012_g_KillMonsterList do
		if eventId == x001012_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x001012_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001012_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Deliveryidx in x001012_g_DeliveryList do
		if missionScriptId == x001012_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,Deliveryidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x001012_g_KillMonsterList do
		if missionScriptId == x001012_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x001012_g_eventList do
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
function x001012_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001012_g_eventList do
		if missionScriptId == findId then
			x001012_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001012_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Deliveryidx in x001012_g_DeliveryList do
		if missionScriptId == x001012_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x001012_g_KillMonsterList do
		if missionScriptId == x001012_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x001012_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001012_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Deliveryidx in x001012_g_DeliveryList do
		if missionScriptId == x001012_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x001012_g_KillMonsterList do
		if missionScriptId == x001012_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x001012_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001012_OnDie( sceneId, selfId, killerId )
end
