--萧峰心魔NPC交互

--脚本号
x998461_g_scriptId = 998461
x998461_g_LimitMembers = 7
x998461_g_TestMode = 0
--**********************************
--事件列表
--**********************************
function x998461_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{YMMJ_230626_119}")
		AddNumText( sceneId, x998461_g_scriptId, "#{YMMJ_230626_78}", 10 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x998461_OnDefaultEvent( sceneId, selfId,targetId )
	x998461_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998461_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "萧峰心魔"  then
			return
		end
		if GetLevel(sceneId,selfId) < 65 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_79}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if x998461_g_TestMode ~= 1 and LuaFnHasRaid(sceneId,selfId) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_80}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_120}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if x998461_g_TestMode ~= 1 and LuaFnIsRaidLeader( sceneId, selfId)==0 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_82}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_121}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--团队尺寸是否足够
		if x998461_g_TestMode ~= 1 and LuaFnGetRaidSize(sceneId,selfId) < x998461_g_LimitMembers then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_84}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_122}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--是否都在附近....
		if x998461_g_TestMode ~= 1 and LuaFnGetRaidSize(sceneId,selfId) ~= LuaFnGetNearRaidCount(sceneId,selfId) then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_84}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_122}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		-- 关闭界面
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		-- 生成萧峰心魔BOSS 
		SetCharacterDieTime(sceneId,targetId,100)
		CallScriptFunction(998445,"CreateMonsterXiaoFengBoss",sceneId)
		return
	end
end
--**********************************
--玩家进入一个 area 时触发
--**********************************
function x998461_OnEnterArea( sceneId, selfId )

end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发
--**********************************
function x998461_OnTimer( sceneId, selfId )
end
--**********************************
--玩家离开一个 area 时触发
--**********************************
function x998461_OnLeaveArea( sceneId, selfId )
end

