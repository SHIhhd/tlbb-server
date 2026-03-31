--欧冶菡

--脚本号
x888816_g_ScriptId = 888816

--**********************************
--事件交互入口
--**********************************
function x888816_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SBFW_20230707_255}")
		AddNumText(sceneId,x888816_g_ScriptId,"#{SBFW_20230707_26}",6,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x888816_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_3}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881205 )
		return
	end
end

--**********************************
--醒目提示
--**********************************
function x888816_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
