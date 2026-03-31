--水月山庄 契丹力士十三
--技能释放顺序，冲撞2次....玄臂....聚力....玄臂....继续返回
--脚本号
x891076_g_ScriptId	= 891076
x891076_g_FuBenControlScript = 891070
--buff....
x891076_Buff_MianYi1	= 10472	--免疫一些负面效果....
x891076_Buff_MianYi2	= 10471	--免疫普通隐身....

x891076_SkillChongFeng	= 3227 --冲锋技能
x891076_SkillChongFengEx = 3234 --冲过去

x891076_SkillJuLiSuoLian = 3246 --聚力锁链
x891076_SkillXuanBiLieDi = 3229 --玄臂裂地

x891076_SkillChongFeng_SpecObj = 1097 --冲锋陷阱
x891076_SkillXuanBiLieDi_SpecObj = 1098 --玄臂陷阱
x891076_SkillJuLiSuoLian_SpecObj = 1096 --聚力锁链

--用于释放的技能
--rate 继续下一个技能的概率
x891076_SkillTable = {
	[0] = {skill = x891076_SkillChongFeng,rate = 30},
	[1] = {skill = x891076_SkillJuLiSuoLian,rate = 80},
	[2] = {skill = x891076_SkillXuanBiLieDi,rate = 80},
}

--AI Index....
x891076_IDX_CombatTime		= 1		--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x891076_IDX_UseSkillIndex	= 2 	--释放第几个技能了....
x891076_SkillXuanBiLieDi_Step = 3 	--玄臂裂地释放第几次了....
x891076_SkillXuanBiLieDi_Outtime = 4 --玄臂裂地延时释放....
x891076_SkillChongFeng_Outtime = 5 	--存储冲锋技能延时释放....
x891076_SkillChongFeng_PosX = 6 	--冲锋目标点
x891076_SkillChongFeng_PosZ = 7 	--冲锋目标点
x891076_IDX_UseSkillCooldown = 8	--每次释放特殊AI技能的间隔时间

x891076_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x891076_SkillChongFengFlag		= 2 --冲锋标记....
x891076_SkillJuLiSuoLian_Flag 	= 3 --聚力锁链标记....

--**********************************
--入口函数
--**********************************
function x891076_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891076_OnInit(sceneId, selfId)
	--发送泡泡
	MonsterTalk(sceneId, selfId, "水月山庄","#{SYSZ_20210203_74}")
	--重置AI....
	x891076_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x891076_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891076_IDX_CombatFlag ) then
		return
	end
	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891076_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891076_IDX_UseSkillIndex )
	local step = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891076_SkillXuanBiLieDi_Step )
	local BoutTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Outtime)
	local ChongFengoutTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_Outtime)
	local SuoLianFlag = MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891076_SkillJuLiSuoLian_Flag)
	local ChongFengFlag = MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891076_SkillChongFengFlag)
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891076_IDX_CombatTime, CombatTime + nTick )
	--存在特殊状态
	if ChongFengFlag == 1 then
		if ChongFengoutTime > 0 then
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_Outtime,ChongFengoutTime - nTick)
		else
			x891076_UseMySkill(sceneId,selfId,x891076_SkillChongFeng)
		end
		return
	end
	if step > 0 then
		if BoutTime > 0 then
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Outtime,BoutTime - nTick)
		else
			x891076_UseMySkill(sceneId,selfId,x891076_SkillXuanBiLieDi)
		end
		return
	end
	if SuoLianFlag == 1 then
		x891076_UseMySkill(sceneId,selfId,x891076_SkillJuLiSuoLian)
		return
	end
	--当前无法执行技能
	if LuaFnCanUnitUseSkill(sceneId,selfId,x891076_SkillTable[NextSkillIndex].skill) ~= 1 then
		return
	end
	--每次释放特殊AI技能的间隔时间
	local nSpecialSkillTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x891076_IDX_UseSkillCooldown)
	nSpecialSkillTime = nSpecialSkillTime - nTick
	if nSpecialSkillTime <= 0 then
		x891076_UseMySkill( sceneId, selfId, x891076_SkillTable[NextSkillIndex].skill )
		if random(0,100) <= x891076_SkillTable[NextSkillIndex].rate then
			NextSkillIndex = mod(NextSkillIndex + 1,3);
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x891076_IDX_UseSkillIndex,NextSkillIndex )
		end
		--间隔10s释放
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x891076_IDX_UseSkillCooldown, 10000 )
	else
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_IDX_UseSkillCooldown,nSpecialSkillTime)
	end
end

--**********************************
--进入战斗....
--**********************************
function x891076_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891076_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x891076_Buff_MianYi2, 0 )
	--重置AI....
	x891076_ResetMyAI( sceneId, selfId )
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x891076_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	x891076_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end


--**********************************
--杀死敌人....
--**********************************
function x891076_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891076_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x891076_g_FuBenControlScript, "OnDie",sceneId,selfId)
end

--**********************************
--技能释放成功
--**********************************
function x891076_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	--十三冲锋
	if nSkillId == x891076_SkillChongFeng then
		local nTarPosX = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosX)
		local nTarPosZ = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosZ)
		if nTarPosX <= 0 or nTarPosZ <= 0 then
			return
		end
		--选定目标的预警圈内布置冲锋陷阱
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x891076_SkillChongFeng_SpecObj,nTarPosX,nTarPosZ,0)
		--做一个完成动作
		LuaFnUnitUseSkill( sceneId, selfId, x891076_SkillChongFengEx, selfId,nTarPosX,nTarPosZ,0,1)
		--清除冲锋所记录信息
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosX,0)
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosZ,0)
		--清除冲锋标记
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_SkillChongFengFlag, 0 )
	end
	--十三聚力锁链释放完毕
	if nSkillId == x891076_SkillJuLiSuoLian then
		local nPosX,nPosZ = GetWorldPos( sceneId, selfId )
		--发送PaoPao
		MonsterTalk(sceneId, selfId, "水月山庄", "#{SYSZ_20210203_88}")
		--脚下释放陷阱
		CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x891076_SkillJuLiSuoLian_SpecObj,nPosX,nPosZ,0)
		--清除标记
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_SkillJuLiSuoLian_Flag,0)
	end
