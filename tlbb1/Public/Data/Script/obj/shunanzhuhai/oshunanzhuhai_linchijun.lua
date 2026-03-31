--临池君

x890251_g_ScriptId	= 890251
--**********************************
--事件交互入口
--**********************************
function x890251_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{CJGH_221223_10}" )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x890251_OnEventRequest( sceneId, selfId, targetId, eventId )

end
--**********************************
--对话窗口信息提示
--**********************************
function x890251_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
