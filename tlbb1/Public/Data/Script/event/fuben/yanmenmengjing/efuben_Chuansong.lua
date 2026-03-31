--雁关·无间度厄 传送NPC
--脚本号
x998465_g_ScriptId	= 998465

--**********************************
--入口函数
--**********************************
function x998465_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText( sceneId,"#{YMMJ_230626_98}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x998465_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end
--**********************************
--屏幕中央提示
--**********************************
function x998465_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框提示
--**********************************
function x998465_MsgBox( sceneId, selfId,targetId,Msg )
	BeginEvent(sceneId)
		AddText(sceneId,Msg)
	EndEvent()
	DispatchEventList(sceneId, selfId, targetId)
end

