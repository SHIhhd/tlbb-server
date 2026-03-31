--庄云饰

--脚本号
x893341_g_ScriptId = 893341

--**********************************
--事件交互入口
--**********************************
function x893341_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{HSWQ_20220607_20}")
		AddNumText(sceneId,x893341_g_ScriptId,"#{HSWQ_20220607_21}",6,1)
		AddNumText(sceneId,x893341_g_ScriptId,"#{HSWQ_20220607_22}",11,2)	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x893341_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 89334001 )
		return
	end
	if GetNumText() == 2 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x893341_g_ScriptId,"#{HSWQ_20220607_40}",11,100)
			AddNumText(sceneId,x893341_g_ScriptId,"#{HSWQ_20220607_41}",11,101)	
			AddNumText(sceneId,x893341_g_ScriptId,"#{HSWQ_20220607_42}",8,102)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 100 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{HSWQ_20220607_43}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 101 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{HSWQ_20220607_44}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 102 then
		x893341_OnDefaultEvent( sceneId, selfId,targetId )
		return
	end
end

--**********************************
--醒目提示
--**********************************
function x893341_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
