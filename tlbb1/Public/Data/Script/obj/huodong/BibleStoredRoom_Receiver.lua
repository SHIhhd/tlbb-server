--藏经阁副本主逻辑
--************************************************************************
x402107_g_ScriptId = 402107
--************************************************************************
x402107_g_CopySceneName = "藏经阁"
x402107_g_CopySceneType = FUBEN_BIBLESTORED_ROOM 	--副本类型，定义在ScriptGlobal.lua里面
x402107_g_CloseTime = 30*60   -----副本存在时间
x402107_g_DogCount = 6   -----小怪刷怪数量
x402107_g_CopySceneMap = "cangjingge.path"
x402107_g_LimitMembers = 1				--可以进副本的最小队伍人数
x402107_g_minLevel	= 40				--可以进入副本的最小等级
x402107_g_TickTime = 1					--回调脚本的时钟时间（单位：秒/次）
x402107_g_OutTime = 60					--副本关闭了，还剩余60s就给玩家弄出去了。
x402107_g_CloseTick = 3						--副本关闭前倒计时（单位：次数）
x402107_g_NoUserTime = 10				--副本中没有人后可以继续保存的时间（单位：秒）
x402107_g_DeadTrans = 0						--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x402107_g_Fuben_X = 66						--进入副本的位置X
x402107_g_Fuben_Z = 105						--进入副本的位置Z
x402107_g_KongfuMonk_Script = 402108		--副本内少林云游武僧的Script
------为军官 左
x402107_g_MonsterInfo_1 = {{x=23,z=47},{x=22,z=47},{x=21,z=47},{x=24,z=47},{x=25,z=47},{x=26,z=47}}

---  为军官 右
x402107_g_MonsterInfo_2 = {{x=103,z=48},{x=102,z=48},{x=101,z=48},{x=104,z=48},{x=105,z=48},{x=106,z=48}}
						   
 ----盗书恶僧左
x402107_g_MonsterInfo_3 = {x=23,z=47}
						   
 ----盗书恶僧右
x402107_g_MonsterInfo_4 = {x=103,z=48}
						   
 ----BOSS
x402107_g_MonsterInfo_5 = {id=13592,x=64,z=32 ,ai=2 ,ai_f=0,p=0}

--**********************************
--任务入口函数
--**********************************
function x402107_OnDefaultEvent( sceneId, selfId, targetId )
	if GetName(sceneId,targetId) ~= "少林云游武僧" then
		return
	end
	local nRet = x402107_CheckCopyScene(sceneId,selfId,targetId)
	--二次检测部分内容，防止有人卡副本
	if nRet == 2 then
		x402107_MsgBox(sceneId,selfId,targetId,"#{CJG_090413_10}")
		return
	end
	if nRet == 3 then
		x402107_MsgBox(sceneId,selfId,targetId,"#{CJG_090413_09}")
		return
	end
	x402107_MakeCopyScene(sceneId,selfId,targetId) --创建副本
	LuaFnDeleteMonster(sceneId, targetId) --删除NPC
end

--**********************************
--列举事件
--**********************************
function x402107_OnEnumerate( sceneId, selfId, targetId )
	local nRet,msg = x402107_CheckCopyScene(sceneId,selfId,targetId)
	AddText(sceneId,msg)
	if nRet == 1 or nRet == 2 or nRet == 3 then
		AddNumText(sceneId,x402107_g_ScriptId,"#{CJG_090413_08}",10,-1)
	end
end
--**********************************
--副本进入检测
--**********************************
function x402107_CheckCopyScene(sceneId,selfId,targetId)
	if GetName(sceneId,targetId) ~= "少林云游武僧" then
		return 0,"你在干什么？"
	end
	local nLevel = GetLevel(sceneId,selfId)
	local nHumanNum = 0;
	--取得玩家附近的队友数量（包括自己）
	local nearteammembercount = GetNearTeamCount(sceneId,selfId) 
	if nLevel < 40 then
		return 0,"#{CJG_090413_03}"
	end
	if LuaFnHasTeam(sceneId,selfId) == 0 then
		return 0,"#{CJG_090413_04}"
	end
	if nearteammembercount < x402107_g_LimitMembers then
		return 2,"#{CJG_090413_05}"
	end
	if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
		return 0,"#{CJG_090413_06}"
	end
	--检测队伍内玩家等级
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 and LuaFnIsCharacterLiving(sceneId,TeamPlayerID) == 1 then
			if GetLevel(sceneId,TeamPlayerID) < x402107_g_minLevel then
				nHumanNum = nHumanNum + 1
			end
		end
	end
	if nHumanNum > 0 then
		return 3,"#{CJG_090413_05}"
	end
	return 1,"#{CJG_090413_07}"
