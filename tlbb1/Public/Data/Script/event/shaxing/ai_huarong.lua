--生死擂台·花容
--A 【天罡阵】降低玩家移动速度
--B 【地煞阵】降低玩家命中
--C 【人亡阵】直接伤害10%
--D 【强化阵】强化玩家内外攻击
--E 【狂暴】给自己加一击致命buff....

--全程都带有免疫制定技能的buff....
--20秒后开始使用A技能....冷却20秒....
--25秒后开始循环释放BCD技能....冷却分别是20..20..30....
--5分钟后进入狂暴模式....停止使用ABCD....清除ABCD的buff....使用E技能....

--脚本号
x402310_g_ScriptId	= 402310

--副本逻辑脚本号....
x402310_g_FuBenScriptId = 402048

--buff....
x402310_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402310_Buff_MianYi2	= 10471	--免疫普通隐身....
x402310_Skill_A		= 1325
x402310_SkillA_SpecObj	= 116
x402310_Skill_B		= 1326
x402310_SkillB_SpecObj	= 129
x402310_Skill_C		= 1327
x402310_SkillC_SpecObj	= 130
x402310_Skill_D		= 1328
x402310_SkillD_SpecObj	= 131

--技能释放时间表....
x402310_UseSkillList =
{
	{ 50,  "A" },
	{ 80,  "B" },
	{ 110,  "A" },
	{ 140,  "C" },
	{ 155,  "A" },
	{ 170,  "D" },
	{ 185,  "A" },
	{ 200,  "B" },
	{ 215, "A" },
	{ 245, "C" },
	{ 275, "A" },
	{ 300, "D" },
}


--AI Index....
x402310_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402310_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x402310_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402310_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x402310_OnDefaultEvent( sceneId, selfId, targetId )

end

--**********************************
--初始化....
--**********************************
function x402310_OnInit(sceneId, selfId)
	--重置AI....
	x402310_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402310_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402310_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402310_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402310_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402310_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402310_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x402310_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x402310_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402310_IDX_UseSkillIndex, NextSkillIndex+1 )
		x402310_UseMySkill( sceneId, selfId, SkillData[2] )
	end

end

--**********************************
--进入战斗....
--**********************************
function x402310_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402310_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402310_Buff_MianYi2, 0 )

	--重置AI....
	x402310_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402310_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x402310_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x402310_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀掉对象
--**********************************
function x402310_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡事件
--**********************************
function x402310_OnDie( sceneId, selfId, killerId )
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
			SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_HUARONG,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_HUARONG) + 1)
			--标记BOSS被击杀
			CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
			
			x402310_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
			if IsZhanDouFlag > 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,0)
			end
			if nKillNum + 1 < 6 then
				x402310_NotifyTip( sceneId, mems[i],
					format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
					,remainingMinutes
					,remainingSecondsInMinute
				));
			end
			--发个系统，只有队长可以操作。
			if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
				local strText = format("#{_INFOUSR%s}#{SXRW_090119_135}",GetName(sceneId,mems[i]))
				BroadMsgByChatPipe(sceneId,mems[i],strText,4)
			end
		end
	end
end


--**********************************
--重置AI....
--**********************************
function x402310_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402310_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402310_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402310_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402310_IDX_CombatFlag, 0 )

end


--**********************************
--BOSS使用技能....
--**********************************
function x402310_UseMySkill( sceneId, selfId, skill )
	local nHumanList = {};
	local nPlayerID = -1
	local numPlayer = 0;
	if skill == "A" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_123}")
		local x,z = GetWorldPos( sceneId, selfId ) --释放空技能坐标
		LuaFnUnitUseSkill( sceneId, selfId, x402310_Skill_A, selfId, x, z, 0, 1 )	--使用空技能....
		local nLevel = GetLevel(sceneId,selfId)
		nLevel = floor(nLevel / 10)
		--必须遍历当前场景内玩家，随机选中一名玩家脚下放阵
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i = 0,membercount - 1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				nHumanList[numPlayer + 1] = mems[i]
				numPlayer = numPlayer + 1
			end
		end
		if numPlayer <= 0 then
			return 0
		end
		nPlayerID = nHumanList[random(numPlayer)]
		--获取选中玩家的坐标
		local nPlayerX,nPlayerZ = GetWorldPos(sceneId,nPlayerID)
		CreateSpecialObjAutoFadeByDataIndex(sceneId, selfId, x402310_SkillA_SpecObj + nLevel,nPlayerX,nPlayerZ,1000) --延时一秒释放
	elseif skill == "B" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_124}")
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x402310_Skill_B, selfId, x, z, 0, 1 )	--使用空技能....
		--必须遍历当前场景内玩家，随机选中一名玩家脚下放阵
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i = 0,membercount - 1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				nHumanList[numPlayer + 1] = mems[i]
				numPlayer = numPlayer + 1
			end
		end
		if numPlayer <= 0 then
			return 0
		end
		nPlayerID = nHumanList[random(numPlayer)]
		--获取选中玩家的坐标
		local nPlayerX,nPlayerZ = GetWorldPos(sceneId,nPlayerID)
		CreateSpecialObjAutoFadeByDataIndex(sceneId, selfId, x402310_SkillB_SpecObj,nPlayerX,nPlayerZ,1000) --延时一秒释放
	elseif skill == "C" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_125}")
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x402310_Skill_C, selfId, x, z, 0, 1 )	--使用空技能....
		--必须遍历当前场景内玩家，随机选中一名玩家脚下放阵
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i = 0,membercount - 1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				nHumanList[numPlayer + 1] = mems[i]
				numPlayer = numPlayer + 1
			end
		end
		if numPlayer <= 0 then
			return 0
		end
		nPlayerID = nHumanList[random(numPlayer)]
		--获取选中玩家的坐标
		local nPlayerX,nPlayerZ = GetWorldPos(sceneId,nPlayerID)
		CreateSpecialObjAutoFadeByDataIndex(sceneId, selfId, x402310_SkillC_SpecObj,nPlayerX,nPlayerZ,1000) --延时一秒释放
	elseif skill == "D" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_126}")
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x402310_Skill_D, selfId, x, z, 0, 1 )	--使用空技能....
		--必须遍历当前场景内玩家，随机选中一名玩家脚下放阵
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i = 0,membercount - 1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				nHumanList[numPlayer + 1] = mems[i]
				numPlayer = numPlayer + 1
			end
		end
		if numPlayer <= 0 then
			return 0
		end
		nPlayerID = nHumanList[random(numPlayer)]
		--获取选中玩家的坐标
		local nPlayerX,nPlayerZ = GetWorldPos(sceneId,nPlayerID)
		CreateSpecialObjAutoFadeByDataIndex(sceneId, selfId, x402310_SkillD_SpecObj,nPlayerX,nPlayerZ,1000) --延时一秒释放
	end
end
--**********************************
--对话框提示
--**********************************
function x402310_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

