--脚本号
x001258_g_ScriptId = 001258
--**********************************
--事件列表
--**********************************
function x001258_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SMEH_100222_9}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001258_OnDefaultEvent( sceneId, selfId,targetId )
	x001258_UpdateEventList( sceneId, selfId, targetId )
end
