--凤凰陵墓副本核心内容
x050063_g_ScriptId	= 050063
x050063_g_BossAIScript = 050065
x050063_g_CopySceneType = FUBEN_PHOENIXMAZE --副本类型
x050063_g_LimitMembers = 1 --可以进副本的最小队伍人数
x050063_g_TickTime = 1 --回调脚本的时钟时间（单位：秒/次）
x050063_g_LimitTimeSuccess = 1800 --副本时间限制（单位：次数），如果此时间到了，任务完成
x050063_g_CloseTick = 60 --副本关闭前倒计时（单位：次数）
x050063_g_NoUserTime = 10 --副本中没有人后可以继续保存的时间（单位：秒）
x050063_g_Fuben_X = 16  --进入副本的位置X
x050063_g_Fuben_Z = 111 --进入副本的位置Z
x050063_g_TotalNeedKillNum	= 43 --需要杀死的怪物数量
x050063_g_MinLevel = 40; --进入场景所需最低等级
--x050063_g_Titleindex = 12		--凤凰古城的霸主称号策划ID
x050063_g_SceneData_KillNum = 9  --记录玩家杀怪数量。
x050063_g_SceneData_KillBossNum = 10 --记录是否击杀BOSS
x050063_g_SceneData_BackPosX = 11 --源场景X
x050063_g_SceneData_BackPosZ = 12 --源场景Z
x050063_g_SceneData_SKILLTIME_1 = 13 --单个高爆弹全屏提示倒计时
x050063_g_SceneData_SKILLTIME_2 = 14 --单个燃烧弹全屏提示倒计时
x050063_g_SceneData_SKILLTIME_3 = 15 --满屏高爆弹全屏提示倒计时
x050063_g_SceneData_CreateBossoutTick = 16 --创建Boss的倒计时
x050063_g_SceneData_CreateBossFlag = 17 --Boss创建标记
--小怪摸金校尉的43个坐标点
x050063_g_DogPostable = 
{
	{x = 73,z = 114},{x = 75,z = 108},{x = 84,z = 108},{x = 85,z = 114},{x = 107,z = 109},{x = 107,z = 114},{x = 112,z = 118},
	{x = 119,z = 119},{x = 118,z = 111},{x = 118,z = 105},{x = 113,z = 105},{x = 105,z = 77},{x = 113,z = 77},{x = 119,z = 68},
	{x = 119,z = 58},{x = 112,z = 56},{x = 106,z = 56},{x = 102,z = 56},{x = 101,z = 67},{x = 97,z = 33},{x = 116,z = 33},
	{x = 118,z = 26},{x = 118,z = 18},{x = 107,z = 13},{x = 95,z = 21},{x = 73,z = 33},{x = 72,z = 28},{x = 73,z = 19},
	{x = 73,z = 17},{x = 64,z = 13},{x = 55,z = 13},{x = 52,z = 22},{x = 53,z = 31},{x = 61,z = 34},{x = 16,z = 10},
	{x = 9,z = 17},{x = 8,z = 28},{x = 14,z = 29},{x = 23,z = 28},{x = 16,z = 18},{x = 15,z = 61},{x = 11,z = 62},{x = 11,z = 70}
}
--摸金校尉的title
x050063_g_DogTitle = "专业盗墓"
--搬山道人的title
x050063_g_BossTitle = "盗墓首领"
x050063_g_BossDataID = {13759,13760,13761,13762,13763,13764,13765,13766,13767}
x050063_g_DogDataID = {13750,13751,13752,13753,13754,13755,13756,13757,13758}
--**********************************
--任务入口函数
--**********************************
function x050063_OnDefaultEvent( sceneId, selfId, targetId )
	if x050063_CheckCopyAccept(sceneId,selfId) == 0 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
		return
	end
	local nearmembercount = GetTeamMemberCount(sceneId,selfId)
	--关闭窗口
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,1000)
	--删除怪物
	LuaFnDeleteMonster(sceneId,targetId)
	--创建副本
	x050063_MakeCopyScene(sceneId,selfId,nearmembercount)
