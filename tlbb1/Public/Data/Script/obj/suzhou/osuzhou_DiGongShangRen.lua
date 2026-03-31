--苏州地宫商人

-- 脚本号
x891156_g_ScriptId = 891156

--所拥有的事件ID列表
x891156_g_EventList = {}

--操作所需最低等级
x891156_g_MinLevel = 80

--**********************************
--事件列表
--**********************************
function x891156_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{MJXZ_210510_83}" )

		local i, findId
		for i, findId in x891156_g_EventList do
			CallScriptFunction( findId, "OnEnumerate", sceneId, selfId, targetId )
		end
		--玲珑齿轮兑换
		AddNumText( sceneId, x891156_g_ScriptId, "#{MJXZ_210510_84}", 6, 100 )
		--玲珑机括兑换
		AddNumText( sceneId, x891156_g_ScriptId, "#{MJXZ_210510_85}", 6, 101 )
		--玲珑晶石兑换
		AddNumText( sceneId, x891156_g_ScriptId, "#{MJXZ_210510_86}", 6, 102 )
		
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件交互入口
--**********************************
function x891156_OnDefaultEvent( sceneId, selfId, targetId )
	x891156_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x891156_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 100 then
		if GetLevel(sceneId,selfId) < x891156_g_MinLevel then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_87}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return	
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,LuaFnGetAvailableItemCount(sceneId,selfId,38002256))
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89115701)
	elseif GetNumText() == 101 then
		if GetLevel(sceneId,selfId) < x891156_g_MinLevel then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_87}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return	
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,2)
			UICommand_AddInt(sceneId,LuaFnGetAvailableItemCount(sceneId,selfId,38002257))
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89115701)
	elseif GetNumText() == 102 then
		if GetLevel(sceneId,selfId) < x891156_g_MinLevel then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_87}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return	
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,4)
			UICommand_AddInt(sceneId,LuaFnGetAvailableItemCount(sceneId,selfId,38002262))
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89115701)
	end

	local i, findId
	for i, findId in x891156_g_EventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x891156_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local i, findId
	for i, findId in x891156_g_EventList do
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
function x891156_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	local i, findId

	--拒绝之后，要返回NPC的事件列表
	for i, findId in x891156_g_EventList do
		if missionScriptId == findId then
			x891156_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x891156_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	local i, findId
	for i, findId in x891156_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x891156_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	local i, findId
	for i, findId in x891156_g_EventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x891156_OnDie( sceneId, selfId, killerId )
end
