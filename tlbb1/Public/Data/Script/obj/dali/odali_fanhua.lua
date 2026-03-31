--大理NPC
--范骅
--普通

--脚本号
x002015_g_ScriptId = 002015

--所拥有的事件
--武道循环任务 891274
--所拥有的事件ID列表
x002015_g_eventList={891274}
--**********************************
--事件列表
--**********************************
function x002015_UpdateEventList( sceneId, selfId,targetId )
	 local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
	AddText(sceneId,"  "..PlayerName..PlayerSex.."#{OBJ_dali_0005}")
	for i, eventId in x002015_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002015_OnDefaultEvent( sceneId, selfId,targetId )
	x002015_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002015_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002015_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x002015_g_ScriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002015_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002015_g_eventList do
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
function x002015_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002015_g_eventList do
		if missionScriptId == findId then
			x002015_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002015_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002015_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002015_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002015_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002015_OnDie( sceneId, selfId, killerId )
end
