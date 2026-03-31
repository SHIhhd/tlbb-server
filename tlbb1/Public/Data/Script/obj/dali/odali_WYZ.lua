--洛阳NPC
--无崖子
--普通

--脚本号
x002097_g_ScriptId = 002097

--所拥有的事件ID列表
x002097_g_eventList={}
x002097_g_DeliveryScript = 006668
x002097_g_DeliveryList = {1018836}
--**********************************
--事件列表
--**********************************
function x002097_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{WH_090729_03}")
		for i, eventId in x002097_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end	
		AddNumText(sceneId,x002097_g_ScriptId,"提升武魂合成等级",6,1) 
		AddNumText(sceneId,x002097_g_ScriptId,"武魂开辟属性栏",6,2)
		AddNumText(sceneId,x002097_g_ScriptId,"武魂扩展属性学习",6,3)
		AddNumText(sceneId,x002097_g_ScriptId,"武魂扩展属性升级",6,4)
		AddNumText(sceneId,x002097_g_ScriptId,"武魂领悟技能",6,5)
		AddNumText(sceneId,x002097_g_ScriptId,"重洗武魂技能",6,6)
		AddNumText(sceneId,x002097_g_ScriptId,"武魂技能升级",6,7)
		AddNumText(sceneId,x002097_g_ScriptId,"武魂说明",11,8)
		
		for i, Deliveryidx in x002097_g_DeliveryList do
			CallScriptFunction( x002097_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002097_OnDefaultEvent( sceneId, selfId,targetId )
	x002097_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x002097_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i,Deliveryidx in x002097_g_DeliveryList do
		if eventId == x002097_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, findId in x002097_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	if GetNumText() == 1 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,2)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090721)
	elseif GetNumText() == 2 then 
	    BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,4)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090721)
	elseif GetNumText() == 3 then 
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,1)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090721)
	elseif GetNumText() == 4 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,1)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090720 )
	elseif GetNumText() == 5 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,1)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090722)
	elseif GetNumText() == 6 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,2)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090722)
	elseif GetNumText() == 7 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090723)
	elseif GetNumText() == 8 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂背景介绍",11,9)
			AddNumText(sceneId,x002097_g_ScriptId,"怎样获得武魂及相关道具",11,10)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂升级介绍",11,11)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂合成等级介绍",11,12)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂拓展属性介绍",11,13)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂技能介绍",11,14)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂属相介绍",11,15)
			AddNumText(sceneId,x002097_g_ScriptId,"武魂的寿命",11,16)
			AddNumText(sceneId,x002097_g_ScriptId,"返回上一页",8,17)
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 9 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090820_01}" )
		--AddNumText(sceneId,x002097_g_ScriptId,"返回上一页",8,18)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 10 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_59}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 11 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_45}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 12 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_46}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 13 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_47}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 14 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_48}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 15 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_49}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 16 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090820_02}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 17 then
		x002097_UpdateEventList( sceneId, selfId,targetId )
	elseif GetNumText() == 18 then
		
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x002097_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x002097_g_DeliveryList do
		if missionScriptId == x002097_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x002097_g_eventList do
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
function x002097_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002097_g_eventList do
		if missionScriptId == findId then
			x002097_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002097_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x002097_g_DeliveryList do
		if missionScriptId == x002097_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x002097_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002097_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x002097_g_DeliveryList do
		if missionScriptId == x002097_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x002097_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end
--**********************************
--死亡事件
--**********************************
function x002097_OnDie( sceneId, selfId, killerId )
end
--**********************************
-- --对话窗口信息提示
--**********************************
function x002097_NotifyFailBox( sceneId, selfId,  msg )
	BeginEvent(sceneId)
	AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)

end