end
--**********************************
--检测玩家是否符合进入副本条件
--**********************************
function x050063_CheckCopyAccept(sceneId,selfId)
	local TeammateCount = GetTeamMemberCount(sceneId,selfId)--队友数量。
	local NearCount = GetNearTeamCount(sceneId,selfId) --在我附近的队友数量。
	if GetLevel(sceneId,selfId) < x050063_g_MinLevel then
		x050063_MsgBox(sceneId,selfId,-1,"#{FHGC_090706_14}")
		return 0
	end
	if LuaFnHasTeam(sceneId,selfId) == 0 then
		x050063_MsgBox(sceneId,selfId,-1,"#{FHGC_090706_39}")
		return 0
	end
	if GetTeamSize(sceneId,selfId) < x050063_g_LimitMembers then
		x050063_MsgBox(sceneId,selfId,-1,"#{FHGC_090706_13}")
		return 0
	end
	if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
		x050063_MsgBox(sceneId,selfId,-1,"#{FHGC_090706_15}")
		return 0
	end
	-- if GetTitle(sceneId,selfId,x050063_g_Titleindex) == 0 then
		-- x050063_MsgBox(sceneId,selfId,-1,"#{FHGC_090706_16}")
		-- return 0
	-- end
	--FHGC_090706_17	    虽然你的#G同盟#W获胜了，但是你的#G帮会#W没有参与#G城战#W，不可带队进入。
	
	if NearCount ~= TeammateCount then
		x050063_MsgBox(sceneId,selfId,-1,"#{FHGC_090706_18}")
		return 0
	end
	--开始判断队伍内成员是否符合进入凤凰陵墓副本条件。
	local TeammateID;
	local Humanlist = {}
	local nHumanNum = 0
	local szText = "#{FHGC_090706_36}"
	for i = 0,TeammateCount - 1 do
		TeammateID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeammateID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeammateID) == 1 and LuaFnIsCharacterLiving(sceneId,TeammateID) == 1 then
			if GetLevel(sceneId,TeammateID) < x050063_g_MinLevel then
				Humanlist[nHumanNum] = GetName(sceneId,TeammateID)
				nHumanNum = nHumanNum + 1
			end
		end
	end
	if nHumanNum > 0 then
		for i = 0,nHumanNum - 2 do
			szText = szText..Humanlist[i].."#{FHGC_090706_37}"
		end
		x050063_MsgBox(sceneId,selfId,-1,szText)
		return 0
	end
	return 1
end
--**********************************
--远程调用交互入口
--**********************************
function x050063_OnEnumerate(sceneId,selfId,targetId)
	if x050063_CheckCopyAccept(sceneId,selfId) == 0 then
		AddNumText(sceneId,x050063_g_ScriptId,"#{INTERFACE_XML_426}",0,-1)
		return
	end
	AddText(sceneId,"#{FHGC_090706_19}")
	AddNumText(sceneId,x050063_g_ScriptId,"#{FHGC_xml_XX(01)}" ,10 ,-1)
end
--**********************************
--创建副本
--**********************************
function x050063_MakeCopyScene(sceneId,selfId,nearmembercount)
	--最终结果
	local nHumanLevel	= 0;
	--临时变量
	local mems = {};
	local tempMemlevel = 0;
	for	i = 0, nearmembercount - 1 do
		mems[i]	= GetNearTeamMember(sceneId, selfId, i);
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			tempMemlevel = tempMemlevel + GetLevel(sceneId, mems[i]);
		end
	end
	nHumanLevel = tempMemlevel / nearmembercount
	if nHumanLevel < 40 then
		nHumanLevel = 40
	elseif nHumanLevel > 119 then
		nHumanLevel = 119
	end
	local leaderguid = LuaFnObjId2Guid( sceneId,selfId)
	local nPosX,nPosZ = GetWorldPos( sceneId,selfId)	
	LuaFnSetSceneLoad_Map( sceneId, "PhoenixMaze.path" )
	LuaFnSetCopySceneData_TeamLeader( sceneId, leaderguid )
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId,x050063_g_NoUserTime*1000)
	LuaFnSetCopySceneData_Timer( sceneId, x050063_g_TickTime*1000)
	LuaFnSetCopySceneData_Param( sceneId,0,x050063_g_CopySceneType )
	LuaFnSetCopySceneData_Param( sceneId,1,x050063_g_ScriptId )
	LuaFnSetCopySceneData_Param( sceneId,2,0 )
	LuaFnSetCopySceneData_Param( sceneId,3,-1)
	LuaFnSetCopySceneData_Param( sceneId,4,0)
	LuaFnSetCopySceneData_Param( sceneId,5,0)
	LuaFnSetCopySceneData_Param( sceneId,6,GetTeamId( sceneId,selfId))
	LuaFnSetCopySceneData_Param( sceneId,7,0)
	for i = 8,31 do
		LuaFnSetCopySceneData_Param( sceneId,i,0)
	end
	
	LuaFnSetSceneLoad_Monster(sceneId,"PhoenixMaze_monster.ini")
	LuaFnSetCopySceneData_Param(sceneId, CopyScene_LevelGap, nHumanLevel) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	local bRetSceneID = LuaFnCreateCopyScene( sceneId )						--初始化完成后调用创建副本函数
	if bRetSceneID > 0 then
		x050063_NotifyTip( sceneId, selfId, "#{FHGC_090706_33}" )
	else
		x050063_NotifyTip( sceneId, selfId, "#{FHGC_090706_34}" )
	end
