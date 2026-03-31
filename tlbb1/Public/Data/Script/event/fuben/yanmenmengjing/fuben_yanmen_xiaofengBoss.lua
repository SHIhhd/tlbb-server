--萧峰BOSSAI逻辑

--脚本号
x998462_g_ScriptId	= 998462
--副本逻辑脚本号....
x998462_g_FuBenScriptId = 998445
x998462_g_CopySceneData_Level = 11			--副本的等级
x998462_g_CopySceneData_InitLevel = 12		--副本创建等级
--动阻控制脚本
x998462_g_DynamicBlockScriptId	= 893038
--是否处于战斗状态的标志....
x998462_IDX_CombatFlag 			= 1	
--萧峰部分状态变量
x998462_IDX_Moqi				= 1
x998462_IDX_Golden				= 2
x998462_IDX_MoqiBak				= 3
x998462_IDX_GoldenBak			= 4
x998462_IDX_SkillCycle_Timer	= 5
x998462_IDX_CurrentStage		= 6
x998462_IDX_LongShiBaHuangX		= 7
x998462_IDX_LongShiBaHuangZ		= 8
x998462_IDX_ZMLW_Count			= 9

--萧峰部分状态常量
x998462_g_MoqiMax				= 18
x998462_g_GoldenMax				= 4
-- 阶段枚举
x998462_g_STAGE = { 
	A = 1, 
	B = 2, 
	C = 3,
	D = 4,
	E = 5,
	F = 6,
}

-- 阶段对应的技能函数
x998462_g_stageAction = {
  [x998462_g_STAGE.A] = x998462_UseSkillA,
  [x998462_g_STAGE.B] = x998462_UseSkillA,
  [x998462_g_STAGE.C] = x998462_UseSkillB,
  [x998462_g_STAGE.D] = x998462_UseSkillC,
  [x998462_g_STAGE.E] = x998462_UseSkillC,
  [x998462_g_STAGE.F] = x998462_UseSkillC,
}

-- 阶段持续时长（毫秒）
x998462_g_stageDuration = {
	[x998462_g_STAGE.A] = 8000,
	[x998462_g_STAGE.B] = 12000,
	[x998462_g_STAGE.C] = 30000,
	[x998462_g_STAGE.D] = 5000,
	[x998462_g_STAGE.E] = 5000,
	[x998462_g_STAGE.F] = 5000,
}
--邪龙巡天
x998462_g_XieLongXunTian = {
	[1] = {
		skillId = 3890,
	},	--普通
	[2] = {
		skillId = 3917,
	},	--困难
}
--正邪何往
x998462_g_ZhengXieHeWang = {
	[1] = {
		skillId = 3891,
		tSpecialObj = {1529,1529,1529,1529,1529,1529,1530,1531,1532,1533,1534},
		
	},	--普通
	[2] = {
		skillId = 3918,
		tSpecialObj = {1571,1571,1571,1571,1571,1571,1572,1573,1574,1575,1576},
	},	--困难
}
--龙噬八荒
x998462_g_LongShiBaHuang = {
	[1] = {
		skillId = 3893,
		tSpecialObj = {1535,1535,1535,1535,1535,1535,1536,1537,1538,1539,1540},
	},	--普通
	[2] = {
		skillId = 3920,
		tSpecialObj = {1577,1577,1577,1577,1577,1577,1578,1579,1580,1581,1582},
	},	--困难
}
--瘴魔乱舞
x998462_g_ZhangMoLuanWu = {
	[1] = {
		skillId = 3896,
		tSpecialObj = {1541,1541,1541,1541,1541,1541,1542,1543,1544,1545,1546},
	},	--普通
	[2] = {
		skillId = 3922,
		tSpecialObj = {1583,1583,1583,1583,1583,1583,1584,1585,1586,1587,1588},
	},	--困难
}
--萧峰混乱状态
x998462_g_HunluanImpact = 46510
--魔气效果的对应层数
x998462_g_BlackImpact = {
	{impactId = 46511,layer = 1},
	{impactId = 46512,layer = 2},
	{impactId = 46513,layer = 3},
}
--正邪何往NPC
x998462_g_SpecialNpc = {
	{tMonsterId = {51554,51554,51554,51554,51554,51554,51555,51556,51557,51558,51559},scriptId = 998464,baseAi = 21},
	{tMonsterId = {51554,51554,51554,51554,51554,51554,51555,51556,51557,51558,51559},scriptId = 998464,baseAi = 21},
	{tMonsterId = {51554,51554,51554,51554,51554,51554,51555,51556,51557,51558,51559},scriptId = 998464,baseAi = 21},
	{tMonsterId = {51560,51560,51560,51560,51560,51560,51560,51560,51560,51560,51560},scriptId = -1,baseAi = 3},
}
--**********************************
--入口函数
--**********************************
function x998462_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--使用特殊技能 瘴魔乱舞 累计释放三次
--**********************************
function x998462_UseSkillSpecial( sceneId, selfId , bFirst )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998462_g_ZhangMoLuanWu[nFuBenType].skillId) ~= 1 then
		return 1
	end
	--技能动作
	local nBossX,nBossZ = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x998462_g_ZhangMoLuanWu[nFuBenType].skillId, selfId, nBossX,nBossZ, 0, 1 )
	
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_210}")
	--萧峰心魔施展了：瘴魔乱舞，注意躲避。	
	CallScriptFunction(x998462_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_211}")
	--增加累计次数
	if bFirst == 1 then
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_ZMLW_Count, 2)
		--清理所有玩家身上的邪气
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				LuaFnCancelSpecificMutexIDImpact( sceneId, nHumanId, 5568 )
			end
		end
	else
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_ZMLW_Count, 
			MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_ZMLW_Count) - 1)
	end
	return 1
