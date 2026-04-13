--MisDescBegin
--脚本号
x890161_g_ScriptId = 890161

--任务号
x890161_g_MissionId = 2168

--前置任务
x890161_g_PreMissionId = 2167
x890161_g_PreMissionName = "#{ZXJQ_221225_154}"

--目标NPC
x890161_g_AcceptNpcInfo	= {name="苏星河", sceneId=14, posx=123, posz=146}

--任务归类
x890161_g_MissionKind = 9

--任务等级
x890161_g_MissionLevel = 85

--是否是精英任务
x890161_g_IfMissionElite = 0

--任务名
x890161_g_MissionName="#{ZXJQ_221225_168}"
x890161_g_MissionTarget="#{ZXJQ_221225_173}"
x890161_g_IsMissionOkFail=0
x890161_g_Custom = {{ id = "了解三人境况，择一人相助", num = 1}}
x890161_g_ContinueInfo = ""
x890161_g_MissionComplete = ""

x890161_g_ExpBonus = 2800000
--奖励道具
x890161_g_ItemBonus={{id=20600000,num=1}}

--MisDescEnd
x890161_g_ExpBonus = 2800000
--交任务npc
x890161_g_Position_X=63--完成任务NPC属性
x890161_g_Position_Z=53
x890161_g_SceneID=1292
x890161_g_AccomplishNPC_Name="墨知愁"
x890161_g_SelectCampId = 1
x890161_g_SelectNpcId = 2
--**********************************
--任务入口函数
--**********************************
function x890161_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x890161_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890161_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x890161_g_AcceptNpcInfo.name then
			local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890161_g_MissionId )
			local opId = GetNumText()
			if opId == 1 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_513}");
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_577}", 6, 10 )
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_576}", 8, 4 )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			elseif opId == 2 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_514}");
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_577}", 6, 11 )
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_576}", 8, 4 )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			elseif opId == 3 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_515}");
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_577}", 6, 12 )
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_576}", 8, 4 )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			elseif opId == 4 then
				--附加说明
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_110}");
					--三个关于说明
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_510}", 8, 1 )
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_511}", 8, 2 )
					AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_512}", 8, 3 )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)	
				return
			elseif opId >= 10 and opId <= 12 then
				--设置完成
				SetMissionByIndex( sceneId, selfId, nMisIndex, x890161_g_IsMissionOkFail,1 )
				SetMissionByIndex( sceneId, selfId, nMisIndex, x890161_g_SelectNpcId,opId - 10 + 1 )
				
				BeginUICommand(sceneId)
				EndUICommand(sceneId )
				DispatchUICommand(sceneId,selfId, 89016101)
				return
			else
				if GetMissionParam(sceneId,selfId,nMisIndex,x890161_g_IsMissionOkFail) < 1 then
					--附加说明
					BeginEvent(sceneId)
						AddText(sceneId,"#{ZXJQ_221225_110}");
						--三个关于说明
						AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_510}", 8, 1 )
						AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_511}", 8, 2 )
						AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_512}", 8, 3 )
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)
				else
					local nSelectId = GetMissionParam(sceneId,selfId,nMisIndex,x890161_g_SelectNpcId)
					BeginEvent(sceneId)
						if nSelectId == 1 then
							AddText(sceneId,"#{ZXJQ_221225_513}");
						elseif nSelectId == 2 then
							AddText(sceneId,"#{ZXJQ_221225_514}");
						else
							AddText(sceneId,"#{ZXJQ_221225_515}");
						end
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)	
				end
			end
				
		elseif GetName(sceneId,targetId) == x890161_g_AccomplishNPC_Name then
			local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890161_g_MissionId )
			local nSelectId = GetMissionParam(sceneId,selfId,nMisIndex,x890161_g_SelectNpcId)
			if nSelectId == 0 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_182}");
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
			
			local nCampId = LuaFnGetShengWangId(sceneId,selfId)
			if nCampId == 0 then
				local opId = GetNumText()
				if opId == 21 then
					LuaFnOpenShengWangAllPage(sceneId,selfId,targetId,1,1)
					return
				elseif opId == 22 then
					LuaFnOpenShengWangAllPage(sceneId,selfId,targetId,2,1)
					return
				elseif opId == 23 then
					LuaFnOpenShengWangAllPage(sceneId,selfId,targetId,3,1)
					return
				end
				
				local nSelectCampId = GetMissionParam(sceneId,selfId,nMisIndex,x890161_g_SelectCampId)
				if nSelectCampId == 0 then
					BeginEvent(sceneId)
						if nSelectId == 1 then
							AddText(sceneId,"#{ZXJQ_221225_566}");
							AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_569}", 6, 21 )
						elseif nSelectId == 2 then
							AddText(sceneId,"#{ZXJQ_221225_567}");
							AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_570}", 6, 22 )
						elseif nSelectId == 3 then
							AddText(sceneId,"#{ZXJQ_221225_568}");
							AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_571}", 6, 23 )
						end
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)	
					return
				end
				
				return
			end
			--提交任务时的说明信息
			BeginEvent(sceneId)
				AddText(sceneId,x890161_g_MissionName)
				AddText(sceneId,"#{ZXJQ_221225_178}")
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x890161_g_ScriptId,x890161_g_MissionId)		
		end

	elseif x890161_CheckAccept( sceneId, selfId ) > 0 and GetName(sceneId,targetId) == x890161_g_AcceptNpcInfo.name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x890161_g_MissionName)
			AddText(sceneId,"#{ZXJQ_221225_167}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890161_g_ScriptId,x890161_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x890161_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890161_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890161_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890161_g_AccomplishNPC_Name or GetName(sceneId,targetId) == x890161_g_AcceptNpcInfo.name then
		
		AddNumText(sceneId, x890161_g_ScriptId,x890161_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890161_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890161_g_AcceptNpcInfo.name then
			AddNumText(sceneId,x890161_g_ScriptId,x890161_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890161_OnAccept(sceneId,selfId,targetId)
	if x890161_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x890161_g_MissionId, x890161_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXJQ_221225_171}")
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
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890161_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZXJQ_221225_110}");
		--三个关于说明
		AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_510}", 8, 1 )
		AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_511}", 8, 2 )
		AddNumText( sceneId, x890161_g_ScriptId, "#{ZXJQ_221225_512}", 8, 3 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end

--**********************************
--检测接受条件
--**********************************
function x890161_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890161_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890161_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890161_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890161_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890161_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890161_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890161_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890161_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890161_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890161_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x890161_g_SceneID then
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
		if GetName(sceneId,targetId) ~= x890161_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_202}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890161_g_MissionId )
		local nSelectId = GetMissionParam(sceneId,selfId,nMisIndex,x890161_g_SelectNpcId)
		if nSelectId == 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_182}");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		BeginAddItem(sceneId)
		for i = 1,getn(x890161_g_ItemBonus) do
			AddBindItem(sceneId,x890161_g_ItemBonus[i].id, x890161_g_ItemBonus[i].num)
		end
		if EndAddItem(sceneId,selfId) <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_352}","1"))
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890161_g_ExpBonus)
		DelMission( sceneId, selfId, x890161_g_MissionId )
		MissionCom( sceneId, selfId, x890161_g_MissionId )

		AddItemListToHuman(sceneId,selfId)
		for i = 1,getn(x890161_g_ItemBonus) do
			BeginEvent(sceneId)
				AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_549}",tostring(x890161_g_ItemBonus[i].num),GetItemName(sceneId,x890161_g_ItemBonus[i].id)))
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890161_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890162,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890161_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890161_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890161_OnItemChanged( sceneId, selfId, itemdataId )
end
