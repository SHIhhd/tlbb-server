--赵钱孙BOSSAI逻辑

--脚本号
x998448_g_ScriptId	= 998448
--副本逻辑脚本号....
x998448_g_FuBenScriptId = 998445
x998448_g_CopySceneData_Level = 11			--副本的等级
x998448_g_CopySceneData_InitLevel = 12		--副本创建等级
--是否处于战斗状态的标志....
x998448_IDX_CombatFlag = 1	
--部分状态变量
x998448_IDX_SkillCycle_Timer	= 1
x998448_IDX_CurrentStage		= 2

-- 阶段枚举
x998448_g_STAGE = { 
	A = 1, 
	B = 2, 
	C = 3,
	D = 4,
}

-- 阶段对应的技能函数
x998448_g_stageAction = {
  [x998448_g_STAGE.A] = x998448_UseSkillA,
  [x998448_g_STAGE.B] = x998448_UseSkillA,
  [x998448_g_STAGE.C] = x998448_UseSkillC,
  [x998448_g_STAGE.D] = x998448_UseSkillB,
}

-- 阶段持续时长（毫秒）
x998448_g_stageDuration = {
  [x998448_g_STAGE.A] = 8000,
  [x998448_g_STAGE.B] = 8000,
  [x998448_g_STAGE.C] = 10000,  -- 10s
  [x998448_g_STAGE.D] = 12000,  -- 12s
}

--部分技能常量
x998448_g_DuanBoZhang = {
	[1] = {skillId = 3871,impactId_Line = 46501},	--普通
	[2] = {skillId = 3898,impactId_Line = 46501},	--困难
}
--遁地匿形
x998448_g_DunDiNiXing = {
	[1] = {skillId = 3873},	--普通
	[2] = {skillId = 3900},	--困难
}
--偷龙转凤
x998448_g_TouLongZhuanFeng = {
	[1] = {skillId = 3925,impact_boss = 46503},	--普通
	[2] = {skillId = 3926,impact_boss = 46504},	--困难
}

--赵钱孙矩形预警
x998448_g_WarningMonster = 51368
--赵钱孙遁地隐身效果
x998448_g_DunDiImpact = 46502
--分身控制脚本
x998448_g_FenShenScriptId = 998450
x998448_g_FenShenBanMove = 46506
--保护罩相关
x998448_g_ZhaoqiansunProtect = {51361,51361,51361,51361,51361,51361,51362,51363,51364,51365,51366}
x998448_g_ZhaoqiansunProtectScript = 998449
x998448_g_ChargeProtect = 46505
--**********************************
--入口函数
--**********************************
function x998448_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--使用技能A-断波掌
--**********************************
function x998448_UseSkillA( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998448_g_DuanBoZhang[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_168}")
	--赵钱孙施展了：断波掌，少侠躲避的同时，可利用其余波消除地面的缩地之洞。
	CallScriptFunction(x998448_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_86}")
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x998448_g_DuanBoZhang[nFuBenType].skillId, selfId, -1, -1, 0, 1 )
	--周边随机生成3个小陷阱
	local x,z = GetWorldPos( sceneId, selfId )
	for i = 1,3 do
		local nRandX,nRandZ = LuaFnRandPosInCenter(x,z,16.0);
		if nRandX == nil then
			break
		end
		print(nRandX,nRandZ)
		local nMonsterId = CreateMonsterWithDir( sceneId,51360 ,nRandX,nRandZ, 3, -1, -1,0.873)
		if nMonsterId ~= -1 then
			SetCharacterDieTime(sceneId, nMonsterId,15000)
		end
	end
	--遍历周边玩家4个玩家给予断波掌效果buff
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
	end
	for i = 1,getn(selected) do
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selected[i], x998448_g_DuanBoZhang[nFuBenType].impactId_Line, 0 )
	end
	--随机创建特殊怪物
	CallScriptFunction(x998448_g_FuBenScriptId, "CreateSpecialMonster",sceneId,selfId,2)
	
	return 1
end

