--水月山庄 驯兽师阿莺
--脚本号
x891079_g_ScriptId	= 891079
x891079_g_FuBenControlScript = 891070
x891079_g_CopySceneData_Param_PetYingAndLang = 22	--驯兽师-鹰狼合体
--buff....
x891079_Buff_MianYi1	= 10472	--免疫一些负面效果....
x891079_Buff_MianYi2	= 10471	--免疫普通隐身....

--AI Index....
x891079_SkillC_Obj1				= 1 --鹰1
x891079_SkillC_Obj2				= 2 --鹰2
x891079_SkillC_Obj3				= 3 --鹰3
x891079_SkillC_Obj4				= 4 --鹰4
x891079_IDX_UseSkillCooldown 	= 5	--每次释放特殊AI技能的间隔时间
x891079_IDX_UseSkillIndex		= 6 --释放第几个技能了....

x891079_SkillA_IDX				= 3235 --白狼魂
x891079_SkillB_IDX				= 3236 --苍原棘刺
X891079_SkillC_IDX				= 3237 --鹰翔霆击

--用于释放的技能
--rate 继续下一个技能的概率
x891079_SkillTable = {
	[0] = {skill = x891079_SkillA_IDX,rate = 60},
	[1] = {skill = x891079_SkillB_IDX,rate = 80},
	[2] = {skill = X891079_SkillC_IDX,rate = 80},
}

x891079_SkillA_Time				= 14000 --冷却时间15s
x891079_SkillB_Time				= 59000 --冷却时间60s
x891079_SkillC_Time				= 44000 --冷却时间45s

x891079_SkillA_Monster			= 48518 --白狼魂
x891079_SkillA_Script			= 891065 --白狼魂所用回调脚本
x891079_SkillA_Impact			= 10524 --狩猎状态

x891079_SkillB_SpecialObj		= 1100 --苍原棘刺陷阱

x891079_SkillC_MonsterGroup = {
	--北
	[1] = {dataid = 48519,posx = 143,posz = 51,patorlid=2,dir=27,dataidx = x891079_SkillC_Obj1},
	--南
	[2] = {dataid = 48519,posx = 143,posz = 79,patorlid=3,dir=9,dataidx = x891079_SkillC_Obj2},
	--西
	[3] = {dataid = 48519,posx = 129,posz = 66,patorlid=4,dir=0,dataidx = x891079_SkillC_Obj3},
	--东
	[4] = {dataid = 48519,posx = 156,posz = 66,patorlid=5,dir=18,dataidx = x891079_SkillC_Obj4},
}

x891079_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....

--**********************************
--入口函数
--**********************************
function x891079_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891079_OnInit(sceneId, selfId)
	--发送泡泡 小白小黑乖到旁边去
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_81}")
	--生成跑动的小白小黑
	CallScriptFunction(x891079_g_FuBenControlScript,"CreateXunShouShiPetStart",sceneId)
	--重置AI....
	x891079_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x891079_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex(sceneId,selfId,x891079_IDX_CombatFlag) then
		return
	end
	local CurPerHp = GetHp(sceneId,selfId) / GetMaxHp(sceneId,selfId)
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891079_IDX_UseSkillIndex )
	--当前无法执行技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x891079_SkillTable[NextSkillIndex].skill) ~= 1 then
		return
	end
	--每次释放特殊AI技能的间隔时间
	local nSpecialSkillTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891079_IDX_UseSkillCooldown)
	nSpecialSkillTime = nSpecialSkillTime - nTick
	if nSpecialSkillTime <= 0 then
		if NextSkillIndex == 0 then
			x891079_UseSkillA(sceneId,selfId)
		elseif NextSkillIndex == 1 then
			x891079_UseSkillB(sceneId,selfId)	
		elseif NextSkillIndex == 2 then
			x891079_UseSkillC(sceneId,selfId)	
		end
		
		if random(0,100) <= x891079_SkillTable[NextSkillIndex].rate then
			NextSkillIndex = mod(NextSkillIndex + 1,3);
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_IDX_UseSkillIndex,NextSkillIndex )
		end
		--间隔10s释放
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_IDX_UseSkillCooldown, 10000 )
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891079_IDX_UseSkillCooldown,nSpecialSkillTime)
	end
