--宋辽大战主控脚本

x502011_g_ScriptId 	= 502011
--副本人数上限
x502011_g_SceneHumanMax = 60 			
--宋辽传送点,复活点位置
x502011_g_Relivepos = {{307,310},{73,82}} 
--x502011_g_nEndTimes = 25 * 60 --副本的持续时间（25分钟）
x502011_g_CloseTick = 60	 	--副本关闭前倒计时（单位：次数）
x502011_g_TickTime = 1	   		--回调脚本的时钟时间（单位：秒/次）
x502011_g_NoUserTime = 20 * 1000  	--副本中没有人后可以继续保存的时间（单位：秒）
x502011_g_PlayerCamp_Song = 156
x502011_g_PlayerCamp_Liao = 157
--副本公共数据信息
x502011_g_SceneData_ID = 0				--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
x502011_g_SceneData_ScriptID = 1		--将1号数据设置为副本场景事件脚本号
x502011_g_SceneData_TickCount = 2		--设置定时器调用次数
x502011_g_SceneData_CloseFlag = 3		--设置副本关闭标志, 0开放，1关闭
x502011_g_SceneData_LeaveTimeCount = 4	--设置离开倒计时次数
--x502011_g_SceneData_State = 5			--当前副本的运行状态
x502011_g_SceneData_Dynamic_State_1 = 5		--动阻状态
x502011_g_SceneData_Dynamic_State_2 = 6		--动阻状态
--动态阻挡相关
x502011_g_DyInitState =
{
	--辽区域
	[1]  = {dataid = 6, posx = 84, posy = 86, npcid = 48281, dir = 0.873},
	--宋区域
	[2]  = {dataid = 6, posx = 303, posy = 307, npcid = 48280, dir = 0.780},
}
--正式的祭坛状态时钟
x502011_g_SongliaoWarSingle_Battle_Ready = 0
x502011_g_SongliaoWarSingle_Battle_Start = 10030
x502011_g_SongliaoWarSingle_Battle_OneTimeBegin = 10090
x502011_g_SongliaoWarSingle_Battle_OneTimeEnd = 10390
x502011_g_SongliaoWarSingle_Battle_TwoTimeBegin = 10450
x502011_g_SongliaoWarSingle_Battle_TwoTimeEnd = 10750
x502011_g_SongliaoWarSingle_Battle_ThreeTimeBegin = 10810
x502011_g_SongliaoWarSingle_Battle_ThreeTimeEnd = 11110
x502011_g_SongliaoWarSingle_Battle_FourTimeBegin = 11170
x502011_g_SongliaoWarSingle_Battle_FourTimeEnd = 11470
--战场时间设定
x502011_g_Campagin_Time ={{20,00},{21,00}} 
--个人击杀分数计算
x502011_g_SongliaoWarSingle_Buff_Score =                                                        
{                                                                                
	{  succkillnum = 1,bias=10,impactSong = 10548,impactLiao = 10559},  
	{  succkillnum = 2,bias=12,impactSong = 10549,impactLiao = 10560},  
	{  succkillnum = 3,bias=14,impactSong = 10550,impactLiao = 10561},  
	{  succkillnum = 4,bias=16,impactSong = 10551,impactLiao = 10562},  
	{  succkillnum = 5,bias=18,impactSong = 10552,impactLiao = 10563},  
	{  succkillnum = 6,bias=20,impactSong = 10553,impactLiao = 10564},  
	{  succkillnum = 7,bias=22,impactSong = 10554,impactLiao = 10565},  
	{  succkillnum = 8,bias=24,impactSong = 10555,impactLiao = 10566},  
	{  succkillnum = 9,bias=26,impactSong = 10556,impactLiao = 10567},  
	{  succkillnum = 10,bias=28,impactSong = 10557,impactLiao = 10568}, 
	{  succkillnum = 11,bias=30,impactSong = 10558,impactLiao = 10569},
}
--场内祭坛信息
x502011_g_JiTan = {
	QingLong = 1,
	BaiHu = 2,
	XuanWu = 3,
	ZhuQue = 4,
}
x502011_g_JiTanInfo = {
	[x502011_g_JiTan.QingLong] 	= {name = "青龙",pos = {282,195}},
	[x502011_g_JiTan.BaiHu] 	= {name = "白虎",pos = {105,195}},
	[x502011_g_JiTan.XuanWu] 	= {name = "玄武",pos = {194,107}},
	[x502011_g_JiTan.ZhuQue] 	= {name = "朱雀",pos = {192,283}},
}
--祭坛状态
x502011_g_JiTanState = {
	Disable = 2,		--被封印
	Activing = 3,		--即将激活
	Pking = 4,			--正在被争夺
	Over = 5,			--未被占领
	Song = x502011_g_PlayerCamp_Song,
	Liao = x502011_g_PlayerCamp_Liao,
}
x502011_g_CampName = {
	[x502011_g_PlayerCamp_Song] = "大宋",
	[x502011_g_PlayerCamp_Liao] = "大辽",
}
x502011_g_CampNameEx = {
	[x502011_g_PlayerCamp_Song] = "#{XSLDZ_180521_342}",
	[x502011_g_PlayerCamp_Liao] = "#{XSLDZ_180521_343}",
}
--产生积分的距离
x502011_g_JiTanRaids = 16	
--**********************************
--活动时间判断
--**********************************
function x502011_GetCampaginTimer(sceneId)
--	local nWeek = GetTodayWeek()
--	if nWeek ~= 1 and nWeek ~= 3 and nWeek ~= 5 then
--		return 0,0
--	end
	local nStartTime = x502011_g_Campagin_Time[1][1] *60 + x502011_g_Campagin_Time[1][2]
	local nEndTime = x502011_g_Campagin_Time[2][1] *60 + x502011_g_Campagin_Time[2][2]
	local nNowTime = floor(mod((LuaFnGetCurrentTime()+28800),86400)/60)
	local is_InTime,nOverTime = 0,0
	if  nStartTime <= nNowTime and   nEndTime >= nNowTime  then
		is_InTime = 1
		nOverTime = nEndTime - nNowTime 
	end
	return is_InTime,nOverTime
