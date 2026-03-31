--萧峰金色分身解救技能逻辑

--脚本号
x998463_g_ScriptId	= 998463
--副本逻辑脚本号....
x998463_g_FuBenScriptId = 998445
x998463_g_CopySceneData_Level = 11			--副本的等级
x998463_g_CopySceneData_InitLevel = 12		--副本创建等级
--萧峰部分状态变量
x998463_IDX_Golden				= 2
--**********************************
--条件检测
--**********************************
function x998463_OnConditionCheck( sceneId, selfId )
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x998463_NotifyTip( sceneId, selfId, "#{YMMJ_230626_190}" )
		return 0
	end
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x998463_SkillOnUnitOne(sceneId,selfId, nSkillId)
	--检查分身还存在与否
	local bExist = 0
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == 51560 then
			--自动消亡时间
			SetCharacterDieTime(sceneId, MonsterId,3000)
			bExist = 1
			break
		end
	end
	if bExist ~= 1 then
		x998463_NotifyTip( sceneId, selfId, "#{YMMJ_230626_188}" )
		return
	end
	--寻找萧峰进行操作
	nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)		
		if GetName(sceneId,MonsterId) == "萧峰心魔" then
			local nGolden = MonsterAI_GetIntParamByIndex(sceneId, MonsterId, x998463_IDX_Golden)
			MonsterAI_SetIntParamByIndex(sceneId, MonsterId, x998463_IDX_Golden,nGolden + 1)
		end
	end
	--YMMJ_230626_192	成功解救清罡分身，所有人魔厄邪气减1层。清罡正气加1层，4层可让boss进入混乱状态,受到伤害增多。	
	x998463_NotifyTip( sceneId, selfId, "#{YMMJ_230626_192}" )
end
--**********************************
--技能被中断
--**********************************
function x998463_SkillOnInterrupt(sceneId,selfId, nSkillId )

end
--**********************************
--技能被取消
--**********************************
function x998463_SkillOnCancel(sceneId,selfId, nSkillId )

end

--**********************************
--对话框提示
--**********************************
function x998463_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

