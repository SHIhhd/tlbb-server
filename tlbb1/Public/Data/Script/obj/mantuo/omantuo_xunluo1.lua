--巡逻 王岚别

--**********************************
--事件交互入口
--**********************************
function x893283_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_81}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
