--灵蚕丝卷道具
---===================================================
x340026_g_scriptId = 340026

--**********************************
--事件交互入口
--**********************************
function x340026_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x340026_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x340026_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x340026_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if itemTblIndex ~= 38000960 then
		x340026_Tip(sceneId,selfId,"物品非法");
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
function x340026_OnDeplete( sceneId, selfId )
--	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
--		return 1;
--	end
	return 1;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x340026_OnActivateOnce( sceneId, selfId )
	local Itemid = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	if LuaFnGetMaterialBagSpace( sceneId, selfId) < 1  then
		x340026_Tip( sceneId, selfId,"#{DWJJ_240329_207}" ) --H请保证您的材料栏有1个空位
		return 		 
	end
	--给250个
	local nNumber = GetBagItemParam(sceneId,selfId,nBagPos,4,2)
	if nNumber > 250 then
		BeginAddItem(sceneId)
			AddItem( sceneId, 20310174, 250 )--绑定的
		EndAddItem(sceneId,selfId)
		AddItemListToHuman(sceneId,selfId)
		--DWJJ_240329_206	灵蚕丝卷使用成功，获得250个灵蚕丝，灵蚕丝卷内还剩余%s0个灵蚕丝。	
		x340026_Tip( sceneId, selfId,ScriptGlobal_Format("#{DWJJ_240329_206}",nNumber - 250) )
		SetBagItemParam(sceneId,selfId,nBagPos,4,2,nNumber - 250)
		--刷新Client端的背包物品信息
		LuaFnRefreshItemInfo( sceneId, selfId, nBagPos )
	else
		BeginAddItem(sceneId)
			AddItem( sceneId, 20310174, nNumber )--绑定的
		EndAddItem(sceneId,selfId)
		AddItemListToHuman(sceneId,selfId)
		--DWJJ_240329_208	灵蚕丝卷使用成功，获得%s0个灵蚕丝。	
		x340026_Tip( sceneId, selfId,ScriptGlobal_Format("#{DWJJ_240329_208}",nNumber) )
		LuaFnEraseItem(sceneId,selfId,nBagPos)
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x340026_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x340026_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end