--云飘飘BOSSAI逻辑

--脚本号
x893032_g_ScriptId	= 893032

--副本逻辑脚本号....
x893032_g_FuBenScriptId = 893020
--动阻控制脚本
x893032_g_DynamicBlockScriptId	= 893038

x893032_g_SceneData_Type = 7		
x893032_g_SceneData_InitLevel = 25				--副本的难度等级
x893032_g_SceneData_Level = 26					--副本的等级

--场地中心位置
x893032_g_CenterPos = {59.8329,63.3948}

--云飘飘特殊技能停留位置
x893032_g_YPPSpecialPos = {52,51}
x893032_g_YPPDataId = 49629

--九尾狐的MonsterId
x893032_g_FoxDataId = 49645

--AI Index....
x893032_IDX_SkillCycle_Timer = 1 -- 技能周期计时器
x893032_IDX_SkillC_SubCycle_Timer = 2 -- 如是我闻小周期计时器
x893032_CurrentStage = 3 -- 当前技能阶段
x893032_SkillC_SubCycle_Count_Remaining = 4 -- 如是我闻倒计时记次
x893032_RSWWSIndex = 5			--如是我闻顺序
x893032_SkillC_SubCycle_ActCount_Remaining = 6 -- 如是我闻激发记次
x893032_IDX_RSWW_Act_SubCycle_Timer = 7 -- 如是我闻激发小周期计时器
x893032_RSWWSObjId_1 = 8
x893032_RSWWSObjId_2 = 9
x893032_RSWWSObjId_3 = 10
x893032_RSWWSObjId_4 = 11
x893032_RSWWSObjId_5 = 12
x893032_YPP_SkillCycle_Timer = 13 -- 云飘飘小技能周期计时器
x893032_YPP_CurrentStage = 14 -- 当前技能阶段
--AI Bool Index
x893032_InRSWWState = 1
x893032_LingHuShouHuBeKill = 2
x893032_IDX_CombatFlag 		= 3	--是否处于战斗状态的标志....

x893032_SkillCycle_Duration_Stage1 = 5000 -- 第1阶段：灵狐禁锢 (5s)
x893032_SkillCycle_Duration_Stage2 = 13000 --第2阶段：灵狐禁锢 (5s)
x893032_SkillCycle_Duration_Stage3 = 30000 -- 第3阶段：如是我闻冷却缓冲期(30s)
x893032_SkillCycle_Duration_Stage4 = 3000 -- 第4阶段：如是我闻准备阶段
x893032_SkillCycle_Duration = x893032_SkillCycle_Duration_Stage1 + x893032_SkillCycle_Duration_Stage2 + x893032_SkillCycle_Duration_Stage3 + x893032_SkillCycle_Duration_Stage4

x893032_SkillC_SubCycle_Interval = 1000 -- 如是我闻展示小周期间隔时间 (1.0s)
x893032_SkillC_SubCycle_Count = 5 -- 如是我闻展示次数
x893032_SkillC_SubCycle_ActInterval = 6000 -- 如是我闻小周期间隔时间 (3.0s)
--技能A 灵狐禁锢
x893032_SkillA_SkillID = {3368,3369}
x893032_SkillA_TipMonsterId = {49848,49847}
x893032_SkillA_TipMonsterDir = {1.571,6.28}
x893032_SkillA_BanMonster = 49831

