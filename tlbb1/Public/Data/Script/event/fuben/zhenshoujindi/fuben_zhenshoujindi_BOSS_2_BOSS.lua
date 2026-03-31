--弈BOSSAI逻辑

--脚本号
x893026_g_ScriptId	= 893026

--副本逻辑脚本号....
x893026_g_FuBenScriptId = 893020
--动阻控制脚本
x893026_g_DynamicBlockScriptId	= 893038

x893026_g_SceneData_BOSS_2_WillKillType = 13	--BOSS2 逸当前的灵狐暴走类型 0 阴 1 阳
x893026_g_SceneData_BOSS_2_WillKillNum = 14		--BOSS2 逸当前的灵狐击杀数量
x893026_g_SceneData_InitLevel = 25				--副本的难度等级
x893026_g_SceneData_Level = 26					--副本的等级

--AI Index....
x893026_IDX_SkillA_CD						= 1	--A技能的CD时间....
x893026_IDX_SkillA_Step						= 2 --A技能的阶段 1 2种状态
x893026_IDX_Skill_Line_CD					= 3 --连线伤害检测计时器....
x893026_IDX_SkillCycle_Timer = 4 -- 技能周期计时器
x893026_IDX_SkillC_SubCycle_Timer = 5 -- 灵狐暴走小周期计时器
x893026_CurrentStage = 6 -- 当前技能阶段
x893026_SkillC_SubCycle_Count_Remaining = 7 -- 灵狐暴走小周期剩余次数

-- 总技能周期时间配置
x893026_SkillCycle_Duration_Stage1 = 10000 -- 第1阶段：阴阳无咎 (10s)
x893026_SkillCycle_Duration_Stage2 = 10000 -- 第2阶段：阴阳有时 (10s)
x893026_SkillCycle_Duration_Stage3 = 10000 -- 第3阶段：灵狐暴走 (10s)

x893026_SkillC_SubCycle_Interval = 16000 -- 灵狐暴走小周期间隔时间 (16s)
x893026_SkillC_SubCycle_Count = 2 -- 灵狐暴走小周期释放次数

--A阴阳无咎(对玩家)释放....
x893026_SkillA_SkillID		= 3352
x893026_SkillA_CD			= 10000
x893026_SkillA_PlayerIMPACT_A = 42986
x893026_SkillA_PlayerIMPACT_B = 42987
x893026_SkillA_PlayerIMPACT_Line = 42988
x893026_SkillA_PlayerIMPACT_LineSame = 42989
x893026_SkillA_PlayerIMPACT_BOSS_A = 42991
x893026_SkillA_PlayerIMPACT_BOSS_B = 42992
x893026_SkillA_DecHP = 42990
x893026_SkillA_LineCD		= 500

--阴阳有时
x893026_SkillID_YYYS	= 3357

--灵狐暴走
x893026_SkillC_SkillID		= 3358
x893026_SkillC_Impact 		= 42993

x893026_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
--**********************************
--入口函数
--**********************************
function x893026_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x893026_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_CD, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_Step, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_Skill_Line_CD, 0 )	
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillCycle_Timer, x893026_SkillCycle_Duration_Stage1)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillC_SubCycle_Timer, 0)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_CurrentStage, 1)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_SkillC_SubCycle_Count_Remaining, x893026_SkillC_SubCycle_Count)
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893026_IDX_CombatFlag,0 )
end

--**********************************
--初始化....
--**********************************
function x893026_OnInit(sceneId, selfId)
	--重置AI....
	x893026_ResetMyAI( sceneId, selfId )
	--技能释放间隔处理
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, 7) ;--副本类型 0-普通 1-困难
	if nFubenType == 1 then
		
	end
end

--**********************************
--心跳....
--**********************************
function x893026_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893026_IDX_CombatFlag ) then
		return
	end
	--A技能心跳....
	x893026_TickSkillA_Impact(sceneId, selfId, nTick)
	-- 获取技能周期计时器
    local skillCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillCycle_Timer)
    local currentStage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893026_CurrentStage)
    skillCycleTimer = skillCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillCycle_Timer, skillCycleTimer)

    if skillCycleTimer <= 0 then
        if currentStage == 1 then
            -- 第1阶段结束，释放“阴阳无咎”
            if x893026_UseSkillA(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillCycle_Timer, x893026_SkillCycle_Duration_Stage2)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_CurrentStage, 2)
                return
            end
        elseif currentStage == 2 then
            -- 第2阶段结束，释放“阴阳有时”
            if x893026_UseSkill_YYYS(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillCycle_Timer, x893026_SkillCycle_Duration_Stage3)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_CurrentStage, 3)
                return
            end
        elseif currentStage == 3 then
            -- 第3阶段，开始释放“灵狐暴走”并进入小周期
            if x893026_HandleSkillCSubCycle(sceneId, selfId, nTick) == 1 then
                return
            else
                -- 如果灵狐暴走小周期释放完成，则重置AI进入下一个大周期
                local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893026_SkillC_SubCycle_Count_Remaining)
                if remainingSubCycles <= 0 then
                    x893026_ResetMyAI(sceneId, selfId)
                end
                return
            end
        end
    end
