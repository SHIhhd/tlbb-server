--MisDescBegin
--脚本号
x893045_g_ScriptId = 893045

--完成任务NPC属性
x893045_g_Position_X=135
x893045_g_Position_Z=81
x893045_g_SceneID=1
x893045_g_AccomplishNPC_Name="云兰舟"

--前置任务
x893045_g_PreMissionId = 2064
x893045_g_PreMissionName="#{SHYD_20211227_224}"

--任务号
x893045_g_MissionId = 2065

--任务归类
x893045_g_MissionKind = 9

--任务等级
x893045_g_MissionLevel = 85 --10000

--是否是精英任务
x893045_g_IfMissionElite = 0

--任务名
x893045_g_MissionName="#{SHYD_20211227_251}"
x893045_g_MissionTarget="#{SHYD_20211227_252}"
x893045_g_IsMissionOkFail=0
x893045_g_Custom = {{ id = "已拜访云兰舟", num = 1}}
x893045_g_ContinueInfo = ""
x893045_g_MissionComplete = "#{SHYD_20211227_255}"

x893045_g_MoneyJZBonus = 15000
x893045_g_ExpBonus = 1000000

--MisDescEnd
x893045_g_AcceptNPC_Name="云飘飘"
--**********************************
--任务入口函数
--**********************************
function x893045_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x893045_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893045_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x893045_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x893045_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_255}")
			AddMoneyJZBonus(sceneId,x893045_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x893045_g_ScriptId,x893045_g_MissionId)		
	elseif x893045_CheckAccept( sceneId, selfId ) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x893045_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_242}")
			AddMoneyJZBonus( sceneId,x893045_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x893045_g_ScriptId,x893045_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x893045_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893045_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893045_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x893045_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x893045_g_ScriptId,"#G"..x893045_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x893045_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x893045_g_AcceptNPC_Name then
			AddNumText(sceneId,x893045_g_ScriptId,"#G"..x893045_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x893045_OnAccept(sceneId,selfId,targetId)
	if x893045_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x893045_g_MissionId, x893045_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_249}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHYD_20211227_250}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHYD_20211227_252}")
	EndEvent()
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--检测接受条件
--**********************************
function x893045_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893045_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893045_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x893045_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x893045_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893045_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893045_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893045_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893045_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	
	return 1
end

--**********************************
--提交
--**********************************
function x893045_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893045_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x893045_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_258}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if GetName(sceneId,targetId) ~= x893045_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_256}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893045_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x893045_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnAddExp( sceneId, selfId, x893045_g_ExpBonus)
		DelMission( sceneId, selfId, x893045_g_MissionId )
		MissionCom( sceneId, selfId, x893045_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_46}",x893045_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(893046,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893045_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x893045_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893045_OnItemChanged( sceneId, selfId, itemdataId )
end
