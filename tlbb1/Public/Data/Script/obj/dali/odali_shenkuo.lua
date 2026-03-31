--大理NPC
--沈括
--普通

--脚本号
x002001_g_scriptId = 002001

--所拥有的事件ID列表
x002001_g_eventList={212128,212131}
x002001_g_EnterareaScript = 006669
x002001_g_EnterareaList = {1020100,1020101,1020102,1020103,1020104,1020105,1020106,1020107,1020108,1020109,1020110,1020111,1020112,1020113,1020114,
1020115,1020116,1020117,1020118,1020119,1020120,1020121,1020122,1020123,1020124,1020125,1020126,1020127,1020128,1020129,1020130,1020131,1020132,
1020133,1020134,1020135,1020136,1020137,1020138,1020139,1020140,1020141,1020142,1020143,1020144,1020145,1020146,1020147,1020148,1020149}
--**********************************
--事件列表
--**********************************
function x002001_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  大理国有很多植物和矿藏极为罕见，也不枉我从汴京千里迢迢而来，真是不虚此行啊。")
		for i,Enterareaidx in x002001_g_EnterareaList do
			CallScriptFunction( x002001_g_EnterareaScript, "OnEnumerate",sceneId, selfId, targetId ,Enterareaidx)
		end
		for i, eventId in x002001_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		
		-- 领取称号
		if (IsMissionHaveDone(sceneId,selfId, 253) > 0 ) then
			AddNumText(sceneId, x002001_g_scriptId, "领取称号", 6, 999);
		end
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002001_OnDefaultEvent( sceneId, selfId,targetId )
	x002001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002001_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText()==999  then
		LuaFnAwardTitle( sceneId, selfId,  9, 233)
		SetCurTitle(sceneId, selfId,  9, 233)
		LuaFnDispatchAllTitle(sceneId, selfId)
		return
	end
	for i,Enterareaidx in x002001_g_EnterareaList do
		if eventId == x002001_g_EnterareaScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Enterareaidx)
		end
	end
	for i, findId in x002001_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i,Enterareaidx in x002001_g_EnterareaList do
		if missionScriptId == x002001_g_EnterareaScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Enterareaidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Enterareaidx)
			end
		end
	end
	for i, findId in x002001_g_eventList do
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
function x002001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002001_g_eventList do
		if missionScriptId == findId then
			x002001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,Enterareaidx in x002001_g_EnterareaList do
		if missionScriptId == x002001_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Enterareaidx)
		end
	end
	for i, findId in x002001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,Enterareaidx in x002001_g_EnterareaList do
		if missionScriptId == x002001_g_EnterareaScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Enterareaidx)
		end
	end
	for i, findId in x002001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002001_OnDie( sceneId, selfId, killerId )
end