end

--**********************************
--处理灵狐暴走小周期
--**********************************
function x893026_HandleSkillCSubCycle(sceneId, selfId, nTick)
    -- 获取灵狐暴走小周期计时器
    local subCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillC_SubCycle_Timer)
    local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893026_SkillC_SubCycle_Count_Remaining)

    subCycleTimer = subCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillC_SubCycle_Timer, subCycleTimer)

    if subCycleTimer <= 0 and remainingSubCycles > 0 then
        if x893026_UseSkillC(sceneId, selfId) == 1 then
            -- 更新小周期计时器
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_IDX_SkillC_SubCycle_Timer, x893026_SkillC_SubCycle_Interval)
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893026_SkillC_SubCycle_Count_Remaining, remainingSubCycles - 1)
            return 1
        else
            return 0
        end
    end
    return 0
end

--**********************************
--阴阳无咎 逻辑心跳
--**********************************
function x893026_TickSkillA_Impact( sceneId, selfId, nTick )
	
	--是否给玩家们状态了
	local nStep = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_Step )
	if nStep ~= 1 then
		return
	end
	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_CD, cd-nTick )
		
		--连线检测
		local cdLine = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893026_IDX_Skill_Line_CD )
		if cdLine > nTick then
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_Skill_Line_CD, cdLine-nTick )
		else
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_Skill_Line_CD, x893026_SkillA_LineCD-(nTick-cdLine) )
			--遍历场景内连线玩家
			local tPlayerID_D = {}
			local tPlayerID_S = {}
			local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanCount-1 do
				local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
					if LuaFnHaveImpactOfSpecificDataIndex(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_Line) == 1 then
						tinsert(tPlayerID_D,nHumanId)
					end
					if LuaFnHaveImpactOfSpecificDataIndex(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_LineSame) == 1 then
						tinsert(tPlayerID_S,nHumanId)
					end
				end
			end
			--需要远离
			if getn(tPlayerID_D) >= 2 then
				for i = 1,getn(tPlayerID_D) do
					for j = 1,getn(tPlayerID_D) do
						if tPlayerID_D[i] ~= tPlayerID_D[j] then
							if IsInDist(sceneId,tPlayerID_D[i],tPlayerID_D[j],4) == 1 then
								--掉血
								LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, tPlayerID_D[i], x893026_SkillA_DecHP, 0 )
								LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, tPlayerID_D[j], x893026_SkillA_DecHP, 0 )
							else
								LuaFnCancelSpecificImpact(sceneId,tPlayerID_D[i],x893026_SkillA_PlayerIMPACT_Line)
								LuaFnCancelSpecificImpact(sceneId,tPlayerID_D[j],x893026_SkillA_PlayerIMPACT_Line)
							end
						end
					end
				end
			end
			--需要靠近
			if getn(tPlayerID_S) >= 2 then
				for i = 1,getn(tPlayerID_S) do
					for j = 1,getn(tPlayerID_S) do
						if tPlayerID_S[i] ~= tPlayerID_S[j] then
							--取消
							if IsInDist(sceneId,tPlayerID_S[i],tPlayerID_S[j],4) == 1 then
								LuaFnCancelSpecificImpact(sceneId,tPlayerID_S[i],x893026_SkillA_PlayerIMPACT_LineSame)
								LuaFnCancelSpecificImpact(sceneId,tPlayerID_S[j],x893026_SkillA_PlayerIMPACT_LineSame)
							else
								--掉血
								LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, tPlayerID_S[i], x893026_SkillA_DecHP, 0 )
								LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, tPlayerID_S[j], x893026_SkillA_DecHP, 0 )
							end
						end
					end
				end
			end
			
		end
		
		
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_CD, x893026_SkillA_CD-(nTick-cd) )
		--进入技能主逻辑
		--挑选两个玩家连线
		local tPlayerImpactA = {}
		local tPlayerImpactB = {}
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				--删除身上的IMPACT
				LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_Line)
				LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_LineSame)
				--清理玩家身上原有的阴阳状态
				LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_A)
				LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_B)
				--赋予新的阴阳状态
				if random(1,2) == 1 then
					LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, nHumanId, x893026_SkillA_PlayerIMPACT_A, 0 )
					tinsert(tPlayerImpactA,nHumanId)
				else
					LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, nHumanId, x893026_SkillA_PlayerIMPACT_B, 0 )
					tinsert(tPlayerImpactB,nHumanId)
				end
			end
		end
		--两个玩家以上再执行逻辑
		if getn(tPlayerImpactA) >= 2 then
			--建立连线
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, tPlayerImpactA[1], tPlayerImpactA[1], x893026_SkillA_PlayerIMPACT_Line, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, tPlayerImpactA[1], tPlayerImpactA[random(2,getn(tPlayerImpactA))], x893026_SkillA_PlayerIMPACT_Line, 0 )
		end
		if getn(tPlayerImpactB) >= 2 then
			--建立连线
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, tPlayerImpactA[1], tPlayerImpactA[1], x893026_SkillA_PlayerIMPACT_Line, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, tPlayerImpactB[1], tPlayerImpactB[random(2,getn(tPlayerImpactB))], x893026_SkillA_PlayerIMPACT_Line, 0 )
		end
		if getn(tPlayerImpactA) >= 2 and getn(tPlayerImpactB) >= 2 then
			--逻辑状态靠近
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, tPlayerImpactA[1], tPlayerImpactB[1], x893026_SkillA_PlayerIMPACT_LineSame, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, tPlayerImpactB[1], tPlayerImpactA[1], x893026_SkillA_PlayerIMPACT_LineSame, 0 )
		end
		
	end
