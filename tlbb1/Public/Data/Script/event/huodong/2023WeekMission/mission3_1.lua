--MisDescBegin
--脚本号
x890079_g_ScriptId = 890079
x890079_g_MainScriptId = 890086
--完成任务NPC属性
x890079_g_Position_X=54	--替代
x890079_g_Position_Z=58	--替代
x890079_g_SceneID=1294	--替代
x890079_g_AccomplishNPC_Name="墨离"	--替代

--任务号
x890079_g_MissionId = 2144

--任务归类
x890079_g_MissionKind = 64

--任务等级
x890079_g_MissionLevel = 85 --10000

--是否是精英任务
x890079_g_IfMissionElite = 0

--任务名
x890079_g_MissionName="#{BLCC_20221214_276}"
x890079_g_MissionTarget="#{BLCC_20221214_157}"
x890079_g_IsMissionOkFail=0
x890079_g_Custom = {{id = "消灭古道胡狼", num = 10}} --替代
x890079_g_ContinueInfo = ""
x890079_g_MissionComplete = "#{BLCC_20221214_156}"


--MisDescEnd
x890079_g_KillNumber = 1
x890079_g_NeedKill = 10
x890079_g_KillerName = "古道胡狼"
--**********************************
--任务入口函数
--**********************************
function x890079_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890079_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890079_g_AccomplishNPC_Name then
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890079_g_MissionId )
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890079_g_IsMissionOkFail )
		if isFinish <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{BLCC_20221214_155}");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_156}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890079_g_ScriptId,x890079_g_MissionId)		
	elseif x890079_CheckAccept( sceneId, selfId ) > 0 then
		--BLCC_20221214_153	#W    少侠你看，我这新铸的机关被那些#R古道胡狼#W咬得稀碎还丢到我门前！这是什么，这是挑衅，对我铸法明晃晃的挑衅！#r    可惜我职责在身，没法亲自收拾这帮臭狼——少侠，你能帮我给它们些教训么！	
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_153}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890079_g_ScriptId,x890079_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890079_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890079_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890079_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890079_g_ScriptId,x890079_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890079_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890079_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890079_g_ScriptId,x890079_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890079_OnAccept(sceneId,selfId,targetId)
	if x890079_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890079_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890079_g_MissionId) <= 0 ) then
		return 0
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890079_g_MissionId, x890079_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890079_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890079_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_154}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890079_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890079_g_MainScriptId, "CanDoMission", sceneId, selfId, x890079_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890079_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890079_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890079_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890079_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890079_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890079_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890079_g_MissionLevel then
		x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890079_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890079_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890079_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890079_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890079_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890079_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890079_g_SceneID then
			x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890079_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890079_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890079_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890079_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890079_g_MissionId )
		--完成任务
		CallScriptFunction(x890079_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890079_g_MissionId,x890079_g_MissionName)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890079_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x890079_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x890079_g_MissionId ) == x890079_g_ScriptId then
			if GetName( sceneId, objId ) == x890079_g_KillerName then
				local misIndex = GetMissionIndexByID( sceneId, selfId, x890079_g_MissionId )	
				local nCurKill = GetMissionParam( sceneId, selfId,misIndex, x890079_g_KillNumber )
				if nCurKill >= x890079_g_NeedKill then
					return
				end
				if nCurKill + 1 >= x890079_g_NeedKill then
					nCurKill = x890079_g_NeedKill
					x890079_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_516}")
					SetMissionByIndex( sceneId, selfId, misIndex, x890079_g_IsMissionOkFail,1 )
				else
					nCurKill = nCurKill + 1
					x890079_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{BLCC_20221214_292}",x890079_g_KillerName,tostring(nCurKill)))
				end
				SetMissionByIndex( sceneId, selfId, misIndex, x890079_g_KillNumber,nCurKill )
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x890079_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890079_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890079_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890079_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
