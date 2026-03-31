--夜探水月山庄
x891099_g_ScriptId	= 891099
x891099_g_CopySceneType=FUBEN_YETANSHUIYUESHANZHAUNG	--副本类型，定义在ScriptGlobal.lua里面
x891099_g_LimitMembers = 1			--可以进副本的最小队伍人数
x891099_g_TickTime = 1				--回调脚本的时钟时间（单位：秒/次）
x891099_g_LimitTotalHoldTime=1800	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x891099_g_CloseTick=300				--副本关闭前倒计时（单位：次数）
x891099_g_NoUserTime=10				--副本中没有人后可以继续保存的时间（单位：秒）
x891099_g_DeadTrans=0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x891099_g_Fuben_X=103				--进入副本的位置X
x891099_g_Fuben_Z=213				--进入副本的位置Z
x891099_g_Back_X=130				--源场景位置X
x891099_g_Back_Z=107				--源场景位置Z
x891099_g_MissionId = 2003			--任务ID号
x891099_g_IsMissionCheck = 	1		--客户端动态显示用
--**********************************
--任务入口函数
--**********************************
function x891099_OnDefaultEvent( sceneId, selfId, targetId )
	local nRet,nTip,nMsg = x891099_CheckTeamLeader(sceneId,selfId)
	if nRet == 0 then
		if nTip ~= "" then
			BeginEvent(sceneId)
				AddText(sceneId,nTip);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
		if nMsg ~= "" then
			x891099_MsgBox(sceneId,selfId,targetId,nMsg)
		end
		return
	end
	x891099_MakeCopyScene(sceneId,selfId)
end

--**********************************
-- 检测副本进入条件
--**********************************
function x891099_CheckTeamLeader(sceneId,selfId)
	if GetLevel(sceneId,selfId) < 80 then
		return 0,"#{YXDHYD_20210205_13}","#{YXDHYD_20210205_12}"
	elseif GetTeamId(sceneId,selfId) > 0 then
		return 0,"#{YXDHYD_20210205_15}","#{YXDHYD_20210205_14}"
	elseif LuaFnGetTaskItemBagSpace(sceneId,selfId) < 1 then
		return 0,"#{YXDHYD_20210205_17}","#{YXDHYD_20210205_16}"
	end
	return 1,"",""
end

--**********************************
--检测接受条件
--**********************************
function x891099_CheckAccept( sceneId, selfId )
	
end

--**********************************
--接受
--**********************************
function x891099_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x891099_OnAbandon( sceneId, selfId )

end
--**********************************
--创建副本
--**********************************
function x891099_MakeCopyScene(sceneId,selfId)
	local leaderguid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "shuiyueshanzhuangye.path"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x891099_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x891099_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x891099_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x891099_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, -1); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;--杀死Boss的数量
	LuaFnSetCopySceneData_PvpRuler(sceneId,9)
	for i = 8,13 do
		LuaFnSetCopySceneData_Param( sceneId, i,0 )
	end	
	--设置场景中的各种Npc和区域
	LuaFnSetSceneLoad_Area( sceneId, "shuiyueshanzhuangye_area.ini" )
    LuaFnSetSceneLoad_Monster( sceneId, "shuiyueshanzhuangye_monster.ini" )
	LuaFnSetCopySceneData_Param(sceneId, CopyScene_LevelGap, nHumanLevel) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数 根据官方视频来看，没有提示创建副本成功的标识，但是一定是副本类型
end
--**********************************
--继续
--**********************************
function x891099_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x891099_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x891099_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891099_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x891099_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891099_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x891099_OnCopySceneReady( sceneId, destsceneId )
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	NewWorld( sceneId, leaderObjId, destsceneId, x891099_g_Fuben_X, x891099_g_Fuben_Z);
end

