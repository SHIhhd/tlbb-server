--珍兽装备进阶
--build 2019-8-2 17:17:47
x800109_g_ScriptId = 800109
x800109_g_Item_ShenShouLing = 20301009

--**********************************
--珍兽装备进阶
--**********************************
function x800109_OnPetEquipSuitUp(sceneId,selfId,nPos,nTarget)
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x800109_NotifyTip( sceneId, selfId, "#{OR_PILFER_LOCK_FLAG}" )	
		return
	end
	if nPos == nil or nTarget == nil then
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
		x800109_NotifyTip( sceneId, selfId, "#{ZSZBSJ_090706_02}" )
		return
	end
	local nRet,nNewQual = LuaFnDoPetEquipSuitUp(sceneId,selfId,nPos);
	if nRet == -1 then
		--只有装备说明中注明了可提升星级的珍兽套装才可使用该功能
		x800109_NotifyTip(sceneId,selfId,"#{ZSZBSJ_090706_03}")
		return
	elseif nRet == -2 then
		--金钱不足
		x800109_NotifyTip(sceneId,selfId,"#{ZSZB_090421_24}")
		return
	elseif nRet == -3 then
		--您身上携带的材料数量不足
		x800109_NotifyTip(sceneId,selfId,"#{ZSZBSJ_090706_04}")
		return
	elseif nRet == -4 then
		x800109_NotifyTip( sceneId, selfId, "#{ZSZBSJ_090706_02}" )
		return
	elseif nRet == 0 then
		LuaFnRefreshItemInfo( sceneId, selfId, nPos )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		x800109_NotifyTip( sceneId, selfId,  "#{ZSZBSJ_090706_05}" )
		--四星以上发广播
		if nNewQual >= 4 then
			local nMessage = "#{_INFOUSR"..GetName(sceneId,selfId).."}"
			local szTranItm	= GetBagItemTransfer( sceneId, selfId, nPos )
			nMessage = nMessage.."#{ZSZB_14}#G圣兽鳞#{ZSZB_15}"..nNewQual.."#{ZSZB_16}"..format("#{_INFOMSG%s}",szTranItm).."#{ZSZB_17}"
			AddGlobalCountNews( sceneId,nMessage)
		end
	end
end
--**********************************
--醒目提示
--**********************************
function x800109_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end