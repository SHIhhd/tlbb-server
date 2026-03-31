--武魂用lua
--脚本号
x809271_g_ScriptId = 809271
--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x809271_OnConditionCheck( sceneId, selfId )
	return 1;
end

--**********************************
--技能释放完毕
--**********************************
function x809271_SkillOnUnitOne( sceneId, selfId, nSkillId )

	x809271_NotifyMsg( sceneId, selfId, "#{WH_210223_09}" )
	for i = 0,1 do
		local nSlodWhWgId = LuaFnGetWHWGInSlot(sceneId,selfId,i)
		if nSlodWhWgId > 0 then
			local nValid,bUnlock,szName = LuaFnGetWHWGInfo(sceneId,selfId,nSlodWhWgId)
			if nValid ~= nil and nValid == 1 then
				if bUnlock == 1 then
					local nCurGrade,nCurLevel = LuaFnGetWHWGLevelInfo(sceneId,selfId,nSlodWhWgId)
					
					if HaveKfsEquiped(sceneId,selfId) ~= 1 then
						x809271_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{WH_210223_10}", szName))
					end
					local nKfsCompLevel = LuaFnGetEquipedKfsCompLevel(sceneId,selfId)
					if nKfsCompLevel < 5 then
						x809271_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{WH_210223_10}", szName))
					else
						--WH_210223_11	#H幻魂：%s0（%s1阶%s2级）已生效。	
						x809271_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{WH_210223_11}", szName,tostring(nCurGrade),tostring(nCurLevel)))
					end
					
				end
				
			end
			
		end
	end
end
--**********************************
--信息提示
--**********************************
function x809271_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
