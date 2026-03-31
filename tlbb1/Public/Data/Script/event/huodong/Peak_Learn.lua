-- 武境系统 @WAYLEE

--脚本号
x502161_g_scriptId = 502161

function x502161_OnDefaultEvent(sceneId, selfId, targetId)
	BeginEvent(sceneId)
		AddText(sceneId, "    武学之境，自体而发，然欲修炼至极，须以心悟之。萧大侠能达此等巅峰之境，盖因他除练功强体之外，亦以心感悟大千世界，思索“武”之精髓、“侠”之真意，施主当以他为楷模。")	
		AddNumText(sceneId, x502161_g_scriptId, "武境修习", 6, 1)
		AddNumText(sceneId, x502161_g_scriptId, "#{DFJC_250709_93}", 11, 2)
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

function x502161_OnEventRequest(sceneId, selfId, targetId, eventId)
	local key = GetNumText()
	if key == 1 then
		x502161_OpenDfeng( sceneId, selfId, targetId )
		return
	end
	if key == 2 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{DFJC_250709_96}")	
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
end

function x502161_OpenDfeng( sceneId, selfId, targetId )
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,20250806)
end

function x502161_SetDfengAttackDefence( sceneId, selfId, targetId,p1,p2,p3 )
	--守御点,攻击点,守御门派,攻击门派
	local MP1 = MathCilCompute_4_In(p1)
	local MP2 = MathCilCompute_4_In(p2)
	local MP3 = MathCilCompute_4_In(p3)

	local Point1 = GetDFengAttackXDD(sceneId,selfId)
	local Point2 = GetDFengDefenceXDD(sceneId,selfId)
	if MP1[2] ~= 0 and MP2[2] ~= 0 and MP3[2] ~= 0 and (MP1[1] == MP2[1] or MP1[1] == MP3[1] or MP2[1] == MP3[1]) then
		x502161_NotifyTip( sceneId, selfId, "攻击门派选择重复！" )
		return
	end	
	if MP1[2] ~= 0 and MP2[2] ~= 0 and MP3[2] ~= 0 and (MP1[2] == MP2[2] or MP1[2] == MP3[2] or MP2[2] == MP3[2]) then
		x502161_NotifyTip( sceneId, selfId, "守御门派选择重复！"..MP3[2] )
		return
	end	
	if MP1[3] + MP2[3] + MP3[3] > Point1 then
		x502161_NotifyTip( sceneId, selfId, "非法数据！" )
		return
	end
	if MP1[4] + MP2[4] + MP3[4] > Point2 then
		x502161_NotifyTip( sceneId, selfId, "非法数据！" )
		return
	end
	
	SetMissionData(sceneId,selfId,MD_DFeng_AttackDefenceType1,MathCilCompute_4_Out(MP1))
	SetMissionData(sceneId,selfId,MD_DFeng_AttackDefenceType2,MathCilCompute_4_Out(MP2))
	SetMissionData(sceneId,selfId,MD_DFeng_AttackDefenceType3,MathCilCompute_4_Out(MP3))
	x502161_NotifyTip( sceneId, selfId, "提交成功！" )

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,38003676)
end

function x502161_CleanDfengAttackDefence( sceneId, selfId, targetId )
	local nWuJingLevel = GetMissionData(sceneId,selfId,MD_DFeng_Level)
	if nWuJingLevel <= 0 then
		x502161_NotifyTip( sceneId, selfId, "尚未修习武境真诀，无需重置。" )
		return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, 38003676) < 1 then
		x502161_NotifyTip( sceneId, selfId, "您背包内没有未锁定的武诀易筋丹，可前往元宝商店进行购买。" )
		return
	end
	if LuaFnDelAvailableItem(sceneId,selfId,38003676,1) ~= 1 then
		x502161_NotifyTip( sceneId, selfId, "武诀易筋丹扣除失败，是否加锁。" )
		return
	end
	
	SetMissionData(sceneId,selfId,MD_DFeng_AttackDefenceType1,0)
	SetMissionData(sceneId,selfId,MD_DFeng_AttackDefenceType2,0)
	SetMissionData(sceneId,selfId,MD_DFeng_AttackDefenceType3,0)

	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,38003676)
	x502161_NotifyTip( sceneId, selfId, "武境真诀重置成功！" )
