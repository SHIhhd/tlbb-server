--带头大哥NPC交互

--脚本号
x998455_g_scriptId = 998455
x998455_g_LimitMembers = 3
x998455_g_LimitMembersMax = 7
x998455_g_NpcTalkActive = 0
x998455_g_TestMode = 0
--**********************************
--事件列表
--**********************************
function x998455_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{YMMJ_230626_99}")
		AddNumText( sceneId, x998455_g_scriptId, "#{YMMJ_230626_78}", 10 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x998455_OnDefaultEvent( sceneId, selfId,targetId )
	x998455_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998455_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "带头大哥"  then
			return
		end
		if GetLevel(sceneId,selfId) < 65 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_79}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if x998455_g_TestMode ~= 1 and LuaFnHasRaid(sceneId,selfId) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_80}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_100}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--是否都在附近....
		if x998455_g_TestMode ~= 1 and LuaFnGetNearRaidCount(sceneId,selfId) < x998455_g_LimitMembers then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_102}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_103}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--不能都在附近，兄弟BOSS也要有人
		if x998455_g_TestMode ~= 1 and LuaFnGetNearRaidCount(sceneId,selfId) >= x998455_g_LimitMembersMax then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_104}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_105}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		-- 关闭界面
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		-- 生成带头大哥BOSS 
		SetCharacterDieTime(sceneId,targetId,100)
		CallScriptFunction(998445,"CreateMonsterDaitoudageBoss",sceneId)
		return
	end
end
--**********************************
--玩家进入一个 area 时触发
--**********************************
function x998455_OnEnterArea( sceneId, selfId )
	--感慨
	if LuaFnGetNpcIntParameter(sceneId,selfId,x998455_g_NpcTalkActive) ~= 1 then
		LuaFnNpcTalk(sceneId,281)
		LuaFnSetNpcIntParameter(sceneId,selfId,x998455_g_NpcTalkActive,1)
	end
end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发
--**********************************
function x998455_OnTimer( sceneId, selfId )
end
--**********************************
--玩家离开一个 area 时触发
--**********************************
function x998455_OnLeaveArea( sceneId, selfId )
end

