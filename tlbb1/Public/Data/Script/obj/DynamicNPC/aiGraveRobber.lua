--搬山道人ai
--燃烧弹冷却20s到时间就放....
--高爆弹冷却60s到时间就放....
--全屏炸弹的条件是受到怒气技能和暗器技能就会放，其余情况下不会释放....无冷却要求
x050065_g_FubenScriptId		= 50063
x050065_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....
x050065_IDX_SKILLA 			= 2	--A技能冷却
x050065_IDX_SKILLB 			= 3	--B技能冷却
x050065_IDX_CHOUDANTIME		= 4 --臭蛋提示用
x050065_IDX_SKILLC_OUTTICKA	= 5 --满屏高爆弹延时用
x050065_IDX_SKILLC_OUTTICKB	= 6 --满屏高爆弹延时用


x050065_SKILLATIME			= 59000 --高爆弹冷却数据
x050065_SKILLBTIME			= 19000 --燃烧弹冷却数据


x050065_GaoBaoDanSpecialOBJ = 135 --高爆弹爆炸
x050065_RanShaoDanSpecialOBJ = 134 --燃烧弹爆炸
x050065_ChouDanSpecialOBJ = 136 --臭弹爆炸

x050065_TransferImpactID = 10540 --大招用的buff


x050065_g_SceneData_SKILLTIME_1 = 13 --全屏提示数据
x050065_g_SceneData_SKILLTIME_2 = 14 --全屏提示数据
x050065_g_SceneData_SKILLTIME_3 = 15 --全屏提示数据

x050065_GaoBaoDanID = {13768,13769,13770,13771,13772,13773,13774,13775,13776}
x050065_RanShaoDanID = {13777,13778,13779,13780,13781,13782,13783,13784,13785}


--**********************************
--初始化....
--**********************************
function x050065_OnInit(sceneId, selfId)
	--泡泡
	MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090706_26}")
	--重置AI....
	x050065_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x050065_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x050065_IDX_CombatFlag ) then
		return
	end
	--臭弹泡泡
	local ChouDanTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x050065_IDX_CHOUDANTIME)
	if ChouDanTime > 0 then
		ChouDanTime = ChouDanTime - nTick
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_CHOUDANTIME,ChouDanTime)
		if ChouDanTime == 0 then
			MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090727_40}")
		end
	end
	--全屏高爆弹逻辑点
	-- local SkillCOuttiCk_1 = MonsterAI_GetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKA)
	-- if SkillCOuttiCk_1 > 0 then
		-- SkillCOuttiCk_1 = SkillCOuttiCk_1 - nTick
		-- if SkillCOuttiCk_1 <= 0 then
			-- --调用B逻辑
			-- x050065_UseSkillC_B(sceneId,selfId)
		-- end
		-- MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKA,SkillCOuttiCk_1)
		-- return
	-- end
	
	-- local SkillCOuttiCk_2 = MonsterAI_GetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKB)
	-- if SkillCOuttiCk_2 > 0 then
		-- SkillCOuttiCk_2 = SkillCOuttiCk_2 - nTick
		-- if SkillCOuttiCk_2 <= 0 then
			-- --调用B逻辑
			-- LuaFnSetCopySceneData_Param(sceneId,x050065_g_SceneData_SKILLTIME_3,5)
		-- end
		-- MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKB,SkillCOuttiCk_2)
		-- return
	-- end
	-- if x050065_TickSkillC( sceneId, selfId, nTick ) == 1 then
		-- return
	-- end
	--上面注释的是满屏高爆弹的技能逻辑。
	if 1 == x050065_TickSkillA( sceneId, selfId, nTick ) then
		return
	end
	if 1 == x050065_TickSkillB( sceneId, selfId, nTick ) then
		return
	end
	--全屏炸弹的条件是受到怒气技能和暗器技能就会放，其余情况下不会释放
	
end
--**********************************
--高爆弹技能
--**********************************
function x050065_TickSkillA( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x050065_IDX_SKILLA )
	if cd >= nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x050065_IDX_SKILLA, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x050065_IDX_SKILLA, x050065_SKILLATIME - (nTick-cd))
		return x050065_UseSkillA( sceneId, selfId )
	end

end
--**********************************
--燃烧弹技能
--**********************************
function x050065_TickSkillB( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x050065_IDX_SKILLB )
	if cd >= nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x050065_IDX_SKILLB, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x050065_IDX_SKILLB, x050065_SKILLBTIME - (nTick-cd))
		return x050065_UseSkillB( sceneId, selfId )
	end

end
--**********************************
--全屏高爆弹
--**********************************
function x050065_TickSkillC( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, 7 )
	if cd >= nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, 7, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, 7, 20000 - (nTick-cd))
		return x050065_UseSkillC_A( sceneId, selfId )
	end

end

