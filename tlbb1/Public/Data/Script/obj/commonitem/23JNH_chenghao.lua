--称号：梦起天龙 与你湘聚
---===================================================
x998520_g_scriptId = 998520
x998520_g_Item = 38002962
x998520_g_MinLevel = 30
x998520_g_TitleId = 1309
--**********************************
--事件交互入口
--**********************************
function x998520_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998520_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998520_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x998520_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x998520_g_Item ~= itemTblIndex then
		x998520_Tip(sceneId,selfId,"物品非法");
		return 0 
	end
	if GetLevel(sceneId,selfId) < x998520_g_MinLevel then
		x998520_Tip(sceneId,selfId,"#{QXCH_230719_1}");
		return 0 
	end
	local retCanAddTitle = LuaFnCanAddTitle( sceneId, selfId, x998520_g_TitleId )
	if ( retCanAddTitle ~= 1 ) then
		if ( retCanAddTitle == 0 ) then
			--称号已存在
			x998520_Tip( sceneId,selfId,ScriptGlobal_Format("#{QXCH_230719_2}",LuaFnGetTitleNameById(x998520_g_TitleId)) )
			return 0
		else
			return 0
		end
	end
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x998520_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 1;
end
--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x998520_OnActivateOnce( sceneId, selfId )
	LuaFnAwardCharTitle( sceneId, selfId, x998520_g_TitleId )
	LuaFnSetCurTitleById( sceneId, selfId, x998520_g_TitleId )
	LuaFnDispatchAllTitle(sceneId, selfId)
	x998520_Tip( sceneId, selfId, ScriptGlobal_Format("#{QXCH_230719_3}",LuaFnGetTitleNameById(x998520_g_TitleId)) ) 
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0) --成功的buff标记

	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998520_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x998520_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end