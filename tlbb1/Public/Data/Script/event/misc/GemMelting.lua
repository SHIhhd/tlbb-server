--宝石熔炼

--脚本号
x800118_g_ScriptId	= 800118


function x800118_OnGemMelting( sceneId, selfId, GemTableIndex, NeedItemPos )

	if GemTableIndex == -1 or NeedItemPos == -1 then
		return
	end

	--是否在安全时间内....这个判断函数里面自己有提示信息....
	if IsPilferLockFlag(sceneId, selfId) <= 0 then
		return
	end

	local NeedItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, NeedItemPos )

	--检测是否可以熔炼....
	local ProductID, NeedID, NeedMoney ,NeedID_2 = LuaFnGetGemMeltingInfo( GemTableIndex )
	if  -1 == ProductID then
		x800118_NotifyTip( sceneId, selfId, "该宝石无法熔炼，宝石熔炼失败。" )
		return
	end

	--检测是否有所需物品....
	if NeedID ~= NeedItemID then
		x800118_NotifyTip( sceneId, selfId, "熔炼所需物品错误，宝石熔炼失败。" )
		return
	end

	--检测金钱是否足够....
	local PlayerMoney = GetMoney( sceneId, selfId ) +  GetMoneyJZ(sceneId, selfId)  --交子普及 Vega
	if PlayerMoney < NeedMoney then
		x800118_NotifyTip( sceneId, selfId, "金钱不足，宝石熔炼失败。" )
		return
	end
	
	--需要至少3颗宝石方可进行熔炼
	if LuaFnGetAvailableItemCount(sceneId, selfId,GemTableIndex) < 3 then
	    x800118_NotifyTip( sceneId, selfId, "#{BSDJ_170811_27}" )
	    return
	end

	--检测产物是否需要绑定....
	local nFirstGemPos = LuaFnGetAvailableItemFirstPos(sceneId,selfId,GemTableIndex)
	local bNeedBind = 0
	if LuaFnGetItemBindStatus(sceneId, selfId, nFirstGemPos) == 1
	or LuaFnGetItemBindStatus(sceneId, selfId, NeedItemPos) == 1 then
		bNeedBind = 1
	end

	local NeedItemInfo = GetBagItemTransfer( sceneId, selfId, NeedItemPos )
	
	--扣除宝石
	LuaFnDelAvailableItem(sceneId,selfId,GemTableIndex,3)

	--扣钱....
	local ret = LuaFnCostMoneyWithPriority( sceneId, selfId, NeedMoney )      --交子普及 Vega
	if ret < 0 then
		x800118_NotifyTip( sceneId, selfId, "金钱不足，宝石熔炼失败。" )
		return
	end
	
	--扣除熔炼符
	LuaFnDelAvailableItem(sceneId,selfId,NeedItemID , 1)

	--给玩家熔炼后的宝石....不用检测背包是否有地方....没地方前边也del出地方了....
	local BagIndex = TryRecieveItem( sceneId, selfId, ProductID, QUALITY_MUST_BE_CHANGE )
	if BagIndex == -1 then
		x800118_NotifyTip( sceneId, selfId, "背包已满，宝石熔炼失败。" )
		return
	end
	if bNeedBind == 1 then
		LuaFnItemBind(sceneId, selfId, BagIndex)
	end
	local ProductItemInfo = GetBagItemTransfer( sceneId, selfId, BagIndex )

	--统计....
--	LuaFnAuditGemMelting( sceneId, selfId, GemItemID1, GemItemID2, GemItemID3, NeedItemID, ProductID )

	--醒目提示....
	x800118_NotifyTip( sceneId, selfId, "3颗（#{_ITEM"..GemTableIndex.."}）被成功熔炼成一颗（#{_ITEM"..ProductID.."}）" )

	--公告....
	if LuaFnGetItemQuality(ProductID) >= 3 then
		local MeltingNPCTbl =
		{
			[0]   = "洛阳（178，185）彭怀玉",
			[420] = "束河古镇（134，84）荆嵌实",
			[186] = "楼兰（74，161）克里木",
		}
		local NPCInfo = MeltingNPCTbl[sceneId]
		local PlayerName = GetName(sceneId, selfId)
		local strText = format("#{JKBS_081021_016}#{_INFOUSR%s}#{JKBS_081021_017}#{_ITEM%s}#{JKBS_081021_018}#{_INFOMSG%s}#{JKBS_081021_019}%s#{JKBS_081021_020}#{_INFOMSG%s}#{JKBS_081021_021}", PlayerName, GemTableIndex, NeedItemInfo, NPCInfo, ProductItemInfo )
		BroadMsgByChatPipe(sceneId,selfId, strText, 4)
	end

	--熔炼成功特效....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)

end

--**********************************
--醒目提示
--**********************************
function x800118_NotifyTip( sceneId, selfId, Msg )

	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )

end