--	return 1,0
end
--**********************************
--任务入口函数
--**********************************
function x502011_OnDefaultEvent( sceneId, selfId, targetId,numText )
	--【运行调整】四象关闭
	if 1 == 1 then
		return
	end
	if numText ~= 1 then
		return
	end
	--时间不对
	local bInTime = CallScriptFunction(502011, "GetCampaginTimer", sceneId)
	if bInTime ~= 1 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180521_340}" )
		x502011_Tips( sceneId, selfId, "#{HSLJ_190919_52}" )
		return
	end
	--你的等级不足80级，请尽快达到80级后再来参与。
	if GetLevel(sceneId,selfId) < 80 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180424_02}" )
		x502011_Tips( sceneId, selfId, "#{XSLDZ_180521_215}" )
		return
	end
	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, 40002000) >= 1 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180424_04}" )
		x502011_Tips( sceneId, selfId, "#{XSLDZ_180521_148}" )
		return
	end
	--当前处于组队中
	local nHasTeam = LuaFnHasTeam(sceneId, selfId);
	if nHasTeam and nHasTeam == 1 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180521_147}" )
		x502011_Tips( sceneId, selfId, "#{XSLDZ_180521_147}" )
		return
	end
	--处于同骑
	local nHasRide_Two = LuaFnGetDRideFlag(sceneId, selfId);
	if nHasRide_Two and nHasRide_Two == 1 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_210128_31}" )
		x502011_Tips( sceneId, selfId, "#{XSLDZ_210128_30}" )
		return
	end
	--杀气缠身
	local pk_value = LuaFnGetHumanPKValue( sceneId, selfId )
	if pk_value and pk_value > 0 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180521_179}" )
		x502011_Tips( sceneId, selfId, "#{XSLDZ_180521_180}" )
		return
	end
	--处于变身状态
	if LuaFnIsModelOrMount( sceneId, selfId ) == 2 then
		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180424_05}" )
		x502011_Tips( sceneId, selfId, "#{XSLDZ_180521_149}" )
		return
	end
	--不能第二次参与
--	if GetMissionFlagEx(sceneId,selfId,MFEX_NEWSONGLIAO_ENTER) == 1 then
--		x502011_MsgBox( sceneId, selfId, targetId, "#{XSLDZ_180424_03}" )
--		return
--	end
	SetMissionFlagEx(sceneId,selfId,MFEX_NEWSONGLIAO_ENTER,1)
	--【运行调整】限制最大血量
	if LuaFnGetMaxHp(sceneId,selfId) < 150000 then
		x502011_MsgBox( sceneId, selfId, targetId, "    这战事虽急，然危险万分，少侠修为尚且不足。还请先修行一阵，待得血量达到#G150000#W以后再来寻我吧。" )
		x502011_Tips( sceneId, selfId, "血量尚未达到150000" )
		return
	end
	--去休息室了
	CallScriptFunction(400900, "TransferFunc", sceneId,selfId,SCENE_TIANMENZHEN_XIUXI,random(28,32),random(28,32))
end

--**********************************
--列举事件
--**********************************
function x502011_OnEnumerate( sceneId,selfId,targetId)
--	AddNumText(sceneId,x502011_g_ScriptId,"#{XSLDZ_180521_103}",10,1)
end

--**********************************
-- 检测副本进入条件
--**********************************
function x502011_CheckTeamLeader( sceneId, selfId )
end

--**********************************
--检测接受条件
--**********************************
function x502011_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x502011_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x502011_OnAbandon( sceneId, selfId )

end
--**********************************
--创建副本
--**********************************
function x502011_MakeCopyScene( sceneId, selfId )
	local nLeaderGuid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "songliao_dazhan.path"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, nLeaderGuid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x502011_g_NoUserTime);
	LuaFnSetCopySceneData_PvpRuler( sceneId, 3 )  -- 竞技规则
	LuaFnSetCopySceneData_Timer(sceneId, x502011_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_ID, FUBEN_NEWSONGLIAO);
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_ScriptID, 502011);
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_TickCount, x502011_g_SongliaoWarSingle_Battle_Ready);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_CloseFlag, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_LeaveTimeCount, 0);--设置离开倒计时次数
	--LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_State, x502011_g_SceneState_NULL); --当前副本的运行状态
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_Dynamic_State_1, -1)
	LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_Dynamic_State_2, -1)
	
	--设置场景中的各种Npc和区域
	LuaFnSetSceneLoad_Area( sceneId, "songliao_dazhan_area.ini" )
	LuaFnSetSceneLoad_Monster( sceneId, "songliao_dazhan_monster.ini" )
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
	if bRetSceneID >0 then
		AddText(sceneId,"副本创建成功"); --H宋辽战场副本创建成功！
	else
		AddText(sceneId,"副本创建失败");
	end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--继续