end
--**********************************
--检测接受条件
--**********************************
function x402107_CheckAccept( sceneId, selfId )
	
end

--**********************************
--询问玩家是否要进入副本
--**********************************
function x402107_AskEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--接受
--**********************************
function x402107_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--玩家同意进入副本
--**********************************
function x402107_AcceptEnterCopyScene( sceneId, selfId )
	
end
--**********************************
--创建副本
--**********************************
function x402107_MakeCopyScene( sceneId, selfId, targetId )
	
	-- 使用队员的等级来算出怪物的等级
	local param0 = 4;
	local param1 = 3;
	--最终结果
	local mylevel = 0;
	--临时变量
	local memId;
	local tempMemlevel = 0;
	local level0 = 0;
	local level1 = 0;
	local i;
	local nearmembercount = GetNearTeamCount(sceneId,selfId)
	for	i = 0, nearmembercount - 1 do
		memId = GetNearTeamMember(sceneId, selfId, i);
		if LuaFnIsObjValid(sceneId,memId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,memId) == 1 and LuaFnIsCharacterLiving(sceneId,memId) == 1 then
			tempMemlevel = GetLevel(sceneId, memId);
		end
		level0 = level0 + (tempMemlevel ^ param0);
		level1 = level1 + (tempMemlevel ^ param1);
	end
	if level1 == 0 then
		mylevel = 0
	else
		mylevel = level0/level1;
	end
	if nearmembercount == -1  then  --没有队伍
		mylevel = GetLevel(sceneId, selfId)
	end
	
	local leaderguid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId,x402107_g_CopySceneMap); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId,x402107_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x402107_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x402107_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x402107_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2,0);		--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3,-1);	--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4,0);		--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5,0);		--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6,GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7,0) ;	--杀死Boss的数量
	
	-- 剧情用到的变量清空
	for i=8, 31 do
		LuaFnSetCopySceneData_Param(sceneId, i, 0)
	end
	
	local PlayerMaxLevel = GetHumanMaxLevelLimit()
	local iniLevel;
	if mylevel < 10 then
		iniLevel = 1;
	elseif mylevel < PlayerMaxLevel then
		iniLevel = floor(mylevel/10);
	else
		iniLevel = floor(PlayerMaxLevel/10);
	end
	
	-- 使用第8位，记录怪物实际的等级
	LuaFnSetCopySceneData_Param(sceneId,8, mylevel)  ---实际等级
	LuaFnSetCopySceneData_Param(sceneId,9, iniLevel) ---取整的等级
	
	local x,z = GetWorldPos(sceneId,selfId)
	LuaFnSetCopySceneData_Param(sceneId,16, x)
	LuaFnSetCopySceneData_Param(sceneId,17, z)
	local bRetSceneID = LuaFnCreateCopyScene(sceneId)
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"副本创建成功！")
		else
			AddText(sceneId,"副本数量已达上限，请稍候再试！")
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

--**********************************
--副本事件
--**********************************
function x402107_OnCopySceneReady( sceneId, destsceneId )
	
	--进入副本的规则
	-- 1，如果这个文件没有组队，就传送这个玩家自己进入副本
	-- 2, 如果玩家有队伍，但是玩家不是队长，就传送自己进入副本
	-- 3，如果玩家有队伍，并且这个玩家是队长，就传送自己和附近队友一起进去

	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId) --设置副本入口场景号
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId)
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid)
	
	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then			-- 处于无法执行逻辑的状态
		return
	end
	
	-- 检测玩家是不是有队伍
	if LuaFnHasTeam(sceneId,leaderObjId) == 0  then   -- 没有队伍
		x402107_GotoScene(sceneId,leaderObjId,destsceneId)
	else
		if IsCaptain(sceneId, leaderObjId) == 0  then
			x402107_GotoScene(sceneId, leaderObjId, destsceneId)
		else
			local nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
			local mems = {}
			for	i=0,nearteammembercount-1 do
				mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
				if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
					x402107_GotoScene(sceneId, mems[i], destsceneId)
				end
			end
		end
	end

end

