--苏州NPC
--王安石
--一般

--脚本号
x001000_g_scriptId = 001000

--所拥有的事件ID列表
x001000_g_eventList={212130, 212133}
x001000_g_KillMonsterScript = 006666
x001000_g_KillMonsterList = {1000300,1000301,1000302,1000303,1000304,1000305,1000306,1000307,1000308,1000309,1000310,1000311,1000312,1000313,1000314,
1000315,1000316,1000317,1000318,1000319,1000320,1000321,1000322,1000323,1000324,1000325,1000326,1000327,1000328,1000329,1000330,1000331,1000332,1000333,
1000334,1000335,1000336,1000337,1000338,1000339}
--**********************************
--事件列表
--**********************************
function x001000_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  天变不足畏，祖宗不足法，流俗之言不足恤。")
		for i,KillMonsteridx in x001000_g_KillMonsterList do
			CallScriptFunction( x001000_g_KillMonsterScript, "OnEnumerate",sceneId, selfId, targetId,KillMonsteridx)
		end
		for i, eventId in x001000_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end

		-- 领取称号
		if (IsMissionHaveDone(sceneId,selfId, 255) > 0 ) then
			AddNumText(sceneId, x001000_g_scriptId, "领取称号", 6, 999);
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001000_OnDefaultEvent( sceneId, selfId,targetId )
	x001000_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001000_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText()==999  then
		LuaFnAwardTitle( sceneId, selfId,  11, 235)
		SetCurTitle(sceneId, selfId,  11, 235)
		LuaFnDispatchAllTitle(sceneId, selfId)
		return
	end
	for i,KillMonsteridx in x001000_g_KillMonsterList do
		if eventId == x001000_g_KillMonsterScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,KillMonsteridx)
		end
	end
	for i, findId in x001000_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001000_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	local ret = 0
	for i,KillMonsteridx in x001000_g_KillMonsterList do
		if missionScriptId == x001000_g_KillMonsterScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,KillMonsteridx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,KillMonsteridx)
			end
		end
	end
	for i, findId in x001000_g_eventList do
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
function x001000_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001000_g_eventList do
		if missionScriptId == findId then
			x001000_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001000_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i,KillMonsteridx in x001000_g_KillMonsterList do
		if missionScriptId == x001000_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId ,targetId,KillMonsteridx)
		end
	end
	for i, findId in x001000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001000_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i,KillMonsteridx in x001000_g_KillMonsterList do
		if missionScriptId == x001000_g_KillMonsterScript then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId ,targetId,selectRadioId,KillMonsteridx)
		end
	end
	for i, findId in x001000_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001000_OnDie( sceneId, selfId, killerId )
end
