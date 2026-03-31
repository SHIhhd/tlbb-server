--珍兽装备鉴定
--build 2019-8-4 11:52:43
x809268_g_ScriptId = 809268
x809268_g_PetEquipAdjustTab = {2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22,23,24,25,30,40,50,60,80}
x809268_g_Tjs_idx = 30900061; --天晶砂
x809268_g_Tjc_idx = 30505267; --水晶锉
--*************************************************
--珍兽装备资质鉴定
--*************************************************
function x809268_FinishAdjust(sceneId,selfId,nPos)
	-- 判断是否为安全时间2019-8-4 11:52:37 
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x809268_Tips( sceneId, selfId, "#{OR_PILFER_LOCK_FLAG}" )	
		return
	end
	if nPos == nil then
		x809268_Tips(sceneId,selfId,"#{ZSZB_090421_20}");
		return
	end
	--看看是不是珍兽装备
	if IsPetEquip( sceneId, selfId, nPos ) ~= 1 then
		x809268_Tips(sceneId,selfId,"#{ZSZB_090421_19}");
		return
	end
	--检查是否加锁
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
		x809268_Tips( sceneId, selfId,"#{ZSYH_170111_82}" )
		return	
	end
	local ret = LuaFnIsPetEquipJudgeApt( sceneId, selfId, nPos )
	if ret == -1 then
		x809268_Tips( sceneId, selfId,"该物品不可用。" )
		return	
	end
	if ret == 1 then
		x809268_Tips( sceneId, selfId,"#{ZSZB_090421_23}" )
		return	
	end
	if ret == 2 then
		x809268_Tips( sceneId, selfId,"#{ZSZB_090421_21}" )
		return	
	end
	if ret == 3 then
		x809268_Tips( sceneId, selfId,"#{ZSZB_090421_22}" )
		return	
	end
	--计算金钱
	local Equip_Level = GetBagItemLevel(sceneId, selfId, nPos);
	local NeedMoney 
	if Equip_Level >= 1 and Equip_Level <= 9 then
		NeedMoney = 10 
	elseif Equip_Level >= 10 and Equip_Level <= 19 then
		NeedMoney = 100 
	elseif Equip_Level >= 20 and Equip_Level <= 29 then
		NeedMoney = 1000 
	elseif Equip_Level >= 30 and Equip_Level <= 39 then
		NeedMoney = 3000 
	elseif Equip_Level >= 40 and Equip_Level <= 49 then
		NeedMoney = 4000 
	elseif Equip_Level >= 50 and Equip_Level <= 59 then
		NeedMoney = 5000 
	elseif Equip_Level >= 60 and Equip_Level <= 69 then
		NeedMoney = 6000 
	elseif Equip_Level >= 70 and Equip_Level <= 79 then
		NeedMoney = 7000 
	elseif Equip_Level >= 80 and Equip_Level <= 89 then
		NeedMoney = 8000 
	elseif Equip_Level >= 90 and Equip_Level <= 99 then
		NeedMoney = 10000 
	elseif Equip_Level < 110 then
		NeedMoney = 20000
	elseif Equip_Level < 120 then
		NeedMoney = 30000
	else
		NeedMoney = 40000
	end
	--看看钱是不是够用
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < NeedMoney then
        x809268_Tips( sceneId, selfId,  "#{ZSYH_170111_84}" )
        return
	end
	local jiaoZi, jinBi = LuaFnCostMoneyWithPriority( sceneId, selfId, NeedMoney )
	if jiaoZi == -1 then
		x809268_Tips( sceneId, selfId,  "未知错误。" )
        return
	end
	ret = LuaFnPetEquipJudgeApt( sceneId, selfId, nPos )
	if ret == 1 then
		x809268_Tips( sceneId, selfId,  "#{ZSZB_090421_25}" );
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		return
	else
		x809268_Tips( sceneId, selfId,  "未知错误。" )
        return
	end
	
end