--**********************************
--有玩家进入副本事件
--**********************************
function x891099_OnPlayerEnter( sceneId, selfId )
	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo( sceneId, selfId,"%100","%100",-1,sceneId, x891099_g_Fuben_X, x891099_g_Fuben_Z );
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891099_g_MissionId)
	SetMissionByIndex(sceneId,selfId,nMisIndex,x891099_g_IsMissionCheck,1) --设置第一个任务已完成，客户端有动态显示
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x891099_OnHumanDie( sceneId, selfId, killerId )
end

--**********************************
--副本场景定时器事件
--**********************************
function x891099_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟读取及设置
	local oldsceneId = LuaFnGetCopySceneData_Param(sceneId,3);--取得副本入口场景号
	local TickCount = LuaFnGetCopySceneData_Param(sceneId,2) ;--取得已经执行的定时次数
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId, CopyScene_LevelGap) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId,4);
	TickCount = TickCount + 1;
	LuaFnSetCopySceneData_Param(sceneId,2,TickCount)
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(sceneId)
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid)
	--进入场景创建沈夜雨
	if TickCount == 3 then
		CreateMonsterWithDir(sceneId,49010,105.5,213.5,20,-1,891101,11)
		--初始化副本就要先创建山庄门口的家丁
		CreateMonsterWithDir(sceneId,49003,122,163,3,-1,-1,0)
		CreateMonsterWithDir(sceneId,49003,128,163,3,-1,-1,0)
	end
	if leaveFlag == 1 then --需要离开
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId,5);
		leaveTickCount = leaveTickCount + 1;
		LuaFnSetCopySceneData_Param(sceneId,5,leaveTickCount);
		if leaveTickCount == x891099_g_CloseTick then --倒计时间到，大家都出去吧
			if LuaFnIsObjValid(sceneId,leaderObjId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,leaderObjId) == 1 and LuaFnIsCharacterLiving(sceneId,leaderObjId) == 1 then
				NewWorld( sceneId, leaderObjId, oldsceneId, x891099_g_Back_X, x891099_g_Back_Z )
			end
		end
	elseif TickCount == x891099_g_LimitTotalHoldTime then --副本总时间限制到了
		--此处设置副本任务有时间限制的情况，当时间到后处理...
			if LuaFnIsObjValid(sceneId, leaderObjId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, leaderObjId) == 1 then
				NewWorld( sceneId,leaderObjId, oldsceneId, x891099_g_Back_X, x891099_g_Back_Z )
			end
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId,4,1);
	end
	--根据当前状态判定是否需要计时器
	if LuaFnIsObjValid(sceneId, leaderObjId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, leaderObjId) == 1 then
		local nMisIndex = GetMissionIndexByID(sceneId,leaderObjId,x891099_g_MissionId)
		local nMissionParam = GetMissionParam(sceneId,leaderObjId,nMisIndex,x891099_g_IsMissionCheck)
		if nMissionParam == 4 or nMissionParam == 5 or nMissionParam == 6 then
			x891099_OnTimer( sceneId, leaderObjId )
		end
	end
