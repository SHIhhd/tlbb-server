--身份系统-个人技能-集合哨
--脚本号
x998718_g_ScriptId = 998718
--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x998718_OnConditionCheck( sceneId, selfId )
	--检查当前是否能传送
--	摆摊状态下无法传送。	
	if LuaFnIsStalling(sceneId,selfId) == 1 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_61}")
		return 0
	end 
--	骑乘状态下无法传送。
	if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_62}")
		return 0
	end
	if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
		x998718_NotifyMsg(sceneId,selfId,"#{MPSD_220622_97}")
		return 0
	end
--	变身状态下无法传送。	
	if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_63}")
		return 0
	end
--	SFDJ_240117_64	处于富甲天下状态下无法传送。	
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_66}")
		return 0
	elseif LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113) == 1 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_65}")
		return 0
	end
--	死亡状态下无法传送。	
	if LuaFnIsCharacterLiving(sceneId,selfId) ~= 1 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_67}")
		return 0
	end
--	组队跟随状态下无法传送。
	if IsTeamFollow(sceneId,selfId) == 1 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_68}")
		return 0
	end 
	return 1;
end

--**********************************
--技能释放完毕
--**********************************
function x998718_SkillOnUnitOne( sceneId, selfId, nSkillId )
	if x998718_OnConditionCheck( sceneId, selfId ) == 0 then
		return
	end
	local destScene,descPosX,destPosZ = LuaFnGetTransTeamMemeberToNearPoistion(sceneId,selfId)
	if destScene == nil or destScene == -1 then
		x998718_NotifyMsg(sceneId,selfId,"#{SFDJ_240117_68}")
		return
	end
	--传送
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, destScene, descPosX,destPosZ, 1 );
end
--**********************************
--信息提示
--**********************************
function x998718_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