--**********************************
function x502011_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x502011_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x502011_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x502011_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x502011_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x502011_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x502011_OnCopySceneReady( sceneId, destsceneId )
	local nLeaderGuid  = LuaFnGetCopySceneData_TeamLeader(destsceneId)
	local nLeaderObjId = LuaFnGuid2ObjId(sceneId,nLeaderGuid)
	if LuaFnIsCanDoScriptLogic( sceneId, nLeaderObjId ) ~= 1 then	-- 处于无法执行逻辑的状态
		return
	end
	if nLeaderObjId == -1 then	 -- 找不到该玩家
		return
	end
	--初始化天门阵管理器
	LuaFnNewSongLiaoManagerCleanUp(destsceneId)
	--启动管理器
	LuaFnNewSongLiaoManagerRun(destsceneId)
	--对休息室内玩家进行排序
	--开始进行玩家分配
	local tHumanHP = {}
	local tHumanObjId = {}
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=1, nHumanCount  do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		tHumanObjId[i] = nHumanId  	     
		tHumanHP[i] = GetMaxHp(sceneId, nHumanId)    
		if i > x502011_g_SceneHumanMax then
			nHumanCount = i
			break
		end
	end
	--对大数进行一次排序
	for i = 1,nHumanCount do
        for j = 1,i do             
			if tHumanHP[i] > tHumanHP[j]  then
				local temp = tHumanHP[i]
				local tempID = tHumanObjId[i]
				tHumanHP[i] = tHumanHP[j]
				tHumanObjId[i] = tHumanObjId[j]
				tHumanHP[j] = temp
				tHumanObjId[j] = tempID
			end
		end
	end
	--玩家数据初始化以及位置初始化
	for i = 1,nHumanCount do
		if tHumanObjId[i] ~= nil and tHumanObjId[i] > 0 then
			if mod(i,2) == 0 then    
				--宋
				LuaFnNewSongLiaoManagerAddPlayer(sceneId,destsceneId,tHumanObjId[i],x502011_g_PlayerCamp_Song)
				CallScriptFunction( (400900), "TransferFunc", sceneId,  tHumanObjId[i], destsceneId, x502011_g_Relivepos[1][1] , x502011_g_Relivepos[1][2] )
			else  
				--辽
				LuaFnNewSongLiaoManagerAddPlayer(sceneId,destsceneId,tHumanObjId[i],x502011_g_PlayerCamp_Liao)
				CallScriptFunction( (400900), "TransferFunc", sceneId,  tHumanObjId[i], destsceneId, x502011_g_Relivepos[2][1] , x502011_g_Relivepos[2][2] )
			end
		end
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x502011_OnPlayerEnter( sceneId, selfId )
	RestoreHp( sceneId, selfId )
	RestoreMp( sceneId, selfId )
	RestoreRage( sceneId, selfId)	 
	--取得当前玩家阵营
	local bRet,nCampId = LuaFnNewSongLiaoManagerGetPlayerInfo(sceneId,selfId)
	if bRet == nil or bRet ~= 1 then
		--玩家数据异常，送回休息室
		CallScriptFunction(400900, "TransferFunc", sceneId,selfId,SCENE_TIANMENZHEN_XIUXI,random(28,32),random(28,32))
		return
	end
	--向客户端发送全量数据
	LuaFnNewSongLiaoManagerSendFullDataToClient(sceneId,selfId)
	
	if nCampId == x502011_g_PlayerCamp_Liao then	 
		--辽阵营
		SetUnitCampID(sceneId,selfId ,selfId, x502011_g_PlayerCamp_Liao)
		SetPlayerDefaultReliveInfo( sceneId, selfId, "%100", "%100", "%100",sceneId ,x502011_g_Relivepos[2][1] , x502011_g_Relivepos[2][2] )
		--npc提示
		LuaFnNpcTalkToHuman(sceneId,selfId,4)
		
	else
		--宋阵营
		SetUnitCampID(sceneId,selfId ,selfId, x502011_g_PlayerCamp_Song)
		SetPlayerDefaultReliveInfo( sceneId, selfId, "%100", "%100", "%100",sceneId ,x502011_g_Relivepos[1][1] , x502011_g_Relivepos[1][2] )
		--npc提示
		LuaFnNpcTalkToHuman(sceneId,selfId,3)
	end
	--开启pvp许可
	SetPvpAuthorizationFlagByID(sceneId, selfId, 2, 1) 
	x502011_SyncHeadImpactHuman(sceneId,selfId)
end

--**********************************
--人物死亡事件
--**********************************
function x502011_OnHumanDie(sceneId, dieId, nHumanId)
	-- 如果这个杀手是个宠物，需要现找到主人
	local nObjType = GetCharacterType(sceneId, nHumanId);
	local killerId = -1;
	if nObjType then
		if nObjType == 1 then	
			killerId = nHumanId
		elseif nObjType == 3 then
			killerId = GetPetCreator(sceneId, nHumanId);
		else
			return
		end
	end
	if killerId == -1 then
		--死的莫名其妙
		return
	end
	if IsSameMAC(sceneId,dieId,killerId) > 0 then
		--相同的MAC，是小号，不记录
		--return
	end
	if killerId == dieId then
		--自杀不算
		return
	end
	if GetUnitCampID(sceneId, killerId, killerId)  == GetUnitCampID(sceneId, dieId, dieId) then
		--同一个阵营就不能行
		return
	end
	--己方夺得对方一半的旗帜，对方旗帜变为1
	local bKRet,nKCampId,_,_,nCurKillSuccKill = LuaFnNewSongLiaoManagerGetPlayerInfo(sceneId,killerId)
	if bKRet ~= 1 then
		return
	end
	local bDRet,nDCampId,_,_,nCurDieSuccKill = LuaFnNewSongLiaoManagerGetPlayerInfo(sceneId,dieId)
	if bKRet ~= 1 then
		return
	end
	if nKCampId == nDCampId then
		return
	end
	--单次最少夺取1面
	nCurDieSuccKill = floor(nCurDieSuccKill/2);
	if nCurDieSuccKill <= 0 then
		nCurDieSuccKill = 1
	end
	--单次最多夺取6面
	if nCurDieSuccKill > 6 then
		nCurDieSuccKill = 6
	end
	nCurKillSuccKill = nCurKillSuccKill + nCurDieSuccKill
	if nCurKillSuccKill >= 255 then
		nCurKillSuccKill = 255;
		x502011_Tips( sceneId, killerId,"#{XSLDZ_180521_333}" )
	end
	LuaFnNewSongLiaoManagerSetPlayerSuccKill(sceneId,dieId,1)
	LuaFnNewSongLiaoManagerSetPlayerSuccKill(sceneId,killerId,nCurKillSuccKill)
	--增加击杀数量
	LuaFnNewSongLiaoManagerPlayerAddKill(sceneId,killerId)
	--高击杀通报
	local nKillerCamp = GetUnitCampID(sceneId,killerId,killerId)
	if nCurKillSuccKill >= x502011_g_SongliaoWarSingle_Buff_Score[getn(x502011_g_SongliaoWarSingle_Buff_Score)].succkillnum then
		MonsterTalk(sceneId, -1, "四象天门阵",ScriptGlobal_Format("#{XSLDZ_180521_311}",
				x502011_g_CampName[nKillerCamp],GetName(sceneId,killerId),tostring(nCurKillSuccKill)))
	end
end

--**********************************
--副本场景定时器事件
--此处1S回调一次
--**********************************
function x502011_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟递增
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, x502011_g_SceneData_TickCount )
	LuaFnSetCopySceneData_Param(sceneId,x502011_g_SceneData_TickCount,TickCount + 1)
	--更新管理器内的tick
	LuaFnNewSongLiaoManagerTick(sceneId,TickCount)
	
	if TickCount >= x502011_g_SongliaoWarSingle_Battle_Start then
		--开始即更新全部数据
		if TickCount > x502011_g_SongliaoWarSingle_Battle_Start then
			LuaFnNewSongLiaoManagerSyncFullData(sceneId)
		end
	end
	if TickCount == x502011_g_SongliaoWarSingle_Battle_Ready then
		--建立宋辽出口阻挡
		x502011_CreateDynamicBlock( sceneId , 1 )
		x502011_CreateDynamicBlock( sceneId , 2 )
	end
	local nCopySceneFlag = LuaFnGetCopySceneData_Param( sceneId, x502011_g_SceneData_CloseFlag )
	if nCopySceneFlag == 1 then --副本关闭，宋辽大战结束
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, x502011_g_SceneData_LeaveTimeCount)
		if leaveTickCount == x502011_g_CloseTick then --倒计时间到，大家都出去吧
			x502011_GoAwayAllPeople(sceneId)
		elseif leaveTickCount < x502011_g_CloseTick then
			if leaveTickCount == 0 then
