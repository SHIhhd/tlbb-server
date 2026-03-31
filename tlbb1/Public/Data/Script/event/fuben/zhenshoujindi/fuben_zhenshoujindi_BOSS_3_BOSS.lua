--艾虎BOSSAI逻辑

--脚本号
x893028_g_ScriptId	= 893028

--副本逻辑脚本号....
x893028_g_FuBenScriptId = 893020
--动阻控制脚本
x893028_g_DynamicBlockScriptId	= 893038

x893028_g_SceneData_InitLevel = 25				--副本的难度等级
x893028_g_SceneData_Level = 26					--副本的等级

--技能的CD时间....
x893028_IDX_SkillCycle_Timer = 1 -- 技能周期计时器
x893028_IDX_SkillC_SubCycle_Timer = 2 -- 牛鸡冲击波小周期计时器
x893028_CurrentStage = 3 -- 当前技能阶段
x893028_SkillC_SubCycle_Count_Remaining = 4 -- 牛鸡冲击波小周期剩余次数

x893028_SkillCycle_Duration_Stage1 = 8000 -- 第1阶段：蛮牛出动 (5s)
x893028_SkillCycle_Duration_Stage2 = 10000 -- 第2阶段：虎啸山林 (10s)
x893028_SkillCycle_Duration_Stage3 = 10000 -- 第3阶段：牛鸡冲击波 (10s)
x893028_SkillCycle_Duration = x893028_SkillCycle_Duration_Stage1 + x893028_SkillCycle_Duration_Stage2 + x893028_SkillCycle_Duration_Stage3

x893028_SkillC_SubCycle_Interval = 5000 -- 牛鸡冲击波小周期间隔时间 (8s)
x893028_SkillC_SubCycle_Count = 2 -- 牛鸡冲击波小周期释放次数

--技能A 虎啸山林
x893028_SkillA_SkillID = 3360
--技能B 蛮牛出动
x893028_SkillB_SkillID = 3359
x893028_SkillB_MonsterDataId = 49588
x893028_SkillB_MonsterSkill = 3592

--技能B 牛鸡冲击波
x893028_SkillC_SkillID = 3361

x893028_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
--**********************************
--入口函数
--**********************************
function x893028_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x893028_ResetMyAI( sceneId, selfId )
	-- 重置计时器
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillCycle_Timer, x893028_SkillCycle_Duration)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillC_SubCycle_Timer, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_CurrentStage, 1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_SkillC_SubCycle_Count_Remaining, x893028_SkillC_SubCycle_Count)
end

--**********************************
--初始化....
--**********************************
function x893028_OnInit(sceneId, selfId)
	--重置AI....
	x893028_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x893028_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893028_IDX_CombatFlag ) then
		return
	end
	-- 获取技能周期计时器
    local skillCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillCycle_Timer)
    local currentStage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893028_CurrentStage)
    skillCycleTimer = skillCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillCycle_Timer, skillCycleTimer)
    if skillCycleTimer <= 0 then
        if currentStage == 1 then
            -- 第1阶段结束，释放“蛮牛出动”
            if x893028_UseSkillB(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillCycle_Timer, x893028_SkillCycle_Duration_Stage2)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_CurrentStage, 2)
                return
            end
        elseif currentStage == 2 then
            -- 第2阶段结束，释放“虎啸山林”
            if x893028_UseSkillA(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillCycle_Timer, x893028_SkillCycle_Duration_Stage3)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_CurrentStage, 3)
                return
            end
        elseif currentStage == 3 then
            -- 第3阶段，开始释放“牛鸡冲击波”并进入小周期
            if x893028_HandleSkillCSubCycle(sceneId, selfId, nTick) == 1 then
                return
            else
                -- 如果牛鸡冲击波小周期释放完成，则重置AI进入下一个大周期
                local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893028_SkillC_SubCycle_Count_Remaining)
                if remainingSubCycles <= 0 then
                    x893028_ResetMyAI(sceneId, selfId)
                end
                return
            end
        end

        -- 技能周期结束，重置AI
        x893028_ResetMyAI(sceneId, selfId)
    end
end
--**********************************
--处理牛鸡冲击波小周期
--**********************************
function x893028_HandleSkillCSubCycle(sceneId, selfId, nTick)
    -- 获取牛鸡冲击波小周期计时器
    local subCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillC_SubCycle_Timer)
    local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893028_SkillC_SubCycle_Count_Remaining)

    subCycleTimer = subCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillC_SubCycle_Timer, subCycleTimer)

    if subCycleTimer <= 0 and remainingSubCycles > 0 then
        if x893028_UseSkillC(sceneId, selfId) == 1 then
            -- 更新小周期计时器
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_IDX_SkillC_SubCycle_Timer, x893028_SkillC_SubCycle_Interval)
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893028_SkillC_SubCycle_Count_Remaining, remainingSubCycles - 1)
            return 1
        else
            return 0
        end
    end
    return 0
end

--**********************************
--牛鸡冲击波 技能释放
--**********************************
function x893028_UseSkillC(sceneId, selfId )
	--能否释放技能
