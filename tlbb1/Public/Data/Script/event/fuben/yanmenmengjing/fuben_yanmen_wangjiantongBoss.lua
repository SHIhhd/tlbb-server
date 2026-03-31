--汪剑通BOSSAI逻辑

--脚本号
x998452_g_ScriptId	= 998452
--副本逻辑脚本号....
x998452_g_FuBenScriptId = 998445
x998452_g_CopySceneData_Level = 11			--副本的等级
x998452_g_CopySceneData_InitLevel = 12		--副本创建等级
--动阻控制脚本
x998452_g_DynamicBlockScriptId	= 893038
--是否处于战斗状态的标志....
x998452_IDX_CombatFlag 			= 1	
--部分状态变量
x998452_IDX_SkillCycle_Timer	= 1
x998452_IDX_CurrentStage		= 2
-- 阶段枚举
x998452_g_STAGE = { 
	A = 1, 
	B = 2, 
	C = 3,
	D = 4,
}

-- 阶段对应的技能函数
x998452_g_stageAction = {
  [x998452_g_STAGE.A] = x998452_UseSkillA,
  [x998452_g_STAGE.B] = x998452_UseSkillA,
  [x998452_g_STAGE.C] = x998452_UseSkillB,
  [x998452_g_STAGE.D] = x998452_UseSkillC,
}

-- 阶段持续时长（毫秒）
x998452_g_stageDuration = {
  [x998452_g_STAGE.A] = 8000,
  [x998452_g_STAGE.B] = 8000,
  [x998452_g_STAGE.C] = 10000,  -- 10s
  [x998452_g_STAGE.D] = 12000,  -- 12s
}
--劈天碎月
x998452_g_PiTianSuiYue = {
	[1] = {
		skillId = 3874,
		tSpecialObj = {1505,1505,1505,1505,1505,1505,1506,1507,1508,1509,1510},
	},	--普通
	[2] = {
		skillId = 3901,
		tSpecialObj = {1547,1547,1547,1547,1547,1547,1548,1549,1550,1551,1552},
	},	--困难
}
--风卷残云
x998452_g_FengJuanCanYun = {
	[1] = {
		skillId = 3875,
		tSpecialObj = {1511,1511,1511,1511,1511,1511,1512,1513,1514,1515,1516},
	},	--普通
	[2] = {
		skillId = 3902,
		tSpecialObj = {1553,1553,1553,1553,1553,1553,1554,1555,1556,1557,1558},
	},	--困难
}
--横扫千军
x998452_g_HengSaoQianJun = {
	[1] = {
		skillId = 3876,
	},	--普通
	[2] = {
		skillId = 3903,
	},	--困难
}
x998452_g_HengSaoQianJunImpact = 46508
--**********************************
--入口函数
--**********************************
function x998452_OnDefaultEvent( sceneId, selfId, targetId )
	
end
--**********************************
--劈天碎月用 计算周边8个围绕点位数据
--**********************************
function x998452_Get8PointsAround(centerX, centerZ, a)
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
--使用技能 劈天碎月
--**********************************
function x998452_UseSkillA( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998452_g_PiTianSuiYue[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_151}")
	--汪剑通施展了：劈天碎月，请少侠注意躲避。	
	CallScriptFunction(x998452_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_95}")
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x998452_g_PiTianSuiYue[nFuBenType].skillId, selfId, -1, -1, 0, 1 )
	--释放爆炸陷阱
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998452_g_CopySceneData_InitLevel)
	local cx, cz = GetWorldPos( sceneId, selfId )
	local eightPts = x998452_Get8PointsAround(cx, cz, 12)
	for i,p in eightPts do
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x998452_g_PiTianSuiYue[nFuBenType].tSpecialObj[nFubenInitLev],p.x,p.z,0)
		--print(format("Point %d: (%.2f, %.2f)", i, p.x, p.z))
	end
	CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x998452_g_PiTianSuiYue[nFuBenType].tSpecialObj[nFubenInitLev],cx,cz,0)
	
	--随机创建特殊怪物
	CallScriptFunction(x998452_g_FuBenScriptId, "CreateSpecialMonster",sceneId,selfId,2)
	return 1
end

--**********************************
--使用技能 风卷残云
--**********************************
function x998452_UseSkillB( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998452_g_FengJuanCanYun[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_152}")
	--汪剑通施展了：风卷残云，请少侠一定注意躲避！	
	CallScriptFunction(x998452_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_97}")
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x998452_g_FengJuanCanYun[nFuBenType].skillId, selfId, -1, -1, 0, 1 )
	--创建随机4个陷阱
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998452_g_CopySceneData_InitLevel)
	local x,z = GetWorldPos( sceneId, selfId )
	for i = 1,4 do
		local nRandX,nRandZ = LuaFnRandPosInCenter(x,z,12.0);
		if nRandX == nil then
			break
		end
		print(nRandX,nRandZ)
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x998452_g_FengJuanCanYun[nFuBenType].tSpecialObj[nFubenInitLev],
			nRandX,nRandZ,0)
	end
	return 1
