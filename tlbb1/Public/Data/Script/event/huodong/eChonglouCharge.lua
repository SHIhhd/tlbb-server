-- 魔尊魂武铸重楼
x503030_g_ScriptId = 503030;
-- 奖励相关
x503030_g_AwradInfo = {
	10422016,
	10423024
}
x503030_g_NeedItemID = {38000539,38000540}
x503030_g_NeedItemNum = 255
--**********************************
--列举事件
--**********************************
function x503030_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x503030_g_ScriptId, "#G#{KVKCS_130326_22}", 6, 10 )
end

--**********************************
--任务入口函数
--**********************************
function x503030_OnDefaultEvent( sceneId, selfId, targetId )

	local nNumText = GetNumText( )
	if( nNumText == 10 ) then
		BeginEvent( sceneId )
		AddText( sceneId, "#{KVKCS_130326_11}" )
		for i, item in x503030_g_AwradInfo do
		 	AddRadioItemBonus( sceneId, item, 1 )
		end
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		DispatchMissionContinueInfo( sceneId, selfId, targetId, x503030_g_ScriptId, 0 )
	end
end


--**********************************
--返回对话
--**********************************
function x503030_ReturnDlg(sceneId, selfId, targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId, msg);
	EndEvent()
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--ReturnTips
--**********************************
function x503030_Tips(sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId, msg);
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end

--**********************************
--接受
--**********************************
function x503030_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x503030_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x503030_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x503030_CheckSubmit( sceneId, selfId )
end
--**********************************
--提交已做完的任务
--**********************************
function x503030_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	local bFind = 0
	for i, item in x503030_g_AwradInfo do
		if item == selectRadioId then
			bFind = 1
			break
		end
	end
	if bFind ~= 1 then
		x503030_Tips(sceneId, selfId, "#{KVKCS_130326_12}")
		return
	end
	if( LuaFnMtl_GetCostNum( sceneId, selfId, x503030_g_NeedItemID[1],x503030_g_NeedItemID[2] ) < x503030_g_NeedItemNum) then
		x503030_Tips(sceneId, selfId, "#{KVKCS_130326_13}")
		return
	end
	BeginAddItem(sceneId)
	AddBindItem(sceneId, selectRadioId, 1)
	local bBagOk = LuaFnEndAddItemIgnoreFatigueState(sceneId, selfId)
	if bBagOk < 1 then
		x503030_Tips(sceneId, selfId, "#{KVKCS_130326_16}")
		return
	end
	-- 添加物品
	local bagidx = LuaFnTryRecieveSingleItem( sceneId, selfId, selectRadioId, 1,1 )
	if bagidx < 0 then
		x503030_Tips(sceneId, selfId, "#{KVKCS_130326_16}")
		return
	end
	-- 扣除材料
	LuaFnMtl_CostMaterial( sceneId, selfId, x503030_g_NeedItemNum,x503030_g_NeedItemID[1],x503030_g_NeedItemID[2])
	-- 通知
	x503030_Tips(sceneId, selfId, ScriptGlobal_Format("#{KVKCS_130326_13}",GetItemName(sceneId,selectRadioId)))
	-- 公告
	local playerName = GetName(sceneId,selfId)
	local itemTransInfo = GetBagItemTransfer( sceneId, selfId,bagidx )
	BroadMsgByChatPipe( sceneId, selfId,  ScriptGlobal_Format("#{KVKCS_130326_15}",playerName,itemTransInfo), 4 )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x503030_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x503030_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x503030_OnItemChanged( sceneId, selfId, itemdataId )
end

