--杨老三

x890236_g_ScriptId	= 890236
--**********************************
--事件交互入口
--**********************************
function x890236_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{CJGH_221223_03}" )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x890236_OnEventRequest( sceneId, selfId, targetId, eventId )

end
--**********************************
--对话窗口信息提示
--**********************************
function x890236_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
