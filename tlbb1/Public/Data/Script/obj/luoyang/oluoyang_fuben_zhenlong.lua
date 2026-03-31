--珍珑副本任务npc

--脚本号
x000090_g_scriptId = 000090


--所拥有的事件ID列表
x000090_g_eventList={401001,891274}
x000090_g_DeliveryScript = 006668
x000090_g_DeliveryList = {1018703,1018705}
--**********************************
--事件列表
--**********************************
function x000090_UpdateEventList( sceneId, selfId,targetId )

	BeginEvent(sceneId)
	
		AddNumText( sceneId, x000090_g_scriptId, "棋局介绍", 11, 10 )
	
		if sceneId == 0 then
			AddNumText( sceneId, x000090_g_scriptId, "进入洛阳第一休息室", 9, 20 )
			AddNumText( sceneId, x000090_g_scriptId, "进入洛阳第二休息室", 9, 21 )
			AddNumText( sceneId, x000090_g_scriptId, "关于休息室", 11, 30 )
		elseif sceneId == 1 then
			AddNumText( sceneId, x000090_g_scriptId, "进入苏州休息室", 9, 22 )
			AddNumText( sceneId, x000090_g_scriptId, "关于休息室", 11, 31 )
		elseif sceneId == 2 then
			AddNumText( sceneId, x000090_g_scriptId, "进入大理休息室", 9, 23 )
			AddNumText( sceneId, x000090_g_scriptId, "关于休息室", 11, 32 )
		end

		AddNumText( sceneId, x000090_g_scriptId, "如何在刷棋中获得更多的经验", 11, 519 )
		--[tx45411]AddNumText(sceneId, x000090_g_scriptId, "#{NSRQ_081110_2}", 11, 999); --zchw
		for i, Deliveryidx in x000090_g_DeliveryList do
			CallScriptFunction( x000090_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, findId in x000090_g_eventList do
			CallScriptFunction( x000090_g_eventList[i], "OnEnumerate",sceneId, selfId, targetId )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件交互入口
--**********************************
function x000090_OnDefaultEvent( sceneId, selfId,targetId )
	x000090_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000090_OnEventRequest( sceneId, selfId, targetId, eventId )

	--[tx45411]if GetNumText() == 999 then
		--BeginEvent(sceneId)					
		--	AddText( sceneId, "#{NSRQ_081110_3}" )						
		--EndEvent(sceneId)
		--DispatchEventList(sceneId,selfId,targetId)
		--return		
	--[/tx45411]end
	if GetNumText() == 10 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{function_help_063}" )
								
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	end
	
	if GetNumText() == 519 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{QJ_20080522_03}" )
								
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	end
	
	local NumText = GetNumText()
	if NumText == 20 then
		x000090_CheckCanEnterRest( sceneId, selfId, targetId, 418,32,16 )
		return
	elseif  NumText == 21 then
		x000090_CheckCanEnterRest( sceneId, selfId, targetId, 419,32,16 )
		return
	elseif  NumText == 22 then
		x000090_CheckCanEnterRest( sceneId, selfId, targetId, 518,32,16 )
		return
	elseif  NumText == 23 then
		x000090_CheckCanEnterRest( sceneId, selfId, targetId, 193,32,16 )
		return
	elseif  NumText == 30 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{QJXXS_1105_1}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif  NumText == 31 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{QJXXS_1105_2}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif  NumText == 32 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{QJXXS_1105_3}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--配表任务
	for i,Deliveryidx in x000090_g_DeliveryList do
		if eventId == x000090_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, findId in x000090_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000090_OnDie( sceneId, selfId, killerId )
end

--**********************************
--检测是否可以进入棋局休息室
--**********************************
function x000090_CheckCanEnterRest( sceneId, selfId, targetId, s, x, y )

	if LuaFnHasTeam(sceneId, selfId) ~= 0 then

		if LuaFnIsTeamLeader(sceneId, selfId) == 0 then
			BeginEvent(sceneId)	
				AddText( sceneId, "  只有队长才能带领队友进入休息室。" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	
		local teamMemberCount = GetTeamMemberCount(sceneId, selfId)
		local nearMemberCount = GetNearTeamCount(sceneId, selfId)
		if teamMemberCount ~= nearMemberCount then
			BeginEvent(sceneId)	
				AddText( sceneId, "  你的队伍中有人不在附近。" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		local memId;
		for	i = 0, nearMemberCount - 1 do
			memId = GetNearTeamMember(sceneId, selfId, i);
			NewWorld(sceneId, memId, s, x, y);
		end

	else

		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, s, x, y )

	end

end

--**********************************
--接受此NPC的任务
--**********************************
function x000090_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x000090_g_DeliveryList do
		if missionScriptId == x000090_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x000090_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,targetId,missionScriptId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000090_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000090_g_eventList do
		if missionScriptId == findId then
			x000090_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000090_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x000090_g_DeliveryList do
		if missionScriptId == x000090_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x000090_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000090_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x000090_g_DeliveryList do
		if missionScriptId == x000090_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x000090_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000090_OnDie( sceneId, selfId, killerId )
end
