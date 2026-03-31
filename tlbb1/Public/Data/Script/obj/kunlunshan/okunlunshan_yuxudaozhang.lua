--脚本号
x001227_g_ScriptId = 001227
--**********************************
--事件列表
--**********************************
function x001227_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{KLS_090604_02}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001227_OnDefaultEvent( sceneId, selfId,targetId )
	x001227_UpdateEventList( sceneId, selfId, targetId )
end
