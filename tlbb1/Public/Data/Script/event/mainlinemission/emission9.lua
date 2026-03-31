--MisDescBegin
--脚本号
x890162_g_ScriptId = 890162

--任务号
x890162_g_MissionId = 2169

--前置任务
x890162_g_PreMissionId = 2168
x890162_g_PreMissionName = "#{ZXJQ_221225_168}"

--目标NPC
x890162_g_AcceptNpcInfo	= {
	[1] = {name="墨知愁", sceneId=1292, posx=63, posz=53, npctext = "#{ZXJQ_221225_179}", text1="#{ZXJQ_221225_120}"},
	[2] = {name="江行云", sceneId=1293, posx=37, posz=119, npctext = "#{ZXJQ_221225_184}",text1="#{ZXJQ_221225_534}"},
	[3] = {name="阮枫眠", sceneId=1294, posx=65, posz=52, npctext = "#{ZXJQ_221225_189}",text1="#{ZXJQ_221225_535}"},
}

--任务归类
x890162_g_MissionKind = 9

--任务等级
x890162_g_MissionLevel = 85

--是否是精英任务
x890162_g_IfMissionElite = 0

--任务名
x890162_g_MissionName="#{ZXJQ_221225_111}"
x890162_g_MissionTarget="#{ZXJQ_221225_122}"
x890162_g_IsMissionOkFail=0
x890162_g_Custom = {{ id = "了解天鉴铸法及天鉴灵武等密文详情", num = 1}}
x890162_g_ContinueInfo = ""
x890162_g_MissionComplete = ""

--MisDescEnd
x890162_g_ExpBonus = 280000
x890162_g_Learn = 1
x890162_g_MissionCamp = 2
--奖励道具
x890162_g_ItemBonus={
	[1] = {id=20600009,num=1},
	[2] = {id=20600011,num=1},
	[3] = {id=20600013,num=1},
}
--**********************************
--任务入口函数
--**********************************
function x890162_OnDefaultEvent( sceneId, selfId, targetId )
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x890162_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890162_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890162_g_AcceptNpcInfo[nCampId].name then
--		提交任务时的说明信息
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890162_g_MissionId )
--		if GetMissionParam(sceneId,selfId,nMisIndex,x890162_g_IsMissionOkFail) < 1 then
			local opId = GetNumText()
			if opId == 1 then
				--何为天鉴灵武
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_525}");
					AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_526}", 8, 0 )
					AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_527}", 8, 2 )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)	
			elseif opId == 2 then
				--如何铸造灵武
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_528}");
					AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_526}", 8, 1 )
					AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_529}", 8, 3 )
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)	
			elseif opId == 3 then
				--如何铸炼灵武
				BeginEvent(sceneId)
					AddText(sceneId,"#{ZXJQ_221225_530}")
				EndEvent()
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x890162_g_ScriptId,x890162_g_MissionId)	
				--标记完成
				SetMissionByIndex( sceneId, selfId, nMisIndex, x890162_g_IsMissionOkFail,1 )
				SetMissionByIndex( sceneId, selfId, nMisIndex, x890162_g_Learn,1 )
			else	
				BeginEvent(sceneId)
					if nCampId == 1 then
						AddText(sceneId,"#{ZXJQ_221225_120}");
						AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_524}", 8, 1 )
					elseif nCampId == 2 then
						AddText(sceneId,"#{ZXJQ_221225_534}");
						AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_524}", 8, 1 )
					else
						AddText(sceneId,"#{ZXJQ_221225_535}");
						AddNumText( sceneId, x890162_g_ScriptId, "#{ZXJQ_221225_524}", 8, 1 )
					end
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)	
			end
			return
--		end
		
	elseif x890162_CheckAccept( sceneId, selfId ) > 0 then
		if GetName(sceneId,targetId) == x890162_g_AcceptNpcInfo[nCampId].name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x890162_g_MissionName)
				AddText(sceneId,x890162_g_AcceptNpcInfo[nCampId].npctext)
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x890162_g_ScriptId,x890162_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x890162_OnEnumerate( sceneId, selfId, targetId )
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		return
	end
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890162_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890162_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890162_g_AcceptNpcInfo[nCampId].name then
		
		AddNumText(sceneId, x890162_g_ScriptId,x890162_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890162_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890162_g_AcceptNpcInfo[nCampId].name then
			AddNumText(sceneId,x890162_g_ScriptId,x890162_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890162_OnAccept(sceneId,selfId,targetId)
	if x890162_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x890162_g_MissionId, x890162_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			if nCampId == 1 then
				AddText(sceneId,"#{ZXJQ_221225_115}")
			elseif nCampId == 2 then
				AddText(sceneId,"#{ZXJQ_221225_116}")
			else
				AddText(sceneId,"#{ZXJQ_221225_117}")
			end
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
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890162_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		if nCampId == 1 then
			AddText(sceneId,"#{ZXJQ_221225_382}")
		elseif nCampId == 2 then
			AddText(sceneId,"#{ZXJQ_221225_383}")
		else
			AddText(sceneId,"#{ZXJQ_221225_384}")
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
	--设置用于显示的阵营
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890162_g_MissionId )
	SetMissionByIndex( sceneId, selfId, nMisIndex, x890162_g_MissionCamp,nCampId )
end

--**********************************
--检测接受条件
--**********************************
function x890162_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890162_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890162_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890162_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890162_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890162_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890162_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890162_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890162_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890162_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890162_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		local nCampId = LuaFnGetShengWangId(sceneId,selfId)
		if nCampId == 0 then
			return
		end
		if sceneId ~= x890162_g_AcceptNpcInfo[nCampId].sceneId then
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
		if GetName(sceneId,targetId) ~= x890162_g_AcceptNpcInfo[nCampId].name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{ZXJQ_221225_202}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		BeginAddItem(sceneId)
		AddBindItem(sceneId,x890162_g_ItemBonus[nCampId].id, x890162_g_ItemBonus[nCampId].num)
		if EndAddItem(sceneId,selfId) <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_352}","1"))
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890162_g_ExpBonus)
		DelMission( sceneId, selfId, x890162_g_MissionId )
		MissionCom( sceneId, selfId, x890162_g_MissionId )
		
		AddItemListToHuman(sceneId,selfId)
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_549}",
				tostring(x890162_g_ItemBonus[nCampId].num),GetItemName(sceneId,x890162_g_ItemBonus[nCampId].id)))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890162_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890163,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890162_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890162_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890162_OnItemChanged( sceneId, selfId, itemdataId )
end
