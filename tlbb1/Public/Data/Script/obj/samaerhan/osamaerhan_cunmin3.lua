--脚本号
x001260_g_ScriptId = 001260
--**********************************
--事件列表
--**********************************
function x001260_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SMEH_100222_11}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001260_OnDefaultEvent( sceneId, selfId,targetId )
	x001260_UpdateEventList( sceneId, selfId, targetId )
end
