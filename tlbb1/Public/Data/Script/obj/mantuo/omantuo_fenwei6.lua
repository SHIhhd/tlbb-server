--花照水

--**********************************
--事件交互入口
--**********************************
function x893290_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_85}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
