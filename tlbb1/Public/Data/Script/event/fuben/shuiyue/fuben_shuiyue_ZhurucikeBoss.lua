--水月山庄 侏儒刺客 梵无救
--梵无救技能，鬼影冷却1分钟，毒煞阵技能在血量小于等于10%的时候释放一次....
--分身技能15s冷却时间，场中存在分身就掠过不释放继续走下面逻辑....
--毒煞阵技能冷却时间40s....
--时间到了就放，除了毒煞阵需要特别操作其他的没什么操作空间....
x891077_g_ScriptId	= 891077
x891077_g_FuBenControlScript = 891070
--buff....
x891077_Buff_MianYi1	= 10472	--免疫一些负面效果....
x891077_Buff_MianYi2	= 10471	--免疫普通隐身....

x891077_SkillA_Time		= 14900 --分身技能冷却时间数据....
x891077_SkillB_Time		= 59000 --鬼影技能冷却时间数据....
x891077_SkillC_Time		= 39000 --毒煞阵技能冷却时间数据....

x891077_SkillA_ID		= 3230 --分身
x891077_SkillB_ID		= 3231 --鬼影
x891077_SkillC_ID		= 3232 --毒煞阵

x891077_SkillAMonsterTable = {48511,48512} --梵修、梵体
x891077_SkillBMonsterTable = 48513 --鬼影
x891077_SkillCMonsterTable = {48514,48515} --红黑区域

x891077_SkillA_Impact = {10517,10516} --梵修、梵体状态
x891077_SkillA_Title = {"唯恐外功","唯恐内功"}

x891077_SkillB_Impact_1 = 10518 --鬼影定身
x891077_SkillB_Impact_2 = 10519 --鬼影掉血

x891077_SkillC_Impactinfo = {10521,10522,10523} --区域检测状态、炸血状态
x891077_SkillC_HumanTipsinfo = {"#{SYSZ_20210203_52}","#{SYSZ_20210203_53}"} --区域提示

--AI Index....
x891077_SkillA_CombatTime		= 1	--A技能冷却时间....
x891077_SkillB_CombatTime		= 2	--B技能冷却时间....
x891077_SkillC_CombatTime		= 3	--C技能冷却时间....
x891077_IDX_SKILLC_Step			= 4 --C技能是否正在使用中....


x891077_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x891077_IDX_SKILLC_KillFlag		= 2 --濒临死亡标记....

--**********************************
--入口函数
--**********************************
function x891077_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891077_OnInit(sceneId, selfId)
	--发送泡泡
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_77}")
	--重置AI....
	x891077_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x891077_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891077_IDX_CombatFlag ) then
		return
	end
	local skillstep = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_Step)
	if skillstep > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_Step,skillstep - nTick)
	end
	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	--分身技能....
	local SkillA_CD = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891077_SkillA_CombatTime)
	if SkillA_CD > nTick then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillA_CombatTime,SkillA_CD - nTick )
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillA_CombatTime,x891077_SkillA_Time - (nTick - SkillA_CD))
		x891077_UseSkillA(sceneId,selfId)
	end
	--鬼影技能....
	local SkillB_CD = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891077_SkillB_CombatTime)
	if SkillB_CD > nTick then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillB_CombatTime,SkillB_CD - nTick )
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillB_CombatTime,x891077_SkillB_Time - (nTick - SkillB_CD))
		x891077_UseSkillB(sceneId,selfId)
	end
	--毒煞阵技能....
	local SkillC_CD = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891077_SkillC_CombatTime)
	if SkillC_CD > nTick then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillC_CombatTime,SkillC_CD - nTick )
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillC_CombatTime,x891077_SkillC_Time - (nTick - SkillC_CD))
		x891077_UseSkillC(sceneId,selfId)
	end
	if CurPercent <= 0.111 then
		--冷却清除，然后做下标记，因为马上要死了
		if MonsterAI_GetBoolParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_KillFlag) == 1 then
			return
		end
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillC_CombatTime,0)
		MonsterAI_SetBoolParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_KillFlag,1)
	end
