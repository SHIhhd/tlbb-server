--琉璃灵玑幻魂残篇礼包
--脚本号
x888802_g_scriptId = 888802
x888802_g_ItemInfo = 
{
	[38002229] = 20800003,
	[38002230] = 20800003,
	[38002231] = 20800001,
	[38002232] = 20800001,
}
--**********************************
--事件交互入口
--**********************************
function x888802_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x888802_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x888802_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x888802_OnConditionCheck( sceneId, selfId )
	if GetLevel(sceneId,selfId) < 80 then
		x888802_ShowNotice(sceneId,selfId,"#{WH_210223_193}")
		return 0
	end
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	--背包中的位置
	local	bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	if bagId < 0 then
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x888802_g_ItemInfo[itemTblIndex] == nil then
		return 0
	end
	if LuaFnLockCheck( sceneId, selfId, bagId, 0 ) < 0 then
		return 0
	end
	local nSizeData = 2
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local nItemInfo = {20800008,20800006,20800004,20800010}
	if x888802_g_ItemInfo[itemTblIndex] == nil then
		return 0
	end
	if nMaterialSize < nSizeData then
		x888802_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{WH_210223_157}",nSizeData))
		return 0
	end
	local nRandom = random(1,getn(nItemInfo))
	BeginAddItem(sceneId)
	AddItem( sceneId,x888802_g_ItemInfo[itemTblIndex],1)
	AddItem( sceneId,nItemInfo[nRandom],1)
	if EndAddItem(sceneId,selfId) <= 0 then
		x888802_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{WH_210223_157}",nSizeData))
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
function x888802_OnDeplete( sceneId, selfId )
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
function x888802_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local nItemInfo = {20800008,20800006,20800004,20800010}
	local nItemNum = 1
	if x888802_g_ItemInfo[itemTblIndex] == nil then
		return 0
	end
	local nSizeData = 2
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nMaterialSize < nSizeData then
		x888802_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{WH_210223_157}",nSizeData))
		return 0
	end
	local nRandom = random(1,getn(nItemInfo))
	BeginAddItem(sceneId)
	AddItem( sceneId,x888802_g_ItemInfo[itemTblIndex],nItemNum)
	AddItem( sceneId,nItemInfo[nRandom],nItemNum)
	if EndAddItem(sceneId,selfId) <= 0 then
		x888802_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{WH_210223_157}",nSizeData))
		return 0
	end
	--给东西
	AddItemListToHuman(sceneId,selfId)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,49,0)
	x888802_ShowNotice(sceneId,selfId,
		ScriptGlobal_Format("#{WH_210223_159}",
		nItemNum,
		GetItemName(sceneId,x888802_g_ItemInfo[itemTblIndex])
	))
	
	x888802_ShowNotice(sceneId,selfId,
		ScriptGlobal_Format("#{WH_210223_160}",
		nItemNum,
		GetItemName(sceneId,nItemInfo[nRandom])
	))
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x888802_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x888802_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
