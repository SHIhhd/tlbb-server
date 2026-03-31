--云思儿

--脚本号
x001083_g_scriptId = 001083

--商店编号
x001083_g_shoptableindex=102

--所拥有的事件ID列表
x001083_g_eventList={400918, 400963,311112}	--	去玄武岛、去圣兽山}	

--珍兽幻化丹碎片
x001083_g_PetHuanhuandan_m = 20310115
--珍兽幻化丹碎片
x001083_g_PetHuanhuandan = 30502005
--珍兽幻化丹合成消耗
x001083_g_PetHuanhuandan_Cost = 20000

--**********************************
--事件列表
--**********************************
function x001083_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"#{YXZ_80917_01}")
		

	AddNumText(sceneId,x001083_g_scriptId,"购买宠物技能书",7,2)
--	AddNumText(sceneId,x001083_g_scriptId,"查询珍兽成长率",6,3)
	AddNumText(sceneId,x001083_g_scriptId,"珍兽幻化",6,10)
	
	AddNumText(sceneId,x001083_g_scriptId,"珍兽幻化丹合成",6,11)
	AddNumText(sceneId,x001083_g_scriptId,"提升幻化珍兽灵性",6,12)
	
	AddNumText(sceneId,x001083_g_scriptId,"#{XXWD_8916_07}",11,5)
	AddNumText(sceneId,x001083_g_scriptId,"如何给珍兽快速升级",11,7)
	AddNumText(sceneId,x001083_g_scriptId,"关于珍兽幻化",11,8)
	AddNumText(sceneId,x001083_g_scriptId,"关于提升幻化珍兽灵性",11,9)
	for i, eventId in x001083_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001083_OnDefaultEvent( sceneId, selfId,targetId )
	x001083_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001083_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x001083_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	
	if GetNumText() == 2 then
		DispatchShopItem( sceneId, selfId,targetId, x001083_g_shoptableindex )
--	elseif GetNumText() == 3 then
--		BeginEvent( sceneId )
--		AddText( sceneId, "  查询珍兽的成长率，查询一次需要收取#{_MONEY100}的费用。" )
--		AddNumText( sceneId, x001083_g_scriptId, "确定", -1, 4 )
--		EndEvent( sceneId )
--		DispatchEventList( sceneId, selfId, targetId )
--	elseif GetNumText() == 4 then
--		BeginUICommand( sceneId )
--			UICommand_AddInt( sceneId, targetId )
--			UICommand_AddInt( sceneId, 6 )				--珍兽查询分支
--		EndUICommand( sceneId )
--		DispatchUICommand( sceneId, selfId, 3 )	--调用珍兽界面
	elseif GetNumText() == 5 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XXWD_8916_08}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 6 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{JNHC_81015_12}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 7 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{ZSKSSJ_081126_5}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 8 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{RXZS_090804_23}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 9 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{RXZS_090804_24}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 10 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090804 )	--珍兽幻化
	elseif GetNumText() == 11 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{RXZS_090804_9}")
			AddNumText(sceneId,x001083_g_scriptId,"合成",6,20)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 12 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20090805 )	--珍兽幻化灵性提升
	elseif GetNumText() == 20 then
		local Num = LuaFnGetAvailableItemCount ( sceneId, selfId,x001083_g_PetHuanhuandan_m);
		if Num < 10 then
		    x001083_NotifyTip( sceneId, selfId,"#{RXZS_090804_10}" )
			return
		end
		local money = GetMoney(sceneId, selfId);
		local moneyJZ = GetMoneyJZ(sceneId, selfId);
		if (money+moneyJZ) < x001083_g_PetHuanhuandan_Cost then
		    x001083_NotifyTip( sceneId, selfId,"#{RXZS_090804_11}" )
			return
		end
		LuaFnDelAvailableItem(sceneId,selfId,x001083_g_PetHuanhuandan_m,10)
		TryRecieveItem( sceneId, selfId, x001083_g_PetHuanhuandan, 1 )	
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		LuaFnCostMoneyWithPriority( sceneId, selfId, x001083_g_PetHuanhuandan_Cost )
		x001083_NotifyTip( sceneId, selfId,"#{RXZS_090804_12}" )
	end
	
end

--**********************************
--接受此NPC的任务
--**********************************
function x001083_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001083_g_eventList do
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
function x001083_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001083_g_eventList do
		if missionScriptId == findId then
			x001083_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001083_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001083_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001083_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001083_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001083_OnDie( sceneId, selfId, killerId )
end

--**********************************
--提交珍兽
--**********************************
function x001083_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
--注意，这里这样写省略了在eventlist中搜索scriptId这一部分，可能会有问题
	CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
end

--**********************************
--醒目提示
--**********************************
function x001083_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
