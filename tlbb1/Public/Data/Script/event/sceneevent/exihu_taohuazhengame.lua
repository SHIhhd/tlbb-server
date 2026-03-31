x212135_g_ScriptId	= 212135
x212135_g_MissionId	= 1164
x212135_g_Name		= "桃夭夭"
x212135_g_MissionItem	= 40004471
x212135_g_TickCount = 2 --记录已经开始多久了
x212135_g_GameTeamID = 6 --保存队伍号，用于提示只给自己队伍
x212135_g_GameStrat = 8 --当前场景桃花阵是否正在进行中
x212135_g_GameLevels = 9 --当前游戏第几关了
x212135_g_GameLeaderMonster = 10 --是否创建木桩
x212135_g_TickOut = 11 --倒计时数据
x212135_g_flash_delayed = 12 --闪烁延时
x212135_g_flashing_completed = 25 --当前阶段闪烁完毕
x212135_g_flashing_frequency = 26 --闪烁次数
x212135_g_Challenge_failed = 27 --挑战失败记录
x212135_g_LeaderClick = 28 --队长点击桃花的次数
x212135_g_notLeaderClick = 29 --非队长点击桃花的次数
x212135_g_GamenotLeaderMonster = 30 --是否创建木桩
x212135_g_GameoldLevels = 31 --历史关卡记录
x212135_g_EndTimeData = 240 --游戏结束时长
--这里是记录每个地图的桃夭夭的基础坐标点，用于将玩家固定到哪个坐标点用的数组
x212135_g_ScenePos = 
{
	[4] = {244,142}, --太湖
	[7] = {147,48}, --剑阁
	[8] = {166,95}, --敦煌
	[24] = {191,269}, --洱海
	[121] = {231,118} --夜西湖
}
x212135_g_DebugTxt = 
{
	[81] = "红",
	[82] = "黄",
	[83] = "蓝",
	[84] = "绿",
	[85] = "紫"
}
x212135_g_MonsterData = {81,82,83,84,85} --桃花阵专用木桩
x212135_g_LeaderflashData = {13,14,15,16,17,18} --队长桃花阵记录闪烁数据
x212135_g_notLeaderflashData = {19,20,21,22,23,24} --非队长桃花阵记录闪烁数据
x212135_g_LeaderImpact = {10528,10525} --队长用的状态
x212135_g_notLeaderImpact = {10529,10526} --非队长用的状态
x212135_g_LoserImpact = 10527 --失败者专用
x212135_g_SuccessImpact = {10535,10536} --成功后第一个给队长，第二个给非队长
x212135_g_FailImpact = {10537,10538} --失败后第一个给队长，第二个给非队长
x212135_g_CurrencyImapct = 10539 --通用启动桃花阵给的状态
x212135_g_ColourData = 
{	--怪物ID，闪烁颜色状态，记录都闪烁啥了。
	[81] = 10530,
	[82] = 10531,
	[83] = 10532,
	[84] = 10533,
	[85] = 10534
}
--当前关卡闪烁几次
x212135_g_LevelsNumber = 
{
	[1] = 2,
	[2] = 3,
	[3] = 4,
	[4] = 5,
	[5] = 6
}
--**********************************
--任务入口函数
--**********************************
function x212135_OnDefaultEvent( sceneId, selfId, targetId )
	if GetMonsterDataID(sceneId,targetId) >= 81 and GetMonsterDataID(sceneId,targetId) <= 85 then
		local completed = LuaFnGetSceneData_TempParam(sceneId,x212135_g_flashing_completed)
		if completed > 0 then
			local nLevels = LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameLevels)
			local leaderclick = LuaFnGetSceneData_TempParam(sceneId,x212135_g_LeaderClick)
			local notleaderclick = LuaFnGetSceneData_TempParam(sceneId,x212135_g_notLeaderClick)
			if GetTeamId(sceneId,selfId) ~= LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameTeamID) then
				x212135_NotifyTips(sceneId,selfId,"#{QSJS_090602_004}")
				return
			end
			--得知道点击桃花的玩家是队长还是啥？
			if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
				notleaderclick = notleaderclick + 1
				if notleaderclick <= x212135_g_LevelsNumber[nLevels] then
					LuaFnSetSceneData_TempParam(sceneId,x212135_g_notLeaderClick,notleaderclick)
					--判断点错了吗
					if LuaFnGetSceneData_TempParam(sceneId,x212135_g_notLeaderflashData[notleaderclick]) ~= GetMonsterDataID(sceneId,targetId) then
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_Challenge_failed,1)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_completed,0)
						return
					end
					if notleaderclick == x212135_g_LevelsNumber[nLevels] and LuaFnGetSceneData_TempParam(sceneId,x212135_g_LeaderClick) == x212135_g_LevelsNumber[nLevels] then
						--直接进入下一关了
						nLevels = nLevels + 1
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameLevels,nLevels)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_completed,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_frequency,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_TickOut,6)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_notLeaderClick,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_LeaderClick,0)
					end
					LuaFnSetSceneData_TempParam(sceneId,x212135_g_notLeaderflashData[notleaderclick],0)
					LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,targetId,x212135_g_ColourData[GetMonsterDataID(sceneId,targetId)],0)
				end
			else
				leaderclick = leaderclick + 1
				if leaderclick <= x212135_g_LevelsNumber[nLevels] then
					LuaFnSetSceneData_TempParam(sceneId,x212135_g_LeaderClick,leaderclick)
					--判断点错了吗
					if LuaFnGetSceneData_TempParam(sceneId,x212135_g_LeaderflashData[leaderclick]) ~= GetMonsterDataID(sceneId,targetId) then
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_Challenge_failed,1)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_completed,0)
						return
					end
					if leaderclick == x212135_g_LevelsNumber[nLevels] and LuaFnGetSceneData_TempParam(sceneId,x212135_g_notLeaderClick) == x212135_g_LevelsNumber[nLevels] then
						--直接进入下一关了
						nLevels = nLevels + 1
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameLevels,nLevels)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_completed,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_frequency,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_LeaderClick,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_notLeaderClick,0)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_TickOut,6)
					end
					LuaFnSetSceneData_TempParam(sceneId,x212135_g_LeaderflashData[leaderclick],0)
					LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,targetId,x212135_g_ColourData[GetMonsterDataID(sceneId,targetId)],0)
				end
			end
		end
	else
		if IsHaveMission(sceneId,selfId,x212135_g_MissionId) > 0 and GetName(sceneId,targetId) == x212135_g_Name then
			if x212135_CheckSubmit(sceneId,selfId) > 0 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090602_013}")
				return
			end
			if GetTeamId(sceneId,selfId) < 0 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_022}")
				return
			end
			if GetTeamSize(sceneId,selfId) ~= GetNearTeamCount( sceneId, selfId) then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_022}")
				return
			end
			if GetNearTeamCount( sceneId, selfId) < 2 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_022}")
				return
			end
			if GetNearTeamCount( sceneId, selfId) > 2 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_022}")
				return
			end
			if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_023}")
				return
			end
			if IsHaveMission(sceneId,selfId,x212135_g_MissionId) <= 0 then
				x212135_NotifyTips(sceneId,selfId,"#{QSJS_090508_025}")
				return
			end
			local nearteammembercount = GetNearTeamCount(sceneId,selfId)
			local ItemIsok,ImpactIsok = 0,0;
			for i = 0,nearteammembercount - 1 do
				local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
				if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 and LuaFnIsCharacterLiving(sceneId,TeamPlayerID) == 1 then
					if LuaFnGetAvailableItemCount(sceneId,TeamPlayerID,x212135_g_MissionItem) > 0 then
						ItemIsok = 1
					end
					if LuaFnHaveImpactOfSpecificDataIndex(sceneId,TeamPlayerID,10527) == 1 then
						ImpactIsok = 1
					end
				end
			end
			if ItemIsok == 0 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_024}")
				return
			end
			if ImpactIsok == 1 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_026}".."1分钟。")
				return
			end
			if LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameStrat) > 0 then
				x212135_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_027}")
				return
			end
			--所有检测都过去了之后，游戏开始
			LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameStrat,1)
			--存储当前进行中的队伍号
			LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameTeamID,GetTeamId(sceneId,selfId))
		end
	end
