x893343_g_ScriptId	= 893343
x893343_g_ControlScript = 893342

x893343_SkillCangSheng = 3581 --怒断苍生
x893343_SkillTaiGu = 3582 --太古之息
x893343_SkillWanChao = 3583 --万朝溯魂

x893343_SkillTaiGu_SpecObj = 1492 --太古陷阱
x893343_SkillCangSheng_SpecObj = 1493 --苍生陷阱

x893343_Buff_MianYi1	= 10472	--免疫一些负面效果....
x893343_Buff_MianYi2	= 10471	--免疫普通隐身....

x893343_IDX_CombatTime		= 1		--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x893343_IDX_UseSkillIndex	= 2 	--释放第几个技能了....
x893343_SkillTaiGu_Step = 3 	--太古之息释放第几次了....
x893343_SkillTaiGu_Outtime = 4 --太古之息延时释放....
x893343_IDX_UseSkillCooldown = 5	--每次释放特殊AI技能的间隔时间
x893343_SkillCangSheng_Outtime = 6 --太古之息延时释放....


x893343_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....


--用于释放的技能
--rate 继续下一个技能的概率
x893343_SkillTable = {
--	[0] = {skill = x893343_SkillWanChao,rate = 30},
	[0] = {skill = x893343_SkillCangSheng,rate = 80},
	[1] = {skill = x893343_SkillTaiGu,rate = 80},
}


x893343_HunYuTable = {
    { 
        nMdex = MDEX_PETSOUL_LING, 
        MosData = 50620, 
        nNumber = 5, 
        HunYu = {38002525,38002526,38002527,38002528,38002529}
    },
    { 
        nMdex = MDEX_PETSOUL_HUANG, 
        MosData = 50619, 
        nNumber = 3, 
        HunYu = {38002520,38002521,38002522,38002523,38002524}
    },
    { 
        nMdex = MDEX_PETSOUL_SHEN, 
        MosData = 50614, 
        nNumber = 1, 
        HunYu = {38002515,38002516,38002517,38002518,38002519}
    }
}

--**********************************
--入口函数
--**********************************
function x893343_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x893343_OnInit(sceneId, selfId)
	--重置AI....
	x893343_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x893343_OnHeartBeat(sceneId, selfId, nTick)
	local MosDataID = GetMonsterDataID( sceneId, selfId );
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	for i =  50614 , 50618  do	
		if MosDataID == i then
			--检测是否不在战斗状态....
			if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893343_IDX_CombatFlag ) then
				return
			end
			local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893343_IDX_CombatTime )
			local step = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893343_SkillTaiGu_Step )
			local BoutTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x893343_SkillTaiGu_Outtime)
			local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893343_IDX_UseSkillIndex )
			
			
			--累加进入战斗的时间....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x893343_IDX_CombatTime, CombatTime + nTick )
	
			--当前无法执行技能
			if LuaFnCanUnitUseSkill(sceneId,selfId,x893343_SkillTable[NextSkillIndex].skill) ~= 1 then
				return
			end
			--每次释放特殊AI技能的间隔时间
			local nSpecialSkillTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893343_IDX_UseSkillCooldown)
			nSpecialSkillTime = nSpecialSkillTime - nTick
			if nSpecialSkillTime <= 0 then
				x893343_UseMySkill( sceneId, selfId, x893343_SkillTable[NextSkillIndex].skill )
				if random(0,100) <= x893343_SkillTable[NextSkillIndex].rate then
					NextSkillIndex = mod(NextSkillIndex + 1,2);
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x893343_IDX_UseSkillIndex,NextSkillIndex )
				end
				--间隔10s释放
				MonsterAI_SetIntParamByIndex( sceneId, selfId, x893343_IDX_UseSkillCooldown, 10000 )
			else
				MonsterAI_SetIntParamByIndex(sceneId,selfId,x893343_IDX_UseSkillCooldown,nSpecialSkillTime)
			end	
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x893343_OnEnterCombat(sceneId, selfId, enmeyId)
	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893343_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893343_Buff_MianYi2, 0 )
	--重置AI....
	x893343_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893343_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x893343_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x893343_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x893343_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x893343_OnDie( sceneId, objId, killerId )
   -- 获取基础信息
    local MosDataID = GetMonsterDataID(sceneId, objId)
    local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
	local nPosX,nPosZ = GetWorldPos(sceneId,objId)
    -- 通用掉落处理
    for i = 1, getn(x893343_HunYuTable) do
        local tConfig = x893343_HunYuTable[i]  
        if MosDataID == tConfig.MosData then
            -- 更新计数
            local nCur = GetMissionDataEx(sceneId, playerID, tConfig.nMdex) 
            if nCur < tConfig.nNumber then
				nCur = nCur + 1 
			    SetMissionDataEx(sceneId, playerID, tConfig.nMdex, nCur)    
				local rand = random (getn(tConfig.HunYu))
				--掉包
				local nBoxId = DropBoxEnterScene(nPosX,nPosZ,sceneId )
				if nBoxId ~= -1 then
					SetItemBoxOwner(sceneId, nBoxId, LuaFnGetGUID(sceneId,playerID))
					SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
					AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1, tConfig.HunYu[rand])
				end
            end
        end
    end
    -- 神兽特殊处理
    if MosDataID >= 50614 and MosDataID <= 50618 then
        local nCurShen = GetMissionDataEx(sceneId, playerID, MDEX_PETSOUL_SHEN)
        if nCurShen < 1 then
            SetMissionDataEx(sceneId, playerID, MDEX_PETSOUL_SHEN, 1)
            -- 发放神兽奖励
            local tShenConfig = x893343_HunYuTable[3]
            local rand = random (getn(tShenConfig.HunYu))
			--掉包
			local nBoxId = DropBoxEnterScene(nPosX,nPosZ,sceneId )
			if nBoxId ~= -1 then
				SetItemBoxOwner(sceneId, nBoxId, LuaFnGetGUID(sceneId,playerID))
				SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1, tShenConfig.HunYu[rand])
			end
        end
    end