end
--**********************************
--生成怪物
--**********************************
function x050063_CreateMonster(sceneId,nType)
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId,CopyScene_LevelGap)
	local MonsterId;
	local nMonsterDataID;
	if nType == "CreateDog" then
		nMonsterDataID = x050063_g_DogDataID[floor(nHumanLevel / 10) - 3]
		for i = 1,x050063_g_TotalNeedKillNum do
			MonsterId = LuaFnCreateMonster(sceneId,nMonsterDataID,x050063_g_DogPostable[i].x,x050063_g_DogPostable[i].z,21,-1,x050063_g_ScriptId)
			if MonsterId > -1 then
				SetCharacterTitle(sceneId,MonsterId,x050063_g_DogTitle)
				SetLevel(sceneId,MonsterId,nHumanLevel)
			end
		end
	elseif nType == "CreateBoss" then
		nMonsterDataID = x050063_g_BossDataID[floor(nHumanLevel / 10) - 3]
		MonsterId = LuaFnCreateMonster(sceneId,nMonsterDataID,67,73,21,-1,x050063_g_BossAIScript)
		if MonsterId > -1 then
			SetCharacterTitle(sceneId,MonsterId,x050063_g_BossTitle)
			SetLevel(sceneId,MonsterId,nHumanLevel)
		end
	end
end
--**********************************
--杀死怪物或玩家
--**********************************
function x050063_OnDie(sceneId,objId,killerId)
	local MonsterData = GetMonsterDataID(sceneId,objId)
	--是否是副本
	local sceneType = LuaFnGetSceneType( sceneId )
	if sceneType ~= 1 then
		return
	end
	--是否是所需要的副本
	local fubentype = LuaFnGetCopySceneData_Param( sceneId, 0 )
	if fubentype ~= x050063_g_CopySceneType then
		return
	end
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param( sceneId, 4 )
	--如果副本已经被置成关闭状态，则杀怪无效
	if leaveFlag == 1 then
		return
	end
	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	local KillBossNum = LuaFnGetCopySceneData_Param(sceneId,x050063_g_SceneData_KillBossNum)
	local killMonsterNum = LuaFnGetCopySceneData_Param(sceneId,x050063_g_SceneData_KillNum)
	--击杀小怪计入数据中
	if MonsterData >= 13750 and MonsterData <= 13758 then
		killMonsterNum = killMonsterNum + 1
		LuaFnSetCopySceneData_Param( sceneId,x050063_g_SceneData_KillNum,killMonsterNum)
	end
	--击杀Boss
	if MonsterData >= 13759 and MonsterData <= 13767 then
		KillBossNum = KillBossNum + 1
		LuaFnSetCopySceneData_Param(sceneId,x050063_g_SceneData_KillBossNum,KillBossNum)
	end
	for i=0, num-1 do
		local ServerID = LuaFnGetCopyScene_HumanObjId( sceneId, i )	  --取得当前场景里人的objId
		if LuaFnIsObjValid(sceneId,ServerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,ServerID) == 1 and LuaFnIsCharacterLiving(sceneId,ServerID) == 1 then
			if killMonsterNum > 0 and killMonsterNum <= x050063_g_TotalNeedKillNum and KillBossNum < 1 then --这里给全屏提示，提示只有刷小怪的时候提示。
				x050063_NotifyTip(sceneId,ServerID,format("#{FHGC_090706_20}%s/%s",killMonsterNum,x050063_g_TotalNeedKillNum))
			end
			if killMonsterNum >= x050063_g_TotalNeedKillNum and KillBossNum < 1 then
				--发个全屏提示然后准备生成小怪了。
				x050063_NotifyTip(sceneId,ServerID,"#{FHGC_090706_21}")
			end
		end
	end
	--摸金校尉完事了，搬山道人也完事了。
	if killMonsterNum >= x050063_g_TotalNeedKillNum and KillBossNum >= 1 then
		LuaFnSetCopySceneData_Param(sceneId,4,1)  --设置任务完成标志
	end
    if killMonsterNum >= x050063_g_TotalNeedKillNum and KillBossNum < 1 then
		--创建搬山道人，写入倒计时数据十秒
		LuaFnSetCopySceneData_Param(sceneId,x050063_g_SceneData_CreateBossFlag,1)
		LuaFnSetCopySceneData_Param(sceneId,x050063_g_SceneData_CreateBossoutTick,10)
	end
