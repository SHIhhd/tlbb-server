--汪剑通NPC交互

--脚本号
x998451_g_scriptId = 998451
x998451_g_LimitMembers = 7
x998451_g_MonsterAi = 998448
x998451_g_NpcTalkActive = 0
x998451_g_TestMode = 0
--**********************************
--事件列表
--**********************************
function x998451_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{YMMJ_230626_90}")
		AddNumText( sceneId, x998451_g_scriptId, "#{YMMJ_230626_78}", 10 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x998451_OnDefaultEvent( sceneId, selfId,targetId )
	x998451_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998451_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "汪剑通"  then
			return
		end
		if GetLevel(sceneId,selfId) < 65 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_79}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if x998451_g_TestMode ~= 1 and LuaFnHasRaid(sceneId,selfId) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_80}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_91}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if x998451_g_TestMode ~= 1 and LuaFnIsRaidLeader( sceneId, selfId)==0 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_82}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_92}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--团队尺寸是否足够
		if x998451_g_TestMode ~= 1 and LuaFnGetRaidSize(sceneId,selfId) < x998451_g_LimitMembers then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_84}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_93}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--是否都在附近....
		if x998451_g_TestMode ~= 1 and LuaFnGetRaidSize(sceneId,selfId) ~= LuaFnGetNearRaidCount(sceneId,selfId) then
			BeginEvent( sceneId )
				AddText( sceneId, "#{YMMJ_230626_84}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{YMMJ_230626_93}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		-- 关闭界面
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		-- 生成汪剑通BOSS 
		SetCharacterDieTime(sceneId,targetId,100)
		CallScriptFunction(998445,"CreateMonsterZhaoWangJianTongBoss",sceneId)
		return
	end
end
--**********************************
--玩家进入一个 area 时触发
--**********************************
function x998451_OnEnterArea( sceneId, selfId )
	--感慨
	if LuaFnGetNpcIntParameter(sceneId,selfId,x998451_g_NpcTalkActive) ~= 1 then
		LuaFnNpcTalk(sceneId,228)
		LuaFnSetNpcIntParameter(sceneId,selfId,x998451_g_NpcTalkActive,1)
	end
end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发
--**********************************
function x998451_OnTimer( sceneId, selfId )
end
--**********************************
--玩家离开一个 area 时触发
--**********************************
function x998451_OnLeaveArea( sceneId, selfId )
end

