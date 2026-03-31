--欧冶画

--脚本号
x888814_g_ScriptId = 888814

--**********************************
--事件交互入口
--**********************************
function x888814_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SBFW_20230707_234}")
		AddNumText(sceneId,x888814_g_ScriptId,"#{SBFW_20230707_27}",6,1)
		AddNumText(sceneId,x888814_g_ScriptId,"#{SBFW_20230707_210}",6,2)
		AddNumText(sceneId,x888814_g_ScriptId,"#{SBFW_20230707_28}",6,3)
		
		AddNumText(sceneId,x888814_g_ScriptId,"#{SBFW_20230707_30}",11,100)	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x888814_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_3}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881501 )
		return
	end
	if GetNumText() == 2 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_3}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881503 )
		return
	end
	if GetNumText() == 3 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_3}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881502 )
		return
	end
	if GetNumText() == 100 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SBFW_20230707_32}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end

--**********************************
--醒目提示
--**********************************
function x888814_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