end

function x502161_GetTargetWuJingData( sceneId, selfId,nTargetGUID)
	if nTargetGUID == nil or nTargetGUID < 1000 then
		x502161_NotifyTip( sceneId, selfId, "目标玩家数据异常，请重新获取对方资料 E-TARGET-ID-LONG" )
		return
	end
    local nTargetID = LuaFnGuid2ObjId( sceneId,nTargetGUID)
	if nTargetID == nil or nTargetID <= 0 then
		x502161_NotifyTip( sceneId, selfId, "目标玩家数据异常，请重新获取对方资料 E-TARGET-ID-ILL" )
		return
	end
	local objType = GetCharacterType( sceneId, nTargetID )
	if objType ~= 1 then
		return
	end
	if LuaFnIsObjValid(sceneId,nTargetID) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,nTargetID) ~= 1 then
		return
	end
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,GetMissionData(sceneId,nTargetID,MD_DFeng_Level))
		UICommand_AddInt(sceneId,GetMissionData(sceneId,nTargetID,MD_DFeng_AttackDefenceType1))
		UICommand_AddInt(sceneId,GetMissionData(sceneId,nTargetID,MD_DFeng_AttackDefenceType2))
		UICommand_AddInt(sceneId,GetMissionData(sceneId,nTargetID,MD_DFeng_AttackDefenceType3))
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,20251127)
end

function GetDFengAttackXDD(sceneId,selfId)	--攻击点数
	local nWuJingLevel = GetMissionData(sceneId,selfId,MD_DFeng_Level)
	local LvList = {10,30,50,70,90,110,130,150,170,190}
	local Out = 0
	for i=1,10 do
		if  nWuJingLevel >= LvList[i] then
			Out = Out + 2
		end
	end
	return Out
end

function GetDFengDefenceXDD(sceneId,selfId)	--防御点数
	local nWuJingLevel = GetMissionData(sceneId,selfId,MD_DFeng_Level)
	local LvList = {20,40,60,80,100,120,140,160,180,200}
	local Out = 0
	for i=1,10 do
		if  nWuJingLevel >= LvList[i] then
			Out = Out + 2
		end
	end
	return Out
end

function MathCilCompute_4_In(nData)
	local nTab = {}
	for i = 1,4 do
		nTab[i] = mod(floor(nData/10 ^ (2 * (i - 1))),100)
	end
	return nTab
end

function MathCilCompute_4_Out(nData)
	local nFinalData = 0
	for i = 1,4 do
		nFinalData = nFinalData + nData[i] * 10 ^ (2 * (i - 1))
	end
	return nFinalData
end

