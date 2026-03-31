--特殊运营修改-摆摊回调 
--雪舞@WAYLEE 2025-12-14

--脚本号
x410002_g_ScriptId = 410002

-- 总控开关
x410002_g_MF_BAN = 0 --flag为0/1的时候,就禁止交易

-- MFEX_IS_BAN_EXCHANGE			= 116	-- 是否禁止交易
-- MFEX_IS_BAN_STALL				= 117	-- 是否禁止摆摊
-- MFEX_IS_BAN_RECEXCHANGE		= 118	-- 是否允许被交易
-- MFEX_IS_BAN_STALLBUY			= 119	-- 是否禁止摆摊购买

--**********************************
--请求摆摊  返回值:0允许 其他拒绝
--**********************************
function x410002_stallAllow( sceneId, selfId, nMovieId)
	if LuaFnIsObjValid(sceneId, selfId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then
		return 1
	end
	if GetMissionFlagEx(sceneId, selfId,MFEX_IS_BAN_STALL) == x410002_g_MF_BAN then
		x410002_NotifyTip(sceneId,selfId,"没有摆摊权限!")
		return 1; 
	end
	return 0; 
end

--**********************************
-- 摆摊购买回调 返回值:2允许 其他拒绝
--**********************************
function x410002_stallBuy(sceneId, selfId)
	if LuaFnIsObjValid(sceneId, selfId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then
		return 1
	end
	if GetMissionFlagEx(sceneId, selfId,MFEX_IS_BAN_STALLBUY) == x410002_g_MF_BAN then
		x410002_NotifyTip(sceneId,selfId,"没有摆摊购买权限!")
		return 1; 
	end
	return 0; 
end

--**********************************
-- 交易请求 返回值:0允许 其他拒绝
--**********************************
function x410002_exchangeAllow( sceneId, selfId, tarobjID)
	if LuaFnIsObjValid(sceneId, selfId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then
		return 1
	end
	if LuaFnIsObjValid(sceneId, tarobjID) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,tarobjID) ~= 1 then
		return 1
	end
	if GetMissionFlagEx(sceneId, selfId,MFEX_IS_BAN_EXCHANGE) == x410002_g_MF_BAN then
		x410002_NotifyTip(sceneId,selfId,"你没有交易权限!")
		return 1; 
	end
	
	if GetMissionFlagEx(sceneId,tarobjID,MFEX_IS_BAN_EXCHANGE) == x410002_g_MF_BAN then
		x410002_NotifyTip(sceneId,selfId,"目标玩家没有交易权限!")
		return 1; 
	end
	return 0; 
end


--**********************************
-- 元宝交易市场请求 返回值:0允许 其他拒绝
-- opType: 0=购买 1=上架
--**********************************
function x410002_YBMarketAllow(sceneId, selfId, opType)
	if LuaFnIsObjValid(sceneId, selfId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId, selfId) ~= 1 then
		return 1
	end

	if GetMissionFlagEx(sceneId, selfId, MFEX_IS_BAN_YBMARKET) == x410002_g_MF_BAN then
		if opType == 0 then
			x410002_NotifyTip(sceneId, selfId, "你没有元宝交易市场购买权限!")
		else
			x410002_NotifyTip(sceneId, selfId, "你没有元宝交易市场上架权限!")
		end
		return 1
	end

	return 0
end

--**********************************
--醒目提示
--**********************************
function x410002_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
