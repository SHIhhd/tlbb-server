--时装染色
--脚本号
x830001_g_scriptId = 830001
x830001_HongYaoShiItemID = 30503140 --红曜石ID
x830001_DressPraintNeedMoney = 50000

--**********************************
--染色成功
--**********************************
function x830001_OnSuccDressPaint( sceneId, selfId, nPos,nCheck )
	
end
--**********************************
--开始染色
--**********************************
function x830001_OnAutoDressPaint( sceneId, selfId, nPos,nFirst )
	--是否是第一次自动染色  为了区别显示不同内容  1 代表第一次 0不是
	local PlayerMoney = GetMoney( sceneId, selfId ) +  GetMoneyJZ(sceneId, selfId)
	if PlayerMoney < x830001_DressPraintNeedMoney then
		x830001_Tips( sceneId, selfId, "#{YJRS_140613_11}" )
		x830001_StopRefreshToClient( sceneId, selfId )
		return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, x830001_HongYaoShiItemID) < 1 then
		x830001_Tips( sceneId, selfId, "#{YJRS_140613_12}" )
		x830001_StopRefreshToClient( sceneId, selfId )
		return
	end
	x830001_OnDressPaint_OK( sceneId, selfId, nPos,1)
end
--**********************************
--开始染色
--**********************************
function x830001_OnDressPaint( sceneId, selfId, nPos,nYuanBaoCheck )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
    if not nPos or nYuanBaoCheck == nil or nYuanBaoCheck > 1 or nYuanBaoCheck < 0 then
	    return
	end
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nPos )
	if EquipPoint ~= HEQUIP_DRESS then
		x830001_Tips( sceneId, selfId, "#{SZPR_091023_17}")
		return
	end
	ret = LuaFnIsItemAvailable( sceneId, selfId, nPos )
	if ret ~= 1 then
		x830001_Tips( sceneId, selfId, "#{SZPR_091023_18}")
		return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, x830001_HongYaoShiItemID) < 1 then
		--元宝快捷购买
		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,2,x830001_HongYaoShiItemID,nYuanBaoCheck)
		if nNeedMoney ~= nil then
		
			local strTips = ScriptGlobal_Format("#{SZRSYH_120912_02}",
			tostring(x830001_HongYaoShiItemID),tostring(nNeedMoney),"#{XFYH_20120221_10}","#{XFYH_20120221_12}",tostring(x830001_HongYaoShiItemID))
			
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 2 )
				UICommand_AddInt( sceneId, nMoneyUnit )
				UICommand_AddInt( sceneId, nNeedMoney )
				UICommand_AddInt( sceneId, itemIndex )
				UICommand_AddInt( sceneId, 0 )
				UICommand_AddInt( sceneId, x830001_g_scriptId )
				UICommand_AddInt( sceneId, nYuanBaoCheck )
				UICommand_AddInt( sceneId, -1 )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddString(sceneId,strTips)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20120222 )
		else
			x830001_Tips(sceneId,selfId,"#{SZPR_091023_21}")
		end
		return
	end
	x830001_OnDressPaint_OK( sceneId, selfId, nPos,0)--直接走
end
--**********************************
--时装染色流程
--**********************************
function x830001_OnDressPaint_OK( sceneId, selfId, pos,isAuto)
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, pos )
	if EquipPoint ~= HEQUIP_DRESS then
		x830001_Tips( sceneId, selfId, "#{SZPR_091023_17}" )
		return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, x830001_HongYaoShiItemID) < 1 then
		if isAuto == 1 then
			x830001_Tips( sceneId, selfId, "#{YJRS_140613_13}" )
			x830001_StopRefreshToClient( sceneId, selfId )
		else
			x830001_Tips( sceneId, selfId, "#{SZPR_091023_21}" )
		end
		return
	end
	local PlayerMoney = GetMoney( sceneId, selfId ) +  GetMoneyJZ(sceneId, selfId)
	if PlayerMoney < x830001_DressPraintNeedMoney then
		x830001_Tips( sceneId, selfId, "#{YJRS_140613_14}" )
		x830001_StopRefreshToClient( sceneId, selfId )
		return
	end
	--进入染色流程
	LuaFnDelAvailableItem(sceneId,selfId,x830001_HongYaoShiItemID,1) --材料扣除
	LuaFnCostMoneyWithPriority(sceneId, selfId, x830001_DressPraintNeedMoney) --扣钱
	--执行染色
	LuaFnDoDressPaint(sceneId,selfId,pos);
	--send impact
	--LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 151, 0)
	x830001_Tips( sceneId, selfId, "#{SZPR_091023_23}")
	--英雄大会埋点
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,10541) == 1 then
		AddHerosReturnsRecoed(sceneId,selfId,11)
	end
	--通知客户端染色成功
	x830001_RefreshSuccessToClient( sceneId, selfId )
	x830001_StopRefreshToClient( sceneId, selfId )
end

--**********************************
--通知客户端染色成功
--**********************************
function x830001_RefreshSuccessToClient( sceneId, selfId )
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 091109 )
end

--**********************************
--通知客户端终止染色
--**********************************
function x830001_StopRefreshToClient( sceneId, selfId )
--	BeginUICommand( sceneId )
--	EndUICommand( sceneId )
--	DispatchUICommand( sceneId, selfId, 091113 )
end

--**********************************
--提示信息
--**********************************
function x830001_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end