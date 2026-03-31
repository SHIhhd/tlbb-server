--御马令

--脚本号
x999905_g_scriptId = 999905
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x999905_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x999905_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x999905_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	if GetLevel(sceneId,selfId) < 15 then
		x999905_NotifyTips( sceneId, selfId, "#{ZJYK_231019_09}")
		return 0
	end
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x999905_NotifyTips( sceneId, selfId, "#{ZJYK_231019_10}")
		return 0
	end
	if LuaFnIsStalling(sceneId,selfId) == 1 then
		x999905_NotifyTips( sceneId, selfId, "#{ZJYK_231019_11}")
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local itemBagIndex = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	if LuaFnIsItemLocked(sceneId, selfId, itemBagIndex) == 1 then
		x999905_NotifyTips( sceneId, selfId, "#{ZJYK_231019_12}")
		return 0
	end
	local nCid,nLeftTime = LuaFnGetRideCardItemLeftTime(itemTblIndex)
	if nCid == -1 then
		return 0
	end
	local iActivedFlag = LuaFnGetRideCardActivedFlag(sceneId,selfId,nCid)
	if iActivedFlag == 1 then
		local left_time = LuaFnGetRideCardLeftTime(sceneId,selfId,nCid)
		if left_time + nLeftTime * 60 - LuaFnGetCurrentTime() >= 365*24*60*60 then		
			x999905_NotifyTips(sceneId,selfId,"#{ZJYK_231019_14}")
			return 0
		end
	end
	--目前只有一种
	--ZJYK_231019_13	#H您最多激活5种御马令。	
	
	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x999905_OnDeplete( sceneId, selfId )
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
function x999905_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local itemBagIndex = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,itemBagIndex)
		UICommand_AddInt( sceneId,itemTblIndex)
    EndUICommand( sceneId )
    DispatchUICommand( sceneId, selfId, 99990501 )   
	return 1
end
--**********************************
--激活确认
--**********************************
function x999905_OnConfirm( sceneId, selfId,BagIndex,itemId )
	local nItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, BagIndex );
	if nItemID ~= itemId then
		return
	end
	--物品可用性
	if LuaFnIsItemAvailable( sceneId, selfId,BagIndex) ~= 1 then
		return
	end
	--相关校验在程序进行，不再额外增加其他注册
	local nAddLimitTime = LuaFnExteriorUseRideCard(sceneId,selfId,BagIndex)
	--使用成功了
	if nAddLimitTime == -1 then
		x999905_NotifyTips(sceneId,selfId,"有错误，请联系客服")
	else
		local strAddTime = ""
		if nAddLimitTime >= 1440 then
			local nAddDay = floor(nAddLimitTime / 1440)
			strAddTime = ScriptGlobal_Format("#{ZJYK_231019_20}", tostring(nAddDay))
		end
		x999905_NotifyTips(sceneId,selfId,strAddTime)
		--销毁身上的御马令
		LuaFnEraseItem(sceneId,selfId,BagIndex)
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end
--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x999905_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x999905_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
