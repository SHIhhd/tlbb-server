--生死擂台·吴永
--脚本号
x402307_g_ScriptId	= 402307

--buff....
x402307_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402307_Buff_MianYi2	= 10471	--免疫普通隐身....
x402307_Buff_JuQi		= 10507 --聚气BUFF

--AI Index....
x402307_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402307_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x402307_IDX_SkillTime		= 3	--释放伏兵的缓存....

x402307_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402307_IDX_IsSkillFlag			= 2	--释放第几个妖星了....

x402307_DogName = {"紫色妖星","黄色妖星","红色妖星"}
x402307_BossTalk = {"#{SXRW_090630_111}","#{SXRW_090630_112}","#{SXRW_090630_113}"}
x402307_DogID = {13541,13542,13543,13544,13545,13546}
x402307_BossID = {13451,13452,13453,13454,13455,13456}

--**********************************
--入口函数
--**********************************
function x402307_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x402307_OnInit(sceneId, selfId)
	--重置AI....
	x402307_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402307_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402307_IDX_CombatFlag ) then
		return
	end
	--===================================================
	-- 吴用无需记录时间以自身血量判断技能释放，而且只释放三次技能
	--===================================================
	local szName = GetName(sceneId,selfId)
	if szName == "吴永" then
		local SkillIDX = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402307_IDX_IsSkillFlag)
		--三个都放完了，他得血量也没了。
		if SkillIDX >= 3 then
			return
		end
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		if CurPercent <= 0.9 then
			if SkillIDX == 0 then
				--释放第一次技能
				x402307_UseMyJuQi( sceneId, selfId ,nTick)
			end
		end
		if CurPercent <= 0.6 then
			if SkillIDX == 1 then
				--释放第二次技能
				x402307_UseMyJuQi( sceneId, selfId ,nTick)
			end
		end
		if CurPercent <= 0.3 then
			if SkillIDX == 2 then
				--释放第三次技能
				x402307_UseMyJuQi( sceneId, selfId ,nTick)
			end
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x402307_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402307_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402307_Buff_MianYi2, 0 )
	--重置AI....
	x402307_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402307_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x402307_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x402307_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x402307_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x402307_OnDie( sceneId, selfId, killerId )
	local szName = GetName(sceneId,selfId)
	if szName == "吴永" then
		--记录已经在生死擂台击杀多少只怪物了。
		local nKillNum = LuaFnGetCopySceneData_Param(sceneId,16)
		local IsZhanDouFlag = LuaFnGetCopySceneData_Param(sceneId,18)
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
				SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_WUYONG,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_WUYONG) + 1)
				--标记BOSS被击杀
				CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
				
				x402307_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
				if IsZhanDouFlag > 0 then
					LuaFnSetCopySceneData_Param(sceneId,18,0)
				end
				if nKillNum + 1 < 6 then
					x402307_NotifyTip( sceneId, mems[i],
						format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
						,remainingMinutes
						,remainingSecondsInMinute
					));
				end
				--发个系统，只有队长可以操作。
				if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
					local strText = format("#{_INFOUSR%s}#{SXRW_090119_129}",GetName(sceneId,mems[i]))
					BroadMsgByChatPipe(sceneId,mems[i],strText,4)
				end
			end
			--补充一段逻辑，防止出错，如果吴用死亡后，场上还有伏兵赶紧清除。
			local nMonsterNum = GetMonsterCount(sceneId)
			for i = 0, nMonsterNum-1 do
				local MonsterId = GetMonsterObjID(sceneId,i)
				local MosDataID = GetMonsterDataID(sceneId, MonsterId )
				for j = 1,getn(x402307_DogID) do
					if MosDataID == x402307_DogID[j] then
						LuaFnDeleteMonster(sceneId,MonsterId)
					end
				end
			end
		end
	elseif szName == "紫色妖星" then
		x402307_KillDog(sceneId,1)
	elseif szName == "黄色妖星" then
		x402307_KillDog(sceneId,2)
	elseif szName == "红色妖星" then
		x402307_KillDog(sceneId,3)
	end
end


--**********************************
--重置AI....
--**********************************
function x402307_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402307_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402307_IDX_UseSkillIndex, 0 )

	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402307_IDX_SkillTime, 5000 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402307_IDX_IsSkillFlag, 0 )

end

--**********************************
--BOSS聚气操作....
--**********************************
function x402307_UseMyJuQi(sceneId,selfId,nTick)
	local SkillTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402307_IDX_SkillTime)
	local SkillIDX = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402307_IDX_IsSkillFlag)
	if SkillTime > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x402307_IDX_SkillTime,SkillTime - nTick)
	else
		x402307_UseMySkill( sceneId, selfId)
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402307_IDX_IsSkillFlag, SkillIDX + 1 )
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x402307_IDX_SkillTime,5000)
		return
	end
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x402307_Buff_JuQi) ~= 1 then
		LuaFnNpcChat(sceneId,selfId,0,x402307_BossTalk[SkillIDX + 1])
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x402307_Buff_JuQi,0)
	end
end

--**********************************
--BOSS使用技能....
--**********************************
function x402307_UseMySkill( sceneId, selfId)
	--温馨提示
	local nLevel = GetLevel(sceneId,selfId)
	nLevel = floor(nLevel / 10) - 6
	local x,z = GetWorldPos( sceneId, selfId )
	for i = 1,3 do
		local a,b = random(3) - random(3),random(3)-random(3)
		local objId = LuaFnCreateMonster(sceneId, x402307_DogID[nLevel],x+a,z+b, 19, 0, x402307_g_ScriptId)
		SetUnitReputationID(sceneId,objId,objId,28)
		SetCharacterName(sceneId,objId,x402307_DogName[i] )
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,objId,10507+i,0)
	end
end

--**********************************
--小怪杀对了吗....
--**********************************
function x402307_KillDog(sceneId,Idx)
	--因为idx传得是绝对值，不需要单独判断他的数据是否会出错，直接判断和吴用释放得技能是否相匹配
	local nMonsterNum = GetMonsterCount(sceneId)
	local killOk = 0
	for i = 0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID(sceneId, MonsterId )
		--遍历吴用ID找他的OBJ
		for j = 1,getn(x402307_BossID) do
			if MosDataID == x402307_BossID[j] then
				--进行召唤小怪比对。
				if Idx == MonsterAI_GetIntParamByIndex(sceneId,MonsterId,x402307_IDX_IsSkillFlag) then
					--执行掉血操作，然后清除剩余的怪物，反之什么都不发生，也不掉血，怪物需要自行打完
					local Hp = GetHp(sceneId,MonsterId)
					local MaxHp = GetMaxHp(sceneId,MonsterId)
					if Hp - (MaxHp * 0.2) < Hp / MaxHp then
						SetHp(sceneId,MonsterId,MaxHp * 0.1)
					else
						SetHp(sceneId,MonsterId,Hp - (MaxHp * 0.2))
					end
					killOk = 1
					--给吴用发端Chat
					LuaFnNpcChat(sceneId,MonsterId,0,"#{SXRW_090630_120}")
				end
			end
		end
		if killOk == 1 then
			for k = 1,getn(x402307_DogID) do
				if MosDataID == x402307_DogID[k] then
					LuaFnDeleteMonster(sceneId,MonsterId)
				end
			end
		end
	end
end

--**********************************
--对话框提示
--**********************************
function x402307_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

