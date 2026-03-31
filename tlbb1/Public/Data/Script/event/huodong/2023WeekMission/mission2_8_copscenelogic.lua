--幽篁里副本逻辑

x890137_g_ScriptId = 890137;				-- 脚本号
x890137_g_NpcScriptId	= 890107
--副本配置
x890137_g_CopySceneMap = "youhuangli.path"
x890137_g_CopySceneMonster = "youhuangli_monster.ini"
x890137_g_TickElapse = 1;					-- 回调脚本的时钟时间（单位：秒/次）
x890137_g_LimitTickCount = 1000;				-- 副本心跳次数限制（单位：次数）
x890137_g_CloseTick = 5;					-- 副本关闭前倒计时心跳次数（单位：次数）
x890137_g_NoUserTime = 15;					-- 副本中没有人后可以继续保存的时间（单位：秒）
x890137_g_CopySceneType = FUBEN_BAIXIGU_YOUHUANGLI	--副本类型，定义在ScriptGlobal.lua里面
x890137_g_Fuben_X=30				--进入副本的位置X
x890137_g_Fuben_Z=44				--进入副本的位置Z

x890137_g_MissionId = 2156
x890137_g_MinLevel = 85
x890137_g_MaxCanEnterTime = 6		--每周可参与此类副本最大次数
x890137_g_MaxMonster = 50			--最多轮次的数量
--任务参数
x890137_g_IsMissionOkFail = 0--是否完成
x890137_g_KillNumber = 1
--副本入口NPC
x890137_g_Position_X=70
x890137_g_Position_Z=37
x890137_g_SceneID=1293
x890137_g_AccomplishNPC_Name="墨星翁"

x890137_g_CheckPosX = 59
x890137_g_CheckPosZ = 81
--怪物生成的位置组
x890137_g_MonsterPos = {
	{62,72},{66,71},{61,69},{58,71},{71,73},
	{74,93},{69,93},{64,92},{58,92},{55,94}
}

--**********************************
--列举事件
--**********************************
function x890137_OnEnumerate( sceneId, selfId, targetId )
	--不存在任务
	if IsHaveMission(sceneId,selfId,x890137_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x890137_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x890137_g_IsMissionOkFail)
	if misOk == 0 then
		if GetName(sceneId,targetId) ~= x890137_g_AccomplishNPC_Name then
			return
		end
		AddNumText(sceneId,x890137_g_NpcScriptId,"#{BLCC_20221214_429}",10,222);
	end
end

--**********************************
--任务入口函数
--**********************************
function x890137_OnDefaultEvent( sceneId, selfId, targetId )
	if sceneId ~= x890137_g_SceneID then
		x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_430}")
		x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_431}")
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_392}")
		x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_393}")
		return
	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x890137_g_MissionId) <= 0 then
		x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_438}")
		x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_439}")
		return
	end
	if GetLevel(sceneId,selfId) < x890137_g_MinLevel then
		x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_396}")
		x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_397}")
		return
	end
	if GetMissionDataEx(sceneId,selfId,MDEX_SPECIAL_SHENGWANG_COPYSCENE_TIME) >= x890137_g_MaxCanEnterTime then
		x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_398}")
		x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_399}")
		return
	end
	if LuaFnHasTeam(sceneId,selfId) == 1 then
		if GetTeamLeader(sceneId,selfId) ~= selfId    then
			x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_390}")
			x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_391}")
			return
		end
		--队友情况检索
		for	i=0,GetNearTeamCount( sceneId, selfId) -1 do
			local memObjId = GetNearTeamMember(sceneId, selfId, i)
			
			if GetLevel(sceneId,memObjId) < x890137_g_MinLevel then
				x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_400}")
				x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_401}")
				return
			end
			if LuaFnGetShengWangId(sceneId,memObjId) == 0 then
				x890137_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_403}")
				x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_404}")
				return
			end
		end
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x890137_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x890137_g_IsMissionOkFail)
	if misOk ~= 0 then
		--任务完成就不允许进去了
		return
	end
	--初始化副本
	local leaderguid = LuaFnObjId2Guid( sceneId, selfId )
	LuaFnSetSceneLoad_Map( sceneId, x890137_g_CopySceneMap )				--地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader( sceneId, leaderguid )
	LuaFnSetCopySceneData_NoUserCloseTime( sceneId, x890137_g_NoUserTime * 1000 )
	LuaFnSetCopySceneData_Timer( sceneId, x890137_g_TickElapse * 1000 )
	LuaFnSetCopySceneData_Param( sceneId, 0, x890137_g_CopySceneType )		--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param( sceneId, 1, x890137_g_ScriptId )			--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param( sceneId, 2, 0 )							--设置定时器调用次数
	LuaFnSetCopySceneData_Param( sceneId, 3, x890137_g_MissionId )			--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param( sceneId, 4, 0 )							--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param( sceneId, 5, 0 )							--设置离开倒计时次数
	LuaFnSetCopySceneData_Param( sceneId, 6, nMPIndex )						--标示这是第几个场景
	LuaFnSetCopySceneData_Param( sceneId, 7, 0 )							--进入副本的位置X
	LuaFnSetCopySceneData_Param( sceneId, 8, 0 )							--进入副本的位置Z
	LuaFnSetCopySceneData_Param( sceneId, 9, x890137_g_MaxMonster )			--剩余的小怪数量
	
	LuaFnSetSceneLoad_Monster( sceneId, x890137_g_CopySceneMonster );

	local bRetSceneID = LuaFnCreateCopyScene( sceneId )						--初始化完成后调用创建副本函数
	if bRetSceneID > 0 then
		x890137_NotifyTips(sceneId, selfId, "#{BLCC_20221214_402}");
	else
		x890137_NotifyTips( sceneId, selfId, "#{BLCC_20221214_411}" )
	end