end

--**********************************
--使用技能 邪龙巡天
--**********************************
function x998462_UseSkillA( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998462_g_XieLongXunTian[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_167}")
	--萧峰心魔施展了：邪龙巡天，注意躲避。
	CallScriptFunction(x998462_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_123}")
	--技能动作
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x998462_g_XieLongXunTian[nFuBenType].skillId, selfId, x,z , 0, 1 )
	
	--随机创建特殊怪物
	CallScriptFunction(x998462_g_FuBenScriptId, "CreateSpecialMonster",sceneId,selfId,2)
	return 1
end

--**********************************
--使用技能 正邪何往
--**********************************
function x998462_UseSkillB( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998462_g_ZhengXieHeWang[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_164}")
	--萧峰心魔施展了：正邪何往，躲避魔厄分身的攻击，解救清罡分身消弱萧峰心魔的实力。
	CallScriptFunction(x998462_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_124}")
	--技能动作
	local nBossX,nBossZ = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x998462_g_ZhengXieHeWang[nFuBenType].skillId, selfId, nBossX,nBossZ, 0, 1 )
	--选择四个玩家创建特殊陷阱
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998462_g_CopySceneData_InitLevel)
	local tPlayerList = {}
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			tPlayerList[numPlayer + 1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end
	local selected = {}
	if numPlayer > 4 then
		for i = 1, 4 do
			local idx = random(1,numPlayer)
			selected[i] = tPlayerList[idx]
			-- 把表尾的元素交换到 idx
			tPlayerList[idx] = tPlayerList[numPlayer]
			numPlayer = numPlayer - 1
		end
	else
		for i = 1, numPlayer do
			selected[i] = tPlayerList[i]
		end
		-- 补齐 必须保证分身全部召唤
		for i = numPlayer, 4 do
			selected[i] = tPlayerList[1]
		end
	end
	--删除已有的旧的
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == 51560 then
			--自动消亡时间
			SetCharacterDieTime(sceneId, MonsterId,100)
		end
	end
	
	for i = 1,getn(selected) do
		local x,z = GetWorldPos( sceneId, selected[i] )
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x998462_g_ZhengXieHeWang[nFuBenType].tSpecialObj[nFubenInitLev],
			x,z,0)
		--创建延时npc
		if x998462_g_SpecialNpc[i] ~= nil then
			CreateDelayMonsterWithDir( sceneId,x998462_g_SpecialNpc[i].tMonsterId[nFubenInitLev] ,
				x,z, x998462_g_SpecialNpc[i].baseAi, -1, x998462_g_SpecialNpc[i].scriptId,0.873,3000)
		end
	end
	return 1
end

