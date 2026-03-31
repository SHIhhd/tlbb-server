--青丘-云飘飘交互脚本

--脚本号
x893031_g_scriptId = 893031
x893031_g_CopyMainScriptId = 893020
x893031_g_LimitMembers= 1			--可以进副本的最小队伍人数
x893031_g_SceneData_MainStep = 8   	--当前的逻辑批次

--**********************************
--事件列表
--**********************************
function x893031_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{ZSFB_20220105_82}")
		local nCurStep = LuaFnGetCopySceneData_Param(sceneId, x893031_g_SceneData_MainStep);
		if nCurStep >=18 or nCurStep <= 20 then
			AddNumText( sceneId, x893031_g_scriptId, "#{ZSFB_20220105_83}", 10 ,1  )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893031_OnDefaultEvent( sceneId, selfId,targetId )
	x893031_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893031_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "云飘飘"  then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_85}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		--ZSFB_20220105_63	#H您尚未战胜云卷舒并完成勇气试炼，无法开启谋略试炼。
		if GetLevel(sceneId,selfId) < 85 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_85}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if LuaFnHasTeam(sceneId,selfId) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_86}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnIsTeamLeader( sceneId, selfId)==0 then	--只有队长才能接任务
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_87}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--队伍尺寸是否足够
		if GetTeamSize(sceneId,selfId) < x893031_g_LimitMembers then
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_88}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--是否都在附近....
		local NearTeamSize = GetNearTeamCount(sceneId,selfId)
		if GetTeamSize(sceneId,selfId) ~= NearTeamSize then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_88}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		--逻辑ID不要乱改
		local nCurStep = LuaFnGetCopySceneData_Param(sceneId, x893031_g_SceneData_MainStep);
		if nCurStep >=18 or nCurStep <= 20 then
			--切换为BOSS
			CallScriptFunction(x893031_g_CopyMainScriptId, "ActiveBOSSYunPiaoPiao",sceneId)
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
function x893031_OnEnterArea( sceneId, selfId )
	local nCurMainStep = LuaFnGetCopySceneData_Param(sceneId, x893031_g_SceneData_MainStep)
	if nCurMainStep == 16 then
		--进入下一个阶段
		LuaFnSetCopySceneData_Param(sceneId, x893031_g_SceneData_MainStep,17)
	end
end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发
--**********************************
function x893031_OnTimer( sceneId, selfId )
end
--**********************************
--玩家离开一个 area 时触发
--**********************************
function x893031_OnLeaveArea( sceneId, selfId )
end
