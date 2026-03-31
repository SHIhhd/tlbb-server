--天山NPC
--邓婆
--普通

x017035_g_ScriptId = 017035
--所拥有的事件ID列表
x017035_g_eventList = {
	--武道循环任务
	891287,
}	
--**********************************
--事件列表
--**********************************
function x017035_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"我天山一向与那些雪怪井水不犯河水，可是这些家伙越来越暴虐，姥姥用了计谋将它们引到了灵鹫峰上，现在就看你的了。")
		AddNumText(sceneId,x017035_g_ScriptId,"去歼灭雪怪",10,0)
		for i, eventId in x017035_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x017035_OnDefaultEvent( sceneId, selfId,targetId )
	x017035_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x017035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<61  then	
			BeginEvent( sceneId )
			local strText = "这些雪怪力大无穷，你等级不到61级，这样带你去，实在是危险。"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 147,94,145)
		end
	end
	
	for i, findId in x017035_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x017035_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x017035_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x017035_g_eventList do
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
function x017035_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x017035_g_eventList do
		if missionScriptId == findId then
			x017035_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x017035_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x017035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x017035_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x017035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x017035_OnDie( sceneId, selfId, killerId )
end
