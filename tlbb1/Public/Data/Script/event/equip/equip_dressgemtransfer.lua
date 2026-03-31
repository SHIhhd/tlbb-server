--时装配饰转移
x888805_g_ScriptId = 888805
--配饰乾坤符
x888805_g_TransItem = {20800018,20800019}

--**********************************
--列举事件
--**********************************
function x888805_DressGemTransfer( sceneId, selfId, nPosS,nPosT,bindConfrim,buyConfrim )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	--==================================
	--源时装检查
	--==================================
	--不是时装
	if LuaFnGetBagEquipType(sceneId, selfId, nPosS) ~= HEQUIP_DRESS then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_06}")	
		return
	end
	--加锁
	if LuaFnIsItemLocked(sceneId, selfId, nPosS) ~= 0 then
		x888805_NotifyTip( sceneId, selfId, "#{SZPSZY_160314_07}")
		return
	end
	--时装上没有配饰可以转移，无法进行放入
	local nHoleCount_A = GetBagGemCount( sceneId, selfId, nPosS )
	if nHoleCount_A < 1 then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_08}")	
		return
	end

	--时装上没有配饰可以转移，无法进行放入
	local nGemCount_A = GetGemEmbededCount( sceneId, selfId, nPosS )
	if nGemCount_A < 1 then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_08}")	
		return
	end
	--==================================
	--目标时装检查
	--==================================
	--不是时装
	if LuaFnGetBagEquipType(sceneId, selfId, nPosT) ~= HEQUIP_DRESS then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_06}")	
		return
	end

	--加锁
	if LuaFnIsItemLocked(sceneId, selfId, nPosT) ~= 0 then
		x888805_NotifyTip( sceneId, selfId, "#{SZPSZY_160314_07}")
		return
	end
	
	--该时装上没有配饰点缀位，无法进行配饰转移
	local nHoleCount_B = GetBagGemCount( sceneId, selfId, nPosT )
	if nHoleCount_B < 1 then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_11}")	
		return
	end

	--该时装上没有空的配饰点缀位，无法进行配饰转移
	local nGemCount_B = GetGemEmbededCount( sceneId, selfId, nPosT )
	if nGemCount_B >= nHoleCount_B then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_22}")	
		return
	end
	--==================================
	--转移前可用孔位检查
	--==================================	
	--对不起，对应转移的目标时装点缀位孔位不足
	if nHoleCount_B - nGemCount_B < nGemCount_A then
		x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_27}")
		return
	end
	--目标时装已镶嵌同类型时装配饰，无法进行配饰转移。
	for i = 1, nHoleCount_A do
		local nGem_Type_A = GetGemEmbededType(sceneId,selfId,nPosS, i - 1)		
		if nGem_Type_A > 0 then
		
			for j = 1 , nHoleCount_B do
				local nGem_Type_B = GetGemEmbededType(sceneId,selfId,nPosT, j - 1)			
				if LuaFnGetItemType( nGem_Type_A ) == LuaFnGetItemType( nGem_Type_B ) then
					x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_41}")
					return
				end
			end
		end
	end
	--==================================
	--材料检查
	--==================================
	local nMaterialNum = LuaFnMtl_GetCostNum(sceneId, selfId,x888805_g_TransItem[1],x888805_g_TransItem[2]);
	if nMaterialNum < 1 then
		--购买
		local nConvenientType = 7
		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,nConvenientType,x888805_g_TransItem[2],buyConfrim)
		if nNeedMoney == nil then
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 2 )			--DRESS_TRANSFER_BUYITEM_CONFIRM
			UICommand_AddInt( sceneId, -1 )			--nUniqueID
			UICommand_AddInt( sceneId, 1 )			--nNeedItemNum
			UICommand_AddInt( sceneId, 1 )			--nBuyNum
			UICommand_AddInt( sceneId, nNeedMoney )	--nPrice
			UICommand_AddInt( sceneId, nConvenientType )
			UICommand_AddInt( sceneId, nMoneyUnit )
			UICommand_AddInt( sceneId, itemIndex )
			UICommand_AddInt( sceneId, 0 )			--nSerialNum
			UICommand_AddInt( sceneId, buyConfrim )
		EndUICommand( sceneId )
		DispatchUICommandNew( sceneId, selfId, 3 )
		
		return
	end
	--==================================
	--绑定状态检查
	--==================================
	local nBindTarget = LuaFnGetItemBindStatus( sceneId, selfId, nPosS )
	if LuaFnGetItemBindStatus( sceneId, selfId, nPosT ) == 1 then
		nBindTarget = 0
	end
	if nBindTarget ==  1 and bindConfrim ~= 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )			--DRESS_TRANSFER_BIND_CONFIRM
			UICommand_AddInt( sceneId, -1 )
		EndUICommand( sceneId )
		DispatchUICommandNew( sceneId, selfId, 3 )
		return
	end
	--执行转移
	LuaFnDoGemDisplace(sceneId,selfId,nPosS,nPosT)
	--消耗材料
	LuaFnMtl_CostMaterial(sceneId,selfId,1,x888805_g_TransItem[1], x888805_g_TransItem[2]);
	--强绑目标物品
	if nBindTarget == 1 then
		LuaFnItemBind( sceneId, selfId, nPosT );
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	--提示客户端转移完成
	x888805_NotifyTip( sceneId, selfId,"#{SZPSZY_160314_52}")
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 3 )			--DRESS_TRANSFER_DONE
		UICommand_AddInt( sceneId, -1 )
	EndUICommand( sceneId )
	DispatchUICommandNew( sceneId, selfId, 3 )
	--随机上世界
	local strTransS = GetBagItemTransfer( sceneId, selfId, nPosS )
	local strTransT = GetBagItemTransfer( sceneId, selfId, nPosT )
	
	local strGlobal = ""
	if random(0,1) == 0 then
		strGlobal = ScriptGlobal_Format("#{SZPSZY_160314_35}",GetName(sceneId,selfId),strTransS,strTransT)
	else
		strGlobal = ScriptGlobal_Format("#{SZPSZY_160314_36}",GetName(sceneId,selfId),strTransS,strTransT)
	end
	AddGlobalCountNews(sceneId, strGlobal)
end
--**********************************
--信息提示
--**********************************
function x888805_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