end
--**********************************
--副本事件
--**********************************
function x050063_OnCopySceneReady( sceneId, destsceneId )
	--设置副本入口场景号
	LuaFnSetCopySceneData_Param( destsceneId,3,sceneId )
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	local nPosX,nPosZ = GetWorldPos(sceneId,leaderObjId)
	LuaFnSetCopySceneData_Param(destsceneId,x050063_g_SceneData_BackPosX,nPosX)
	LuaFnSetCopySceneData_Param(destsceneId,x050063_g_SceneData_BackPosZ,nPosZ)
	NewWorld( sceneId,leaderObjId, destsceneId, x050063_g_Fuben_X, x050063_g_Fuben_Z)
	local nearmembercount = GetNearTeamCount( sceneId, leaderObjId )
	local member
	for	i=0, nearmembercount - 1 do
		member = GetNearTeamMember( sceneId,leaderObjId,i)
		if LuaFnIsObjValid(sceneId,member) == 1 and LuaFnIsCanDoScriptLogic(sceneId,member) == 1 and LuaFnIsCharacterLiving(sceneId,member) == 1 then
			NewWorld( sceneId, member, destsceneId, x050063_g_Fuben_X, x050063_g_Fuben_Z )
		end
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x050063_OnPlayerEnter(sceneId,selfId)
	--设置死亡复活点。
	SetPlayerDefaultReliveInfo(sceneId,selfId,"%10", -1, "0",sceneId, x050063_g_Fuben_X,x050063_g_Fuben_Z)
end

--**********************************
--将某玩家传送出副本,回到进入时的位置
--**********************************
function x050063_KickOut(sceneId,objId)
    local oldSceneId = LuaFnGetCopySceneData_Param(sceneId,3)	--取得副本入口场景号
	local oldPosX = LuaFnGetCopySceneData_Param( sceneId,x050063_g_SceneData_BackPosX) --进入时的坐标X
	local oldPosZ = LuaFnGetCopySceneData_Param( sceneId,x050063_g_SceneData_BackPosZ) --进入时的坐标Z
	if LuaFnIsObjValid(sceneId,objId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,objId) == 1 and LuaFnIsCharacterLiving(sceneId,objId) == 1 then
	    NewWorld(sceneId,objId,oldSceneId,oldPosX,oldPosZ)
	end
end