--大招 如是我闻 元素点位
x893032_SkillRSWW_ElementPos = {
	--金
	{dataid = 49825,posx = 53.8,posz = 55.8,dir = 0.69,actSkill = 3372},
	--水
	{dataid = 49827,posx = 65.2,posz = 55.5,dir = 5.584,actSkill = 3372},
	--木
	{dataid = 49826,posx = 69.2,posz = 66,dir = 4.463,actSkill = 3372},
	--火
	{dataid = 49828,posx = 60.26,posz = 73.26,dir = 3.14,actSkill = 3372},
	--土
	{dataid = 49829,posx = 50.8,posz = 66.8,dir = 1.92,actSkill = 3372},
}
x893032_Skill_RSWW = 3372
x893032_Skill_RSWW_Protect = 43004	--如是我闻过程无敌
--如是我闻中场爆炸NPC
x893032_Skill_CenterSpecialNpc = 49608
x893032_Skill_RSWW_ReadyBanMove = 42998
x893032_Skill_RSWW_DamageImp = {43002,43005}
--云飘飘小技能
x893032_YPPSkillCycle_Duration_Stage1 = 7000 -- 云断烟 (7s)
x893032_YPPSkillCycle_Duration_Stage2 = 15000 -- 同舟共济 (15s)
x893032_YPPSkillCycle_Duration = x893032_YPPSkillCycle_Duration_Stage1 + x893032_YPPSkillCycle_Duration_Stage2
--云断烟
x893032_YPP_YunDuanYanSkillId = 3365
x893032_YPP_YunDuanYanMonsterId = 49604
--同舟共济
x893032_YPP_TongZhouGongJi = 3364
x893032_YPP_TongZhouGongJiImpId = 42997
--灵狐守护
x893032_SkillCycle_Duration_ShouHu = 5000 	--灵狐守护等待
x893032_SkillShouHuWaitTime = 15000		  	--灵狐守护发招时间
x893032_SkillShouHuImpact = 42999			--未击破伤害
x893032_SkillShouHu_Protect = 43003			--灵狐守护过程无敌

--**********************************
--入口函数
--**********************************
function x893032_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x893032_ResetMyAI( sceneId, selfId )
	-- 重置计时器
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, x893032_SkillCycle_Duration)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillC_SubCycle_Timer, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_Count_Remaining, x893032_SkillC_SubCycle_Count)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_ActCount_Remaining, x893032_SkillC_SubCycle_Count)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_RSWW_Act_SubCycle_Timer, 0)
	
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_1, -1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_2, -1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_3, -1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_4, -1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_5, -1)
	--云飘飘小技能计时器
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_SkillCycle_Timer, x893032_YPPSkillCycle_Duration)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_CurrentStage, 1)
	
	--是否在如是我闻状态
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x893032_InRSWWState,0)
	--灵狐守护是否被击杀
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x893032_LingHuShouHuBeKill,0)
	
end

--**********************************
--初始化....
--**********************************
function x893032_OnInit(sceneId, selfId)
	--重置AI....
	x893032_ResetMyAI( sceneId, selfId )
	--设置战斗状态
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x893032_IDX_CombatFlag,0)
end

--**********************************
--心跳....
--**********************************
function x893032_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end	
	--是否在战斗状态
	if MonsterAI_GetBoolParamByIndex(sceneId,selfId,x893032_IDX_CombatFlag) ~= 1 then
		return
	end
	-- 获取技能周期计时器
    local skillCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer)
    local currentStage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_CurrentStage)
	if currentStage < 3 then
		-- 单独的副流程跑云飘飘技能
		x893032_OnHeartBeat_YPP(sceneId, selfId, nTick)
	end
	-- 主流程跑九尾狐技能	
    skillCycleTimer = skillCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, skillCycleTimer)
    if skillCycleTimer <= 0 then
        if currentStage == 1 then
            -- 第1阶段结束，释放“灵狐禁锢”
            if x893032_UseSkill_LingHuJingGu(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, x893032_SkillCycle_Duration_Stage2)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 2)
                return
            end
        elseif currentStage == 2 then
			--释放“灵狐禁锢”第二次
			 if x893032_UseSkill_LingHuJingGu(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, x893032_SkillCycle_Duration_Stage3)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 3)
                return
            end
		elseif currentStage == 3 then
            -- 第3阶段结束，释放大招 如是我闻
            if x893032_UseSkill_RuShiWoWen(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, x893032_SkillCycle_Duration_Stage4)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 4)
				--预留1s等待
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillC_SubCycle_Timer, x893032_SkillC_SubCycle_Interval)
                return
            end
        elseif currentStage == 4 then
            -- 如是我闻结束，进入特殊灯盏显示阶段
            if x893032_HandleSkillCSubCycle(sceneId, selfId, nTick) == 1 then
                return
            else
                local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_Count_Remaining)
                if remainingSubCycles <= 0 then
                    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 5)
					--预备激发准备
					x893032_UseSkill_RuShiWoWenPreActive( sceneId, selfId )
					--小计时器初始化
					MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_RSWW_Act_SubCycle_Timer, x893032_SkillC_SubCycle_ActInterval)
                end
                return
            end
		elseif currentStage == 5 then
            -- 如是我闻展示阶段结束，进入激发阶段
            if x893032_HandleRSWW_Active(sceneId, selfId, nTick) == 1 then
                return
            else
                local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_ActCount_Remaining)
                if remainingSubCycles <= 0 then
					
					--进入灵狐守护阶段
					MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 6)
					MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, x893032_SkillCycle_Duration_ShouHu)
                end
                return
            end
		elseif currentStage == 6 then
			x893032_UseSkill_LingHuShouHuPre( sceneId, selfId )
			MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 7)
			MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillCycle_Timer, x893032_SkillShouHuWaitTime)
		elseif currentStage == 8 then
			--守护激发结算
			x893032_UseSkill_LingHuShouHuActive( sceneId, selfId )
        end
	else
		if currentStage == 7 and skillCycleTimer <= 10000 then
			--全屏提示
			CallScriptFunction(x893032_g_FuBenScriptId, "TipAllHuman",sceneId,ScriptGlobal_Format("#{ZSFB_20220105_155}",10));
			--进入预备释放阶段
			MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_CurrentStage, 8)
		end
    end
