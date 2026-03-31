-- 青丘商店
-- 脚本号
x893060_g_ScriptId = 893060
-- 可操作的最低等级
x893060_g_MinLevel = 60
--消耗代币
--MDEX_QINGQIULINGYE = 117		--青丘灵叶
--MDEX_QINGQIUXINYE = 118			--青丘新叶
x893060_g_PriceFormat = {
    [1] = {mdex =MDEX_QINGQIULINGYE,show="#{QQSD_220801_11}"},
    [2] = {mdex =MDEX_QINGQIUXINYE,show="#{QQSD_220801_31}"},
}
--**********************************
--购买物品
--**********************************
function x893060_buyitem( sceneId, selfId, targetId,shopType,itemIndex  )
	if GetLevel(sceneId,selfId) < x893060_g_MinLevel then
		x893060_Tips( sceneId, selfId, "#{QQSD_220801_9}" )
		return
	end
	--距离过远
	if IsInDist(sceneId,selfId,targetId,6) < 1 then
		x893060_Tips( sceneId, selfId, "#{QQSD_220801_4}" )
		return
	end
	if GetName(sceneId,targetId) ~= "云兰舟" then
		x893060_Tips( sceneId, selfId, "#{QQSD_220801_4}" )
		return
	end
	if x893060_g_PriceFormat[shopType] == nil then
		return
	end
	--检索并过滤非法请求
	local titemID,cshopType,itemName,onceNum,needNum = LuaFnGetQingQiuShopInfo(sceneId,selfId,itemIndex)
	if titemID < 0 then
		return
	end
	--数量不足
	local nCurCount = GetMissionDataEx(sceneId, selfId, x893060_g_PriceFormat[cshopType].mdex)
	if nCurCount < needNum then
		x893060_Tips( sceneId, selfId, x893060_g_PriceFormat[cshopType].show )
		return
	end
	--检查背包
	BeginAddItem(sceneId)
	AddItem( sceneId, titemID, onceNum )
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--消耗代币
	SetMissionDataEx(sceneId,selfId,x893060_g_PriceFormat[cshopType].mdex,nCurCount - needNum)
	--发送物品
	AddItemListToHuman(sceneId,selfId)
	--更新客户端代币显示
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,x893060_g_PriceFormat[cshopType].mdex))
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89306002)
	--提示
	x893060_Tips( sceneId, selfId, ScriptGlobal_Format("#{QQSD_220801_12}",tostring(onceNum),itemName) )
end
--**********************************
--任务入口函数
--**********************************
function x893060_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	if GetNumText() == 10 then
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x893060_Tips( sceneId, selfId, "#{QQSD_220801_4}" )
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,x893060_g_PriceFormat[1].mdex))
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89306001)
		return
	end
	if GetNumText() == 11 then
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x893060_Tips( sceneId, selfId, "#{QQSD_220801_4}" )
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,2)
			UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,x893060_g_PriceFormat[2].mdex))
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89306001)
		return
	end
	if GetNumText() == 12 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{QQSD_220801_5}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
end

--**********************************
--列举事件
--**********************************
function x893060_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x893060_g_ScriptId, "#{QQSD_220801_1}" ,7,10 )
	AddNumText( sceneId, x893060_g_ScriptId, "#{QQSD_220801_2}" ,7,11 )
	AddNumText( sceneId, x893060_g_ScriptId, "#{QQSD_220801_3}" ,11,12 )
end

--**********************************
--检测接受条件，也供子任务调用
--**********************************
function x893060_CheckAccept( sceneId, selfId )
end

--**********************************
--接受，仅供子任务调用设置公共参数
--**********************************
function x893060_OnAccept( sceneId, selfId, targetId, scriptId )
end

--**********************************
--放弃，仅供子任务调用
--**********************************
function x893060_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x893060_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893060_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交，仅供子任务调用
--**********************************
function x893060_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end
--**********************************
--提示信息
--**********************************
function x893060_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x893060_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end