--荼蘼花陷阱AI

--脚本号
x893024_g_ScriptId	= 893024
--效果技能
x893024_g_SkillId = 3585
--Boss1云卷舒的ID
x893024_g_SceneData_BOSS_1_ObjId = 12	
--NPC Param分配
x893024_g_NPCParam_MainSpecId = 0
x893024_g_NPCParam_SubSpecId = 1

x893024_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....
--**********************************
--入口函数
--**********************************
function x893024_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--初始化....
--**********************************
function x893024_OnInit(sceneId, selfId)	
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893024_IDX_CombatFlag, 0 )
end

--**********************************
--心跳....
--**********************************
function x893024_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	--防止反复调用
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893024_IDX_CombatFlag ) then
		return
	end
	--遍历周边玩家
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			if IsInDist(sceneId,selfId,nHumanId,3) == 1 then
				x893024_OnEnterCombat(sceneId, selfId, nHumanId)
				return
			end
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x893024_OnEnterCombat(sceneId, selfId, enmeyId)
	--防止反复调用
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893024_IDX_CombatFlag ) then
		return
	end
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893024_IDX_CombatFlag, 1 )
	
	local nBoss1ObjId = LuaFnGetCopySceneData_Param(sceneId,x893024_g_SceneData_BOSS_1_ObjId)
	if nBoss1ObjId ~= -1 and LuaFnIsCharacterLiving(sceneId, nBoss1ObjId) == 1 then
		local nSubSpecObj = LuaFnGetNpcIntParameter(sceneId,nBoss1ObjId,x893024_g_NPCParam_SubSpecId)
		--释放技能效果
		LuaFnUnitUseSkill(sceneId,selfId,x893024_g_SkillId,selfId,-1,-1,-1,0)
		--创建触发陷阱
		local x,z = GetWorldPos( sceneId, selfId )
		CreateSpecialObjByDataIndex(sceneId, selfId, nSubSpecObj, x, z, 0)
		--设置自身死亡在3000ms后死亡
		SetCharacterDieTime(sceneId, selfId,3000)
	end
end


--**********************************
--离开战斗....
--**********************************
function x893024_OnLeaveCombat(sceneId, selfId)

end

--**********************************
--杀死敌人....
--**********************************
function x893024_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x893024_OnDie( sceneId, selfId, killerId )

end

--**********************************
--对话框提示
--**********************************
function x893024_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

