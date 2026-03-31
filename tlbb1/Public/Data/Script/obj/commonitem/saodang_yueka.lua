--百战征龙令
x891194_g_scriptId = 891194

x891194_g_MinLevel = 60

x891194_g_ItemTableIndex = 38000206
--**********************************
--事件交互入口
--**********************************
function x891194_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x891194_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x891194_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891194_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	if GetLevel(sceneId,selfId) < x891194_g_MinLevel then
		x891194_ShowNotice( sceneId, selfId, "#{TQJF_221108_05}")
		return 0
	end
	local tqmfmonth = GetMissionFlag(sceneId,selfId,MF_TQSD_MONTHCARD)
	local tqmfday = GetMissionFlag(sceneId,selfId,MF_TQSD_DAYCARD)
	if tqmfmonth == 1 or tqmfday == 1 then
		x891194_ShowNotice( sceneId, selfId, "#{TQJF_221108_06}")
		return 0
	end
	--组队跟随状态
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x891194_ShowNotice(sceneId,selfId,"#{TQJF_221108_19}")
		return 0
	end
	--摆摊
	if LuaFnIsStalling( sceneId, selfId ) == 1 then
		x891194_ShowNotice(sceneId,selfId,"#{TQJF_221108_20}")
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
function x891194_OnDeplete( sceneId, selfId )
	return 1;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x891194_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	if itemTblIndex ~= x891194_g_ItemTableIndex then
		return 0;
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89119501 )
	return 0;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x891194_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--激活特权月卡
--**********************************
function x891194_ConfirmOpenTeQuan( sceneId, selfId )

	local itemTblIndex = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	if itemTblIndex ~= x891194_g_ItemTableIndex then
		return
	end
	if GetLevel(sceneId,selfId) < x891194_g_MinLevel then
		x891194_ShowNotice( sceneId, selfId, "#{TQJF_221108_29}")
		return
	end
	local itemBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	if LuaFnIsItemAvailable( sceneId, selfId, itemBagPos ) ~= 1 then
		x891194_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{TQJF_221108_30}",GetItemName(sceneId,itemTblIndex)))
		return
	end
	--组队跟随状态
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x891194_ShowNotice(sceneId,selfId,"#{TQJF_221108_19}")
		return
	end
	--摆摊
	if LuaFnIsStalling( sceneId, selfId ) == 1 then
		x891194_ShowNotice(sceneId,selfId,"#{TQJF_221108_20}")
		return
	end
	
	LuaFnEraseItem(sceneId,selfId,itemBagPos)
	
	SetMissionFlag(sceneId,selfId,MF_TQSD_MONTHCARD,1)
	SetMissionData(sceneId,selfId,MD_TQSD_DATA,LuaFnGetCurrentDateTime());
	
	x891194_ShowNotice(sceneId,selfId,"#{TQJF_221108_22}")
	
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89106202 )
	
end

function x891194_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
