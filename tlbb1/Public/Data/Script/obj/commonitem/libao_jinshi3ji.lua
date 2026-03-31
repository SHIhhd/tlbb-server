--晶石3级礼盒
x891123_g_scriptId = 891123

x891123_g_itemids = 
{
	[1] = {50302002, 50302001, 50302003, 50302004},  --晶石3级礼盒
}
x891123_g_boxType = 0
--晶石3级礼盒得ID
x891123_g_ItemID = 38002221;
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x891123_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x891123_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891123_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	--打开客户端
	BeginUICommand( sceneId )
		UICommand_AddInt(sceneId,1)
	EndUICommand( sceneId)
	DispatchUICommand( sceneId, selfId, 89112301 )
	return 0
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x891123_OnDeplete( sceneId, selfId )
	if LuaFnDepletingUsedItem( sceneId, selfId ) > 0 then
		return 1
	end
	return 0
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x891123_OnActivateOnce( sceneId, selfId )
	return 1
end

--**********************************
--客户端入口
--**********************************
function x891123_OnSelectItem(sceneId,selfId,nSelect)
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nBagPos)
	--检测是否正确物品
	if nItemId ~= x891123_g_ItemID then
		return
	end
	--不知道官方这个写法多此一举是干嘛，但是根据官方得客户端规划来做吧，没准以后加东西呢。
	x891123_g_boxType = 1
	local tPrizeTable = x891123_g_itemids[x891123_g_boxType];
	if tPrizeTable == nil then
		return
	end
	if nSelect < 1 or nSelect > getn(tPrizeTable) then
		x891123_NotifyFailTips(sceneId,selfId,"#{YNZJ_210127_19}")
		return
	end
	--背包空间检测
	BeginAddItem(sceneId)
	AddBindItem(sceneId,tPrizeTable[nSelect],1)
	if EndAddItem(sceneId,selfId) <= 0 then
		x891123_NotifyFailTips(sceneId,selfId,"#{YNZJ_210127_20}")
		return
	end
	--给东西
	AddItemListToHuman(sceneId,selfId)
	--礼包销毁
	LuaFnDelAvailableItem(sceneId,selfId,nItemId,1)
	--提示
	x891123_NotifyFailTips(sceneId,selfId,
		ScriptGlobal_Format("#{YNZJ_210127_21}",
		GetItemName(sceneId,tPrizeTable[nSelect]
	)))
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	--数据清零
	x891123_g_boxType = 0
	--UI关闭
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,0)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89112301 )
end

--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x891123_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x891123_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
