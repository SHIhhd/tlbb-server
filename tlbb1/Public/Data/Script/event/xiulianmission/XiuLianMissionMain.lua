--脚本号
x891272_g_ScriptId = 891272
--目标NPC：接任务、交任务，都是这个
x891272_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}}, --替代2022
}
--接受任务距离
x891272_g_AcceptDist = 5
--接受任务要求最低等级
x891272_g_MissionLevel = 60
--目前可枚举的子任务
x891272_g_MissionList = {
	--答题任务 ok
	[1] = {missionId = 2030,scriptId = 891274,name="#{XLRW_210725_472}"},
	--天材地宝 ok
	[2] = {missionId = 2031,scriptId = 891275,name="#{XLRW_210725_473}"},
	--养神调息 打坐任务 ok
	[3] = {missionId = 2032,scriptId = 891276,name="#{XLRW_210725_474}"},
	--清理恶痞 ok
	[4] = {missionId = 2033,scriptId = 891277,name="#{XLRW_210725_475}"},
	--参武切磋 ok 
	[5] = {missionId = 2034,scriptId = 891278,name="#{XLRW_210725_476}"},
	--珍物秘宝 ok
	[6] = {missionId = 2035,scriptId = 891279,name="#{XLRW_210725_477}"},
	--通达各派
	[7] = {missionId = 2036,scriptId = 891280,name="#{XLRW_210725_478}"},
	--复命
	[8] = {missionId = 2037,scriptId = 891281,name="#{XLRW_210725_479}"},
}
--放弃任务后多久可接
x891272_g_AbandonAvibleTime = 60 * 30
--武道玄元丹
x891272_g_BonusItem = 38002397
--武道引导任务 ‘勘破玄机得灵识’
x891272_g_MissionId = 2026
--武道的环数奖励
x891272_g_PirzeRound = {
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
	2,2,3,3,5,
}
--双倍修行消耗
x891272_g_DoubleCost = 200000
--**********************************
--任务入口函数
--**********************************
function x891272_OnDefaultEvent( sceneId, selfId, targetId,numText )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891272_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891272_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nTalentType - 1 ~= nSectType then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891272_g_AcceptDist) ~= 1 then
		x891272_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891272_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891272_g_MissionLevel then
		x891272_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891272_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	
	local nCurWeekCount = x891272_GetWeekMissionCount(sceneId, selfId)
	if numText == 1 then
		--想交付任务
		for i = 1,getn(x891272_g_MissionList) do
			if (IsHaveMission(sceneId,selfId,x891272_g_MissionList[i].missionId) > 0 ) then
				--周可做次数是否满了
				if nCurWeekCount >= getn(x891272_g_PirzeRound) then
					x891272_NotifyTip( sceneId, selfId, "#{XLRW_210725_184}" )
					x891272_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_200}" )
					return
				end
				CallScriptFunction( x891272_g_MissionList[i].scriptId, "OnSubmit",sceneId, selfId, targetId)
				return
			end
		end
	end
	
end
--**********************************
--接受武道任务
--**********************************
function x891272_OnAcceptMission( sceneId, selfId, targetId,bDouble,bAuto )
	if x891272_CheckAccept( sceneId, selfId ) <= 0 then
		return
	end
	local nLastAbandonTime = GetMissionDataEx(sceneId,selfId,MDEX_LAST_ABANDON_XIULIANMISSION);
	if nLastAbandonTime > 0 and LuaFnGetCurrentTime() < nLastAbandonTime then
		x891272_NotifyTip( sceneId, selfId, "#{XLRW_210725_159}" )
		x891272_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_158}" )
		return
	end
	if bDouble == 1 then
		--双倍消耗检测
		local selfMoney = GetMoney( sceneId, selfId )  +  GetMoneyJZ(sceneId, selfId)
		if selfMoney < x891272_g_DoubleCost then
			x891272_NotifyTip( sceneId, selfId, "#{WDEC_220425_87}" )
			x891272_NotifyBox( sceneId, selfId, targetId, "#{WDEC_220425_88}" )
			return
		end
		--扣金币
		if LuaFnCostMoneyWithPriority(sceneId,selfId ,x891272_g_DoubleCost) == -1 then
			x891272_NotifyTip( sceneId, selfId, "#{WDEC_220425_87}" )
			x891272_NotifyBox( sceneId, selfId, targetId, "#{WDEC_220425_88}" )
			return
		end
		--设置新的五环双倍任务
		SetMissionDataEx(sceneId,selfId,MDEX_DOUBLE_XIULIANMISSION,5)
	end
--		环数清0 准备重新计算
	x891272_SetXiuLianMissionNum(sceneId,selfId,0)	
	
	local nRandIndex = random(1,getn(x891272_g_MissionList))
	if x891272_g_MissionList[nRandIndex] ~= nil then
		CallScriptFunction( x891272_g_MissionList[nRandIndex].scriptId, "OnAccept",sceneId, selfId, targetId)
	end
end

--**********************************
--列举事件
--**********************************
function x891272_OnEnumerate( sceneId, selfId, targetId )
end

--**********************************
--检测接受条件
--**********************************
function x891272_CheckAccept( sceneId, selfId )
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891272_g_MissionLevel then
		return 0
	end
	
	-- 是否存在武道任务了
	if x891272_HaveXiuLianMission(sceneId,selfId) == 1 then
		return 0
	end
	
	return 1
end