end

--**********************************
--重置AI....
--**********************************
function x891076_ResetMyAI( sceneId, selfId )
	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891076_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891076_IDX_UseSkillIndex,0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x891076_SkillXuanBiLieDi_Step ,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosX,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosZ,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_Outtime,0)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_IDX_UseSkillCooldown,10000)
	
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_IDX_CombatFlag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_SkillJuLiSuoLian_Flag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_SkillChongFengFlag, 0 )
end

--**********************************
--释放技能....
--**********************************
function x891076_UseMySkill(sceneId,selfId,nSkill)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local nHumanId;
	local Step = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Step)
	local ChongFengFlag = MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891076_SkillChongFengFlag)
	if nSkill == x891076_SkillChongFeng then
		if ChongFengFlag == 0 then
			local nMaxDisPlayerId = -1
			local nMaxDis = 0;
			--冲撞，选择最远的一名玩家进行冲撞
			for i = 0,nHumanCount - 1 do
				nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
					local nDist = GetDist(sceneId,selfId,nHumanId)
					if nDist >= nMaxDis then
						nMaxDisPlayerId = nHumanId
					end
				end
			end
			if nMaxDisPlayerId < 0 then
				return
			end
			--回到原地
--			local nDefPosX,nDefPosZ = CallScriptFunction(x891076_g_FuBenControlScript,"GetFubenMonsterPos",sceneId,1)
--			SetPos(sceneId,selfId,124,176)
			--发送全屏提示
			CallScriptFunction(x891076_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_36}")
			--发送PaoPao
			MonsterTalk(sceneId, selfId,"水月山庄", ScriptGlobal_Format("#{SYSZ_20210203_35}",GetName(sceneId,nMaxDisPlayerId)))
			local nPlayerX,nPlayerZ = GetWorldPos( sceneId, nMaxDisPlayerId )
			--添加预警NPC
			local TarObjId = LuaFnCreateMonster(sceneId,48505,nPlayerX,nPlayerZ,0,-1,-1)
			if TarObjId > -1 then
				SetCharacterDieTime(sceneId,TarObjId,2500)
				--写入延时释放冲锋技能操作
				MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosX,nPlayerX)
				MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_PosZ,nPlayerZ)
			end
			--释放冲锋聚气技能
			LuaFnUnitUseSkill( sceneId, selfId, x891076_SkillChongFeng, -1,nPlayerX,nPlayerZ,-1,1)
			--写入延时释放冲锋技能操作
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillChongFeng_Outtime,2500)
			--冲锋标记
			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_SkillChongFengFlag, 1 )
		end
	elseif nSkill == x891076_SkillXuanBiLieDi then
		--第一次进入的时候
		local PosX,PosZ = GetWorldPos(sceneId,selfId)
		if Step == 0 then
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Step,2)
			--释放控技能给自己
			LuaFnUnitUseSkill( sceneId, selfId, x891076_SkillXuanBiLieDi,selfId,PosX,PosZ,0,1)
			--发送PaoPao
			MonsterTalk(sceneId, selfId, "水月山庄", "#{SYSZ_20210203_39}")
			--发送Talk
			LuaFnNpcTalk(sceneId,101)
			--发送全屏提示
			CallScriptFunction(x891076_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_40}")
			--释放陷阱伤害取全部玩家
			for i = 0,nHumanCount - 1 do
				nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
					local PlayerX,PlayerZ = GetWorldPos(sceneId,nHumanId)
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_SpecObj,PlayerX,PlayerZ,2000)
					MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Outtime,1000)
				end
			end
		else
			--释放陷阱伤害取全部玩家
			for i = 0,nHumanCount - 1 do
				nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
					local PlayerX,PlayerZ = GetWorldPos(sceneId,nHumanId)
					CreateSpecialObjAutoFadeByDataIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_SpecObj,PlayerX,PlayerZ,0)
					MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Outtime,1000)
				end
			end
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891076_SkillXuanBiLieDi_Step,Step - 1)
		end
	elseif nSkill == x891076_SkillJuLiSuoLian then
		local SuoLianFlag = MonsterAI_GetBoolParamByIndex( sceneId, selfId, x891076_SkillJuLiSuoLian_Flag)
		if SuoLianFlag == 0 then
			--将没在身边的玩家拉到身边
			local PlayerList = {}
			local numPlayer = 0
			for i = 0,nHumanCount - 1 do
				nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
					local nDist = GetDist(sceneId,selfId,nHumanId)
					if nDist > 5 then
						--给被锁定的玩家上一个buff
						LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,nHumanId,42655,0)
						--被锁定的玩家来一条提示
						x891076_NotifyTip( sceneId, nHumanId, "#{SYSZ_20210203_38}" )
						numPlayer = numPlayer + 1
					end
				end
			end
			--点名
			if numPlayer <= 0 then
				return
			end
			--发送PaoPao
			MonsterTalk(sceneId, selfId, "水月山庄", "#{SYSZ_20210203_37}")
			--释放一个空技能
			LuaFnUnitUseSkill( sceneId, selfId, x891076_SkillJuLiSuoLian,-1,-1,-1,0,1)
			--然后进入标记状态
			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x891076_SkillJuLiSuoLian_Flag,1)
		end
	end
end

--**********************************
--对话框提示
--**********************************
function x891076_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

