--逍遥NPC
--公治子长
--普通

x014035_g_ScriptId = 014035
--所拥有的事件ID列表
x014035_g_eventList = {
	--武道循环任务
	891287,
}	
--**********************************
--事件列表
--**********************************
function x014035_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"最近我无意中找到了本巧匠的奇书，依书所为，竟然做成了天机傀儡。它们功能非常，似乎还能思考，想去见识见识么？")
		AddNumText(sceneId,x014035_g_ScriptId,"去见识天机傀儡",10,0)
		for i, eventId in x014035_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x014035_OnDefaultEvent( sceneId, selfId,targetId )
	x014035_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x014035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<81  then	
			BeginEvent( sceneId )
			local strText = "不要太小看我公冶子长的技艺，等级达不到81级，我是不会让你见天机傀儡的。"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 144,51,129)
		end
	end
	
	for i, findId in x014035_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x014035_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x014035_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x014035_g_eventList do
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
function x014035_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x014035_g_eventList do
		if missionScriptId == findId then
			x014035_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x014035_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x014035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x014035_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x014035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x014035_OnDie( sceneId, selfId, killerId )
end
