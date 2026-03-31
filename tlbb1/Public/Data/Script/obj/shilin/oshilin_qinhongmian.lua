--石林 秦红棉

--脚本号
x026001_g_scriptId = 026001

--所拥有的事件ID列表
x026001_g_eventList={}--211703,211706	
x026001_g_DeliveryScript = 006668
x026001_g_DeliveryList = {1010393}
x026001_g_KillMonsterScript = 006666
x026001_g_KillMonsterList = {1000071,1000357}
--**********************************
--事件列表
--**********************************
function x026001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "    你就是从大理来的$N？那你一定见过段郎了？段郎？段郎你不知道？就是大理的镇南王段正淳！哼，那个该杀千刀的，等我见到他……有他好看的。")	
		for i, Deliveryidx in x026001_g_DeliveryList do
			CallScriptFunction( x026001_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i,KillMonsteridx in x026001_g_KillMonsterList do
			CallScriptFunction( x026001_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
		end
		for i, eventId in x026001_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x026001_OnDefaultEvent( sceneId, selfId,targetId )
	x026001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x026001_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,Deliveryidx in x026001_g_DeliveryList do
		if eventId == x026001_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x026001_g_KillMonsterList do
		if eventId == x026001_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x026001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x026001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Deliveryidx in x026001_g_DeliveryList do
		if missionScriptId == x026001_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,Deliveryidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x026001_g_KillMonsterList do
		if missionScriptId == x026001_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x026001_g_eventList do
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
function x026001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x026001_g_eventList do
		if missionScriptId == findId then
			x026001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x026001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Deliveryidx in x026001_g_DeliveryList do
		if missionScriptId == x026001_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x026001_g_KillMonsterList do
		if missionScriptId == x026001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x026001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x026001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Deliveryidx in x026001_g_DeliveryList do
		if missionScriptId == x026001_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,Deliveryidx)
		end
	end
	for i,KillMonsteridx in x026001_g_KillMonsterList do
		if missionScriptId == x026001_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x026001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x026001_OnDie( sceneId, selfId, killerId )
end
