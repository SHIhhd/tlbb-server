--水月山庄 开牢门
x891068_g_ScriptId	= 891068
x891068_g_FuBenControlScript = 891070
x891068_g_CopySceneData_Param_LaomenAState = 23		--牢门A
x891068_g_CopySceneData_Param_LaomenBState = 24		--牢门B
--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891068_OnConditionCheck( sceneId, selfId )
	if GetLevel(sceneId,selfId) < 80 then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_01}")
		return 0
	end
	if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_05}")
		return 0
	end
	if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_05}")
		return 0
	end
	if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_06}")
		return 0
	end
	if IsTeamFollow(sceneId,selfId) == 1 then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_04}")
		return 0
	end 
	if LuaFnGetCopySceneData_Param(sceneId,0) ~= FUBEN_SHUIYUESHANZHAUNG then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_02}")
		return 0
	end
	local nCurTarObj = LuaFnGetTargetObjID(sceneId,selfId)
	local MosDataID = GetMonsterDataID(sceneId,nCurTarObj)
	if MosDataID ~= 48524 and MosDataID ~= 48525 then
		return 0;
	end
	if IsInDist(sceneId,selfId,nCurTarObj,10) ~= 1 then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_03}")
		return 0
	end
	--牢门已开
	if LuaFnGetNpcIntParameter(sceneId,nCurTarObj,0) == 1 then
		x891068_NotifyTip(sceneId,selfId,"#{SYSZ_20210304_08}")
		return 0
	end
	return 1;
end
--**********************************
--技能释放完毕
--**********************************
function x891068_SkillOnUnitOne(sceneId,selfId, nSkillId,targetID )
	--开牢门
	if nSkillId ~= 3243 then
		return
	end
	LuaFnSetNpcIntParameter(sceneId,targetID,0,1)
	LuaFnMonsterDoSpecialAction(sceneId,targetID,166,165,165)
	--给玩家回血
	RestoreHp(sceneId,selfId)
	RestoreMp(sceneId,selfId)
	RestoreRage(sceneId,selfId)
	--根据牢门放不同的人
	local MosDataID = GetMonsterDataID(sceneId,targetID)
	local nMonsterNum = GetMonsterCount(sceneId)
	if MosDataID == 48524 then
		for i = 0, nMonsterNum - 1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MonsterData = GetMonsterDataID(sceneId,MonsterId)
			if MonsterData == 48531 then --农夫张
				MonsterDoMove(sceneId,MonsterId,186,97)
			end
			if MonsterData == 48532 then --农夫田
				MonsterDoMove(sceneId,MonsterId,187,95)
			end
			if MonsterData == 48533 then --厨师刘
				MonsterDoMove(sceneId,MonsterId,186,94)
				MonsterTalk(sceneId,MonsterId,"水月山庄",ScriptGlobal_Format("#{SYSZ_20210326_01}",GetName(sceneId,selfId)))
			end
			if MonsterData == 48534 then --伙计刘
				MonsterDoMove(sceneId,MonsterId,190,94)
			end
			if MonsterData == 48535 then --伙计张
				MonsterDoMove(sceneId,MonsterId,187,92)
			end
		end
	elseif MosDataID == 48525 then
		for i = 0, nMonsterNum - 1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MonsterData = GetMonsterDataID(sceneId,MonsterId)
			if MonsterData == 48526 then --李庄主
				MonsterDoMove(sceneId,MonsterId,190,86)
				MonsterTalk(sceneId,MonsterId,"水月山庄",ScriptGlobal_Format("#{SYSZ_20210326_03}",GetName(sceneId,selfId)))
			end
			if MonsterData == 48527 then --贵妇
				MonsterDoMove(sceneId,MonsterId,188,85)
			end
			if MonsterData == 48530 then --女孩
				MonsterDoMove(sceneId,MonsterId,188,87)
			end
			if MonsterData == 48529 then --男孩
				MonsterDoMove(sceneId,MonsterId,188,88)
			end
			if MonsterData == 48528 then --丫鬟
				MonsterDoMove(sceneId,MonsterId,188,89)
			end
		end
	end
	--发送全屏提示
	CallScriptFunction(x891068_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210304_08}")
end
--**********************************
--对话框提示
--**********************************
function x891068_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