--**********************************
--使用技能 龙噬八荒
--**********************************
function x998462_UseSkillC( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998462_g_LongShiBaHuang[nFuBenType].skillId) ~= 1 then
		return 1
	end
	--创建周围火海
	local nFireMonsterId = CreateMonsterWithDir( sceneId,51456 ,162,60, 3, -1, -1,0.873)
	if nFireMonsterId ~= -1 then
		SetCharacterDieTime(sceneId, nFireMonsterId,20000)
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_166}")
	LuaFnNpcTalk(sceneId,236)
	--萧峰心魔施展了：邪龙巡天，场地周围的火海在蔓延，要注意躲避火海以及萧峰心魔。	
	CallScriptFunction(x998462_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_125}")
	--技能动作
	local nBossX,nBossZ = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x998462_g_LongShiBaHuang[nFuBenType].skillId, selfId, nBossX,nBossZ, 0, 1 )
	--生成随机陷阱位置
	local nRandX,nRandZ = LuaFnRandPosInCenter(162,60,16.0);
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangX, nRandX)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangZ, nRandZ)	
	--创造特殊陷阱
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998462_g_CopySceneData_InitLevel)
	CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x998462_g_LongShiBaHuang[nFuBenType].tSpecialObj[nFubenInitLev],nRandX,nRandZ,0)
	
	return 1
end

--**********************************
--计算玩家邪气累积值
--**********************************
function x998462_ComputeMoQi( sceneId,selfId  )
	local nMoQi = 0
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			
			for j = 1,getn(x998462_g_BlackImpact) do
				if LuaFnHaveImpactOfSpecificDataIndex(sceneId,nHumanId,x998462_g_BlackImpact[j].impactId) == 1 then
					nMoQi = nMoQi + x998462_g_BlackImpact[j].layer
				end
			end
		end
	end
	local nCurMoQi = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Moqi)
	if nCurMoQi ~= nMoQi then
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_Moqi,nMoQi)
	end
end

--**********************************
--重置AI....
--**********************************
function x998462_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998462_IDX_CombatFlag, 0 )
	--重置阶段至1
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_SkillCycle_Timer, 8000)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_CurrentStage, 1)
	
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangX, -1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangZ, -1)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_ZMLW_Count, 0)
end

--**********************************
--初始化....
--**********************************
function x998462_OnInit(sceneId, selfId)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998462_g_CopySceneData_Level)
	SetLevel( sceneId, selfId, nFubenLev )
	SetCharacterTitle( sceneId, selfId, "魔煞" )
	SetMonsterFightWithNpcFlag(sceneId, selfId, 1)
	--特殊提示
	LuaFnNpcTalk(sceneId,231)
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_135}")
end

--**********************************
--心跳....
--**********************************
function x998462_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x998462_IDX_CombatFlag ) then
		return
	end
	
	--更新魔气状态
	local nCurMoQi = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Moqi)
	local nCurMoQiBak = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_MoqiBak)
	
	local nCurGolden = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Golden)
	local nCurGoldenBak = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_GoldenBak)
	
	if nCurMoQi ~= nCurMoQiBak or nCurGolden ~= nCurGoldenBak then
	
		x998462_UpdateMoQi(sceneId,1, 
			MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Moqi),
			x998462_g_MoqiMax,
			MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Golden),
			x998462_g_GoldenMax)
		--更新暂存状态
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_MoqiBak,nCurMoQi)
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_GoldenBak,nCurGolden)
	end
	
	-- 清刚正气满
	if nCurGolden >= x998462_g_GoldenMax then
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_Golden,0)
		--给予自身虚弱效果
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x998462_g_HunluanImpact, 0 )
		LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_210}")
	end
	-- 魔气满
	if nCurMoQi >= x998462_g_MoqiMax then
		x998462_UseSkillSpecial( sceneId, selfId , 1 )
	end
	-- 计算玩家魔气
	x998462_ComputeMoQi( sceneId,selfId )
	
	-- 特殊技能阶段不执行递进逻辑
	if MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_ZMLW_Count) > 0 then
		return
	end
	-- 读取当前 timer 和阶段
	local timer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_SkillCycle_Timer)
	local stage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_CurrentStage)

	-- 倒计时
	timer = timer - nTick
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_SkillCycle_Timer, timer)
	
	-- 还没到切换时间，直接返回
	if timer > 0 then
		return
	end
	if x998462_g_stageAction[stage] == nil then
		stage = 1
	end
	-- 尝试释放当前阶段技能
	local ok = x998462_g_stageAction[stage](sceneId, selfId)
	if ok == 1 then
		-- 释放成功，进入下一个阶段
		local nextStage = mod(stage,getn(x998462_g_stageAction)) + 1
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_CurrentStage, nextStage)
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_SkillCycle_Timer, x998462_g_stageDuration[nextStage])
	else
		-- 释放失败时，500ms 后重试
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_SkillCycle_Timer, 500)
	end