end
--**********************************
--场景计时器
--**********************************
function x212135_OnSceneTimer(sceneId)
	--当前场景是否开启了桃花阵
	local nMonsterNum = GetMonsterCount(sceneId)
	local sceneType = LuaFnGetSceneType(sceneId)
	if sceneType == 1 then
		return
	end
	if LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameStrat) > 0 then
		--整体执行
		local nTick = LuaFnGetSceneData_TempParam(sceneId,x212135_g_TickCount)
		LuaFnSetSceneData_TempParam(sceneId,x212135_g_TickCount,nTick + 1)
		local nTickout = LuaFnGetSceneData_TempParam(sceneId,x212135_g_TickOut)
		if nTickout > 0 then
			LuaFnSetSceneData_TempParam(sceneId,x212135_g_TickOut,nTickout - 1)
		end
		--闪烁延时
		local flashd = LuaFnGetSceneData_TempParam(sceneId,x212135_g_flash_delayed)
		if flashd > 0 then
			LuaFnSetSceneData_TempParam(sceneId,x212135_g_flash_delayed,flashd - 1)
		end
		--遍历全场景玩家，识别下开启桃花阵的队伍和数据中存储的队伍是否相同
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i = 0,nHumanCount -1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				x212135_TaoHuaZhenGame(sceneId,mems[i])
			end
		end
	else
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 81 and MosDataID <= 85 then
				LuaFnDeleteMonster(sceneId,MonsterId)
			end
		end
		for i = 2,31 do
			if LuaFnGetSceneData_TempParam(sceneId,i) > 0 then
				LuaFnSetSceneData_TempParam(sceneId,i,0)
			end
		end
		--强制清理buff
		--遍历全场景玩家，识别下开启桃花阵的队伍和数据中存储的队伍是否相同
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i = 0,nHumanCount -1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				for j = 1,2 do
					LuaFnCancelSpecificImpact(sceneId,mems[i],x212135_g_notLeaderImpact[j])
					LuaFnCancelSpecificImpact(sceneId,mems[i],x212135_g_LeaderImpact[j])
				end
			end
		end
	end
