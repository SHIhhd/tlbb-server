--新版本引导任务设计-新增自选礼包
x998831_g_scriptId = 998831

--奇纹镏金箱
x998831_g_PayBox = 38003156
x998831_g_NeedPayYuanBao = 4000
--锦叶纹艺匣
x998831_g_FreeGift = 38003157
x998831_g_FreeGiftItem_List = {10,15,17,18}
--沉木纹艺匣
x998831_g_PayedGift = 38003158
--需要完成的任务限制
x998831_g_NeedMission = 2269

--**********************************
--事件交互入口
--**********************************
function x998831_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998831_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998831_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x998831_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	if IsMissionHaveDone(sceneId,selfId,x998831_g_NeedMission) <= 0 then
		x998831_ShowNotice( sceneId, selfId,"#{QEYD_240402_111}")
		return
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local bagpos = LuaFnGetBagIndexOfUsedItem( sceneId, selfId)
	if itemTblIndex == x998831_g_FreeGift then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddInt( sceneId, bagpos )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99883102 )
	elseif itemTblIndex == x998831_g_PayedGift then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddInt( sceneId, bagpos )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99883103 )
	elseif itemTblIndex == x998831_g_PayBox then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddInt( sceneId, bagpos )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99883101 )
	end
	return 0; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x998831_OnDeplete( sceneId, selfId )
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
function x998831_OnActivateOnce( sceneId, selfId )
	
	return 0;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998831_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--选择领取物品
--**********************************
function x998831_GiveAward( sceneId, selfId,nIndex,nBagPos)
	if IsMissionHaveDone(sceneId,selfId,x998831_g_NeedMission) ~= 1 then
		x998831_ShowNotice( sceneId, selfId,"#{QEYD_240402_111}")
		return
	end
	if GetLevel(sceneId,selfId) < 50 then
		x998831_ShowNotice( sceneId, selfId,"#{QEYD_240402_110}")
		return
	end
	
	local itemTblIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nBagPos )
	if itemTblIndex == x998831_g_FreeGift then
		--免费的4奖励宝箱
		if x998831_g_FreeGiftItem_List[nIndex] == nil or x998831_g_FreeGiftItem_List[nIndex] < 0 then
			return
		end
		--获取具体的奖励内容
		local itemid, itemnum, itemname = LuaFnGetZXGiftInfo(x998831_g_FreeGiftItem_List[nIndex])
		if  itemid == nil then
			return
		end
		--QEYD_240402_115	#H您的道具背包空间不足，请至少空出%s0个道具栏位。	
		--QEYD_240402_116	#H您的材料背包空间不足，请至少空出%s0个材料栏位。	
		BeginAddItem(sceneId)
		AddItem(sceneId,itemid,itemnum)
		if EndAddItem(sceneId,selfId,1) <= 0 then
			local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
			if iBase ~= nil and iBase > 0 then
				x998831_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_115}",tostring(iBase)))
			end
			if iMat ~= nil and iMat > 0 then
				x998831_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_116}",tostring(iMat)))
			end
			return
		end
		--给物品
		AddItemListToHuman(sceneId,selfId)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--扣除选定物品
		LuaFnDelAvailableItem(sceneId,selfId,itemTblIndex,1)
		--关闭客户端UI
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, 1 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99883102 )
	elseif itemTblIndex == x998831_g_PayedGift then
		--收费的多选1宝箱
		local itemid, itemnum, itemname = LuaFnGetZXGiftInfo(nIndex - 100)
		if itemid == nil then
			return
		end
		--QEYD_240402_115	#H您的道具背包空间不足，请至少空出%s0个道具栏位。	
		--QEYD_240402_116	#H您的材料背包空间不足，请至少空出%s0个材料栏位。	
		BeginAddItem(sceneId)
		AddItem(sceneId,itemid,itemnum)
		if EndAddItem(sceneId,selfId,1) <= 0 then
			local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
			if iBase ~= nil and iBase > 0 then
				x998831_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_115}",tostring(iBase)))
			end
			if iMat ~= nil and iMat > 0 then
				x998831_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_116}",tostring(iMat)))
			end
			return
		end
		--给物品
		AddItemListToHuman(sceneId,selfId)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--扣除选定物品
		LuaFnDelAvailableItem(sceneId,selfId,itemTblIndex,1)
		--关闭客户端UI
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, 1 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99883103 )
	end
end
--**********************************
--领取付费物品
--**********************************
function x998831_GiveGiftBox( sceneId, selfId,nBagPos)
	if IsMissionHaveDone(sceneId,selfId,x998831_g_NeedMission) ~= 1 then
		x998831_ShowNotice( sceneId, selfId,"#{QEYD_240402_111}")
		return
	end
	if GetLevel(sceneId,selfId) < 50 then
		x998831_ShowNotice( sceneId, selfId,"#{QEYD_240402_110}")
		return
	end
	if LuaFnGetAvailableItemCount(sceneId,selfId,x998831_g_PayBox) < 1 then
		return
	end
	--检查元宝
	local nCurYB = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYB < x998831_g_NeedPayYuanBao then
		x998831_ShowNotice( sceneId, selfId,"#{QEYD_240402_156}")
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,x998831_g_NeedPayYuanBao) ~= 1 then
		x998831_ShowNotice( sceneId, selfId,"#{SWXT_221213_252}")
		return
	end
	BeginAddItem(sceneId)
	AddItem(sceneId,38003158,2)
	if EndAddItem(sceneId,selfId,1) <= 0 then
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x998831_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_115}",tostring(iBase)))
		end
		if iMat ~= nil and iMat > 0 then
			x998831_ShowNotice(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_116}",tostring(iMat)))
		end
		return
	end
	--扣除元宝
	LuaFnCostYuanBao(sceneId,selfId,x998831_g_NeedPayYuanBao,998831,"GiveGiftBox",0,-1);
	--给物品
	AddItemListToHuman(sceneId,selfId)
	--扣除选定物品
	LuaFnDelAvailableItem(sceneId,selfId,x998831_g_PayBox,1)
	--关闭客户端UI
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 99883101 )
	--特效显示
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
end
--**********************************
--屏幕中心提示
--**********************************
function x998831_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
