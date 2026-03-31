--玄武岛镜 荒兽脚本【作废】
x893083_g_scriptId=893083
--**********************************
--事件交互入口
--**********************************
function x893083_OnDefaultEvent( sceneId, selfId, targetId )

end
--**********************************
--荒兽死亡
--**********************************
function x893083_OnDie(sceneId, MonsterId, killerId)
	
end

--**********************************
-- 醒目失败提示
--**********************************
function x893083_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

