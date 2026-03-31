--水月山庄 侏儒刺客 梵无救SKILLNPC？？？
--脚本号
x891078_g_ScriptId	= 891078

--buff....
x891078_Buff_MianYi1	= 10472	--免疫一些负面效果....
x891078_Buff_MianYi2	= 10471	--免疫普通隐身....

--AI Index....
x891078_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....

x891078_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....

--**********************************
--入口函数
--**********************************
function x891078_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891078_OnInit(sceneId, selfId)
	--重置AI....
	x891078_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x891078_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891078_IDX_CombatFlag ) then
		return
	end
end

--**********************************
--进入战斗....
--**********************************
function x891078_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891078_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891078_Buff_MianYi2, 0 )
	--重置AI....
	x891078_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891078_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x891078_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x891078_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x891078_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891078_OnDie( sceneId, selfId, killerId )
	
end


--**********************************
--重置AI....
--**********************************
function x891078_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891078_IDX_CombatTime, 0 )

end

--**********************************
--对话框提示
--**********************************
function x891078_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

