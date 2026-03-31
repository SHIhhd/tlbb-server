--坐骑介绍 子今

--**********************************
--事件交互入口
--**********************************
function x893270_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_20}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