end
--**********************************
--心跳....
--**********************************
function x893032_OnHeartBeat_YPP(sceneId, selfId, nTick)
	--如是我闻状态
	if MonsterAI_GetBoolParamByIndex(sceneId,selfId,x893032_InRSWWState) == 1 then
		return
	end
	
	local skillCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_YPP_SkillCycle_Timer)
	local currentStage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_YPP_CurrentStage)
--	print("currentStage",currentStage)
	-- 主流程跑九尾狐技能	
    skillCycleTimer = skillCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_SkillCycle_Timer, skillCycleTimer)
    if skillCycleTimer <= 0 then
		--云断烟
		if currentStage == 1 then
			if x893032_UseSkill_YunYan(sceneId, selfId) == 1 then
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_SkillCycle_Timer, x893032_YPPSkillCycle_Duration_Stage1)
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_CurrentStage, 2)
				return
			end
		elseif currentStage == 2 then
			if x893032_UseSkill_YunYan(sceneId, selfId) == 1 then
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_SkillCycle_Timer, x893032_YPPSkillCycle_Duration_Stage1)
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_CurrentStage, 3)
				return
			end
		elseif currentStage == 3 then
			if x893032_UseSkill_TongZhouGongJi(sceneId, selfId) == 1 then
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_SkillCycle_Timer, x893032_YPPSkillCycle_Duration_Stage2)
				--切回云断烟
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_YPP_CurrentStage, 1)
				return
			end	
		end
		
	end
end
--**********************************
--进入灵狐守护激发阶段
--**********************************
function x893032_UseSkill_LingHuShouHuActive( sceneId, selfId )
	--九尾狐做动作
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x893032_g_FoxDataId then
			--结束包裹动作
			LuaFnMonsterDoSpecialAction( sceneId, MonsterId,172,-1,-1 )
		end
	end
	--释放一个普攻打断当前动作
	LuaFnUnitUseSkill( sceneId, selfId, 0, selfId, -1,-1,0.873, 1)
	--大周期结束
	x893032_ResetMyAI( sceneId, selfId )
	--判定灵狐守护是否还存在
	if MonsterAI_GetBoolParamByIndex(sceneId,selfId,x893032_LingHuShouHuBeKill) == 1 then
		return
	end
	--全场玩家及其宠物给予伤害
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)	
	for i=0, nHumanNum-1  do
		local nHumanObjId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanObjId) == 1 
			and LuaFnIsCharacterLiving( sceneId, nHumanObjId ) == 1 
			and IsInDist(sceneId,selfId,nHumanObjId,30) == 1 then
			--伤害释放
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanObjId, x893032_SkillShouHuImpact, 10);
			
			local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, nHumanObjId)
			if pgH ~= nil and pgL ~= nil and pgH > 0 and pgL > 0 then
				local nPetObjId = LuaFnGetPetObjIdByGUID(sceneId,nHumanObjId, pgH , pgL )
				if LuaFnIsObjValid(sceneId, nPetObjId) == 1 and LuaFnIsCharacterLiving(sceneId,nPetObjId) == 1 then

					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nPetObjId, x893032_SkillShouHuImpact, 10);
				end
			end
		end
	end
	
