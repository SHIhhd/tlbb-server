--欧冶安

--脚本号
x888813_g_ScriptId = 888813

x888813_g_ExchangeTab = {	
	[100] = {cost = 38002944, count = 10,prize = 38002985,mdex = MDEX_SHENBING_EXCHANGE_1,max = 2},
	[101] = {cost = 38002945, count = 20,prize = 38002986,mdex = MDEX_SHENBING_EXCHANGE_2,max = 3},
}
--所拥有的事件ID列表
x888813_g_eventList={
	--情刃引导·注法有求
	890272,
	--情刃引导·情刃归缘
	890277,
}
--**********************************
--事件列表
--**********************************
function x888813_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SBFW_20230707_20}")
		for i, eventId in x888813_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddNumText(sceneId,x888813_g_ScriptId,"#{SBFW_20230707_21}",6,1)
		AddNumText(sceneId,x888813_g_ScriptId,"#{SBFW_20230707_256}",6,2)
		AddNumText(sceneId,x888813_g_ScriptId,"#{SBFW_20230707_257}",6,3)
		
		AddNumText(sceneId,x888813_g_ScriptId,"#{SBFW_20230707_29}",11,200)	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x888813_OnDefaultEvent( sceneId, selfId,targetId )
	x888813_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x888813_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x888813_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
	
	if GetNumText() == 1 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_3}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881201 )
		return
	end
	if GetNumText() == 2 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_3}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881202 )
		return
	end
	if GetNumText() == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{SBFW_20230707_260}",
			tostring(x888813_g_ExchangeTab[100].max - GetMissionDataEx(sceneId,selfId,x888813_g_ExchangeTab[100].mdex)),
			tostring(x888813_g_ExchangeTab[101].max - GetMissionDataEx(sceneId,selfId,x888813_g_ExchangeTab[101].mdex))
			))
			AddNumText(sceneId,x888813_g_ScriptId,"#{SBFW_20230707_261}",6,100)
			AddNumText(sceneId,x888813_g_ScriptId,"#{SBFW_20230707_262}",6,101)
			
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 100 or GetNumText() == 101 then
		if GetLevel(sceneId,selfId) < 65 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_263}" )
			return
		end
		if sceneId ~= 2 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_264}" )
			return
		end
		if IsInDist( sceneId, selfId, targetId, 6 ) ~= 1 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_265}" )
			return
		end
		local nExchangeKey = GetNumText();
		local nCurExchangeCount = GetMissionDataEx(sceneId,selfId,x888813_g_ExchangeTab[nExchangeKey].mdex)
		if x888813_g_ExchangeTab[nExchangeKey].max - nCurExchangeCount <= 0 then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_266}" )
			return
		end
		if LuaFnGetAvailableItemCount(sceneId, selfId, x888813_g_ExchangeTab[nExchangeKey].cost) < x888813_g_ExchangeTab[nExchangeKey].count then
			x888813_NotifyTip( sceneId, selfId, "#{SBFW_20230707_267}" )
			return
		end
		BeginAddItem(sceneId)
		AddItem( sceneId, x888813_g_ExchangeTab[nExchangeKey].prize, 1)
		if EndAddItem(sceneId,selfId)<=0  then
			return
		end
		LuaFnMtl_CostMaterial(sceneId,selfId,x888813_g_ExchangeTab[nExchangeKey].count,x888813_g_ExchangeTab[nExchangeKey].cost)
		
		AddItemListToHuman(sceneId,selfId)
		--增加兑换数量
		SetMissionDataEx(sceneId,selfId,x888813_g_ExchangeTab[nExchangeKey].mdex,nCurExchangeCount + 1)
		--给特效
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		x888813_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SBFW_20230707_270}",GetItemName(sceneId,x888813_g_ExchangeTab[nExchangeKey].prize),1) )
	end
	if GetNumText() == 200 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SBFW_20230707_31}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x888813_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x888813_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId,targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x888813_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x888813_g_eventList do
		if missionScriptId == findId then
			x888813_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x888813_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x888813_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x888813_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x888813_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x888813_OnDie( sceneId, selfId, killerId )
end

--**********************************
--醒目提示
--**********************************
function x888813_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