end
--玩家进入一个 area 时触发
function x891099_OnEnterArea( sceneId, selfId, areaId )
	--第一次发送对话，判断任务目标
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891099_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,nMisIndex,x891099_g_IsMissionCheck)
	local Chat_1 = LuaFnGetCopySceneData_Param(sceneId,10)
	local nMonsterNum = GetMonsterCount(sceneId)
	if param == 4 then
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID == 49005 then
				if Chat_1 == 0 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_36}") --发送第一段对话
					LuaFnSetCopySceneData_Param(sceneId,10,1)
				end
				if Chat_1 == 1 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_37}") --发送第二段对话
					LuaFnSetCopySceneData_Param(sceneId,10,2)
				end
				if Chat_1 == 2 then
					BroadMsgByChatPipe(sceneId,selfId,"#{YXDHYD_20210205_38}",0) --发送附近对话
					LuaFnSetCopySceneData_Param(sceneId,10,3)
				end
				if Chat_1 == 3 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_39}") --发送第三段对话
					LuaFnSetCopySceneData_Param(sceneId,10,4)
					SetMissionByIndex(sceneId,selfId,nMisIndex,x891099_g_IsMissionCheck,5) --剧情任务5
					--触发NPCtalk
					LuaFnNpcTalkToHuman(sceneId,selfId,115)
					--来一条提示
					BeginEvent(sceneId)
						AddText(sceneId,"#{YXDHYD_20210205_40}");
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					--这里动态生成那些无法交互得NPC
					--创建动态阻挡
					-- local monsterObjId = CreateMonsterWithDir(sceneId,49014,163,65,3,-1,-1,33)
					-- if monsterObjId > 0 then
						-- LuaFnAddDynamicRegionByObject(sceneId,monsterObjId,1)
					-- end
					CreateMonsterWithDir(sceneId,49006,188,90,6,-1,891105,13) --梵无救
					CreateMonsterWithDir(sceneId,49008,150,66,3,-1,-1,33) --耶律
					CreateMonsterWithDir(sceneId,49009,154,70,3,-1,-1,28) --宋老
					CreateMonsterWithDir(sceneId,49007,154,62,3,-1,-1,13.5) --阿莺
					
					CreateMonsterWithDir(sceneId,48535,182.5,93,3,-1,-1,33) --伙计张
					CreateMonsterWithDir(sceneId,48533,182.5,94,3,-1,-1,28) --厨师刘
					CreateMonsterWithDir(sceneId,48531,182.5,96,3,-1,-1,13.5) --农夫张
					CreateMonsterWithDir(sceneId,48532,182.5,97,3,-1,-1,13.5) --农夫田
					CreateMonsterWithDir(sceneId,48534,181,94,3,-1,-1,13) --伙计刘
					
					CreateMonsterWithDir(sceneId,48528,181,86,3,-1,-1,28) --丫鬟
					CreateMonsterWithDir(sceneId,48530,182.5,86,3,-1,-1,28) --小女孩
					CreateMonsterWithDir(sceneId,48529,181,87,3,-1,-1,33) --小男孩
					CreateMonsterWithDir(sceneId,48526,182.5,87,3,-1,-1,33) --李庄主
					CreateMonsterWithDir(sceneId,48527,182.5,88,3,-1,-1,13.5) --贵妇
				end
			end
		end
	elseif param == 5 then --进入第五个剧情，到达触发点
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID == 49006 then
				if Chat_1 == 4 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_41}")
					LuaFnSetCopySceneData_Param(sceneId,10,5)
				end
				if Chat_1 == 5 then
					BroadMsgByChatPipe(sceneId,selfId,"#{YXDHYD_20210205_42}",0)
					LuaFnSetCopySceneData_Param(sceneId,10,6)
				end
				if Chat_1 == 6 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_43}")
					LuaFnSetCopySceneData_Param(sceneId,10,7)
				end
				if Chat_1 == 7 then
					--来一条提示
					BeginEvent(sceneId)
						AddText(sceneId,"#{YXDHYD_20210205_44}")
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					SetMissionByIndex(sceneId,selfId,nMisIndex,x891099_g_IsMissionCheck,6) --剧情任务6
					--触发NPCtalk
					LuaFnNpcTalkToHuman(sceneId,selfId,116)
					LuaFnSetCopySceneData_Param(sceneId,10,8)
				end
			end
		end
	elseif param == 6 then
		--到达触发点先完成玩家设置2号任务数据为1
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID == 49006 then
				if Chat_1 == 8 then
					SetMissionByIndex(sceneId,selfId,nMisIndex,2,1) --跟所梵无救结束
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_45}")
					LuaFnSetCopySceneData_Param(sceneId,10,9)
				end
			end
			if MosDataID == 49008 then
				if Chat_1 == 9 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_46}")
					LuaFnSetCopySceneData_Param(sceneId,10,10)
				end
			end
			if MosDataID == 49009 then
				if Chat_1 == 10 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_47}")
					LuaFnSetCopySceneData_Param(sceneId,10,11)
				end
			end
			if MosDataID == 49007 then
				if Chat_1 == 11 then
					LuaFnNpcChat(sceneId,MonsterId,0,"#{YXDHYD_20210205_48}")
					LuaFnSetCopySceneData_Param(sceneId,10,12)
				end
			end
		end
		if Chat_1 == 12 then
			BroadMsgByChatPipe(sceneId,selfId,"#{YXDHYD_20210205_49}",0)
			LuaFnSetCopySceneData_Param(sceneId,10,13)
		end
		if Chat_1 == 13 then
			--来一条提示
			BeginEvent(sceneId)
				AddText(sceneId,"#{YXDHYD_20210205_50}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			--触发NPCtalk
			LuaFnNpcTalkToHuman(sceneId,selfId,117)
			--创建一个沈夜雨2号
			CreateMonsterWithDir(sceneId,49011,175,63,6,-1,891104,11) --沈夜雨
			SetMissionByIndex(sceneId,selfId,nMisIndex,x891099_g_IsMissionCheck,7)
			SetMissionByIndex(sceneId,selfId,nMisIndex,2,1)
		end
	end
end

--玩家在一个 area 呆了一段时间没走则定时触发【注意，这个特性程序是不支持的】
function x891099_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个area停留多久了
	local StandingTime;
	local Chat_1 = LuaFnGetCopySceneData_Param(sceneId,10)
	if Chat_1 >= 1 and Chat_1 < 4 then
		StandingTime = QueryAreaStandingTime( sceneId, selfId )
		if StandingTime >= 5000 then
			x891099_OnEnterArea( sceneId, selfId )
			ResetAreaStandingTime( sceneId, selfId, 0 )
		end
	elseif Chat_1 > 4 and Chat_1 <= 7 then
		StandingTime = QueryAreaStandingTime( sceneId, selfId )
		if StandingTime >= 5000 then
			x891099_OnEnterArea( sceneId, selfId )
			ResetAreaStandingTime( sceneId, selfId, 0 )
		end
	elseif Chat_1 > 8 then
		StandingTime = QueryAreaStandingTime( sceneId, selfId )
		if StandingTime >= 5000 then
			x891099_OnEnterArea( sceneId, selfId )
			ResetAreaStandingTime( sceneId, selfId, 0 )
		end
	end
end

--玩家离开一个 area 时触发
function x891099_OnLeaveArea( sceneId, selfId )
end

--**********************************
--怪物死亡
--**********************************
function x891099_OnDie(sceneId,selfId,killerId)
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
	local nMisIndex = GetMissionIndexByID(sceneId,playerID,x891099_g_MissionId)
	local szName = GetName(sceneId,selfId)
	if szName == "伪装的家丁甲" or szName == "伪装的家丁乙" then
		local nKillNum = LuaFnGetCopySceneData_Param(sceneId,7)
		nKillNum = nKillNum + 1
		x891099_NotifyTips(sceneId,ScriptGlobal_Format("#{YXDHYD_20210205_24}",nKillNum))
		SetMissionByIndex(sceneId,playerID,nMisIndex,2,nKillNum) --设置第三个任务已完成，客户端有动态显示
		if nKillNum >= 2 then
			local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
			SetMissionByIndex(sceneId,playerID,nMisIndex,x891099_g_IsMissionCheck,3) --设置第三个任务已完成，客户端有动态显示
			SetMissionByIndex(sceneId,playerID,nMisIndex,2,0)
			x891099_NotifyTips(sceneId,"#{YXDHYD_20210205_25}")
			--直接删除家丁
			LuaFnDeleteMonster(sceneId,selfId)
			--生成倒地的家丁
			LuaFnCreateMonster(sceneId,49012,nPosX,nPosZ,3,-1,-1)
		end
		LuaFnSetCopySceneData_Param(sceneId,7,nKillNum)
	end
end
--**********************************
--全屏提示
--**********************************
function x891099_NotifyTips(sceneId,tip)
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i = 0,membercount - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId,tip);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,mems[i])
		end
	end
end
--**********************************
--对话框提示
--**********************************
function x891099_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end