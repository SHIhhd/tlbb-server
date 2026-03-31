--外观中心-配饰操作

x999361_g_ScriptId = 999361
x999361_g_NPCPos = {253.8,130.1}

x999361_g_Limit_Lv	= 30			-- 限制等级
x999361_g_Need_Money	= 50000		-- 需要金钱
x999361_g_eOpType = {
	Back = 0,
	Head = 1,
}
x999361_g_OrnamentState				= {
	INVALID	= 0,	-- 无效
	EMPTY	= 1,	-- 空闲
	TIME	= 2,	-- 限时
	TIMEOUT	= 3,	-- 过期
	FOREVER	= 4,	-- 永久
}

--**********************************
-- 穿戴饰品 (由客户端UI命令回调触发)
-- 客户端收到 DispatchUICommand 后通过 Send_XSCRIPT 回调此函数
-- 此时是独立的 CGExecuteScriptHandler 请求，与脱下/改位置不在同一帧
--**********************************
function x999361_EquipOrnament( sceneId, selfId, nOpType,nExteriorId)
	 if nOpType ~= 0 and nOpType ~= 1 then
        return
    end
    
    if nExteriorId == nil or nExteriorId <= 0 then
        x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_57}")
        return
    end
    
    -- 检查饰品是否存在且有效
    local nIdx, nState = LuaFnGetPlayerOrnamentsInfo(sceneId, selfId, nOpType, nExteriorId)
    if nIdx < 0 or (nState ~= x999361_g_OrnamentState.FOREVER and nState ~= x999361_g_OrnamentState.TIME) then
        x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_48}")
        return
    end
    
    -- 穿上
    LuaFnSetOrnamentInUse(sceneId, selfId, nOpType, nExteriorId)
end

--**********************************
-- 调整装饰物位置
-- 流程: 脱下 → 改位置 → 发UI命令让客户端回调穿上
--**********************************
function x999361_ChangeOrnamentsPos( sceneId, selfId, nOpType,nExteriorId,nX,nY,nZ)
	local nIdx, nState = LuaFnGetPlayerOrnamentsInfo(sceneId,selfId,nOpType, nExteriorId)
	if nIdx < 0 or (nState ~= x999361_g_OrnamentState.FOREVER and nState ~= x999361_g_OrnamentState.TIME) then
		x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_48}") --#H该图鉴尚未激活，无法调整位置。
		return
	end
	--不能调节位置
	local nPosXMin, nPosXMax, nPosYMin,nPosYMax,nPosZMin, nPosZMax, nPosAdjust = LuaFnGetOrnamentsInfo(nOpType, nExteriorId, "Pos")
	if nPosAdjust == nil or nPosAdjust ~= 1 then
		return
	end
	if nX < nPosXMin or nX > nPosXMax then
		x999361_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{BGTS_220125_45}",nPosXMin,nPosXMax))
		return
	end
	if nY < nPosYMin or nY > nPosYMax then
		x999361_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{BGTS_220125_46}",nPosYMin,nPosYMax))
		return
	end
	if nZ < nPosZMin or nZ > nPosZMax then
		x999361_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{BGTS_220125_47}",nPosZMin,nPosZMax))
		return
	end
	
	local nCurId = LuaFnGetOrnamentInUseId(sceneId, selfId, nOpType)
	if nCurId > 0 and nCurId == nExteriorId then
		-- 正在穿戴: 脱下 → 改位置 → 发UI命令让客户端回调穿上
		LuaFnSetOrnamentInUse(sceneId, selfId, nOpType, 0)
		LuaFnChangeOrnamentsUnitPosition(sceneId, selfId, nOpType, nExteriorId, nX, nY, nZ)

		-- 发UI命令通知客户端回调穿上
		local tReequipUIID = { [0] = 202602162, [1] = 202602161 }
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, nOpType)
		UICommand_AddInt(sceneId, nExteriorId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, tReequipUIID[nOpType])
	else
		-- 未穿戴: 直接改位置即可
		LuaFnChangeOrnamentsUnitPosition(sceneId, selfId, nOpType, nExteriorId, nX, nY, nZ)
	end
	x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_57}")
end

--**********************************
--解锁装饰物
--**********************************
function x999361_UnlockOrnaments( sceneId, selfId, nBagPos,itemId,nOpType,nCheck )
	if sceneId ~= 0 then
		x999361_NotifyTips( sceneId, selfId, "#{HSRL_220214_2}" )
		return
	end
	--取距离
	local nPosX,nPosY = LuaFnGetUnitPosition(sceneId, selfId);
	local nKPosX,nKPosY = x999361_g_NPCPos[1],x999361_g_NPCPos[2]
	local nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
	if nDistance > 12 then
		x999361_NotifyTips( sceneId, selfId, "#{HSRL_220214_3}" )
		return
	end
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
	--道具已加锁
	if LuaFnIsItemLocked(sceneId, selfId, nBagPos) ~= 0 then
		x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_17}" )
		return
	end
	local itemtype, idx, lifetimeex = LuaFnGetOrnamentsItemInfo(itemId)
	if itemtype < 0 then
		if nOpType == x999361_g_eOpType.Back then
			x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_16}" )
		elseif nOpType == x999361_g_eOpType.Head then
			x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_31}" )
		end
		return
	end
	--带计时物品要弹窗二次确认
	if nCheck == 1 then
		if lifetimeex > 0 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId,nOpType)
				UICommand_AddInt( sceneId,nBagPos)
				UICommand_AddInt( sceneId,itemId)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 99936110 )   
			return
		end
	end
	--带时效的饰品有激活数限制
	--目前暂时不设计计时
	if lifetimeex > 0 then
		
	end
	local strName = LuaFnGetOrnamentsInfo(nOpType, idx, "Name")
	local nIdx, nState = LuaFnGetPlayerOrnamentsInfo(sceneId,selfId,nOpType, idx)
	if nIdx > 0 and nState == x999361_g_OrnamentState.FOREVER then
		x999361_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{BGTS_220125_22}",strName))
		return
	end
	local nRet,nLeftTime = LuaFnAddOrnamentsUnit(sceneId,selfId,nBagPos)
	if nRet == 1 then
		--扣除物品
		LuaFnEraseItem(sceneId,selfId,nBagPos)
		--调整UI
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99936102 )   
			
		if nLeftTime == -1 then
			x999361_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{BGTS_220125_19}",strName))
		else
			x999361_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{BGTS_220125_21}",ceil(nLeftTime / 24)))
		end
		--效果
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
	else
		if nOpType == x999361_g_eOpType.Back then
			x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_20}" )
		elseif nOpType == x999361_g_eOpType.Head then
			x999361_NotifyTips( sceneId, selfId, "#{BGTS_220125_32}" )
		end
	end
end

--**********************************
--提示信息
--**********************************
function x999361_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
