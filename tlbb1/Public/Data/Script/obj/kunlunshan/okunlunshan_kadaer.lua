--脚本号
x001222_g_ScriptId = 001222
--**********************************
--事件列表
--**********************************
function x001222_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{KLS_090604_01}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001222_OnDefaultEvent( sceneId, selfId,targetId )
	x001222_UpdateEventList( sceneId, selfId, targetId )
end