end
--**********************************
--计算周边8个围绕点位数据
--**********************************
function x998462_Get8PointsAround(centerX, centerZ, a)
    local inv_s2 = 1 / sqrt(2)    -- ≈0.70710678118655
	local d = a * inv_s2

	local dirs = {
		{  a,  0},  -- 东
		{  d,  d},  -- 东北
		{  0,  a},  -- 北
		{-d,  d},   -- 西北
		{-a,  0},   -- 西
		{-d, -d},   -- 西南
		{  0, -a},  -- 南
		{ d, -d},   -- 东南
	}

	local pts = {}
	for i, off in dirs do
		-- 四舍五入到整数
		local x = floor(centerX + off[1] + 0.5)
		local z = floor(centerZ + off[2] + 0.5)
		pts[i] = { x = x, z = z }
	end
	return pts
end
--**********************************
--技能释放成功
--**********************************
function x998462_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--龙噬八荒
	for i = 1,getn(x998462_g_LongShiBaHuang) do
		if nSkillId == x998462_g_LongShiBaHuang[i].skillId then
			local nRandX = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangX)
			local nRandZ = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangZ)	
			--位置确定移动萧峰至指定位置
			SetPos(sceneId,selfId,nRandX,nRandZ)
			--创建可移动的龙
			local eightPts = x998462_Get8PointsAround(nRandX, nRandZ, 32)
			for i,p in eightPts do
				local nMonsterId = CreateMonster( sceneId,51457 ,nRandX,nRandZ, 32, -1, -1)
				if nMonsterId ~= -1 then
					SetCharacterDieTime(sceneId, nMonsterId,8000)
					MonsterDoMove(sceneId,nMonsterId,p.x, p.z,1)
				end
				print(format("Point %d: (%.2f, %.2f)", i, p.x, p.z))
			end
			--使用完毕后重置位置
			MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangX, -1)
			MonsterAI_SetIntParamByIndex(sceneId, selfId, x998462_IDX_LongShiBaHuangZ, -1)	
		end
	end
	--瘴魔乱舞
	for i = 1,getn(x998462_g_ZhangMoLuanWu) do
		if nSkillId == x998462_g_ZhangMoLuanWu[i].skillId then
			--选择周围所有玩家释放陷阱
			local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998462_g_CopySceneData_InitLevel)
			local tPlayerList = {}
			local numPlayer = 0
			local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanCount-1 do
				local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
					local x,z = GetWorldPos( sceneId, nHumanId )
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x998462_g_ZhangMoLuanWu[1].tSpecialObj[nFubenInitLev],
						x,z,0)
				end
			end
			if MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_ZMLW_Count) > 0 then
				--继续执行特殊技能
				x998462_UseSkillSpecial( sceneId, selfId , 0 )
			end
		end
	end
	
end

--**********************************
--进入战斗....
--**********************************
function x998462_OnEnterCombat(sceneId, selfId, enmeyId)	
	--重置状态
	x998462_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998462_IDX_CombatFlag, 1 )
	
	x998462_UpdateMoQi(sceneId,1, 
			MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Moqi),
			x998462_g_MoqiMax,
			MonsterAI_GetIntParamByIndex(sceneId, selfId, x998462_IDX_Golden),
			x998462_g_GoldenMax)
end

--**********************************
--更新魔气页面
--**********************************
function x998462_UpdateMoQi(sceneId,bOpen, nMoqiNum,nMoqiMax,nGolden,nGoldenMax)	
	--载入魔气页面
	BeginUICommand( sceneId )
	if bOpen == 1 then
		UICommand_AddInt( sceneId, nMoqiNum)
		UICommand_AddInt( sceneId, nMoqiMax )
		UICommand_AddInt( sceneId, nGolden )
		UICommand_AddInt( sceneId, nGoldenMax )
	end
	EndUICommand( sceneId )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			if bOpen == 1 then
				DispatchUICommand( sceneId, PlayerId, 99846201 )
			else
				DispatchUICommand( sceneId, PlayerId, 99846202 )
			end
		end
	end
end

--**********************************
--离开战斗....
--**********************************
function x998462_OnLeaveCombat(sceneId, selfId)
	--关闭客户端模块
	x998462_UpdateMoQi(sceneId,0)
	--重置状态
	x998462_ResetMyAI( sceneId, selfId )
end

--**********************************
--杀死敌人....
--**********************************
function x998462_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x998462_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x998462_g_FuBenScriptId,"OnBossDie",sceneId,selfId,killerId)
end

--**********************************
--对话框提示
--**********************************
function x998462_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

