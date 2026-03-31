--地宫二层传送人

-- 脚本号
x893387_g_ScriptId = 893387

--所拥有的事件ID列表
x893387_g_EventList = {893379}

--**********************************
--事件列表
--**********************************
function x893387_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{MJXZ_210510_248}" )
		local i, findId
		for i, findId in x893387_g_EventList do
			CallScriptFunction( findId, "OnEnumerate", sceneId, selfId, targetId )
		end
		--AddNumText( sceneId, x893387_g_ScriptId, "#{MJXZ_210510_84}", 6, 100 )		
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--Monster Timer
--**********************************
function x893387_OnCharacterTimer( sceneId, objId, dataId, uTime )
	CallScriptFunction( 891147, "OnSceneTimer", sceneId )
end

--**********************************
--事件交互入口
--**********************************
function x893387_OnDefaultEvent( sceneId, selfId, targetId )
	x893387_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893387_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 100 then
	end

	local i, findId
	for i, findId in x893387_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893387_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local i, findId
	for i, findId in x893387_g_EventList do
		if missionScriptId == findId then
			local ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId, targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId, missionScriptId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x893387_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	local i, findId

	--拒绝之后，要返回NPC的事件列表
	for i, findId in x893387_g_EventList do
		if missionScriptId == findId then
			x893387_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x893387_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	local i, findId
	for i, findId in x893387_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x893387_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	local i, findId
	for i, findId in x893387_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x893387_OnDie( sceneId, selfId, killerId )
end
