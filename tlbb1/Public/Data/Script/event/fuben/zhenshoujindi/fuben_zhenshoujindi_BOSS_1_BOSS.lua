--云卷舒BOSSAI逻辑

--脚本号
x893023_g_ScriptId	= 893023

--副本逻辑脚本号....
x893023_g_FuBenScriptId = 893020
--动阻控制脚本
x893023_g_DynamicBlockScriptId	= 893038
--当前的逻辑批次
x893023_g_SceneData_MainStep = 8   	
--副本的难度类型
x893023_g_SceneData_Type = 7		
x893023_g_SceneData_InitLevel = 25				--副本的难度等级
x893023_g_SceneData_Level = 26					--副本的等级

--Boss1云卷舒的ID
x893023_g_SceneData_BOSS_1_ObjId = 12	
--NPC Param分配
x893023_g_NPCParam_MainSpecId = 0
x893023_g_NPCParam_SubSpecId = 1
x893023_g_NPCParam_SkillD_DamageImpact = 2		--流芳谢春风伤害impact【程序用，勿动】
--荼蘼花
x893023_g_TuMiFlowerDataId = 49576
x893023_g_TuMiFlowerScriptId = 893024
x893023_g_TuMiSpecObj = 
{
	--主陷阱id 副陷阱id
	[0] = {
		{mid=1390,sid=1391},
		{mid=1390,sid=1391},
		{mid=1390,sid=1391},
		{mid=1390,sid=1391},
		{mid=1390,sid=1391},
		{mid=1390,sid=1391},
		{mid=1390,sid=1391},
		{mid=1393,sid=1394},
		{mid=1396,sid=1397},
		{mid=1399,sid=1400},	
		{mid=1402,sid=1403},
	},
	[1] = {
		{mid=1405,sid=1406},
		{mid=1405,sid=1406},
		{mid=1405,sid=1406},
		{mid=1405,sid=1406},
		{mid=1405,sid=1406},
		{mid=1405,sid=1406},
		{mid=1408,sid=1409},
		{mid=1411,sid=1412},
		{mid=1414,sid=1415},
		{mid=1417,sid=1418},
		{mid=1420,sid=1421},
	},
}
--AI Index....
x893023_IDX_SkillCycle_Timer = 1 -- 技能周期计时器
x893023_IDX_SkillC_SubCycle_Timer = 2 -- 流芳谢春风小周期计时器
x893023_CurrentStage = 3 -- 当前技能阶段
x893023_SkillC_SubCycle_Count_Remaining = 4 -- 流芳谢春风小周期剩余次数

-- 总技能周期时间配置
x893023_SkillCycle_Duration_Stage1 = 5000 -- 第1阶段：荼蘼花事 (5s)
x893023_SkillCycle_Duration_Stage2 = 10000 -- 第2阶段：一叶摄心 (5s)
x893023_SkillCycle_Duration_Stage3 = 12000 -- 第3阶段：流芳谢春风 (12s)

x893023_SkillC_SubCycle_Interval = 6000 -- 流芳谢春风小周期间隔时间 (16s)
x893023_SkillC_SubCycle_Count = 2 -- 流芳谢春风小周期释放次数

--AI Index....
x893023_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....

--A荼蘼花事释放....
x893023_SkillA_ID			= 3353

--一叶摄心释放....
x893023_SkillB_ID			= 3354
x893023_SkillB_tImpactID	= 
{
	--恐惧ID 持续掉血ID
	[0] = {
		{buffA=43023,buffB=43024},
		{buffA=43023,buffB=43024},
		{buffA=43023,buffB=43024},
		{buffA=43023,buffB=43024},
		{buffA=43023,buffB=43024},
		{buffA=43023,buffB=43024},
		{buffA=43023,buffB=43024},
		{buffA=43035,buffB=43036},
		{buffA=43047,buffB=43048},
		{buffA=43059,buffB=43060},	
		{buffA=43071,buffB=43072},
	},
	[1] = {
		{buffA=43083,buffB=43084},
		{buffA=43083,buffB=43084},
		{buffA=43083,buffB=43084},
		{buffA=43083,buffB=43084},
		{buffA=43083,buffB=43084},
		{buffA=43083,buffB=43084},
		{buffA=43095,buffB=43096},
		{buffA=44115,buffB=44116},
		{buffA=44127,buffB=44128},
		{buffA=44139,buffB=44140},
		{buffA=44151,buffB=44152},
	},
}

--D流芳谢春风....
x893023_SkillD_ID		= 3355
--云卷舒的位置
x893023_PosYunJuanShu = {180,123}

