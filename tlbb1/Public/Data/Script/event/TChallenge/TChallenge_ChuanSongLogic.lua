-- 跨服擂台相关脚本

x890024_g_ScriptId = 890024
x890024_g_MinLevel = 60

--**********************************
--任务入口函数
--**********************************
function x890024_OnDefaultEvent( sceneId, selfId, targetId ,op)
	if op == 61 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{TFXC_20220921_11}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif op == 60 then
		--传送至跨服校场休息室
		--96,104
		if GetLevel(sceneId,selfId) < x890024_g_MinLevel then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_12}")
			return
		end
		--TFXC_20220921_04	#H请退出队伍后，再进行此操作。
		if GetTeamId(sceneId,selfId)>=0 then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_04}")
			return
		end
		--TFXC_20220921_05	#H处于跑商状态，无法进行此操作。	
		if GetItemCount(sceneId, selfId, 40002000) >= 1 then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_05}")
			return
		end
		--是否在漕运
		local haveImpact = LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113)
		if haveImpact == 1 then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_06}")
			return
		end
		if LuaFnIsStalling( sceneId, selfId ) == 1 then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_07}")
			return
		end
		if LuaFnGetDRideFlag(sceneId, selfId) == 1 then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_08}")
			return
		end
		if LuaFnIsCharacterLiving(sceneId,selfId) ~= 1 then
			x890024_NotifyTip(sceneId,selfId,"#{TFXC_20220921_09}")
			return
		end
		--尝试传送到跨服校场
		NewWorld(sceneId,selfId,SCENE_TCHALLENGE,96,104)
	end
end

--**********************************
--列举事件
--**********************************
function x890024_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x890024_g_ScriptId,"#{TFXC_20220921_01}", 9,60)
	AddNumText(sceneId,x890024_g_ScriptId,"#{TFXC_20220921_02}", 11,61)
	return
end

--**********************************
--检测接受条件
--**********************************
function x890024_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x890024_OnAccept( sceneId, selfId )
end

--**********************************
-- 玩家个人全屏提示
--**********************************
function x890024_NotifyTip(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
