--苏州NPC
--安以轩

--**********************************
--事件交互入口
--**********************************
function x001091_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{AYX_100401_1}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