end

--**********************************
--使用技能 横扫千军
--**********************************
function x998452_UseSkillC( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998452_g_HengSaoQianJun[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_153}")
	LuaFnNpcTalk(sceneId,233,"#{YMMJ_230626_153}")
	--汪剑通施展了：横扫千军，请少侠注意躲避汪剑通和其分身的追击。	
	CallScriptFunction(x998452_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_94}")
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x998452_g_HengSaoQianJun[nFuBenType].skillId, selfId, -1, -1, 0, 1 )
	return 1
end

--**********************************
--重置AI....
--**********************************
function x998452_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998452_IDX_CombatFlag, 0 )
	--重置阶段至1
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998452_IDX_SkillCycle_Timer, 5000)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998452_IDX_CurrentStage, 1)
end

--**********************************
--初始化....
--**********************************
function x998452_OnInit(sceneId, selfId)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998452_g_CopySceneData_Level)
	SetLevel( sceneId, selfId, nFubenLev )
	SetCharacterTitle( sceneId, selfId, "江湖剑鬓" )
	SetMonsterFightWithNpcFlag(sceneId, selfId, 1)
end

--**********************************
--心跳....
--**********************************
function x998452_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x998452_IDX_CombatFlag ) then
		return
	end
	
	-- 读取当前 timer 和阶段
	local timer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998452_IDX_SkillCycle_Timer)
	local stage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998452_IDX_CurrentStage)

	-- 倒计时
	timer = timer - nTick
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998452_IDX_SkillCycle_Timer, timer)
	
	-- 还没到切换时间，直接返回
	if timer > 0 then
		return
	end
	if x998452_g_stageAction[stage] == nil then
		stage = 1
	end
	-- 尝试释放当前阶段技能
	local ok = x998452_g_stageAction[stage](sceneId, selfId)
	if ok == 1 then
		-- 释放成功，进入下一个阶段
		local nextStage = mod(stage,getn(x998452_g_stageAction)) + 1
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998452_IDX_CurrentStage, nextStage)
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998452_IDX_SkillCycle_Timer, x998452_g_stageDuration[nextStage])
	else
		-- 释放失败时，500ms 后重试
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998452_IDX_SkillCycle_Timer, 500)
	end
end

--**********************************
--技能释放成功
--**********************************
function x998452_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	local x,z = GetWorldPos( sceneId, selfId )
	--风卷残云
	for i = 1,getn(x998452_g_FengJuanCanYun) do
		if nSkillId == x998452_g_FengJuanCanYun[i].skillId then
			for j = 1,4 do
				local nRandX,nRandZ = LuaFnRandPosInCenter(x,z,12.0);
				if nRandX == nil then
					break
				end
				print(nRandX,nRandZ)
				local nMonsterId = CreateMonsterWithDir( sceneId,51407,nRandX,nRandZ, 33, -1, -1,0.873)
				if nMonsterId ~= -1 then
					SetCharacterDieTime(sceneId, nMonsterId,6000)
				end
			end
			
		end
	end
	--横扫千军
	for i = 1,getn(x998452_g_HengSaoQianJun) do
		if nSkillId == x998452_g_HengSaoQianJun[i].skillId then
			for j = 1,4 do
				local nRandX,nRandZ = LuaFnRandPosInCenter(x,z,12.0);
				if nRandX == nil then
					break
				end
				print(nRandX,nRandZ)
				local nMonsterId = CreateMonsterWithDir( sceneId,51408,nRandX,nRandZ, 34, -1, -1,0.873)
				if nMonsterId ~= -1 then
					SetCharacterDieTime(sceneId, nMonsterId,8000)
					--横扫buff
					LuaFnSendSpecificImpactToUnit( sceneId, selfId, nMonsterId, nMonsterId, x998452_g_HengSaoQianJunImpact, 0 )
				end
			end
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x998452_g_HengSaoQianJunImpact, 0 )
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x998452_OnEnterCombat(sceneId, selfId, enmeyId)	
	--重置AI....
	x998452_ResetMyAI( sceneId, selfId )
	--发表讲话
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_194}")
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998452_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x998452_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x998452_ResetMyAI( sceneId, selfId )
end

--**********************************
--杀死敌人....
--**********************************
function x998452_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x998452_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(998445,"OnBossDie",sceneId,selfId,killerId)
end

--**********************************
--对话框提示
--**********************************
function x998452_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

