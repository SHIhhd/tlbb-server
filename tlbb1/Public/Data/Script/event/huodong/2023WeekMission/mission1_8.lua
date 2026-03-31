--MisDescBegin
--脚本号
x890105_g_ScriptId	= 890105
x890105_g_MainScriptId = 890086

x890105_g_KDZZID = 1006000562
x890105_g_SubKDZZID = 0

--任务号
x890105_g_MissionId			= 2155

--完成任务NPC属性
x890105_g_Position_X=130
x890105_g_Position_Z=190
x890105_g_SceneID=1292
x890105_g_AccomplishNPC_Name="墨如"

--任务归类
x890105_g_MissionKind			= 64
--任务等级
x890105_g_MissionLevel		= 85
--是否是精英任务
x890105_g_IfMissionElite	= 0
--任务是否已经完成
x890105_g_IsMissionOkFail	= 0		--任务参数的第0位

--任务文本描述
x890105_g_MissionName			= "#{BLCC_20221214_463}"
--任务描述
x890105_g_MissionInfo			= ""
--x890105_g_ContinueInfo = "#{BLCC_20221214_381}"		--未完成任务的npc对话 ?	#少侠可有铲除掉雪猿？
--任务目标
x890105_g_MissionTarget		= "#{BLCC_20221214_383}"

-- 任务完成情况,内容动态刷新,占用任务参数的第1位
x890105_g_Custom	= { {id="制伏冰蚀木魇",num=1} }


--MisDescEnd
x890105_g_KillNumber = 1
x890105_g_NeedKill = 1
x890105_g_KillerName = "冰蚀木魇"
--**********************************
--任务入口函数
--**********************************
function x890105_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890105_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890105_g_AccomplishNPC_Name then
		--BLCC_20221214_381	#W    少侠切记，#R冰蚀木魇#W受#R寒缚冰锥#W所禁，亦为#R寒缚冰锥#W所护。唯有分别击碎#G3#W个#R寒缚冰锥#W，保证#G30#W秒内#G3#W个#R寒缚冰锥#W均不在场，才能让#R冰蚀木魇#W出现。#r    #G提示：单人击败冰蚀木魇难度较大，建议组队前往。帮助他人完成困难难度的天鉴任务也会获得经验奖励，每周最多可获得6次。	
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890105_g_MissionId )
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890105_g_IsMissionOkFail )
		if isFinish <= 0 then
			local op = GetNumText()
			if op == 222 then
				CallScriptFunction( 890133, "OnDefaultEvent",sceneId, selfId, targetId)
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{BLCC_20221214_381}");
					CallScriptFunction( 890133, "OnEnumerate",sceneId, selfId, targetId )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_382}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890105_g_ScriptId,x890105_g_MissionId)		
	elseif x890105_CheckAccept( sceneId, selfId ) > 0 then
		--BLCC_20221214_379	#W    观少侠身手了得，不知可否帮老身制伏#R冰蚀木魇#W？	
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_379}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890105_g_ScriptId,x890105_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890105_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890105_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890105_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890105_g_ScriptId,x890105_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890105_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890105_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890105_g_ScriptId,x890105_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890105_OnAccept(sceneId,selfId,targetId)
	if x890105_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890105_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890105_g_MissionId) <= 0 ) then
		return 0
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890105_g_MissionId, x890105_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890105_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890105_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	--BLCC_20221214_380	#W    说起这#R冰蚀木魇#W，本是#G长春谷#W尚未覆灭时专司防御的机关，却于天灾降临前出现故障，无法修复。少谷主无法，只得设下#R寒缚冰锥#W限制其行动，不时开启机关消解其力。#r    如今此物被放置在#G雪山禁地#W之中，还望少侠相助，先击碎#G3#W个#R寒缚冰锥#W，保证#G30#W秒内#G3#W个#R寒缚冰锥#W均不在场，再制伏出现的#R冰蚀木魇#W即可。#r    #G提示：单人击败冰蚀木魇难度较大，建议组队前往。帮助他人完成困难难度的天鉴任务也会获得经验奖励，每周最多可获得6次。		
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_380}");
		CallScriptFunction( 890133, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890105_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890105_g_MainScriptId, "CanDoMission", sceneId, selfId, x890105_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890105_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890105_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890105_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890105_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890105_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890105_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890105_g_MissionLevel then
		x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890105_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890105_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890105_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890105_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890105_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890105_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890105_g_SceneID then
			x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890105_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890105_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890105_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890105_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890105_g_MissionId )
		--完成任务
		CallScriptFunction(x890105_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890105_g_MissionId,x890105_g_MissionName)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890105_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x890105_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x890105_g_MissionId ) == x890105_g_ScriptId then
			if GetName( sceneId, objId ) == x890105_g_KillerName then
				local misIndex = GetMissionIndexByID( sceneId, selfId, x890105_g_MissionId )	
				
				x890105_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_470}")
				
				SetMissionByIndex( sceneId, selfId, misIndex, x890105_g_IsMissionOkFail,1 )
				SetMissionByIndex( sceneId, selfId, misIndex, x890105_g_KillNumber,1 )
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x890105_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890105_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890105_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890105_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
