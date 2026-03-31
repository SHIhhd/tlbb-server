--MisDescBegin
--脚本号
x893044_g_ScriptId = 893044

--完成任务NPC属性
x893044_g_Position_X=265
x893044_g_Position_Z=128
x893044_g_SceneID=2
x893044_g_AccomplishNPC_Name="云决决"

--前置任务
x893044_g_PreMissionId = 2063
x893044_g_PreMissionName="#{SHYD_20211227_195}"

--任务号
x893044_g_MissionId = 2064

--任务归类
x893044_g_MissionKind = 9

--任务等级
x893044_g_MissionLevel = 85 --10000

--是否是精英任务
x893044_g_IfMissionElite = 0

--任务名
x893044_g_MissionName="#{SHYD_20211227_224}"
x893044_g_MissionTarget="#{SHYD_20211227_227}"
x893044_g_IsMissionOkFail=0
x893044_g_Custom = {{ id = "已汇报云深深", num = 1},{ id = "已交付云飘飘", num = 1}}
x893044_g_ContinueInfo = ""
x893044_g_MissionComplete = "#{SHYD_20211227_469}"

x893044_g_MoneyJZBonus = 15000
x893044_g_ExpBonus = 100000

--MisDescEnd
x893044_g_CustomT = 
{
	[1] = {name = "云深深",param = 1},
	[2] = {name = "云飘飘",param = 2},
}
--**********************************
--任务入口函数
--**********************************
function x893044_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x893044_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893044_g_MissionId) > 0 then
		local misIndex = GetMissionIndexByID(sceneId,selfId,x893044_g_MissionId)
		--云深深
		if GetName(sceneId,targetId) == x893044_g_CustomT[1].name 
			and GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[1].param) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_442}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			--标记已拜访
			SetMissionByIndex(sceneId,selfId,misIndex,x893044_g_CustomT[1].param,1)	
			return
		end
		--云飘飘
		if GetName(sceneId,targetId) == x893044_g_CustomT[2].name then
			if GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[2].param) == 1 then
				BeginEvent(sceneId)
					AddText(sceneId,x893044_g_MissionName)
					AddText(sceneId,"#{SHYD_20211227_469}")
					AddMoneyJZBonus(sceneId,x893044_g_MoneyJZBonus)
				EndEvent()
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x893044_g_ScriptId,x893044_g_MissionId)
				return
			end
			--检查有无拜访云深深
			if GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[1].param) ~= 1 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{SHYD_20211227_232}")
				EndEvent()
				DispatchEventList( sceneId, selfId, targetId )
				
				BeginEvent(sceneId)
					AddText(sceneId,ScriptGlobal_Format("#{SHYD_20211227_241}",x893044_g_CustomT[1].name))
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			if GetNumText() == -2 then
				BeginEvent(sceneId)
					AddText(sceneId,x893044_g_MissionName)
					AddText(sceneId,"#{SHYD_20211227_469}")
					AddMoneyJZBonus(sceneId,x893044_g_MoneyJZBonus)
				EndEvent()
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x893044_g_ScriptId,x893044_g_MissionId)
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{SHYD_20211227_231}")
					AddNumText(sceneId, x893044_g_ScriptId,"#{SHYD_20211227_468}",8,-2);
				EndEvent()
				DispatchEventList( sceneId, selfId, targetId )
				--标记已拜访
				SetMissionByIndex(sceneId,selfId,misIndex,x893044_g_CustomT[2].param,1)	
			end
		end	
	elseif x893044_CheckAccept( sceneId, selfId ) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x893044_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_214}")
			AddMoneyJZBonus( sceneId,x893044_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x893044_g_ScriptId,x893044_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x893044_OnEnumerate( sceneId, selfId, targetId )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x893044_g_MissionId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893044_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893044_g_MissionId) > 0 then
		--云深深
		if GetName(sceneId,targetId) == x893044_g_CustomT[1].name 
			and GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[1].param) ~= 1 then
			AddNumText(sceneId, x893044_g_ScriptId,"#G"..x893044_g_MissionName,2,-1);
			return
		end
		--云飘飘
		if GetName(sceneId,targetId) == x893044_g_CustomT[2].name then
			if GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[2].param) == 1 then
				AddNumText(sceneId, x893044_g_ScriptId,"#G"..x893044_g_MissionName,2,-1);
				return
			end
			--检查有无拜访云深深
			if GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[1].param) ~= 1 then
				return
			end
			AddNumText(sceneId, x893044_g_ScriptId,"#G"..x893044_g_MissionName,2,-1);
			return
		end	
	--满足任务接收条件
	elseif x893044_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x893044_g_AccomplishNPC_Name then
			AddNumText(sceneId,x893044_g_ScriptId,"#G"..x893044_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x893044_OnAccept(sceneId,selfId,targetId)
	if x893044_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x893044_g_MissionId, x893044_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_220}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHYD_20211227_223}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHYD_20211227_221}")
	EndEvent()
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--检测接受条件
--**********************************
function x893044_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893044_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893044_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x893044_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x893044_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893044_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893044_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893044_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893044_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	
	return 1
end

--**********************************
--提交
--**********************************
function x893044_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893044_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		local misIndex = GetMissionIndexByID(sceneId,selfId,x893044_g_MissionId)
		if sceneId ~= x893044_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_234}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if GetMissionParam(sceneId,selfId,misIndex,x893044_g_CustomT[2].param) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_232}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893044_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x893044_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnAddExp( sceneId, selfId, x893044_g_ExpBonus)
		DelMission( sceneId, selfId, x893044_g_MissionId )
		MissionCom( sceneId, selfId, x893044_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_46}",x893044_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(893045,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893044_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x893044_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893044_OnItemChanged( sceneId, selfId, itemdataId )
end
