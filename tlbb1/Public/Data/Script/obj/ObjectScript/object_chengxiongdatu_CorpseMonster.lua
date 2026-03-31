--夺宝马贼

x807001_g_scriptId=807001
--**********************************
--事件交互入口
--**********************************
function x807001_OnDefaultEvent( sceneId, selfId, targetId )
	--判断是否能够激活该npc的条件
	if targetId == nil or targetId < 0 then
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId, "你在哪呢？我怎么看不到你！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetName(sceneId,targetId) ~= "夺宝马贼" then
		return
	end
	local npcLevel = GetCharacterLevel(sceneId, targetId)

	local teamCount = GetTeamMemberCount(sceneId, selfId)

	local teamLeaderID = GetTeamLeader(sceneId, selfId)

	local teamLeaderLevel = GetCharacterLevel(sceneId, teamLeaderID)
	
	--取得玩家附近的队友数量（包括自己）
	local nearteammembercount = GetNearTeamCount( sceneId, selfId )
	if  nearteammembercount < 1 then	
		BeginEvent(sceneId)
			AddText(sceneId, "胆敢小看我，至少3人组队才行噢, 哈哈。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif teamLeaderLevel < npcLevel then
		--提示条件不符
		BeginEvent(sceneId)
			AddText(sceneId, "胆敢小看我，等级再高些就知道我的厉害了")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	else
		--设置对怪为敌对的 目前是28号是敌对的，如果有人改变了相应的势力声望那我就惨了！！:-(((
		SetUnitReputationID(sceneId, selfId, targetId, 28)
	end
end
function x807001_OnEventRequest( sceneId, selfId, targetId )

end

function x807001_OnDie(sceneId, selfId, killerId)
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
	--马贼死亡
	local nearteammembercount = GetNearTeamCount( sceneId, playerID )
	for i=0, nearteammembercount-1  do
		local nPlayerId = GetNearTeamMember(sceneId,playerID, i)
		if LuaFnIsObjValid(sceneId,nPlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nPlayerId) == 1 then
			--周活跃数据埋点
			LuaFnFinishZhouHuoYueMission(sceneId,nPlayerId,7)
		end
	end	

end

