--甄百岁

x890244_g_ScriptId	= 890244
--**********************************
--事件交互入口
--**********************************
function x890244_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{CJGH_221223_17}" )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x890244_OnEventRequest( sceneId, selfId, targetId, eventId )

end
--**********************************
--对话窗口信息提示
--**********************************
function x890244_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
