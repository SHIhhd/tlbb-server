--霜叶谷副本逻辑

x890140_g_ScriptId = 890140;				-- 脚本号
x890140_g_NpcScriptId	= 890108
--副本配置
x890140_g_CopySceneMap = "shuangyegu.path"
x890140_g_CopySceneMonster = "shuangyegu_monster.ini"
x890140_g_TickElapse = 1;					-- 回调脚本的时钟时间（单位：秒/次）
x890140_g_LimitTickCount = 1000;				-- 副本心跳次数限制（单位：次数）
x890140_g_CloseTick = 5;					-- 副本关闭前倒计时心跳次数（单位：次数）
x890140_g_NoUserTime = 15;					-- 副本中没有人后可以继续保存的时间（单位：秒）
x890140_g_CopySceneType = FUBEN_BAIXIGU_SHUANGYEGU	--副本类型，定义在ScriptGlobal.lua里面
x890140_g_Fuben_X=84				--进入副本的位置X
x890140_g_Fuben_Z=109				--进入副本的位置Z

x890140_g_MissionId = 2157
x890140_g_MinLevel = 85
x890140_g_MaxCanEnterTime = 6		--每周可参与此类副本最大次数
--任务参数
x890140_g_IsMissionOkFail = 0--是否完成
x890140_g_KillNumber = 1
--副本入口NPC
x890140_g_Position_X=54
x890140_g_Position_Z=58
x890140_g_SceneID=1294
x890140_g_AccomplishNPC_Name="墨离"

x890140_g_CheckPosX = 72
x890140_g_CheckPosZ = 73

--**********************************
--列举事件
--**********************************
function x890140_OnEnumerate( sceneId, selfId, targetId )
	--不存在任务
	if IsHaveMission(sceneId,selfId,x890140_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x890140_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x890140_g_IsMissionOkFail)
	if misOk == 0 then
		if GetName(sceneId,targetId) ~= x890140_g_AccomplishNPC_Name then
			return
		end
		AddNumText(sceneId,x890140_g_NpcScriptId,"#{BLCC_20221214_458}",10,222);
	end
end

--**********************************
--任务入口函数
--**********************************
function x890140_OnDefaultEvent( sceneId, selfId, targetId )
	if sceneId ~= x890140_g_SceneID then
		x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_459}")
		x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_460}")
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId == 0 then
		x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_392}")
		x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_393}")
		return
	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x890140_g_MissionId) <= 0 then
		x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_461}")
		x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_462}")
		return
	end
	if GetLevel(sceneId,selfId) < x890140_g_MinLevel then
		x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_396}")
		x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_397}")
		return
	end
	if GetMissionDataEx(sceneId,selfId,MDEX_SPECIAL_SHENGWANG_COPYSCENE_TIME) >= x890140_g_MaxCanEnterTime then
		x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_398}")
		x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_399}")
		return
	end
	if LuaFnHasTeam(sceneId,selfId) == 1 then
		if GetTeamLeader(sceneId,selfId) ~= selfId    then
			x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_390}")
			x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_391}")
			return
		end
		--队友情况检索
		for	i=0,GetNearTeamCount( sceneId, selfId) -1 do
			local memObjId = GetNearTeamMember(sceneId, selfId, i)
			
			if GetLevel(sceneId,memObjId) < x890140_g_MinLevel then
				x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_400}")
				x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_401}")
				return
			end
			if LuaFnGetShengWangId(sceneId,memObjId) == 0 then
				x890140_MessageBox(sceneId, selfId, targetId, "#{BLCC_20221214_403}")
				x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_404}")
				return
			end
		end
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x890140_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x890140_g_IsMissionOkFail)
	if misOk ~= 0 then
		--任务完成就不允许进去了
		return
	end
	--初始化副本
	local leaderguid = LuaFnObjId2Guid( sceneId, selfId )
	LuaFnSetSceneLoad_Map( sceneId, x890140_g_CopySceneMap )				--地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader( sceneId, leaderguid )
	LuaFnSetCopySceneData_NoUserCloseTime( sceneId, x890140_g_NoUserTime * 1000 )
	LuaFnSetCopySceneData_Timer( sceneId, x890140_g_TickElapse * 1000 )
	LuaFnSetCopySceneData_Param( sceneId, 0, x890140_g_CopySceneType )		--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param( sceneId, 1, x890140_g_ScriptId )			--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param( sceneId, 2, 0 )							--设置定时器调用次数
	LuaFnSetCopySceneData_Param( sceneId, 3, x890140_g_MissionId )			--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param( sceneId, 4, 0 )							--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param( sceneId, 5, 0 )							--设置离开倒计时次数
	LuaFnSetCopySceneData_Param( sceneId, 6, nMPIndex )						--标示这是第几个场景
	LuaFnSetCopySceneData_Param( sceneId, 7, 0 )							--进入副本的位置X
	LuaFnSetCopySceneData_Param( sceneId, 8, 0 )							--进入副本的位置Z
	LuaFnSetCopySceneData_Param( sceneId, 9, 0 )							--是否生成了boss
	
	LuaFnSetSceneLoad_Monster( sceneId, x890140_g_CopySceneMonster );

	local bRetSceneID = LuaFnCreateCopyScene( sceneId )						--初始化完成后调用创建副本函数
	if bRetSceneID > 0 then
		x890140_NotifyTips(sceneId, selfId, "#{BLCC_20221214_402}");
	else
		x890140_NotifyTips( sceneId, selfId, "#{BLCC_20221214_411}" )
	end
