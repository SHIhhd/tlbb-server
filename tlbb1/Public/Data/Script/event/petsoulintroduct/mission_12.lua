--MisDescBegin
--脚本号
x893051_g_ScriptId = 893051

--完成任务NPC属性
x893051_g_Position_X=89
x893051_g_Position_Z=139
x893051_g_SceneID=1
x893051_g_AccomplishNPC_Name="云深深"

--前置任务
x893051_g_PreMissionId = 2070
x893051_g_PreMissionName="#{SHYD_20211227_377}"

--任务号
x893051_g_MissionId = 2071

--任务归类
x893051_g_MissionKind = 9

--任务等级
x893051_g_MissionLevel = 85 --10000

--是否是精英任务
x893051_g_IfMissionElite = 0

--任务名
x893051_g_MissionName="#{SHYD_20211227_401}"
x893051_g_MissionTarget="#{SHYD_20211227_403}"
x893051_g_IsMissionOkFail=0
x893051_g_Custom = {{ id = "已进行兽魂融魂", num = 1}}
x893051_g_ContinueInfo = ""
x893051_g_MissionComplete = "#{SHYD_20211227_405}"

x893051_g_MoneyJZBonus = 40000
x893051_g_ExpBonus = 200000

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x893051_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x893051_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893051_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x893051_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		local misIndex = GetMissionIndexByID(sceneId,selfId,x893051_g_MissionId)
		local bOk = GetMissionParam(sceneId,selfId,misIndex,x893051_g_IsMissionOkFail)
		if bOk ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId,x893051_g_MissionName)
				AddText(sceneId,"#{SHYD_20211227_411}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,x893051_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_405}")
			AddMoneyJZBonus(sceneId,x893051_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x893051_g_ScriptId,x893051_g_MissionId)		
	elseif x893051_CheckAccept( sceneId, selfId ) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x893051_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_392}")
			AddMoneyJZBonus( sceneId,x893051_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x893051_g_ScriptId,x893051_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x893051_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893051_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893051_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x893051_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x893051_g_ScriptId,"#G"..x893051_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x893051_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x893051_g_AccomplishNPC_Name then
			AddNumText(sceneId,x893051_g_ScriptId,"#G"..x893051_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x893051_OnAccept(sceneId,selfId,targetId)
	if x893051_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x893051_g_MissionId, x893051_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_396}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHYD_20211227_400}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	--打开宠物页面
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 4);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 8930401)
end

--**********************************
--检测接受条件
--**********************************
function x893051_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893051_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893051_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x893051_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x893051_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893051_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893051_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893051_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893051_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	
	return 1
end

--**********************************
--提交
--**********************************
function x893051_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893051_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x893051_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_370}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if GetName(sceneId,targetId) ~= x893051_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_370}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local misIndex = GetMissionIndexByID(sceneId,selfId,x893051_g_MissionId)
		local bOk = GetMissionParam(sceneId,selfId,misIndex,x893051_g_IsMissionOkFail)
		if bOk ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_391}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		
		AddMoneyJZ(sceneId,selfId, x893051_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x893051_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnAddExp( sceneId, selfId, x893051_g_ExpBonus)
		DelMission( sceneId, selfId, x893051_g_MissionId )
		MissionCom( sceneId, selfId, x893051_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_46}",x893051_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(893052,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end
--**********************************
--任务完成
--**********************************
function x893051_OnFinish( sceneId, selfId )
	-- 检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893051_g_MissionId) > 0 ) then
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893051_g_MissionLevel then
		return
	end
	-- 未接取任务
	if IsHaveMission(sceneId,selfId,x893051_g_MissionId) <= 0 then
		return
	end
	--标记任务完成
	local misIndex = GetMissionIndexByID(sceneId,selfId,x893051_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,x893051_g_IsMissionOkFail,1)	
end