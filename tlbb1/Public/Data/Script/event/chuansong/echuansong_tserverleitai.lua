x890035_g_ChallengeScriptId = 890025

--**********************************
-- 玩家进入传送点
--**********************************
function x890035_OnEnterArea( sceneId, selfId )
	CallScriptFunction(x890035_g_ChallengeScriptId, "LeaveScene", sceneId, selfId )
end
--**********************************
-- 玩家停留在传送点
--**********************************
function x890035_OnTimer( sceneId, selfId )
	return
end
--**********************************
-- 玩家离开传送点
--**********************************
function x890035_OnLeaveArea( sceneId, selfId )
	return
end