--	if LuaFnCanUnitUseSkill(sceneId,selfId,x893028_SkillC_SkillID) ~= 1 then
--		return 0
--	end
	--发表讲话
	--510	#W哼哼，样你见思一下森么叫——大暖斗！	
	PaoPaoExEx(sceneId,selfId, 510)
	--通知
	CallScriptFunction(x893028_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_81}")
	--消息 样你见思一下森么叫——大暖斗！
--	LuaFnNpcTalk(sceneId,121)
	--选取周边随机的呆呆牛和蛋蛋鸡释放技能
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		local nCurMonsterDataId = GetMonsterDataID(sceneId,nMonsterId)
		if nCurMonsterDataId == 49590 or nCurMonsterDataId == 49606 then
			local nRandV = random(0,2)
			if nRandV < 2 then
				local x,z = GetWorldPos( sceneId, nMonsterId )
				LuaFnUnitUseSkill( sceneId, nMonsterId, x893028_SkillC_SkillID, nMonsterId, x, z, GetObjDir(sceneId,nMonsterId), 1 )
			end
		end
	end
	
	return 1
end

--**********************************
--蛮牛出动 技能释放
--**********************************
function x893028_UseSkillB( sceneId, selfId )
	--能否释放技能
--	if LuaFnCanUnitUseSkill(sceneId,selfId,x893028_SkillB_SkillID) ~= 1 then
--		return 0
--	end
	--发表讲话
	--阿呆，撞他！	
	PaoPaoExEx(sceneId,selfId, 508)
	--通知
	CallScriptFunction(x893028_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_79}")
	--技能显示
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893028_SkillB_SkillID, selfId, x, z, 0, 1 )
	return 1
end

--**********************************
--虎啸山林 技能释放
--**********************************
function x893028_UseSkillA( sceneId, selfId )
	--能否释放技能
--	if LuaFnCanUnitUseSkill(sceneId,selfId,x893028_SkillA_SkillID) ~= 1 then
--		return 0
--	end
	--发表讲话
	--嗷呜，吼他！	
	PaoPaoExEx(sceneId,selfId, 509)
	--通知
	CallScriptFunction(x893028_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_80}")
	--技能显示
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893028_SkillA_SkillID, selfId, x, z, 0, 1 )
	return 1
end
--**********************************
--技能释放成功
--**********************************
function x893028_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--蛮牛出动
	if nSkillId == x893028_SkillB_SkillID then
		--随机召唤5-6只蛮牛出动 Center:艾虎 Dir:Straight Line
		local tPosAndDir = {
			{x = 79,z = 152,dir = 4.712},
			{x = 76,z = 157,dir = 3.316},
			{x = 66,z = 163,dir = 3.141},
			{x = 58,z = 158,dir = 3.84},
			{x = 52,z = 153,dir = 1.571},
			{x = 49,z = 141,dir = 1.396},
			{x = 54,z = 132,dir = 1.047},
			{x = 66,z = 131,dir = 6.283},
			{x = 75,z = 129,dir = 6.283},
		}
		local tTmp = {}
		for i = 1,random(5,6) do
			local tRand = random(1,getn(tPosAndDir))
			local nExist = 0
			for j = 1,getn(tTmp) do
				if tTmp[j] == tRand then
					nExist = 1
					break
				end
			end
			if nExist ~= 1 then
				tinsert(tTmp,tRand);
			end
		end
		for i = 1,getn(tTmp) do
			local tData = tPosAndDir[tTmp[i]];
			local nObjId = CreateAutoMoveMonsterWithDir(sceneId,x893028_SkillB_MonsterDataId,tData.x,tData.z,3,-1,-1,tData.dir,34)
--			LuaFnMonsterDoSpecialAction( sceneId, nObjId, 165,165, 165 )
			--3592
			local x,z = GetWorldPos( sceneId, nObjId )
			LuaFnUnitUseSkill( sceneId, nObjId, 3592, nObjId, x, z, tData.dir, 1 )
		end
	end
end
--**********************************
--进入战斗....
--**********************************
function x893028_OnEnterCombat(sceneId, selfId, enmeyId)
	--重置AI....
	x893028_ResetMyAI( sceneId, selfId )
	--发表讲话
	PaoPaoExEx(sceneId,selfId, 530)
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893028_IDX_CombatFlag, 1 )
	--创建动阻
	CallScriptFunction(x893028_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,1);
	CallScriptFunction(x893028_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,7);
	CallScriptFunction(x893028_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,8);
end


--**********************************
--离开战斗....
--**********************************
function x893028_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x893028_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893028_IDX_CombatFlag, 0 )
	--清理动阻
	CallScriptFunction(x893028_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893028_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,7);
	CallScriptFunction(x893028_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,8);
end


--**********************************
--杀死敌人....
--**********************************
function x893028_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x893028_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x893028_g_FuBenScriptId, "OnBOSSAiHuDie", sceneId,selfId);
end

--**********************************
--对话框提示
--**********************************
function x893028_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

