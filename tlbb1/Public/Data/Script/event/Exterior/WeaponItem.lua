--幻饰武器

--脚本号
x999904_g_scriptId = 999904
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x999904_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x999904_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x999904_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local nExteriorID = LuaFnGetExteriorWeaponID(itemTblIndex)
	if nExteriorID < 0 then
		x999904_NotifyTips( sceneId, selfId, format("蠢蛋策划没给%s加表，请马上联系客服",GetItemName(sceneId,itemTblIndex)) )
		return 0
	end
	--HSWQ_20220607_09	#H已拥有永久的%s0，无须再次激活。	
	local bHave = LuaFnIsHaveExteriorWeapon(sceneId,selfId,nExteriorID)
	if bHave == 1 then
		local nLeftTime = LuaFnGetExteriorWeaponLeftTime(sceneId,selfId,nExteriorID)
		if nLeftTime == -1 then
			x999904_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{HSWQ_20220607_09}",GetItemName(sceneId,itemTblIndex)) )
			return 0
		end
	end
	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x999904_OnDeplete( sceneId, selfId )
--	if LuaFnDepletingUsedItem( sceneId, selfId ) > 0 then
--		return 1
--	end
	return 1
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x999904_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local itemBagIndex = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nExteriorID,nAddTime = LuaFnGetExteriorWeaponID(itemTblIndex)
	if nExteriorID < 0 then
		x999904_NotifyTips( sceneId, selfId, format("蠢蛋策划没给%s加表，请马上联系客服",GetItemName(sceneId,itemTblIndex)) )
		return 0
	end
	local nLeftTime = LuaFnGetExteriorWeaponLeftTime(sceneId,selfId,nExteriorID)
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,itemBagIndex)
		UICommand_AddInt( sceneId,itemTblIndex)
		UICommand_AddInt( sceneId,nExteriorID)
		UICommand_AddInt( sceneId,nLeftTime)
		UICommand_AddInt( sceneId,nAddTime)
    EndUICommand( sceneId )
    DispatchUICommand( sceneId, selfId, 99990401 )   
	return 1
end
--**********************************
--幻饰武器激活确认
--**********************************
function x999904_OnConfirm( sceneId, selfId,BagIndex,itemId )
	local nItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, BagIndex );
	if nItemID ~= itemId then
		return
	end
	--物品可用性
	if LuaFnIsItemAvailable( sceneId, selfId,BagIndex) ~= 1 then
		return
	end
	local nExteriorID,nAddLimitTime = LuaFnGetExteriorWeaponID(itemId)

	if nExteriorID < 0 then
		return
	end
	local nLeftTime = LuaFnGetExteriorWeaponLeftTime(sceneId,selfId,nExteriorID)
	--激活幻饰武器
	LuaFnActiveExteriorWeapon(sceneId,selfId,BagIndex)
	x999904_NotifyTips( sceneId, selfId, "#{HSWQ_20220607_13}" )
	
	--HSWQ_20220607_14	#H幻饰武器：%s0的有效期增加%s1天。
	--HSWQ_20220607_17	#H幻饰武器：%s0已可永久使用。
	--时间提示
	local nLeftTime = LuaFnGetExteriorWeaponLeftTime(sceneId,selfId,nExteriorID)
	if nLeftTime == -1 then
		x999904_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{HSWQ_20220607_17}",GetItemName(sceneId,itemId)) )
	else
		local nAddDay = floor(nAddLimitTime / 86400)
		x999904_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{HSWQ_20220607_14}",GetItemName(sceneId,itemId),tostring(nAddDay)) )
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end
--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x999904_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x999904_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