function x402107_GotoScene(sceneId, ObjId, destsceneId)
	NewWorld( sceneId, ObjId, destsceneId, x402107_g_Fuben_X, x402107_g_Fuben_Z) ;
end


--**********************************
--有玩家进入副本事件
--**********************************
function x402107_OnPlayerEnter( sceneId, selfId )
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%10", -1, "0", sceneId, x402107_g_Fuben_X, x402107_g_Fuben_Z )
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x402107_OnHumanDie( sceneId, selfId, killerId )
	
end

--**********************************
--放弃
--**********************************
function x402107_OnAbandon( sceneId, selfId )
	
end

--**********************************
-- 回城，只有城市任务副本可以调用此接口
--**********************************
function x402107_BackToCity( sceneId, selfId )
	
end

--**********************************
--继续
--**********************************
function x402107_OnContinue( sceneId, selfId, targetId )
	
end	

--**********************************
--检测是否可以提交
--**********************************
function x402107_CheckSubmit( sceneId, selfId, selectRadioId )
	
end

--**********************************
--提交
--**********************************
function x402107_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
end

--**********************************
--杀死怪物或玩家
--**********************************
function x402107_OnKillObject( sceneId, selfId, objdataId, objId )
	
end

--**********************************
--进入区域事件
--**********************************
function x402107_OnEnterZone( sceneId, selfId, zoneId )
	
end

--**********************************
--道具改变
--**********************************
function x402107_OnItemChanged( sceneId, selfId, itemdataId )
	
end

