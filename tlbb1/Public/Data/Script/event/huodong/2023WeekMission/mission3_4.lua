--MisDescBegin
--脚本号
x890082_g_ScriptId = 890082
x890082_g_MainScriptId = 890086
--完成任务NPC属性
x890082_g_Position_X=54	--替代
x890082_g_Position_Z=58	--替代
x890082_g_SceneID=1294	--替代
x890082_g_AccomplishNPC_Name="墨离"	--替代

--任务号
x890082_g_MissionId = 2147

--任务归类
x890082_g_MissionKind = 64

--任务等级
x890082_g_MissionLevel = 85 --10000

--是否是精英任务
x890082_g_IfMissionElite = 0

--任务名
x890082_g_MissionName="#{BLCC_20221214_279}"
x890082_g_MissionTarget="#{BLCC_20221214_183}"
x890082_g_IsMissionOkFail=0
x890082_g_Custom = {{id = "修理臂甲", num = 1}} --替代
x890082_g_ContinueInfo = ""
x890082_g_MissionComplete = "#{BLCC_20221214_182}"


--MisDescEnd
x890082_g_TransBuff = {
	[0] = 45521,
	[1] = 45520,
}
--**********************************
--任务入口函数
--**********************************
function x890082_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890082_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890082_g_AccomplishNPC_Name then
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890082_g_MissionId )
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890082_g_IsMissionOkFail )
		if isFinish <= 0 then
			local nSelfSex = GetSex(sceneId,selfId)
			local opId = GetNumText()
			if opId == 111 then
				if GetLevel(sceneId, selfId) < x890082_g_MissionLevel then
					x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_483}")
					return
				end
				if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
					x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_484}")
					return
				end
				if IsHaveMission(sceneId,selfId,x890082_g_MissionId) <= 0 then
					x890082_NotifyMsg( sceneId, selfId,ScriptGlobal_Format( "#{BLCC_20221214_485}",x890082_g_MissionName))
					return
				end
				--如果玩家处于骑乘或变身状态
				if LuaFnIsRiding( sceneId, selfId ) == 1 then 
					x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_487}")
					return
				elseif LuaFnIsModelOrMount( sceneId, selfId ) == 2 then
					x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_488}")
					return
				end
				if IsTeamFollow(sceneId,selfId) == 1 then
					x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_486}")
					return
				end
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x890082_g_TransBuff[nSelfSex], 0);
				x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_40}")
				return
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{BLCC_20221214_181}");
					if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890082_g_TransBuff[nSelfSex]) ~= 1 then
						AddNumText( sceneId, x890082_g_ScriptId, "#{BLCC_20221214_482}", 6, 111 )
					end
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_182}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890082_g_ScriptId,x890082_g_MissionId)		
	elseif x890082_CheckAccept( sceneId, selfId ) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_179}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890082_g_ScriptId,x890082_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890082_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890082_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890082_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890082_g_ScriptId,x890082_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890082_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890082_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890082_g_ScriptId,x890082_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890082_OnAccept(sceneId,selfId,targetId)
	if x890082_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890082_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890082_g_MissionId) <= 0 ) then
		return
	end
	--变身
	local nSelfSex = GetSex(sceneId,selfId)
	if x890082_g_TransBuff[nSelfSex] == nil then
		return
	end
	--如果玩家处于骑乘或变身状态
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_534}")
		return
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 2 then
		x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_39}")
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890082_g_MissionId, x890082_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890082_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--变身
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x890082_g_TransBuff[nSelfSex], 0);
	x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_40}")
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890082_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_180}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890082_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890082_g_MainScriptId, "CanDoMission", sceneId, selfId, x890082_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890082_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890082_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890082_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890082_g_MissionId )
	--解除变身
	local nSelfSex = GetSex(sceneId,selfId)
	LuaFnCancelSpecificImpact(sceneId,selfId,x890082_g_TransBuff[nSelfSex])
end

--**********************************
--检测是否可以提交
--**********************************
function x890082_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890082_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890082_g_MissionLevel then
		x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890082_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890082_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890082_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890082_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890082_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890082_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890082_g_SceneID then
			x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890082_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890082_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890082_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890082_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890082_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890082_g_MissionId )
		--解除变身
		local nSelfSex = GetSex(sceneId,selfId)
		LuaFnCancelSpecificImpact(sceneId,selfId,x890082_g_TransBuff[nSelfSex])
		--完成任务
		CallScriptFunction(x890082_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890082_g_MissionId,x890082_g_MissionName)
	end
end
--**********************************
-- 变身被取消后的回调
--**********************************
function x890082_OnImpactFadeOut( sceneId, selfId, impactId )
--	x890082_OnAbandon( sceneId, selfId )
end
--**********************************
--杀死怪物或玩家
--**********************************
function x890082_OnKillObject( sceneId, selfId, objdataId, objId )
end

--**********************************
--进入区域事件
--**********************************
function x890082_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890082_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890082_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890082_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