end
--**********************************
--进入灵狐守护预备阶段
--**********************************
function x893032_UseSkill_LingHuShouHuPre( sceneId, selfId )
	local nMonsterId = CreateMonsterWithDir( sceneId,49832 ,54,57, 3, -1, x893032_g_FuBenScriptId,0.873)
	if nMonsterId ~= 1 then
		--设置一个最大存在时间 防止逻辑出错引起问题
		SetCharacterDieTime(sceneId, nMonsterId,16000)
	end
	--放置云飘飘到特殊位置并进入蓄力阶段
	SetPos(sceneId,selfId,x893032_g_YPPSpecialPos[1],x893032_g_YPPSpecialPos[2])
	LuaFnUnitUseSkill( sceneId, selfId, x893032_Skill_RSWW, selfId, x893032_g_YPPSpecialPos[1],x893032_g_YPPSpecialPos[2],0.873, 1)
	--给予云飘飘特殊BUFF
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x893032_SkillShouHu_Protect,0);
	--九尾狐做动作
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x893032_g_FoxDataId then
			--包裹住云飘飘
			LuaFnMonsterDoSpecialAction( sceneId, MonsterId,170,171,-1 )
--			LuaFnMonsterDoSpecialAction( sceneId, MonsterId,172,-1,-1 )
		end
	end
	--全屏提示
	CallScriptFunction(x893032_g_FuBenScriptId, "TipAllHuman",sceneId,ScriptGlobal_Format("#{ZSFB_20220105_155}",15));
	
	return 1
end
--**********************************
--处理如是我闻展示小周期
--**********************************
function x893032_HandleSkillCSubCycle(sceneId, selfId, nTick)
    local subCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillC_SubCycle_Timer)
    local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_Count_Remaining)

    subCycleTimer = subCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillC_SubCycle_Timer, subCycleTimer)

    if subCycleTimer <= 0 and remainingSubCycles > 0 then
        if x893032_UseSkill_RuShiWoWenShow(sceneId, selfId,remainingSubCycles) == 1 then
            -- 更新小周期计时器
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_SkillC_SubCycle_Timer, x893032_SkillC_SubCycle_Interval)
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_Count_Remaining, remainingSubCycles - 1)
            return 1
        else
            return 0
        end
    end
    return 0
end
--**********************************
--如是我闻激发小周期
--**********************************
function x893032_HandleRSWW_Active(sceneId, selfId, nTick)
    local subCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_IDX_RSWW_Act_SubCycle_Timer)
    local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_ActCount_Remaining)

    subCycleTimer = subCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_RSWW_Act_SubCycle_Timer, subCycleTimer)

    if subCycleTimer <= 0 and remainingSubCycles > 0 then
        if x893032_UseSkill_RuShiWoWenActive(sceneId, selfId,remainingSubCycles) == 1 then
            -- 更新小周期计时器
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_IDX_RSWW_Act_SubCycle_Timer, x893032_SkillC_SubCycle_ActInterval)
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_SkillC_SubCycle_ActCount_Remaining, remainingSubCycles - 1)
            return 1
        else
            return 0
        end
    end
    return 0
