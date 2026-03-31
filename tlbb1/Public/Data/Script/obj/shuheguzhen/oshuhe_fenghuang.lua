--束河古镇NPC....
--凤凰古城入口NPC 李野....
x001218_g_scriptId = 001218

--**********************************
--事件交互入口
--**********************************
function x001218_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{FHZD_090708_37}")
		AddNumText(sceneId,x001218_g_scriptId,"#{FHZD_XML_13}", 9, 1 )
		AddNumText(sceneId,x001218_g_scriptId,"#{FHZD_XML_33}", 11, 2 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x001218_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumText = GetNumText()
	if nNumText == 1 then
		CallScriptFunction((403003), "GoToPhoenixPlain",sceneId, selfId, targetId)
		return
	elseif nNumText == 2 then
		x001218_MsgBox(sceneId,selfId,targetId,"#{FHZD_090708_86}")
	end
end
--**********************************
--屏幕中间信息提示
--**********************************
function x001218_NotifyTips(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x001218_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end