--脚本号
x001223_g_ScriptId = 001223
--**********************************
--事件列表
--**********************************
function x001223_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{KLS_090604_07}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001223_OnDefaultEvent( sceneId, selfId,targetId )
	x001223_UpdateEventList( sceneId, selfId, targetId )
end