end
--**********************************
--全屏大招 如是我闻预备激发阶段
--**********************************
function x893032_UseSkill_RuShiWoWenPreActive( sceneId, selfId )
	--构建四角点位
	for i = 1,getn(x893032_SkillRSWW_ElementPos) do
		local tData = x893032_SkillRSWW_ElementPos[i]
		local nMonsterId = CreateMonsterWithDir( sceneId,tData.dataid ,tData.posx,tData.posz, 3, -1, -1,tData.dir)
		--暂存ID
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_1 + i - 1, nMonsterId)
		--进入蓄力阶段
		LuaFnMonsterDoSpecialAction( sceneId, nMonsterId,-1,168,-1 )
	end
	--构建中心特殊NPC
	local nCenterNpc = CreateMonsterWithDir( sceneId,x893032_Skill_CenterSpecialNpc ,x893032_g_CenterPos[1],x893032_g_CenterPos[2], 3, -1, -1,1.571)
	if nCenterNpc ~= -1 then
		SetCharacterDieTime(sceneId, nCenterNpc,40000)
	end
	return 1
end
--**********************************
--全屏大招 如是我闻激发阶段
--**********************************
function x893032_UseSkill_RuShiWoWenActive( sceneId, selfId,nShowIdx )
	local nRSWWSIndex = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_RSWWSIndex)
	local tRSWWIndex = ScriptGlobal_MathCilCompute_1_In(nRSWWSIndex)
	local nCurShowIndex = tRSWWIndex[nShowIdx]
	--处理要激发的NPC
	local nProtectNpcId = -1
--	local tData = x893032_SkillRSWW_ElementPos[nCurShowIndex]
	for i = 1,getn(x893032_SkillRSWW_ElementPos) do
		local nMonsterId = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_RSWWSObjId_1 + i - 1)
		if nCurShowIndex == i then
			--防护
			LuaFnMonsterDoSpecialAction( sceneId, nMonsterId,167,168,-1 )
			nProtectNpcId = nMonsterId
		else
			--伤害
			LuaFnMonsterDoSpecialAction( sceneId, nMonsterId,162,168,-1 )
		end
	end
	if nProtectNpcId == nil then
		--这是异常
		local recordMsg = format("x893032_UseSkill_RuShiWoWenActive nProtectNpcId ERROR sceneid=%d ProtectNpcId=%d", sceneId,nProtectNpcId )
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1,recordMsg)
	end
	--拉取全场的角色信息
	local tDamageObj = {}
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)	
	for i=0, nHumanNum-1  do
		local nHumanObjId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanObjId) == 1 
			and LuaFnIsCharacterLiving( sceneId, nHumanObjId ) == 1 
			and IsInDist(sceneId,selfId,nHumanObjId,30) == 1 then
			
			if IsInDist(sceneId,nProtectNpcId,nHumanObjId,4) ~= 1 then
				tinsert(tDamageObj,nHumanObjId)
			end
		end
	end
	--中心大圈激发
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		local nCurMonsterDataId = GetMonsterDataID(sceneId,nMonsterId)
		if nCurMonsterDataId == x893032_Skill_CenterSpecialNpc then
			LuaFnMonsterDoSpecialAction( sceneId, nMonsterId,165,-1,-1 )
		end
	end
	
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893032_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	--给予未在周边玩家伤害
	for i = 1,getn(tDamageObj) do
		if LuaFnIsObjValid(sceneId, tDamageObj[i]) == 1 
			and LuaFnIsCharacterLiving( sceneId, tDamageObj[i] ) == 1 then
			
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, tDamageObj[i], x893032_Skill_RSWW_DamageImp[nFubenType + 1],100);
		end
	end
	return 1
end
--**********************************
--全屏大招 如是我闻展示阶段
--**********************************
function x893032_UseSkill_RuShiWoWenShow( sceneId, selfId,nShowIdx )
	local nRSWWSIndex = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893032_RSWWSIndex)
	local tRSWWIndex = ScriptGlobal_MathCilCompute_1_In(nRSWWSIndex)
--	print("nShowIdx",nShowIdx)
	local nCurShowIndex = tRSWWIndex[nShowIdx]
	--创建要展示的NPC
	local tData = x893032_SkillRSWW_ElementPos[nCurShowIndex]
	local nMonsterId = CreateMonsterWithDir( sceneId,tData.dataid ,tData.posx,tData.posz, 3, -1, -1,tData.dir)
	LuaFnMonsterDoSpecialAction( sceneId, nMonsterId,166,-1,-1 )
	SetCharacterDieTime(sceneId, nMonsterId,500)
	
	return 1
