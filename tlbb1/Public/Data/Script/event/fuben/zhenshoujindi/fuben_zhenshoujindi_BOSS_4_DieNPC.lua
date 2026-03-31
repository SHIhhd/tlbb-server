--青丘-BOSS4死后处理脚本
--lanna

--**********************************
--事件列表
--**********************************
function x893037_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{ZSFB_20220105_90}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893037_OnDefaultEvent( sceneId, selfId,targetId )
	x893037_UpdateEventList( sceneId, selfId, targetId )
end