end

--**********************************
--技能释放成功
--**********************************
function x893343_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	
end

--**********************************
--重置AI....
--**********************************
function x893343_ResetMyAI( sceneId, selfId )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893343_SkillTaiGu_Step ,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x893343_SkillTaiGu_Outtime,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x893343_IDX_UseSkillCooldown,10000)
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893343_IDX_UseSkillIndex,0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893343_SkillCangSheng_Outtime,0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893343_IDX_CombatFlag, 0 )
end

--**********************************
--释放技能....
--**********************************
function x893343_UseMySkill(sceneId,selfId,nSkill)

	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local nHumanId;
	local Step = MonsterAI_GetIntParamByIndex(sceneId,selfId,x893343_SkillTaiGu_Step)
	local namMonster= GetName( sceneId, selfId )
	if nSkill == x893343_SkillTaiGu then
		--第一次进入的时候
		local PosX,PosZ = GetWorldPos(sceneId,selfId)

		MonsterAI_SetIntParamByIndex(sceneId,selfId,x893343_SkillTaiGu_Step,2)
		--释放控技能给自己
		LuaFnUnitUseSkill( sceneId, selfId, x893343_SkillTaiGu,selfId,PosX,PosZ,0,1)
		--发送PaoPao
		PaoPaoExEx(sceneId,selfId,500)

		--发送全屏提示
		x893343_NotifyTips(sceneId,ScriptGlobal_Format("#{ZSPVP_211231_21}",namMonster))

		--释放陷阱伤害取全部玩家
		for i = 0,nHumanCount - 1 do
			nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
				local PlayerX,PlayerZ = GetWorldPos(sceneId,nHumanId)
				CreateSpecialObjByDataIndex(sceneId,selfId,x893343_SkillTaiGu_SpecObj,PlayerX,PlayerZ,0)
				MonsterAI_SetIntParamByIndex(sceneId,selfId,x893343_SkillTaiGu_Outtime,1000)
			end
		end
	elseif nSkill == x893343_SkillCangSheng then
		--第一次进入的时候
		local PosX,PosZ = GetWorldPos(sceneId,selfId)

		--释放控技能给自己
		LuaFnUnitUseSkill( sceneId, selfId, x893343_SkillTaiGu,selfId,PosX,PosZ,0,1)
--		CreateSpecialObjByDataIndex(sceneId,selfId,x893343_SkillCangSheng_SpecObj,PosX,PosX,0)
		--发送PaoPao
		PaoPaoExEx(sceneId,selfId,536)

		--发送全屏提示
		x893343_NotifyTips(sceneId,ScriptGlobal_Format("#{ZSPVP_211231_61}",namMonster))

--		--释放陷阱伤害取全部玩家
		for i = 0,nHumanCount - 1 do
			nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
				local PlayerX,PlayerZ = GetWorldPos(sceneId,nHumanId)
				CreateSpecialObjByDataIndex(sceneId,selfId,x893343_SkillCangSheng_SpecObj,PlayerX,PlayerZ,0)
				MonsterAI_SetIntParamByIndex(sceneId,selfId,x893343_SkillCangSheng_Outtime,1000)
			end
		end
	end
end

--**********************************
--对话框提示
--**********************************
function x893343_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

function x893343_NotifyTips(sceneId,tip)
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i = 0,membercount - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId,tip);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,mems[i])
		end
	end
end