--**********************************
--使用技能B
--**********************************
function x998448_UseSkillB( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998448_g_TouLongZhuanFeng[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_169}")
	--赵钱孙施展了：偷龙转凤，少侠需要召出真身打断其运气，否则赵钱孙会回复大量血量。	
	CallScriptFunction(x998448_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_87}")
	--设置自身引导不被打断
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x998448_g_ChargeProtect, 0 )
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x998448_g_TouLongZhuanFeng[nFuBenType].skillId, selfId, -1, -1, 0, 1 )
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998448_g_CopySceneData_InitLevel)
	--创建分身 3个
	local x,z = GetWorldPos( sceneId, selfId )
	for i = 1,3 do
		local nRandX,nRandZ = LuaFnRandPosInCenter(x,z,16.0);
		if nRandX == nil then
			break
		end
		print(nRandX,nRandZ)
		local nMonsterId = CreateMonsterWithDir( sceneId,51367 ,nRandX,nRandZ, 21, -1, x998448_g_FenShenScriptId,GetObjDir(sceneId,selfId))
		if nMonsterId ~= -1 then
			--最大到运气结束后消失
			SetCharacterDieTime(sceneId, nMonsterId,15000)
			--设置自身引导不被打断
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, nMonsterId, nMonsterId, x998448_g_ChargeProtect, 0 )
			--禁止移动
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, nMonsterId, nMonsterId, x998448_g_FenShenBanMove, 0 )
			--技能动作
			LuaFnUnitUseSkill( sceneId, nMonsterId, x998448_g_TouLongZhuanFeng[nFuBenType].skillId, nMonsterId, -1, -1, 0, 1 )
		end
		--同样的位置创建保护罩
		local nProtectId = CreateMonsterWithDir( sceneId,
			x998448_g_ZhaoqiansunProtect[nFubenInitLev],
			nRandX,nRandZ, 26, -1, 
			x998448_g_ZhaoqiansunProtectScript,GetObjDir(sceneId,selfId))
		if nProtectId ~= -1 then
			--最大到运气结束后消失
			SetCharacterDieTime(sceneId, nProtectId,15000)
			--设置归属的NPC
			LuaFnSetNpcIntParameter(sceneId,nProtectId,0,nMonsterId)
			--设置拥有的保护罩
			LuaFnSetNpcIntParameter(sceneId,nMonsterId,0,nProtectId)
		end
	end
	--BOSS自身也创建保护罩
	local nProtectId = CreateMonsterWithDir( sceneId,
		x998448_g_ZhaoqiansunProtect[nFubenInitLev],
		x,z, 21, -1, 
		x998448_g_ZhaoqiansunProtectScript,GetObjDir(sceneId,selfId))
	if nProtectId ~= -1 then
		--最大到运气结束后消失
		SetCharacterDieTime(sceneId, nProtectId,15000)
		--设置归属的NPC
		LuaFnSetNpcIntParameter(sceneId,nProtectId,0,selfId)
		--设置拥有的保护罩
		LuaFnSetNpcIntParameter(sceneId,selfId,0,nProtectId)
	end
	
	return 1
end

--**********************************
--使用技能 缩骨遁地功
--**********************************
function x998448_UseSkillC( sceneId, selfId )
	--判定副本难易
	local nFuBenType = 1
	if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
		nFuBenType = 2
	end
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998448_g_DunDiNiXing[nFuBenType].skillId) ~= 1 then
		return 1
	end
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_170}")
	LuaFnNpcTalk(sceneId,288,"#{YMMJ_230626_170}")
	--赵钱孙施展了：缩骨遁地功，请少侠注意躲避。	
	CallScriptFunction(x998448_g_FuBenScriptId, "TipAllHuman",sceneId,"#{YMMJ_230626_88}")
	--技能动作
	LuaFnUnitUseSkill( sceneId, selfId, x998448_g_DunDiNiXing[nFuBenType].skillId, selfId, -1, -1, 0, 1 )
	--使自己隐身
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x998448_g_DunDiImpact, 0 )
	--在中心区域创建随机移动的特殊土包
	for i = 1,8 do
		local nRandX,nRandZ = LuaFnRandPosInCenter(52,202,16.0);
		if nRandX == nil then
			break
		end
		print(nRandX,nRandZ)
		local nMonsterId = CreateMonsterWithDir( sceneId,51399 ,nRandX,nRandZ, 33, -1, -1,0.873)
		if nMonsterId ~= -1 then
			SetCharacterDieTime(sceneId, nMonsterId,18000)
		end
	end
	return 1
