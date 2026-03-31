--生死擂台·公孙胜
--脚本号
x402319_g_ScriptId	= 402319

--副本逻辑脚本号....
x402319_g_FuBenScriptId = 892009

--buff....
x402319_Buff_MianYi1	= 10472	--免疫一些负面效果....
x402319_Buff_MianYi2	= 10471	--免疫普通隐身....
x402319_Buff_JuQi		= 10506 --3s聚气状态

x402319_Skill_FenShen	= 1321 --分身符ID
x402319_Skill_FSTime	= 120000 --冷却120s
x402319_MaxCloneData	= 64 --最大可以生成64个分身(这分身是以分身体分身计算)


--AI Index....
x402319_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x402319_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....
x402319_IDX_SkillFSTime		= 3 --分身符技能冷却时间
x402319_IDX_MaxCloen		= 4 --分身符最大分身记录.....

x402319_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....

--**********************************
--入口函数
--**********************************
function x402319_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--初始化....
--**********************************
function x402319_OnInit(sceneId, selfId)
	--重置AI....
	x402319_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x402319_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402319_IDX_CombatFlag ) then
		return
	end
	local MosDataID = GetMonsterDataID(sceneId,selfId);
	if MosDataID >= 13712 and MosDataID <= 13717 then
		--分身不释放技能
	else
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		if CurPercent <= 0.5 then
			--释放分身符技能
			x402319_FenShenJuqi( sceneId, selfId ,nTick)
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x402319_OnEnterCombat(sceneId, selfId, enmeyId)
	local MosDataID = GetMonsterDataID(sceneId,selfId);
	if MosDataID >= 13712 and MosDataID <= 13717 then
	else
		--加初始buff....
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402319_Buff_MianYi1, 0 )
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x402319_Buff_MianYi2, 0 )
		--重置AI....
		x402319_ResetMyAI( sceneId, selfId )
	end
	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402319_IDX_CombatFlag, 1 )
end


--**********************************
--离开战斗....
--**********************************
function x402319_OnLeaveCombat(sceneId, selfId)
	local MosDataID = GetMonsterDataID(sceneId,selfId);
	if MosDataID >= 13712 and MosDataID <= 13717 then
		--如果本体存在，直接消失。
		--遍历场内存不存在本体
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 13469 and MosDataID <= 13474 then
				LuaFnDeleteMonster(sceneId,selfId)
			end
		end
		--不存在本体不消失，继续走逻辑哦。
	else
		--重置AI....
		x402319_ResetMyAI( sceneId, selfId )
		--满血自己....
		SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
	end
end


--**********************************
--杀死敌人....
--**********************************
function x402319_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x402319_OnDie( sceneId, selfId, killerId )
	local MosDataID = GetMonsterDataID(sceneId,selfId);
	if MosDataID >= 13712 and MosDataID <= 13717 then
		--判断，如果本体死了，分身还活着呢，那分身死亡之后无限释放技能。
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 13469 and MosDataID <= 13474 then
			else
				--限制个最大数量，然后不让他再继续生成了。
				if MonsterAI_GetIntParamByIndex(sceneId,selfId,x402319_IDX_MaxCloen) >= x402319_MaxCloneData then
					return
				end
				x402319_UseFenShenSkill(sceneId,selfId)
				break
			end
		end
	else
		--这块也要严谨判断，如果本体死了，分身存在，那就直接返回了，什么都不给等于这个副本失败。
		SetCharacterDieTime(sceneId,selfId,2000) --设定2s挂掉，给上个对话
		LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090119_168}") --对话必须要有
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			--场内存在分身，直接不管了。
			if MosDataID >= 13712 and MosDataID <= 13717 then
				return
			end
		end
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
				SetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_GONGSUNSHENG,GetMissionDataEx(sceneId,mems[i],MDEX_SHAXING_GONGSUNSHENG) + 1)
				--标记BOSS被击杀
				CallScriptFunction(402048, "OnKillBoss",sceneId, mems[i])
				
				x402319_NotifyTip( sceneId, mems[i],format("已击败%s",szName))
				if IsZhanDouFlag > 0 then
					LuaFnSetCopySceneData_Param(sceneId,18,0)
				end
				if nKillNum + 1 < 6 then
					x402319_NotifyTip( sceneId, mems[i],
						format("下一个煞星将会在%d分%d秒后主动出现，队长与任意剩余杀星对话可直接开启挑战。"
						,remainingMinutes
						,remainingSecondsInMinute
					));
				end
				--发个系统，只有队长可以操作。
				if LuaFnIsTeamLeader(sceneId,mems[i]) == 1 then
					local strText = format("#{_INFOUSR%s}#{SXRW_090119_131}",GetName(sceneId,mems[i]))
					BroadMsgByChatPipe(sceneId,mems[i],strText,4)
				end
			end
		end
	end
