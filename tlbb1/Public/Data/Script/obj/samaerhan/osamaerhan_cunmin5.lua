--脚本号
x001262_g_ScriptId = 001262
--**********************************
--事件列表
--**********************************
function x001262_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SMEH_100222_13}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001262_OnDefaultEvent( sceneId, selfId,targetId )
	x001262_UpdateEventList( sceneId, selfId, targetId )
end
