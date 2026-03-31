--祝福贵
--周活跃入口npc

x002096_g_ScriptId = 002096
x002096_g_DeliveryScript = 006668
x002096_g_DeliveryList = {1018820,1018821,1018822,1018823,1018824,1018825,1018826,1018827,1018828}
--**********************************
--事件交互入口
--**********************************
function x002096_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZHY_210301_34}")
		AddNumText( sceneId, x002096_g_ScriptId, "#{ZHY_210301_03}",14,1) 
		AddNumText( sceneId, x002096_g_ScriptId, "#{GZRW_XML_2}",14,2)  
		for i, Deliveryidx in x002096_g_DeliveryList do
			CallScriptFunction( x002096_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x002096_OnEventRequest(sceneId,selfId,targetId,eventId)
    local myLevel = GetLevel(sceneId, selfId)
	if myLevel < 35 then
	    x002096_NotifyTip( sceneId, selfId, "#{ZHY_210301_02}" )
		return
	end
	if GetNumText() == 1 then
		--打开客户端UI
		CallScriptFunction(800121, "OpenUI", sceneId,selfId)
	elseif GetNumText() == 2 then
		--没执行过工资任务
		BeginEvent(sceneId)
			AddText(sceneId,"#{GZRW_XML_20}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--配表任务
	for i,Deliveryidx in x002096_g_DeliveryList do
		if eventId == x002096_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
end
--**********************************
--屏幕中间醒目提示
--**********************************
function x002096_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--接受此NPC的任务
--**********************************
function x002096_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x002096_g_DeliveryList do
		if missionScriptId == x002096_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002096_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002096_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x002096_g_DeliveryList do
		if missionScriptId == x002096_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002096_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x002096_g_DeliveryList do
		if missionScriptId == x002096_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002096_OnDie( sceneId, selfId, killerId )
end