end
--**********************************
--桃花阵小游戏主逻辑
--**********************************
function x212135_TaoHuaZhenGame(sceneId,selfId)
	if GetTeamId(sceneId,selfId) == LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameTeamID) then
		local nTick = LuaFnGetSceneData_TempParam(sceneId,x212135_g_TickCount)
		local notleaderm = LuaFnGetSceneData_TempParam(sceneId,x212135_g_GamenotLeaderMonster)
		local leaderm = LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameLeaderMonster)
		local nLevels = LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameLevels)
		local nTickout = LuaFnGetSceneData_TempParam(sceneId,x212135_g_TickOut)
		local flashd = LuaFnGetSceneData_TempParam(sceneId,x212135_g_flash_delayed)
		local nFlashCount = LuaFnGetSceneData_TempParam(sceneId,x212135_g_flashing_frequency)
		local complete = LuaFnGetSceneData_TempParam(sceneId,x212135_g_flashing_completed)
		local oldLevels = LuaFnGetSceneData_TempParam(sceneId,x212135_g_GameoldLevels)
		local failed = LuaFnGetSceneData_TempParam(sceneId,x212135_g_Challenge_failed)
		local nMonsterNum = GetMonsterCount(sceneId)
		local nearteammembercount = GetNearTeamCount(sceneId,selfId)
		local teamId = {}
		for i = 0,nearteammembercount - 1 do
			teamId[i + 1] = GetNearTeamMember(sceneId,selfId,i)
		end
		local misIndex = GetMissionIndexByID(sceneId,teamId[1],x212135_g_MissionId)
		local misIndex_2 = GetMissionIndexByID(sceneId,teamId[2],x212135_g_MissionId)
		local param_1_1 = GetMissionParam(sceneId,teamId[1],misIndex,1)
		local param_1_2 = GetMissionParam(sceneId,teamId[2],misIndex_2,1)
		if failed > 0 then
			--给双方来一条提示在上下失败者buff
			x212135_NotifyTips(sceneId,selfId,"#{QSJS_090508_033}")
			for i = 1,getn(x212135_g_notLeaderImpact) do
				LuaFnCancelSpecificImpact(sceneId,teamId[2],x212135_g_notLeaderImpact[i])
			end
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,teamId[2],x212135_g_FailImpact[2],0)
			
			for i = 1,getn(x212135_g_LeaderImpact) do
				LuaFnCancelSpecificImpact(sceneId,teamId[1],x212135_g_LeaderImpact[i])
			end
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,teamId[1],x212135_g_FailImpact[1],0)
			
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,teamId[1],x212135_g_LoserImpact,0)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,teamId[2],x212135_g_LoserImpact,0)
			LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameStrat,0) --游戏关闭
			return
		end
		--桃花阵任务完成
		if nLevels > 5 then
			SetMissionByIndex(sceneId,teamId[1],misIndex,1,5)
			SetMissionByIndex(sceneId,teamId[2],misIndex_2,1,5)
			SetMissionByIndex(sceneId,teamId[1],misIndex,0,1)
			SetMissionByIndex(sceneId,teamId[2],misIndex_2,0,1)
			x212135_NotifyTips(sceneId,selfId,"#{QSJS_090508_040}")
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,teamId[1],x212135_g_SuccessImpact[1],0)
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,teamId[2],x212135_g_SuccessImpact[2],0)
			LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameStrat,0) --游戏关闭
			return
		end
		--先把玩家移动下坐标然后分别给状态
		if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x212135_g_notLeaderImpact[2]) ~= 1 then
				--不是队长
				SetPos(sceneId,selfId,x212135_g_ScenePos[sceneId][1] + 4,x212135_g_ScenePos[sceneId][2])
				--上状态
				for i = 1,getn(x212135_g_notLeaderImpact) do
					LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x212135_g_notLeaderImpact[i],0)
				end
				LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x212135_g_CurrencyImapct,0)
			end
		else
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x212135_g_LeaderImpact[2]) ~= 1 then
				--是队长
				SetPos(sceneId,teamId[1],x212135_g_ScenePos[sceneId][1] - 4,x212135_g_ScenePos[sceneId][2])
				--上状态
				for i = 1,getn(x212135_g_LeaderImpact) do
					LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x212135_g_LeaderImpact[i],0)
				end
				LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,x212135_g_CurrencyImapct,0)
			end
		end
		if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
			if notleaderm == 0 then
				local x,z = GetWorldPos(sceneId,selfId)
				LuaFnCreateMonster(sceneId,81,x + 1.9,z - 0.6,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,82,x,z - 2,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,83,x - 1.2,z + 1.6,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,84,x - 1.9,z - 0.6,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,85,x + 1.2,z + 1.5,3,-1,x212135_g_ScriptId)
				LuaFnSetSceneData_TempParam(sceneId,x212135_g_GamenotLeaderMonster,1)
			end
		else
			if leaderm == 0 then
				local x,z = GetWorldPos(sceneId,selfId)
				LuaFnCreateMonster(sceneId,81,x - 1.9,z - 0.6,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,82,x,z - 2,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,83,x + 1.2,z + 1.5,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,84,x + 1.9,z - 0.6,3,-1,x212135_g_ScriptId)
				LuaFnCreateMonster(sceneId,85,x - 1.2,z + 1.6,3,-1,x212135_g_ScriptId)
				LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameLeaderMonster,1)
			end
		end
		if complete > 0 then
			return
		end
		if notleaderm > 0 and leaderm > 0 then
			--初始化第一关的情况下
			if nLevels == 0 then
				LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameLevels,1)
				--倒计时数据写入
				LuaFnSetSceneData_TempParam(sceneId,x212135_g_TickOut,6)
				--历史关卡记录
				LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameoldLevels,1)
			end
		end
		if nLevels > 0 then
			if oldLevels < nLevels then
				LuaFnSetSceneData_TempParam(sceneId,x212135_g_GameoldLevels,nLevels)
				x212135_NotifyTips(sceneId,teamId[1],"#{QSJS_090508_035}")
				x212135_NotifyTips(sceneId,teamId[2],"#{QSJS_090508_035}")
			end
		end
		if nLevels == 2 then
			if nTickout > 0 then
				x212135_NotifyTips(sceneId,selfId,nTickout.."#{QSJS_090508_036}")
				if param_1_1 < 1 then
					SetMissionByIndex(sceneId,teamId[1],misIndex,1,1)
				end
				if param_1_2 < 1 then
					SetMissionByIndex(sceneId,teamId[2],misIndex_2,1,1)
				end
			end
		elseif nLevels == 3 then
			if nTickout > 0 then
				x212135_NotifyTips(sceneId,selfId,nTickout.."#{QSJS_090508_037}")
				if param_1_1 < 2 then
					SetMissionByIndex(sceneId,teamId[1],misIndex,1,2)
				end
				if param_1_2 < 2 then
					SetMissionByIndex(sceneId,teamId[2],misIndex_2,1,2)
				end
			end
		elseif nLevels == 4 then
			if nTickout > 0 then
				x212135_NotifyTips(sceneId,selfId,nTickout.."#{QSJS_090508_038}")
				if param_1_1 < 3 then
					SetMissionByIndex(sceneId,teamId[1],misIndex,1,3)
				end
				if param_1_2 < 3 then
					SetMissionByIndex(sceneId,teamId[2],misIndex_2,1,3)
				end
			end
		elseif nLevels == 5 then
			if nTickout > 0 then
				x212135_NotifyTips(sceneId,selfId,nTickout.."#{QSJS_090508_039}")
				if param_1_1 < 4 then
					SetMissionByIndex(sceneId,teamId[1],misIndex,1,4)
				end
				if param_1_2 < 4 then
					SetMissionByIndex(sceneId,teamId[2],misIndex_2,1,4)
				end
			end
		end
		if nTickout > 0 then
			--第一关有个特写
			if nLevels == 1 then
				if nTickout == 5 then
					x212135_NotifyTips(sceneId,selfId,"#{QSJS_090508_028}5#{QSJS_090508_029}")
				end
				if nTickout == 3 then
					x212135_NotifyTips(sceneId,selfId,"#{QSJS_0090702_1}")
				end
				if nTickout == 1 then
					x212135_NotifyTips(sceneId,selfId,"#{QSJS_0090702_2}")
					LuaFnSetSceneData_TempParam(sceneId,x212135_g_flash_delayed,1) --闪烁延时
				end
			end
		end
		if nLevels > 0 then
			if nTickout == 0 then
				if flashd == 0 then
					--进行闪烁，闪烁为随机闪烁，闪烁一次记录一次，开始闪烁
					if nFlashCount < x212135_g_LevelsNumber[nLevels] then
						nFlashCount = nFlashCount + 1
						local nRandom = random(81,85)
						for i = 0, nMonsterNum-1 do
							local MonsterId = GetMonsterObjID(sceneId,i)
							local MosDataID = GetMonsterDataID(sceneId,MonsterId)
							if MosDataID == nRandom then
								--开闪
								LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,MonsterId,x212135_g_ColourData[nRandom],0)
							end
						end
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_LeaderflashData[nFlashCount],nRandom)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_notLeaderflashData[nFlashCount],nRandom)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_frequency,nFlashCount)
						LuaFnSetSceneData_TempParam(sceneId,x212135_g_flash_delayed,2)
						if nFlashCount == x212135_g_LevelsNumber[nLevels] then
							x212135_NotifyTips(sceneId,teamId[1],"#{QSJS_090508_030}")
							x212135_NotifyTips(sceneId,teamId[2],"#{QSJS_090508_030}")
							LuaFnSetSceneData_TempParam(sceneId,x212135_g_flashing_completed,1)
						end
					end
				end
			end
		end
	end
end
--**********************************
--列举事件
--**********************************
function x212135_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x212135_g_MissionId) > 0 and GetName(sceneId,targetId) == x212135_g_Name then
		AddNumText(sceneId, x212135_g_ScriptId, "#{QSJS_090602_014}", 6, -1);
	end
end
--**********************************
--检测接受条件
--**********************************
function x212135_CheckAccept( sceneId, selfId )
	return 1
end

--**********************************
--接受
--**********************************
function x212135_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x212135_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x212135_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x212135_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x212135_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x212135_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x212135_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x212135_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x212135_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x212135_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

function x212135_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
	AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
