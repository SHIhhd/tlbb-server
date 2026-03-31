--MisDescBegin
--脚本号
x890155_g_ScriptId = 890155

--任务号
x890155_g_MissionId = 2162

--前置任务
x890155_g_PreMissionId = 2161
x890155_g_PreMissionName = "#{ZXJQ_221225_10}"

--目标NPC
x890155_g_AcceptNpcInfo	= {name="墨知愁", sceneId=1292, posx=63, posz=53}

--交任务npc
x890155_g_Position_X=63--完成任务NPC属性
x890155_g_Position_Z=53
x890155_g_SceneID=1292
x890155_g_AccomplishNPC_Name="墨知愁"

--任务归类
x890155_g_MissionKind = 9

--任务等级
x890155_g_MissionLevel = 85

--是否是精英任务
x890155_g_IfMissionElite = 0

--任务名
x890155_g_MissionName="#{ZXJQ_221225_54}"
x890155_g_MissionTarget="#{ZXJQ_221225_64}"
x890155_g_IsMissionOkFail=0
x890155_g_Custom = {{ id = "获得灵武裂甲", num = 2}}
x890155_g_ContinueInfo = ""
x890155_g_MissionComplete = ""

--MisDescEnd
x890155_g_ExpBonus = 400000
x890155_g_MissionItemID = 40005093
x890155_g_MissionItemNeed = 2
x890155_g_MissionParam_ItemNum = 1
--**********************************
--任务入口函数
--**********************************
function x890155_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x890155_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890155_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890155_g_AccomplishNPC_Name then
		--物品不够
		local nItemNum	= GetItemCount( sceneId, selfId, x890155_g_MissionItemID )
		if nItemNum < x890155_g_MissionItemNeed then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_283}");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x890155_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_45}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x890155_g_ScriptId,x890155_g_MissionId)		
	elseif x890155_CheckAccept( sceneId, selfId ) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x890155_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_53}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890155_g_ScriptId,x890155_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890155_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890155_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890155_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890155_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x890155_g_ScriptId,x890155_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890155_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890155_g_AccomplishNPC_Name then
			AddNumText(sceneId,x890155_g_ScriptId,x890155_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890155_OnAccept(sceneId,selfId,targetId)
	if x890155_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890155_g_MissionId, x890155_g_ScriptId, 1, 0, 1 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_60}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_219}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890155_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXJQ_221225_61}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x890155_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890155_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890155_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890155_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890155_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890155_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890155_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890155_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890155_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890155_g_MissionId) <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_40}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 0
	end
	local nItemNum	= GetItemCount( sceneId, selfId, x890155_g_MissionItemID )
	if nItemNum < x890155_g_MissionItemNeed then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_38}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890155_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890155_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x890155_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_35}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_36}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if GetName(sceneId,targetId) ~= x890155_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_35}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890155_g_ExpBonus)
		DelMission( sceneId, selfId, x890155_g_MissionId )
		MissionCom( sceneId, selfId, x890155_g_MissionId )
		--清理所有任务物品
		LuaFnDelAvailableItem( sceneId, selfId, x890155_g_MissionItemID, x890155_g_MissionItemNeed )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890155_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890156,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890155_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x890155_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x890155_g_MissionId ) == x890155_g_ScriptId then
			if GetName( sceneId, objId ) == "木甲豹" then
				--物品足够了
				if GetItemCount( sceneId, curOwner, x890155_g_MissionItemID ) >= x890155_g_MissionItemNeed then
					return
				end
				
				AddMonsterDropItem( sceneId, objId, curOwner, x890155_g_MissionItemID )
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x890155_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890155_OnItemChanged( sceneId, selfId, itemdataId )
	if itemdataId ~= x890155_g_MissionItemID then
		return
	end
	if IsHaveMission( sceneId, selfId, x890155_g_MissionId ) <= 0 then
		return
	end
--	ZXJQ_221225_465	#H成功拾取1个灵武裂甲（%s0/2）。	
--	ZXJQ_221225_466	#H您已拾取了足够的灵武裂甲，现可前往白溪湖墨知愁（63，53）处交付此任务。	
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890155_g_MissionId )	
	local nItemNum	= GetItemCount( sceneId, selfId, itemdataId )
	if nItemNum >= x890155_g_MissionItemNeed then
		SetMissionByIndex( sceneId, selfId, misIndex, x890155_g_MissionParam_ItemNum,x890155_g_MissionItemNeed )
		SetMissionByIndex( sceneId, selfId, misIndex, x890155_g_IsMissionOkFail,1 )
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_466}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	else
		SetMissionByIndex( sceneId, selfId, misIndex, x890155_g_MissionParam_ItemNum,nItemNum )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_465}",tostring(nItemNum)))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end
