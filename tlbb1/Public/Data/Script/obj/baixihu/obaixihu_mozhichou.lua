--墨知愁

--脚本号
x890231_g_scriptId = 890231

--所拥有的事件ID列表
x890231_g_eventList={
	--白溪湖声望
	890060,
	--灵武NPC操作
	888810,
	--剧情任务
	890154,
	890155,
	890156,
	890159,
	890160,
	890161,
	890162,
	890163,
	890164,
	--天鉴·雪重难行
	890068,
	--天鉴·剪雪裁冰
	890069,
	--天鉴·知交莫零落
	890070,
	--天鉴·知音叹别离
	890071,
}

--**********************************
--事件列表
--**********************************
function x890231_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SWXT_221213_1}");
	for i, eventId in x890231_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x890231_OnDefaultEvent( sceneId, selfId,targetId )
	x890231_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x890231_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x890231_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x890231_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890231_g_eventList do
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
function x890231_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x890231_g_eventList do
		if missionScriptId == findId then
			x890231_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x890231_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890231_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x890231_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x890231_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x890231_OnDie( sceneId, selfId, killerId )
end
