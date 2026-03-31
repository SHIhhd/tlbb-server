--仙灵鹤武礼盒
x998542_g_scriptId = 998542
x998542_g_SetItem = 
{
	--绑定
	[38003017] = {ui = 99854201,tItem = {38003019, 38003020, 38003021, 38003022}},
	--不绑定
	[38003018] = {ui = 99854201,tItem = {38003019, 38003020, 38003021, 38003022}},
}
--**********************************
--事件交互入口
--**********************************
function x998542_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998542_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998542_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x998542_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local itemSn = LuaFnGetItemIndexOfUsedItem(sceneId, selfId);
	if x998542_g_SetItem[itemSn] == nil then
		x998542_Tips(sceneId,selfId,"#{QXHB_20210701_277}")
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
function x998542_OnDeplete( sceneId, selfId )
--	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
--	end
--	return 0;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x998542_OnActivateOnce( sceneId, selfId )
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId)
	local itemSn = LuaFnGetItemIndexOfUsedItem(sceneId, selfId);
	if x998542_g_SetItem[itemSn] ~= nil then
		BeginUICommand( sceneId )
			UICommand_AddInt(sceneId,nBagPos)
			UICommand_AddInt(sceneId,x998542_g_scriptId)
		EndUICommand( sceneId)
		DispatchUICommand(sceneId,selfId,x998542_g_SetItem[itemSn].ui)
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998542_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
--**********************************
--武器选择完成
--**********************************
function x998542_OnWeaponChoice( sceneId, selfId,nBagPos,nSelect)
	if GetLevel(sceneId,selfId) < 15 then
		x998542_Tips(sceneId,selfId,"#{QXHB_20210701_284}")
		return
	end
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	if x998542_g_SetItem[nItemId] == nil then
		x998542_Tips(sceneId,selfId,"#{QXHB_20210701_277}")
		return
	end
	if x998542_g_SetItem[nItemId].tItem[nSelect] == nil then
		x998542_Tips(sceneId,selfId,"#{QXHB_20210701_296}")
		return
	end
	-- 背包道具栏有空间？
	if LuaFnGetPropertyBagSpace(sceneId, selfId) < 1 then
		x998542_Tips(sceneId,selfId,"#{QXHB_20210701_287}")
		return	
	end
	BeginAddItem(sceneId)
	if nItemId == 38003017 then
		AddBindItem( sceneId, x998542_g_SetItem[nItemId].tItem[nSelect], 1 )
	else
		AddItem( sceneId, x998542_g_SetItem[nItemId].tItem[nSelect], 1 )
	end
	
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	AddItemListToHuman(sceneId,selfId)
	
	LuaFnEraseItem(sceneId,selfId,nBagPos)
	
	x998542_Tips(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20210701_308}",tostring(1),GetItemName(sceneId,x998542_g_SetItem[nItemId].tItem[nSelect])))
	
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 49, 0 )
end

--**********************************
--提示信息
--**********************************
function x998542_Tips(sceneId,selfId,tip)
    BeginEvent(sceneId)
		AddText(sceneId,tip)
 	EndEvent(sceneId)
 	DispatchMissionTips(sceneId,selfId)
end