end
--**********************************
--白狼魂技能释放....
--**********************************
function x891079_UseSkillA(sceneId,selfId)
	--发送泡泡
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210226_01}")
	--效果npc释放动作
	local nEffectObjId = LuaFnGetCopySceneData_Param(sceneId,x891079_g_CopySceneData_Param_PetYingAndLang)
	if nEffectObjId ~= -1 then
		MonsterDoAction( sceneId, nEffectObjId, 165, -1 )
	end
	--释放一个空技能
	local x,z = GetWorldPos(sceneId,selfId)
	LuaFnUnitUseSkill(sceneId,selfId,x891079_SkillA_IDX,selfId,x,z,0,1)
	--点名操作
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local PlayerList = {}
	local numPlayer = 0
	local PlayerId;
	local nHumanId;
	local szName,nPosX,nPosZ,szText	= "",0,0,""
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
	--如果是超过3个人以上再刷副本的情况。
	if numPlayer > 3 then
		for i = 1,3 do
			PlayerId = PlayerList[random(numPlayer)]
			szName = GetName(sceneId,PlayerId)
			nPosX,nPosZ = GetWorldPos(sceneId,PlayerId)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerId,x891079_SkillA_Impact,0)
			--创建狼魂，锁定目标，只在场中存活10s因为狩猎状态就10s
			local nDogID = LuaFnCreateMonster(sceneId,x891079_SkillA_Monster,nPosX,nPosZ - 5,21,-1,x891079_SkillA_Script)
			if nDogID > -1 then
				SetCharacterTitle(sceneId,nDogID,"狩猎"..szName)
				LuaFnSetNpcIntParameter(sceneId,nDogID,0,PlayerId) --一定要锁定住
				SetMonsterCurEnemy(sceneId,nDogID,PlayerId)
				SetCharacterDieTime(sceneId,nDogID,10000)
			end
			--构建点名数据用于醒目提示
			if i < 3 then
				szText = szText..szName.."、"
			end
			if i == 3 then
				szText = szText..szName
			end
		end
		--发送醒目提示
		CallScriptFunction(x891079_g_FuBenControlScript,"NotifyTips",sceneId,ScriptGlobal_Format("#{SYSZ_20210203_57}",szText))
	else
		for i = 1,numPlayer do
			PlayerId = PlayerList[i]
			szName = GetName(sceneId,PlayerId)
			nPosX,nPosZ = GetWorldPos(sceneId,PlayerId)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,PlayerId,x891079_SkillA_Impact,0)
			--创建狼魂，锁定目标，只在场中存活10s因为狩猎状态就10s
			local nDogID = LuaFnCreateMonster(sceneId,x891079_SkillA_Monster,nPosX,nPosZ - 5,21,-1,x891079_SkillA_Script)
			if nDogID > -1 then
				SetCharacterTitle(sceneId,nDogID,"狩猎"..szName)
				LuaFnSetNpcIntParameter(sceneId,nDogID,0,PlayerId) --一定要锁定住
				SetMonsterCurEnemy(sceneId,nDogID,PlayerId)
				SetCharacterDieTime(sceneId,nDogID,10000)
			end
			--构建点名数据用于醒目提示
			if i < numPlayer then
				szText = szText..szName.."、"
			end
			if i == numPlayer then
				szText = szText..szName
			end
		end
		--发送醒目提示
		CallScriptFunction(x891079_g_FuBenControlScript,"NotifyTips",sceneId,ScriptGlobal_Format("#{SYSZ_20210203_57}",szText))
	end
end
--**********************************
--苍原棘刺技能释放....
--**********************************
function x891079_UseSkillB(sceneId,selfId)
	--发送泡泡
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_59}")
	--释放一个空技能
	local x,z = GetWorldPos(sceneId,selfId)
	LuaFnUnitUseSkill(sceneId,selfId,x891079_SkillB_IDX,selfId,x,z,0,1)
	--发送全屏提示
	CallScriptFunction(x891079_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_60}")
	--随机选中两名玩家
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local PlayerList = {}
	local numPlayer = 0
	local PlayerId;
	local nHumanId;
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
	if numPlayer >= 2 then
		for i = 1,2 do
			PlayerId = PlayerList[random(numPlayer)]
			nPosX,nPosZ = GetWorldPos(sceneId,PlayerId)
			CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x891079_SkillB_SpecialObj,nPosX,nPosZ,0)
		end
	else
		PlayerId = PlayerList[random(numPlayer)]
		nPosX,nPosZ = GetWorldPos(sceneId,PlayerId)
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x891079_SkillB_SpecialObj,nPosX,nPosZ,0)
	end
