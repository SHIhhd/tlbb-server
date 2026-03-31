--玄武岛镜 神兽脚本

x893084_g_scriptId=893084
--**********************************
--事件交互入口
--**********************************
function x893084_OnDefaultEvent( sceneId, selfId, targetId )

end
--**********************************
--初始化....
--**********************************
function x893084_OnInit(sceneId, selfId)
	--重置AI....
	--x893084_ResetMyAI( sceneId, selfId )
end
--**********************************
--心跳....
--**********************************
function x893084_OnHeartBeat(sceneId, selfId, nTick)
	
end
--**********************************
--进入战斗....
--**********************************
function x893084_OnEnterCombat(sceneId, selfId, enmeyId)	
	--重置AI....
	--x893084_ResetMyAI( sceneId, selfId )
	--发表讲话 出招吧
	--PaoPaoExEx(sceneId,selfId, 527)
	--设置进入战斗状态....
	--MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893084_IDX_CombatFlag, 1 )
end
--**********************************
--离开战斗....
--**********************************
function x893084_OnLeaveCombat(sceneId, selfId)
	--重置AI....
	--x893084_ResetMyAI( sceneId, selfId )
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end
--**********************************
--神兽死亡
--**********************************
function x893084_OnDie(sceneId, MonsterId, killerId)
	--归属队伍为使用魂神之卷的队伍时，使用者可获得魂玉奖励，其他人获得魂尘奖励
	--归属队伍不是使用魂神之卷队伍时，队内随机一人获得魂玉奖励，其他人获得魂尘奖励
	
	--创建者的OBJID
--	local nCreaterTeam = 0;
--	local nCreaterID = -1
--	local playerID = killerId
--	local objType = GetCharacterType( sceneId, killerId )
--	if objType == 3 then
--		playerID = GetPetCreator( sceneId, killerId )
--		nCreaterID = playerID
--	end
--	
--	local nCreaterGUID = LuaFnGetNpcIntParameter(sceneId,MonsterId,0);
--	if nCreaterGUID ~= LuaFnGetGUID(sceneId,playerID) then
--		--不是创建人
--		--遍历创建人所属队伍
--		if LuaFnHasTeam(sceneId,playerID) ~= 1 then
--			nCreaterTeam = 1
--		else
--			for i=0, GetTeamSize(sceneId,playerID)-1 do
--				local PlayerId = GetNearTeamMember( sceneId, playerID, i )
--				if LuaFnGetGUID(sceneId,PlayerId) == nCreaterGUID then
--					nCreaterTeam = 1
--					break
--				end
--			end
--		end
--	else
--		nCreaterTeam = 1
--	end
--	
--	
--	x893084_NotifyTips(sceneId,killerId,"x893084_OnDie killerId "..killerId)
end

--**********************************
-- 醒目失败提示
--**********************************
function x893084_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

