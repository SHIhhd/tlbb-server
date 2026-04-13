--MisDescBegin
--脚本号
x890164_g_ScriptId = 890164

--任务号
x890164_g_MissionId = 2171

--前置任务
x890164_g_PreMissionId = 2170
x890164_g_PreMissionName = "#{ZXJQ_221225_388}"

--目标NPC
x890164_g_AcceptNpcInfo	= {
	[1] = {name="墨知愁", sceneId=1292, posx=63, posz=53, npctext = "#{ZXJQ_221225_389}",text1="#{ZXJQ_221225_356}",text2="#{ZXJQ_221225_206}",text3="#{ZXJQ_221225_374}"},
	[2] = {name="江行云", sceneId=1293, posx=37, posz=119, npctext = "#{ZXJQ_221225_390}",text1="#{ZXJQ_221225_194}",text2="#{ZXJQ_221225_211}",text3="#{ZXJQ_221225_379}"},
	[3] = {name="阮枫眠", sceneId=1294, posx=65, posz=52, npctext = "#{ZXJQ_221225_391}",text1="#{ZXJQ_221225_198}",text2="#{ZXJQ_221225_215}",text3="#{ZXJQ_221225_380}"},
}

--任务归类
x890164_g_MissionKind = 9

--任务等级
x890164_g_MissionLevel = 85

--是否是精英任务
x890164_g_IfMissionElite = 0

--任务名
x890164_g_MissionName="#{ZXJQ_221225_190}"
x890164_g_MissionTarget="#{ZXJQ_221225_200}"
x890164_g_IsMissionOkFail=0
x890164_g_Custom = {{ id = "完成一次天鉴任务", num = 1}}
x890164_g_ContinueInfo = ""
x890164_g_MissionComplete = ""


--MisDescEnd
x890164_g_ExpBonus = 5000000
x890164_g_FinishMission = 1
x890164_g_MissionCamp = 2
--**********************************
--任务入口函数
--**********************************
function x890164_OnDefaultEvent( sceneId, selfId, targetId )
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x890164_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x890164_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890164_g_AcceptNpcInfo[nCampId].name then
--		提交任务时的说明信息
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890164_g_MissionId )
		if GetMissionParam(sceneId,selfId,nMisIndex,x890164_g_FinishMission) < 1 then
			BeginEvent(sceneId)
				AddText(sceneId,x890164_g_MissionName)
				AddText(sceneId,x890164_g_AcceptNpcInfo[nCampId].text3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)	
		else
			BeginEvent(sceneId)
				AddText(sceneId,x890164_g_MissionName)
				AddText(sceneId,x890164_g_AcceptNpcInfo[nCampId].text2)
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x890164_g_ScriptId,x890164_g_MissionId)	
		end
	elseif x890164_CheckAccept( sceneId, selfId ) > 0 then
		if GetName(sceneId,targetId) == x890164_g_AcceptNpcInfo[nCampId].name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x890164_g_MissionName)
				AddText(sceneId,x890164_g_AcceptNpcInfo[nCampId].npctext)
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x890164_g_ScriptId,x890164_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x890164_OnEnumerate( sceneId, selfId, targetId )
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		return
	end
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890164_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890164_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x890164_g_AcceptNpcInfo[nCampId].name then
		
		AddNumText(sceneId, x890164_g_ScriptId,x890164_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x890164_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890164_g_AcceptNpcInfo[nCampId].name then
			AddNumText(sceneId,x890164_g_ScriptId,x890164_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x890164_OnAccept(sceneId,selfId,targetId)
	if x890164_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890164_g_MissionId, x890164_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZXJQ_221225_219}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_62}",x890164_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,x890164_g_AcceptNpcInfo[nCampId].text1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
	--设置用于显示的阵营
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890164_g_MissionId )
	SetMissionByIndex( sceneId, selfId, nMisIndex, x890164_g_MissionCamp,nCampId )
end

--**********************************
--检测接受条件
--**********************************
function x890164_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890164_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890164_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890164_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x890164_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x890164_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890164_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890164_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890164_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x890164_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890164_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		local nCampId = LuaFnGetShengWangId(sceneId,selfId)
		if nCampId == 0 then
			return
		end
		if sceneId ~= x890164_g_AcceptNpcInfo[nCampId].sceneId then
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXJQ_221225_36}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if GetName(sceneId,targetId) ~= x890164_g_AcceptNpcInfo[nCampId].name then
			return
		end

		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890164_g_ExpBonus)
		DelMission( sceneId, selfId, x890164_g_MissionId )
		MissionCom( sceneId, selfId, x890164_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZXJQ_221225_381}",x890164_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
--		CallScriptFunction(890164,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890164_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890164_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890164_OnItemChanged( sceneId, selfId, itemdataId )

end