end

--**********************************
--阴阳无咎 首次释放
--**********************************
function x893026_UseSkillA( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893026_SkillA_SkillID) ~= 1 then
		return 0
	end
	--发表讲话
	--阁下当真知晓，何谓阴阳？
	PaoPaoExEx(sceneId,selfId, 505)
	--通知
	CallScriptFunction(x893026_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_69}")
	--技能显示
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893026_SkillA_SkillID, selfId, x, z, 0, 1 )
	--先遍历所有玩家，筛选出符合条件的有效玩家ID
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local validHumanIds = {}
	for i = 0, nHumanCount - 1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 
		   and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 
		   and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			tinsert(validHumanIds, nHumanId)
		end
	end
	-- 根据有效玩家数量平衡分配两种状态
	local numValid = getn(validHumanIds)
	local numA = floor(numValid / 2)
	local numB = numValid - numA

	local effectTable = {}
	for i = 1, numA do
		tinsert(effectTable, x893026_SkillA_PlayerIMPACT_A)
	end
	for i = 1, numB do
		tinsert(effectTable, x893026_SkillA_PlayerIMPACT_B)
	end
	-- 对 effectTable 进行 Fisher-Yates 洗牌
	for i = getn(effectTable), 2, -1 do
		local j = random(1, i)
		effectTable[i], effectTable[j] = effectTable[j], effectTable[i]
	end
	-- 对每个有效玩家先清除原有状态，再赋予预先分配的效果
	local count = getn(validHumanIds)
	for i = 1, count do
		local nHumanId = validHumanIds[i]
		LuaFnCancelSpecificImpact(sceneId, nHumanId, x893026_SkillA_PlayerIMPACT_A)
		LuaFnCancelSpecificImpact(sceneId, nHumanId, x893026_SkillA_PlayerIMPACT_B)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanId, effectTable[i], 0)
	end
	--标记已经释放
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893026_IDX_SkillA_Step, 1 )
	return 1
end

--**********************************
--阴阳无咎 首次释放
--**********************************
function x893026_UseSkill_YYYS( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893026_SkillID_YYYS) ~= 1 then
		return 0
	end
	--清理BOSS身上的BUFF效果-阴阳有时
	--技能显示-阴阳有时
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893026_SkillID_YYYS, selfId, x, z, 0, 1 )
	
	CallScriptFunction(x893026_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_70}")
	LuaFnCancelSpecificImpact(sceneId,selfId,x893026_SkillA_PlayerIMPACT_BOSS_A)
	LuaFnCancelSpecificImpact(sceneId,selfId,x893026_SkillA_PlayerIMPACT_BOSS_B)
	if random(1,2) == 1 then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893026_SkillA_PlayerIMPACT_BOSS_A, 0 )
	else
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893026_SkillA_PlayerIMPACT_BOSS_B, 0 )
	end
	return 1
	--BOSS身上的效果变换后，如果异效玩家攻击，从程序结算对玩家的伤害
	--返伤是45%