end
--**********************************
--鹰归技能释放....
--**********************************
function x891079_UseSkillC(sceneId,selfId)
	--效果npc释放动作
	local nEffectObjId = LuaFnGetCopySceneData_Param(sceneId,x891079_g_CopySceneData_Param_PetYingAndLang)
	if nEffectObjId ~= -1 then
		MonsterDoAction( sceneId, nEffectObjId, 167, -1 )
	end
	--自身回到中心点
	local nDefPosX,nDefPosZ = CallScriptFunction(x891079_g_FuBenControlScript,"GetFubenMonsterPos",sceneId,3)
	SetPos(sceneId,selfId,nDefPosX,nDefPosZ)
	--释放鹰翔霆击
	LuaFnUnitUseSkill(sceneId,selfId,X891079_SkillC_IDX,-1,-1,-1,0,1)
	--发送泡泡 鹰归！与我共御敌
	MonsterTalk(sceneId,selfId,"水月山庄","#{SYSZ_20210203_61}")
	--发送全屏提示 大批的飞鹰正在聚集而来，请少侠赶快消灭，不要让其靠近阿莺！	
	CallScriptFunction(x891079_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_62}")
	--草原翱翔之雄鹰，来往长空，击碎雷霆！
	LuaFnNpcTalk(sceneId,103)
	--创建四路雄鹰
	for i = 1,getn(x891079_SkillC_MonsterGroup) do
		local tab = x891079_SkillC_MonsterGroup[i];
		local nYing = CreateMonsterWithDir(sceneId,tab.dataid,tab.posx,tab.posz,15,-1,-1,tab.dir)
		if nYing > -1 then
			--设置消亡时间
			SetCharacterDieTime(sceneId,nYing,10000)
			--设置巡逻路径
			SetPatrolId(sceneId, nYing, tab.patorlid)
			--设置临时ID
			MonsterAI_SetIntParamByIndex(sceneId,selfId,tab.dataidx,nYing)
		end
	end	
end

--**********************************
--技能释放成功
--**********************************
function x891079_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--鹰归
	if nSkillId == X891079_SkillC_IDX then
		local nAliveNum = 1;
		--四路雄鹰存活情况
		for i = 1,getn(x891079_SkillC_MonsterGroup) do
			local tab = x891079_SkillC_MonsterGroup[i];
			local nYing = MonsterAI_GetIntParamByIndex(sceneId,selfId,tab.dataidx)
			if nYing > -1 then
				if IsInDist(sceneId,selfId,nYing,1) == 1 and LuaFnIsCharacterLiving(sceneId,nYing) == 1 then
					nAliveNum = nAliveNum + 1
				end
				MonsterAI_SetIntParamByIndex(sceneId,selfId,tab.dataidx,-1)
			end
		end	
		if nAliveNum <= 0 then
			return
		end
		--遍历周围角色并给予伤害
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,42703 + nAliveNum - 1,0)
	end
end

--**********************************
--进入战斗....
--**********************************
function x891079_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891079_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891079_Buff_MianYi2, 0 )
	--重置AI....
	x891079_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891079_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x891079_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x891079_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x891079_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891079_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x891079_g_FuBenControlScript, "OnDie",sceneId,selfId)
end


--**********************************
--重置AI....
--**********************************
function x891079_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_SkillC_Obj1,-1)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_SkillC_Obj2,-1)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_SkillC_Obj3,-1)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_SkillC_Obj4,-1)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_IDX_UseSkillCooldown,8000)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891079_IDX_UseSkillIndex,0)
	
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891079_IDX_CombatFlag, 0 )
	--雄鹰
	for i = 1,getn(x891079_SkillC_MonsterGroup) do
		local tab = x891079_SkillC_MonsterGroup[i];
		MonsterAI_SetIntParamByIndex(sceneId,selfId,tab.dataidx,-1)
	end
end

--**********************************
--对话框提示
--**********************************
function x891079_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

