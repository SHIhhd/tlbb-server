--大理NPC
--武泽

--脚本号
x777700_g_ScriptId = 777700

--所拥有的事件ID列表
x777700_g_eventList={891087,891088,891089}

--**********************************
--事件列表
--**********************************
function x777700_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{WH_210223_12}")
		for i, eventId in x777700_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end	
		AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_109}",6,1)  ---
		AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_110}",6,2)
		AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_111}",6,3)
		AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_150}",6,4)
		AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_113}",11,5)
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x777700_OnDefaultEvent( sceneId, selfId,targetId )
	x777700_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x777700_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x777700_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end

	if GetNumText() == 1 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,88880001)
	elseif GetNumText() == 2 then 
	    BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_WUHUN_TUPU_UPDATE_TIME))
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,88880002)
	elseif GetNumText() == 3 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,88880003)
	elseif GetNumText() == 4 then
		--绘金尘合成
		BeginEvent(sceneId)
			AddText(sceneId,"#{WH_210223_151}")
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_152}",6,101)
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_153}",6,102)
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_154}",6,103)
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_155}",6,104)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 5 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_210223_13}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() >= 101 and GetNumText() <= 104 then
		--绘金尘合成
		local aCompDesc = {
			[101] = "#{WH_210223_178}",
			[102] = "#{WH_210223_184}",
			[103] = "#{WH_210223_185}",
			[104] = "#{WH_210223_186}",
		}
		BeginEvent(sceneId)
			AddText(sceneId,aCompDesc[GetNumText()])
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_179}",6,200 + GetNumText() - 100)
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() >= 201 and GetNumText() <= 204 then
		x777700_CombineHuiJin(sceneId,selfId,targetId,GetNumText() - 200)
	end
	
end
--**********************************
--合成绘金尘
--**********************************
function x777700_CombineHuiJin(sceneId,selfId,targetId,nIndex)
	if nIndex < 1 or nIndex > 4 then
	    return
	end
	if GetLevel(sceneId,selfId) < 80 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{WH_210223_187}")
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--金钱判断
	local needMoney = {30000,300000,50000,500000}
	local nMoneyJB = GetMoney(sceneId,selfId)
	if nMoneyJB < needMoney[nIndex] then
        BeginEvent(sceneId)
			AddText(sceneId,"#{WH_210223_189}")
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--所需物品判断
	local neeItem = {20800012,20800013}
	local needconst = {3,30,5,50}
	local nCurHave = LuaFnMtl_GetCostNum(sceneId,selfId,neeItem[1],neeItem[2])
	if nCurHave < needconst[nIndex] then
		x777700_NotifyTip( sceneId, selfId, "#{WH_210223_156}" )
		BeginEvent(sceneId)
			AddText(sceneId,"#{WH_210223_188}")
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--背包空间检测
	--因为这个是叠加物品，所以要一个空位就够了
	if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 1 then
		x777700_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_157}",tostring(1)))
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{WH_210223_190}",tostring(1)))
			AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	local aGiveItemNum = {1,10,1,10}
	local nNotBindItemNum = 0
	local nBindItemNum = 0;
	
	local nCostNotBindItemNum = 0
	local nCostBindItemNum = 0;
	--先检测非绑定的是不是足够
	local nNotBindMatNum = LuaFnGetAvailableItemCount(sceneId,selfId,neeItem[1]);
	if nNotBindMatNum < needconst[nIndex] then
		--非绑定不够，存在绑定的
		--计算非绑定的数量
		if nIndex == 2 then
			nNotBindItemNum = floor(nNotBindMatNum / 3)
			nCostNotBindItemNum = nNotBindItemNum * 3
		elseif nIndex == 4 then
			nNotBindItemNum = floor(nNotBindMatNum / 5)
			nCostNotBindItemNum = nNotBindItemNum * 5
		end
		nBindItemNum = aGiveItemNum[nIndex] - nNotBindItemNum
		
		if nIndex == 1 or nIndex == 2 then
			nCostBindItemNum = nBindItemNum * 3
		elseif nIndex == 3 or nIndex == 4 then
			nCostBindItemNum = nBindItemNum * 5
		end
	else
		nNotBindItemNum = aGiveItemNum[nIndex]
		nCostNotBindItemNum = needconst[nIndex]
	end
	local nNotBindItem = 0
	local nBindItem = 0;
	if nIndex == 1 or nIndex == 2 then
		nNotBindItem = 20800014
		nBindItem = 20800015
	elseif nIndex == 3 or nIndex == 4 then
		nNotBindItem = 20800016
		nBindItem = 20800017
	else
		return
	end
	if nCostNotBindItemNum == 0 and nCostBindItemNum == 0 then
		return
	end
	--扣物品
	if nCostNotBindItemNum > 0 then
		if LuaFnDelAvailableItem(sceneId,selfId,20800012,nCostNotBindItemNum) ~= 1 then
			x777700_NotifyTip( sceneId, selfId, "#{WH_210223_156}" )
			BeginEvent(sceneId)
				AddText(sceneId,"#{WH_210223_188}")
				AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	end
	if nCostBindItemNum > 0 then
		if LuaFnDelAvailableItem(sceneId,selfId,20800013,nCostBindItemNum) ~= 1 then
			x777700_NotifyTip( sceneId, selfId, "#{WH_210223_156}" )
			BeginEvent(sceneId)
				AddText(sceneId,"#{WH_210223_188}")
				AddNumText(sceneId,x777700_g_ScriptId,"#{WH_210223_180}",6,4)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	end
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId,selfId,needMoney[nIndex])
	--给新的物品
	if nBindItemNum > 0 then
		LuaFnTryRecieveMultiItem(sceneId,selfId,nBindItem,1,nBindItemNum,1)
		x777700_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_159}",tostring(nBindItemNum),GetItemName(sceneId,nNotBindItem)))
	end
	if nNotBindItemNum > 0 then
		LuaFnTryRecieveMultiItem(sceneId,selfId,nNotBindItem,1,nNotBindItemNum,0)
		x777700_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_160}",tostring(nNotBindItemNum),GetItemName(sceneId,nNotBindItem)))
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
end
--**********************************
--接受此NPC的任务
--**********************************
function x777700_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x777700_g_eventList do
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
function x777700_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x777700_g_eventList do
		if missionScriptId == findId then
			x777700_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x777700_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x777700_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x777700_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x777700_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x777700_OnDie( sceneId, selfId, killerId )
end

--**********************************
--醒目提示
--**********************************
function x777700_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- --对话窗口信息提示
--**********************************
function x777700_NotifyFailBox( sceneId, selfId,  msg )
	BeginEvent( sceneId )
		AddText( sceneId,msg)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end