end

--**********************************
--副本事件
--**********************************
function x890137_OnCopySceneReady(sceneId, destsceneId)
	LuaFnSetCopySceneData_Param( destsceneId, 3, sceneId )					--设置副本入口场景号

	local leaderguid = LuaFnGetCopySceneData_TeamLeader( destsceneId )
	local leaderObjId = LuaFnGuid2ObjId( sceneId, leaderguid )

	if leaderObjId == -1 then
		return
	end

	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then			-- 处于无法执行逻辑的状态
		return
	end
	--设置副本的入口位置
	local PlayerX = GetHumanWorldX(sceneId,leaderObjId)
	local PlayerY = GetHumanWorldZ(sceneId,leaderObjId)
	LuaFnSetCopySceneData_Param( destsceneId, 7, PlayerX )					
	LuaFnSetCopySceneData_Param( destsceneId, 8, PlayerY )
	--进入副本的规则
	-- 1，如果这个文件没有组队，就传送这个文件自己进入副本
	-- 2, 如果玩家有队伍，但是玩家不是队长，就传送自己进入副本
	-- 3，如果玩家有队伍，并且这个晚间是队长，就传送自己和附近队友一起进去
	
	if LuaFnHasTeam(sceneId,leaderObjId) == 0 or IsCaptain(sceneId, leaderObjId) == 0  then
		NewWorld( sceneId, leaderObjId, destsceneId, x890137_g_Fuben_X, x890137_g_Fuben_Z) ;
	else
		local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
		for	i=0,nearteammembercount-1 do
			local memObjId = GetNearTeamMember(sceneId, leaderObjId, i)
			if GetLevel(sceneId,memObjId) < x890137_g_MinLevel then
				x890137_NotifyTips(sceneId, memObjId, "#{BLCC_20221214_401}")
				return
			end
			if LuaFnGetShengWangId(sceneId,memObjId) == 0 then
				x890137_NotifyTips(sceneId, memObjId, "#{BLCC_20221214_404}")
				return
			end
			if GetMissionDataEx(sceneId,memObjId,MDEX_SPECIAL_SHENGWANG_COPYSCENE_TIME) >= x890137_g_MaxCanEnterTime then
				x890137_NotifyTips(sceneId, memObjId, "#{BLCC_20221214_399}")
				return
			end
			NewWorld( sceneId, memObjId, destsceneId, x890137_g_Fuben_X, x890137_g_Fuben_Z) ;
		end
	end		
end

--**********************************
--有玩家进入副本事件
--**********************************
function x890137_OnPlayerEnter(sceneId, selfId)
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x890137_OnHumanDie(sceneId, selfId, killerId)
end

--**********************************
--生成小怪
--**********************************
function x890137_GenMonster(sceneId)
	for i = 1,getn(x890137_g_MonsterPos) do
		local monsterID = CreateMonsterWithDir( sceneId,50990,x890137_g_MonsterPos[i][1],x890137_g_MonsterPos[i][2], 28, -1, 890138,0.873 )
		if monsterID ~= -1 then
			SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
		end
		local nCurRemainNum = LuaFnGetCopySceneData_Param(sceneId, 9);
		nCurRemainNum = nCurRemainNum - 1
		if nCurRemainNum <= 0 then
			nCurRemainNum = 0
		end
		LuaFnSetCopySceneData_Param(sceneId, 9,nCurRemainNum);
		if nCurRemainNum == 0 then
			break
		end
	end
