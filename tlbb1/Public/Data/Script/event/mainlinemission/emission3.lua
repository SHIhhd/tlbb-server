--MisDescBegin
--脚本号
x890156_g_ScriptId = 890156

--任务号
x890156_g_MissionId = 2163

--前置任务
x890156_g_PreMissionId = 2162
x890156_g_PreMissionName = "#{ZXJQ_221225_54}"

--目标NPC
x890156_g_AcceptNpcInfo	= {name="墨知愁", sceneId=1292, posx=63, posz=53}

--交任务npc
x890156_g_Position_X=37--完成任务NPC属性
x890156_g_Position_Z=119
x890156_g_SceneID=1293
x890156_g_AccomplishNPC_Name="江行云"

--任务归类
x890156_g_MissionKind = 9

--任务等级
x890156_g_MissionLevel = 85

--是否是精英任务
x890156_g_IfMissionElite = 0

--任务名
x890156_g_MissionName="#{ZXJQ_221225_47}"
x890156_g_MissionTarget="#{ZXJQ_221225_73}"
x890156_g_IsMissionOkFail=0
x890156_g_Custom = {{ id = "交付亲笔素笺及灵武裂甲", num = 1}}
x890156_g_ContinueInfo = ""
x890156_g_MissionComplete = ""

--MisDescEnd
x890156_g_ExpBonus = 2000000
x890156_g_SpecialItem = {40005093,40005094}
--**********************************
--任务入口函数
--**********************************
function x890156_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x890156_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890156_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890156_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x890156_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_83}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890156_g_ScriptId,x890156_g_MissionId)		
	elseif x890156_CheckAccept( sceneId, selfId ) > 0 and GetName(sceneId,targetId) == x890156_g_AcceptNpcInfo.name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x890156_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_66}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890156_g_ScriptId,x890156_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890156_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890156_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890156_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890156_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890156_g_ScriptId,x890156_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890156_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890156_g_AcceptNpcInfo.name then
			AddNumText(sceneId,x890156_g_ScriptId,x890156_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890156_OnAccept(sceneId,selfId,targetId)
	if x890156_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	BeginAddItem(sceneId)
	for i = 1,getn(x890156_g_SpecialItem) do
		AddItem(sceneId,x890156_g_SpecialItem[i], 1)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_360}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x890156_g_MissionId, x890156_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXJQ_221225_70}")
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
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890156_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXJQ_221225_71}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end

--**********************************
--检测接受条件
--**********************************
function x890156_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890156_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890156_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890156_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890156_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890156_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890156_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890156_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890156_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x890156_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890156_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x890156_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_75}")
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
		if GetName(sceneId,targetId) ~= x890156_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_75}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local nItemNum	= GetItemCount( sceneId, selfId, x890156_g_SpecialItem[1] )
		if nItemNum < 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_79}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_78}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return 0
		end
		nItemNum	= GetItemCount( sceneId, selfId, x890156_g_SpecialItem[2] )
		if nItemNum < 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_77}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_76}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return 0
		end
	
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890156_g_ExpBonus)
		DelMission( sceneId, selfId, x890156_g_MissionId )
		MissionCom( sceneId, selfId, x890156_g_MissionId )
		--清理任务物品
		for i = 1,getn(x890156_g_SpecialItem) do
			LuaFnDelAvailableItem( sceneId, selfId, x890156_g_SpecialItem[i], 1 )
		end
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890156_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890157,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890156_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890156_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890156_OnItemChanged( sceneId, selfId, itemdataId )
end
