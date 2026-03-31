--水月山庄 契丹武士耶律
--脚本号
x891066_g_ScriptId	= 891066
x891066_g_FuBenControlScript = 891070
--buff....
x891066_Buff_MianYi1	= 10472	--免疫一些负面效果....
x891066_Buff_MianYi2	= 10471	--免疫普通隐身....

--AI Index....
x891066_IDX_UseSkillCooldown 	= 1	--每次释放特殊AI技能的间隔时间
x891066_IDX_UseSkillIndex		= 2 --释放第几个技能了....
x891066_SkillB_Step				= 3 --千刃化阵释放第几个单位了....
x891066_SkillB_PosX				= 4 --千刃化阵释放坐标数据....
x891066_SkillB_PosZ				= 5 --千刃化阵释放坐标数据....
x891066_SkillB_SpecialTime		= 6 --延时释放special

x891066_SkillA_Data				= 3240 --以气化刃
x891066_SkillB_Data				= 3241 --千刃刀阵
x891066_SkillC_Data				= 3242 --万刃纵横
--用于释放的技能
--rate 继续下一个技能的概率
x891066_SkillTable = {
	[0] = {skill = x891066_SkillA_Data,rate = 60},
	[1] = {skill = x891066_SkillB_Data,rate = 80},
	[2] = {skill = x891066_SkillC_Data,rate = 100},
}

x891066_SkillA_Time				= 14000 --冷却时间15s
x891066_SkillB_Time				= 59000 --冷却时间60s
x891066_SkillC_Time				= 44000 --冷却时间45s


x891066_SkillB_SpecialObj		= {1101,1102,1103,1104,1105}



x891066_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....

--**********************************
--入口函数
--**********************************
function x891066_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891066_OnInit(sceneId, selfId)
	--发送泡泡
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_84}")
	--重置AI....
	x891066_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x891066_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891066_IDX_CombatFlag ) then
		return
	end
	local CurPerHp = GetHp(sceneId,selfId) / GetMaxHp(sceneId,selfId)
	--千刃刀阵特殊技能
	local Step = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891066_SkillB_Step)
	local skillb_specialtime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891066_SkillB_SpecialTime)
	if Step > 0 then
		if skillb_specialtime > 0 then
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_SkillB_SpecialTime,skillb_specialtime - nTick)
		else
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_Step,Step - 1)
			x891066_UseSkillB_SpecialObj(sceneId,selfId)
			return
		end
	end
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891066_IDX_UseSkillIndex )
	--当前无法执行技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x891066_SkillTable[NextSkillIndex].skill) ~= 1 then
		return
	end
	--每次释放特殊AI技能的间隔时间
	local nSpecialSkillTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891066_IDX_UseSkillCooldown)
	nSpecialSkillTime = nSpecialSkillTime - nTick
	if nSpecialSkillTime <= 0 then
		if NextSkillIndex == 0 then
			x891066_UseSkillA(sceneId,selfId)
		elseif NextSkillIndex == 1 then
			x891066_UseSkillB(sceneId,selfId)	
		elseif NextSkillIndex == 2 then
			x891066_UseSkillC(sceneId,selfId)	
		end
		
		if random(0,100) <= x891066_SkillTable[NextSkillIndex].rate then
			NextSkillIndex = mod(NextSkillIndex + 1,3);
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_IDX_UseSkillIndex,NextSkillIndex )
		end
		--间隔10s释放
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_IDX_UseSkillCooldown, 10000 )
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_IDX_UseSkillCooldown,nSpecialSkillTime)
	end
	
end
--**********************************
--释放以气化刃
--**********************************
function x891066_UseSkillA(sceneId,selfId)
	--发送泡泡 以气化刃，斩！
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_64}")
	--全屏提示 耶律泓佑正在凝聚刀锋，请速速躲避！	
	CallScriptFunction(x891066_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_65}")
	--释放以气化刃
	LuaFnUnitUseSkill(sceneId,selfId,x891066_SkillA_Data,selfId,-1,-1,0,1)
end
--**********************************
--释放千刃刀阵....
--**********************************
function x891066_UseSkillB(sceneId,selfId)
	--发送泡泡
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_66}")
	--全屏提示
	CallScriptFunction(x891066_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_67}")
	--释放千刃刀阵
	LuaFnUnitUseSkill(sceneId,selfId,x891066_SkillB_Data,selfId,-1,-1,0,1)
	--释放陷阱
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_SkillB_Step,5)
	x891066_UseSkillB_SpecialObj(sceneId,selfId)
