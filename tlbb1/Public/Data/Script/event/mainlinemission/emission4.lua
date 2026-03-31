--MisDescBegin
--脚本号
x890157_g_ScriptId = 890157

--任务号
x890157_g_MissionId = 2164

--前置任务
x890157_g_PreMissionId = 2163
x890157_g_PreMissionName = "#{ZXJQ_221225_47}"

--目标NPC
x890157_g_AcceptNpcInfo	= {name="江行云", sceneId=1293, posx=37, posz=119}

--交任务npc
x890157_g_Position_X=65--完成任务NPC属性
x890157_g_Position_Z=52
x890157_g_SceneID=1294
x890157_g_AccomplishNPC_Name="阮枫眠"

--任务归类
x890157_g_MissionKind = 9

--任务等级
x890157_g_MissionLevel = 85

--是否是精英任务
x890157_g_IfMissionElite = 0

--任务名
x890157_g_MissionName="#{ZXJQ_221225_85}"
x890157_g_MissionTarget="#{ZXJQ_221225_91}"
x890157_g_IsMissionOkFail=0
x890157_g_Custom = {{ id = "于枫林采集西凉枫木", num = 1}}
x890157_g_ContinueInfo = ""
x890157_g_MissionComplete = ""

--MisDescEnd
x890157_g_ExpBonus = 300000
--枫林舆图、分山石斧
x890157_g_SpecialItem = {40005095,40005104}
--**********************************
--任务入口函数
--**********************************
function x890157_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x890157_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890157_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890157_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x890157_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_126}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890157_g_ScriptId,x890157_g_MissionId)		
	elseif x890157_CheckAccept( sceneId, selfId ) > 0 and GetName(sceneId,targetId) == x890157_g_AcceptNpcInfo.name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x890157_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_84}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890157_g_ScriptId,x890157_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890157_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890157_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890157_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890157_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890157_g_ScriptId,x890157_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890157_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890157_g_AcceptNpcInfo.name then
			AddNumText(sceneId,x890157_g_ScriptId,x890157_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890157_OnAccept(sceneId,selfId,targetId)
	if x890157_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	BeginAddItem(sceneId)
	for i = 1,getn(x890157_g_SpecialItem) do
		AddItem(sceneId,x890157_g_SpecialItem[i], 1)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_360}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x890157_g_MissionId, x890157_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXJQ_221225_88}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_219}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--给予特殊任务物品
	AddItemListToHuman(sceneId,selfId)
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890157_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXJQ_221225_89}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end

--**********************************
--检测接受条件
--**********************************
function x890157_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890157_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890157_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890157_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890157_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890157_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890157_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890157_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890157_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890157_g_MissionId )
	if GetMissionParam(sceneId,selfId,nMisIndex,x890157_g_IsMissionOkFail) < 1 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_471}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890157_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890157_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x890157_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_103}")
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
		if GetName(sceneId,targetId) ~= x890157_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_103}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
	
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890157_g_ExpBonus)
		DelMission( sceneId, selfId, x890157_g_MissionId )
		MissionCom( sceneId, selfId, x890157_g_MissionId )
		--清理任务物品
		for i = 1,getn(x890157_g_SpecialItem) do
			LuaFnDelAvailableItem( sceneId, selfId, x890157_g_SpecialItem[i], 1 )
		end
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890157_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890158,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890157_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890157_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890157_OnItemChanged( sceneId, selfId, itemdataId )
end
