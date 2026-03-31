--生死擂台·卢俊义
--脚本号
--A 【天罡皇气】免疫百分之90的伤害
--B 【天人五衰】放大自身伤害2倍
--C 【天罡霸气】反弹伤害百分百....

--全程都带有免疫制定技能的buff....
--10秒后开始使用A技能....冷却30秒....
--A B C技能循环释放 A技能持续15s B技能持续15s C技能持续15s
--5分钟后进入狂暴模式....停止使用ABCD....清除ABCD的buff....使用E技能....
x402314_g_ScriptId	= 402314

--buff....
x402314_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402314_Buff_MianYi2	= 10471	--免疫普通隐身....


--AI Index....
x402314_IDX_CombatTime		= 1	--记录进入战斗得时间....
x402314_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x402314_Skill_A				= 1307 --技能天罡皇气....
x402314_Skill_B				= 1309 --技能天人五衰....
x402314_Skill_C				= 1308 --技能天罡霸气....

x402314_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402314_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--技能释放时间表....
x402314_UseSkillList =
{
	{10,  "A" },
	{25,  "B" },
	{40,  "C" },
	{55,  "A" },
	{70,  "B" },
	{85,  "C" },
	{100, "A" },
	{115, "B" },
	{130, "C" },
	{145, "A" },
	{160, "B" },
	{175, "C" },
	{190, "A" },
	{205, "B" },
	{220, "C" },
	{235, "A" },
	{250, "B" },
	{265, "C" },
}

--**********************************
--入口函数
--**********************************
function x402314_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x402314_OnInit(sceneId, selfId)
	--重置AI....
	x402314_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402314_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402314_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402314_IDX_IsKuangBaoMode ) then
		return
	end
	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402314_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402314_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402314_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x402314_UseSkillList ) then
		return
	end
	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x402314_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402314_IDX_UseSkillIndex, NextSkillIndex+1 )
		x402314_UseMySkill( sceneId, selfId, SkillData[2] )
	end
end

--**********************************
--进入战斗....
--**********************************
function x402314_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402314_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402314_Buff_MianYi2, 0 )

	--重置AI....
	x402314_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402314_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x402314_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x402314_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x402314_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x402314_OnDie( sceneId, selfId, killerId )
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
			SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_LUJUNYI,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_LUJUNYI) + 1)
			--标记BOSS被击杀
			CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
				
			x402314_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
			if IsZhanDouFlag > 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,0)
			end
			if nKillNum + 1 < 6 then
				x402314_NotifyTip( sceneId, mems[i],
					format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
					,remainingMinutes
					,remainingSecondsInMinute
				));
			end
			--发个系统，只有队长可以操作。
			if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
				local strText = format("#{_INFOUSR%s}#{SXRW_090119_128}",GetName(sceneId,mems[i]))
				BroadMsgByChatPipe(sceneId,mems[i],strText,4)
			end
		end
	end
end

--**********************************
--BOSS使用技能....
--**********************************
function x402314_UseMySkill( sceneId, selfId, skill )
	if skill == "A" then
		x402314_UseSkill_A( sceneId, selfId)
	elseif skill == "B" then
		x402314_UseSkill_B( sceneId, selfId)
	elseif skill == "C" then
		x402314_UseSkill_C( sceneId, selfId)
	end
end

--**********************************
--重置AI....
--**********************************
function x402314_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402314_IDX_CombatTime,0)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402314_IDX_UseSkillIndex,1)
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402314_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402314_IDX_CombatFlag, 0 )
end

--**********************************
--BOSS使用A技能天罡皇气....
--**********************************
function x402314_UseSkill_A( sceneId, selfId)
    LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090119_166}")
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	LuaFnUnitUseSkill(sceneId,selfId,x402314_Skill_A,selfId,nPosX,nPosZ,0)
end

--**********************************
--BOSS使用B技能天人五衰....
--**********************************
function x402314_UseSkill_B( sceneId, selfId )
    LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090630_115}")
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	LuaFnUnitUseSkill(sceneId,selfId,x402314_Skill_B,selfId,nPosX,nPosZ,0)
end

--**********************************
--BOSS使用C技能天罡霸气....
--**********************************
function x402314_UseSkill_C( sceneId, selfId )
    LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090119_167}")
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	LuaFnUnitUseSkill(sceneId,selfId,x402314_Skill_C,selfId,nPosX,nPosZ,0)
end
--**********************************
--对话框提示
--**********************************
function x402314_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

