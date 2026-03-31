--地宫四层场景逻辑

--脚本号
x998262_g_ScriptId = 998262
--开始及终止时间
x998262_g_StartTipTime = 195000
x998262_g_StartTime = 210000
x998262_g_EndTime = 235900

--**********************************
--场景计时器[tick 1s]
--**********************************
function x998262_OnSceneTimer( sceneId )
	local curTime = GetHour() * 10000 + GetMinute() * 100 + GetSecond();
	--提示时间
	if curTime == x998262_g_StartTipTime then
		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:#{DLZX_230314_01}")
	elseif curTime == x998262_g_StartTime then
		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:#{DLZX_230314_02}")
	end
	--结束
	if curTime == x998262_g_EndTime then
		--全局公告
		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:#{DLZX_230314_03}")
		--传送所有玩家至大理
		x998262_TransPlayerToHome( sceneId )
	end
	--未在活动时间
	if x998262_IsInActiveTime( sceneId) ~= 1 then
		--传送所有玩家至大理
		x998262_TransPlayerToHome( sceneId )
	end
end
--**********************************
--传送所有玩家至大理
--**********************************
function x998262_TransPlayerToHome( sceneId )
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount <= 0 then
		return
	end
	for i = 0,nHumanCount - 1 do
		local nHumanID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanID) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanID) == 1 then
			CallScriptFunction(400900, "TransferFunc", sceneId, nHumanID, 2, 160, 113 )
		end
	end
end
--**********************************
--玩家死亡
--**********************************
function x998262_OnSceneHumanDie( sceneId,selfId,killerId)
	
end
--**********************************
--是否在活动时间
--**********************************
function x998262_IsInActiveTime( sceneId )
	local curTime = GetHour() * 10000 + GetMinute() * 100 + GetSecond();
	if curTime >= x998262_g_StartTime and curTime < x998262_g_EndTime then
		return 1
	end
	return 0
end

--**********************************
--玩家进入场景
--**********************************
function x998262_OnPlayerEnterScene( sceneId,selfId,isReconnect)
	if sceneId ~= SCENE_DILING then
		return
	end
	--特殊保护效果
	if isReconnect == 0 then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5972, 100 )
		x998262_NotifyTip( sceneId, selfId, "#{DLZX_230314_118}" )			
	end
	
end

--**********************************
-- 驱毒时间倒计时结束后逻辑
--**********************************
function x998262_OnImpactFadeOut( sceneId, selfId, impactId )
	if sceneId ~= SCENE_DILING then
		return
	end
	CallScriptFunction(400900, "TransferFunc", sceneId, selfId, 2, 160, 113 )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x998262_NotifyBox( sceneId, selfId,targetId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x998262_NotifyTip( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