--**********************************
--副本场景定时器事件
--**********************************
function x402107_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟读取及设置
	--取得已经执行的定时次数
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, 2 )
	TickCount = TickCount + 1
	--设置新的定时器调用次数
	LuaFnSetCopySceneData_Param( sceneId,2,TickCount)
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId,4)
	local Interval_time = 135 --这里为间隔时间
	--开始阻击标志
	local Startblock = LuaFnGetCopySceneData_Param(sceneId,18)
	local StartTick = LuaFnGetCopySceneData_Param(sceneId,19) --阻击开始的时间记录
	local nNumber = LuaFnGetCopySceneData_Param(sceneId,20) --记录当前是第几波怪物
	local timedata = LuaFnGetCopySceneData_Param(sceneId,23) --间隔时间记录
	local fodengtm = LuaFnGetCopySceneData_Param(sceneId,24) --佛灯时间记录
	local NndTime = LuaFnGetCopySceneData_Param(sceneId, 21)   -------结束时间标志
	--离开副本标志，需要离开副本
	if leaveFlag == 1 then
		--如果不满足上面的条件那肯定是刷完了倒计时60s给玩家送出去
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId,5);
		leaveTickCount = leaveTickCount + 1;
		LuaFnSetCopySceneData_Param(sceneId,5,leaveTickCount);
		--这个情况一定是少林云游僧死了，直接给场内玩家送出去
		if nNumber < 10 then
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId,PlayerId) == 1 then
					x402107_KickOut(sceneId,PlayerId)
				end
			end
			return
		end
		if leaveTickCount == x402107_g_OutTime then --倒计时间到，大家都出去吧
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId,PlayerId) == 1 then
					x402107_KickOut(sceneId,PlayerId)
				end
			end
		end
	elseif TickCount == x402107_g_CloseTime then --副本总时间限制到了直接给玩家传送出去
		LuaFnSetCopySceneData_Param(sceneId,4,1)
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanNum-1  do
			local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId,PlayerId) == 1 then
				x402107_KickOut(sceneId,PlayerId)
			end
		end
	end
	if TickCount == 5 then  --副本创建执行5s后创建初始化NPC
		local PlayerLv = LuaFnGetCopySceneData_Param(sceneId,8)
		local iniLevel = LuaFnGetCopySceneData_Param(sceneId,9)		
		local nRetrievalMonterID = 13565
		if iniLevel >= 11 then
		   nRetrievalMonterID = nRetrievalMonterID + 8	
		else
		   nRetrievalMonterID = nRetrievalMonterID + iniLevel - 3		
		end		
		local nNpcId = LuaFnCreateMonster(sceneId,nRetrievalMonterID,64,105,6,226,x402107_g_KongfuMonk_Script)
		SetMonsterFightWithNpcFlag(sceneId,nNpcId,1)
		SetLevel(sceneId,nNpcId,PlayerLv) --设置少林云游武僧等级
		LuaFnSetCopySceneData_Param(sceneId,13,nNpcId) --记录少林云游武僧的场景OBJ
		LuaFnSetCopySceneData_Param(sceneId,15,nRetrievalMonterID) --记录副本内少林云游武僧的MonsterID
		--发送一个全屏提示
		x402107_TipAllHuman(sceneId,"#{CJG_090605_1}")
		MonsterTalk(sceneId,-1,"藏经阁","#{CJG_090413_43}")
	end
	--这里做个判断，如果玩家进入副本30s没有执行阻击操作，则自动开始阻击
	if TickCount >= 30 then
		if Startblock == 0 then
			LuaFnSetCopySceneData_Param(sceneId,18,1) --自动开始阻击
			--发送对话
			local nObjID = LuaFnGetCopySceneData_Param(sceneId,13)
			LuaFnNpcChat(sceneId,nObjID,0,"#{CJG_090413_20}")
		end
	end
	--阻击开始
	if Startblock >= 1 then
		--开启后，15s后开启第一波怪的进攻
		StartTick = StartTick + 1
		timedata = timedata + 1
		LuaFnSetCopySceneData_Param( sceneId,19,StartTick)
		if timedata <= 135 then
			LuaFnSetCopySceneData_Param(sceneId,23,timedata)
		end
		if StartTick == 15 then --这是第一波怪，独立进行记录，下面的继续计算刷新内容
			--刷新第一波怪物，右上角
			nNumber = nNumber + 1
			x402107_CreateNpcBOSS(sceneId,nNumber)	
			x402107_CreateXiaoBOSS(sceneId,nNumber)
			LuaFnSetCopySceneData_Param(sceneId,20,nNumber)
			LuaFnSetCopySceneData_Param(sceneId,22,0) --每次刷新都清除一次数据
			if nNumber <= 10 then
				if mod(nNumber,2) == 0 then
					x402107_TipAllHuman(sceneId,"#{CJG_090413_21}"..nNumber.."/10".."#{CJG_090413_22}左".."#{CJG_090413_23}")
				else
					x402107_TipAllHuman(sceneId,"#{CJG_090413_21}"..nNumber.."/10".."#{CJG_090413_22}右".."#{CJG_090413_23}")
				end
				x402107_TipAllHuman(sceneId,"#{CJG_090413_32}0/1")
			end
		end
		if StartTick == 18 then
			x402107_CreateNpcBOSS(sceneId,nNumber) --第一波怪物创建后再创建一次。
		end
		--第一波怪刷新之后每过15秒给一次提示
		if nNumber >= 1 and nNumber < 10 then
			if mod(timedata,15) == 0 then
				Interval_time = Interval_time - timedata
				if Interval_time > 0 then
					x402107_TipAllHuman(sceneId,"#{CJG_090605_2}"..Interval_time.."#{CJG_090605_3}")
				end
				--到刷新时间了，开始刷新
				if Interval_time == 0 then
					nNumber = nNumber + 1
					x402107_CreateNpcBOSS(sceneId,nNumber)	
					x402107_CreateXiaoBOSS(sceneId,nNumber)
					LuaFnSetCopySceneData_Param(sceneId,20,nNumber)
					LuaFnSetCopySceneData_Param(sceneId,22,0) --每次刷新都清除一次击杀数据
					LuaFnSetCopySceneData_Param(sceneId,23,0) --更新下一次刷新时间为0
					if nNumber <= 10 then
						if mod(nNumber,2) == 0 then
							x402107_TipAllHuman(sceneId,"#{CJG_090413_21}"..nNumber.."/10".."#{CJG_090413_22}左".."#{CJG_090413_23}")
						else
							x402107_TipAllHuman(sceneId,"#{CJG_090413_21}"..nNumber.."/10".."#{CJG_090413_22}右".."#{CJG_090413_23}")
						end
						x402107_TipAllHuman(sceneId,"#{CJG_090413_32}0/1")
					end
				end
			end
		end
		--第二波开始这么刷
		if nNumber > 1 and nNumber <= 10 then
			local Refrshtime = LuaFnGetCopySceneData_Param(sceneId,23)
			if Refrshtime == 3 then
				x402107_CreateNpcBOSS(sceneId,nNumber)
			end
		end
		--第一次已经刷新了，然后开始记录时间
		if nNumber == 5 then
			--刷佛灯检测是否有佛灯有就不刷，开了之后进入标记
			local nMonsterNum = GetMonsterCount(sceneId)
			for i = 0, nMonsterNum-1 do
				local MonsterId = GetMonsterObjID(sceneId,i)
				local MosDataID = GetMonsterDataID(sceneId,MonsterId)
				if MosDataID >= 550 and MosDataID <= 552 then
					return
				end
			end
			--佛灯冷却时间
			if fodengtm > 0 then
				return
			end
			x402107_TipAllHuman(sceneId,"#{CJG_090413_11}")
			--随机刷新
			local nFoDeng = random(550,552)
			--刷两个位置。
			LuaFnCreateMonster(sceneId,nFoDeng,84,84,3,-1,402108)
			LuaFnCreateMonster(sceneId,nFoDeng,44,84,3,-1,402108)
			LuaFnSetCopySceneData_Param(sceneId,24,300) --计入数据
		end
		if nNumber >= 5 then
			local fodengtm = LuaFnGetCopySceneData_Param(sceneId,24) --佛灯时间记录
			fodengtm = fodengtm - 1
			LuaFnSetCopySceneData_Param(sceneId,24,fodengtm)
			if fodengtm == 0 then
				x402107_TipAllHuman(sceneId,"#{CJG_090413_11}")
				--这已经不是第一次刷佛灯了，刷新前先检测佛灯
				local nMonsterNum = GetMonsterCount(sceneId)
				for i = 0, nMonsterNum-1 do
					local MonsterId = GetMonsterObjID(sceneId,i)
					local MosDataID = GetMonsterDataID(sceneId,MonsterId)
					if MosDataID >= 550 and MosDataID <= 552 then
						LuaFnDeleteMonster(sceneId,MonsterId)
					end
				end
				--随机刷新
				local nFoDeng = random(550,552)
				--刷两个位置。
				LuaFnCreateMonster(sceneId,nFoDeng,84,84,3,-1,402108)
				LuaFnCreateMonster(sceneId,nFoDeng,44,84,3,-1,402108)
				LuaFnGetCopySceneData_Param(sceneId,24,300) --计入数据
			end
		end
	end
