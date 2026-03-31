--脚本号
x001221_g_ScriptId = 001221
--**********************************
--事件列表
--**********************************
function x001221_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{KLS_090604_06}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001221_OnDefaultEvent( sceneId, selfId,targetId )
	x001221_UpdateEventList( sceneId, selfId, targetId )
end
