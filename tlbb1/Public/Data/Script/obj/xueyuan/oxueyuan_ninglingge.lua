--NPC
--宁令哥
--普通
x021200_g_scriptId = 021200

--所拥有的事件ID列表
x021200_g_eventList={}
x021200_g_EnterareaScript = 006669
x021200_g_EnterareaList = {1020151}
x021200_g_KillMonsterScript = 006666
x021200_g_KillMonsterList = {1009201,1009202}
--**********************************
--事件列表
--**********************************
function x021200_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "你听说过得企鹅者得幸福这个传说吗？" )
		for i,Enterareaidx in x021200_g_EnterareaList do
			CallScriptFunction( x021200_g_EnterareaScript, "OnEnumerate",sceneId, selfId, targetId ,Enterareaidx)
		end
		for i,KillMonsteridx in x021200_g_KillMonsterList do
			CallScriptFunction( x021200_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
		end
		for i, eventId in x021200_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x021200_OnDefaultEvent( sceneId, selfId,targetId )
	x021200_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x021200_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i,Enterareaidx in x021200_g_EnterareaList do
		if eventId == x021200_g_EnterareaScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,Enterareaidx)
		end
	end
	for i,KillMonsteridx in x021200_g_KillMonsterList do
		if eventId == x021200_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x021200_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x021200_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i, Enterareaidx in x021200_g_EnterareaList do
		if missionScriptId == x021200_g_EnterareaScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,Enterareaidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,Enterareaidx)
			end
			return
		end
	end
	for i,KillMonsteridx in x021200_g_KillMonsterList do
		if missionScriptId == x021200_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x021200_g_eventList do
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
function x021200_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x021200_g_eventList do
		if missionScriptId == findId then
			x021200_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x021200_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Enterareaidx in x021200_g_EnterareaList do
		if missionScriptId == x021200_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId,Enterareaidx)
		end
	end
	for i,KillMonsteridx in x021200_g_KillMonsterList do
		if missionScriptId == x021200_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x021200_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x021200_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Enterareaidx in x021200_g_EnterareaList do
		if missionScriptId == x021200_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId,selectRadioId,Enterareaidx)
		end
	end
	for i,KillMonsteridx in x021200_g_KillMonsterList do
		if missionScriptId == x021200_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i,	findId in x021200_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x021200_OnDie( sceneId, selfId, killerId )
end