--**********************************
--副本场景定时器事件
--**********************************
function x050063_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟读取及设置
	--取得已经执行的定时次数
	local strText
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, 2 )
	local SkillTimeA = LuaFnGetCopySceneData_Param( sceneId,x050063_g_SceneData_SKILLTIME_1)
	local SkillTimeB = LuaFnGetCopySceneData_Param( sceneId,x050063_g_SceneData_SKILLTIME_2)
	local SkillTimeC = LuaFnGetCopySceneData_Param( sceneId,x050063_g_SceneData_SKILLTIME_3)
	local BossoutTick = LuaFnGetCopySceneData_Param(sceneId,x050063_g_SceneData_CreateBossoutTick)
	local CreateBossflag = LuaFnGetCopySceneData_Param(sceneId,x050063_g_SceneData_CreateBossFlag)
	TickCount = TickCount + 1
	--设置新的定时器调用次数
	LuaFnSetCopySceneData_Param( sceneId, 2, TickCount )
	--副本创建随之直接创建摸金校尉
	if TickCount == 1 then
		x050063_CreateMonster(sceneId,"CreateDog")
	end
	--创建搬山道人
	if CreateBossflag == 1 then
		if BossoutTick > 0 then
			BossoutTick = BossoutTick - 1
			if BossoutTick == 0 then
				x050063_CreateMonster(sceneId,"CreateBoss")
			end
			LuaFnSetCopySceneData_Param(sceneId,x050063_g_SceneData_CreateBossoutTick,BossoutTick)
		end
	end
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param( sceneId, 4 )
	local membercount = LuaFnGetCopyScene_HumanCount( sceneId )
	local mems = {}
	--随时检查
	local oldteamid = LuaFnGetCopySceneData_Param( sceneId, 6 )		--取得保存的队伍号
	for	i = 0, membercount -1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			if oldteamid ~= GetTeamId( sceneId, mems[i] ) then
				--给一条提示
				x050063_TipAllHuman(sceneId,"你不在正确的队伍中!")
				x050063_KickOut( sceneId, mems[i] )
			end
		end
	end
	--单个高爆弹全屏提示。
	if SkillTimeA > 0 then
		x050063_TipAllHuman(sceneId,format("#{FHGC_090706_24}%s".."#{FHGC_090730_01}",SkillTimeA))
		SkillTimeA = SkillTimeA - 1
		LuaFnSetCopySceneData_Param( sceneId,x050063_g_SceneData_SKILLTIME_1,SkillTimeA)
	end
	if SkillTimeB > 0 then
		x050063_TipAllHuman(sceneId,format("#{FHGC_090706_23}%s".."#{FHGC_090730_01}",SkillTimeB))
		SkillTimeB = SkillTimeB - 1
		LuaFnSetCopySceneData_Param( sceneId,x050063_g_SceneData_SKILLTIME_2,SkillTimeB)
	end
	if SkillTimeC > 0 then
		x050063_TipAllHuman(sceneId,format("#{FHGC_090706_25}%s".."#{FHGC_090730_01}",SkillTimeC))
		SkillTimeC = SkillTimeC - 1
		LuaFnSetCopySceneData_Param( sceneId,x050063_g_SceneData_SKILLTIME_3,SkillTimeC)
	end
	
	--副本结束已关闭
	if leaveFlag == 1 then
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param( sceneId, 5 )
		leaveTickCount = leaveTickCount + 1
		LuaFnSetCopySceneData_Param( sceneId, 5, leaveTickCount )
		if leaveTickCount == x050063_g_CloseTick then --倒计时间到，大家都出去吧
			--将当前副本场景里的所有人传送回原来进入时候的场景
			for	i=0, membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
				if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
					x050063_KickOut( sceneId, mems[i] )				
				end
			end
		end
		if mod(leaveTickCount,5) == 0 then
			x050063_TipAllHuman(sceneId,"#{FHGC_090706_22}"..x050063_g_CloseTick - leaveTickCount.."#{FHGC_090706_32}")
		end
	--到总时间限制了
	elseif TickCount == x050063_g_LimitTimeSuccess then
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId,4,1)
	end
end

--**********************************
--对话框通知事件
--**********************************
function x050063_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
	AddText( sceneId,  msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示所有副本内玩家
--**********************************
function x050063_TipAllHuman( sceneId, Str )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	local PlayerId;
	for i=0, nHumanNum-1  do
		PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId,PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId,PlayerId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, PlayerId)
		end
	end
end

--**********************************
--场景通知事件
--**********************************
function x050063_NotifyTip(sceneId, selfId, msg)
	BeginEvent( sceneId )
	AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--==============================================
--不干活全部放到下面扔着，看着不乱。
--==============================================
--**********************************
--有玩家在副本中死亡事件
--**********************************
function x050063_OnHumanDie( sceneId, selfId, killerId )
end
--**********************************
--检测接受条件
--**********************************
function x050063_CheckAccept( sceneId, selfId )	
	return 1
end
--**********************************
--放弃
--**********************************
function x050063_OnAbandon( sceneId, selfId )
end
--**********************************
--进入区域事件
--**********************************
function x050063_OnEnterZone( sceneId, selfId, zoneId )
end
--**********************************
--道具改变
--**********************************
function x050063_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--继续
--**********************************
function x050063_OnContinue( sceneId, selfId, targetId )
end
--**********************************
--检测是否可以提交
--**********************************
function x050063_CheckSubmit( sceneId, selfId, selectRadioId )
end
--**********************************
--提交
--**********************************
function x050063_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end