--**********************************
--入口函数
--**********************************
function x893023_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x893023_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893023_IDX_CombatFlag, 0 )
	
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillCycle_Timer, x893023_SkillCycle_Duration_Stage1)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillC_SubCycle_Timer, 0)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_CurrentStage, 1)
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_SkillC_SubCycle_Count_Remaining, x893023_SkillC_SubCycle_Count)
	
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893023_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893023_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893023_g_SceneData_Level)
	--生成主副陷阱ID
	LuaFnSetNpcIntParameter(sceneId,selfId,x893023_g_NPCParam_MainSpecId,x893023_g_TuMiSpecObj[nFubenType][nFubenInitLev].mid)
	LuaFnSetNpcIntParameter(sceneId,selfId,x893023_g_NPCParam_SubSpecId,x893023_g_TuMiSpecObj[nFubenType][nFubenInitLev].sid)
	--流芳谢春风伤害impact
	local tLiuFangXieChunFeng = 
	{
		[0] = {43026,43026,43026,43026,43026,43026,43026,43038,43050,43062,43074},
		[1] = {43086,43086,43086,43086,43086,43086,43098,44118,44130,44142,44154},
	}
	LuaFnSetNpcIntParameter(sceneId,selfId,x893023_g_NPCParam_SkillD_DamageImpact,tLiuFangXieChunFeng[nFubenType][nFubenInitLev])
	
end

--**********************************
--初始化....
--**********************************
function x893023_OnInit(sceneId, selfId)
	--重置AI....
	x893023_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x893023_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893023_IDX_CombatFlag ) then
		return
	end
	-- 获取技能周期计时器
    local skillCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillCycle_Timer)
    local currentStage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893023_CurrentStage)
    skillCycleTimer = skillCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillCycle_Timer, skillCycleTimer)

    if skillCycleTimer <= 0 then
        if currentStage == 1 then
            -- 第1阶段结束，释放“荼蘼花事”
            if x893023_UseSkillA(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillCycle_Timer, x893023_SkillCycle_Duration_Stage2)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_CurrentStage, 2)
                return
            end
        elseif currentStage == 2 then
            -- 第2阶段结束，释放“一叶摄心”
            if x893023_UseSkillB(sceneId, selfId) == 1 then
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillCycle_Timer, x893023_SkillCycle_Duration_Stage3)
                MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_CurrentStage, 3)
                return
            end
        elseif currentStage == 3 then
            -- 第3阶段，开始释放“流芳谢春风”并进入小周期
            if x893023_HandleSkillCSubCycle(sceneId, selfId, nTick) == 1 then
                return
            else
                -- 如果流芳谢春风小周期释放完成，则重置AI进入下一个大周期
                local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893023_SkillC_SubCycle_Count_Remaining)
                if remainingSubCycles <= 0 then
                    x893023_ResetMyAI(sceneId, selfId)
                end
                return
            end
        end
    end
end

--**********************************
--处理流芳谢春风小周期
--**********************************
function x893023_HandleSkillCSubCycle(sceneId, selfId, nTick)
    -- 获取流芳谢春风小周期计时器
    local subCycleTimer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillC_SubCycle_Timer)
    local remainingSubCycles = MonsterAI_GetIntParamByIndex(sceneId, selfId, x893023_SkillC_SubCycle_Count_Remaining)

    subCycleTimer = subCycleTimer - nTick
    MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillC_SubCycle_Timer, subCycleTimer)

    if subCycleTimer <= 0 and remainingSubCycles > 0 then
        if x893023_UseSkillD(sceneId, selfId) == 1 then
            -- 更新小周期计时器
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_IDX_SkillC_SubCycle_Timer, x893023_SkillC_SubCycle_Interval)
            MonsterAI_SetIntParamByIndex(sceneId, selfId, x893023_SkillC_SubCycle_Count_Remaining, remainingSubCycles - 1)
            return 1
        else
            return 0
        end
    end
    return 0
end

--**********************************
--技能释放成功
--**********************************
function x893023_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893023_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893023_g_SceneData_InitLevel)
	--荼蘼花事了
	if nSkillId == x893023_SkillA_ID then
		--副本中有效的玩家的列表....
		local PlayerList = {}
		--将有效的人加入列表....
		local numPlayer = 0
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				PlayerList[numPlayer+1] = nHumanId
				numPlayer = numPlayer + 1
			end
		end
		--随机挑选两个玩家个玩家....
		if numPlayer <= 0 then
			return 0
		end
		for i = 1,2 do
			local PlayerId = PlayerList[ random(numPlayer) ]
			--对玩家脚下放荼蘼花陷阱
			local x,z = GetWorldPos( sceneId, PlayerId )
			x893023_PutTuMiFlower(sceneId, selfId,x,z,0)
		end
	end
	--一叶摄心
	if nSkillId == x893023_SkillB_ID then
		--失明
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, targetId, x893023_SkillB_tImpactID[nFubenType][nFubenInitLev].buffA, 0 )
		--持续掉血
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, targetId, x893023_SkillB_tImpactID[nFubenType][nFubenInitLev].buffB, 0 )
	end
	--流芳谢春风
	if nSkillId == x893023_SkillD_ID then
		--引爆场景内所有荼蘼花
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID( sceneId, MonsterId )
			if MosDataID == x893023_g_TuMiFlowerDataId then
				CallScriptFunction(x893023_g_TuMiFlowerScriptId, "OnEnterCombat",sceneId,MonsterId,-1)
			end
		end
	end