end

--**********************************
--怪物死亡事件
--**********************************
function x402107_OnDie(sceneId,selfId,killerId)
	local KillCount = LuaFnGetCopySceneData_Param(sceneId,22) --击杀怪物数量
	local Number = LuaFnGetCopySceneData_Param(sceneId,20)
	local szName = GetName(sceneId,selfId)
	if szName == "伪官军" then
		if Number < 10 then
			KillCount = KillCount + 1
			--在这记录一下，如果数据等于13了
			if KillCount == 13 then
				LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
				--把刷新时间改为剩余15s
				LuaFnSetCopySceneData_Param(sceneId,23,120)
				x402107_TipAllHuman(sceneId,"#{CJG_090605_4}")
				return
			end
			LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
		else
			--第十波了，如果最后刷完了该刷大BOSS了。
			KillCount = KillCount + 1
			--在这记录一下，如果数据等于13了
			if KillCount == 13 then
				LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
				--最后一波了，这里不在更新了直接出最大怪
				LuaFnSetCopySceneData_Param(sceneId,23,135)
				x402107_TipAllHuman(sceneId,"#{CJG_090413_24}")
				x402107_CreateBoss(sceneId)
				return
			end
			LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
		end
	elseif szName == "盗书恶僧" then
		if Number < 10 then
			KillCount = KillCount + 1
			--在这记录一下，如果数据等于13了
			if KillCount == 13 then
				LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
				--把刷新时间改为剩余15s
				LuaFnSetCopySceneData_Param(sceneId,23,120)
				x402107_TipAllHuman(sceneId,"#{CJG_090605_4}")
				return
			end
			LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
		else
			--第十波了，如果最后刷完了该刷大BOSS了。
			KillCount = KillCount + 1
			--在这记录一下，如果数据等于13了
			if KillCount == 13 then
				LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
				--最后一波了，这里不在更新了直接出最大怪
				LuaFnSetCopySceneData_Param(sceneId,23,135)
				--提示
				x402107_TipAllHuman(sceneId,"#{CJG_090413_24}")
				x402107_CreateBoss(sceneId)
				return
			end
			LuaFnSetCopySceneData_Param(sceneId,22,KillCount)
		end
	elseif szName == "蒙面恶僧" then
		LuaFnSetCopySceneData_Param(sceneId,4,1) --副本关闭标志开启，上面计时器进行逻辑检测
		x402107_TipAllHuman(sceneId,"#{CJG_090413_32}1/1")
		x402107_TipAllHuman(sceneId,"#{CJG_090413_26}60#{CJG_090413_27}")
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				LuaFnFinishZhouHuoYueMission(sceneId,mems[i],19)
				--英雄大会埋点
				if LuaFnHaveImpactOfSpecificDataIndex(sceneId,mems[i],10541) == 1 then
					AddHerosReturnsRecoed(sceneId,mems[i],13)
				end
			end
		end
	end
