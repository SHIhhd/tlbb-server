-- 扫荡金币
x890290_g_scriptId = 890290
x890290_g_tItem = 
{
	[38002972] = 50000,
	[38002973] = 100000,
	[38002974] = 150000,
	[38002975] = 200000,
	[38002976] = 250000,
	[38002977] = 300000,
}
x890290_g_Max = 1000000000
--**********************************
--事件交互入口
--**********************************
function x890290_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x890290_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x890290_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x890290_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	if x890290_g_tItem[itemTblIndex] == nil then
	    return 0
	end
	local _,_,_,_,_,Jinbidaibi,YinbiDaibi = LuaFnGetSecKillData(sceneId,selfId)
	if Jinbidaibi >= x890290_g_Max then
		x890290_ShowNotice(sceneId,selfId,"#{JBSD_230919_04}")
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
function x890290_OnDeplete( sceneId, selfId )
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
function x890290_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x890290_g_tItem[itemTblIndex] == nil then
	    return 0
	end
	local _,_,_,_,_,Jinbidaibi,YinbiDaibi = LuaFnGetSecKillData(sceneId,selfId)
	local nCanGet = Jinbidaibi + x890290_g_tItem[itemTblIndex]
	if nCanGet >= x890290_g_Max then
		nCanGet = x890290_g_Max
	end
	LuaFnSetSecKillJinBi(sceneId,selfId,nCanGet)
	
	x890290_ShowNotice(sceneId,selfId,
		ScriptGlobal_Format("#{JBSD_230919_06}",
		x890290_g_tItem[itemTblIndex]
		))
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x890290_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x890290_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
