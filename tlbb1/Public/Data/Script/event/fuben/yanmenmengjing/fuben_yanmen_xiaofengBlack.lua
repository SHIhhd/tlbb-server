--萧峰魔厄分身逻辑

--脚本号
x998464_g_ScriptId	= 998464
--副本逻辑脚本号....
x998464_g_FuBenScriptId = 998445
x998464_g_CopySceneData_Level = 11			--副本的等级
x998464_g_CopySceneData_InitLevel = 12		--副本创建等级
--是否处于战斗状态的标志....
x998464_IDX_CombatFlag 			= 1	
--部分状态变量
x998464_IDX_SkillCycle_Timer	= 5
x998464_IDX_CurrentStage		= 6
-- 阶段枚举
x998464_g_STAGE = { 
	A = 1, 
	B = 2, 
}
-- 阶段对应的技能函数
x998464_g_stageAction = {
  [x998464_g_STAGE.A] = x998464_UseSkillA,
  [x998464_g_STAGE.B] = x998464_UseSkillA,
}

-- 阶段持续时长（毫秒）
x998464_g_stageDuration = {
  [x998464_g_STAGE.A] = 4000,
  [x998464_g_STAGE.B] = 4000,
}
--萧峰心魔黑色分身技能
x998464_g_FenShenSkill = {
	[1] = {
		skillId = 3895,
	},	--普通
	[2] = {
		skillId = 3922,
	},	--困难
}

--**********************************
--入口函数
--**********************************
function x998464_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x998464_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998464_IDX_CombatFlag, 0 )
	--重置阶段至1
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998464_IDX_SkillCycle_Timer, 2000)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998464_IDX_CurrentStage, 1)
end
--**********************************
--使用技能
--**********************************
function x998464_UseSkillA( sceneId, selfId )
	--能否释放技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x998464_g_FenShenSkill[1].skillId) ~= 1 then
		return 1
	end
	local nBossX,nBossZ = GetWorldPos( sceneId, selfId )
	--选择玩家释放特殊技能
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
	if numPlayer > 1 then
		local idx = random(1,numPlayer)
		LuaFnUnitUseSkill( sceneId, selfId, x998464_g_FenShenSkill[1].skillId, tPlayerList[idx], nBossX,nBossZ, 0, 1 )
	else
		LuaFnUnitUseSkill( sceneId, selfId, x998464_g_FenShenSkill[1].skillId, tPlayerList[1], nBossX,nBossZ, 0, 1 )
	end
	return 1
end
--**********************************
--初始化....
--**********************************
function x998464_OnInit(sceneId, selfId)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998464_g_CopySceneData_Level)
	SetLevel( sceneId, selfId, nFubenLev )
	SetMonsterFightWithNpcFlag(sceneId, selfId, 1)
	--自动消亡时间
	SetCharacterDieTime(sceneId, selfId,25000)
end

--**********************************
--心跳....
--**********************************
function x998464_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x998464_IDX_CombatFlag ) then
		return
	end
	
	-- 读取当前 timer 和阶段
	local timer = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998464_IDX_SkillCycle_Timer)
	local stage = MonsterAI_GetIntParamByIndex(sceneId, selfId, x998464_IDX_CurrentStage)

	-- 倒计时
	timer = timer - nTick
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x998464_IDX_SkillCycle_Timer, timer)
	
	-- 还没到切换时间，直接返回
	if timer > 0 then
		return
	end
	if x998464_g_stageAction[stage] == nil then
		stage = 1
	end
	-- 尝试释放当前阶段技能
	local ok = x998464_g_stageAction[stage](sceneId, selfId)
	if ok == 1 then
		-- 释放成功，进入下一个阶段
		local nextStage = mod(stage,getn(x998464_g_stageAction)) + 1
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998464_IDX_CurrentStage, nextStage)
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998464_IDX_SkillCycle_Timer, x998464_g_stageDuration[nextStage])
	else
		-- 释放失败时，500ms 后重试
		MonsterAI_SetIntParamByIndex(sceneId, selfId, x998464_IDX_SkillCycle_Timer, 500)
	end
end

--**********************************
--技能释放成功
--**********************************
function x998464_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	
end

--**********************************
--进入战斗....
--**********************************
function x998464_OnEnterCombat(sceneId, selfId, enmeyId)	
	--重置状态
	x998464_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x998464_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x998464_OnLeaveCombat(sceneId, selfId)
	--重置状态
	x998464_ResetMyAI( sceneId, selfId )
end

--**********************************
--杀死敌人....
--**********************************
function x998464_OnKillCharacter(sceneId, selfId, targetId)
	
end

--**********************************
--死亡....
--**********************************
function x998464_OnDie( sceneId, selfId, killerId )

end

--**********************************
--对话框提示
--**********************************
function x998464_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

