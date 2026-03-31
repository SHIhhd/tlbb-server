--玄慈BOSSAI逻辑

--脚本号
x998454_g_ScriptId	= 998454
--副本逻辑脚本号....
x998454_g_FuBenScriptId = 998445
x998454_g_CopySceneData_Level = 11			--副本的等级
--动阻控制脚本
x998454_g_DynamicBlockScriptId	= 893038
--是否处于战斗状态的标志....
x998454_IDX_CombatFlag 			= 1	
--**********************************
--入口函数
--**********************************
function x998454_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x998454_ResetMyAI( sceneId, selfId )

end

--**********************************
--初始化....
--**********************************
function x998454_OnInit(sceneId, selfId)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998454_g_CopySceneData_Level)
	SetLevel( sceneId, selfId, nFubenLev )
	SetCharacterTitle( sceneId, selfId, "伏虎罗汉" )
	SetMonsterFightWithNpcFlag(sceneId, selfId, 1)
end

--**********************************
--心跳....
--**********************************
function x998454_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x998454_IDX_CombatFlag ) then
		return
	end
end

--**********************************
--技能释放成功
--**********************************
function x998454_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)

end

--**********************************
--进入战斗....
--**********************************
function x998454_OnEnterCombat(sceneId, selfId, enmeyId)	

end


--**********************************
--离开战斗....
--**********************************
function x998454_OnLeaveCombat(sceneId, selfId)

end

--**********************************
--杀死敌人....
--**********************************
function x998454_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x998454_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x998454_g_FuBenScriptId,"OnBossDie",sceneId,selfId,killerId)
end

--**********************************
--对话框提示
--**********************************
function x998454_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

