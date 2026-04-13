--MisDescBegin
--脚本号
x893043_g_ScriptId = 893043

--完成任务NPC属性
x893043_g_Position_X=107
x893043_g_Position_Z=87
x893043_g_SceneID=39
x893043_g_AccomplishNPC_Name="云决决"

--前置任务
x893043_g_PreMissionId = 2062
x893043_g_PreMissionName="#{SHYD_20211227_96}"

--任务号
x893043_g_MissionId = 2063

--任务归类
x893043_g_MissionKind = 9

--任务等级
x893043_g_MissionLevel = 85 --10000

--是否是精英任务
x893043_g_IfMissionElite = 0

--任务名
x893043_g_MissionName="#{SHYD_20211227_195}"
x893043_g_MissionTarget="#{SHYD_20211227_196}"
x893043_g_IsMissionOkFail=0
x893043_g_Custom = {{id = "已击败狻猊心魔", num = 1}} --替代
x893043_g_ContinueInfo = ""
x893043_g_MissionComplete = "#{SHYD_20211227_203}"

x893043_g_MoneyJZBonus = 20000
x893043_g_ExpBonus = 1200000


--MisDescEnd
x893043_g_AcceptNPCPosition_X=151
x893043_g_AcceptNPCPosition_Z=132
x893043_g_AcceptNPCSceneID=40
x893043_g_AcceptNPC_Name="狻猊"
--**********************************
--任务入口函数
--**********************************
function x893043_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x893043_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893043_g_MissionId) > 0 then
		--提交任务时的说明信息
		if GetName(sceneId,targetId) == x893043_g_AccomplishNPC_Name then
			if sceneId ~= x893043_g_SceneID then
				BeginEvent(sceneId)
					AddText(sceneId,"#{SHYD_20211227_206}")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
			local misIndex = GetMissionIndexByID(sceneId,selfId,x893043_g_MissionId)
			local bOk = GetMissionParam(sceneId,selfId,misIndex,x893043_g_IsMissionOkFail)
			if bOk ~= 1 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{SHYD_20211227_209}")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				
				BeginEvent(sceneId)
					AddText(sceneId, "#{SHYD_20211227_212}")
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			BeginEvent(sceneId)
				AddText(sceneId,x893043_g_MissionName)
				AddText(sceneId,"#{SHYD_20211227_203}")
				AddMoneyJZBonus(sceneId,x893043_g_MoneyJZBonus)
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x893043_g_ScriptId,x893043_g_MissionId)
		end
	elseif x893043_CheckAccept( sceneId, selfId ) > 0 then
		if GetName(sceneId,targetId) == x893043_g_AcceptNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,x893043_g_MissionName)
				AddText(sceneId,"#{SHYD_20211227_186}")
				AddMoneyJZBonus( sceneId,x893043_g_MoneyJZBonus)
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x893043_g_ScriptId,x893043_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893043_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893043_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893043_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x893043_g_AccomplishNPC_Name then
			AddNumText(sceneId, x893043_g_ScriptId,"#G"..x893043_g_MissionName,2,-1);
		end
	--满足任务接收条件
	elseif x893043_CheckAccept(sceneId,selfId) > 0 then
		--在上一个完成任务NPC处
		if GetName(sceneId,targetId) == x893043_g_AcceptNPC_Name then
			AddNumText(sceneId,x893043_g_ScriptId,"#G"..x893043_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x893043_OnAccept(sceneId,selfId,targetId)
	if x893043_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x893043_g_MissionId, x893043_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SHYD_20211227_193}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, "#{SHYD_20211227_194}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	BeginEvent( sceneId )
		AddText( sceneId, "#{SHYD_20211227_199}" )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--检测接受条件
--**********************************
function x893043_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893043_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893043_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x893043_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893043_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893043_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893043_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893043_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x893043_g_MissionId)
	local bOk = GetMissionParam(sceneId,selfId,misIndex,x893043_g_IsMissionOkFail)
	if bOk ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x893043_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893043_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893043_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x893043_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnAddExp( sceneId, selfId, x893043_g_ExpBonus)
		DelMission( sceneId, selfId, x893043_g_MissionId )
		MissionCom( sceneId, selfId, x893043_g_MissionId )
				
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_46}",x893043_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(893044,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893043_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x893043_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x893043_g_MissionId ) == x893043_g_ScriptId then
			if GetName( sceneId, objId ) == "狻猊心魔" then
				local misIndex = GetMissionIndexByID(sceneId,selfId,x893043_g_MissionId)
				local nKillNum = GetMissionParam(sceneId,selfId,misIndex,1)
				if nKillNum < x893043_g_Custom[1].num  then
					SetMissionByIndex(sceneId,selfId,misIndex,1,nKillNum + 1)	
					if nKillNum + 1 >= x893043_g_Custom[1].num then
						BeginEvent(sceneId)
							AddText(sceneId, "#{SHYD_20211227_201}")
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,selfId)
						
						BeginEvent(sceneId)
							AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_202}",x893043_g_AccomplishNPC_Name))
						EndEvent(sceneId)
						DispatchMissionTips(sceneId,selfId)
						--标记任务完成
						SetMissionByIndex(sceneId,selfId,misIndex,x893043_g_IsMissionOkFail,1)	
						--完成提示
						BeginEvent( sceneId )
							AddText( sceneId, "#{SHYD_20211227_467}" )
						EndEvent( sceneId )
						DispatchEventList( sceneId, selfId, -1 )
					end
				end
			end
		end
	end
	
end

--**********************************
--进入区域事件
--**********************************
function x893043_OnEnterZone( sceneId, selfId, zoneId )
end
