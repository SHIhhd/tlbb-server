--曼陀山庄NPC
--玩家进入一个 area 时触发
function x893295_OnEnterArea( sceneId, selfId )
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, SCENE_MANTUOSHANZHUANG,136,180)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x893295_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个 area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5秒后仍未传送
	if StandingTime >= 5000 then
		x893295_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开一个 area 时触发
function x893295_OnLeaveArea( sceneId, selfId )
end
