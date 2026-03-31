--江湖盟会-个人技能-集合哨
--脚本号
x998711_g_scriptId = 998711

--是否检查盟会身份
x998711_g_CheckIdentity = 0
--传送技能效果
x998711_g_TransfSkill = 120
--**********************************
--事件交互入口
--**********************************
function x998711_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998711_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998711_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x998711_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	--检测当前盟会
	if x998711_g_CheckIdentity == 1 then
		local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
		if nCurIdentityId ~= IDENTITY_ENGINEER_IDX then
			--SFDJ_240117_170	当前所在盟会不符合，无法使用此道具。	
			BeginEvent(sceneId)
				AddText(sceneId,"#{SFDJ_240117_170}");
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		end
	end
	if GetTeamSize(sceneId,selfId) < 1  then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SFDJ_240117_50}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 0
	end
	if GetTeamSize(sceneId,selfId) < 2  then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SFDJ_240117_51}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 0
	end
	if LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SFDJ_240117_52}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 0
	end
	
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x998711_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x998711_OnActivateOnce( sceneId, selfId )
	--程序通知相关邀请信息
	LuaFnAskTransTeamMemeberToNearPoistion(sceneId,selfId)
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998711_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--*****************************************************
--客户端触发
--*****************************************************
function x998711_ActivateFromClient( sceneId, selfId )
	
end
--*************************************************
--清理使用CD
--*************************************************
function x998711_ResetJiHeShaoSkillCD( sceneId, selfId )
	
end
--*************************************************
--确认传送自身
--*************************************************
function x998711_TransferMe( sceneId, selfId )
	--检查当前是否能传送
--	摆摊状态下无法传送。	
	if LuaFnIsStalling(sceneId,selfId) == 1 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_61}")
		return
	end 
--	骑乘状态下无法传送。
	if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_62}")
		return
	end
	if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
		x998711_NotifyTip(sceneId,selfId,"#{MPSD_220622_97}")
		return
	end
--	变身状态下无法传送。	
	if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_63}")
		return
	end
--	SFDJ_240117_64	处于富甲天下状态下无法传送。	
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_66}")
		return
	elseif LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113) == 1 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_65}")
		return
	end
--	死亡状态下无法传送。	
	if LuaFnIsCharacterLiving(sceneId,selfId) ~= 1 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_67}")
		return
	end
--	组队跟随状态下无法传送。
	if IsTeamFollow(sceneId,selfId) == 1 then
		x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_68}")
		return
	end 
	--正在传送中，请勿进行其他操作。	
	x998711_NotifyTip(sceneId,selfId,"#{SFDJ_240117_69}")
	--调用释放相关技能
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	local nCurDir = GetObjDir(sceneId,selfId)
	LuaFnHumanScriptUseSkill(sceneId,selfId,x998711_g_TransfSkill,selfId,nCurPosX,nCurPosZ,nCurDir)
end
--**********************************
--信息提示
--**********************************
function x998711_NotifyTip( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