end


--**********************************
--重置AI....
--**********************************
function x402319_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x402319_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x402319_IDX_UseSkillIndex, 1 )
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x402319_IDX_SkillFSTime,3000)
	
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x402319_IDX_CombatFlag, 0 )

end

--**********************************
--分身符聚气....
--**********************************
function x402319_FenShenJuqi(sceneId,selfId,nTick)
	local SkillTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x402319_IDX_SkillFSTime)
	if SkillTime > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x402319_IDX_SkillFSTime,SkillTime - nTick)
	else
		x402319_UseFenShenSkill(sceneId,selfId)
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x402319_IDX_SkillFSTime,x402319_Skill_FSTime)
		return
	end
	if (SkillTime - nTick) >= 0 and (SkillTime - nTick) < 3000 then
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x402319_Buff_JuQi) ~= 1 then
			LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090630_122}")
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x402319_Buff_JuQi,0)
		end
	end
end
--**********************************
--BOSS使用技能....
--**********************************
function x402319_UseFenShenSkill(sceneId,selfId)
	-- 分身符释放规则，选取场内玩家随机一个人的坐标，然后在他脚下释放分身怪。
	local MosDataID = GetMonsterDataID(sceneId,selfId);
	local Hp = GetHp(sceneId,selfId)
	if MosDataID >= 13712 and MosDataID <= 13717 then
		Hp = GetMaxHp(sceneId,selfId) * 0.5
		LuaFnNpcChat(sceneId,selfId,0,"#{SXRW_090119_168}") --对话必须要有
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x402319_IDX_MaxCloen,MonsterAI_GetIntParamByIndex(sceneId,selfId,x402319_IDX_MaxCloen) + 1)
	end
	local nSelfX,nSelfZ = GetWorldPos(sceneId,selfId)
	local nHumanList = {};
	local nPlayerID = -1
	local numPlayer = 0;
	local nLevel = floor(GetLevel(sceneId,selfId)/10) - 6
	local nFenShenID = 13711 + nLevel
	LuaFnUnitUseSkill(sceneId,selfId,x402319_Skill_FenShen,selfId,nSelfX,nSelfZ,0,1) --使用空技能...
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local nHumanId;
	for i=0, nHumanCount-1 do
		nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanId) == 1 then
			nHumanList[numPlayer + 1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end
	if numPlayer <= 0 then
		return 0
	end
	nPlayerID = nHumanList[random(numPlayer)]
	--获取选中玩家的坐标
	local nPlayerX,nPlayerZ = GetWorldPos(sceneId,nPlayerID)
	local objId = LuaFnCreateMonster(sceneId,nFenShenID,nPlayerX,nPlayerZ, 19, 0,x402319_g_ScriptId)
	SetUnitReputationID(sceneId,objId,objId,28)
	SetHp(sceneId,objId,Hp)
	SetCharacterTitle(sceneId,objId,"天闲星")
end

--**********************************
--对话框提示
--**********************************
function x402319_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
