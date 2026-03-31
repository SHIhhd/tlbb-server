--生死擂台·宋江
--脚本号
--根据视频展示，这个技能前面连着放，也不知道具体数据，设定为放满6次就不放了，这个技能伤害高。
x402309_g_ScriptId	= 402309

--副本逻辑脚本号....
x402309_g_FuBenScriptId = 892009

--buff....
x402309_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402309_Buff_MianYi2	= 10471	--免疫普通隐身....
x402309_Buff_JuQi		= 10507 --聚气BUFF
x402309_Skill_A1		= 1305 --妖星聚义
x402309_Skill_B			= 1306 --神行逆转


--AI Index....
x402309_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402309_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x402309_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x402309_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....
--技能释放时间表....
x402309_UseSkillList =
{
	{ 15,  "A" }, --聚气 
	{ 20,  "A1" },--释放
	{ 33,  "B" }, --神行
	{ 35,  "A" }, --聚气
	{ 40,  "A1" }, --释放
	{ 53,  "B" }, --神行
	{ 55,  "A" }, --聚气
	{ 60,  "A1" }, --释放
	{ 73,  "B" }, --神行
	{ 75,  "A" }, --聚气
	{ 80,  "A1" }, --释放
	{ 93,  "B" }, --神行
	{ 95,  "A" }, --聚气
	{ 100,  "A1" }, --释放
	{ 113,  "B" }, --神行
	{ 115,  "A" }, --聚气
	{ 120,  "A1" }, --释放
	{ 123,  "B" }, --神行
}
--**********************************
--入口函数
--**********************************
function x402309_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x402309_OnInit(sceneId, selfId)
	--重置AI....
	x402309_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402309_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402309_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402309_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402309_IDX_CombatTime )
    local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x402309_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402309_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x402309_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x402309_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x402309_IDX_UseSkillIndex, NextSkillIndex+1 )
		x402309_UseMySkill(sceneId,selfId,SkillData[2])
	end
end

--**********************************
--进入战斗....
--**********************************
function x402309_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402309_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402309_Buff_MianYi2, 0 )

	--重置AI....
	x402309_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402309_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x402309_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x402309_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x402309_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x402309_OnDie( sceneId, selfId, killerId )
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
			SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_SONGJIANG,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_SONGJIANG) + 1)
			--标记BOSS被击杀
			CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
				
			x402309_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
			if IsZhanDouFlag > 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,0)
			end
			if nKillNum + 1 < 6 then
				x402309_NotifyTip( sceneId, mems[i],
					format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
					,remainingMinutes
					,remainingSecondsInMinute
				));
			end
			--发个系统，只取队长得信息
			if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
				local strText = format("#{_INFOUSR%s}#{SXRW_090119_039}",GetName(sceneId,mems[i]))
				BroadMsgByChatPipe(sceneId,mems[i],strText,4)
			end
		end
	end
end


--**********************************
--重置AI....
--**********************************
function x402309_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402309_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x402309_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402309_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402309_IDX_CombatFlag, 0 )
end

--**********************************
--BOSS使用技能....
--**********************************
function x402309_UseMySkill(sceneId,selfId,skill)
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	if skill == "A" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_114}")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x402309_Buff_JuQi,0)
	elseif skill == "A1" then
		LuaFnUnitUseSkill( sceneId, selfId, x402309_Skill_A1, selfId, nPosX, nPosZ, 0, 1 )
	elseif skill == "B" then
		LuaFnUnitUseSkill( sceneId, selfId, x402309_Skill_B, selfId, nPosX, nPosZ, 0, 1 )
	end
end

--**********************************
--对话框提示
--**********************************
function x402309_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

