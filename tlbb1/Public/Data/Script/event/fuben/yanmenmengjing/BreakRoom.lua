--雁门团本 休息室 NPC
--脚本号
x998467_g_ScriptId = 998467

--所拥有的事件ID列表
x998467_g_eventList={
	--普通难度
	998445,
	--困难难度
	998446,
}

--**********************************
--事件列表
--**********************************
function x998467_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{YMMJ_230626_2}");
		for i, eventId in x998467_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddNumText(sceneId, x998467_g_ScriptId,"#{YMMJ_230626_29}",9,1000);
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x998467_OnDefaultEvent( sceneId, selfId,targetId )
	x998467_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998467_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x998467_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	if GetNumText() == 1 then
		if sceneId ~= SCENE_YANMEN_BREAKROOM then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_139}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, SCENE_DALI, 243,56, 65 );
	end
	if GetNumText() == 2 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )	
		return
	end
	if GetNumText() == 1000 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{YMMJ_230626_138}");
			AddNumText(sceneId, x998467_g_ScriptId,"#{YMMJ_230626_68}",6,1);
			AddNumText(sceneId, x998467_g_ScriptId,"#{YMMJ_230626_69}",6,2);
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x998467_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x998467_g_eventList do
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
function x998467_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x998467_g_eventList do
		if missionScriptId == findId then
			x998467_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x998467_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x998467_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x998467_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x998467_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x998467_OnDie( sceneId, selfId, killerId )
end

--**********************************
--玩家进入休息室
--**********************************
function x998467_OnPlayerEnterScene( sceneId, selfId )
	--打开常驻页面
	BeginUICommand(sceneId)
		--打开页面
		if sceneId == SCENE_YANMEN_BREAKROOM then
			UICommand_AddInt(sceneId,1)
		else
			UICommand_AddInt(sceneId,0)
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 99846701)
end

