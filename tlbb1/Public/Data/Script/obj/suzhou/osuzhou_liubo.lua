--种师道
x502023_g_scriptId = 502023

--所拥有的事件ID列表
x502023_g_eventList={502011,891092,891093}

x502023_g_MinLevel = 80
x502023_g_TitleID_List = {
	{39920084,1034,1},{39920085,1035,2},{39920086,1036,3},{39920087,1037,4},{39920088,1038,5},{39920089,1039,6},{39920090,1040,7} 
}
x502023_g_TitleNeed_List ={500,2000,5000,20000,50000,100000,200000}

--**********************************
--事件列表
--**********************************
function x502023_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XSLDZ_180521_98}")
		for i, eventId in x502023_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		--领取兵行四象奖励
		AddNumText(sceneId,x502023_g_scriptId,"#{XSLDZ_180521_104}",15,10)
		--四象荣誉商店
		AddNumText(sceneId,x502023_g_scriptId,"#{XSLDZ_180521_196}",15,11)
		--领取四象荣誉称号
		AddNumText(sceneId,x502023_g_scriptId,"#{XSLDZ_180521_199}",15,12)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x502023_OnDefaultEvent( sceneId, selfId,targetId )
	x502023_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x502023_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x502023_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
	if GetNumText() == 10 then
		--领取兵行四象奖励
--		LuaFnAskNpcScriptMail(sceneId, selfId, MAIL_BINGXINGSIXIANG)
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_210128_06}")
			x502023_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_210128_07}" )
			return
		end
		if GetMissionFlagEx(sceneId,selfId,MFEX_NEWSONGLIAO_CURGETPRIZE) == 1 then
			x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_210128_09}")
			x502023_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_210128_08}" )
			return
		end
		local nCampId = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURCAMP)
		local nWiner = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURSTATE)
		local nIndex = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURINDEX)
		if nCampId == 0 then
			x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_210128_11}")
			x502023_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_210128_10}" )
			return
		end
		x502023_NewRaidPrize(sceneId, selfId,targetId, nCampId, nWiner, nIndex)
	elseif GetNumText() == 11 then
		--更新荣誉信息
		LuaFnUpdateSelfRongYuInfo(sceneId,selfId)
		
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 502023 )
		return
	elseif GetNumText() == 12 then
		--更新荣誉信息
		LuaFnUpdateSelfRongYuInfo(sceneId,selfId)
		--领取四象荣誉称号
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 2 )--OpenUI
			UICommand_AddInt( sceneId, targetId )
			--称号获取状态
			for i = 1,getn(x502023_g_TitleID_List) do
				local retCanAddTitle = LuaFnCanAddTitle(sceneId, selfId,x502023_g_TitleID_List[i][2])
				if retCanAddTitle == 0 then
					--称号已存在
					UICommand_AddInt( sceneId, 1 )
				else
					UICommand_AddInt( sceneId, 0 )
				end
			end
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 50202301 )
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x502023_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x502023_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x502023_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x502023_g_eventList do
		if missionScriptId == findId then
			x502023_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x502023_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x502023_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x502023_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x502023_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x502023_OnDie( sceneId, selfId, killerId )
end
--**********************************
--领取兵行四象奖励
--**********************************
function x502023_NewRaidPrize(sceneId, selfId,targetId, nCampId, nWiner, nIndex)
	--nWiner:	0:平局 156：宋胜 157：辽胜
	--nCampId:	自己的阵营
	--nIndex:	排名1-30
	local m_nIndex,m_SongBonusItemID,m_SongBonusItemNum,m_SongBonusProNum,
		m_LiaoBonusItemID,m_LiaoBonusItemNum,m_LiaoonusProNum,
		m_BonusItemID1,m_BonusItemNum1,m_BonusProNum1,
		m_BonusItemID2,m_BonusItemNum2,m_BonusProNum2,
		m_RYValue,m_RYVictoryValue,m_LossRYRankValue,m_RYLossValue = LuaFnGetSongLiaoBonusInfo(nIndex)
	if m_nIndex == nil then
		return
	end
	--物品奖励
	local tPrizeMessage = {}
	LuaFnBeginAddItem( sceneId )
	if nFinalResult == 1 then
		tinsert(tPrizeMessage,{m_BonusItemID1,m_BonusItemNum1})
	else
		tinsert(tPrizeMessage,{m_BonusItemID2,m_BonusItemNum2})
	end
	--排名物品奖励
	if nCampId == 156 then
		if m_SongBonusItemID > 0 then
			tinsert(tPrizeMessage,{m_SongBonusItemID,m_SongBonusItemNum})
		end
	else
		if m_SongBonusItemID > 0 then
			tinsert(tPrizeMessage,{m_LiaoBonusItemID,m_LiaoBonusItemNum})
		end
	end
	for i = 1,getn(tPrizeMessage) do
		LuaFnAddItem( sceneId, tPrizeMessage[i][1], tPrizeMessage[i][2])
	end
	if LuaFnEndAddItem( sceneId, selfId ) <= 0 then
		--背包满了
		x502023_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_210128_12}" )
		return
	end
	AddItemListToHuman(sceneId,selfId)
	for i = 1,getn(tPrizeMessage) do
		x502023_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{XSLDZ_210128_18}",tostring(tPrizeMessage[i][2]),GetItemName(sceneId,tPrizeMessage[i][1])) )
	end
	--特殊声明
	if m_nIndex == 1 then
		if nCampId == 156 then
			x502023_NotifyTips( sceneId, selfId, "#{XSLDZ_210128_19}" )
		else
			x502023_NotifyTips( sceneId, selfId, "#{XSLDZ_210128_20}" )
		end
	end
	--计算四象荣誉
	local nRYFinal = m_RYValue;
	if nWiner == nCampId then
		nRYFinal = nRYFinal + m_RYVictoryValue
		x502023_NotifyTips( sceneId, selfId, "#{XSLDZ_210128_16}" )
	elseif nWiner == 0 then
		nRYFinal = nRYFinal + m_LossRYRankValue
	else
		nRYFinal = nRYFinal + m_RYLossValue
	end
	x502023_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{XSLDZ_210128_17}",tostring(nRYFinal)) )
	--四象荣誉计算
	--MDEX_NEWSONGLIAO_SIXIANGRONGYU = 142		--新宋辽 四象荣誉
	--MDEX_NEWSONGLIAO_SIXIANGRONGYU_HIS = 143 	--新宋辽 历史四象荣誉
	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU,GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU) + nRYFinal)
	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU_HIS,GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU_HIS) + nRYFinal)
	--更新荣誉信息
	LuaFnUpdateSelfRongYuInfo(sceneId,selfId)
	
	SetMissionFlagEx(sceneId,selfId,MFEX_NEWSONGLIAO_CURGETPRIZE,1)
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end

