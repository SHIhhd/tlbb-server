-- 兽魂染色

-- 脚本号
x998506_g_ScriptId = 998506;
x998506_g_MinLevel = 85
x998506_g_Item = 30503154
x998506_g_NeedMoney = 50000
--**********************************
-- 请求染色
--**********************************
function x998506_OnPossPaint(sceneId, selfId,targetId, nSelectPlan,nCurSelExteriorID,bOk,bYuanBaoPay)
	if GetLevel(sceneId,selfId) < x998506_g_MinLevel then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_30}" )
		return
	end
	if sceneId ~= SCENE_SUZHOU then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_31}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_32}" )
		return
	end
	if nSelectPlan < 1 or nSelectPlan > 3 then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_33}" )
		return
	end
	if LuaFnIsCanRanSe(nCurSelExteriorID) ~= 1 then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_34}" )
		return
	end
	--判定金钱是否足够
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < x998506_g_NeedMoney then
        x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_38}" )
		return
	end
	--判定数量是不是够的
	if LuaFnGetAvailableItemCount(sceneId, selfId, x998506_g_Item) < 1 then
		--元宝快捷购买
		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,15,x998506_g_Item,bYuanBaoPay)
		if nNeedMoney ~= nil then
		
			local strTips = ScriptGlobal_Format("#{RSYH_231120_11}",
			GetItemName(sceneId,x998506_g_Item),tostring(nNeedMoney))
			
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 15 )
				UICommand_AddInt( sceneId, nMoneyUnit )
				UICommand_AddInt( sceneId, nNeedMoney )
				UICommand_AddInt( sceneId, itemIndex )
				UICommand_AddInt( sceneId, 0 )
				UICommand_AddInt( sceneId, x998506_g_ScriptId )
				UICommand_AddInt( sceneId, bYuanBaoPay )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddString(sceneId,strTips)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 99850605 )
		else
			x998506_ShowTips( sceneId, selfId,"#{SHRS_230621_37}")
		end
		return
	end
	--SHRS_230621_36	正使用的魂录绘色风格无法进行绘色。	
	local nColor = LuaFnGetRanSeColorItem(sceneId,selfId,nCurSelExteriorID, nSelectPlan - 1)
	local nCurUsePlan = LuaFnGetPlanInUsing(sceneId,selfId)
	if floor(nCurUsePlan / 10) == nColor then
--		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_36}" )
--		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId, selfId, x998506_g_NeedMoney)
	--扣除材料
	LuaFnDelAvailableItem(sceneId,selfId,x998506_g_Item,1)
	--染色
	local nActivePlanId = LuaFnTryUnlockRanse(sceneId,selfId,nCurSelExteriorID, nSelectPlan - 1)
	local _,_,_,_,strPossName = LuaFnGetExteriorPossTableInfo(sceneId,selfId,nCurSelExteriorID)
	local strPlanName = LuaFnGetRanSePlanName(nCurSelExteriorID, nActivePlanId)
	
	x998506_ShowTips( sceneId, selfId,"#{SHRS_230621_39}")
	x998506_ShowTips( sceneId, selfId,ScriptGlobal_Format("#{SHRS_230621_40}",strPossName,strPlanName))
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	--特殊公告
	local nRanSeQual = LuaFnGetQualityForRanSe(nCurSelExteriorID,nActivePlanId)
	if nRanSeQual ~= nil and nRanSeQual >= 3 then
		BroadMsgByChatPipe( sceneId, selfId, ScriptGlobal_Format("#{SHRS_230621_164}",
			GetName(sceneId,selfId),strPossName,strPlanName), 4 )
	end
end
--**********************************
-- 自动染色
--**********************************
function x998506_OnAutoRanSe(sceneId, selfId, targetId, nSelectPlan,nCurSelExteriorID,bIsFirstAuto)
	if GetLevel(sceneId,selfId) < x998506_g_MinLevel then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_30}" )
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	if sceneId ~= SCENE_SUZHOU then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_31}" )
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_32}" )
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	if nSelectPlan < 1 or nSelectPlan > 3 then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_33}" )
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	if LuaFnIsCanRanSe(nCurSelExteriorID) ~= 1 then
		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_34}" )
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	--判定金钱是否足够
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < x998506_g_NeedMoney then
        if bIsFirstAuto == 1 then
			x998506_ShowTips( sceneId, selfId,"#{SHRS_230621_155}")
		else
			x998506_ShowTips( sceneId, selfId,"#{SHRS_230621_158}")
		end
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	--判定数量是不是够的
	if LuaFnGetAvailableItemCount(sceneId, selfId, x998506_g_Item) < 1 then
		if bIsFirstAuto == 1 then
			x998506_ShowTips( sceneId, selfId,"#{SHRS_230621_156}")
		else
			x998506_ShowTips( sceneId, selfId,"#{SHRS_230621_157}")
		end
		--终止自动染色
		x998506_StopClientAuto(sceneId, selfId)
		return
	end
	--SHRS_230621_36	正使用的魂录绘色风格无法进行绘色。	
	local nColor = LuaFnGetRanSeColorItem(sceneId,selfId,nCurSelExteriorID, nSelectPlan - 1)
	local nCurUsePlan = LuaFnGetPlanInUsing(sceneId,selfId)
	if floor(nCurUsePlan / 10) == nColor then
--		x998506_ShowTips( sceneId, selfId, "#{SHRS_230621_36}" )
		--终止自动染色
--		x998506_StopClientAuto(sceneId, selfId)
--		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId, selfId, x998506_g_NeedMoney)
	--扣除材料
	LuaFnDelAvailableItem(sceneId,selfId,x998506_g_Item,1)
	--染色
	local nActivePlanId = LuaFnTryUnlockRanse(sceneId,selfId,nCurSelExteriorID, nSelectPlan - 1)
	--告知自动结果
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nActivePlanId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 99850603 )
	
	--特殊公告
	local nRanSeQual = LuaFnGetQualityForRanSe(nCurSelExteriorID,nActivePlanId)
	if nRanSeQual ~= nil and nRanSeQual >= 3 then
		local _,_,_,_,strPossName = LuaFnGetExteriorPossTableInfo(sceneId,selfId,nCurSelExteriorID)
		local strPlanName = LuaFnGetRanSePlanName(nCurSelExteriorID, nActivePlanId)
	
		BroadMsgByChatPipe( sceneId, selfId, ScriptGlobal_Format("#{SHRS_230621_164}",
			GetName(sceneId,selfId),strPossName,strPlanName), 4 )
	end
end
--**********************************
-- 终止自动染色
--**********************************
function x998506_StopClientAuto(sceneId, selfId)
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 99850601 )
	
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 99850603 )
end

--**********************************
-- 成功染色
--**********************************
function x998506_OnSuccRanSe(sceneId, selfId, nSelectPlan,nCurSelExteriorID)
	
end

--**********************************
-- 提示信息
--**********************************
function x998506_ShowTips(sceneId, selfId, tipMsg)
	BeginEvent(sceneId);
		AddText(sceneId, tipMsg);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