end

--**********************************
--副本场景定时器事件
--**********************************
function x890137_OnCopySceneTimer(sceneId, nowTime)
	
	--副本时钟读取及设置
	local tickCount = LuaFnGetCopySceneData_Param(sceneId, 2);	--取得已经执行的定时次数
	tickCount = tickCount + 1;
	LuaFnSetCopySceneData_Param(sceneId, 2, tickCount);		--设置新的定时器调用次数
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4);
	if leaveFlag == 1 then --需要离开

		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5);
		leaveTickCount = leaveTickCount + 1;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount);
		
		if leaveTickCount > x890137_g_CloseTick or leaveTickCount == x890137_g_CloseTick then --倒计时间到，大家都出去吧
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号
			local enterPosX = LuaFnGetCopySceneData_Param(sceneId, 7);
			local enterPosZ = LuaFnGetCopySceneData_Param(sceneId, 8);

			--将当前副本场景里的所有人传送回原来进入时候的场景
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
			local mems = {};
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				NewWorld(sceneId, mems[i], oldsceneId, enterPosX, enterPosZ);
			end
			
		elseif leaveTickCount < x890137_g_CloseTick then
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号

			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
			local mems = {};
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				x890137_NotifyTips(sceneId, mems[i], ScriptGlobal_Format("#{BLCC_20221214_492}",tostring((x890137_g_CloseTick-leaveTickCount)*x890137_g_TickElapse)));
			end
		end

	elseif tickCount > x890137_g_LimitTickCount or tickCount == x890137_g_LimitTickCount then
		LuaFnSetCopySceneData_Param(sceneId, 4, 1);
		return
	else
		--进入后的初次提醒逻辑
		if tickCount == 5 then
			--BLCC_20221214_448	#W    这#R匪徒#W狡猾的很，请务必小心四周。	
			LuaFnNpcTalk(sceneId,217)
			--BLCC_20221214_447	#H前往幽篁里（59,81）处引出匪徒，将其消灭。
			x890137_TipAllHuman( sceneId, "#{BLCC_20221214_447}" )
		end
		
		local nCurRemainNum = LuaFnGetCopySceneData_Param(sceneId, 9);
		--每tick遍历队长距离检测点的位置
		local leaderguid = LuaFnGetCopySceneData_TeamLeader( sceneId )
		local leaderObjId = LuaFnGuid2ObjId( sceneId, leaderguid )
		if leaderObjId ~= -1 then
			local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, leaderObjId);
			local distSqNpcToPlayer = floor(sqrt((selfPosX-x890137_g_CheckPosX)*(selfPosX-x890137_g_CheckPosX)+(selfPosZ-x890137_g_CheckPosZ)*(selfPosZ-x890137_g_CheckPosZ)))
			if distSqNpcToPlayer < 5 and nCurRemainNum == x890137_g_MaxMonster then
				--首次触发
				x890137_GenMonster(sceneId)
				--BLCC_20221214_449	#W    他们来啦，少侠快帮忙啊！	
				LuaFnNpcTalk(sceneId,218)
			end
		end
		if x890137_GetMonsterNumber( sceneId ) == 0 and nCurRemainNum == 0 then
			--副本结束
			if nCurRemainNum == 0 then
				LuaFnSetCopySceneData_Param(sceneId, 4, 1);
			elseif nCurRemainNum ~= x890137_g_MaxMonster then
				--生成一轮
				x890137_GenMonster(sceneId)
			end
		end
	end
end
--**********************************
--获取当前存活的怪物数量
--**********************************
function x890137_GetMonsterNumber( sceneId )
	local nTotalNum = 0;
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == 50990 then
			nTotalNum = nTotalNum + 1
		end
	end
	return nTotalNum
end

--**********************************
--提示所有副本内玩家
--**********************************
function x890137_TipAllHuman( sceneId, Str )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, PlayerId)
		end
	end
end

--**********************************
--屏幕中心信息提示
--**********************************
function x890137_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end

--**********************************
--对话窗口信息提示
--**********************************
function x890137_MessageBox(sceneId, selfId, targetId, msg)
	BeginEvent(sceneId);
		AddText(sceneId, msg);
	EndEvent(sceneId);
	DispatchEventList(sceneId, selfId, targetId);
end