--				BroadMsgByChatPipe(sceneId,-1,"#{XSLDZ_180521_328}",13)
			end
			if mod(leaveTickCount,10) == 0 then
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_327}", tostring((x502011_g_CloseTick-leaveTickCount)*x502011_g_TickTime )))
			end
		end
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_LeaveTimeCount, leaveTickCount) ;
	else
		--更新副本内各玩家的IMPACT显示
		if mod(TickCount,3) == 0 then
			x502011_SyncHeadImpact(sceneId)
		end
		--副本正常运转
		if TickCount == x502011_g_SongliaoWarSingle_Battle_Ready then
			x502011_TipAllHuman( sceneId, "#{XSLDZ_180521_181}" )
			return
		end
		--倒计时提示
		if TickCount > x502011_g_SongliaoWarSingle_Battle_Ready and TickCount <= x502011_g_SongliaoWarSingle_Battle_Start - 10000 then
			if mod(TickCount,10) == 0 then
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_182}",x502011_g_SongliaoWarSingle_Battle_Start - 10000 - TickCount) )
			end
			--最后阶段的倒计时
			if TickCount >= x502011_g_SongliaoWarSingle_Battle_Start - 10000 - 5 then
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_182}",x502011_g_SongliaoWarSingle_Battle_Start - 10000 - TickCount) )
			end
			--倒计时UI
			if TickCount == x502011_g_SongliaoWarSingle_Battle_Start - 10000 - 3 then
				LuaFnNewSongLiaoManagerSyncFullData(sceneId)
			end
			--青龙祭坛开始倒计时
			if TickCount == x502011_g_SongliaoWarSingle_Battle_Start - 10000 then
				LuaFnSetCopySceneData_Param(sceneId,x502011_g_SceneData_TickCount,x502011_g_SongliaoWarSingle_Battle_Start)
				--取消宋辽出口阻挡
				x502011_ReleaseDynamicRegion( sceneId , 1 )
				x502011_ReleaseDynamicRegion( sceneId , 2 )
			
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_318}",x502011_g_JiTanInfo[1].name))
				x502011_DoNpcTalk(sceneId,"#{XSLDZ_180521_300}")
				--设置祭坛状态
				LuaFnNewSongLiaoSetJiTanState(sceneId,x502011_g_JiTan.QingLong - 1,x502011_g_JiTanState.Activing)
			end
		end
		--青龙祭坛倒计时30s
		if TickCount == x502011_g_SongliaoWarSingle_Battle_OneTimeBegin - 30 then
			x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180424_45}",x502011_g_JiTanInfo[1].name))
		end
		--青龙祭坛活跃期
		if TickCount >= x502011_g_SongliaoWarSingle_Battle_OneTimeBegin and TickCount <= x502011_g_SongliaoWarSingle_Battle_OneTimeEnd then
			--祭坛解封
			if TickCount == x502011_g_SongliaoWarSingle_Battle_OneTimeBegin then
				x502011_OnJiTanOpen(sceneId,x502011_g_JiTan.QingLong)
				return
			end
			--周围的玩家结算
			if mod(TickCount,5) == 0 then
				x502011_RefreshPlayerRankScore(sceneId,x502011_g_JiTan.QingLong)
			end
			if TickCount == x502011_g_SongliaoWarSingle_Battle_OneTimeEnd - 120 then
				x502011_OnJiTanNearEnd(sceneId,1,x502011_g_JiTan.QingLong)
			elseif TickCount == x502011_g_SongliaoWarSingle_Battle_OneTimeEnd - 60 then
				x502011_OnJiTanNearEnd(sceneId,2,x502011_g_JiTan.QingLong)
			end
			--结算当前祭坛
			if TickCount == x502011_g_SongliaoWarSingle_Battle_OneTimeEnd then
				--结算
				x502011_OnJiTanEnd(sceneId,x502011_g_JiTan.QingLong)
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_318}",x502011_g_JiTanInfo[x502011_g_JiTan.BaiHu].name))
				--设置祭坛状态
				LuaFnNewSongLiaoSetJiTanState(sceneId,x502011_g_JiTan.BaiHu - 1,x502011_g_JiTanState.Activing)
			end
		end
		--白虎祭坛活跃期
		if TickCount >= x502011_g_SongliaoWarSingle_Battle_TwoTimeBegin and TickCount <= x502011_g_SongliaoWarSingle_Battle_TwoTimeEnd then
			--祭坛解封
			if TickCount == x502011_g_SongliaoWarSingle_Battle_TwoTimeBegin then
				x502011_OnJiTanOpen(sceneId,x502011_g_JiTan.BaiHu)
				return
			end
			--周围的玩家结算
			if mod(TickCount,5) == 0 then
				x502011_RefreshPlayerRankScore(sceneId,x502011_g_JiTan.BaiHu)
			end
			if TickCount == x502011_g_SongliaoWarSingle_Battle_TwoTimeEnd - 120 then
				x502011_OnJiTanNearEnd(sceneId,1,x502011_g_JiTan.BaiHu)
			elseif TickCount == x502011_g_SongliaoWarSingle_Battle_TwoTimeEnd - 60 then
				x502011_OnJiTanNearEnd(sceneId,2,x502011_g_JiTan.BaiHu)
			end
			--结算当前祭坛
			if TickCount == x502011_g_SongliaoWarSingle_Battle_TwoTimeEnd then
				--结算
				x502011_OnJiTanEnd(sceneId,x502011_g_JiTan.BaiHu)
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_318}",x502011_g_JiTanInfo[x502011_g_JiTan.XuanWu].name))
				--设置祭坛状态
				LuaFnNewSongLiaoSetJiTanState(sceneId,x502011_g_JiTan.XuanWu - 1,x502011_g_JiTanState.Activing)
			end
		end
		--玄武祭坛活跃期
		if TickCount >= x502011_g_SongliaoWarSingle_Battle_ThreeTimeBegin and TickCount <= x502011_g_SongliaoWarSingle_Battle_ThreeTimeEnd then
			--祭坛解封
			if TickCount == x502011_g_SongliaoWarSingle_Battle_ThreeTimeBegin then
				x502011_OnJiTanOpen(sceneId,x502011_g_JiTan.XuanWu)
				return
			end
			--周围的玩家结算
			if mod(TickCount,5) == 0 then
				x502011_RefreshPlayerRankScore(sceneId,x502011_g_JiTan.XuanWu)
			end
			if TickCount == x502011_g_SongliaoWarSingle_Battle_ThreeTimeEnd - 120 then
				x502011_OnJiTanNearEnd(sceneId,1,x502011_g_JiTan.XuanWu)
			elseif TickCount == x502011_g_SongliaoWarSingle_Battle_ThreeTimeEnd - 60 then
				x502011_OnJiTanNearEnd(sceneId,2,x502011_g_JiTan.XuanWu)
			end
			--结算当前祭坛
			if TickCount == x502011_g_SongliaoWarSingle_Battle_ThreeTimeEnd then
				--结算
				x502011_OnJiTanEnd(sceneId,x502011_g_JiTan.XuanWu)
				x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_318}",x502011_g_JiTanInfo[x502011_g_JiTan.ZhuQue].name))
				--设置祭坛状态
				LuaFnNewSongLiaoSetJiTanState(sceneId,x502011_g_JiTan.ZhuQue - 1,x502011_g_JiTanState.Activing)
			end
		end
		--朱雀祭坛
		if TickCount >= x502011_g_SongliaoWarSingle_Battle_FourTimeBegin and TickCount <= x502011_g_SongliaoWarSingle_Battle_FourTimeEnd then
			--祭坛解封
			if TickCount == x502011_g_SongliaoWarSingle_Battle_FourTimeBegin then
				x502011_OnJiTanOpen(sceneId,x502011_g_JiTan.ZhuQue)
				return
			end
			--周围的玩家结算
			if mod(TickCount,5) == 0 then
				x502011_RefreshPlayerRankScore(sceneId,x502011_g_JiTan.ZhuQue)
			end
			if TickCount == x502011_g_SongliaoWarSingle_Battle_FourTimeEnd - 120 then
				x502011_OnJiTanNearEnd(sceneId,1,x502011_g_JiTan.ZhuQue)
			elseif TickCount == x502011_g_SongliaoWarSingle_Battle_FourTimeEnd - 60 then
				x502011_OnJiTanNearEnd(sceneId,2,x502011_g_JiTan.ZhuQue)
			end
			--结算当前祭坛
			if TickCount == x502011_g_SongliaoWarSingle_Battle_FourTimeEnd then
				--结算
				x502011_OnJiTanEnd(sceneId,x502011_g_JiTan.ZhuQue)
			end
		end
		--最终结算
		if TickCount == x502011_g_SongliaoWarSingle_Battle_FourTimeEnd + 5 then
			x502011_OnFinalCompute(sceneId)
		end
		
	end