--**********************************
--是否存在武道任务了
--**********************************
function x891272_HaveXiuLianMission( sceneId, selfId )
	for i = 1,getn(x891272_g_MissionList) do
		if (IsHaveMission(sceneId,selfId,x891272_g_MissionList[i].missionId) > 0 ) then
			return 1
		end
	end
	return 0
end
--**********************************
--玩家完成了任务
--**********************************
function x891272_OnFinishMission(sceneId, selfId, targetId, missionId)
	--删除任务
	DelMission( sceneId, selfId, missionId )
	--增加任务环数
	local nData = x891272_GetXiuLianMissionNum(sceneId, selfId)
	--第5环时不再派发
	if x891272_GetXiuLianMissionNum(sceneId, selfId) >= 5 then
		x891272_SetXiuLianMissionNum(sceneId,selfId,0)	
		x891272_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_672}",0) )
	else
		x891272_SetXiuLianMissionNum(sceneId,selfId,nData + 1)	
		--产生一个新的任务
		local nRandIndex = random(1,getn(x891272_g_MissionList))
		if x891272_g_MissionList[nRandIndex] ~= nil then
			CallScriptFunction( x891272_g_MissionList[nRandIndex].scriptId, "OnAccept",sceneId, selfId, targetId)
		end
	end
	--武道引导任务 ‘勘破玄机得灵识’ 对接
	if IsHaveMission(sceneId,selfId,x891272_g_MissionId) > 0 then
		if x891272_GetXiuLianMissionNum(sceneId, selfId) >= 4 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x891272_g_MissionId)
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)	
			SetMissionByIndex(sceneId,selfId,misIndex,1,1)	
		end
	end
	--增加周次数
	local nCurWeekCount = x891272_GetWeekMissionCount(sceneId, selfId)
	nCurWeekCount = nCurWeekCount + 1
	x891272_SetWeekMissionCount(sceneId, selfId,nCurWeekCount)
	--给武道点数
	local nPrizePoint = x891272_g_PirzeRound[nCurWeekCount]
	local nDoubleCount = GetMissionDataEx(sceneId,selfId,MDEX_DOUBLE_XIULIANMISSION)
	if nDoubleCount > 0 then
		nPrizePoint = nPrizePoint * 2
		nDoubleCount = nDoubleCount - 1
		if nDoubleCount <= 0 then
			nDoubleCount = 0
		end
		SetMissionDataEx(sceneId,selfId,MDEX_DOUBLE_XIULIANMISSION,nDoubleCount)
	end
	--增加武道点数
	LuaFnSetSectPoint(sceneId,selfId,LuaFnGetSectPoint(sceneId,selfId) + nPrizePoint)
	--如果为空应该是最后一次任务
	if x891272_g_PirzeRound[nCurWeekCount + 1] == nil then
		--XLRW_210725_201	    你已完成此轮武道修行，余下时间可用于沉淀所学。这样才可使你在下一次修行中有更多收益。	
		x891272_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_201}")
	end
	
	x891272_NotifyTip( sceneId, selfId,  format("恭喜您，获得了%d点武道领悟点。",nPrizePoint) )
	--特效
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

--**********************************
--玩家主动放弃子任务
--**********************************
function x891272_OnAbandonMission(sceneId, selfId,missionId)
	if IsHaveMission(sceneId,selfId,missionId) <= 0 then
		return
	end
	--环数清0
	x891272_SetXiuLianMissionNum(sceneId,selfId,0)	
	--删除任务
	DelMission( sceneId, selfId, missionId )
	--记录当前放弃任务的时间
	SetMissionDataEx(sceneId,selfId,MDEX_LAST_ABANDON_XIULIANMISSION,LuaFnGetCurrentTime() + x891272_g_AbandonAvibleTime)	
end

--**********************************
--任务当前环数
--周次 周任务数量 累计环数
--00000 00 000
--**********************************
function x891272_GetXiuLianMissionNum(sceneId, selfId)
	x891272_CheckXiuLianMission(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end
--**********************************
--任务当前环数
--周次 周任务数量 累计环数
--00000 00 000
--**********************************
function x891272_SetXiuLianMissionNum(sceneId, selfId,nNum)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	local nBeData = floor(nData / 1000) * 1000 + nNum;
	SetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM,nBeData)
end
--**********************************
--获取本周可进行的任务次数
--周次 周任务数量 累计环数
--00000 00 000
--**********************************
function x891272_GetWeekMissionCount(sceneId, selfId)
	x891272_CheckXiuLianMission(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	local nRoundWeek = mod(floor(nData / 1000),100)
	
	return nRoundWeek
end
function x891272_SetWeekMissionCount(sceneId, selfId,nRoundWeek)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	local nRound = mod(nData,1000)
	
	SetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM, nRoundWeek * 1000 + nRound)
end
--**********************************
--周次自动检测处理
--00 000
--**********************************
function x891272_CheckXiuLianMission(sceneId, selfId)
	local nWeekCur = GetWeekTime();		--当前时间	
	local nData = GetMissionDataEx(sceneId,selfId,MDEX_XIULIAN_MISSION_NUM)
	if nData == nWeekCur then
		return
	end
--	更新现在的状态
	SetMissionDataEx(sceneId,selfId,MDEX_XIULIAN_MISSION_NUM,nWeekCur)
	
	local nRoundWeek = 0
	local nRound = mod(nData,1000)
	SetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM, nRoundWeek * 1000 + nRound)
end
--**********************************
--对话窗口信息提示
--**********************************
function x891272_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891272_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end