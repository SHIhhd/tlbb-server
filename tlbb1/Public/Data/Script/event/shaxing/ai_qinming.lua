--生死擂台·秦冥
--脚本号
x402317_g_ScriptId	= 402317

--副本逻辑脚本号....
x402317_g_FuBenScriptId = 402048

--buff....
x402317_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402317_Buff_MianYi2	= 10471	--免疫普通隐身....
x402317_Buff_MianDu		= 10497 --免疫毒攻击
x402317_Buff_XuRuoXuan	= 10501 --虚弱玄抗

x402317_Buff_PoDu		= 10503 --破毒抗
x402317_Skill_A 		= 1318 --腐骨穿心
x402317_Impact_TIME		= 25000 
x402317_YanShiSkill		= 5000 --5s延时

--AI Index....
x402317_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402317_IDX_UseImpactFlag	= 2	--破抗标记....
x402317_IDX_UseSkillTime	= 3	--延迟多少秒后释放技能....

x402317_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402317_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x402317_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x402317_OnInit(sceneId, selfId)
	--重置AI....
	x402317_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402317_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402317_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402317_IDX_IsKuangBaoMode ) then
		return
	end
	
	--释放技能破火抗
	local CombatTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402317_IDX_CombatTime)
	if CombatTime > nTick then --限制五分钟使用一次。
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402317_IDX_CombatTime,CombatTime - nTick)
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x402317_IDX_CombatTime,x402317_Impact_TIME) --重置CD
		--调用Impact
		x402317_TickPoBingImpact(sceneId,selfId)
	end
	--延迟释放技能
	local nImpactFlag = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402317_IDX_UseImpactFlag)
	local nSkillTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402317_IDX_UseSkillTime)
	if nImpactFlag == 1 then
		if nSkillTime > nTick then
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x402317_IDX_UseSkillTime,nSkillTime - nTick)
		else
			LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090119_148}")
			local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
			LuaFnUnitUseSkill(sceneId,selfId,x402317_Skill_A,selfId,nPosX,nPosZ,0) --使用技能
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x402317_IDX_UseImpactFlag,0) --破抗标记清空
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x402317_IDX_UseSkillTime,x402317_YanShiSkill) --重置
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x402317_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402317_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402317_Buff_MianYi2, 0 )

	--重置AI....
	x402317_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402317_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x402317_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x402317_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x402317_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x402317_OnDie( sceneId, selfId, killerId )
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
			SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_QINMING,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_QINMING) + 1)
			--标记BOSS被击杀
			CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
			
			x402317_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
			if IsZhanDouFlag > 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,0)
			end
			if nKillNum + 1 < 6 then
				x402317_NotifyTip( sceneId, mems[i],
					format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
					,remainingMinutes
					,remainingSecondsInMinute
				));
			end
			--发个系统，只有队长可以操作。
			if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
				local strText = format("#{_INFOUSR%s}#{SXRW_090119_134}",GetName(sceneId,mems[i]))
				BroadMsgByChatPipe(sceneId,mems[i],strText,4)
			end
		end
	end
end


--**********************************
--重置AI....
--**********************************
function x402317_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402317_IDX_CombatTime, x402317_Impact_TIME )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402317_IDX_UseImpactFlag, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402317_IDX_UseSkillTime, x402317_YanShiSkill )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402317_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402317_IDX_CombatFlag, 0 )
	
	--秦冥免疫毒攻击
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x402317_Buff_MianDu,0)
	--虚弱玄抗
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x402317_Buff_XuRuoXuan,0)

end

--**********************************
--BOSS使用技能....
--**********************************
function x402317_TickPoBingImpact(sceneId,selfId)
    LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090119_170}")
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount - 1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
			if nHumanId >= 15000 then --必须是玩家。
				LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,nHumanId,x402317_Buff_PoDu,0)
			end
		end
    end
	--破抗标记
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x402317_IDX_UseImpactFlag,1)
end

--**********************************
--对话框提示
--**********************************
function x402317_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

