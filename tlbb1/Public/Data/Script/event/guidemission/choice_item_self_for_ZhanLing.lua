--战令用雕纹36选一礼包

x999262_g_scriptId = 999262
x999262_g_GiftBoxId = 38003165
--**********************************
--事件交互入口
--**********************************
function x999262_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x999262_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x999262_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x999262_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if itemTblIndex ~= x999262_g_GiftBoxId then
		x999262_ShowNotice( sceneId, selfId, "数据错误")
		return
	end
	local bagpos = LuaFnGetBagIndexOfUsedItem( sceneId, selfId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )
		UICommand_AddInt( sceneId, 0 )
		UICommand_AddInt( sceneId, bagpos )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 99926201 )
	
	return 0; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x999262_OnDeplete( sceneId, selfId )
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
function x999262_OnActivateOnce( sceneId, selfId )
	
	return 0;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x999262_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--选择领取物品
--**********************************
function x999262_GiveAward( sceneId, selfId,nSelect,nBagPos)
	
	local itemTblIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nBagPos )
	if x999262_g_GiftBoxId ~= itemTblIndex then
		return
	end
	local itemid, itemnum, itemname = LuaFnGetZXGiftInfo(nSelect - 100)
	if itemid == nil then
		return
	end
	BeginAddItem(sceneId)
	AddItem( sceneId, itemid, itemnum)
	if EndAddItem(sceneId,selfId,1) <= 0 then
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x999262_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_115}",tostring(iBase)))
		end
		if iMat ~= nil and iMat > 0 then
			x999262_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_116}",tostring(iMat)))
		end
		return
	end
	AddItemListToHuman(sceneId,selfId)
	x999262_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{DWJJ_240329_342}",GetItemName(sceneId,itemid)))
	--扣除
	LuaFnEraseItem( sceneId, selfId, nBagPos )
	--给特效
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0);

	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )
		UICommand_AddInt( sceneId, 1 )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 99926201 )
end

--**********************************
--显示特殊信息
--**********************************
function x999262_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