end

--**********************************
--灵狐暴走
--**********************************
function x893026_UseSkillC( sceneId, selfId )
	--能否释放技能
--	if LuaFnCanUnitUseSkill(sceneId,selfId,x893026_SkillC_SkillID) ~= 1 then
--		return 0
--	end
	--发表讲话
	--小狐狸们干活了
	PaoPaoExEx(sceneId,selfId, 507)
	--放置自己到中心点
	SetPos(sceneId,selfId,141,198)
	--技能显示
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893026_SkillC_SkillID, selfId, x, z, 0, 1 )
	--标记当前的状态
	--	ZSFB_20220105_147	#H逸释放了黑狐暴走，请少侠击败所有黑狐。	
	--	ZSFB_20220105_148	#H逸释放了白狐暴走，请少侠击败所有白狐。	
	local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893026_SkillC_SubCycle_Count_Remaining)
	if remainingSubCycles == 2 then
		LuaFnSetCopySceneData_Param(sceneId,x893026_g_SceneData_BOSS_2_WillKillType, 1);
		CallScriptFunction(x893026_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_148}")
	else
		LuaFnSetCopySceneData_Param(sceneId,x893026_g_SceneData_BOSS_2_WillKillType, 0);
		CallScriptFunction(x893026_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_147}")
	end
	--清理历史击杀数量
	LuaFnSetCopySceneData_Param(sceneId,x893026_g_SceneData_BOSS_2_WillKillNum, 0);
	--创建灵狐
	for i = 1,24 do
		local nMonsterDataId = 49745;
		if mod(i,2) == 0 then
			nMonsterDataId = 49746
		end
		local nBeginPosX,nBeginPosZ = GetBeginPatrolPoint(sceneId,4 + i - 1)
		local nMonsterId = LuaFnCreateMonster( sceneId,nMonsterDataId ,nBeginPosX,nBeginPosZ, 3, -1, x893026_g_FuBenScriptId )
		SetPatrolId(sceneId, nMonsterId, 4 + i - 1)
		if mod(i,2) == 0 then
			SetCharacterTitle( sceneId, nMonsterId, "阴" )
		else	
			SetCharacterTitle( sceneId, nMonsterId, "阳" )
		end
		SetCharacterDieTime(sceneId, nMonsterId,16000)
	end
	return 1
end


--**********************************
--技能释放成功
--**********************************
function x893026_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--灵狐暴走 结算
	if nSkillId == x893026_SkillC_SkillID then
		local nCurKillNum = LuaFnGetCopySceneData_Param(sceneId,x893026_g_SceneData_BOSS_2_WillKillNum);
		if nCurKillNum >= 12 then
			return
		end
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, nHumanId, x893026_SkillC_Impact, 0 )
			end
		end
		
	end
end

--**********************************
--进入战斗....
--**********************************
function x893026_OnEnterCombat(sceneId, selfId, enmeyId)
	--重置AI....
	x893026_ResetMyAI( sceneId, selfId )
	--发表讲话 来吧
	PaoPaoExEx(sceneId,selfId, 528)
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893026_IDX_CombatFlag, 1 )
	--关闭入口
	CallScriptFunction(x893026_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,1);
	CallScriptFunction(x893026_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,6);
end


--**********************************
--离开战斗....
--**********************************
function x893026_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x893026_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
	--清理动阻
	CallScriptFunction(x893026_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893026_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,6);
end

--**********************************
--杀死敌人....
--**********************************
function x893026_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x893026_OnDie( sceneId, selfId, killerId )
	--清理全场玩家的特殊状态
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			--删除身上的IMPACT
			LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_Line)
			LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_LineSame)
			--清理玩家身上原有的阴阳状态
			LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_A)
			LuaFnCancelSpecificImpact(sceneId,nHumanId,x893026_SkillA_PlayerIMPACT_B)
		end
	end
	
	CallScriptFunction(x893026_g_FuBenScriptId, "OnBOSSYiDie", sceneId,selfId);
end

--**********************************
--对话框提示
--**********************************
function x893026_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