end
--*********************************
--最终结算
--*********************************
function x502011_OnFinalCompute(sceneId)
	--标记副本结束
	LuaFnSetCopySceneData_Param( sceneId, x502011_g_SceneData_CloseFlag,1 )
	--平局，双方判负
	local nNumOfS = 0
	local nNumOfL = 0
	for i = 1,4 do
		local nStateWinner =  LuaFnNewSongLiaoGetJiTanState(sceneId,i - 1)
		if nStateWinner == x502011_g_PlayerCamp_Song then
			nNumOfS  = nNumOfS + 1
		end
		if nStateWinner == x502011_g_PlayerCamp_Liao then
			nNumOfL  = nNumOfL + 1
		end
	end
	
	local nWiner = 0
	if nNumOfL == nNumOfS then
		x502011_TipAllHuman( sceneId, "#{XSLDZ_180521_324}")
		LuaFnNewSongLiaoMonsterTalk(sceneId, -1, "四象天门阵","#{XSLDZ_180521_326}")
	else
		if nNumOfL > nNumOfS then
			--辽胜
			nWiner = x502011_g_PlayerCamp_Liao
		else
			--宋胜
			nWiner = x502011_g_PlayerCamp_Song
		end
		if x502011_g_CampName[nWiner] ~= nil then
			--XSLDZ_180521_323	此战%s0所占祭坛居多，已赢得本场胜利。	
			x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180521_323}",x502011_g_CampName[nWiner]))
			LuaFnNewSongLiaoMonsterTalk(sceneId, -1, "四象天门阵",ScriptGlobal_Format("#{XSLDZ_180521_325}",x502011_g_CampNameEx[nWiner]))
		end
	end
	
	--双方玩家数据排序
	LuaFnNewSongLiaoSortPlayer(sceneId)
	--遍历在场所有玩家
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=1, nHumanCount do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			local nIndex,nCampId,nScore = LuaFnNewSongLiaoManagerGetSortPlayerInfo(sceneId,nHumanId)
			--设定PVP状态
			SetPvpAuthorizationFlagByID(sceneId,nHumanId, 2, 0)
			--重新设定阵营
			SetUnitCampID(sceneId,nHumanId,nHumanId, -1) 
			--标记参与了一次兵行四象
			CallScriptFunction(891093, "OnFinish",sceneId, nHumanId)
			--周活跃及其他
			LuaFnFinishZhouHuoYueMission(sceneId,nHumanId,26)
			--发可执行邮件
			--nIndex为0就默认30名
			if nIndex == 0 then
				nIndex = 30
			end
--			MDEX_NEWSONGLIAO_CURCAMP = 144				--新宋辽 本次参与的阵营
--			MDEX_NEWSONGLIAO_CURSTATE = 145				--新宋辽 本次阵营情况
--			MDEX_NEWSONGLIAO_CURINDEX = 146				--新宋辽 本次排名
			SetMissionDataEx(sceneId,nHumanId,MDEX_NEWSONGLIAO_CURCAMP,nCampId)
			SetMissionDataEx(sceneId,nHumanId,MDEX_NEWSONGLIAO_CURSTATE,nWiner)
			SetMissionDataEx(sceneId,nHumanId,MDEX_NEWSONGLIAO_CURINDEX,nIndex)
--			LuaFnSendScriptMail( sceneId, GetName(sceneId,nHumanId), MAIL_BINGXINGSIXIANG, nCampId, nWiner, nIndex)
			--邮件提示
			x502011_SendSystemMail(sceneId,nHumanId)
			--客户端结束UI开启
			BeginUICommand( sceneId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, nHumanId, 502011 )
		end
	end
