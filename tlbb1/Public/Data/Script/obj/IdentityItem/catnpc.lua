--狸奴灵偶npc

x998708_g_ScriptId	= 998708
--**********************************
--事件交互入口
--**********************************
function x998708_OnDefaultEvent( sceneId, selfId,targetId )

end

--**********************************
--事件列表选中一项
--**********************************
function x998708_OnEventRequest( sceneId, selfId, targetId, eventId )

end

--**********************************
--Monster Timer
--**********************************
function x998708_OnCharacterTimer( sceneId, objId, dataId, uTime )
	
end

--**********************************
--屏幕中心信息提示
--**********************************
function x998708_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x998708_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