end
--**********************************
--全屏大招 如是我闻
--**********************************
function x893032_UseSkill_RuShiWoWen( sceneId, selfId )
	--清理所有云断烟
	x893032_RemoveAllYunDuanYan(sceneId)
	--设置进入如是我闻状态
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x893032_InRSWWState,1)
	--通知 九尾灵狐与云飘飘释放了合力施展阵法，请少侠注意场地变化，牢记印记点亮顺序，合理躲避！	
	CallScriptFunction(x893032_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_94}")
	--灵狐提示 相信汝之双眼，遵从汝之判断。 	
	LuaFnNpcTalk(sceneId,122)
	
	--生成本次如是我闻的元素顺序
	local tTemp = {1,2,3,4,5}
	local n = getn(tTemp)
    for i = n, 2, -1 do
        local j = random(i)
        tTemp[i], tTemp[j] =tTemp[j], tTemp[i]
    end
	tTemp[6] = 0;
	tTemp[7] = 0;
	tTemp[8] = 0;
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893032_RSWWSIndex, ScriptGlobal_MathCilCompute_1_Out(tTemp))
	--放置云飘飘到特殊位置并进入如是我闻阶段
	SetPos(sceneId,selfId,x893032_g_YPPSpecialPos[1],x893032_g_YPPSpecialPos[2])
	LuaFnUnitUseSkill( sceneId, selfId, x893032_Skill_RSWW, selfId, x893032_g_YPPSpecialPos[1],x893032_g_YPPSpecialPos[2],0.873, 1)
	--给予云飘飘特殊BUFF
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x893032_Skill_RSWW_Protect,0);
	--拉取全屏的玩家和其宠物到圈中心
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)	
	for i=0, nHumanNum-1  do
		local nHumanObjId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanObjId) == 1 
			and LuaFnIsCharacterLiving( sceneId, nHumanObjId ) == 1 
			and IsInDist(sceneId,selfId,nHumanObjId,30) == 1 then
			--拉宠物至中心点
			SetPos(sceneId,nHumanObjId,x893032_g_CenterPos[1], x893032_g_CenterPos[2])
			--禁止人物移动
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanObjId, x893032_Skill_RSWW_ReadyBanMove, 0);
			
			local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, nHumanObjId)
			if pgH ~= nil and pgL ~= nil and pgH > 0 and pgL > 0 then
				local nPetObjId = LuaFnGetPetObjIdByGUID(sceneId,nHumanObjId, pgH , pgL )
				if LuaFnIsObjValid(sceneId, nPetObjId) == 1 and LuaFnIsCharacterLiving(sceneId,nPetObjId) == 1 then
					--拉宠物至中心点
					SetPos(sceneId,nPetObjId,x893032_g_CenterPos[1], x893032_g_CenterPos[2])
				end
			end
		end
	end
	
	return 1
end

--**********************************
--灵狐禁锢 技能释放
--**********************************
function x893032_UseSkill_LingHuJingGu( sceneId, selfId )	
	local nRand = random(1,2)
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893032_SkillA_SkillID[nRand]) ~= 1 then
		return 0
	end
	--通知 九尾灵狐的尾巴即将挥向场地，请速速躲避！	
	CallScriptFunction(x893032_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_91}")
	
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x893032_g_FoxDataId then
			LuaFnUnitUseSkill( sceneId, MonsterId, x893032_SkillA_SkillID[nRand], selfId, x893032_g_CenterPos[1], x893032_g_CenterPos[2],0.873, 1)
		end
	end
	local nMonsterId = CreateMonsterWithDir( sceneId,
		x893032_SkillA_TipMonsterId[nRand],
		x893032_g_CenterPos[1],
		x893032_g_CenterPos[2], 3, -1, -1,
		x893032_SkillA_TipMonsterDir[nRand])
	--警告圈的消散时间
	SetCharacterDieTime(sceneId, nMonsterId,6000)
	--锁定的逻辑由程序来实现
	
	return 1
