--MisDescBegin
--脚本号
x890160_g_ScriptId = 890160

--任务号
x890160_g_MissionId = 2167

--前置任务
x890160_g_PreMissionId = 2166
x890160_g_PreMissionName = "#{ZXJQ_221225_140}"

--目标NPC
x890160_g_AcceptNpcInfo	= {name="墨知愁", sceneId=1292, posx=63, posz=53}

--交任务npc
x890160_g_Position_X=123--完成任务NPC属性
x890160_g_Position_Z=146
x890160_g_SceneID=14
x890160_g_AccomplishNPC_Name="苏星河"

--任务归类
x890160_g_MissionKind = 9

--任务等级
x890160_g_MissionLevel = 85

--是否是精英任务
x890160_g_IfMissionElite = 0

--任务名
x890160_g_MissionName="#{ZXJQ_221225_154}"
x890160_g_MissionTarget="#{ZXJQ_221225_160}"
x890160_g_IsMissionOkFail=0
x890160_g_Custom = {{ id = "前往凌波洞寻苏星河", num = 1}}
x890160_g_ContinueInfo = ""
x890160_g_MissionComplete = ""

--MisDescEnd
x890160_g_ExpBonus = 250000
--**********************************
--任务入口函数
--**********************************
function x890160_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x890160_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890160_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890160_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x890160_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_166}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890160_g_ScriptId,x890160_g_MissionId)		
	elseif x890160_CheckAccept( sceneId, selfId ) > 0 and GetName(sceneId,targetId) == x890160_g_AcceptNpcInfo.name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x890160_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_153}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890160_g_ScriptId,x890160_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890160_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890160_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890160_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890160_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890160_g_ScriptId,x890160_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890160_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890160_g_AcceptNpcInfo.name then
			AddNumText(sceneId,x890160_g_ScriptId,x890160_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890160_OnAccept(sceneId,selfId,targetId)
	if x890160_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x890160_g_MissionId, x890160_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXJQ_221225_157}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_219}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890160_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXJQ_221225_158}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end

--**********************************
--检测接受条件
--**********************************
function x890160_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890160_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890160_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890160_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890160_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890160_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890160_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890160_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890160_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890160_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890160_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x890160_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_162}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_36}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if GetName(sceneId,targetId) ~= x890160_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_162}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
	
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890160_g_ExpBonus)
		DelMission( sceneId, selfId, x890160_g_MissionId )
		MissionCom( sceneId, selfId, x890160_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890160_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890161,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890160_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890160_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890160_OnItemChanged( sceneId, selfId, itemdataId )
end
