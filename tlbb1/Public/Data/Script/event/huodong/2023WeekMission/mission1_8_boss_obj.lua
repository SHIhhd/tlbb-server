--雪山禁地-冰蚀木魇

--脚本号
x890135_g_ScriptId	= 890135
--任务参数
x890135_g_MissionId = 2155
x890135_g_IsMissionOkFail = 0--是否完成
x890135_g_KillNumber = 1
--**********************************
--入口函数
--**********************************
function x890135_OnDefaultEvent( sceneId, selfId, targetId )
	
end
--**********************************
--事件列表选中一项
--**********************************
function x890135_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--重置AI....
--**********************************
function x890135_ResetMyAI( sceneId, selfId )
end

--**********************************
--初始化....
--**********************************
function x890135_OnInit(sceneId, selfId)
	--重置AI....
	x890135_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x890135_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end	
end

--**********************************
--技能释放成功
--**********************************
function x890135_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
end
--**********************************
--进入战斗....
--**********************************
function x890135_OnEnterCombat(sceneId, selfId, enmeyId)
end

--**********************************
--离开战斗....
--**********************************
function x890135_OnLeaveCombat(sceneId, selfId)
end

--**********************************
--杀死敌人....
--**********************************
function x890135_OnKillCharacter(sceneId, selfId, targetId)
end

--**********************************
--死亡....
--**********************************
function x890135_OnDie( sceneId, selfId, killerId )
	--遍历玩家，标记任务完成
	--杀死怪物的是宠物则获取其主人的Id....
	local playerID = killerId
	local objTypeEx = GetCharacterType( sceneId, killerId )
	if objTypeEx == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
	if LuaFnHasTeam(sceneId,playerID) == 0 then
		-- 已经接取了任务
		if IsHaveMission(sceneId,playerID,x890135_g_MissionId) > 0 then
			local misIndex = GetMissionIndexByID( sceneId, playerID, x890135_g_MissionId )
			SetMissionByIndex( sceneId, playerID, misIndex, x890135_g_IsMissionOkFail,1 )
			SetMissionByIndex( sceneId, playerID, misIndex, x890135_g_KillNumber,1 )
		end
	else
		local	nearteammembercount = GetNearTeamCount( sceneId, playerID) 
		for	i=0,nearteammembercount-1 do
			local memObjId = GetNearTeamMember(sceneId, playerID, i)
			-- 已经接取了任务
			if IsHaveMission(sceneId,memObjId,x890135_g_MissionId) > 0 then
				local misIndex = GetMissionIndexByID( sceneId, memObjId, x890135_g_MissionId )
				SetMissionByIndex( sceneId, memObjId, misIndex, x890135_g_IsMissionOkFail,1 )
				SetMissionByIndex( sceneId, memObjId, misIndex, x890135_g_KillNumber,1 )
			end
		end
	end
	--标记副本结束
	LuaFnSetCopySceneData_Param( sceneId, 9, 1 )	
	LuaFnSetCopySceneData_Param(sceneId, 4, 1);
end

--**********************************
--对话框提示
--**********************************
function x890135_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

