-- 特殊BOSS

x810101_TBL = 
{
	IDX_TimerPrepare = 1,
	IDX_TimerInterval = 2,
	IDX_FlagCombat = 1,
	BossSkill = 1002,
	PrepareTime = 60000,
	SkillInterval = 60000,
	BossBuff = 9999
}


function x810101_OnDie( sceneId, selfId, killerId )
	LuaFnNpcChat(sceneId, selfId, 0, format("下次在遇到你们，%s我又是一条好汉！",GetName(sceneId,selfId)))
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x810101_TBL.IDX_FlagCombat, 0)
	
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then --如果是宠物的话，把这个ID设置成主人ID
		killerId = GetPetCreator( sceneId, killerId )
	end
	--给个人生成掉落箱子
--	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
--	local nBoxId = DropBoxEnterSceneEx(nPosX,nPosZ,sceneId,LuaFnGetGUID(sceneId,killerId) )
--	if nBoxId ~= -1 then
--		SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
--		--增加掉落物品 毛茸茸兔耳朵
--		AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,10410035)
--	end
	--给场景所有人2w绑定元宝
--	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
--	for i=0, nHumanNum-1  do
--		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
--		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
--			BindYuanBao(sceneId,PlayerId,-1,1,20000)
--		end
--	end
	
	--随机生成宝箱20个
	local cx, cz = GetWorldPos( sceneId, selfId )
	for i = 1,20 do
		local nRandX,nRandZ = LuaFnRandPosInCenter(cx,cz,16.0);
		--没有则创建NPC大宝箱....
		local MstId = LuaFnCreateMonster(sceneId, 60001, nRandX,nRandZ, 3, 0, 810102 )
		if MstId ~= -1 then
			SetCharacterName( sceneId, MstId, format("%s的宝藏",GetName(sceneId,selfId)) )
			--5分钟生命期....	
			SetCharacterDieTime(sceneId, MstId,5 * 60 * 1000)
		end
	end
end

function x810101_OnHeartBeat(sceneId, selfId, nTick)
	if(1==LuaFnIsCharacterLiving(sceneId, selfId)) then
		if(1==MonsterAI_GetBoolParamByIndex(sceneId, selfId, x810101_TBL.IDX_FlagCombat)) then
			--Countdown TimerPrepare
			local TimePrepare = MonsterAI_GetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerPrepare)
			if(0<TimePrepare) then
				TimePrepare = TimePrepare - nTick;
				MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerPrepare, TimePrepare)
			else
				local TimeInterval = MonsterAI_GetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval)
				if(0<TimeInterval) then
					--Countdown TimerInterval
					TimeInterval = TimeInterval - nTick;
					MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval, TimeInterval)
				else
					MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval, x810101_TBL.SkillInterval)
					local nTarget = LuaFnGetTargetObjID(sceneId, selfId)
					if(-1~=nTarget) then
						local posX, posZ = GetWorldPos(sceneId,nTarget)
						local fDir = 0.0
						LuaFnUnitUseSkill(sceneId, selfId, x810101_TBL.BossSkill, nTarget, posX, posZ, fDir)			
						LuaFnNpcChat(sceneId, selfId, 0, "尝尝我的滔天怒火吧！")
					end
				end
			end
		end
	end
end

function x810101_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x810101_TBL.IDX_FlagCombat, 0)
end

function x810101_OnKillCharacter(sceneId, selfId, targetId)
	if(-1~=targetId) then
		local szTarget = GetName(sceneId, targetId)		
		LuaFnNpcChat(sceneId, selfId, 0, szTarget .. format("，你就算再厉害十倍，遇上我%s也只有死路一条！",GetName(sceneId,selfId)))
	end
end

function x810101_OnEnterCombat(sceneId, selfId, enmeyId)
	if(0<x810101_TBL.BossBuff) then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x810101_TBL.BossBuff, 0)
	end
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerPrepare, x810101_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x810101_TBL.IDX_FlagCombat, 1)
end

function x810101_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x810101_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x810101_TBL.IDX_FlagCombat, 0)
end
