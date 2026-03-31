--时装染色还原
--脚本号
x830002_g_scriptId = 830002
x830002_DressPraintNeedMoney = 50000

--**********************************
--时装染色还原
--**********************************
function x830002_OnDressWash(sceneId,selfId,nPos)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if nPos == nil or nPos < 0 then
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < x830002_DressPraintNeedMoney then
        x830002_Tips( sceneId, selfId,  "#{RXZS_090804_11}" )
        return
	end
	--从客户端清理出去
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 910283 )
	--执行操作
	local nRet = LuaFnDoDressWash(sceneId,selfId,nPos);
	if nRet <= 0 then
		x830002_Tips( sceneId, selfId, "#{SZPR_091023_27}" )
		return
	end
	LuaFnCostMoneyWithPriority( sceneId, selfId, x830002_DressPraintNeedMoney)
	x830002_Tips( sceneId, selfId,  "#{SZPR_091023_86}" )
end

--**********************************
--提示信息
--**********************************
function x830002_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end