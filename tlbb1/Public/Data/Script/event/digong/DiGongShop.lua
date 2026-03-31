--地宫商店
--脚本号
x891157_g_scriptId = 891157
--操作所需最低等级
x891157_g_MinLevel = 80
--消耗代币
x891157_g_PriceFormat = {
    [1] = {ItemID =38002256,show="#{MJXZ_210510_96}"},
    [2] = {ItemID =38002257,show="#{MJXZ_210510_97}"},
    [4] = {ItemID =38002262,show="#{MJXZ_210510_98}"},
}
--**********************************
--购买物品
--**********************************
function x891157_BuyItem( sceneId, selfId, itemIndex,itemID,nShopId,targetId  )
	if GetLevel(sceneId,selfId) < x891157_g_MinLevel then
		return
	end
	--距离过远
	if IsInDist(sceneId,selfId,targetId,6) < 1 then
		return
	end
	if GetName(sceneId,targetId) ~= "宫隽" then
		return
	end
	if x891157_g_PriceFormat[nShopId] == nil then
		return
	end
	--检索并过滤非法请求
	local titemID,itemName,countLimit,countNow,needNum,onceNum = Lua_GetDiGongShop(sceneId,selfId,itemIndex,itemID,nShopId)
	if titemID < 0 then
		return
	end
	--兑换数量
	if countNow >= countLimit then
		x891157_Tips( sceneId, selfId, "#{MJXZ_210510_95}" )
		return
	end
	--数量不足
	local nCurCount = LuaFnGetAvailableItemCount(sceneId, selfId, x891157_g_PriceFormat[nShopId].ItemID)
	if nCurCount < needNum then
		x891157_Tips( sceneId, selfId, x891157_g_PriceFormat[nShopId].show )
		return
	end
	--检查背包
	BeginAddItem(sceneId)
	AddItem( sceneId, titemID, onceNum )
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--消耗代币
	LuaFnDelAvailableItem(sceneId,selfId,x891157_g_PriceFormat[nShopId].ItemID,needNum)
	--发送物品
	AddItemListToHuman(sceneId,selfId)
	--增加兑换量
	LuaFnAddDiGongShopBuyCount(sceneId,selfId,itemIndex,itemID,nShopId)
	--提示
	x891157_Tips( sceneId, selfId, ScriptGlobal_Format("#{MJXZ_210510_101}",tostring(onceNum),itemName) )
end
--**********************************
--请求商店信息
--**********************************
function x891157_OpenShop( sceneId, selfId, nShopId,targetId )
	if x891157_g_PriceFormat[nShopId] == nil then
		return
	end
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nShopId)
		UICommand_AddInt(sceneId,LuaFnGetAvailableItemCount(sceneId,selfId,x891157_g_PriceFormat[nShopId].ItemID))
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89115701)
end

--**********************************
--提示信息
--**********************************
function x891157_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x891157_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end