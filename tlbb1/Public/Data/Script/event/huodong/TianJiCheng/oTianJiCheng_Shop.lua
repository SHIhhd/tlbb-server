-- 天机城代币商店
-- 脚本号
x890254_g_ScriptId = 890254
-- 可操作的最低等级
x890254_g_MinLevel = 85
--消耗代币
--MDEX_QINGQIULINGYE = 117		--青丘灵叶
--MDEX_QINGQIUXINYE = 118			--青丘新叶
x890254_g_PriceFormat = {
    [1] = {mdex =MDEX_QINGQIULINGYE,show="#{QQSD_220801_11}"},
    [2] = {mdex =MDEX_QINGQIUXINYE,show="#{QQSD_220801_31}"},
}
--**********************************
--购买物品
--**********************************
function x890254_Callback_Exchange( sceneId, selfId,itemIndex  )
	if GetLevel(sceneId,selfId) < x890254_g_MinLevel then
		x890254_Tips( sceneId, selfId, "#{BLDPVP_221214_137}" )
		return
	end
	--检索并过滤非法请求
	--注意配表索引按1开始
	local itemId, isBind, onceNum, maxNum, needNum = LuaFnTJCPVPGetShopItemInfo(itemIndex + 1)
	if itemId <= 0 then
		return
	end
	-- 获取物品已兑换数量
    local exchangedNum = LuaFnTJCPVPGetExchangedNum(sceneId,selfId,itemIndex)
    if (maxNum <= exchangedNum) then
        -- 可兑换数量为0
        x890254_Tips( sceneId, selfId,"#{BLDPVP_221214_138}")
        return
    end
	local nDaiBiNum = LuaFnTJCPVPGetDaiBiCount(sceneId,selfId)
    if (nDaiBiNum < needNum) then
        -- 代币数量不足
        x890254_Tips( sceneId, selfId,"#{BLDPVP_221214_139}")
        return
    end
	--检查背包
	BeginAddItem(sceneId)
	if isBind == 1 then
		AddBindItem( sceneId, itemId, onceNum )
	else
		AddItem( sceneId, itemId, onceNum )
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--消耗代币
	LuaFnTJCPVPSetDaiBiCount(sceneId,selfId,nDaiBiNum - needNum)
	--增加购买计数
	LuaFnTJCPVPSetExchangedNum(sceneId,selfId,itemIndex,exchangedNum + 1)
	--发送物品
	AddItemListToHuman(sceneId,selfId)
	--更新商店
	LuaFnTJCPVPOpenShop(sceneId,selfId,-1)
	--提示
	x890254_Tips( sceneId, selfId, ScriptGlobal_Format("#{BLDPVP_221214_142}",tostring(onceNum),GetItemName(sceneId,itemId)) )
end
--**********************************
--任务入口函数
--**********************************
function x890254_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	if GetLevel(sceneId,selfId) < x890254_g_MinLevel then
		x890254_Tips( sceneId, selfId, "#{BLDPVP_221214_130}" )
		x890254_TipsBox( sceneId, selfId,targetId, "#{BLDPVP_221214_131}" )
		return
	end
	--距离过远
	if IsInDist(sceneId,selfId,targetId,6) < 1 then
		x890254_Tips( sceneId, selfId, "#{BLDPVP_221214_133}" )
		return
	end
	if GetNumText() == 1 then
		LuaFnTJCPVPOpenShop(sceneId,selfId,targetId)
	end
end

--**********************************
--列举事件
--**********************************
function x890254_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x890254_g_ScriptId, "#{BLDPVP_221214_129}" ,7,1 )
end

--**********************************
--检测接受条件，也供子任务调用
--**********************************
function x890254_CheckAccept( sceneId, selfId )
end

--**********************************
--接受，仅供子任务调用设置公共参数
--**********************************
function x890254_OnAccept( sceneId, selfId, targetId, scriptId )
end

--**********************************
--放弃，仅供子任务调用
--**********************************
function x890254_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x890254_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890254_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交，仅供子任务调用
--**********************************
function x890254_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end
--**********************************
--提示信息
--**********************************
function x890254_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x890254_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end