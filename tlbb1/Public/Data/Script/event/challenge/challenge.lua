-- challenge.lua
-- 挑战相关脚本

x806010_g_ScriptId = 806010
-- 观战buff
x806010_g_ViewBuff = 2693

x806010_g_TChallengeScript = 890025

-- 判断该玩家是否处在挑战区域
function x806010_HaveChallengeFlag( sceneId, selfId )
	--藏经阁校场休息室全图可挑战
	if sceneId == SCENE_TCHALLENGE then
		return 1;
	end
	return (GetMissionData( sceneId, selfId, MD_TIAOZHAN_SCRIPT ) > 0)
end

-- 让 selfId (及队友) 挑战 targetId (及队友)
function x806010_ProcChallenge( sceneId, selfId, targetId )
	
	if sceneId ~= SCENE_TCHALLENGE then
		local ChallengeScript = GetMissionData( sceneId, selfId, MD_TIAOZHAN_SCRIPT )
		if ChallengeScript ~= GetMissionData( sceneId, targetId, MD_TIAOZHAN_SCRIPT ) then
			return
		end
		-- 调用具体的挑战脚本，每个擂台应该绑定一个脚本
		CallScriptFunction(ChallengeScript, "DoChallenge", sceneId, selfId, targetId )
	else
		-- 调用具体的挑战脚本，每个擂台应该绑定一个脚本
		CallScriptFunction(x806010_g_TChallengeScript, "DoChallenge", sceneId, selfId, targetId )
	end
	--封魂录埋点更新
	CallScriptFunction(791010, "AddPointData", sceneId, selfId, 12);
end

--**********************************
--程序回调 请求进入观战场景
--**********************************
function x806010_AskEnterChallengeView( sceneId, selfId, tarSceneId )
--	SJBW_130823_65	#H您当前正处在变身状态，暂时无法进入	
--	SJBW_210415_02	#H请先取消您的骑乘状态再进行观战	
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		x806010_NotifyTip(sceneId,selfId,"#{SJBW_210415_02}")
		return
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
		x806010_NotifyTip(sceneId,selfId,"#{SJBW_130823_65}")
		return
	end
--	SJBW_130823_66	#H您当前正处在跑商状态，暂时无法进入	
--	SJBW_130823_67	#H您当前正处在漕运状态，暂时无法进入	
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x806010_NotifyTip(sceneId,selfId,"#{SJBW_130823_67}")
		return
	elseif LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113) == 1 then
		x806010_NotifyTip(sceneId,selfId,"#{SJBW_130823_66}")
		return
	end
--	SJBW_210415_01	#H请先将珍兽收回后再进行观战	
	local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
	if pgH ~= nil and pgH > 0 then
		x806010_NotifyTip(sceneId,selfId,"#{SJBW_210415_01}")
		return
	end
--	SJBW_210415_03	#H组队跟随状态下无法进行观战	
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x806010_NotifyTip(sceneId,selfId,"#{SJBW_210415_03}")
		return
	end
	if LuaFnIsCanDoScriptLogic( sceneId, selfId ) == 1 then
		--增加观战BUFF
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x806010_g_ViewBuff, 0)
		--送到目标副本场景
		NewWorld( sceneId, selfId, tarSceneId, 32, 33)
	end
end

--**********************************
--任务入口函数
--**********************************
function x806010_OnDefaultEvent( sceneId, selfId, targetId )
	--呼出挑战观战UI
	LuaFnAskChallengeList(sceneId,selfId)
end

--**********************************
--列举事件
--**********************************
function x806010_OnEnumerate( sceneId, selfId, targetId )
	--添加按钮
	AddNumText(sceneId,x806010_g_ScriptId,"#{SJBW_130823_49}", 6,50)
	return
end

--**********************************
--检测接受条件
--**********************************
function x806010_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x806010_OnAccept( sceneId, selfId )
end

--**********************************
-- 玩家个人全屏提示
--**********************************
function x806010_NotifyTip(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
