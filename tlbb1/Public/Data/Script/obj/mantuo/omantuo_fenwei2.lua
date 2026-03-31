--王易简

--**********************************
--事件交互入口
--**********************************
function x893286_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_91}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
