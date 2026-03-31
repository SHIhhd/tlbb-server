--脚本号
x001226_g_ScriptId = 001226
--**********************************
--事件列表
--**********************************
function x001226_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{KLS_090604_03}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001226_OnDefaultEvent( sceneId, selfId,targetId )
	x001226_UpdateEventList( sceneId, selfId, targetId )
end
