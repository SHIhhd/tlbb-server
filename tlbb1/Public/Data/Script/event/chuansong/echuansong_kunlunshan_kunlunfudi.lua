--玩家进入一个 area 时触发
x400158_g_ScriptId = 400158
x400158_left=20.0000
x400158_top=228.0000

x400158_right=23.0000
x400158_bottom=232.0000

function x400158_OnEnterArea( sceneId, selfId )
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, x400158_g_ScriptId);
		UICommand_AddString(sceneId, "GoToKunLunFuDi");
		UICommand_AddString(sceneId, "昆仑福地为不加杀气场景，请注意安全。你确定要进入吗？");
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x400158_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个 area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5秒后仍未传送
	if StandingTime >= 5000 then
		x400158_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开一个 area 时触发
function x400158_OnLeaveArea( sceneId, selfId )
end

--**********************************
--任务入口函数
--**********************************
function x400158_GoToKunLunFuDi( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	
	-- 检查玩家是不是还在这个范围内
	if sceneId ~= 433 then
		--你已经不在可传送区域。
		BeginEvent(sceneId)
			AddText(sceneId,"你已经不在可传送区域。")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local targetX, targetZ = GetWorldPos(sceneId, selfId)
	
	if 	targetX < x400158_left or
			targetX > x400158_right or
			targetZ < x400158_top  or
			targetZ > x400158_bottom   then
		
		BeginEvent(sceneId)
			AddText(sceneId,"你已经不在可传送区域。")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
			
	end
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 434,95,36,90)
end
