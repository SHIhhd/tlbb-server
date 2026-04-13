--MisDescBegin
--脚本号
x890154_g_ScriptId = 890154

--任务号
x890154_g_MissionId = 2161

--交任务npc
x890154_g_Position_X=63--完成任务NPC属性
x890154_g_Position_Z=53
x890154_g_SceneID=1292
x890154_g_AccomplishNPC_Name="墨知愁"

--任务归类
x890154_g_MissionKind = 9

--任务等级
x890154_g_MissionLevel = 85

--是否是精英任务
x890154_g_IfMissionElite = 0

--任务名
x890154_g_MissionName="#{ZXJQ_221225_10}"
x890154_g_MissionTarget="#{ZXJQ_221225_13}"
x890154_g_IsMissionOkFail=0
x890154_g_Custom = {{ id = "前往白溪湖墨知愁处详谈", num = 1}}
x890154_g_ContinueInfo = ""
x890154_g_MissionComplete = ""

--MisDescEnd
x890154_g_ExpBonus = 1000000
--**********************************
--任务入口函数
--**********************************
function x890154_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x890154_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x890154_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x890154_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_52}")
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x890154_g_ScriptId,x890154_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x890154_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890154_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890154_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x890154_g_AccomplishNPC_Name then
			AddNumText(sceneId, x890154_g_ScriptId,x890154_g_MissionName,2,-1);
		end
	--满足任务接收条件
--	elseif x890154_CheckAccept(sceneId,selfId) > 0 then
--		if GetName(sceneId,targetId) == x890154_g_AccomplishNPC_Name then
--			AddNumText(sceneId,x890154_g_ScriptId,"#G"..x890154_g_MissionName,1,-1);
--		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x890154_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890154_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890154_g_MissionLevel then
		return 0
	end
	
	return 1
end
--**********************************
--接受
--**********************************
function x890154_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--放弃
--**********************************
function x890154_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890154_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890154_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890154_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x890154_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890154_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		LuaFnAddExp( sceneId, selfId, x890154_g_ExpBonus)
		DelMission( sceneId, selfId, x890154_g_MissionId )
		MissionCom( sceneId, selfId, x890154_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890154_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
--		下一阶段任务
		CallScriptFunction(890155,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890154_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890154_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890154_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--请求接取任务并到NPC处
--**********************************
function x890154_GotoFindNpc( sceneId, selfId)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x890154_g_MissionLevel then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_05}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x890154_g_MissionId) > 0 then
		--关闭按钮，不应该调用
		LuaFnUpdateQuickEnter(sceneId,selfId,10,0);
		--关闭UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 3);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89015401)
		return
	end
	-- 没有任务的话需要接取
	if IsHaveMission(sceneId,selfId,x890154_g_MissionId) <= 0 then
		--加入任务到玩家列表
		local ret = AddMission(sceneId,selfId, x890154_g_MissionId, x890154_g_ScriptId, 0, 0, 0)
		if ret <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_50}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_219}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--成功接取任务
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890154_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	--关闭按钮
	LuaFnUpdateQuickEnter(sceneId,selfId,10,0);
	--自动寻路到目标
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 2);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89015401)
end
--**********************************
--玩家登录
--**********************************
function x890154_OnHumanLogin( sceneId, selfId)
	--特殊生活技能补充【周常任务用】
	if QueryHumanAbilityLevel(sceneId, selfId, ABILITY_CAIJI_SHILI) < 1 then
		SetHumanAbilityLevel(sceneId,selfId,ABILITY_CAIJI_SHILI,1)
	end
	if QueryHumanAbilityLevel(sceneId, selfId, ABILITY_CAIJI_MISSION) < 1 then
		SetHumanAbilityLevel(sceneId,selfId,ABILITY_CAIJI_MISSION,1)
	end
	
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x890154_g_MissionLevel then
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x890154_g_MissionId) > 0 then
		return
	end
	LuaFnUpdateQuickEnter(sceneId,selfId,10,1);
end
--**********************************
--客户端UI逻辑
--**********************************
function x890154_UILogic( sceneId, selfId,nOp)
	if nOp == 1 then
		--等级等前置检查
		if GetLevel(sceneId,selfId) < x890154_g_MissionLevel then
			--关闭按钮，不应该调用
			LuaFnUpdateQuickEnter(sceneId,selfId,10,0);
			return
		end
		--前置任务完成了
		if IsMissionHaveDone(sceneId,selfId,x890154_g_MissionId) > 0 then
			--关闭按钮，不应该调用
			LuaFnUpdateQuickEnter(sceneId,selfId,10,0);
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 1);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89015401)
		return
	end
end
