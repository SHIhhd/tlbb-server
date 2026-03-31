--生死擂台·鲁智深
--脚本号
x402313_g_ScriptId	= 402313

--副本逻辑脚本号....
x402313_g_FuBenScriptId = 892009

--buff....
x402313_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402313_Buff_MianYi2	= 10471	--免疫普通隐身....

x402313_Skill_tsgx		= 1312 --天煞孤星
x402313_Skill_kfc		= 1313 --狂风铲
x402313_IDX_SkillKFC_CD	= 20000 --20s一次吧


x402313_Impact_gfzs		= 22012 --孤芳自赏状态

--技能释放时间表....
x402313_UseSkillList =
{
	{ 60,  "A" },
	{ 75,  "B" },
	{ 135,  "A" },
	{ 150,  "B" },
	{ 210,  "A" },
	{ 225,  "B" },
	{ 285,  "A" },
	{ 300,  "B" },
}


--AI Index....
x402313_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402313_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....
x402313_IDX_SkillKFC		= 3 --狂风铲技能CD记录....


x402313_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402313_IDX_SkillTianSha		= 2	--天煞孤星使用标记，进入战斗就使用....

--**********************************
--入口函数
--**********************************
function x402313_OnDefaultEvent( sceneId, selfId, targetId )
end

--**********************************
--初始化....
--**********************************
function x402313_OnInit(sceneId, selfId)
	--重置AI....
	x402313_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402313_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402313_IDX_CombatFlag ) then
		return
	end
	
	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402313_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402313_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x402313_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x402313_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_UseSkillIndex, NextSkillIndex+1 )
		x402313_UseMySkill( sceneId, selfId, SkillData[2] )
	end
	--无任何限制
	x402313_TickSkillA( sceneId, selfId, nTick )

end

--**********************************
--进入战斗....
--**********************************
function x402313_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402313_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402313_Buff_MianYi2, 0 )
	--初始化孤芳自赏状态....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402313_Impact_gfzs, 0 )
	--重置AI....
	x402313_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402313_IDX_CombatFlag, 1 )
	--天煞孤星检测....
	if MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402313_IDX_SkillTianSha ) ~= 1 then
		--释放天煞孤星
		local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
		LuaFnUnitUseSkill(sceneId,selfId,x402313_Skill_tsgx,selfId,nPosX,nPosZ,0,1)
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402313_IDX_SkillTianSha,1) 
	end
end


--**********************************
--离开战斗....
--**********************************
function x402313_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x402313_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x402313_OnKillCharacter(sceneId, selfId, targetId)
    local objType = GetCharacterType( sceneId, targetId )
	if objType == 3 then
		local Hp,MaxHp = GetHp( sceneId, selfId ),GetMaxHp( sceneId, selfId )
		if Hp <= MaxHp * 0.9 then
			SetHp( sceneId, selfId,Hp + MaxHp * 0.1)
		end
	end
end


--**********************************
--死亡....
--**********************************
function x402313_OnDie( sceneId, selfId, killerId )
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
			SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_LUZHISHENG,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_LUZHISHENG) + 1)
			--标记BOSS被击杀
			CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
			
			x402313_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
			if IsZhanDouFlag > 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,0)
			end
			if nKillNum + 1 < 6 then
				x402313_NotifyTip( sceneId, mems[i],
					format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
					,remainingMinutes
					,remainingSecondsInMinute
				));
			end
			--发个系统，只有队长可以操作。
			if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
				local strText = format("#{_INFOUSR%s}#{SXRW_090119_137}",GetName(sceneId,mems[i]))
				BroadMsgByChatPipe(sceneId,mems[i],strText,4)
			end
		end
	end
end


--**********************************
--重置AI....
--**********************************
function x402313_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_UseSkillIndex, 1 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_SkillKFC, 3000 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402313_IDX_SkillTianSha, 0)
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402313_IDX_CombatFlag, 0 )

end

--**********************************
--BOSS使用技能....
--**********************************
function x402313_UseMySkill( sceneId, selfId,skill )
	if skill == "A" then  ----提示玩家找生门
	    LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090630_118}")
        LuaFnCancelSpecificImpact(sceneId,selfId,x402313_Impact_gfzs)
	elseif skill == "B" then
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x402313_Impact_gfzs,0)
    end
end

--**********************************
--狂风铲技能心跳独立处理....
--**********************************
function x402313_TickSkillA( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402313_IDX_SkillKFC )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_SkillKFC, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402313_IDX_SkillKFC, x402313_IDX_SkillKFC_CD-(nTick-cd) )
		return x402313_UseSkillA( sceneId, selfId )
	end

end

function x402313_UseSkillA(sceneId,selfId)
	LuaFnUnitUseSkill( sceneId,selfId,x402313_Skill_kfc,selfId,-1,-1,0,1)
	return 1
end
--**********************************
--对话框提示
--**********************************
function x402313_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

