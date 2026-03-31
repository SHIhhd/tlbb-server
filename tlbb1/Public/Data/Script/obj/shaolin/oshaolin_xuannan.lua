--少林NPC
--玄难
--普通

x009002_g_ScriptId = 009002
--所拥有的事件ID列表
x009002_g_eventList = {
	--武道引导
	891219,891220,891279
}	
--**********************************
--事件列表
--**********************************
function x009002_UpdateEventList( sceneId, selfId,targetId )
	if GetMenPai(sceneId, selfId) == MP_SHAOLIN then
		BeginEvent(sceneId)
			AddText(sceneId,"#{TYJZ_081103_02}")
			for i, eventId in x009002_g_eventList do
				CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
			end
			AddNumText(sceneId, x009002_g_ScriptId, "学习技能",12,0)
			AddNumText(sceneId, x009002_g_ScriptId, "关于心法的介绍",11,10)
			--AddNumText(sceneId, x009002_g_ScriptId, "#{JZBZ_081031_02}",11,11)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"老衲玄难，施主找贫僧有何事啊？")
			
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件交互入口
--**********************************
function x009002_OnDefaultEvent( sceneId, selfId,targetId )
	x009002_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x009002_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 10 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{function_xinfajieshao_001}" )
								
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	elseif GetNumText() == 11 then
		BeginEvent(sceneId)					
			AddText( sceneId, "#{JZBZ_081031_01}" )							
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 0 then
		DispatchXinfaLevelInfo( sceneId, selfId, targetId, 0 );
	end
	
	for i, findId in x009002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x009002_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x009002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009002_g_eventList do
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
function x009002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x009002_g_eventList do
		if missionScriptId == findId then
			x009002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x009002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x009002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x009002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x009002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x009002_OnDie( sceneId, selfId, killerId )
end

