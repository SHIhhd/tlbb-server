--赵钱孙保护罩逻辑

--脚本号
x998449_g_ScriptId	= 998449
--副本逻辑脚本号....
x998449_g_FuBenScriptId = 998445
x998449_g_CopySceneData_Level = 11			--副本的等级
x998449_g_CopySceneData_InitLevel = 12		--副本创建等级
--是否处于战斗状态的标志....
x998449_IDX_CombatFlag 			= 1
--自身引导保护效果	
x998449_g_ChargeProtect = 46505
--**********************************
--入口函数
--**********************************
function x998449_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--重置AI....
--**********************************
function x998449_ResetMyAI( sceneId, selfId )

end

--**********************************
--初始化....
--**********************************
function x998449_OnInit(sceneId, selfId)
	
end

--**********************************
--心跳....
--**********************************
function x998449_OnHeartBeat(sceneId, selfId, nTick)

end

--**********************************
--技能释放成功
--**********************************
function x998449_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)

end

--**********************************
--进入战斗....
--**********************************
function x998449_OnEnterCombat(sceneId, selfId, enmeyId)	

end


--**********************************
--离开战斗....
--**********************************
function x998449_OnLeaveCombat(sceneId, selfId)

end

--**********************************
--杀死敌人....
--**********************************
function x998449_OnKillCharacter(sceneId, selfId, targetId)
	
end

--**********************************
--死亡....
--**********************************
function x998449_OnDie( sceneId, selfId, killerId )
	--查询归属是否为赵钱孙本体
	local nMasterObjId = LuaFnGetNpcIntParameter(sceneId,selfId,0)
	if nMasterObjId ~= -1 then
		--允许本体施法可被打断
		LuaFnCancelSpecificImpact(sceneId,nMasterObjId,x998449_g_ChargeProtect)
	end
end

--**********************************
--对话框提示
--**********************************
function x998449_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

