--青丘-逸交互脚本

--脚本号
x893025_g_scriptId = 893025
x893025_g_CopyMainScriptId = 893020
x893025_g_LimitMembers= 1			--可以进副本的最小队伍人数
x893025_g_SceneData_MainStep = 8   	--当前的逻辑批次
--**********************************
--事件列表
--**********************************
function x893025_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nCurStep = LuaFnGetCopySceneData_Param(sceneId, x893025_g_SceneData_MainStep);
		AddText(sceneId, "#{ZSFB_20220105_61}")
		if nCurStep == 11 then
			AddNumText( sceneId, x893025_g_scriptId, "#{ZSFB_20220105_62}", 10 ,1  )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893025_OnDefaultEvent( sceneId, selfId,targetId )
	x893025_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893025_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "逸"  then
			return
		end
		--ZSFB_20220105_63	#H您尚未战胜云卷舒并完成勇气试炼，无法开启谋略试炼。
		if GetLevel(sceneId,selfId) < 85 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_50}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if LuaFnHasTeam(sceneId,selfId) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_65}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnIsTeamLeader( sceneId, selfId)==0 then	--只有队长才能接任务
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_66}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--队伍尺寸是否足够
		if GetTeamSize(sceneId,selfId) < x893025_g_LimitMembers then
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_67}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--是否都在附近....
		local NearTeamSize = GetNearTeamCount(sceneId,selfId)
		if GetTeamSize(sceneId,selfId) ~= NearTeamSize then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_55}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_56}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--逻辑ID不要乱改
		local nCurStep = LuaFnGetCopySceneData_Param(sceneId, x893025_g_SceneData_MainStep);
		if nCurStep == 11 then
			--切换为BOSS
			CallScriptFunction(x893025_g_CopyMainScriptId, "CreateMonster_BOSS_2_BOSS",sceneId)
		end

		-- 关闭界面
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		
		return
	end
end
--**********************************
--玩家进入一个 area 时触发
--**********************************
function x893025_OnEnterArea( sceneId, selfId )
	local nCurMainStep = LuaFnGetCopySceneData_Param(sceneId, x893025_g_SceneData_MainStep)
	if nCurMainStep == 8 then
		--逸的挑衅
		LuaFnNpcTalk(sceneId,126)
		--进入置空
		LuaFnSetCopySceneData_Param(sceneId, x893025_g_SceneData_MainStep,9)
	end
end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发
--**********************************
function x893025_OnTimer( sceneId, selfId )
end
--**********************************
--玩家离开一个 area 时触发
--**********************************
function x893025_OnLeaveArea( sceneId, selfId )
end