end
--**********************************
--释放分身技能....
--**********************************
function x891077_UseSkillA(sceneId,selfId)
	--如果正在释放毒煞阵，略过此技能
	if MonsterAI_GetIntParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_Step) > 0 then
		return
	end
	--如果梵体梵修有一个在场，跳过此技能
	local nMonsterNum = GetMonsterCount(sceneId)
	for i = 0, nMonsterNum - 1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x891077_SkillAMonsterTable[1] or MosDataID == x891077_SkillAMonsterTable[2] then
			return
		end
	end	
	local x,z = GetWorldPos(sceneId,selfId)
	--先发送对话
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_43}")
	--发送全屏提示
	CallScriptFunction(x891076_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_44}")
	--发送全屏提示
	CallScriptFunction(x891076_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_45}")
	--释放空技能，召唤分身
	LuaFnUnitUseSkill(sceneId,selfId,x891077_SkillA_ID,selfId,x,z,0,1)
	--召唤分身，在梵无救左右两侧，然后给添加buff
	local DogID = LuaFnCreateMonster(sceneId,x891077_SkillAMonsterTable[1],x+3,z,21,-1,-1)
	local DogID_2 = LuaFnCreateMonster(sceneId,x891077_SkillAMonsterTable[2],x-3,z,21,-1,-1)
	if DogID > -1 then
		--修改称号，上状态
		SetCharacterTitle(sceneId, DogID,x891077_SkillA_Title[1])
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,DogID,x891077_SkillA_Impact[1],0)
	end
	if DogID_2 > -1 then
		--修改称号，上状态
		SetCharacterTitle(sceneId,DogID_2,x891077_SkillA_Title[2])
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,DogID_2,x891077_SkillA_Impact[2],0)
	end
end
--**********************************
--释放鬼影技能....
--**********************************
function x891077_UseSkillB(sceneId,selfId)
	--如果正在释放毒煞阵，略过此技能
	if MonsterAI_GetIntParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_Step) > 0 then
		return
	end
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local x,z = GetWorldPos(sceneId,selfId)
	--先发送对话
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_48}")
	--发送全屏提示
	CallScriptFunction(x891076_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_49}")
	--释放空技能
	LuaFnUnitUseSkill(sceneId,selfId,x891077_SkillB_ID,selfId,x,z,0,1)
	--随机选中两名玩家
	local PlayerList = {}
	local numPlayer = 0
	local PlayerId;
	for i = 0,nHumanCount - 1 do
		nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
			PlayerList[numPlayer+1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end
	--点名
	if numPlayer <= 0 then
		return
	end
	--如果是超过2个人以上再刷副本的情况。
	if numPlayer > 2 then
		for i = 1,2 do
			PlayerId = PlayerList[random(numPlayer)]
			--给选中的两名玩家上定身、掉血状态
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerId,x891077_SkillB_Impact_1,0)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerId,x891077_SkillB_Impact_2,0)
			x891077_NotifyTip(sceneId,PlayerId,"#{SYSZ_20210203_50}")
			--在他们身边创建两个鬼影
			local x,z = GetWorldPos(sceneId,PlayerId)
			local GuiHunID = LuaFnCreateMonster(sceneId,x891077_SkillBMonsterTable,x,z,26,-1,x891077_g_ScriptId)
			if GuiHunID > -1 then
				LuaFnSetNpcIntParameter(sceneId,GuiHunID,0,PlayerId)
			end
		end
	else
		PlayerId = PlayerList[random(numPlayer)]
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerId,x891077_SkillB_Impact_1,0)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerId,x891077_SkillB_Impact_2,0)
		x891077_NotifyTip(sceneId,PlayerId,"#{SYSZ_20210203_50}")
		--在他们身边创建两个鬼影
		local x,z = GetWorldPos(sceneId,PlayerId)
		local GuiHunID = LuaFnCreateMonster(sceneId,x891077_SkillBMonsterTable,x,z,26,-1,x891077_g_ScriptId)
		if GuiHunID > -1 then
			LuaFnSetNpcIntParameter(sceneId,GuiHunID,0,PlayerId)
		end
	end
