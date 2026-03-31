--MisDescBegin
--脚本号
x890067_g_ScriptId = 890067
x890067_g_MainScriptId = 890086
--完成任务NPC属性
x890067_g_Position_X=125	--替代
x890067_g_Position_Z=178	--替代
x890067_g_SceneID=1292	--替代
x890067_g_AccomplishNPC_Name="墨晓清"	--替代

--任务号
x890067_g_MissionId = 2132

--任务归类
x890067_g_MissionKind = 64

--任务等级
x890067_g_MissionLevel = 85 --10000

--是否是精英任务
x890067_g_IfMissionElite = 0

--任务名
x890067_g_MissionName="#{BLCC_20221214_264}"
x890067_g_MissionTarget="#{BLCC_20221214_30}"
x890067_g_IsMissionOkFail=0
x890067_g_Custom = {{id = "驱赶木甲豹", num = 20}} --替代
x890067_g_ContinueInfo = ""
x890067_g_MissionComplete = "#{BLCC_20221214_29}"


--MisDescEnd
x890067_g_KillNumber = 1
x890067_g_NeedKill = 20
x890067_g_KillerName = "木甲豹"
--**********************************
--任务入口函数
--**********************************
function x890067_OnDefaultEvent( sceneId, selfId, targetId )
	
	if IsHaveMission(sceneId,selfId,x890067_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890067_g_AccomplishNPC_Name then
		--BLCC_20221214_28	#W    凭借少侠身手，驱赶#G20#W只#R木甲豹#W想来不是难事。	
		local misIndex = GetMissionIndexByID( sceneId, selfId, x890067_g_MissionId )
		local isFinish = GetMissionParam( sceneId, selfId,misIndex, x890067_g_IsMissionOkFail )
		if isFinish <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{BLCC_20221214_28}");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_28}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890067_g_ScriptId,x890067_g_MissionId)		
	elseif x890067_CheckAccept( sceneId, selfId ) > 0 then
		--BLCC_20221214_26	#W    长春谷还在时，小女最喜欢的地方，就是#G横崖#W。#r    ……每到春天，一种不知名的小黄花就会开满向阳花道和雁栖林。晓溪淘气，总跑去那里打滚，好好的衣服只消半天就染满花汁，阿娘气呼呼地替他洗衣，阿爹就好声好气劝和……#r    如今阿爹阿娘不在了，除却照顾晓溪，此处便是我唯一的念想。前几日听阿辰说，有一些陌生的#R木甲豹#W在此徘徊，希望少侠能出手相助。	
		BeginEvent(sceneId)
			AddText(sceneId,"#{BLCC_20221214_26}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890067_g_ScriptId,x890067_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890067_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x890067_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890067_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890067_g_ScriptId,x890067_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x890067_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890067_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890067_g_ScriptId,x890067_g_MissionName,3,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890067_OnAccept(sceneId,selfId,targetId)
	if x890067_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 检测当前有无权限接取该任务【带提示】
	if (CallScriptFunction( x890067_g_MainScriptId, "CanAcceptMission", sceneId, selfId, x890067_g_MissionId) <= 0 ) then
		return 0
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890067_g_MissionId, x890067_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		--BLCC_20221214_283	    少侠，您的要事太多，不能在接取更多的任务了。	
		x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_284}")
		x890067_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_283}")			
		return
	end
	--BLCC_20221214_13	#H成功领取任务：%s0。	
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{BLCC_20221214_13}",x890067_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	--BLCC_20221214_27	#W    阿辰说，这些#R木甲豹#W的木料用材很奇怪，不似长春谷之物——小女担心或有人觊觎长春谷秘法，哪怕只剩下些断壁残垣也不肯放过……#r    小女实在不愿昔日回忆之地再遭侵扰，希望少侠可以帮忙前往#G长春谷·横崖#{_INFOAIM176,194,616,-1}#W附近驱赶#G20#W只#R木甲豹#W。	
	BeginEvent(sceneId)
		AddText(sceneId,"#{BLCC_20221214_27}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890067_CheckAccept( sceneId, selfId )
	-- 检测当前有无权限接取该任务
	if (CallScriptFunction( x890067_g_MainScriptId, "CanDoMission", sceneId, selfId, x890067_g_MissionId) <= 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890067_g_MissionLevel then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890067_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890067_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890067_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890067_CheckSubmit( sceneId, selfId ,targetId)
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890067_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890067_g_MissionLevel then
		x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_14}")
		x890067_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_285}")			
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890067_g_MissionId) <= 0 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890067_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId, misIndex,x890067_g_IsMissionOkFail )
	if isFinish <= 0 then
		--BLCC_20221214_17	#H您未达成任务目标。	
		x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_17}")
		return
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890067_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890067_CheckSubmit( sceneId, selfId,targetId, selectRadioId ) == 1 then
		if sceneId ~= x890067_g_SceneID then
			x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890067_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_15}")
			x890067_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_286}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_16}")
			x890067_NotifyBox( sceneId, selfId,targetId, "#{BLCC_20221214_287}")
			return
		end
		if GetName(sceneId,targetId) ~= x890067_g_AccomplishNPC_Name then
			return
		end
		--添加任务奖励		
		DelMission( sceneId, selfId, x890067_g_MissionId )
		--完成任务
		CallScriptFunction(x890067_g_MainScriptId,"OnMissionFinish",sceneId,selfId,targetId,x890067_g_MissionId,x890067_g_MissionName)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890067_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x890067_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x890067_g_MissionId ) == x890067_g_ScriptId then
			if GetName( sceneId, objId ) == x890067_g_KillerName then
				local misIndex = GetMissionIndexByID( sceneId, selfId, x890067_g_MissionId )	
				local nCurKill = GetMissionParam( sceneId, selfId,misIndex, x890067_g_KillNumber )
				if nCurKill >= x890067_g_NeedKill then
					return
				end
--				BLCC_20221214_296	当前已驱赶木甲豹：%s0/20	
--				BLCC_20221214_297	#H已驱赶20只木甲豹，任务：天鉴·往日时光完成。	
				if nCurKill + 1 >= x890067_g_NeedKill then
					nCurKill = x890067_g_NeedKill
					x890067_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_297}")
					SetMissionByIndex( sceneId, selfId, misIndex, x890067_g_IsMissionOkFail,1 )
				else
					nCurKill = nCurKill + 1
					x890067_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{BLCC_20221214_296}",tostring(nCurKill)))
				end
				SetMissionByIndex( sceneId, selfId, misIndex, x890067_g_KillNumber,nCurKill )
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x890067_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890067_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--对话框提示
--**********************************
function x890067_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x890067_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
