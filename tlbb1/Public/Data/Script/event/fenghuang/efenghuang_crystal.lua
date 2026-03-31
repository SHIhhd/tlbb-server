--凤凰古城 水晶

x403006_g_ScriptId	= 403006

--**********************************
--屏幕中间信息提示
--**********************************
function x403006_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403006_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


