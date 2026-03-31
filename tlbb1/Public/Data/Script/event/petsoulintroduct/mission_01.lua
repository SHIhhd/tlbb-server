--MisDescBegin
--脚本号
x893040_g_ScriptId = 893040

--完成任务NPC属性
x893040_g_Position_X=89
x893040_g_Position_Z=139
x893040_g_SceneID=1
x893040_g_AccomplishNPC_Name="云深深"

--任务号
x893040_g_MissionId = 2060

--任务归类
x893040_g_MissionKind = 9

--任务等级
x893040_g_MissionLevel = 85 --10000

--是否是精英任务
x893040_g_IfMissionElite = 0

--任务名
x893040_g_MissionName="#{SHYD_20211227_25}"
x893040_g_MissionTarget="#{SHYD_20211227_26}"
x893040_g_IsMissionOkFail=0
x893040_g_Custom = {{ id = "已拜访云飘飘", num = 1}, { id = "已拜访云深深", num = 1}}
x893040_g_ContinueInfo = ""
x893040_g_MissionComplete = "#{SHYD_20211227_29}"

x893040_g_MoneyJZBonus = 10000
x893040_g_ExpBonus = 80000

--MisDescEnd
x893040_g_Name = "云飘飘"
--**********************************
--任务入口函数
--**********************************
function x893040_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x893040_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x893040_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x893040_g_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_441}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			
			local misIndex = GetMissionIndexByID( sceneId, selfId, x893040_g_MissionId )	
			SetMissionByIndex( sceneId, selfId, misIndex, x893040_g_IsMissionOkFail,1 )
		elseif GetName(sceneId,targetId) == x893040_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_25}")
				AddText(sceneId,"#{SHYD_20211227_29}")
				AddMoneyJZBonus( sceneId, x893040_g_MoneyJZBonus )
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x893040_g_ScriptId,x893040_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893040_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893040_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893040_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x893040_g_Name or GetName(sceneId,targetId) == x893040_g_AccomplishNPC_Name then
			AddNumText(sceneId, x893040_g_ScriptId,"#G"..x893040_g_MissionName,2,-1);
		end
	--满足任务接收条件
--	elseif x893040_CheckAccept(sceneId,selfId) > 0 then
--		if GetName(sceneId,targetId) == x893040_g_AccomplishNPC_Name then
--			AddNumText(sceneId,x893040_g_ScriptId,"#G"..x893040_g_MissionName,1,-1);
--		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x893040_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893040_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893040_g_MissionLevel then
		return 0
	end
	
	return 1
end
--**********************************
--接受
--**********************************
function x893040_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--放弃
--**********************************
function x893040_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893040_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893040_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893040_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x893040_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893040_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893040_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x893040_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnAddExp( sceneId, selfId, x893040_g_ExpBonus)
		DelMission( sceneId, selfId, x893040_g_MissionId )
		MissionCom( sceneId, selfId, x893040_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_46}",x893040_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--关闭入口
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 8930400)
--		下一阶段任务
		CallScriptFunction(893041,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893040_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x893040_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893040_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--客户端呼出主UI
--**********************************
function x893040_OpenUI( sceneId, selfId, opType)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x893040_g_MissionLevel then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SHYD_20211227_04}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x893040_g_MissionId) > 0 then
		--关闭入口UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 8930400)
		--关闭UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 3);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 8930401)
		return
	end
	if opType == 2 then
		-- 没有任务的话需要接取
		if IsHaveMission(sceneId,selfId,x893040_g_MissionId) <= 0 then
			--加入任务到玩家列表
			local ret = AddMission(sceneId,selfId, x893040_g_MissionId, x893040_g_ScriptId, 0, 0, 0)
			if ret <= 0 then
				BeginEvent(sceneId)
					AddText(sceneId, "#{TFYD_210729_04}")
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--成功接取任务
			BeginEvent(sceneId)
				AddText(sceneId, "#{SHYD_20211227_22}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	end
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, opType);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 8930401)
end
--**********************************
--玩家登录
--**********************************
function x893040_OnHumanLogin( sceneId, selfId)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x893040_g_MissionLevel then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 8930400)
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x893040_g_MissionId) > 0 then
	    BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 8930400)
		return
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 1);
		UICommand_AddInt(sceneId, 1);	--show anmite
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 8930400)
end