--*************************************************
--珍兽装备资质重新鉴定
--*************************************************
function x809268_FinishReAdjust(sceneId,selfId,nPos)
	-- 判断是否为安全时间2019-8-4 11:52:37 
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x809268_Tips( sceneId, selfId, "#{OR_PILFER_LOCK_FLAG}" )	
		return
	end
	if nPos == nil then
		x809268_Tips(sceneId,selfId,"#{ZSYH_170111_81}");
		return
	end
	--看看是不是珍兽装备
	if IsPetEquip( sceneId, selfId, nPos ) ~= 1 then
		x809268_Tips(sceneId,selfId,"#{ZSZB_090421_19}");
		return
	end
	--检查是否加锁
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
		x809268_Tips( sceneId, selfId,"#{ZSYH_170111_82}" )
		return	
	end
	local NeedMoney = GetBagItemLevel(sceneId, selfId, nPos) * 20 + 50;  
	--看看钱是不是够用
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < NeedMoney then
        x809268_Tips( sceneId, selfId,  "#{ZSYH_170111_84}" )
        return
	end
	--看看是不是有资质了
	local ret = LuaFnIsPetEquipJudgeApt( sceneId, selfId, nPos )
	if ret == -1 then
		x809268_Tips( sceneId, selfId,"该物品不可用。" )
		return	
	end
	if ret == 0 then
		x809268_Tips( sceneId, selfId,"#{ZSZB_090421_33}" )
		return	
	end
	--开始区分天晶砂和水晶锉
	local itemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x809268_g_Tjs_idx)
	local itemCount2 = LuaFnGetAvailableItemCount(sceneId, selfId, x809268_g_Tjc_idx)
	if itemCount < 1 and itemCount2 < 1 then
		x809268_Tips( sceneId, selfId,"#{ZSZB_090421_34}" )
		return	
	end
	--检查装备是否是绑定
	local ret = LuaFnGetItemBindStatus( sceneId, selfId, nPos )
	--扣除规则是：绑定优先，然后是天晶砂优先。也就扣除次序是绑定天晶砂，绑定水晶锉，天晶砂，水晶锉
	--找绑定天晶砂
	local ShaPos = GetBagPosByItemSnAvailableBind(sceneId, selfId, x809268_g_Tjs_idx, tonumber(1) )
	local needBind = 0
	if ret == 0 then
		if ShaPos ~= -1 then
			needBind = 1
		end
	end
	local ShaPos2 = -1
	if ShaPos == -1 then --找绑定水晶锉
		ShaPos2 = GetBagPosByItemSnAvailableBind(sceneId, selfId, x809268_g_Tjc_idx, tonumber(1))
	end
	if ret == 0 then
		if ShaPos2 ~= -1 then
			needBind = 1
		end
	end
	if ShaPos == -1 and ShaPos2 == -1 then --找天晶砂
		ShaPos = GetBagPosByItemSnAvailableBind(sceneId, selfId, x809268_g_Tjs_idx, tonumber(0))
	end
	if ShaPos == -1 and ShaPos2 == -1 then --找水晶锉
		ShaPos2 = GetBagPosByItemSnAvailableBind(sceneId, selfId, x809268_g_Tjc_idx, tonumber(0))
	end
	local ShaInfo = 0
	-- 扣天晶砂或水晶锉....
	if ShaPos ~= -1 then
		ShaInfo = GetBagItemTransfer( sceneId, selfId, ShaPos )
		LuaFnDelAvailableItem(sceneId,selfId,x809268_g_Tjs_idx,1)
--		ret = LuaFnEraseItem(sceneId, selfId, ShaPos)
--		if ret ~= 1 then
--			x809268_Tips( sceneId, selfId, "天晶砂不可用" )
--			return
--		end
	elseif ShaPos2 ~= -1 then
		ShaInfo = GetBagItemTransfer( sceneId, selfId, ShaPos2 )
		local r, t = LuaFnEraseItemTimes( sceneId, selfId, ShaPos2, 11 )
		x809268_Tips( sceneId, selfId, format( "水晶锉剩余使用次数%d/%d", tonumber(t), tonumber(11)))
	end
	--重新鉴定资质
	ret = LuaFnReSetPetEquipApt( sceneId, selfId, nPos )
	if ret == 1 then
		--扣钱
		LuaFnCostMoneyWithPriority( sceneId, selfId, NeedMoney )
		--给特效
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--绑定
		if needBind == 1 then
			LuaFnItemBind( sceneId, selfId, nPos )
		end
		
		x809268_Tips( sceneId, selfId, "#{ZSZB_090421_37}" )
	elseif ret == 2 or ret == 3 then --高级效果，要发公告
		--扣钱
		LuaFnCostMoneyWithPriority( sceneId, selfId, NeedMoney )
		--给特效
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--绑定
		if needBind == 1 then
			LuaFnItemBind( sceneId, selfId, nPos )
		end
		
		x809268_Tips( sceneId, selfId, "#{ZSZB_090421_37}" )

		--发公告....
		x809268_ReAdjustNotify( sceneId, selfId, ret, ShaPos, ShaPos2, ShaInfo, nPos )

		return
	end
end

--**********************************
--重新鉴定装备资质公告
--**********************************
function x809268_ReAdjustNotify( sceneId, selfId, ret, ShaPos, ShaPos2, ShaInfo, nEquItemIndex )

	local Name = GetName(sceneId, selfId)		
	local itemInfo = GetBagItemTransfer( sceneId, selfId, nEquItemIndex )
	local strText
	local nEquipID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nEquItemIndex )

	--如果资质洗到了250以上就会发洗出超级装备的公告....
	if ret == 3 then
		if ShaPos ~= -1 then
			--ZSZB_25	#{_INFOUSR%s0}#H在#G苏州（251，184）#R云雪儿#H处，使用#W#{_INFOMSG%s1}#H在#W#{_INFOMSG%s2}#H上轻轻地一磨，突然间光芒四射，一件绝世的超完美珍兽装备横空出世。	
			strText = ScriptGlobal_Format("#{ZSZB_25}",Name, ShaInfo, itemInfo)
			BroadMsgByChatPipe(sceneId,selfId, strText, 4)
		elseif ShaPos2 ~= -1 then
			--ZSZB_26	#{_INFOUSR%s0}#H在#G苏州（251，184）#R云雪儿#H处，用#W#{_INFOMSG%s1}#H来回的打磨着#W#{_INFOMSG%s2}#H，片刻后珍兽装备焕然一新，一件双完美的珍兽装备就此展现在众人面前。	
			strText = ScriptGlobal_Format("#{ZSZB_26}",Name, ShaInfo, itemInfo)
			BroadMsgByChatPipe(sceneId,selfId, strText, 4)
		end
	end

	--如果资质没有洗到了250以上....但也已经达到优秀....就会发洗出普通装备的公告....
	if ret == 2 then
		strText = format("#W#{_INFOUSR%s}#{ZSZB_7}#{_INFOMSG%s}#{ZSZB_8}#{_INFOMSG%s}#{ZSZB_9}", Name, itemInfo ,ShaInfo);
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end


end
--*************************************************
--屏幕中间对话提示
--*************************************************
function x809268_Tips( sceneId, selfId,msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end