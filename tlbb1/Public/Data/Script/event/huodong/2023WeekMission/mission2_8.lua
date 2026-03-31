--MisDescBegin
--脚本号
x890107_g_ScriptId	= 890107
x890107_g_MainScriptId = 890086

x890107_g_KDZZID = 1006000562
x890107_g_SubKDZZID = 0

--任务号
x890107_g_MissionId			= 2156

--完成任务NPC属性
x890107_g_Position_X=70
x890107_g_Position_Z=37
x890107_g_SceneID=1293
x890107_g_AccomplishNPC_Name="墨星翁"

--任务归类
x890107_g_MissionKind			= 64
--任务等级
x890107_g_MissionLevel		= 85
--是否是精英任务
x890107_g_IfMissionElite	= 0
--任务是否已经完成
x890107_g_IsMissionOkFail	= 0		--任务参数的第0位

--任务文本描述
x890107_g_MissionName			= "#{BLCC_20221214_464}"
--任务描述
x890107_g_MissionInfo			= ""
--x890107_g_ContinueInfo = "#{BLCC_20221214_381}"		--未完成任务的npc对话 ?	#少侠可有铲除掉雪猿？
--任务目标
x890107_g_MissionTarget		= "#{BLCC_20221214_424}"

-- 任务完成情况,内容动态刷新,占用任务参数的第1位
x890107_g_Custom	= { {id="消灭所有匪徒",num=1} }


--MisDescEnd
x890107_g_KillNumber = 1
x890107_g_NeedKill = 50
x890107_g_KillerName = "匪徒"
--**********************************
--任务入口函数
--**********************************
function x890107_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890107_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890107_g_AccomplishNPC_Name then
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890107_g_MissionId )
		--BLCC_20221214_422	#W    少侠准备好了么？我们何时动身？#r    #G提示：单人击败匪徒难度较大，建议组队前往。帮助他人完成困难难度的天鉴任务也会获得经验奖励，每周最多可获得6次。	
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890107_g_IsMissionOkFail )
		if isFinish <= 0 then
			local op = GetNumText()
			if op == 222 then
				CallScriptFunction( 890137, "OnDefaultEvent",sceneId, selfId, targetId)
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{BLCC_20221214_422}");
					CallScriptFunction( 890137, "OnEnumerate",sceneId, selfId, targetId )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_423}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890107_g_ScriptId,x890107_g_MissionId)		
	elseif x890107_CheckAccept( sceneId, selfId ) > 0 then
--BLCC_20221214_420	#W    唔，真是头疼——都是那些埋伏的#R匪徒#W闹得！自我来这#G蜀南竹海#W，偶尔替周围村落古镇做些机关物件——嘿！那些黑心商人便盯上我了，找了些杂七杂八的#R匪徒#W，成日没个清净！不知少侠可愿帮帮我这个老头子？	
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_420}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890107_g_ScriptId,x890107_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890107_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890107_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890107_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890107_g_ScriptId,x890107_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890107_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890107_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890107_g_ScriptId,x890107_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890107_OnAccept(sceneId,selfId,targetId)
	if x890107_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890107_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890107_g_MissionId) <= 0 ) then
		return 0
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890107_g_MissionId, x890107_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890107_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890107_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
--BLCC_20221214_421	#W    等下老头子我啊便装作踩中他们的陷阱，大声呼救，那些#R匪徒#W必会现身——届时还请少侠出手相助！#r    #G提示：单人击败匪徒难度较大，建议组队前往。帮助他人完成困难难度的天鉴任务也会获得经验奖励，每周最多可获得6次。	
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_421}");
		CallScriptFunction( 890137, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890107_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890107_g_MainScriptId, "CanDoMission", sceneId, selfId, x890107_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890107_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890107_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890107_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890107_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890107_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890107_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890107_g_MissionLevel then
		x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890107_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890107_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890107_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890107_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890107_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890107_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890107_g_SceneID then
			x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890107_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890107_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890107_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890107_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890107_g_MissionId )
		--完成任务
		CallScriptFunction(x890107_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890107_g_MissionId,x890107_g_MissionName)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890107_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x890107_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x890107_g_MissionId ) == x890107_g_ScriptId then
			if GetName( sceneId, objId ) == x890107_g_KillerName then
				local misIndex = GetMissionIndexByID( sceneId, selfId, x890107_g_MissionId )	
				local nCurKill = GetMissionParam( sceneId, selfId,misIndex, x890107_g_KillNumber )
				if nCurKill >= x890107_g_NeedKill then
					return
				end
				if nCurKill + 1 >= x890107_g_NeedKill then
					nCurKill = x890107_g_NeedKill
					x890107_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_546}")
					SetMissionByIndex( sceneId, selfId, misIndex, x890107_g_IsMissionOkFail,1 )
				else
					nCurKill = nCurKill + 1
					x890107_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{BLCC_20221214_547}",tostring(nCurKill)))
				end
				SetMissionByIndex( sceneId, selfId, misIndex, x890107_g_KillNumber,nCurKill )
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x890107_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890107_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890107_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890107_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