function x502161_AddWuJingExp(sceneId,selfId,nAddExp)
	if nAddExp <= 0 then
		return
	end

	if GetLevel(sceneId,selfId) < 85 then
		return
	end	
	
	local nWuJingLevel = GetMissionData(sceneId,selfId,MD_DFeng_Level)
	local nWuJingExp = GetMissionData(sceneId,selfId,MD_DFeng_Exp)
	
	if nWuJingLevel >= 200 then
		SetMissionData(sceneId,selfId,MD_DFeng_Exp,0)
		return
	end
	local WeekCount = GetMissionData(sceneId,selfId,MD_WEEKDFeng_Count)
	local nDayTime = floor(WeekCount/10)
	local nCount = mod(WeekCount,10)
	local nTodayOne = GetMondayDate(sceneId, selfId)
	if nDayTime ~= nTodayOne then
		nCount = 0
	end

	-- if nDayTime == nTodayOne and nCount >= 7 then
		-- x502161_NotifyTip( sceneId, selfId, "#G本周武境可提升等级已达上限，无法继续获得武境经验。！" )
		-- return
	-- end
	
	-- 经验倍率计算
    local fExpRate = 1.0
    local bIsDoubleExp = DEGetMoneyTime(sceneId, selfId) > 0
    
    -- 双倍经验加成
    if bIsDoubleExp then
        fExpRate = 2.0
    end
    
    -- 玄灵丹(98号buff) + 双倍经验时，额外*2.0
    if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 98) == 1 and bIsDoubleExp then
        fExpRate = fExpRate * 2.0
    else
        -- 人物2.5倍(60号buff)
        if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 60) == 1 then
            fExpRate = fExpRate * 2.5
        end
        
        -- 小灵丹(62号buff) 人物1.5倍
        if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 62) == 1 then
            fExpRate = fExpRate * 1.5
        end
    end
	
	-- 计算最终经验
    local nFinalExp = math.floor(nAddExp * fExpRate)
    local nBonusExp = nFinalExp - nAddExp
	 
	if nBonusExp > 0 then
        x502161_NotifyTip(sceneId, selfId, "你获得"..nAddExp.."武境经验，同时获得武境经验奖励"..nBonusExp)
    else
        x502161_NotifyTip(sceneId, selfId, "你获得"..nAddExp.."武境经验")
    end
	
	SetMissionData(sceneId, selfId, MD_DFeng_Exp, nWuJingExp + nFinalExp)
	nWuJingExp = GetMissionData(sceneId,selfId,MD_DFeng_Exp)
	
	local nExpList = {20000000,40000000,70000000,100000000,150000000,200000000,250000000,250000000,250000000,250000000}
	local nExpIndex = floor(nWuJingLevel/20) + 1

	if nExpIndex > 10 then
		nExpIndex = 10
	end
	
	if nWuJingExp >= nExpList[nExpIndex] then
		SetMissionData(sceneId,selfId,MD_DFeng_Level,nWuJingLevel + 1)
		x502161_NotifyTip( sceneId, selfId, "恭喜您将武境等级提升至"..(nWuJingLevel + 1).."级，您获得了新的属性增强！" )
		SetMissionData(sceneId,selfId,MD_DFeng_Exp,nWuJingExp - nExpList[floor(nWuJingLevel/20) + 1])
		--SetMissionData(sceneId,selfId,MD_WEEKDFeng_Count,nTodayOne * 10 + nCount + 1)
		
		-- 调用属性结算
		CallScriptFunction((866010), "StartComputeHumanData",sceneId, selfId,1)
	end

end
--=========================
--确定周一的日期
--=========================
function GetMondayDate(sceneId, selfId)
	local xq = GetTodayWeek()
	local ys = mod(xq,7)
	local rq = GetDayTime()
	if ys == 1 then
		return rq
	elseif ys == 0 then
		return rq - 6
	else
		return rq - ys + 1
	end
end

function x502161_GetDfengAttr(sceneId, selfId)
	local nWuJingLevel = GetMissionData(sceneId,selfId,MD_DFeng_Level)
	local nDFVar = {36,36,36,36,2,2,2,2,1,2,36,36,36,36,2,2,2,2,1,2}
	local Attr = {0,0,0,0,0,0,0,0,0}
	--"外功攻击","外功防御","内功攻击","内功防御","体力","力量","灵气","定力","身法"
	for i=1,nWuJingLevel do
		if mod(i,10) ~= 0 then
			Attr[mod(i,10)] = Attr[mod(i,10)] + nDFVar[mod(i,10)]
		end
	end
	return Attr[1],Attr[2],Attr[3],Attr[4],Attr[5],Attr[6],Attr[7],Attr[8],Attr[9]
end

function x502161_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end