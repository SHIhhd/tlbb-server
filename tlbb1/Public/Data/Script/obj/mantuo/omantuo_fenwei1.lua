--苏酥

--**********************************
--事件交互入口
--**********************************
function x893285_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_88}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