end
--*********************************
--根据奖励内容发送邮件
--*********************************
function x502011_SendSystemMail(sceneId,selfId)
	local nCampID = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURCAMP)
	local nWiner = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURSTATE)
	local nIndex = GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURINDEX)
	--nWiner:	0:平局 156：宋胜 157：辽胜
	--nCampID:	自己的阵营
	--nIndex:	排名1-30
	local m_nIndex,m_SongBonusItemID,m_SongBonusItemNum,m_SongBonusProNum,
		m_LiaoBonusItemID,m_LiaoBonusItemNum,m_LiaoonusProNum,
		m_BonusItemID1,m_BonusItemNum1,m_BonusProNum1,
		m_BonusItemID2,m_BonusItemNum2,m_BonusProNum2,
		m_RYValue,m_RYVictoryValue,m_LossRYRankValue,m_RYLossValue = LuaFnGetSongLiaoBonusInfo(nIndex)
	if m_nIndex == nil then
		return
	end
	--计算四象荣誉
	local nRYFinal = m_RYValue;
	if nWiner == nCampID then
		nRYFinal = nRYFinal + m_RYVictoryValue
	elseif nWiner == 0 then
		nRYFinal = nRYFinal + m_LossRYRankValue
	else
		nRYFinal = nRYFinal + m_RYLossValue
	end
	--平局
	local strMail = ""
	if nWiner == 0 then
		--第一名
		if nIndex == 1 then
			if nCampID == x502011_g_PlayerCamp_Song then
				strMail = ScriptGlobal_Format("#{XSLDZ_180521_270}",GetName(sceneId,selfId),tostring(nRYFinal))
			else
				strMail = ScriptGlobal_Format("#{XSLDZ_180521_332}",GetName(sceneId,selfId),tostring(nRYFinal))
			end
		else
			strMail = ScriptGlobal_Format("#{XSLDZ_180521_271}",GetName(sceneId,selfId),x502011_g_CampNameEx[nCampID],tostring(nIndex),tostring(nRYFinal))
		end
	--本方获胜
	elseif nWiner == nCampID then
		--第一名
		if nIndex == 1 then
			if nCampID == x502011_g_PlayerCamp_Song then
				strMail = ScriptGlobal_Format("#{XSLDZ_180521_283}",GetName(sceneId,selfId),tostring(nRYFinal))
			else
				strMail = ScriptGlobal_Format("#{XSLDZ_180521_330}",GetName(sceneId,selfId),tostring(nRYFinal))
			end
		else
			strMail = ScriptGlobal_Format("#{XSLDZ_180521_284}",GetName(sceneId,selfId),x502011_g_CampNameEx[nCampID],tostring(nIndex),tostring(nRYFinal))
		end
	else
	--本方失败
		if nIndex == 1 then
			if nCampID == x502011_g_PlayerCamp_Song then
				strMail = ScriptGlobal_Format("#{XSLDZ_180521_285}",GetName(sceneId,selfId),tostring(nRYFinal))
			else
				strMail = ScriptGlobal_Format("#{XSLDZ_180521_331}",GetName(sceneId,selfId),tostring(nRYFinal))
			end
		else
			strMail = ScriptGlobal_Format("#{XSLDZ_180521_288}",GetName(sceneId,selfId),x502011_g_CampNameEx[nCampID],tostring(nIndex),tostring(nRYFinal))
		end
	end
	LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), strMail )
end
--*********************************
--刷新每位玩家的个人积分
--*********************************
function x502011_RefreshPlayerRankScore(sceneId,nIndex)
	if x502011_g_JiTanInfo[nIndex] == nil then
		return
	end
	local nPosX = x502011_g_JiTanInfo[nIndex].pos[1];
	local nPosZ = x502011_g_JiTanInfo[nIndex].pos[2];

	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=1, nHumanCount do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			local PlayerX = GetHumanWorldX(sceneId,nHumanId)
			local PlayerZ = GetHumanWorldZ(sceneId,nHumanId)
			local nDistance = floor(sqrt((nPosX-PlayerX)*(nPosX-PlayerX)+(nPosZ-PlayerZ)*(nPosZ-PlayerZ)))
			
			if nDistance <= x502011_g_JiTanRaids then
				local bRet,nCampId,nScore,nKillNum,nSuccKillNum = LuaFnNewSongLiaoManagerGetPlayerInfo(sceneId,nHumanId)
				if bRet == 1 then
					local nCanGetScore = x502011_GetScore( nSuccKillNum)
					if nCanGetScore > 0 then
						LuaFnNewSongLiaoManagerPlayerAddScore(sceneId,nHumanId,nCanGetScore)
						--XSLDZ_180521_312	#H您为本方夺取%s0点%s1之力。	
						x502011_Tips( sceneId, nHumanId, ScriptGlobal_Format("#{XSLDZ_180521_312}",tostring(nCanGetScore),x502011_g_JiTanInfo[nIndex].name) )
					end
				end
			end
		end
	end
end
--*********************************
--祭坛争夺结束，计算归属
--不计算最终归属
--*********************************
function x502011_OnJiTanEnd(sceneId,nIndex)
	if x502011_g_JiTanInfo[nIndex] == nil then
		return
	end
	local songScore,liaoScore = LuaFnNewSongLiaoGetCampScore(sceneId)
	local nResult = x502011_g_JiTanState.Over	--默认平局
	if songScore > liaoScore then
		nResult = x502011_g_PlayerCamp_Song
	end
	if songScore < liaoScore then
		nResult = x502011_g_PlayerCamp_Liao
	end
	--设置祭坛状态
	LuaFnNewSongLiaoSetJiTanState(sceneId,nIndex - 1,nResult)
	
	if nResult ~= x502011_g_JiTanState.Over then
		x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180424_47}",x502011_g_JiTanInfo[nIndex].name,x502011_g_CampName[nResult]))
		LuaFnNewSongLiaoMonsterTalk(sceneId, -1, "四象天门阵",ScriptGlobal_Format("#{XSLDZ_180521_316}",
			x502011_g_CampName[nResult],
			x502011_g_JiTanInfo[nIndex].name,
			x502011_g_JiTanInfo[nIndex].name,
			x502011_g_CampName[nResult]))
	else
		--平分秋色
		x502011_TipAllHuman( sceneId, "#{XSLDZ_180521_310}")
		LuaFnNewSongLiaoMonsterTalk(sceneId, -1, "四象天门阵",ScriptGlobal_Format("#{XSLDZ_180521_317}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex].name))
	end
	--双方比分清空
	LuaFnNewSongLiaoResetCampScore(sceneId)
	--如果全争夺完就不再显示
	if nIndex >= 4 then
		return
	end
	--发送NPC的图贴
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=1, nHumanCount do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			local nCampID = GetUnitCampID(sceneId,nHumanId,nHumanId)
			if nResult == x502011_g_JiTanState.Over then
				if nCampID == x502011_g_PlayerCamp_Song then
					LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_257}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex + 1].name))
				else
					LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_257}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex + 1].name))
				end
			end
			if nResult == nCampID then
				if nCampID == x502011_g_PlayerCamp_Song then
					LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_255}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex + 1].name))
				else
					LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_255}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex + 1].name))
				end
			else
				if nCampID == x502011_g_PlayerCamp_Song then
					LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_256}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex + 1].name))
				else
					LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_256}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex + 1].name))
				end
			end
			
		end
	end
	
