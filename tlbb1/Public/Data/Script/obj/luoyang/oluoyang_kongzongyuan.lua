--洛阳NPC
--孔宗渊
--普通

x000124_g_ScriptId	= 000124

--操作集
x000124_g_Key				=
{
		["do"]					= 100,	--确定
		["undo"]				= 101,	--取消
		["do_protect"]			= 102,	--确定
}

--******************************************************
--事件交互入口
--******************************************************
function x000124_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{SCGZ_091119_01}" )
		AddNumText( sceneId, x000124_g_ScriptId, "#{SCGZ_091119_02}", -1, x000124_g_Key["do"] )
		AddNumText( sceneId, x000124_g_ScriptId, "#{SCGZ_091119_03}", -1, x000124_g_Key["do_protect"] )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000124_OnEventRequest( sceneId, selfId, targetId, eventId )
	local	key	= GetNumText()

	if key == x000124_g_Key["do"]	then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 42 )
		return
	end
	if key == x000124_g_Key["do_protect"]	then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, x000124_GetApplyState(sceneId,selfId) )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 43 )
		return
	end
end

--******************************************************
--销毁任务物品
--由Client\Interface\MissionObjDel\MissionObjDel.lua发出
--******************************************************
function x000124_OnDestroy( sceneId, selfId, posItem )
	if posItem < 0 then
		return
	end
	
	local idItem = LuaFnGetItemTableIndexByIndex( sceneId, selfId, posItem )
	
	if idItem == 40002109 then 
		
		local ret = DelMission( sceneId, selfId, 4021 )
		if ret > 0 then		
			SetCurTitle(sceneId, selfId,  0, 124)
			DeleteTitle( sceneId, selfId,  5)
			LuaFnDispatchAllTitle(sceneId, selfId)			
			SetMissionData(sceneId,selfId,MD_CAOYUN_HUAN,0)
			SetMissionData(sceneId,selfId,MD_CAOYUN_MONSTERTIMER,0)
			LuaFnCancelSpecificImpact(sceneId,selfId,113)
		end
	
	end
	EraseItem( sceneId, selfId, posItem )
	x000124_OnDestroyLaborDay( sceneId, selfId, idItem )
end

--******************************************************
--销毁任务物品的特殊处理 五一节赠送活动
--刘盾 2008-04-17
--******************************************************
function x000124_OnDestroyLaborDay( sceneId, selfId, idItem )
	if(GlobalLaborDayActivityTable.PetCageCardID == idItem) then
		local hasImapct = LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, GlobalLaborDayActivityTable.PetCageDelayBuff)
		if ( hasImapct > 0 ) then
			LuaFnCancelSpecificImpact(sceneId, selfId, GlobalLaborDayActivityTable.PetCageDelayBuff)
		end
	end
end
--******************************************************
--贵重物品销毁申请
--******************************************************
function x000124_ApplyDelProtectGoods( sceneId, selfId, targetId,nType )
	if nType == 1 then
		--申请
		SetMissionDataEx(sceneId,selfId,MDEX_PROTECT_GOODS_APPLY,LuaFnGetCurrentTime())
	elseif nType == 0 then
		--取消申请
		SetMissionDataEx(sceneId,selfId,MDEX_PROTECT_GOODS_APPLY,0)
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		UICommand_AddInt( sceneId, x000124_GetApplyState(sceneId,selfId) )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 43 )
end
--******************************************************
--贵重物品销毁
--******************************************************
function x000124_DelProtectGoods( sceneId, selfId, targetId,nBagPos )
	local nCurState = x000124_GetApplyState(sceneId,selfId)
	if nCurState == 0 then
		x000124_NotifyBox( sceneId, selfId,  "#{SCGZ_091119_09}" )
		return
	end
	if nCurState == 1 then
		x000124_NotifyBox( sceneId, selfId,  "#{SCGZ_091119_08}" )
		return
	end
	--不是贵重
	if IsGoodsProtect_Goods(sceneId,selfId,nBagPos) ~= 1 then
		x000124_NotifyBox( sceneId, selfId,  "#{SCGZ_091119_10}" )
		return
	end
	LuaFnEraseItem(sceneId,selfId,nBagPos);
	--日志统计
	local guid = LuaFnObjId2Guid(sceneId, selfId)
	local log = format("ItemPos=%d", nBagPos)
	ScriptGlobal_AuditGeneralLog(LUAAUDIT_GOODS_PROTECT_DELETE, guid, log)
	--销毁后处理
	SetMissionDataEx(sceneId,selfId,MDEX_PROTECT_GOODS_APPLY,0)
end
--******************************************************
--获取申请状态
--获得当前申请删除贵重物品的状态，0：未申请；1：正在申请；2：获得删除资格
--******************************************************
function x000124_GetApplyState(sceneId,selfId)
	local nCurrentTime = LuaFnGetCurrentTime();
	local nEraseApplyTime = LuaFnGetGoodsEraseApplyTime();
	local nEraseActiveTime = LuaFnGetGoodsEraseActiveTime();

	local nApplyTime = GetMissionDataEx(sceneId,selfId,MDEX_PROTECT_GOODS_APPLY);
	local nState = 0;
	if nApplyTime <= 0 then
		nState = 0;	--未申请
	elseif nCurrentTime - nApplyTime <= nEraseApplyTime then
		nState = 1; --正在申请
	elseif nCurrentTime - nApplyTime > nEraseApplyTime and nCurrentTime - nApplyTime <= nEraseApplyTime + nEraseActiveTime then
		nState = 2;
	else
		nState = 0;
	end
	return nState
end
--**********************************
--邮件提醒
--**********************************
function x000124_LoginMail( sceneId, selfId )
	local nCurState = x000124_GetApplyState(sceneId,selfId);
	if nCurState == 1 then
		LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{SCGZ_091119_12}" )
	--elseif nCurState == 2 then 这里程序通知
	--	LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{SCGZ_091119_13}" )	
	end
end
--**********************************
--信息提示
--**********************************
function x000124_NotifyBox( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
