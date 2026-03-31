--青鸢

x292007_g_ScriptId	= 292007
--所拥有的事件ID列表
x292007_g_eventList={
	--天机城代币商店
	890254,
}
--**********************************
--事件列表
--**********************************
function x292007_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	--CJWK_221220_31	传送至长春谷·横崖	
	if sceneId == SCENE_BAIXIHU or sceneId == SCENE_SHUNANZHUHAI or sceneId == SCENE_XILIANGFENGLIN then
		AddText(sceneId,"#{BLDPVP_221214_18}");
		AddNumText(sceneId,x292007_g_ScriptId,"#{CJWK_221220_31}",9,0)
		for i, eventId in x292007_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	else
		AddText(sceneId,"#{CJWK_221220_57}");
		AddNumText(sceneId,x292007_g_ScriptId,"#{CJWK_221220_58}",9,1)
		AddNumText(sceneId,x292007_g_ScriptId,"#{CJWK_221220_59}",9,2)
		AddNumText(sceneId,x292007_g_ScriptId,"#{CJWK_221220_60}",9,3)
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x292007_OnDefaultEvent( sceneId, selfId,targetId )
	x292007_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x292007_OnEventRequest( sceneId, selfId, targetId, eventId )

	if sceneId == SCENE_BAIXIHU or sceneId == SCENE_SHUNANZHUHAI or sceneId == SCENE_XILIANGFENGLIN then
	
		for i, findId in x292007_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
				return
			end
		end
		if GetNumText() == 0 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId, x292007_g_ScriptId);			
				UICommand_AddInt(sceneId, targetId);
				UICommand_AddInt(sceneId, 4);
				UICommand_AddString(sceneId, "GotoNewScene");
				UICommand_AddString(sceneId, "#{CJWK_221220_03}");
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 24)
		end
	else
		if GetNumText() == 1 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId, x292007_g_ScriptId);			
				UICommand_AddInt(sceneId, targetId);
				UICommand_AddInt(sceneId, 1);
				UICommand_AddString(sceneId, "GotoNewScene");
				UICommand_AddString(sceneId, "#{CJWK_221220_61}");
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 24)
		elseif GetNumText() == 2 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId, x292007_g_ScriptId);			
				UICommand_AddInt(sceneId, targetId);
				UICommand_AddInt(sceneId, 2);
				UICommand_AddString(sceneId, "GotoNewScene");
				UICommand_AddString(sceneId, "#{CJWK_221220_62}");
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 24)
		elseif GetNumText() == 3 then	
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId, x292007_g_ScriptId);			
				UICommand_AddInt(sceneId, targetId);
				UICommand_AddInt(sceneId, 3);
				UICommand_AddString(sceneId, "GotoNewScene");
				UICommand_AddString(sceneId, "#{CJWK_221220_63}");
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 24)
		end
	end
	
end

--**********************************
--接受此NPC的任务
--**********************************
function x292007_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x292007_g_eventList do
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
function x292007_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x292007_g_eventList do
		if missionScriptId == findId then
			x292007_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x292007_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x292007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x292007_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x292007_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x292007_OnDie( sceneId, selfId, killerId )
end
--**********************************
--传送事件
--**********************************
function x292007_GotoNewScene( sceneId, selfId, targetId,nIndex )
	if nIndex == 1 then
		CallScriptFunction(400900, "TransferFuncFromNpc",sceneId, selfId, SCENE_BAIXIHU,118,110, 85)
	elseif nIndex == 2 then
		CallScriptFunction(400900, "TransferFuncFromNpc",sceneId, selfId, SCENE_SHUNANZHUHAI,84,111, 85)
	elseif nIndex == 3 then
		CallScriptFunction(400900, "TransferFuncFromNpc",sceneId, selfId, SCENE_XILIANGFENGLIN,95,64, 85)
	elseif nIndex == 4 then	
		CallScriptFunction(400900, "TransferFuncFromNpc",sceneId, selfId, SCENE_CHANGCHUNGU_HY,54,217, 85)
	end
end
