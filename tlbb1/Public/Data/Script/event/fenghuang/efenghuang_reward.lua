--凤凰古城 奖励组件

x403002_g_ScriptId	= 403002

--**********************************
--屏幕中间信息提示
--**********************************
function x403002_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403002_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


