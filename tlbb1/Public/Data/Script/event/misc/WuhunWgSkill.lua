--幻魂装填
x888801_g_ScriptId = 888801
--**********************************
--条件检测入口
--**********************************
function x888801_OnConditionCheck( sceneId, selfId )
	return 1;
end
--**********************************
--技能释放完毕
--**********************************
function x888801_SkillOnUnitOne( sceneId, selfId, nSkillId )
	--3238是填入的技能ID，有硬编码
	if nSkillId ~= 3238 then
		return
	end
	local nSlotPos,nWhWgId = LuaFnGetWHWGCallUpInfo(sceneId,selfId)
	local nSlod_0 = LuaFnGetWHWGInSlot(sceneId,selfId,0)
	local nSlod_1 = LuaFnGetWHWGInSlot(sceneId,selfId,1)
	--填入前，先检测是否有相同类型的WGID
	if nSlod_0 == nWhWgId then
		LuaFnActiveWhWgSlot(sceneId,selfId,0,0)
	end
	if nSlod_1 == nWhWgId then
		LuaFnActiveWhWgSlot(sceneId,selfId,1,0)
	end
	local nValid,bUnlock,szName = LuaFnGetWHWGInfo(sceneId,selfId,nWhWgId)
	if nValid == nil or nValid == 0 then
		return
	end
	if bUnlock ~= 1 then
		return
	end
	local nCurGrade,nCurLevel = LuaFnGetWHWGLevelInfo(sceneId,selfId,nWhWgId)
	if nCurGrade == 0 and nCurLevel == 0 then
		return
	end
	--填入
	LuaFnActiveWhWgSlot(sceneId,selfId,nSlotPos,nWhWgId)
	x888801_NotifyTip( sceneId, selfId, "#{WH_210223_09}" )
	
	if HaveKfsEquiped(sceneId,selfId) ~= 1 then
		x888801_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{WH_210223_10}", szName))
	end
	local nKfsCompLevel = LuaFnGetEquipedKfsCompLevel(sceneId,selfId)
	if nKfsCompLevel < 5 then
		x888801_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{WH_210223_10}", szName))
	else
		--WH_210223_11	#H幻魂：%s0（%s1阶%s2级）已生效。	
		x888801_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{WH_210223_11}", szName,tostring(nCurGrade),tostring(nCurLevel)))
	end
end

--**********************************
--醒目提示
--**********************************
function x888801_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end