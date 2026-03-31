--脚本号
x001086_g_scriptId = 001086
x001086_g_eventList={808131,808137,808133,808132,808134,808135,808136}
--**********************************
--事件列表
--**********************************
function x001086_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{XCHQ_90601_1}" )
		CallScriptFunction( x001086_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( x001086_g_eventList[2], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( x001086_g_eventList[3], "OnEnumerate",sceneId, selfId, targetId )
		AddNumText(sceneId,x001086_g_scriptId,"#{ZXCM_090602_04}",6,5000)
		AddNumText(sceneId,x001086_g_eventList[4],"#{SQXY_09061_5}",6,3)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001086_OnDefaultEvent( sceneId, selfId,targetId )
	x001086_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x001086_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 5000 then
		local nWeek = GetTodayWeek();
		local nTime = GetHour() * 100 + GetMinute()
		--需要一个判断，判断玩家当前任务到第几环了，防止其余人卡任务，每周只能完成一次。
		local nMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_ZHONGXIACHUMO)
		BeginEvent(sceneId)
			AddText( sceneId,"#{ZXCM_090602_06}")
			if nWeek == 3 then
				if nTime >= 1900 and nTime < 2200 then
					if nMissionCount == 0 then
						CallScriptFunction(808134,"OnEnumerate",sceneId,selfId,targetId)
					elseif nMissionCount == 1 then
						CallScriptFunction(808135,"OnEnumerate",sceneId,selfId,targetId)
					elseif nMissionCount == 2 then
						CallScriptFunction(808136,"OnEnumerate",sceneId,selfId,targetId)
					end
				end
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	for i, findId in x001086_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,eventId)
			return
		end
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x001086_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,missionScriptId)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,missionScriptId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x001086_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			x001086_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001086_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId ,missionScriptId)
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001086_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId,missionScriptId, selectRadioId )
			return
		end
	end
end
--**********************************
--死亡事件
--**********************************
function x001086_OnDie( sceneId, selfId, killerId )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x001086_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**************************************************************************
--对话
--**************************************************************************
function x001086_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