end
--**********************************
--释放毒煞阵技能....
--**********************************
function x891077_UseSkillC(sceneId,selfId)
	--先发送对话
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_51}")
	--遍历在场内的玩家，不在安全区内全部干半血
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	--将角色直接转移到生成点释放技能
	SetPos(sceneId,selfId,125,125)
	local x,z = GetWorldPos(sceneId,selfId)
	--释放空技能
	LuaFnUnitUseSkill(sceneId,selfId,x891077_SkillC_ID,selfId,x,z,0,1)
	--创建安全区域
	SetCharacterDieTime(sceneId,LuaFnCreateMonster(sceneId,x891077_SkillCMonsterTable[1],x+10,z,3,-1,-1),5000) --黑色
	SetCharacterDieTime(sceneId,LuaFnCreateMonster(sceneId,x891077_SkillCMonsterTable[2],x-10,z,3,-1,-1),5000) --红色
	--给buff
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local PlayerID;
	for	i = 0,nHumanCount -1 do
		PlayerID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,PlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,PlayerID) == 1 and LuaFnIsCharacterLiving(sceneId,PlayerID) == 1 then
			--先执行给状态操作
			local nRandom = random(1,2)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerID,x891077_SkillC_Impactinfo[nRandom],0)
			--检测玩家
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId,PlayerID,x891077_SkillC_Impactinfo[1]) == 1 then
				CallScriptFunction(x891076_g_FuBenControlScript,"PlayerTips",sceneId,PlayerID,x891077_SkillC_HumanTipsinfo[1])
			end
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId,PlayerID,x891077_SkillC_Impactinfo[2]) == 1 then
				CallScriptFunction(x891076_g_FuBenControlScript,"PlayerTips",sceneId,PlayerID,x891077_SkillC_HumanTipsinfo[2])
			end
		end
	end
	--设置技能正在使用中的缓存时间
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_Step,5000)
end
--**********************************
--毒煞阵检测....
--**********************************
function x891077_OnImpactFadeOut(sceneId,selfId,impactId)
	--这种情况不会发生一般，如果发生了就是有人在搞事。
	if impactId == nil or not impactId or impactId < x891077_SkillC_Impactinfo[1] or impactId > x891077_SkillC_Impactinfo[2] then
		return
	end
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	if impactId == x891077_SkillC_Impactinfo[1] then
		if nPosX >= 130 and nPosX <= 140 and nPosZ >= 120 and nPosZ <= 130 then
			--很安全无任何操作
		else
			--直接buff炸半血
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x891077_SkillC_Impactinfo[3],0)
		end
	end
	if impactId == x891077_SkillC_Impactinfo[2] then
		if nPosX >= 110 and nPosX <= 120 and nPosZ >= 120 and nPosZ <= 130 then
			--很安全无任何操作
		else
			--直接buff炸半血
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x891077_SkillC_Impactinfo[3],0)
		end
	end
end
--**********************************
--进入战斗....
--**********************************
function x891077_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891077_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891077_Buff_MianYi2, 0 )
	--重置AI....
	x891077_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891077_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x891077_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x891077_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x891077_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891077_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x891077_g_FuBenControlScript, "OnDie",sceneId,selfId)
end


--**********************************
--重置AI....
--**********************************
function x891077_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillA_CombatTime,x891077_SkillA_Time )
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillB_CombatTime,x891077_SkillB_Time )
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_SkillC_CombatTime,x891077_SkillC_Time )
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_Step,0)
	
	MonsterAI_SetBoolParamByIndex(sceneId,selfId,x891077_IDX_SKILLC_KillFlag,0)
end

--**********************************
--对话框提示
--**********************************
function x891077_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

