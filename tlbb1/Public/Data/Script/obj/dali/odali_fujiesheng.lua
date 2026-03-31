--除恶天劫楼
--除恶务尽
--付劫生
x002095_g_ScriptId	= 002095
x002095_g_Yinpiao = 40002000
x002095_g_eventList = {808138}
x002095_g_DeliveryScript = 006668
x002095_g_DeliveryList = {1018829,1018837,1018838,1018839,1018840,1018841,1018842,1018843,1018844,1018846}
x002095_g_LootItemscript = 006667
x002095_g_LootItemList = {1039803,1039805,1039806,1039807,1039808,1039809,1039810,1039811,1039812}
--**********************************
--事件交互入口
--**********************************
function x002095_OnDefaultEvent( sceneId, selfId, targetId )

	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x002095_g_Yinpiao)>=1  then
		x002095_MsgBox(sceneId,selfId,targetId, "  你身上有银票，正在跑商！我不能帮助你。" )
		return
	end
	BeginEvent( sceneId )
		AddText( sceneId, "#{TJL_090714_01}" )
		if sceneId == SCENE_DALI then --在大理显示进入天劫楼
			AddNumText( sceneId, x002095_g_ScriptId, "#{TJL_xml_XX(02)}", 10, 1001 )
		end
		AddNumText( sceneId, x002095_g_ScriptId, "#{TJL_xml_XX(03)}", 11, 1002 )
		for i, Deliveryidx in x002095_g_DeliveryList do
			CallScriptFunction( x002095_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
		for i, LootItemidx in x002095_g_LootItemList do
			CallScriptFunction( x002095_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		for i, eventId in x002095_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002095_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1002 then
		x002095_MsgBox(sceneId,selfId,targetId, "#{TJL_090714_09}" )
		return
	end
		--队伍相关
	if GetTeamId(sceneId,selfId)>=0 and
		IsTeamFollow(sceneId, selfId)==1 and
		LuaFnIsTeamLeader(sceneId,selfId)==1 then
		num=LuaFnGetFollowedMembersCount( sceneId, selfId)
		local mems = {}
		for	i=0,num-1 do
			mems[i] = GetFollowedMember(sceneId, selfId, i)
			if mems[i] == -1 then
				return
			end
			if IsHaveMission(sceneId,mems[i],4021) > 0 then
				x002095_MsgBox( sceneId, selfId, targetId, "  你队伍成员中有人有漕运货舱在身，我不能送你们去天劫楼。" )
				return
			end
		end
	end

	--漕运相关
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x002095_MsgBox( sceneId, selfId, targetId, "  你有漕运货舱在身，我不能送你去天劫楼。" )
		return
	end

    local iniLevel = GetLevel( sceneId, selfId )
	if GetNumText() == 1001 then		--除恶天劫楼
		if iniLevel < 30 then
			x002095_NotifyFailTips( sceneId, selfId,"#{TJL_090714_07}")
			return
		end
        if iniLevel >= 30 and iniLevel < 40 then
		    CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 435, 82, 78, 30 );
		elseif iniLevel >= 40 and iniLevel < 50 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 436, 82, 78, 40 );
		elseif iniLevel >= 50 and iniLevel < 60 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 437, 82, 78, 50 );
		elseif iniLevel >= 60 and iniLevel < 70 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 438, 82, 78, 60 );
		elseif iniLevel >= 70 and iniLevel < 80 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 439, 82, 78, 70 );
		elseif iniLevel >= 80 and iniLevel < 90 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 440, 82, 78, 80 );
		elseif iniLevel >= 90 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 441, 82, 78, 90 );
		end
	    return
	end
	--配表任务
	for i,Deliveryidx in x002095_g_DeliveryList do
		if eventId == x002095_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, LootItemidx in x002095_g_LootItemList do
		if eventId == x002095_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x002095_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x002095_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x002095_g_DeliveryList do
		if missionScriptId == x002095_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, LootItemidx in x002095_g_LootItemList do
		if missionScriptId == x002095_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x002095_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002095_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002095_g_eventList do
		if missionScriptId == findId then
			x002095_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002095_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x002095_g_DeliveryList do
		if missionScriptId == x002095_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, LootItemidx in x002095_g_LootItemList do
		if missionScriptId == x002095_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x002095_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002095_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x002095_g_DeliveryList do
		if missionScriptId == x002095_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, LootItemidx in x002095_g_LootItemList do
		if missionScriptId == x002095_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x002095_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end
--**********************************
--死亡事件
--**********************************
function x002095_OnDie( sceneId, selfId, killerId )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x002095_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**************************************************************************
--对话
--**************************************************************************
function x002095_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end