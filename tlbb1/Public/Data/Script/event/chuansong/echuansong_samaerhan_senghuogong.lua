--玩家进入一个 area 时触发
x400978_g_ScriptId = 400978
x400978_left 	=69.0000
x400978_right	=74.0000

x400978_top  	=29.0000
x400978_bottom	=32.0000
function x400978_OnEnterArea( sceneId, selfId )
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x400978_g_ScriptId);
		UICommand_AddString(sceneId, "GoToShengHuoGong");
		UICommand_AddString(sceneId, "#{QZDZCS_100730}");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x400978_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个 area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5秒后仍未传送
	if StandingTime >= 5000 then
		x400978_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开一个 area 时触发
function x400978_OnLeaveArea( sceneId, selfId )
end

function x400978_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--任务入口函数
--**********************************
function x400978_GoToShengHuoGong( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	
	-- 检查玩家是不是还在这个范围内
	if sceneId ~= 201 then
		x400978_NotifyFailTips(sceneId,selfId,"你已经不在可传送区域。")
		return
	end
	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x400978_left or
			targetX > x400978_right or
			targetZ < x400978_top  or
			targetZ > x400978_bottom   then
		x400978_NotifyFailTips(sceneId,selfId,"你已经不在可传送区域。")
		return
	end
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 202,25,102,90)
end
