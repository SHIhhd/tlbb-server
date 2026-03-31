--手工装备重洗
--脚本号
x888820_g_ScriptId = 888820
--可洗练装备点
x888820_g_Valid_ep = {1, 2, 3, 4, 5, 6, 7, 12, 14, 15}
--操作等级限制
x888820_g_LevelLimit = 60
--消耗材料
x888820_g_Need_Item_ID7 = 38003056
x888820_g_Need_Item_ID8 = 38003055
x888820_g_Need_Item_Count = 1

x888820_g_CostMoney = 200000
--**********************************
--属性切换
--**********************************
function x888820_SwitchEquipAttr( sceneId, selfId, nBagPos)
	
	local nRet = LuaFnSGZBSwitchEquipAttr(sceneId,selfId,nBagPos)
	if nRet == -1 then
		x888820_NotifyTip( sceneId, selfId, "#{SGCX_20231227_59}" )
		return
	elseif nRet == -2 then
		x888820_NotifyTip( sceneId, selfId, "#{SGCX_20231227_59}" )
		return
	elseif nRet == -3 then
		x888820_NotifyTip( sceneId, selfId, "#{SGCX_20231227_60}" )
		return
	elseif nRet == 1 then
		x888820_NotifyTip( sceneId, selfId, "#{SGCX_20231227_61}" )
	end
end

--**********************************
--属性重洗
--**********************************
function x888820_RefreshEquipAttr( sceneId, selfId, iBagIndex, bBindConfirm)
	if GetLevel(sceneId,selfId) < x888820_g_LevelLimit then
		return
	end
	--加锁
	if LuaFnIsItemLocked( sceneId, selfId, iBagIndex ) ~= 0 then
		x888820_NotifyTip( sceneId, selfId,"#{Item_Locked}")
		return
	end
	local iEquipItemId = LuaFnGetItemTableIndexByIndex( sceneId, selfId, iBagIndex )
	if IsEquipItem(iEquipItemId) ~= 1 then
		x888820_NotifyTip( sceneId, selfId,"#{SGCX_20231227_32}")
		return
	end
	local nEquipPoint = LuaFnGetBagEquipType(sceneId,selfId,iBagIndex)
	if x888820_IsEquipPointValid(nEquipPoint) ~= 1 then
		x888820_NotifyTip( sceneId, selfId,"#{SGCX_20231227_32}")
		return
	end
	local nCurQual = LuaFnGetEquipQual(sceneId,selfId,iBagIndex)
	if nCurQual < 7 then
		x888820_NotifyTip( sceneId, selfId,"#{SGCX_20231227_33}")
		return
	end
	if LuaFnIsHandMakeEquip(sceneId,selfId,iBagIndex) ~= 1 then
		x888820_NotifyTip( sceneId, selfId,"#{SGCX_20231227_32}")
		return
	end
	--有无剩余重洗次数
	if LuaFnGetEquipAttrRefreshTimes(sceneId,selfId,iBagIndex) >= 3 then
		x888820_NotifyTip( sceneId, selfId,  "#{SGCX_20231227_71}" )
		return
	end
	--钱是否够....
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < x888820_g_CostMoney then
		x888820_NotifyTip( sceneId, selfId,  "#{SGCX_20231227_70}" )
		return
	end
	local nNeedItemId = x888820_g_Need_Item_ID7
	if nCurQual == 7 then
		nNeedItemId = x888820_g_Need_Item_ID7
	elseif nCurQual == 8 then
		nNeedItemId = x888820_g_Need_Item_ID8
	else
		return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, nNeedItemId) < x888820_g_Need_Item_Count then
		x888820_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{SGCX_20231227_57}",GetItemName(sceneId,nNeedItemId)))
		return
	end
	LuaFnCostMoneyWithPriority( sceneId, selfId, x888820_g_CostMoney)
	LuaFnDelAvailableItem(sceneId,selfId,nNeedItemId,x888820_g_Need_Item_Count);
	--生成属性即可
	LuaFnRefreshEquipAttrGenAttr(sceneId,selfId,iBagIndex)
end

--**********************************
--放弃新属性
--**********************************
function x888820_DiscardNewEquipAttr( sceneId, selfId, nBagPos, bCheck)
	local nRet = LuaFnDiscardNewEquipAttr(sceneId,selfId,nBagPos)
	if nRet == -1 then
		--SGCX_20231227_62	#H当前尚未进行装备重洗，无法进行保留。	
		x888820_NotifyTip( sceneId, selfId, "#{SGCX_20231227_62}" )
		return
	elseif nRet == 1 then
		--SGCX_20231227_63	#H保留原有扩展属性成功。
		x888820_NotifyTip( sceneId, selfId, "#{SGCX_20231227_63}" )
	end
end

function x888820_IsEquipPointValid(ep)
	for i = 1, getn(x888820_g_Valid_ep) do
		if ep == x888820_g_Valid_ep[i] then
			return 1
		end
	end
	return 0
end
--**********************************
--醒目提示
--**********************************
function x888820_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
