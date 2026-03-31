--云深深

--脚本号
x001095_g_ScriptId = 001095

--所拥有的事件ID列表
x001095_g_eventList={893040,893041,893044,893047,893048,893049,893050,893051,893052}

x001095_g_SkillBaofa = 3547
x001095_g_ComCost = 50000

--**********************************
--事件列表
--**********************************
function x001095_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHXT_20211230_47}")
		AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_48}",6,1)
		AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_49}",6,2)	
		AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_50}",6,3)
		AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_276}",6,4)
		
		if HaveSkill(sceneId,selfId,x001095_g_SkillBaofa) ~= 1 then
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_240}",6,100)
		end
		AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_55}",11,5)	
		for i, eventId in x001095_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001095_OnDefaultEvent( sceneId, selfId,targetId )
	x001095_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001095_OnEventRequest( sceneId, selfId, targetId, eventId )
	--升级
	if GetNumText() == 1 then
		if sceneId ~= SCENE_SUZHOU then
			x001095_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001095_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )--bIsShow
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012701 )
		return
	end
	--属性洗练
	if GetNumText() == 2 then
		if sceneId ~= SCENE_SUZHOU then
			x001095_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001095_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )--1 Open 2 Update
			UICommand_AddInt( sceneId, targetId )
			--已洗练次数
			UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_XILIAN_SHEN) ) --神
			UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_XILIAN_HUANG) ) --荒
			UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_XILIAN_LING) ) --灵
			--淬魂液 淬魂髓消耗
			UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNYE) ) --淬魂液
			UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSUI) ) --淬魂髓
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012708 )
		return
	end
	--育魂
	if GetNumText() == 3 then
		if sceneId ~= SCENE_SUZHOU then
			x001095_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001095_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )--bIsShow
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012702 )
		return
	end
	--兽魂爆发学习
	if GetNumText() == 100 then
		if sceneId ~= SCENE_SUZHOU then
			x001095_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001095_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		if HaveSkill(sceneId,selfId,x001095_g_SkillBaofa) == 1 then
			return
		end
		AddSkill(sceneId,selfId,x001095_g_SkillBaofa);
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_241}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		
		BeginEvent( sceneId )
			AddText( sceneId, "#{SHXT_20211230_242}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return
	end
	--合成洗练道具
	if GetNumText() == 4 then
		if sceneId ~= SCENE_SUZHOU then
			x001095_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001095_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_277}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_278}",6,41)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_279}",6,42)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--介绍信息
	if GetNumText() == 5 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_143}",11,100)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_144}",11,101)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_192}",11,102)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_145}",11,103)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_146}",11,104)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_147}",11,105)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_148}",11,106)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_227}",11,107)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,300)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	--********************************************************************
	--介绍详情
	--********************************************************************
	if GetNumText() == 100 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_151}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 101 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_152}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 102 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_193}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 103 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_153}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 104 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_154}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 105 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_155}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 106 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_156}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 107 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_228}")
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetNumText() == 300 then
		x001095_OnDefaultEvent( sceneId, selfId,targetId )
		return
	end
	if GetNumText() == 301 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_143}",11,100)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_144}",11,101)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_192}",11,102)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_145}",11,103)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_146}",11,104)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_147}",11,105)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_148}",11,106)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_227}",11,107)	
			AddNumText(sceneId,x001095_g_ScriptId,"#{SHXT_20211230_217}",8,300)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--********************************************************************
	--淬魂液 淬魂髓合成
	--********************************************************************
	if GetNumText() == 41 or GetNumText() == 42 then
		--判定金钱是否足够
		local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
		if nMoneySelf < x001095_g_ComCost then
			x001095_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SHXT_20211230_160}",x001095_g_ComCost) )
			return
		end
		local nNeedItem = 38002534
		local nGenItem = 38002533
		if GetNumText() == 42 then
			nNeedItem = 38002533
			nGenItem = 38002532
		end
		--扣除材料
		local nBindCount = LuaFnGetBindItemCountInBag(sceneId,selfId,nNeedItem)
		local nUnBindCount = LuaFnGetNotBindItemCountInBag(sceneId,selfId,nNeedItem)
		if nBindCount <= 0 and nUnBindCount <= 0 then
			x001095_NotifyTip( sceneId, selfId, "#{SHXT_20211230_280}" )
			return
		elseif nBindCount + nUnBindCount < 3 then
			x001095_NotifyTip( sceneId, selfId, "#{SHXT_20211230_280}" )
			return
		end
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			x001095_NotifyTip( sceneId, selfId, "#{SHXT_20211230_114}" )
			return
		end
		--扣除金币
		LuaFnCostMoneyWithPriority(sceneId, selfId, x001095_g_ComCost)
		
		if nBindCount >= 3 then
			LuaFnDelBindAvailableItem(sceneId,selfId,nNeedItem,3)
			LuaFnTryRecieveSingleItem(sceneId,selfId,nGenItem,1,1)
		elseif nBindCount > 0 then
			LuaFnDelBindAvailableItem(sceneId,selfId,nNeedItem,nBindCount)
			LuaFnDelNotBindAvailableItem(sceneId,selfId,nNeedItem,3 - nBindCount)
			LuaFnTryRecieveSingleItem(sceneId,selfId,nGenItem,1,1)
		elseif nBindCount <= 0 then
			LuaFnDelNotBindAvailableItem(sceneId,selfId,nNeedItem,3)
			LuaFnTryRecieveSingleItem(sceneId,selfId,nGenItem,1,0)
		end
		if GetNumText() == 42 then
			x001095_NotifyTip( sceneId, selfId, "#{SHXT_20211230_282}" )
		else	
			x001095_NotifyTip( sceneId, selfId, "#{SHXT_20211230_281}" )
		end
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	end

	for i, findId in x001095_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x001095_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001095_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001095_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x001095_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001095_g_eventList do
		if missionScriptId == findId then
			x001095_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001095_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001095_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001095_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001095_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001095_OnDie( sceneId, selfId, killerId )
end

--**********************************
--醒目提示
--**********************************
function x001095_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话提示
--**********************************
function x001095_NotifyBox( sceneId, selfId,targetId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchEventList(sceneId,selfId,targetId)
end