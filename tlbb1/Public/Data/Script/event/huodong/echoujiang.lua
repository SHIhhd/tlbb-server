--NPC抽奖

x808062_g_ScriptId						= 808062

--**********************************
--列举事件
--**********************************
function x808062_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x808062_g_ScriptId, "领取活动奖励", 6, 1)
end

--**********************************
--任务入口函数
--**********************************
function x808062_OnDefaultEvent( sceneId, selfId, targetId )
	local TextNum = GetNumText()
	if TextNum == 1 then
		CallScriptFunction( PRIZE_SCRIPT_ID, "AskPrize", sceneId, selfId,targetId)
	end
end

--**********************************
--领取奖励
--**********************************
function x808062_OnGetPrize( sceneId, selfId, targetId,nSelect )
	if sceneId ~= SCENE_DALI then
		x808062_NotifyMsg( sceneId, selfId, "#{LJSJ_160308_14}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x808062_NotifyMsg( sceneId, selfId, "#{LJSJ_160308_16}" )
		return
	end
	CallScriptFunction( PRIZE_SCRIPT_ID, "AskGetPrize", sceneId, selfId,nSelect)
end

--**********************************
--玩家上线
--**********************************
function x808062_OnPlayerLogin( sceneId, selfId )
	local nPrizeTip = HaveNewPrizeTips(sceneId,selfId)
	if nPrizeTip < 1 then
		return
	end
	if nPrizeTip == 1 then
		--账号下
		DispatchMsgBall(sceneId,selfId,48)
		LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LJSJ_160308_01}" )
	elseif nPrizeTip == 2 then
		--角色下
		DispatchMsgBall(sceneId,selfId,47)
		LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LJSJ_160308_02}" )
	end
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x808062_NotifyMsg( sceneId, selfId, msg )
	BeginEvent(sceneId);
		AddText(sceneId, msg);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
