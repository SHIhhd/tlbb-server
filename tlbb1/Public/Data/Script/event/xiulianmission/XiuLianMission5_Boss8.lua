--门派演武 
--残影AI

--脚本号
x891300_g_ScriptId	= 891300

--buff....
x891300_Skill_A			=	3284
x891300_Skill_B			=	3285

--AI Index....
x891300_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....

x891300_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....


--**********************************
--初始化....
--**********************************
function x891300_OnInit(sceneId, selfId)
end


--**********************************
--心跳....
--**********************************
function x891300_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891300_IDX_CombatFlag ) then
		return
	end
	
	--累加进入战斗的时间....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891300_IDX_CombatTime )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891300_IDX_CombatTime, CombatTime + nTick )
	
	if mod(CombatTime,5) == 0 then
		local nTarget = LuaFnGetTargetObjID(sceneId, selfId)
		if(-1~=nTarget) then
			local posX, posZ = GetWorldPos(sceneId,nTarget)
			if random(1,2) == 1 then
				LuaFnUnitUseSkill(sceneId, selfId, x891300_Skill_A, nTarget, posX, posZ, 0)	
			else
				LuaFnUnitUseSkill(sceneId, selfId, x891300_Skill_B, nTarget, posX, posZ, 0)	
			end		
		end
	end

end


--**********************************
--进入战斗....
--**********************************
function x891300_OnEnterCombat(sceneId, selfId, enmeyId)
	--重置AI....
	x891300_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891300_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x891300_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x891300_ResetMyAI( sceneId, selfId )
end


--**********************************
--杀死敌人....
--**********************************
function x891300_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x891300_OnDie( sceneId, selfId, killerId )
	--重置AI....
	x891300_ResetMyAI( sceneId, selfId )
end


--**********************************
--重置AI....
--**********************************
function x891300_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891300_IDX_CombatTime, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891300_IDX_CombatFlag, 0 )
end

