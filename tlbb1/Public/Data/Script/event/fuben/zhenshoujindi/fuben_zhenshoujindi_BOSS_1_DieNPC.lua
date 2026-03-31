--青丘-BOSS1死后处理脚本

--**********************************
--事件列表
--**********************************
function x893034_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{ZSFB_20220105_57}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893034_OnDefaultEvent( sceneId, selfId,targetId )
	x893034_UpdateEventList( sceneId, selfId, targetId )
end