end

--**********************************
--重置AI....
--**********************************
function x998448_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998448_IDX_CombatFlag, 0 )
	--重置阶段至1
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998448_IDX_SkillCycle_Timer, 5000)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998448_IDX_CurrentStage, 1)
end

--**********************************
--初始化....
--**********************************
function x998448_OnInit(sceneId, selfId)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998448_g_CopySceneData_Level)
	SetLevel( sceneId, selfId, nFubenLev )
	SetCharacterTitle( sceneId, selfId, "无踪行者" )
	SetMonsterFightWithNpcFlag(sceneId, selfId, 1)
end

--**********************************
--心跳....
--**********************************
function x998448_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x998448_IDX_CombatFlag ) then
		return
	end
	
	--检测是不是在遁地状态
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x998448_g_DunDiImpact) == 1 then
		return
	end
	
	-- 读取当前 timer 和阶段
	local timer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998448_IDX_SkillCycle_Timer)
	local stage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998448_IDX_CurrentStage)

	-- 倒计时
	timer = timer - nTick
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998448_IDX_SkillCycle_Timer, timer)
	
	-- 还没到切换时间，直接返回
	if timer > 0 then
		return
	end
	if x998448_g_stageAction[stage] == nil then
		stage = 1
	end
	-- 尝试释放当前阶段技能
	local ok = x998448_g_stageAction[stage](sceneId, selfId)
	if ok == 1 then
		-- 释放成功，进入下一个阶段
		local nextStage = mod(stage,getn(x998448_g_stageAction)) + 1
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998448_IDX_CurrentStage, nextStage)
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998448_IDX_SkillCycle_Timer, x998448_g_stageDuration[nextStage])
	else
		-- 释放失败时，500ms 后重试
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998448_IDX_SkillCycle_Timer, 500)
	end
end

--**********************************
--技能释放成功
--**********************************
function x998448_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--断波掌
	for i = 1,getn(x998448_g_DuanBoZhang) do
		if nSkillId == x998448_g_DuanBoZhang[i].skillId then
			local x,z = GetWorldPos( sceneId, selfId )
			--遍历拥有效果的玩家方位，释放obj并指向
			local tPlayerList = {}
			local numPlayer = 0
			local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
			for j=0, nHumanCount-1 do
				local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, j)
				if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
					if LuaFnHaveImpactOfSpecificDataIndex(sceneId,nHumanId,x998448_g_DuanBoZhang[i].impactId_Line) == 1 then
						local fAngle = LuaFnGetObjAngle(sceneId,selfId,nHumanId)
						local nMonsterId = CreateMonsterWithDir( sceneId,x998448_g_WarningMonster ,
							x,z, 3, -1, -1,fAngle)
						if nMonsterId ~= -1 then
							SetCharacterDieTime(sceneId, nMonsterId,4000)
						end
					end
				end
			end
			break
		end
	end
	--回血技能
	for i = 1,getn(x998448_g_TouLongZhuanFeng) do
		if nSkillId == x998448_g_TouLongZhuanFeng[i].skillId then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x998448_g_TouLongZhuanFeng[i].impact_boss, 0 )
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x998448_OnEnterCombat(sceneId, selfId, enmeyId)	
	--重置AI....
	x998448_ResetMyAI( sceneId, selfId )
	--发表讲话
	LuaFnNpcTalkPaoPao(sceneId,selfId,"#{YMMJ_230626_130}")
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998448_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x998448_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x998448_ResetMyAI( sceneId, selfId )
end

--**********************************
--杀死敌人....
--**********************************
function x998448_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x998448_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(998445,"OnBossDie",sceneId,selfId,killerId)
end

--**********************************
--对话框提示
--**********************************
function x998448_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

