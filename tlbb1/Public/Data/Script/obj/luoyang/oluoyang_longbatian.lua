--洛阳NPC
--神医
--普通

--脚本号
x000129_g_scriptId = 000129

--所拥有的事件ID列表
x000129_g_eventList={806010,701603,890024}				-- 擂台观战脚本、“珍兽治疗”脚本、跨服校场

--游医脚本编号
x000129_g_healScriptId = 000064

--治疗设定 参见脚本000064

--**********************************
--事件列表
--**********************************
function x000129_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{OBJ_luoyang_BaTian}")
		--擂台观战脚本
		CallScriptFunction( 806010, "OnEnumerate",sceneId, selfId, targetId )
		AddNumText(sceneId,x000129_g_scriptId,"满怒治疗",6,0)
		--“珍兽治疗”脚本
		CallScriptFunction( 701603, "OnEnumerate",sceneId, selfId, targetId )
		AddNumText(sceneId,x000129_g_scriptId,"关于擂台挑战",11,1)
		CallScriptFunction( 890024, "OnEnumerate",sceneId, selfId, targetId )
		--【临时帮战PVP地图】镜湖幻境
		AddNumText(sceneId,x000129_g_scriptId,"#G前往镜湖·幻境", 9,100)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000129_OnDefaultEvent( sceneId, selfId,targetId )
	x000129_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000129_OnEventRequest( sceneId, selfId, targetId, eventId )
	-- 调用“江湖游医”脚本中计算金钱的函数
	local	gld = CallScriptFunction( x000129_g_healScriptId, "CalcMoney_hpmp",sceneId, selfId, targetId )* 0.1

	local	key	= GetNumText()
	--【临时帮战PVP地图】镜湖幻境
	if key == 100 then
		
		BeginEvent( sceneId )
			AddText( sceneId, "  前方道路略有眩晕，少侠可要忍住..." )
			AddNumText(sceneId,x000129_g_scriptId,"前往镜湖·幻境 甲 集结点", 9,101)
			AddNumText(sceneId,x000129_g_scriptId,"前往镜湖·幻境 乙 集结点", 9,102)
			AddNumText(sceneId,x000129_g_scriptId,"前往镜湖·幻境 丙 集结点", 9,103)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	elseif key >= 101 and key <= 103 then
		SetMissionCacheData(sceneId,selfId,0,key)
		LuaFnOpenTransSceneEffect( sceneId, selfId, 000129 )
	end

	if key == 1000 then	--不愿再治疗
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
	if key == 1001 then	--确认要治疗
		-- 调用“江湖游医”脚本中计算金钱的函数
		gld = CallScriptFunction( x000129_g_healScriptId, "CalcMoney_hpmp",sceneId, selfId, targetId )* 0.1

		-- 得到交子和金钱数目
		local nMoneyJZ = GetMoneyJZ ( sceneId, selfId )
		local nMoney = GetMoney ( sceneId, selfId )
		
		--检查玩家是否有足够的现金
		if (nMoneyJZ + nMoney >= gld) then
			--扣钱
			LuaFnCostMoneyWithPriority (sceneId, selfId, gld)
			-- 调用“江湖游医”脚本
			CallScriptFunction( x000129_g_healScriptId, "Restore_hpmp",sceneId, selfId, targetId )
			RestoreStrikePoint( sceneId, selfId )			
			return
		
		else
			BeginEvent( sceneId )
				AddText( sceneId, "  你的金钱不足！" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
		end
	end
	
	--加血
	if key == 0 then
		if GetHp( sceneId, selfId ) == GetMaxHp( sceneId, selfId ) and
			 GetRage( sceneId, selfId ) == GetMaxRage( sceneId, selfId ) and
			 GetMp( sceneId, selfId ) == GetMaxMp( sceneId, selfId ) and
			 IsStrikePointFull( sceneId, selfId ) == 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "  你现在很健康，不需要治疗！" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			
			--取消指定玩家身上的所有敌对可驱散驻留效果
			LuaFnDispelAllHostileImpacts( sceneId, selfId )
			return
		end
	
		if gld <= 0 then
			-- 调用“江湖游医”脚本
			CallScriptFunction( x000129_g_healScriptId, "Restore_hpmp",sceneId, selfId, targetId )
			RestoreStrikePoint( sceneId, selfId )
			--x000129_Restore_hpmp( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId )
				AddText( sceneId, "  你可以花费#G#{_EXCHG"..gld.."}#W，来恢复气血和怒气，确定要治疗吗？" )
				AddNumText( sceneId, x000129_g_scriptId, "是", -1, 1001 )
				AddNumText( sceneId, x000129_g_scriptId, "否", -1, 1000 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif key == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{LTJS_090910_01}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	else
		for i, findId in x000129_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText() )	--GetNumText()是addnumtext中最后的变量
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000129_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000129_g_eventList do
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
function x000129_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			x000129_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000129_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000129_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000129_OnDie( sceneId, selfId, killerId )
end

--**********************************
--客户端回调传送事件完成
--**********************************
function x000129_OnCloseTransSceneEffect( sceneId, selfId )
	local nCurSel = GetMissionCacheData(sceneId,selfId,0)
	if nCurSel == 101 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_JINGHU_HUANJING, 272,47, 10 )
	elseif nCurSel == 102 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_JINGHU_HUANJING, 41,276, 10 )
	elseif nCurSel == 103 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_JINGHU_HUANJING, 39,234, 10 )
	end
	SetMissionCacheData(sceneId,selfId,0,0)
end
