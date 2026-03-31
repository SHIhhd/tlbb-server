--周任务
--组装十方轮

x890087_g_ScriptId = 890087
x890087_g_MinLevel = 85
x890087_g_TransBuff = {
	[0] = 45509,
	[1] = 45508,
}
x890087_g_MissionId = 2133
x890087_g_SceneID=1292
x890087_g_NeedPosX = 78
x890087_g_NeedPosZ = 150
x890087_g_MaxCreateNum = 512
--参数1空
x890087_g_MissionCreate = 2
--**********************************
--条件检测
--**********************************
function x890087_OnConditionCheck( sceneId, selfId )
	if sceneId ~= x890087_g_SceneID then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_359}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890087_g_MinLevel then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_41}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890087_g_TransBuff[nSelfSex]) ~= 1 then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_42}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890087_g_MissionId) <= 0 then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_42}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890087_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId,misIndex, 0 )
	if isFinish > 0 then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_358}" )
		return 0
	end
	local isCreated = GetMissionParam( sceneId, selfId,misIndex, x890087_g_MissionCreate )
	if isCreated > 0 then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_360}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, selfId);
	local distSqNpcToPlayer = (selfPosX - x890087_g_NeedPosX) * (selfPosX - x890087_g_NeedPosX) + (selfPosZ - x890087_g_NeedPosZ) * (selfPosZ - x890087_g_NeedPosZ);
	if distSqNpcToPlayer >= 9 then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_543}" )
		return 0
	end
	--总量限制在512个
	local nShiFangLunNum = 0
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == 50903 or MosDataID == 50904 then
			nShiFangLunNum = nShiFangLunNum + 1
		end
	end
	if nShiFangLunNum >= x890087_g_MaxCreateNum then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_361}" )
		return 0
	end
	
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890087_SkillOnUnitOne(sceneId,selfId, nSkillId)
	--创建十方轮
	local PosX, PosY = LuaFnGetWorldPos( sceneId, selfId )
	local nMonsterObj = CreateMonsterWithDir(sceneId,50903,PosX + 1,PosY + 1,3,-1,890130,33)
	if nMonsterObj < 0 then
		x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_361}" )
		return
	end
	--存在5分钟
	SetCharacterDieTime(sceneId, nMonsterObj, 1000*60*8)	
	--记录创建者GUID
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,0,LuaFnGetGUID(sceneId,selfId))
	--您拼装好了十方轮，请开始修理。	
	x890087_NotifyTip( sceneId, selfId, "#{BLCC_20221214_362}" )
end

--**********************************
--醒目提示
--**********************************
function x890087_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end