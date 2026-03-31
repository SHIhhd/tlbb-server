--水月山庄传送沈夜雨
x891075_g_scriptId = 891075

--所拥有的事件ID列表
x891075_g_eventList={}

--**********************************
--事件列表
--**********************************
function x891075_UpdateEventList( sceneId, selfId,targetId )
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId,4);
	BeginEvent(sceneId)
		if leaveFlag == 0 then
			AddText(sceneId,"#{SYSZ_20210205_01}")
			AddNumText(sceneId,x891075_g_scriptId,"#{SYSZ_20210205_02}",9,3)
		else
			AddText(sceneId,"#{SYSZ_20210203_96}")
			AddNumText(sceneId,x891075_g_scriptId,"#{SYSZ_20210203_94}",6,4)
			AddNumText(sceneId,x891075_g_scriptId,"#{SYSZ_20210203_95}",6,5)
		end
		for i, eventId in x891075_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x891075_OnDefaultEvent( sceneId, selfId,targetId )
	x891075_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x891075_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumText = GetNumText()
	if nNumText == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SYSZ_20210205_93}")
			AddNumText(sceneId,x891070_g_ScriptId,"#{SYSZ_20210205_94}",6,4)
			AddNumText(sceneId,x891070_g_ScriptId,"#{SYSZ_20210205_95}",6,5)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if nNumText == 4 then
		CallScriptFunction((400900),"TransferFunc",sceneId,selfId,1,133,107)
	end
	if nNumText == 5 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
	for i, findId in x891075_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x891075_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x891075_g_eventList do
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
function x891075_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x891075_g_eventList do
		if missionScriptId == findId then
			x891075_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x891075_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x891075_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x891075_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x891075_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x891075_OnDie( sceneId, selfId, killerId )
end
