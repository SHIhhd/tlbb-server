--大理NPC
--黄公道
--服装店

x002024_g_scriptId = 002024
x002024_g_shoptableindex = 2
--所拥有的事件ID列表
x002024_g_eventList={210256,210257,210258,210280}

--**********************************
--事件交互入口
--**********************************
function x002024_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "    本店有大量商品出售，欢迎选购！" )
		AddNumText( sceneId, x002024_g_scriptId, "看看你卖的东西", 7, 0 )
		for i, eventId in x002024_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002024_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		DispatchShopItem( sceneId, selfId, targetId, x002024_g_shoptableindex )
	end
	for i, findId in x002024_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x002024_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002024_g_eventList do
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
function x002024_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002024_g_eventList do
		if missionScriptId == findId then
			x002024_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002024_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002024_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002024_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002024_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002024_OnDie( sceneId, selfId, killerId )
end
