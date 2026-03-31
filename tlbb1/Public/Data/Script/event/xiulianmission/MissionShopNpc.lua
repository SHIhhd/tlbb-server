--脚本号
x891271_g_ScriptId = 891271

x891271_g_MissionId = 2035
x891271_g_MissionItemId = 3		-- 道具id
x891271_g_MissionLevel = 60
--npc距离
x891271_g_NpcDist = 5

x891271_g_ButtonsNum = 12;
--**********************************
--任务入口函数
--**********************************
function x891271_OnDefaultEvent( sceneId, selfId, targetId,numText)
	if GetLevel(sceneId,selfId) < x891271_g_MissionLevel then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_65}" )
		return
	end
	if sceneId ~= SCENE_LUOYANG then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_66}" )
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891271_g_NpcDist) ~= 1 then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_67}" )
		return
	end
	BeginUICommand(sceneId)
		--0为关闭
		UICommand_AddInt(sceneId, 1);	
		UICommand_AddInt(sceneId, targetId);	
		
		UICommand_AddInt(sceneId, LuaFnGetQianWuShopItemNum());	
		if IsHaveMission(sceneId,selfId,x891271_g_MissionId) > 0 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x891271_g_MissionId)
			local nItemId = GetMissionParam(sceneId,selfId,misIndex,x891271_g_MissionItemId)
			UICommand_AddInt(sceneId, nItemId);	
		else
			UICommand_AddInt(sceneId, 0);	
		end
		UICommand_AddInt(sceneId, 1);	
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89127101)
end
--**********************************
--购买操作
--**********************************
function x891271_DoBuyFromShop( sceneId, selfId, targetId ,nPage,nIndex)
	if GetLevel(sceneId,selfId) < x891271_g_MissionLevel then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_65}" )
		return
	end
	if sceneId ~= SCENE_LUOYANG then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_66}" )
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891271_g_NpcDist) ~= 1 then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_67}" )
		return
	end
	local nActIndex = ((nPage - 1) * x891271_g_ButtonsNum) + nIndex
	local nTabSize = LuaFnGetQianWuShopItemNum()
	if nActIndex < 1 or nActIndex > nTabSize then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_505}" )
		return
	end
	local nRet, itemid, itemnum, itemcost, strName, strUnit  = LuaFnGetQianWuShopItemByIdx(nActIndex - 1)
	if nRet == nil or nRet <= 0 then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_505}" )
		return
	end
	--交子够不够
	if GetMoneyJZ(sceneId,selfId) < itemcost then
		x891271_NotifyTip( sceneId, selfId, "#{XLRW_210725_507}" )
		return
	end
	--背包是否够装
	BeginAddItem(sceneId)
	AddItem( sceneId, itemid, itemnum )
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	LuaFnCostMoneyWithPriority(sceneId,selfId,itemcost)
	AddItemListToHuman(sceneId,selfId)
	--提示
	x891271_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_508}",strName) )
end
--**********************************
--列举事件
--**********************************
function x891271_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x891271_g_ScriptId,"#{XLRW_210725_64}",7,1);
end
--**********************************
--接取任务
--**********************************
function x891271_OnAccept(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x891271_OnAbandon( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x891271_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
--对话窗口信息提示
--**********************************
function x891271_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891271_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
