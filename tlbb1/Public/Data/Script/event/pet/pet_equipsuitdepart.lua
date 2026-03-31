--珍兽装备拆解
--build 2019-8-2 17:17:47
x800122_g_ScriptId = 800122
--**********************************
--珍兽装备拆解
--**********************************
function x800122_OnPetEquipSuitDepart(sceneId,selfId,nPos,nTarget)
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x800122_NotifyTip( sceneId, selfId, "#{OR_PILFER_LOCK_FLAG}" )	
		return
	end
	if nPos == nil or nTarget == nil then
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
		x800122_NotifyTip( sceneId, selfId, "#{ZSZBSJ_090706_02}" )
		return
	end
	--获取拆解获得的数量
	local nDepartItemID,nItemCount = LuaFnGetPetEquipSuitDepartItemCount(sceneId,selfId,nPos);
	if nDepartItemID <= 0 then
		--只有装备说明中注明了可拆解的珍兽套装才可使用该功能
		x800122_NotifyTip(sceneId,selfId,"#{ZSZBSJ_090706_08}")
		return
	end
	BeginAddItem(sceneId)
	AddItem( sceneId,nDepartItemID, nItemCount )
	if LuaFnEndAddItemIgnoreFatigueState(sceneId,selfId) < 0 then
		--空间不够，中断
		return
	end
	local nRet,nMaterialNum = LuaFnDoPetEquipSuitDepart(sceneId,selfId,nPos)
	if (nRet == -1) then
		--只有装备说明中注明了可拆解的珍兽套装才可使用该功能
		x800122_NotifyTip(sceneId,selfId,"#{ZSZBSJ_090706_08}")
		return
	elseif (nRet == -2) then
		--拆解珍兽套装失败，你拆解的珍兽套装消失。
		x800122_NotifyTip(sceneId,selfId,"#{ZSZBSJ_090706_12}")
		return
	elseif (nRet == -3) then
		--加锁了
		x800122_NotifyTip(sceneId,selfId,"#{ZSZBSJ_090706_02}")
		return
	elseif nRet == 0 then
		LuaFnRefreshItemInfo( sceneId, selfId, nPos )
		--给予物品
		AddItemListToHuman(sceneId,selfId)
		x800122_NotifyTip( sceneId, selfId, "#{ZSZBSJ_090706_10}"..nMaterialNum.."#{ZSZBSJ_090706_11}" )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	end
	
end
--**********************************
--醒目提示
--**********************************
function x800122_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end