end
--**********************************
--释放万刃纵横
--**********************************
function x891066_UseSkillC(sceneId,selfId)
	--发送泡泡 万刃纵横，扭转！	
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_68}")
	--全屏提示 耶律泓佑在场地中央开始释放万刃纵横，请注意躲避！	
	CallScriptFunction(x891066_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_69}")
	--NPC TALK
	--中原武学确实精深，值得在下全力迎战——乾坤扭转，万刃纵横！
	LuaFnNpcTalk(sceneId,104)
	--自身回到中心点
	local nDefPosX,nDefPosZ = CallScriptFunction(x891066_g_FuBenControlScript,"GetFubenMonsterPos",sceneId,4)
	SetPos(sceneId,selfId,nDefPosX,nDefPosZ)
	--释放万刃纵横 这个技能方向锁正南
	LuaFnUnitUseSkill(sceneId,selfId,x891066_SkillC_Data,-1,nDefPosX,nDefPosZ,-1.57,1)
	--创建周围的空NPC
	local nEnvNpcObjId = LuaFnCreateMonster(sceneId,48536,nDefPosX,nDefPosZ,3,-1,-1)
	if nEnvNpcObjId > -1 then
		SetCharacterDieTime(sceneId,nEnvNpcObjId,15000)
	end
	return 1
end
--**********************************
--千刃刀阵陷阱释放接口
--**********************************
function x891066_UseSkillB_SpecialObj(sceneId,selfId)
	--随机选中两名玩家释放刀阵
	local Step = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891066_SkillB_Step)
	if Step >= 1 and Step <= 5 then
		local specialX = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosX)
		local specialZ = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosZ)
		local specialobjid = x891066_SkillB_SpecialObj[6 - Step]
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		local PlayerList = {}
		local numPlayer = 0
		local PlayerId
		local nHumanId
		local nPosX,nPosZ = 0,0
		for i = 0,nHumanCount - 1 do
			nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
				PlayerList[numPlayer+1] = nHumanId
				numPlayer = numPlayer + 1
			end
		end
		if numPlayer <= 0 then
			return
		end
		if numPlayer > 2 then
			for i = 1,2 do
				PlayerId = PlayerList[random(numPlayer)]
				nPosX,nPosZ = GetWorldPos(sceneId,PlayerId)
				--第一个阵法就正常释放了
				if specialX == 0 and specialZ == 0 then
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,specialobjid,nPosX,nPosZ,0)
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosX,nPosX)
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosZ,nPosZ)
					MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_SkillB_SpecialTime,1000)
				else
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,specialobjid,specialX,specialZ,0)
					MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_SkillB_SpecialTime,1000)
				end
			end
		else
			for i = 1,numPlayer do
				PlayerId = PlayerList[random(numPlayer)]
				nPosX,nPosZ = GetWorldPos(sceneId,PlayerId)
				--第一个阵法就正常释放了
				if specialX == 0 and specialZ == 0 then
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,specialobjid,nPosX,nPosZ,0)
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosX,nPosX)
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosZ,nPosZ)
					MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_SkillB_SpecialTime,1000)
				else
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,specialobjid,specialX,specialZ,0)
					MonsterAI_SetIntParamByIndex(sceneId,selfId,x891066_SkillB_SpecialTime,1000)
				end
			end
		end
		if Step == 1 then
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosX,0)
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosZ,0)
		end
	end
end

--**********************************
--技能释放成功
--**********************************
function x891066_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--万刃纵横
	if nSkillId == x891066_SkillC_Data then
		
	end
end

--**********************************
--进入战斗....
--**********************************
function x891066_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891066_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891066_Buff_MianYi2, 0 )
	--重置AI....
	x891066_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891066_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x891066_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x891066_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x891066_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891066_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x891066_g_FuBenControlScript, "OnDie",sceneId,selfId)
end


--**********************************
--重置AI....
--**********************************
function x891066_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_IDX_UseSkillCooldown, 8000 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_IDX_UseSkillIndex, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_Step,0)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosX,0)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_PosZ,0)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891066_SkillB_SpecialTime,0)

end

--**********************************
--对话框提示
--**********************************
function x891066_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

