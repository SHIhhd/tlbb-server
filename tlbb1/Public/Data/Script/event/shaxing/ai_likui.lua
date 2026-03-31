--生死擂台·李魁
--脚本号
x402315_g_ScriptId	= 402315

--副本逻辑脚本号....
x402315_g_FuBenScriptId = 892009

--buff....
x402315_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402315_Buff_MianYi2	= 10471	--免疫普通隐身....

x402315_Skill_SQWY		= 1310 --杀气瘟疫
x402315_Skill_SQBF		= 1311 --杀气爆发

--技能释放时间表....
x402315_UseSkillList =
{
	10,
	40,
	70,
	100,
	130,
	160,
	190,
	220,
	250,
	280,
	300,
}


--AI Index....
x402315_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402315_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x402315_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402315_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x402315_OnDefaultEvent( sceneId, selfId, targetId )
end

--**********************************
--初始化....
--**********************************
function x402315_OnInit(sceneId, selfId)
	--重置AI....
	x402315_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402315_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402315_IDX_CombatFlag ) then
		return
	end
	
	
	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent <= 0.1 then --血量还剩10%不在释放其他技能
		if MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402315_IDX_IsKuangBaoMode ) ~= 1 then
			--释放技能杀气爆发再来一段对话
			LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_117}")
			local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
			LuaFnUnitUseSkill(sceneId,selfId,x402315_Skill_SQBF,selfId,nPosX,nPosZ,0,1)
			MonsterAI_SetBoolParamByIndex(sceneId,selfId,x402315_IDX_IsKuangBaoMode,1)
		end
		return
	end
	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402315_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402315_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402315_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x402315_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x402315_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData * 1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402315_IDX_UseSkillIndex, NextSkillIndex+1 )
		x402315_UseMySkill(sceneId,selfId)
	end

end

--**********************************
--进入战斗....
--**********************************
function x402315_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402315_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402315_Buff_MianYi2, 0 )

	--重置AI....
	x402315_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402315_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x402315_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x402315_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x402315_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x402315_OnDie( sceneId, selfId, killerId )
	--记录已经在生死擂台击杀多少只怪物了。
	local nKillNum = LuaFnGetCopySceneData_Param(sceneId,16)
	local IsZhanDouFlag = LuaFnGetCopySceneData_Param(sceneId,18)
	local szName = GetName(sceneId,selfId)
	if nKillNum >= 6 then
		LuaFnSetCopySceneData_Param(sceneId,16,6)
	else
		LuaFnSetCopySceneData_Param(sceneId,16,nKillNum + 1)
	end
	--死亡后给一条提示下一个杀星将于多久后出现
	local TickCount = LuaFnGetCopySceneData_Param(sceneId,17)
	local baseTick = 300
	local remainingSeconds = baseTick - mod(TickCount,baseTick)
	local remainingMinutes = floor(remainingSeconds / 60)
	local remainingSecondsInMinute = mod(remainingSeconds,60)
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i=0,membercount-1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 then
			--给队伍增加击杀次数
			SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_LIKUI,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_LIKUI) + 1)
			--标记BOSS被击杀
			CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
			
			x402315_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
			if IsZhanDouFlag > 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,0)
			end
			if nKillNum + 1 < 6 then
				x402315_NotifyTip( sceneId, mems[i],
					format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
					,remainingMinutes
					,remainingSecondsInMinute
				));
			end
			--发个系统，只有队长可以操作。
			if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
				local strText = format("#{_INFOUSR%s}#{SXRW_090119_130}",GetName(sceneId,mems[i]))
				BroadMsgByChatPipe(sceneId,mems[i],strText,4)
			end
		end
	end
end


--**********************************
--重置AI....
--**********************************
function x402315_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402315_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402315_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402315_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402315_IDX_CombatFlag, 0 )


end

--**********************************
--BOSS使用技能....
--**********************************
function x402315_UseMySkill( sceneId, selfId ,skill)
	--获取怪物当前进攻的OBJID给他来上一个杀气瘟疫！！！
	local nObjId = GetMonsterCurEnemy(sceneId,selfId)
	if not nObjId and nObjId == -1 then
		return
	end
	local szName = GetName(sceneId,nObjId)
	LuaFnNpcChat(sceneId, selfId, 0, szName.."#{SXRW_090630_116}")
	local nPosX,nPosZ = GetWorldPos(sceneId,nObjId)
	LuaFnUnitUseSkill(sceneId,selfId,x402315_Skill_SQWY,nObjId,nPosX,nPosZ,0,1)
end


--**********************************
--屏幕提示
--**********************************
function x402315_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

