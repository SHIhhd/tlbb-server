--花照水

--**********************************
--事件交互入口
--**********************************
function x893291_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_86}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