--**********************************
--高爆弹
--**********************************
function x050065_UseSkillA(sceneId,selfId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mensi = {}
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			tinsert(mensi,nHumanId)
		end
	end
	local BaoZhaSpecialOBJ = x050065_GaoBaoDanSpecialOBJ
	local nMonsterLevel = floor(GetLevel(sceneId,selfId) / 10) - 3
	local randomID = mensi[random(1,getn(mensi))]
	local x,z = GetWorldPos( sceneId, randomID )
	MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090706_28}")
	local nMonsterId = LuaFnCreateMonster(sceneId,x050065_GaoBaoDanID[nMonsterLevel],x,z,3,-1,-1)
	if nMonsterId > - 1 then
		SetCharacterDieTime(sceneId,nMonsterId,7000) --5秒引爆
	end
	--有几率放出臭弹
	if random(1,100) < 10 then
		BaoZhaSpecialOBJ = x050065_ChouDanSpecialOBJ
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_CHOUDANTIME,7000)
	end
	CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,BaoZhaSpecialOBJ,x,z,7000)
	LuaFnSetCopySceneData_Param(sceneId,x050065_g_SceneData_SKILLTIME_1,5)
	return 1
end
--**********************************
--燃烧弹
--**********************************
function x050065_UseSkillB(sceneId,selfId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mensi = {}
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			tinsert(mensi,nHumanId)
		end
	end
	local BaoZhaSpecialOBJ = x050065_RanShaoDanSpecialOBJ
	local nMonsterLevel = floor(GetLevel(sceneId,selfId) / 10) - 3
	local randomID = mensi[random(1,getn(mensi))]
	local x,z = GetWorldPos( sceneId, randomID )
	MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090706_27}")--给个NPC对话。
	local nMonsterId = LuaFnCreateMonster(sceneId,x050065_RanShaoDanID[nMonsterLevel],x,z,3,-1,-1)
	if nMonsterId > -1 then
		SetCharacterDieTime(sceneId,nMonsterId,12000) --10秒引爆
	end
	--有几率放出臭弹
	if random(1,100) < 10 then
		BaoZhaSpecialOBJ = x050065_ChouDanSpecialOBJ
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_CHOUDANTIME,12000)
	end
	CreateSpecialObjByDataIndex(sceneId,selfId,BaoZhaSpecialOBJ,x,z,12000)
	LuaFnSetCopySceneData_Param( sceneId,x050065_g_SceneData_SKILLTIME_2,10)
	return 1
end
--**********************************
--满屏高爆弹A逻辑
--**********************************
function x050065_UseSkillC_A(sceneId,selfId)
	--发送提示
	MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090706_38}")
	--延时2s继续释放调用下一层逻辑
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKA,2000)
end
--**********************************
--满屏高爆弹B逻辑
--**********************************
function x050065_UseSkillC_B(sceneId,selfId)
	--发送新提示
	MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090706_29}")
	--给自己一个
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x050065_TransferImpactID,0)
	--BOSS回到复活点
	SetPos(sceneId,selfId,67,73)
	--遍历全体玩家
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mensi = {}
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
			tinsert(mensi,nHumanId)
		end
	end
	local nMonsterX,nMonsterZ = GetWorldPos(sceneId,selfId)
	--周围浮点数据
	local positions = 
	{
		{1.9, -0.6},
		{0, -2},
		{-1.2, 1.6},
		{-1.9, -0.6},
		{1.2, 1.5}
	}
	for i = 1,getn(mensi) do
		--给个BUFF先
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,mensi[i],x050065_TransferImpactID,0)
		--转移到boss周围
		local offsetX = positions[i][1]
		local offsetZ = positions[i][2]
		SetPos(sceneId,mensi[i],nMonsterX + offsetX,nMonsterZ + offsetZ)
	end
	--炸弹防止完毕，进入C逻辑全屏提示逻辑 5s延时
	local nMonsterX,nMonsterZ = GetWorldPos(sceneId, selfId)
	for i = 1,40 do
		local NewPosX = random(nMonsterX-25,nMonsterX+25)
		local NewPosZ = random(nMonsterZ-25,nMonsterZ+25)
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,138,NewPosX,NewPosZ,0)
		local nMonsterId = LuaFnCreateMonster(sceneId,13768,NewPosX,NewPosZ,3,-1,-1)
		if nMonsterId > - 1 then
			SetCharacterDieTime(sceneId,nMonsterId,12000) --5秒引爆
		end
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,135,NewPosX,NewPosZ,12000)
	end
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKB,5000)
end
--**********************************
--进入战斗....
--**********************************
function x050065_OnEnterCombat(sceneId, selfId, enmeyId)
	--重置AI....
	x050065_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x050065_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x050065_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x050065_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x050065_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x050065_OnDie( sceneId, selfId, killerId )
	MonsterTalk(sceneId,selfId,"凤凰陵墓","#{FHGC_090706_31}")
	CallScriptFunction(x050065_g_FubenScriptId,"OnDie",sceneId,selfId,killerId)
end


--**********************************
--重置AI....
--**********************************
function x050065_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLA,x050065_SKILLATIME)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLB,x050065_SKILLBTIME)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_CHOUDANTIME,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKA,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x050065_IDX_SKILLC_OUTTICKB,0)
	
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x050065_IDX_CombatFlag,0)
end

