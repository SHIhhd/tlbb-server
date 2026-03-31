--明教NPC
--石刚
--普通

x011035_g_ScriptId = 011035
--所拥有的事件ID列表
x011035_g_eventList = {
	--武道循环任务
	891287,
}	
--**********************************
--事件列表
--**********************************
function x011035_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"官兵又来围剿光明殿，真是麻烦，不过来的都是些无名小卒，你愿意去练练拳脚吗？")
		AddNumText(sceneId,x011035_g_ScriptId,"去抵挡围剿",10,0)
		for i, eventId in x011035_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x011035_OnDefaultEvent( sceneId, selfId,targetId )
	x011035_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x011035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<31  then	
			BeginEvent( sceneId )
			local strText = "虽是无名小卒，也不可小觎，你还不到31级，为了你的安全依我看，还是练练再来吧。"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 141,97,157)
		end
	end
	
	for i, findId in x011035_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x011035_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x011035_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x011035_g_eventList do
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
function x011035_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x011035_g_eventList do
		if missionScriptId == findId then
			x011035_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x011035_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x011035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x011035_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x011035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x011035_OnDie( sceneId, selfId, killerId )
end