--赵钱孙分身逻辑

--脚本号
x998450_g_ScriptId	= 998450
--副本逻辑脚本号....
x998450_g_FuBenScriptId = 998445
x998450_g_CopySceneData_Level = 11			--副本的等级
x998450_g_CopySceneData_InitLevel = 12		--副本创建等级
--是否处于战斗状态的标志....
x998450_IDX_CombatFlag 			= 1	
--**********************************
--入口函数
--**********************************
function x998450_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x998450_ResetMyAI( sceneId, selfId )

end

--**********************************
--初始化....
--**********************************
function x998450_OnInit(sceneId, selfId)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998450_g_CopySceneData_Level)
	SetLevel( sceneId, selfId, nFubenLev )
	SetCharacterTitle( sceneId, selfId, "无踪分身" )
	SetMonsterFightWithNpcFlag(sceneId, selfId, 1)
	--运气特殊技能
	LuaFnUnitUseSkill( sceneId, selfId,3925, selfId, -1, -1, 0, 1 )
end

--**********************************
--心跳....
--**********************************
function x998450_OnHeartBeat(sceneId, selfId, nTick)

end

--**********************************
--技能释放成功
--**********************************
function x998450_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)

end

--**********************************
--进入战斗....
--**********************************
function x998450_OnEnterCombat(sceneId, selfId, enmeyId)	

end


--**********************************
--离开战斗....
--**********************************
function x998450_OnLeaveCombat(sceneId, selfId)

end

--**********************************
--杀死敌人....
--**********************************
function x998450_OnKillCharacter(sceneId, selfId, targetId)
	
end

--**********************************
--死亡....
--**********************************
function x998450_OnDie( sceneId, selfId, killerId )
	local x,z = GetWorldPos( sceneId, selfId )
	--释放爆炸陷阱
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998450_g_CopySceneData_InitLevel)
	local tBoomSpecialObj = {1675,1675,1675,1675,1675,1675,1676,1677,1678,1679,1680}
	CreateSpecialObjByDataIndex(sceneId, selfId, tBoomSpecialObj[nFubenInitLev], x, z, 0)
end

--**********************************
--对话框提示
--**********************************
function x998450_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