end
--**********************************
--云飘飘 云断烟
--**********************************
function x893032_UseSkill_YunYan(sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893032_YPP_YunDuanYanSkillId) ~= 1 then
		return 0
	end
	--发表讲话
	--513	#W呼——	
	PaoPaoExEx(sceneId,selfId, 513)
	--通知
	CallScriptFunction(x893032_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_93}")
	
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893032_YPP_YunDuanYanSkillId, selfId, x, z, GetObjDir(sceneId,selfId), 1 )
	
	return 1
end

--**********************************
--同舟共济 技能释放
--**********************************
function x893032_UseSkill_TongZhouGongJi( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893032_YPP_TongZhouGongJi) ~= 1 then
		return 0
	end
	--通知
	CallScriptFunction(x893032_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_92}")
	--控制九尾狐释放技能
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x893032_g_FoxDataId then
			LuaFnUnitUseSkill( sceneId, MonsterId, x893032_YPP_TongZhouGongJi, MonsterId, x893032_g_CenterPos[1], x893032_g_CenterPos[2],0.873, 1)
		end
	end
	--云飘飘自身要显字
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893032_YPP_TongZhouGongJi, selfId, x, z, GetObjDir(sceneId,selfId), 1 )
	return 1
end

--**********************************
--技能释放成功
--**********************************
function x893032_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--云断烟释放
	if nSkillId	 == x893032_YPP_YunDuanYanSkillId then
		local x,z = GetWorldPos( sceneId, selfId )
		for i = 1,2 do
			--随机方位角
			local nRandDir = GetObjDir(sceneId,selfId) + (random(-314,314) / 100);
			local nYunYanDuan = CreateMonsterWithDir( sceneId, x893032_YPP_YunDuanYanMonsterId,x,z, 3, -1,-1, nRandDir )
			if nYunYanDuan ~= -1 then
				SetCharacterDieTime(sceneId, nYunYanDuan,12000)
				--设置云飘飘当前的位置 
				--程序要使用此处的值来计算攻击范围
				LuaFnSetNpcIntParameter(sceneId,nYunYanDuan,0,x);
				LuaFnSetNpcIntParameter(sceneId,nYunYanDuan,1,z);
			end
		end
	end
	--同舟共济
	if nSkillId == x893032_YPP_TongZhouGongJi then
		--给在场所有玩家增加特殊光圈
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)	
		for i=0, nHumanNum-1  do
			local nHumanObjId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanObjId) == 1 
				and LuaFnIsCharacterLiving( sceneId, nHumanObjId ) == 1 
				and IsInDist(sceneId,selfId,nHumanObjId,30) == 1 then
				
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanObjId, x893032_YPP_TongZhouGongJiImpId, 0);
			end
		end	
	end
	
end

--**********************************
--清理所有云断烟
--**********************************
function x893032_RemoveAllYunDuanYan(sceneId)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x893032_YPP_YunDuanYanMonsterId then
			SetCharacterDieTime(sceneId, MonsterId,100)
		end
	end
end
--**********************************
--进入战斗....
--**********************************
function x893032_OnEnterCombat(sceneId, selfId, enmeyId)
	--重置AI....
	x893032_ResetMyAI( sceneId, selfId )
	--发表提示信息
	LuaFnNpcTalk(sceneId,132)
	--设置战斗状态
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x893032_IDX_CombatFlag,1)
	--创建动阻
	CallScriptFunction(x893032_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,1);
	CallScriptFunction(x893032_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,9);
end
--**********************************
--离开战斗....
--**********************************
function x893032_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x893032_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
	--设置战斗状态
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x893032_IDX_CombatFlag,0)
	--清理动阻
	CallScriptFunction(x893032_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893032_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,9);
end


--**********************************
--杀死敌人....
--**********************************
function x893032_OnKillCharacter(sceneId, selfId, targetId)
	
end

--**********************************
--死亡....
--**********************************
function x893032_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x893032_g_FuBenScriptId, "OnFinalBossDie", sceneId,selfId);
end

--**********************************
--对话框提示
--**********************************
function x893032_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

