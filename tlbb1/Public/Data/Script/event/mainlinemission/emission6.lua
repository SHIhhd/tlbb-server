--MisDescBegin
--脚本号
x890159_g_ScriptId = 890159

--任务号
x890159_g_MissionId = 2166

--前置任务
x890159_g_PreMissionId = 2165
x890159_g_PreMissionName = "#{ZXJQ_221225_128}"

--目标NPC
x890159_g_AcceptNpcInfo	= {name="阮枫眠", sceneId=1294, posx=65, posz=52}

--交任务npc
x890159_g_Position_X=63--完成任务NPC属性
x890159_g_Position_Z=53
x890159_g_SceneID=1292
x890159_g_AccomplishNPC_Name="墨知愁"

--任务归类
x890159_g_MissionKind = 9

--任务等级
x890159_g_MissionLevel = 85

--是否是精英任务
x890159_g_IfMissionElite = 0

--任务名
x890159_g_MissionName="#{ZXJQ_221225_140}"
x890159_g_MissionTarget="#{ZXJQ_221225_147}"
x890159_g_IsMissionOkFail=0
x890159_g_Custom = {{ id = "去寻墨知愁", num = 1}}
x890159_g_ContinueInfo = ""
x890159_g_MissionComplete = ""

--MisDescEnd
x890159_g_ExpBonus = 2500000
--**********************************
--任务入口函数
--**********************************
function x890159_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x890159_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890159_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890159_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x890159_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_152}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890159_g_ScriptId,x890159_g_MissionId)		
	elseif x890159_CheckAccept( sceneId, selfId ) > 0 and GetName(sceneId,targetId) == x890159_g_AcceptNpcInfo.name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x890159_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_141}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890159_g_ScriptId,x890159_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890159_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890159_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890159_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890159_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890159_g_ScriptId,x890159_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890159_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890159_g_AcceptNpcInfo.name then
			AddNumText(sceneId,x890159_g_ScriptId,x890159_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890159_OnAccept(sceneId,selfId,targetId)
	if x890159_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x890159_g_MissionId, x890159_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXJQ_221225_144}")
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
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890159_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXJQ_221225_145}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end

--**********************************
--检测接受条件
--**********************************
function x890159_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890159_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890159_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890159_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890159_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890159_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890159_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890159_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890159_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890159_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890159_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x890159_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_202}")
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
		if GetName(sceneId,targetId) ~= x890159_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_202}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
	
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890159_g_ExpBonus)
		DelMission( sceneId, selfId, x890159_g_MissionId )
		MissionCom( sceneId, selfId, x890159_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890159_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890160,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890159_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890159_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890159_OnItemChanged( sceneId, selfId, itemdataId )
end

