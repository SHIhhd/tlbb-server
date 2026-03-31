--青丘-云卷舒交互脚本

--脚本号
x893022_g_scriptId = 893022
x893022_g_CopyMainScriptId = 893020
x893022_g_LimitMembers= 1			--可以进副本的最小队伍人数
x893022_g_SceneData_MainStep = 8   	--当前的逻辑批次

--**********************************
--事件列表
--**********************************
function x893022_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		
		local nCurStep = LuaFnGetCopySceneData_Param(sceneId, 8);
		if nCurStep == 6 then
			AddText(sceneId, "#{ZSFB_20220105_48}")
			AddNumText( sceneId, x893022_g_scriptId, "#{ZSFB_20220105_49}", 10 ,1  )
		else
			AddText(sceneId, "#{ZSFB_20220105_57}")
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893022_OnDefaultEvent( sceneId, selfId,targetId )
	x893022_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893022_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "云卷舒"  then
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_50}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if LuaFnHasTeam(sceneId,selfId) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_51}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_52}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnIsTeamLeader( sceneId, selfId)==0 then	--只有队长才能接任务
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_53}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_54}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--队伍尺寸是否足够
		if GetTeamSize(sceneId,selfId) < x893022_g_LimitMembers then
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
		local nCurStep = LuaFnGetCopySceneData_Param(sceneId, 8);
		if nCurStep == 6 then
			--切换为BOSS
			CallScriptFunction(x893022_g_CopyMainScriptId, "CreateMonster_BOSS_1_BOSS",sceneId)
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
function x893022_OnEnterArea( sceneId, selfId )
	local nCurMainStep = LuaFnGetCopySceneData_Param(sceneId, x893022_g_SceneData_MainStep)
	if nCurMainStep == 5 then
		--云卷舒的挑衅
		LuaFnNpcTalk(sceneId,125)
		--进入下一个阶段
		LuaFnSetCopySceneData_Param(sceneId, x893022_g_SceneData_MainStep,6)
	end
end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发
--**********************************
function x893022_OnTimer( sceneId, selfId )
end
--**********************************
--玩家离开一个 area 时触发
--**********************************
function x893022_OnLeaveArea( sceneId, selfId )
end

