--灵武周任务 主控脚本
--脚本号
x890086_g_ScriptId = 890086
x890086_g_MinLevel = 85
x890086_g_WeekMax = 100
--任务集合
x890086_g_ShengWangAll_MissionCount = 3	--角色能接取的最大任务数量
x890086_g_ShengWangAll_MissionRealCount = 6
x890086_g_ShengWangAll_MissionInfo = {
	--阵营1
	[1] = {
			[1]={missionid=2130, name="#{SWXT_221213_142}",des="#{SWXT_221213_144}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=130,posZ=190,NPCname="墨如",AcceptTimeParam=5},
			[2]={missionid=2131, name="#{SWXT_221213_145}",des="#{SWXT_221213_146}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=130,posZ=190,NPCname="墨如",AcceptTimeParam=5},
			[3]={missionid=2132, name="#{SWXT_221213_147}",des="#{SWXT_221213_149}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=613,posX=125,posZ=178,NPCname="墨晓清",AcceptTimeParam=5},
			[4]={missionid=2133, name="#{SWXT_221213_150}",des="#{SWXT_221213_151}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[5]={missionid=2134, name="#{SWXT_221213_152}",des="#{SWXT_221213_153}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[6]={missionid=2135, name="#{SWXT_221213_154}",des="#{SWXT_221213_155}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[7]={missionid=2136, name="#{SWXT_221213_156}",des="#{SWXT_221213_157}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[8]={missionid=2155, name="#{SWXT_221213_158}",des="#{SWXT_221213_160}",grade="set:ShengWang01 image:ShengWangAll_KunNan",bonus=25,scene=613,posX=130,posZ=190,NPCname="墨如",AcceptTimeParam=3},
		},
	--阵营2
	[2] = {
			[1]={missionid=2137, name="#{SWXT_221213_161}",des="#{SWXT_221213_162}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=62,posZ=199,NPCname="墨忆",AcceptTimeParam=5},
			[2]={missionid=2138, name="#{SWXT_221213_163}",des="#{SWXT_221213_164}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=70,posZ=37,NPCname="墨星翁",AcceptTimeParam=5},
			[3]={missionid=2139, name="#{SWXT_221213_165}",des="#{SWXT_221213_166}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=614,posX=69,posZ=142,NPCname="墨北辰",AcceptTimeParam=5},
			[4]={missionid=2140, name="#{SWXT_221213_167}",des="#{SWXT_221213_168}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=37,posZ=119,NPCname="江行云",AcceptTimeParam=5},
			[5]={missionid=2141, name="#{SWXT_221213_169}",des="#{SWXT_221213_170}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=56,posZ=198,NPCname="墨思思",AcceptTimeParam=5},
			[6]={missionid=2142, name="#{SWXT_221213_171}",des="#{SWXT_221213_172}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=614,posX=37,posZ=119,NPCname="江行云",AcceptTimeParam=5},
			[7]={missionid=2143, name="#{SWXT_221213_173}",des="#{SWXT_221213_174}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=614,posX=37,posZ=119,NPCname="江行云",AcceptTimeParam=5},
			[8]={missionid=2156, name="#{SWXT_221213_175}",des="#{SWXT_221213_176}",grade="set:ShengWang01 image:ShengWangAll_KunNan",bonus=25,scene=614,posX=70,posZ=37,NPCname="墨星翁",AcceptTimeParam=3},
		},
	--阵营3
	[3] = {
			[1]={missionid=2144, name="#{SWXT_221213_177}",des="#{SWXT_221213_178}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=54,posZ=58,NPCname="墨离",AcceptTimeParam=5},
			[2]={missionid=2145, name="#{SWXT_221213_179}",des="#{SWXT_221213_180}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=75,posZ=60,NPCname="墨回",AcceptTimeParam=5},
			[3]={missionid=2146, name="#{SWXT_221213_181}",des="#{SWXT_221213_182}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=615,posX=65,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[4]={missionid=2147, name="#{SWXT_221213_183}",des="#{SWXT_221213_184}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=54,posZ=58,NPCname="墨离",AcceptTimeParam=5},
			[5]={missionid=2148, name="#{SWXT_221213_185}",des="#{SWXT_221213_186}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=65,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[6]={missionid=2149, name="#{SWXT_221213_187}",des="#{SWXT_221213_188}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=615,posX=65,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[7]={missionid=2150, name="#{SWXT_221213_189}",des="#{SWXT_221213_190}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=615,posX=62,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[8]={missionid=2157, name="#{SWXT_221213_191}",des="#{SWXT_221213_192}",grade="set:ShengWang01 image:ShengWangAll_KunNan",bonus=25,scene=615,posX=54,posZ=58,NPCname="墨离",AcceptTimeParam=3},
		},
}
--主线剧情任务
x890086_g_MainLineMissionId = 2171

--**********************************
--完成天鉴任务
--**********************************
function x890086_OnMissionFinish( sceneId, selfId,targetId, idMission,strMissionName)
	if GetLevel(sceneId, selfId) < x890086_g_MinLevel then
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 or x890086_g_ShengWangAll_MissionInfo[nCampId] == nil then
		return
	end
	local tData = nil
	local nDataIndex = nil
	for i = 1,x890086_g_ShengWangAll_MissionRealCount do		
		local nMissionIndex = LuaFnGetShengWangMissionIndex(sceneId,selfId,i - 1)
		local nDone = LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i-1)
		if nDone ~= 1 then
			if x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex] ~= nil and x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex].missionid == idMission then
				tData = x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex]
				nDataIndex = i - 1
				break
			end
		end
	end
	if tData == nil or nDataIndex == nil then
		return
	end
	--主线剧情任务特写
	if IsHaveMission(sceneId,selfId,x890086_g_MainLineMissionId) > 0  then
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x890086_g_MainLineMissionId )
		if GetMissionParam(sceneId,selfId,nMisIndex,1) <= 0 then
			SetMissionByIndex( sceneId, selfId, nMisIndex, 0,1 )
			SetMissionByIndex( sceneId, selfId, nMisIndex, 1,1 )
		end
	end
	--标记任务完成
	LuaFnSetShengWangMissionDoneFlag(sceneId,selfId,nDataIndex,1)
	
	local nCurWeekPoint = GetMissionData(sceneId,selfId,MD_SWXT_QURWEEKPOINT)
	if nCurWeekPoint >= x890086_g_WeekMax then
		--BLCC_20221214_542	#H完成任务：%s0，您的镌春令已达最大值，因此本次未能获得镌春令。	
		x890086_NotifyMsg(sceneId,selfId,ScriptGlobal_Format("#{BLCC_20221214_542}",strMissionName))
		return
	end
	local nWillAddPoint = tData.bonus
	local nCurPoint = LuaFnGetShengWangPoint(sceneId,selfId)
	if nCurWeekPoint + nWillAddPoint >= x890086_g_WeekMax then
		nWillAddPoint = x890086_g_WeekMax - nCurWeekPoint
	end
	LuaFnSetShengWangPoint(sceneId,selfId,nCurPoint + nWillAddPoint)
	SetMissionData(sceneId,selfId,MD_SWXT_QURWEEKPOINT,nCurWeekPoint + nWillAddPoint)
	--BLCC_20221214_288	#H完成任务：%s0，获得%s1个镌春令。	
	x890086_NotifyMsg(sceneId,selfId,ScriptGlobal_Format("#{BLCC_20221214_288}",strMissionName,tostring(nWillAddPoint)))
	--【天鉴战令】标记完成
	CallScriptFunction(890215, "OnFinishMission",sceneId, selfId, 1)
end
--**********************************
--是否接取了其余的天鉴任务
--**********************************
function x890086_CanAcceptMission( sceneId, selfId, idMission)
	--BLCC_20221214_9	#H您的等级不足85级，无法接取天鉴任务。	
	if GetLevel(sceneId, selfId) < x890086_g_MinLevel then
		x890086_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_9}")
		return 0
	end
	--是否处于组队跟随
	--BLCC_20221214_10	#H您当前处于组队跟随状态，无法接取天鉴任务。	
	if IsTeamFollow(sceneId,selfId) == 1 then
		x890086_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_10}")
		return 0
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 or x890086_g_ShengWangAll_MissionInfo[nCampId] == nil then
		return 0
	end
--	local nDoneNum = 0
	for i = 1,x890086_g_ShengWangAll_MissionRealCount do		
		local nMissionIndex = LuaFnGetShengWangMissionIndex(sceneId,selfId,i - 1)
		local nDone = LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i-1)
		if nDone ~= 1 then
			if x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex] ~= nil then
				if IsHaveMission(sceneId,selfId,x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex].missionid) > 0
					and x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex].missionid ~= idMission then
					--BLCC_20221214_11	#H您已经接取了一个天鉴任务，不能重复接取。	
					x890086_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_11}")
					return 0
				end
			end
		end
--		if LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i - 1) == 1 then
--			nDoneNum = nDoneNum + 1
--		end
	end
--	if nDoneNum >= x890086_g_ShengWangAll_MissionRealCount then
--		x890086_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_10}")
--		return 0
--	end
	
	return 1
end
--**********************************
--本次是否拥有该任务
--**********************************
function x890086_CanDoMission( sceneId, selfId, idMission)
	if GetLevel(sceneId, selfId) < x890086_g_MinLevel then
		return 0
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 or x890086_g_ShengWangAll_MissionInfo[nCampId] == nil then
		return 0
	end
	for i = 1,x890086_g_ShengWangAll_MissionCount do		
		local nMissionIndex = LuaFnGetShengWangMissionIndex(sceneId,selfId,i - 1)
		if x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex] ~= nil and x890086_g_ShengWangAll_MissionInfo[nCampId][nMissionIndex].missionid == idMission then
			--不能已经完成了
			if LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i - 1) == 0 then
				return 1
			else
				--已经完成的情况下检查另一组任务是否完成
				if LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i - 1 + 3) == 0 then
					return 1
				end
			end
		end
	end
	return 0
