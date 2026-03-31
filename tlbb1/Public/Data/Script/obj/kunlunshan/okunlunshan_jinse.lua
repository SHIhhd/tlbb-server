--脚本号
x001220_g_ScriptId = 001220
--**********************************
--事件列表
--**********************************
function x001220_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{KLS_090604_04}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001220_OnDefaultEvent( sceneId, selfId,targetId )
	x001220_UpdateEventList( sceneId, selfId, targetId )
end
