--天龙666财富卡<ID:30505080>
--脚本号 889935

x889935_g_scriptId = 889935

--**********************************
--事件交互入口
--**********************************
function x889935_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x889935_IsSkillLikeScript( sceneId, selfId )
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x889935_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x889935_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if 1~=LuaFnVerifyUsedItem(sceneId, selfId) then
		return 0
	end
	local ItemId = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	if ItemId ~= 30505080 then
		return 0
	end
	if GetMissionFlag(sceneId,selfId,MF_ActiveNewUserCard666) == 1 then
		--TLWS_20200908_20	您已经激活了%s0，无法重复激活！	
		x889935_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{TLWS_20200908_20}",GetItemName(sceneId,30505080)))
		return 0
	end
	if GetLevel(sceneId,selfId) >= 30 then
		--TLWS_20200908_22	您的等级过高，无法激活%s0！
		x889935_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{TLWS_20200908_22}",GetItemName(sceneId,30505080)))
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
function x889935_OnDeplete( sceneId, selfId )
	if 0<LuaFnDepletingUsedItem(sceneId, selfId) then
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
function x889935_OnActivateOnce( sceneId, selfId )
	--您已成功激活%s0，达到对应等级后可前往大理（151，167）都大爽处领取奖励。
	--"#{TLWS_20200908_69}"
	
	SetMissionFlag( sceneId, selfId, MF_ActiveNewUserCard666, 1 )
	x889935_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{TLWS_20200908_69}",GetItemName(sceneId,30505080)))
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x889935_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x889935_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