end
--**********************************
--扫荡
--**********************************
function x890086_SaoDang( sceneId, selfId, targetId,npcCampId)
	--等级
	if GetLevel(sceneId,selfId) < 85 then
		x890086_NotifyMsg( sceneId, selfId,"#{SWXT_221213_78}")
		return
	end
	--是否属于该势力
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId ~= npcCampId  then
		x890086_NotifyMsg( sceneId, selfId,"#{SWXT_221213_81}")
		return
	end
	local nCostMoney = 0
	local nBonus = 0
	local nUndoNum = 0
	for i=1,6 do
		local doneNum =0
		local nIndex = LuaFnGetShengWangMissionIndex(sceneId,selfId,i-1)
		local nDone = LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i-1)

		local tempList = x890086_g_ShengWangAll_MissionInfo[nCampId]
		if tempList ==nil then
			return
		end
		local nMissionList = tempList[nIndex]
		if nMissionList == nil then
			return
		end

		local isHaveMission = IsHaveMission(sceneId,selfId, nMissionList.missionid)
		if isHaveMission == 0 and nDone == 0 then
			nUndoNum=nUndoNum+1
			nBonus = nBonus + nMissionList.bonus
			if nMissionList.bonus == 10 then
				--简单
				nCostMoney = nCostMoney + 40000
			elseif nMissionList.bonus == 15 then
				--普通
				nCostMoney = nCostMoney + 60000
			elseif nMissionList.bonus == 25 then
				--困难
				nCostMoney = nCostMoney + 100000
			end
		end
	end
	if nUndoNum == 0 then
		x890086_NotifyMsg( sceneId, selfId,"#{SWXT_230919_4}")
		return
	end
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nUndoNum)		
		UICommand_AddInt( sceneId, floor(nCostMoney / 10000) )	
		UICommand_AddInt( sceneId, nBonus )	
		UICommand_AddInt( sceneId, targetId )	
		UICommand_AddInt( sceneId, npcCampId )	
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89008601 )
end
--**********************************
--扫荡确认
--**********************************
function x890086_SaoDangConfirm( sceneId, selfId,nNum,nJiaoZi,nBouns, targetId,npcCampId)
	--等级
	if GetLevel(sceneId,selfId) < 85 then
		x890086_NotifyMsg( sceneId, selfId,"#{SWXT_221213_78}")
		return
	end
	--是否属于该势力
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId ~= npcCampId  then
		x890086_NotifyMsg( sceneId, selfId,"#{SWXT_221213_81}")
		return
	end
	local nCostMoney = 0
	local nWillAddPoint = 0
	local nUndoNum = 0
	for i=1,6 do
		local doneNum =0
		local nIndex = LuaFnGetShengWangMissionIndex(sceneId,selfId,i-1)
		local nDone = LuaFnGetShengWangMissionDoneFlag(sceneId,selfId,i-1)

		local tempList = x890086_g_ShengWangAll_MissionInfo[nCampId]
		if tempList ==nil then
			return
		end
		local nMissionList = tempList[nIndex]
		if nMissionList == nil then
			return
		end

		local isHaveMission = IsHaveMission(sceneId,selfId, nMissionList.missionid)
		if isHaveMission == 0 and nDone == 0 then
			nUndoNum=nUndoNum+1
			nWillAddPoint = nWillAddPoint + nMissionList.bonus
			if nMissionList.bonus == 10 then
				--简单
				nCostMoney = nCostMoney + 40000
			elseif nMissionList.bonus == 15 then
				--普通
				nCostMoney = nCostMoney + 60000
			elseif nMissionList.bonus == 25 then
				--困难
				nCostMoney = nCostMoney + 100000
			end
		end
	end
	if nUndoNum == 0 then
		x890086_NotifyMsg( sceneId, selfId,"#{SWXT_230919_4}")
		return
	end
	--金钱检测
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < nCostMoney then
		x890086_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{SWXT_230919_8}",floor(nCostMoney / 10000)) )
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, nCostMoney)
	--标记任务完成
	for i=1,6 do
		LuaFnSetShengWangMissionDoneFlag(sceneId,selfId,i - 1,1)
		--【天鉴战令】标记完成
		CallScriptFunction(890215, "OnFinishMission",sceneId, selfId, 1)
	end
	--镌春令处理
	local nCurWeekPoint = GetMissionData(sceneId,selfId,MD_SWXT_QURWEEKPOINT)
	if nCurWeekPoint < x890086_g_WeekMax then
		local nCurPoint = LuaFnGetShengWangPoint(sceneId,selfId)
		if nCurWeekPoint + nWillAddPoint >= x890086_g_WeekMax then
			nWillAddPoint = x890086_g_WeekMax - nCurWeekPoint
		end
		LuaFnSetShengWangPoint(sceneId,selfId,nCurPoint + nWillAddPoint)
		SetMissionData(sceneId,selfId,MD_SWXT_QURWEEKPOINT,nCurWeekPoint + nWillAddPoint)
	end
	--SWXT_230919_9	您使用任务扫荡完成了%s0个天鉴任务，获得%s1个镌春令。	
	x890086_NotifyMsg(sceneId,selfId,ScriptGlobal_Format("#{SWXT_230919_9}",tostring(nUndoNum),tostring(nWillAddPoint)))
	--关闭页面
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89008602 )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
end
--**********************************
--信息提示
--**********************************
function x890086_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end