end
--*********************************
--祭坛争夺开始
--*********************************
function x502011_OnJiTanOpen(sceneId,nIndex)
	if x502011_g_JiTanInfo[nIndex].name == nil then
		return
	end
	--设置祭坛状态
	LuaFnNewSongLiaoSetJiTanState(sceneId,nIndex - 1,x502011_g_JiTanState.Pking)
	
	--XSLDZ_180424_46	#H%s0祭坛已解除封印。	
	x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180424_46}",x502011_g_JiTanInfo[nIndex].name))
	--XSLDZ_180521_314	#G%s0#P祭坛已#G解除封印#P，处于祭坛周围即可获得#G%s1之力#P。#G5分钟#P后，获得#G%s2之力#P多的一方，将会占领此祭坛。	
	LuaFnNewSongLiaoMonsterTalk(sceneId, -1, "四象天门阵",
		ScriptGlobal_Format("#{XSLDZ_180521_314}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex].name)
	)
	--XSLDZ_180521_315	#W%s0祭坛封印已除，还请诸位全力掠获%s1之力。待到祭坛重封之时，若我方所获多于敌军，便可将其收入囊中。	
	x502011_DoNpcTalk(sceneId,ScriptGlobal_Format("#{XSLDZ_180521_315}",x502011_g_JiTanInfo[nIndex].name,x502011_g_JiTanInfo[nIndex].name))
end
--*********************************
--祭坛争夺即将结束
--全场玩家提醒
--*********************************
function x502011_OnJiTanNearEnd(sceneId,nType,nIndex)
	--nType 1:剩2分 2:剩1分
	if x502011_g_JiTanInfo[nIndex].name == nil then
		return
	end
	local songScore,liaoScore = LuaFnNewSongLiaoGetCampScore(sceneId)
	local nResult = 0
	if songScore > liaoScore then
		nResult = x502011_g_PlayerCamp_Song
	end
	if songScore < liaoScore then
		nResult = x502011_g_PlayerCamp_Liao
	end
	
	--发送NPC的图贴
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=1, nHumanCount do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			local nCampID = GetUnitCampID(sceneId,nHumanId,nHumanId)
			if nResult == 0 then
				if nCampID == x502011_g_PlayerCamp_Song then
					if nType == 1 then
						LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_260}",x502011_g_JiTanInfo[nIndex].name))
					else
						LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_263}",x502011_g_JiTanInfo[nIndex].name))
					end
				else
					if nType == 1 then
						LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_260}",x502011_g_JiTanInfo[nIndex].name))
					else
						LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_263}",x502011_g_JiTanInfo[nIndex].name))
					end
				end
			end
			if nResult == nCampID then
				if nCampID == x502011_g_PlayerCamp_Song then
					if nType == 1 then
						LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_259}",x502011_g_JiTanInfo[nIndex].name))
					else
						LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_262}",x502011_g_JiTanInfo[nIndex].name))
					end
				else
					if nType == 1 then
						LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_259}",x502011_g_JiTanInfo[nIndex].name))
					else
						LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_262}",x502011_g_JiTanInfo[nIndex].name))
					end
				end
			else
				if nCampID == x502011_g_PlayerCamp_Song then
					if nType == 1 then
						LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_258}",x502011_g_JiTanInfo[nIndex].name))
					else
						LuaFnNpcTalkToHuman(sceneId,nHumanId,11,ScriptGlobal_Format("#{XSLDZ_180521_261}",x502011_g_JiTanInfo[nIndex].name))
					end
				else
					if nType == 1 then
						LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_258}",x502011_g_JiTanInfo[nIndex].name))
					else
						LuaFnNpcTalkToHuman(sceneId,nHumanId,12,ScriptGlobal_Format("#{XSLDZ_180521_261}",x502011_g_JiTanInfo[nIndex].name))
					end
				end
			end
			
		end
	end
end
--**********************************
-- 按阵营发送场景内的Npctalk
--**********************************
function x502011_DoNpcTalk(sceneId,strTips)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i = 1,nHumanCount do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			local nTempCampID = GetUnitCampID(sceneId, nHumanId,nHumanId)
			if nTempCampID == x502011_g_PlayerCamp_Liao then	
				LuaFnNpcTalkToHuman(sceneId,nHumanId,2,strTips)
			else
				LuaFnNpcTalkToHuman(sceneId,nHumanId,1,strTips)
			end
		end
	end
end
--**********************************
--玩家主动退出
--**********************************
function x502011_OnHumanAskLeave( sceneId, selfId )
	x502011_TipAllHuman( sceneId, ScriptGlobal_Format("#{XSLDZ_180424_44}",GetName(sceneId,selfId)) )
	CallScriptFunction( (400900), "TransferFunc",sceneId, selfId,SCENE_SUZHOU,random(192,194),random(143,145))
end
--**********************************
--客户端请求离开战场
--**********************************
function x502011_Transfer( sceneId, selfId )
	--这里是完成后才允许调用的
	local nCopySceneFlag = LuaFnGetCopySceneData_Param( sceneId, x502011_g_SceneData_CloseFlag )
	if nCopySceneFlag ~= 1 then
		return
	end
	CallScriptFunction( (400900), "TransferFunc",sceneId, selfId,SCENE_SUZHOU,random(192,194),random(143,145))
