--雾隐宝匣
--脚本号
x505025_g_scriptId = 505025 --临时写这个,真正用的时候一定要改.

--需要的等级
x505025_g_levelRequire = 1
--AE范围半径
x505025_g_radiusAE = 6.0
--AE的目标关系标记
x505025_g_standFlag = 3 -- 3:任何人 2:队友， 1：友军， -1：敌军
--AE影响数目限制
x505025_g_effectCount = 6 -- -1:不限制
--效果的ID
x505025_g_Impact1 = 47566 --临时写这个
x505025_g_Impact2 = -1 --不用

--**********************************
--事件交互入口
--**********************************
function x505025_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x505025_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x505025_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x505025_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	if(0<=targetId) then
		-- 目标必须是友军的检测
--		if(1~=LuaFnUnitIsFriend(sceneId, selfId, targetId)) then
--			SendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- 目标必须是敌军的检测
--		if(1~=LuaFnUnitIsEnemy(sceneId, selfId, targetId)) then
--			SendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- 目标必须是队友的检测
--		if(1~=LuaFnUnitIsPartner(sceneId, selfId, targetId)) then
--			SendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
		-- 目标级别的检测
--		if(g_LevelRequire<=LuaFnGetLevel(sceneId, targetId)) then
--			SendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end
--		if(g_LevelRequire>=LuaFnGetLevel(sceneId, targetId)) then
--			SendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
--			return 0;
--		end

	end
	
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x505025_OnDeplete( sceneId, selfId )
	if(LuaFnDepletingUsedItem(sceneId, selfId)) then
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
function x505025_OnActivateOnce( sceneId, selfId )
	if(-1~=x505025_g_Impact1) then
		--给自己加效果
--		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x505025_g_Impact1, 0);
		--给目标加效果
--		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
--		if(0<=targetId) then
--			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x505025_g_Impact1, 0);
--		end
		--自己周围AE
		local posX,posZ = LuaFnGetUnitPosition(sceneId, selfId)
		LuaFnSendImpactAroundPosition(sceneId, selfId, posX, posZ, x505025_g_radiusAE, x505025_g_standFlag, x505025_g_levelRequire, x505025_g_effectCount, x505025_g_Impact1, 0)
		--指定地点周围AE
--		local posX,posZ = LuaFnGetTargetPosition(sceneId, selfId)
--		LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x505025_g_radiusAE, x505025_g_standFlag, x505025_g_levelRequire, x505025_g_effectCount, x505025_g_Impact1, 0)
		--目标个体周围AE
--		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
--		if(0<=targetId) then
--			local posX,posZ = LuaFnGetUnitPosition(sceneId, targetId)
--			LuaFnSendImpactAroundPosition(sceneId, selfID, posX, posZ, x505025_g_radiusAE, x505025_g_standFlag, x505025_g_levelRequire, x505025_g_effectCount, x505025_g_Impact1, 0)
--		end
		--SFDJ_240117_73	雾隐宝匣使用成功！	
		BeginEvent(sceneId)
			AddText(sceneId,"#{SFDJ_240117_73}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x505025_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