end

--**********************************
-- 退出副本
--**********************************
function x402107_KickOut( sceneId,objId)
    local oldsceneId = LuaFnGetCopySceneData_Param( sceneId, 3 )	--取得副本入口场景号
	local x = LuaFnGetCopySceneData_Param( sceneId, 16 ) --进入时的坐标X
	local z = LuaFnGetCopySceneData_Param( sceneId, 17 ) --进入时的坐标Z
	if LuaFnIsObjValid(sceneId,objId) == 1
	and LuaFnIsCanDoScriptLogic(sceneId,objId) == 1 
	and LuaFnIsCharacterLiving(sceneId,objId) == 1 then
	    NewWorld(sceneId,objId,oldsceneId,x,z)
	end
end
--**********************************
-- 创建伪官军
--**********************************
function x402107_CreateNpcBOSS(sceneId,Number)
	local nMosnterID = 13583
	local nMonsterPat = 1
	local nMonsterPos;
	if mod(Number,2) == 0 then
		nMonsterPos = x402107_g_MonsterInfo_1 --为偶数就左面出
		nMonsterPat = 0
	else
		nMonsterPos = x402107_g_MonsterInfo_2 --为奇数就右面出
	end
	for i = 1,x402107_g_DogCount  do
		local nNpcId = x402107_CreateNpc(sceneId, nMosnterID, nMonsterPos[i].x, nMonsterPos[i].z,9,0,x402107_g_ScriptId)
		if nNpcId > 0 then
			SetMonsterSpecialNameFlag(sceneId,nNpcId,1)
			SetMonsterFightWithNpcFlag(sceneId,nNpcId,1)
			SetPatrolId(sceneId,nNpcId,nMonsterPat)
		end
	end
end
--**********************************
-- 创建盗书恶僧
--**********************************
function x402107_CreateXiaoBOSS(sceneId,Number)
	local nMosnterID = 13574
	local nMonsterPat = 1
	local nMonsterPos;
	if mod(Number,2) == 0 then
		nMonsterPos = x402107_g_MonsterInfo_3 --为偶数就左面出
		nMonsterPat = 0
	else
		nMonsterPos = x402107_g_MonsterInfo_4 --为奇数就右面出
	end
	local nNpcId = x402107_CreateNpc(sceneId, nMosnterID, nMonsterPos.x, nMonsterPos.z,9,0,x402107_g_ScriptId)
	if nNpcId > 0 then
		SetMonsterSpecialNameFlag(sceneId,nNpcId,1)
		SetMonsterFightWithNpcFlag(sceneId,nNpcId,1)
		SetPatrolId(sceneId,nNpcId,nMonsterPat)
	end
end
--**********************************
-- 创建蒙面恶僧
--**********************************
function x402107_CreateBoss(sceneId)
	local nMosnterID = x402107_g_MonsterInfo_5
	x402107_CreateNpc(sceneId,nMosnterID.id,nMosnterID.x, nMosnterID.z,23, nMosnterID.ai_f, x402107_g_ScriptId)
end

--**********************************
-- 通用创建怪物函数
--**********************************
function x402107_CreateNpc(sceneId,NpcId,x,y,Ai,AiFile,Script)
	local PlayerLevel = LuaFnGetCopySceneData_Param(sceneId,8)
	local ModifyLevel = LuaFnGetCopySceneData_Param(sceneId,9)
	local nNpcId = 0	
	if ModifyLevel >= 11 then
	   nNpcId = NpcId + 8 
	else
	   nNpcId = NpcId + ModifyLevel - 3
	end	
	local nMonsterId = LuaFnCreateMonster(sceneId, nNpcId, x, y, Ai, AiFile, Script)
	SetLevel(sceneId, nMonsterId, PlayerLevel)
	return nMonsterId
end

 --**********************************
--对话框提示
--**********************************
function x402107_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--提示所有副本内玩家
--**********************************
function x402107_TipAllHuman(sceneId,Str)
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId,PlayerId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, PlayerId)
		end
	end
end