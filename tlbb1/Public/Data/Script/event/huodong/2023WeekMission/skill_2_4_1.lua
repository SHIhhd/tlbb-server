--周任务
--组装水幕摇柄

x890091_g_ScriptId = 890091
x890091_g_MinLevel = 85
x890091_g_TransBuff = {
	[0] = 45515,
	[1] = 45514,
}
x890091_g_MissionId = 2140
x890091_g_SceneID=1293
x890091_g_NeedPosX = 65
x890091_g_NeedPosZ = 174
x890091_g_MaxCreateNum = 512
--参数1空
x890091_g_MissionCreate = 2
--**********************************
--条件检测
--**********************************
function x890091_OnConditionCheck( sceneId, selfId )
	if sceneId ~= x890091_g_SceneID then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_342}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x890091_g_MinLevel then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_41}" )
		return 0
	end
	local nSelfSex = GetSex(sceneId,selfId)
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x890091_g_TransBuff[nSelfSex]) ~= 1 then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_527}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x890091_g_MissionId) <= 0 then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_527}" )
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890091_g_MissionId )
	local isFinish = GetMissionParam( sceneId, selfId,misIndex, 0 )
	if isFinish > 0 then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_365}" )
		return 0
	end
	local isCreated = GetMissionParam( sceneId, selfId,misIndex, x890091_g_MissionCreate )
	if isCreated > 0 then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_367}" )
		return 0
	end
	local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, selfId);
	local distSqNpcToPlayer = (selfPosX - x890091_g_NeedPosX) * (selfPosX - x890091_g_NeedPosX) + (selfPosZ - x890091_g_NeedPosZ) * (selfPosZ - x890091_g_NeedPosZ);
	if distSqNpcToPlayer >= 9 then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_544}" )
		return 0
	end
	--总量限制在512个
	local nShiFangLunNum = 0
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == 50910 or MosDataID == 50911 then
			nShiFangLunNum = nShiFangLunNum + 1
		end
	end
	if nShiFangLunNum >= x890091_g_MaxCreateNum then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_368}" )
		return 0
	end
	
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x890091_SkillOnUnitOne(sceneId,selfId, nSkillId)
	--创建十方轮
	local PosX, PosY = LuaFnGetWorldPos( sceneId, selfId )
	local nMonsterObj = CreateMonsterWithDir(sceneId,50910,PosX + 1,PosY + 1,3,-1,890131,33)
	if nMonsterObj < 0 then
		x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_368}" )
		return
	end
	--存在5分钟
	SetCharacterDieTime(sceneId, nMonsterObj, 1000*60*8)	
	--记录创建者GUID
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,0,LuaFnGetGUID(sceneId,selfId))
	--您拼装好了水幕摇柄，请开始修理。	
	x890091_NotifyTip( sceneId, selfId, "#{BLCC_20221214_369}" )
end

--**********************************
--醒目提示
--**********************************
function x890091_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end