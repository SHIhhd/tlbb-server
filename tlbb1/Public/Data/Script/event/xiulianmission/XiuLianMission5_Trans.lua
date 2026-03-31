--脚本号
x891301_g_scriptId = 891301

x891301_g_MissionId = 2034
--任务参数
x891301_g_IsMissionOkFail = 0--是否完成
x891301_g_Param_Custom = 4--完成情况

--所拥有的事件ID列表
x891301_g_eventList={}

--**********************************
--事件列表
--**********************************
function x891301_UpdateEventList( sceneId, selfId,targetId )
	
	BeginEvent(sceneId)	
		AddText(sceneId,"#{XLRW_210725_102}")
		AddNumText(sceneId,x891301_g_scriptId,"#{XLRW_210725_103}",9,0)
		for i, eventId in x891301_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x891301_OnDefaultEvent( sceneId, selfId,targetId )
	x891301_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x891301_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		--检查任务有无完成
		if IsHaveMission(sceneId,selfId,x891301_g_MissionId) <= 0 then
			return
		end
		local misIndex = GetMissionIndexByID(sceneId,selfId,x891301_g_MissionId)
		local misOk = GetMissionParam(sceneId,selfId,misIndex,x891301_g_IsMissionOkFail)
		if misOk == 0 then
			BeginEvent(sceneId)	
				AddText(sceneId,"#{XLRW_210725_28}")
				AddNumText(sceneId,x891301_g_scriptId,"#{XLRW_210725_29}",6,1)
				AddNumText(sceneId,x891301_g_scriptId,"#{XLRW_210725_33}",6,2)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			--直接送回本门派
			if LuaFnGetSceneType(sceneId) == 1 then
				SetMissionByIndex(sceneId,selfId,misIndex,x891301_g_Param_Custom,0)
				--调用门派召集令
				CallScriptFunction(340001, "MenpaiTransfer",sceneId, selfId)
			end
		end
	elseif GetNumText()==2	then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	elseif GetNumText()==1	then
		--直接送回本门派
		if LuaFnGetSceneType(sceneId) == 1 then
			SetMissionByIndex(sceneId,selfId,misIndex,x891301_g_Param_Custom,0)
			--调用门派召集令
			CallScriptFunction(340001, "MenpaiTransfer",sceneId, selfId)
		end
	else
		for i, findId in x891301_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x891301_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x891301_g_eventList do
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
function x891301_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x891301_g_eventList do
		if missionScriptId == findId then
			x891301_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x891301_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x891301_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x891301_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x891301_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x891301_OnDie( sceneId, selfId, killerId )
end
