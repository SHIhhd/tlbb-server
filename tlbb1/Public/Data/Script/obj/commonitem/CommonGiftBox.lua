--通用礼包
--礼包内容在../Public/Config/CommonGiftBox.txt中配置

x998255_g_scriptId = 998255

--**********************************
--事件交互入口
--**********************************
function x998255_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998255_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998255_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x998255_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
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
function x998255_OnDeplete( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local bFind,nMustCount,nRate10000Count,nRateT10000Count = LuaFnGetCommonGiftBoxInfo(itemTblIndex)
	if bFind ~= 1 then
		x998255_Tip(sceneId,selfId,"物品非法");
		return 0 
	end
	
	LuaFnBeginAddItem( sceneId )
	--放入临时物品容器
	for i = 1,nMustCount do
		local nItemId,nItemNum,bMustItem = LuaFnGetCommonGiftBoxMustItem(itemTblIndex,i - 1)
		if nItemId > 0 then
			if bMustItem == 1 then
				LuaFnAddBindItem( sceneId, nItemId,nItemNum)
			else
				LuaFnAddItem( sceneId, nItemId, nItemNum)
			end
		end
	end
	--放入概率物品，程序生成保证随机器游程足够
	local nItemId,nItemNum = LuaFnGetCommonGiftBoxRateT10000Item(itemTblIndex)
	if nItemId > 0 then
		LuaFnAddItem( sceneId, nItemId, nItemNum)
	end
	--放入固定概率物品，程序生成保证随机器游程足够
	local nItemId,nItemNum = LuaFnGetCommonGiftBoxRate10000Item(itemTblIndex)
	if nItemId > 0 then
		LuaFnAddItem( sceneId, nItemId, nItemNum)
	end
	if LuaFnEndAddItem( sceneId, selfId, 1 ) <= 0 then
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x998255_Tip(sceneId,selfId,ScriptGlobal_Format("#{TYLB_20220809_04}",tostring(iBase)));
		end
		if iMat ~= nil and iMat > 0 then
			x998255_Tip(sceneId,selfId,ScriptGlobal_Format("#{TYLB_20220809_05}",tostring(iMat)));
		end
		return 0 
	end
	
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
function x998255_OnActivateOnce( sceneId, selfId )
	LuaFnAddItemListToHuman(sceneId,selfId)
	--打印获得的物品
	local nItemCount = LuaFnGetItemListCount(sceneId)
	for i = 0,nItemCount - 1 do
		local nItemNum,nItemId = LuaFnGetItemListItem(sceneId,i)
		if nItemNum > 0 then
			x998255_Tip(sceneId,selfId,ScriptGlobal_Format("#{TYLB_20220809_06}",tostring(nItemNum),GetItemName(sceneId,nItemId)));
		end
	end
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 151, 0)

	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998255_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x998255_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end