end

--**********************************
--使用A技能....荼蘼花事了
--**********************************
function x893023_UseSkillA( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893023_SkillA_ID) ~= 1 then
		return 0
	end
	--云卷舒回到中央
	SetPos(sceneId,selfId,x893023_PosYunJuanShu[1],x893023_PosYunJuanShu[2]);
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x893023_SkillA_ID, selfId, -1, -1, 0, 1 )
	--云卷舒发动了技能荼蘼花事了，请少侠注意躲避，并小心触发荼蘼花将其清理掉。
	CallScriptFunction(x893023_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_58}")
	--残留的荼蘼花会一直存在并在敌人接近后的4秒造成范围伤害，请少侠留心处理，否则后患无穷。
	CallScriptFunction(x893023_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_154}")
	--接招吧
	PaoPaoExEx(sceneId,selfId, 527)
	return 1

end
--**********************************
--使用B技能 一叶摄心
--**********************************
function x893023_UseSkillB( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893023_SkillB_ID) ~= 1 then
		return 0
	end
	--一叶摄心 随机挑选一个玩家
	local tPlayerID = {}
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			tinsert(tPlayerID,nHumanId)
		end
	end
	local nRandom = random(1,getn(tPlayerID));
	local nRandomPlayerID = tPlayerID[nRandom]
	--一叶摄心
	local x,z = GetWorldPos( sceneId, nRandomPlayerID )
	LuaFnUnitUseSkill( sceneId, selfId, x893023_SkillB_ID, nRandomPlayerID, x, z, 0, 1 )

	return 1
end

--**********************************
--使用D技能....
--**********************************
function x893023_UseSkillD( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x893023_SkillD_ID) ~= 1 then
		return 0
	end
	--说个话
	PaoPaoExEx(sceneId,selfId, 504)
	--消息
	LuaFnNpcTalk(sceneId,119)
	CallScriptFunction(x893023_g_FuBenScriptId, "TipAllHuman",sceneId,"#{ZSFB_20220105_60}")
	--四角放置荼蘼花
	x893023_PutTuMiFlower(sceneId, selfId,172,128,1)
	x893023_PutTuMiFlower(sceneId, selfId,174,113,1)
	x893023_PutTuMiFlower(sceneId, selfId,192,122,1)
	x893023_PutTuMiFlower(sceneId, selfId,183,136,1)
	--云卷舒回到中央
	SetPos(sceneId,selfId,x893023_PosYunJuanShu[1],x893023_PosYunJuanShu[2]);
	--使用流芳谢春风
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893023_SkillD_ID, selfId, x, z, 0, 1 )
	
	return 1

end

--**********************************
--放置荼蘼花
--**********************************
function x893023_PutTuMiFlower(sceneId, selfId,posX,posZ,bCreateDirect)
	if bCreateDirect == 1 then
		CreateMonsterWithDir(sceneId, x893023_g_TuMiFlowerDataId,posX, posZ, 31, -1, x893023_g_TuMiFlowerScriptId,3.14)
	else
		local nMainSpecObj = LuaFnGetNpcIntParameter(sceneId,selfId,x893023_g_NPCParam_MainSpecId)
		--对玩家脚下放荼蘼花陷阱
		CreateSpecialObjByDataIndex(sceneId, selfId, nMainSpecObj, posX, posZ, 0)
		--延时创建荼蘼花 4000ms
		CreateDelayMonsterWithDir(sceneId, x893023_g_TuMiFlowerDataId,posX, posZ, 31, -1, x893023_g_TuMiFlowerScriptId,3.14,4000)
	end
end


--**********************************
--进入战斗....
--**********************************
function x893023_OnEnterCombat(sceneId, selfId, enmeyId)	
	--重置AI....
	x893023_ResetMyAI( sceneId, selfId )
	--发表讲话 出招吧
	PaoPaoExEx(sceneId,selfId, 527)
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893023_IDX_CombatFlag, 1 )
	--关闭入口
	CallScriptFunction(x893023_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,1);
	CallScriptFunction(x893023_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,5);
end


--**********************************
--离开战斗....
--**********************************
function x893023_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x893023_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
	--玩家死完，关闭入口封闭逻辑
	CallScriptFunction(x893023_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893023_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,5);
end

--**********************************
--杀死敌人....
--**********************************
function x893023_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x893023_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x893023_g_FuBenScriptId, "OnYunJuanShuDie", sceneId,selfId);
end

--**********************************
--对话框提示
--**********************************
function x893023_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

