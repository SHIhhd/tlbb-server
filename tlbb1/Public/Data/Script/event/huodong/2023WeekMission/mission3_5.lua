--MisDescBegin
--脚本号
x890083_g_ScriptId = 890083
x890083_g_MainScriptId = 890086
--完成任务NPC属性
x890083_g_Position_X=65	--替代
x890083_g_Position_Z=52	--替代
x890083_g_SceneID=1294	--替代
x890083_g_AccomplishNPC_Name="阮枫眠"	--替代

--任务号
x890083_g_MissionId = 2148

--任务归类
x890083_g_MissionKind = 64

--任务等级
x890083_g_MissionLevel = 85 --10000

--是否是精英任务
x890083_g_IfMissionElite = 0

--任务名
x890083_g_MissionName="#{BLCC_20221214_280}"
x890083_g_MissionTarget="#{BLCC_20221214_192}"
x890083_g_IsMissionOkFail=0
x890083_g_Custom = {{id = "搜集西府海棠", num = 5}} --替代
x890083_g_ContinueInfo = ""
x890083_g_MissionComplete = "#{BLCC_20221214_191}"


--MisDescEnd
x890067_g_PickNumber = 1
x890067_g_NeedPick = 5
--**********************************
--任务入口函数
--**********************************
function x890083_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890083_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890083_g_AccomplishNPC_Name then
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890083_g_MissionId )
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890083_g_IsMissionOkFail )
		if isFinish <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{BLCC_20221214_190}");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_191}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890083_g_ScriptId,x890083_g_MissionId)		
	elseif x890083_CheckAccept( sceneId, selfId ) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_188}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890083_g_ScriptId,x890083_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890083_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890083_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890083_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890083_g_ScriptId,x890083_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890083_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890083_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890083_g_ScriptId,x890083_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890083_OnAccept(sceneId,selfId,targetId)
	if x890083_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890083_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890083_g_MissionId) <= 0 ) then
		return 0
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890083_g_MissionId, x890083_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890083_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890083_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890083_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_189}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890083_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890083_g_MainScriptId, "CanDoMission", sceneId, selfId, x890083_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890083_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890083_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890083_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890083_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890083_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890083_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890083_g_MissionLevel then
		x890083_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890083_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890083_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890083_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890083_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890083_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890083_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890083_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890083_g_SceneID then
			x890083_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890083_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890083_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890083_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890083_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890083_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890083_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890083_g_MissionId )
		--完成任务
		CallScriptFunction(x890083_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890083_g_MissionId,x890083_g_MissionName)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890083_OnKillObject( sceneId, selfId, objdataId, objId )
end

--**********************************
--进入区域事件
--**********************************
function x890083_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890083_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890083_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890083_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