end

--**********************************
--副本事件
--**********************************
function x890140_OnCopySceneReady(sceneId, destsceneId)
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
		NewWorld( sceneId, leaderObjId, destsceneId, x890140_g_Fuben_X, x890140_g_Fuben_Z) ;
	else
		local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
		for	i=0,nearteammembercount-1 do
			local memObjId = GetNearTeamMember(sceneId, leaderObjId, i)
			if GetLevel(sceneId,memObjId) < x890140_g_MinLevel then
				x890140_NotifyTips(sceneId, memObjId, "#{BLCC_20221214_401}")
				return
			end
			if LuaFnGetShengWangId(sceneId,memObjId) == 0 then
				x890140_NotifyTips(sceneId, memObjId, "#{BLCC_20221214_404}")
				return
			end
			if GetMissionDataEx(sceneId,memObjId,MDEX_SPECIAL_SHENGWANG_COPYSCENE_TIME) >= x890140_g_MaxCanEnterTime then
				x890140_NotifyTips(sceneId, memObjId, "#{BLCC_20221214_399}")
				return
			end
			NewWorld( sceneId, memObjId, destsceneId, x890140_g_Fuben_X, x890140_g_Fuben_Z) ;
		end
	end		
end

--**********************************
--有玩家进入副本事件
--**********************************
function x890140_OnPlayerEnter(sceneId, selfId)
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x890140_OnHumanDie(sceneId, selfId, killerId)
end

--**********************************
--生成千机木甲豹
--**********************************
function x890140_GenBOSS(sceneId)
	local monsterID = CreateMonsterWithDir( sceneId,50997,66,71, 28, -1, 890141,0.873 )
	if monsterID ~= -1 then
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
	end
end

--**********************************
--副本场景定时器事件
--**********************************
function x890140_OnCopySceneTimer(sceneId, nowTime)
	
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
		
		if leaveTickCount > x890140_g_CloseTick or leaveTickCount == x890140_g_CloseTick then --倒计时间到，大家都出去吧
		
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
			
		elseif leaveTickCount < x890140_g_CloseTick then
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号

			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
			local mems = {};
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				x890140_NotifyTips(sceneId, mems[i], ScriptGlobal_Format("#{BLCC_20221214_492}",tostring((x890140_g_CloseTick-leaveTickCount)*x890140_g_TickElapse)));
			end
		end

	elseif tickCount > x890140_g_LimitTickCount or tickCount == x890140_g_LimitTickCount then
		LuaFnSetCopySceneData_Param(sceneId, 4, 1);
		return
	else
		--进入后的初次提醒逻辑
		if tickCount == 5 then
--			BLCC_20221214_448	#W    这#R匪徒#W狡猾的很，请务必小心四周。	
			LuaFnNpcTalk(sceneId,219)
		end
		
		local bGenBoss = LuaFnGetCopySceneData_Param(sceneId, 9);
--		每tick遍历队长距离检测点的位置
		local leaderguid = LuaFnGetCopySceneData_TeamLeader( sceneId )
		local leaderObjId = LuaFnGuid2ObjId( sceneId, leaderguid )
		if leaderObjId ~= -1 then
			local selfPosX, selfPosZ = LuaFnGetWorldPos(sceneId, leaderObjId);
			local distSqNpcToPlayer = floor(sqrt((selfPosX-x890140_g_CheckPosX)*(selfPosX-x890140_g_CheckPosX)+(selfPosZ-x890140_g_CheckPosZ)*(selfPosZ-x890140_g_CheckPosZ)))
			if distSqNpcToPlayer < 5 and bGenBoss == 0 then
				x890140_GenBOSS(sceneId)
--				BLCC_20221214_441	#R    千机木甲豹#W苏醒了！	
				LuaFnNpcTalk(sceneId,220)
				--标记已经创建
				LuaFnSetCopySceneData_Param(sceneId, 9,1);
			end
		end
	end
end

--**********************************
--提示所有副本内玩家
--**********************************
function x890140_TipAllHuman( sceneId, Str )
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
function x890140_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end

--**********************************
--对话窗口信息提示
--**********************************
function x890140_MessageBox(sceneId, selfId, targetId, msg)
	BeginEvent(sceneId);
		AddText(sceneId, msg);
	EndEvent(sceneId);
	DispatchEventList(sceneId, selfId, targetId);
end
