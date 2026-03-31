--MisDescBegin
--脚本号
x890074_g_ScriptId = 890074
x890074_g_MainScriptId = 890086
--完成任务NPC属性
x890074_g_Position_X=69	--替代
x890074_g_Position_Z=142	--替代
x890074_g_SceneID=1293	--替代
x890074_g_AccomplishNPC_Name="墨北辰"	--替代

--任务号
x890074_g_MissionId = 2139

--任务归类
x890074_g_MissionKind = 64

--任务等级
x890074_g_MissionLevel = 85 --10000

--是否是精英任务
x890074_g_IfMissionElite = 0

--任务名
x890074_g_MissionName="#{BLCC_20221214_271}"
x890074_g_MissionTarget="#{BLCC_20221214_107}"
x890074_g_IsMissionOkFail=0
x890074_g_Custom = {{id = "拿回探路隐甲碎片", num = 20}} --替代
x890074_g_ContinueInfo = ""
x890074_g_MissionComplete = "#{BLCC_20221214_106}"


--MisDescEnd
x890074_g_KillNumber = 1
x890074_g_NeedKill = 20
x890074_g_KillerName = "灵猊"
--**********************************
--任务入口函数
--**********************************
function x890074_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890074_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890074_g_AccomplishNPC_Name then
		--BLCC_20221214_105	#W    凭借少侠身手，击败#R灵猊#W，拿回#G20#W个#Y探路隐甲碎片#W想来不是难事。	
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890074_g_MissionId )
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890074_g_IsMissionOkFail )
		if isFinish <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{BLCC_20221214_105}");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_106}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890074_g_ScriptId,x890074_g_MissionId)		
	elseif x890074_CheckAccept( sceneId, selfId ) > 0 then
		--BLCC_20221214_103	#W    天灾那日实在突然，在下忙于疏散百姓。待想取出图纸，却发现西城门已倾塌。彼时山火蔓延不可久留，不得已只能离开。#r    此后数年，在下多番尝试铸炼出一种“#Y探路隐甲#W”，想着凭此穿过#G横崖#W，经由#G乌衣巷#W进入西城，寻找图纸。不料#Y探路隐甲#W在#G横崖#W尽头，被#R灵猊#W发现并毁去。#r    若可以取回#Y探路隐甲碎片#W，或许可以得知隐甲不足，加以改良。不知少侠可愿相助？	
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_103}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890074_g_ScriptId,x890074_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890074_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890074_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890074_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890074_g_ScriptId,x890074_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890074_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890074_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890074_g_ScriptId,x890074_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890074_OnAccept(sceneId,selfId,targetId)
	if x890074_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890074_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890074_g_MissionId) <= 0 ) then
		return 0
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890074_g_MissionId, x890074_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890074_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890074_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	--BLCC_20221214_104	#W    那图纸存放之法十分特殊，不能经由他人，故而#Y探路隐甲#W是在下唯一的指望。#r    劳烦少侠前往#G长春谷·横崖#{_INFOAIM84,58,616,-1}#W#W，从#R灵猊#W处拿回#G20#W个#Y探路隐甲碎片#W。	
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_104}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890074_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890074_g_MainScriptId, "CanDoMission", sceneId, selfId, x890074_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890074_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890074_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890074_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890074_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890074_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890074_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890074_g_MissionLevel then
		x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890074_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890074_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890074_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890074_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890074_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890074_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890074_g_SceneID then
			x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890074_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890074_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890074_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890074_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890074_g_MissionId )
		--完成任务
		CallScriptFunction(x890074_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890074_g_MissionId,x890074_g_MissionName)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890074_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x890074_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x890074_g_MissionId ) == x890074_g_ScriptId then
			if GetName( sceneId, objId ) == x890074_g_KillerName then
				local misIndex = GetMissionIndexByID( sceneId, selfId, x890074_g_MissionId )	
				local nCurKill = GetMissionParam( sceneId, selfId,misIndex, x890074_g_KillNumber )
				if nCurKill >= x890074_g_NeedKill then
					return
				end	
				if nCurKill + 1 >= x890074_g_NeedKill then
					nCurKill = x890074_g_NeedKill
					x890074_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_303}")
					SetMissionByIndex( sceneId, selfId, misIndex, x890074_g_IsMissionOkFail,1 )
				else
					nCurKill = nCurKill + 1
					x890074_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{BLCC_20221214_302}",tostring(nCurKill)))
				end
				SetMissionByIndex( sceneId, selfId, misIndex, x890074_g_KillNumber,nCurKill )
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x890074_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890074_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890074_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890074_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
