--周任务
--修理十方轮

x890088_g_ScriptId = 890088
x890088_g_MinLevel = 85
x890088_g_TransBuff = {
	[0] = 45509,
	[1] = 45508,
}
x890088_g_MissionId = 2133
x890088_g_SceneID=1292
--**********************************
--条件检测
--**********************************
function x890088_OnConditionCheck( sceneId, selfId,targetId )
	if sceneId ~= x890088_g_SceneID then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_359}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890088_g_MinLevel then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_41}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890088_g_TransBuff[nSelfSex]) ~= 1 then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_42}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890088_g_MissionId) <= 0 then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_42}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890088_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId,misIndex, 0 )
	if isFinish > 0 then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_364}" )
		return 0
	end
	local MosDataID = GetMonsterDataID(sceneId,targetId)
	if MosDataID ~= 50903 then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_494}" )
		return 0
	end
	if LuaFnGetNpcIntParameter(sceneId,targetId,0) ~= LuaFnGetGUID(sceneId,selfId) then
		x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_363}" )
		return 0
	end
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890088_SkillOnUnitOne(sceneId,selfId, nSkillId)
end
--**********************************
--引导等动作结束后会回调此入口
--**********************************
function x890088_OnActionFinished( sceneId, selfId, targetId )	
	--设置任务完成
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890088_g_MissionId )
	SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
	--创建一个修理好的机器
	local MosDataID = GetMonsterDataID(sceneId,targetId)
	if MosDataID == 50903 then
--		local PosX, PosY = LuaFnGetWorldPos( sceneId, targetId )
--		local Dir = GetObjDir(sceneId,targetId)
		LuaFnDeleteMonster(sceneId,targetId)
--		local nMonsterObj = CreateMonsterWithDir(sceneId,50904,PosX, PosY,3,-1,890130,Dir)
--		if nMonsterObj >= 0 then
--			SetObjDir(sceneId,nMonsterObj,Dir)
--			--设置30s后销毁
--			SetCharacterDieTime(sceneId, nMonsterObj, 1000*30)	
--		end
	end
	
	x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_49}" )
end
--**********************************
--技能被中断
--**********************************
function x890088_SkillOnInterrupt(sceneId,selfId, nSkillId )
	x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_44}" )
end
--**********************************
--技能被取消
--**********************************
function x890088_SkillOnCancel(sceneId,selfId, nSkillId )
	x890088_NotifyTip( sceneId, selfId, "#{BLCC_20221214_44}" )
end
--**********************************
--醒目提示
--**********************************
function x890088_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end