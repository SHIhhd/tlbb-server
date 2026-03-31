--凤凰古城入口控制

x403001_g_ScriptId	= 403001

--**********************************
--屏幕中间信息提示
--**********************************
function x403001_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403001_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


