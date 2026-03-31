--江行云

--脚本号
x890238_g_scriptId = 890238

--所拥有的事件ID列表
x890238_g_eventList={
	--西凉风林声望
	890062,
	--灵武NPC操作
	888810,
	--剧情任务
	890157,
	890158,
	890159,
	890162,
	890163,
	890164,
	--天鉴·如履薄冰
	890081,
	--天鉴·一花一念
	890083,
	--天鉴·所思在远道
	890084,
	--天鉴·暗香旧时月
	890085,
}

--**********************************
--事件列表
--**********************************
function x890238_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SWXT_221213_6}");
	for i, eventId in x890238_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x890238_OnDefaultEvent( sceneId, selfId,targetId )
	x890238_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x890238_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x890238_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x890238_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890238_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId,targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x890238_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x890238_g_eventList do
		if missionScriptId == findId then
			x890238_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x890238_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890238_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x890238_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x890238_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x890238_OnDie( sceneId, selfId, killerId )
end
