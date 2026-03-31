--丐帮NPC
--欧阳果
--普通

x010035_g_ScriptId = 010035
--所拥有的事件ID列表
x010035_g_eventList = {
	--武道循环任务
	891287,
}	
--**********************************
--事件列表
--**********************************
function x010035_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"那些恶猴一贯进入我们酒窖偷酒，甚是可恶，我们教训过他们几次，竟不知进退的来攻丐帮总舵，要去给他们些颜色吗？")
		AddNumText(sceneId,x010035_g_ScriptId,"去抵挡恶猴",10,0)
		for i, eventId in x010035_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x010035_OnDefaultEvent( sceneId, selfId,targetId )
	x010035_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x010035_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<11  then	
			BeginEvent( sceneId )
			local strText = "可不要小看这些恶猴，我看你还是等级超过11级再来找我吧。"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 140,91,151)
		end
	end
	
	for i, findId in x010035_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x010035_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x010035_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x010035_g_eventList do
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
function x010035_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x010035_g_eventList do
		if missionScriptId == findId then
			x010035_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x010035_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x010035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x010035_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x010035_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x010035_OnDie( sceneId, selfId, killerId )
end