--**********************************
-- 荣誉商店购买
--**********************************
function x502023_BuyRYItem( sceneId, selfId, nIndex )
	local nItemID,nLimitedNum,nItemPrice = LuaFnGetRongYuShopInfo(sceneId,selfId,nIndex)
	if nItemID == nil or nItemID <= 0 then
		return
	end
	local nRYValue = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU)
	if nRYValue < nItemPrice then
		x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_180521_220}")
		return
	end
	--检测是否还能继续购买
	if nLimitedNum > 0 then
		local nHaveBoughtNum = LuaFnGetRongYuShopBuyCount(sceneId,selfId,nIndex - 1);
		if nHaveBoughtNum >= nLimitedNum then
			x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_180521_218}")
			return
		end
	end
	--检测背包空间
	LuaFnBeginAddItem( sceneId )
--	LuaFnAddItem( sceneId, nItemID, 1)
	LuaFnAddBindItem( sceneId, nItemID, 1)	--目前调整为全给绑定的物品
	
	if LuaFnEndAddItem( sceneId, selfId ) <= 0 then
		x502023_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_221}" )
		return
	end
	AddItemListToHuman(sceneId,selfId)
	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU,nRYValue - nItemPrice)
	--购买数量记录
	if nLimitedNum > 0 then
		local nHaveBoughtNum = LuaFnGetRongYuShopBuyCount(sceneId,selfId, nIndex - 1);
		LuaFnSetRongYuShopBuyCount(sceneId,selfId,nIndex - 1,nHaveBoughtNum + 1);
	end
	LuaFnUpdateSelfRongYuInfo(sceneId,selfId)

	x502023_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{XSLDZ_180521_222}",tostring(1),GetItemName(sceneId,nItemID)) )
end

--**********************************
--客户端申请称号兑换
--**********************************
function x502023_AddTitleRequest( sceneId, selfId,nIndex )
	if x502023_g_TitleNeed_List[nIndex] == nil then
		return
	end
	if GetLevel(sceneId,selfId) < x502023_g_MinLevel then
		x502023_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_231}" )
		return
	end
	local nCurRYValue = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU_HIS);
	if nCurRYValue < x502023_g_TitleNeed_List[nIndex] then
		x502023_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_233}" )
		return
	end
	--获取称号状态
	local retCanAddTitle = LuaFnCanAddTitle( sceneId, selfId, x502023_g_TitleID_List[nIndex][2] )
	if ( retCanAddTitle ~= 1 ) then
		if ( retCanAddTitle == 0 ) then
			x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_180521_232}")
		end
		return
	end
	--给新称号
	LuaFnAwardCharTitle( sceneId, selfId, x502023_g_TitleID_List[nIndex][2] )
	LuaFnSetCurTitleById( sceneId, selfId, x502023_g_TitleID_List[nIndex][2] )
	LuaFnDispatchAllTitle(sceneId, selfId)
	
	x502023_NotifyTips( sceneId, selfId,"#{XSLDZ_180521_234}")
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	
	--XSLDZ_180521_235	#G%s0#P在兵行四象大显神威，声名远扬，被授予称号：#G%s1#P，真是可喜可贺！	
	AddGlobalCountNews(sceneId,ScriptGlobal_Format("#{XSLDZ_180521_235}",GetName(sceneId, selfId),LuaFnGetTitleNameById(x502023_g_TitleID_List[nIndex][2])))
	--更新UI情况
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 3 )--RwardReturn
		UICommand_AddInt( sceneId, -1 )
		--称号获取状态
		UICommand_AddInt( sceneId, 1 )
		UICommand_AddInt( sceneId, x502023_g_TitleID_List[nIndex][3] )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 50202301 )
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x502023_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x502023_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

