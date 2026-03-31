--周任务
--组装臂甲

x890095_g_ScriptId = 890095
x890095_g_MinLevel = 85
x890095_g_TransBuff = {
	[0] = 45521,
	[1] = 45520,
}
x890095_g_MissionId = 2147
x890095_g_SceneID=1294
x890095_g_NeedPosX = 71
x890095_g_NeedPosZ = 121
x890095_g_MaxCreateNum = 512
--参数1空
x890095_g_MissionCreate = 2
--**********************************
--条件检测
--**********************************
function x890095_OnConditionCheck( sceneId, selfId )
	if sceneId ~= x890095_g_SceneID then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_343}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890095_g_MinLevel then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_41}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890095_g_TransBuff[nSelfSex]) ~= 1 then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_535}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890095_g_MissionId) <= 0 then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_535}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890095_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId,misIndex, 0 )
	if isFinish > 0 then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_378}" )
		return 0
	end
	local isCreated = GetMissionParam( sceneId, selfId,misIndex, x890095_g_MissionCreate )
	if isCreated > 0 then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_374}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, selfId);
	local distSqNpcToPlayer = (selfPosX - x890095_g_NeedPosX) * (selfPosX - x890095_g_NeedPosX) + (selfPosZ - x890095_g_NeedPosZ) * (selfPosZ - x890095_g_NeedPosZ);
	if distSqNpcToPlayer >= 9 then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_545}" )
		return 0
	end
	--总量限制在512个
	local nShiFangLunNum = 0
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == 50917 or MosDataID == 50918 then
			nShiFangLunNum = nShiFangLunNum + 1
		end
	end
	if nShiFangLunNum >= x890095_g_MaxCreateNum then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_375}" )
		return 0
	end
	
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890095_SkillOnUnitOne(sceneId,selfId, nSkillId)
	--创建十方轮
	local PosX, PosY = LuaFnGetWorldPos( sceneId, selfId )
	local nMonsterObj = CreateMonsterWithDir(sceneId,50917,PosX + 1,PosY + 1,3,-1,890131,33)
	if nMonsterObj < 0 then
		x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_375}" )
		return
	end
	--存在5分钟
	SetCharacterDieTime(sceneId, nMonsterObj, 1000*60*8)	
	--记录创建者GUID
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,0,LuaFnGetGUID(sceneId,selfId))
	--您拼装好了臂甲，请开始修理。	
	x890095_NotifyTip( sceneId, selfId, "#{BLCC_20221214_376}" )
end

--**********************************
--醒目提示
--**********************************
function x890095_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end