end
--**********************************
--怪物死亡
--**********************************
function x502011_OnDie(sceneId,selfId,killerId)
	
end

--**********************************
--动阻创建
--**********************************
function x502011_CreateDynamicBlock( sceneId , index )
	local item = x502011_g_DyInitState[index]
	if item == nil then
		return 0
	end
	local DyNpcid = LuaFnGetCopySceneData_Param(sceneId, x502011_g_SceneData_Dynamic_State_1 + index - 1)
	if DyNpcid == -1 then
		DyNpcid = CreateMonsterWithDir(sceneId, item.npcid, item.posx, item.posy, 3, -1, -1, item.dir)
		if DyNpcid == nil or DyNpcid < 0 then
			local recordMsg = format("CreateDynamicBlocks npc ERROR sceneid=%d", sceneId)
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SONGLIAONEW, -1,recordMsg)
			return 0
		else
			local DyRetId = LuaFnAddDynamicRegionByObject(sceneId, DyNpcid, item.dataid)
			if DyRetId == -1 then
				local recordMsg = format("CreateDynamicBlocks region ERROR sceneid=%d", sceneId )
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SONGLIAONEW, -1,recordMsg)
				return 0
			else
				LuaFnSetNpcIntParameter(sceneId, DyNpcid, 0, DyRetId)
				local recordMsg = format("CreateDynamicBlocks sceneid=%d, regionindex=%d, DyRetId=%d", sceneId, index, DyRetId)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SONGLIAONEW, -1, recordMsg)
			end
		end
		LuaFnSetCopySceneData_Param(sceneId, x502011_g_SceneData_Dynamic_State_1 + index - 1, DyNpcid)
	else
		local recordMsg = format("Has Been Create ERROR sceneid=%d", sceneId )
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SONGLIAONEW, -1,recordMsg)
	end
	return 0
end
--**********************************
--动阻区域销毁
--**********************************
function x502011_ReleaseDynamicRegion( sceneId,index)
	if index < 1 or index > getn(x502011_g_DyInitState) then
		local recordMsg = format("ReleaseDynamicRegion sceneid=%d, index=%d", sceneId, index)
		ScriptGlobal_AuditGeneralLog( LUAAUDIT_FUBEN_SONGLIAONEW, -1, recordMsg )
		return 0
	end
	local npcid = -1
	if index >= 1  and index <= getn(x502011_g_DyInitState) then
		npcid = LuaFnGetCopySceneData_Param(sceneId, index + x502011_g_SceneData_Dynamic_State_1 - 1)
	end
	local ret = 0
	if npcid >= 0 then
		local DyregionID = LuaFnGetNpcIntParameter(sceneId, npcid, 0)
		if DyregionID ~= -1 then
			ret = LuaFnReleaseDynamicRegion(sceneId, DyregionID)
			if ret == 1 then
				LuaFnSetNpcIntParameter(sceneId, npcid, 0, -1)
				--清理动阻的怪物数据
				SetCharacterDieTime(sceneId,npcid,100)
				LuaFnSetCopySceneData_Param(sceneId, index + x502011_g_SceneData_Dynamic_State_1 - 1,-1)
				
				local teamID = LuaFnGetCopySceneData_Param( sceneId, 6)
				local recordMsg = format("ReleaseDynamicRegion sceneid=%d, regionindex=%d, teamID=%d", sceneId, index, teamID)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SONGLIAONEW, -1, recordMsg)
			else
				local recordMsg = format("ReleaseDynamicRegion open err sceneid=%d, regionindex=%d", sceneId, index)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SONGLIAONEW, -1, recordMsg)
			end
		end
	end
	return 0
end
--*********************************
--更新玩家impact效果显示
--*********************************
function x502011_SyncHeadImpact(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 then
			x502011_SyncHeadImpactHuman(sceneId,nHumanId)
		end
    end
end
--*********************************
--更新玩家impact效果显示
--*********************************
function x502011_SyncHeadImpactHuman(sceneId,selfId)
	local bRet,nCampId,nScore,nKillNum,nSuccKillNum = LuaFnNewSongLiaoManagerGetPlayerInfo(sceneId,selfId)
	if bRet ~= nil and bRet == 1 then
		local nIndex = 1
		for i = 1,getn(x502011_g_SongliaoWarSingle_Buff_Score) do
			if nSuccKillNum  >= x502011_g_SongliaoWarSingle_Buff_Score[i].succkillnum then
				nIndex = i
			end
		end
		local nImpact = -1
		if nCampId == x502011_g_PlayerCamp_Liao then
			nImpact = x502011_g_SongliaoWarSingle_Buff_Score[nIndex].impactLiao
		elseif nCampId == x502011_g_PlayerCamp_Song then
			nImpact = x502011_g_SongliaoWarSingle_Buff_Score[nIndex].impactSong	
		end
		if nImpact == -1 then
			return
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,nImpact) ~= 1 then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, nImpact, 0);
		end
	end
end
--*********************************
--副本人员清空
--*********************************
function x502011_GoAwayAllPeople(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 then
			SetPvpAuthorizationFlagByID(sceneId,nHumanId, 2, 0)--设定PVP状态
			SetUnitCampID(sceneId,nHumanId,nHumanId, -1) --重新设定阵营
			CallScriptFunction( (400900), "TransferFunc",sceneId, nHumanId,SCENE_SUZHOU,random(192,194),random(143,145))
		end
    end
end
--**********************************
--全屏提示
--**********************************
function x502011_NotifyTips(sceneId,tip)
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	for	i = 0,membercount - 1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId,tip);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,nHumanId)
		end
	end
end
--**********************************
--计算击杀后得到的分数
--**********************************
function x502011_GetScore( playerSucc)
	if playerSucc == nil then
		return 0
	end
	local nIndex = 1
	for i = 1,getn(x502011_g_SongliaoWarSingle_Buff_Score) do
		if playerSucc  >= x502011_g_SongliaoWarSingle_Buff_Score[i].succkillnum then
			nIndex = i
		end
	end

	return 1 * x502011_g_SongliaoWarSingle_Buff_Score[nIndex].bias
end

--**********************************
--提示所有副本内玩家
--**********************************
function x502011_TipAllHuman( sceneId, Str )
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanNum <= 0 then
		return
	end
	for i=0, nHumanNum-1  do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, nHumanId)
		end
	end
end
--**********************************
-- 玩家个人全屏提示
--**********************************
function x502011_Tips(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x502011_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end