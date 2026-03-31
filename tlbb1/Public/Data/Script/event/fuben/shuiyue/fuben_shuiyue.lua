--水月山庄
x891070_g_ScriptId 	= 891070
x891070_g_CopySceneType=FUBEN_SHUIYUESHANZHAUNG	--副本类型，定义在ScriptGlobal.lua里面
x891070_g_LimitMembers = 1			--可以进副本的最小队伍人数
x891070_g_Challenge_count = 2		--每日可以挑战的次数
x891070_g_minLevel = 80				--进入副本的最低等级
x891070_g_TickTime = 1				--回调脚本的时钟时间（单位：秒/次）
x891070_g_LimitTotalHoldTime=1800	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x891070_g_CloseTick=300				--副本关闭前倒计时（单位：次数）
x891070_g_NoUserTime=10				--副本中没有人后可以继续保存的时间（单位：秒）
x891070_g_DeadTrans=0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x891070_g_Fuben_X=103				--进入副本的位置X
x891070_g_Fuben_Z=217				--进入副本的位置Z
x891070_g_Back_X=133				--源场景位置X
x891070_g_Back_Z=107				--源场景位置Z
x891070_g_KillDogNum=10				--击杀伪装家丁的数量
x891070_g_KillHuweiNum=6			--击杀护卫数据
--8-17为动阻状态数据
x891070_g_CopySceneData_Param_KillHuWei = 19		--击杀的护卫
x891070_g_CopySceneData_Param_PetYing = 20			--驯兽师-鹰
x891070_g_CopySceneData_Param_PetLang = 21			--驯兽师-狼
x891070_g_CopySceneData_Param_PetYingAndLang = 22	--驯兽师-鹰狼合体
x891070_g_CopySceneData_Param_KillJiaDing = 23		--击杀的家丁数量

--动态阻挡相关
x891070_DyInitState =
{
	--山庄大门
	[1]  = {dataid = 4, posx = 125, posy = 149, npcid = 49015, dir = 0},
	--山庄右侧阻挡 NPCID未确定
	[2]  = {dataid = 1, posx = 149, posy = 125, npcid = 49014, dir = 1.57},
	--山庄阿莺入口阻挡	NPCID未确定
	[3]  = {dataid = 5, posx = 158, posy = 65, npcid = 49016, dir = 1.57},
	--山庄阿莺出口阻挡	NPCID未确定
	[4]  = {dataid = 3, posx = 133, posy = 55, npcid = 49017, dir = 3.93},
	--山庄阿莺出口南阻挡 NPCID未确定
	[5]  = {dataid = 2, posx = 143, posy = 79, npcid = 49017, dir = 3.14},
	--十三入口
	[6]  = {dataid = 2, posx = 115, posy = 197, npcid = 49019, dir = 2.6},
	--十三出口
	[7]  = {dataid = 3, posx = 124, posy = 161, npcid = 49018, dir = 0},
	--耶律泓佑出口阻挡
	[8]  = {dataid = 3, posx = 50, posy = 65, npcid = 49017, dir = 1.57},
	--耶律泓佑入口阻挡
	[9]  = {dataid = 3, posx = 85, posy = 52, npcid = 49017, dir = 5.5},
	--最底下的出口
	[10]  = {dataid = 5, posx = 106, posy = 213, npcid = 49019, dir = 2.6},
}
--Boss数据
x891070_CreateBossTable = 
{
	["QiDanLiShi_NPC"] = {id = 48503, posx = 125,posz = 170,baseai = 3,scriptai = -1,scriptid = 891071, dir = 0},
	["QiDanLiShi_Boss"] = {id = 48504, posx = 125,posz = 170,baseai = 21,scriptai = -1,scriptid = 891076, dir = 0},
	
	["Cike_NPC"] = {id = 48509, posx = 125,posz = 125,baseai = 3,scriptai = -1,scriptid = 891072, dir = 0},
	["Cike_Boss"] = {id = 48510, posx = 125,posz = 125,baseai = 21,scriptai = -1,scriptid = 891077, dir = 0},
	
	["XunShouShi_NPC"] = {id = 48516, posx = 143,posz = 66,baseai = 3,scriptai = -1,scriptid = 891073, dir = 0},
	["XunShouShi_Boss"] = {id = 48517, posx = 143,posz = 66,baseai = 21,scriptai = -1,scriptid = 891079, dir = 0},
	
	["QiDanWuShi_NPC"] = {id = 48520, posx = 71,posz = 66,baseai = 3,scriptai = -1,scriptid = 891074, dir = 0},
	["QiDanWuShi_Boss"] = {id = 48521, posx = 71,posz = 66,baseai = 21,scriptai = -1,scriptid = 891066, dir = 0},
	--笼子1
	["LongZi_1"] = {id = 48524, posx = 181 ,posz = 95,baseai = 3,scriptai = -1,scriptid = -1, dir = 33},
	--笼子2
	["LongZi_2"] = {id = 48525, posx = 181 ,posz = 87,baseai = 3,scriptai = -1,scriptid = -1, dir = 33},
	--护卫长
	["HuWeiZhang"] = {id = 48507, posx = 193 ,posz = 92,baseai = 21,scriptai = -1,scriptid = 891069, dir = 11},
}
--初始化十个小兵的坐标数据
x891070_CreateDogPosTable = 
{
	{114,179},{121,182},{128,182},{117,173},{119,176},
	{122,176},{125,176},{125,178},{128,176},{128,173}
}
x891070_CreateHuWeiPosTable = 
{
	{188,105},{181,100},{194,100},{201,93},{186,90}
}
--**********************************
--任务入口函数
--**********************************
function x891070_OnDefaultEvent( sceneId, selfId, targetId )
	local nNumText = GetNumText()
	if nNumText == 1 then
		x891070_MsgBox(sceneId,selfId,targetId,"#{SYSZ_20210308_02}")
	elseif nNumText == 2 then
		x891070_MsgBox(sceneId,selfId,targetId,"#{FBSD_150126_04}")
	elseif nNumText == 1000 then
		--判断进入副本条件
		if 1 ~= x891070_CheckTeamLeader( sceneId, selfId ) then
			return
		end
		local nearmembercount = GetNearTeamCount(sceneId,selfId)
		x891070_MakeCopyScene(sceneId,selfId,nearmembercount)
	end
end

--**********************************
--列举事件
--**********************************
function x891070_OnEnumerate( sceneId,selfId,targetId)
	if IsHaveMission(sceneId,selfId,2005) > 0 or IsMissionHaveDone(sceneId,selfId,2005) > 0 then
		AddNumText(sceneId,x891070_g_ScriptId,"#{SYSZ_20210203_03}",10,1000)
	end
	AddNumText(sceneId,x891070_g_ScriptId,"#{SYSZ_20210308_01}",11,1)
	AddNumText(sceneId,x891070_g_ScriptId,"#{FBSD_150126_03}",11,2)
end

--**********************************
-- 检测副本进入条件
--**********************************
function x891070_CheckTeamLeader( sceneId, selfId )
	local strText = "#{SYSZ_20210203_16}"
	local Isok = 0
	local nearteammembercount = GetNearTeamCount( sceneId, selfId) 
	if GetTeamId(sceneId,selfId) < 0 then	--判断是否有队伍
		x891070_MsgBox(sceneId,selfId,-1,"#{SYSZ_20210203_04}")
		x891070_PlayerTips(sceneId,selfId,"#{SYSZ_20210203_05}")
		return 0
	end
	if LuaFnIsTeamLeader(sceneId,selfId) == 0 then	--只有队长才能操作。
		x891070_MsgBox(sceneId,selfId,-1,"#{SYSZ_20210203_06}")
		x891070_PlayerTips(sceneId,selfId,"#{SYSZ_20210203_07}")
		return 0
	end
	if GetLevel(sceneId,selfId) < x891070_g_minLevel then	--等级不够。
		x891070_MsgBox(sceneId,selfId,-1,"#{SYSZ_20210203_08}")
		x891070_PlayerTips(sceneId,selfId,"#{SYSZ_20210203_09}")
		return 0
	end
	if GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHUIYUE) >= x891070_g_Challenge_count then
		x891070_MsgBox(sceneId,selfId,-1,"#{SYSZ_20210203_10}")
		x891070_PlayerTips(sceneId,selfId,"#{SYSZ_20210203_11}")
		return 0
	end
	if nearteammembercount < x891070_g_LimitMembers then
		x891070_MsgBox(sceneId,selfId,-1,"#{SYSZ_20210203_12}")
		x891070_PlayerTips(sceneId,selfId,"#{SYSZ_20210203_13}")
		return 0
	end
	--附近有队员没来。
	if GetTeamSize(sceneId,selfId) ~= nearteammembercount then
		x891070_MsgBox(sceneId,selfId,-1,"#{SYSZ_20210203_14}")
		x891070_PlayerTips(sceneId,selfId,"#{SYSZ_20210203_15}")
		return 0
	end
	--是否满足进入条件
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 and LuaFnIsCharacterLiving(sceneId,TeamPlayerID) == 1 then
			if GetLevel(sceneId,TeamPlayerID) < x891070_g_minLevel and GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHUIYUE) >= x891070_g_Challenge_count then
				strText = strText.."#r"..GetName(sceneId,TeamPlayerID).."#{SYSZ_20210203_18}".."#{SYSZ_20210203_20}"
				Isok = 0
			else
				strText = strText.."#r"..GetName(sceneId,TeamPlayerID).."#{SYSZ_20210203_17}".."#{SYSZ_20210203_19}"
				Isok = 1
			end
		end
	end
	x891070_MsgBox(sceneId,selfId,-1,strText)
	return Isok
end

--**********************************
--检测接受条件
--**********************************
function x891070_CheckAccept( sceneId, selfId )
	
end

--**********************************
--接受
--**********************************
function x891070_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x891070_OnAbandon( sceneId, selfId )

end
--**********************************
--创建副本
--**********************************
function x891070_MakeCopyScene( sceneId, selfId, nearmembercount )
	--指数参数
	local	param0	= 4;
	local	param1	= 3;

	--最终结果
	local nHumanLevel	= 0;

	--临时变量
	local mems		= {};
	local	tempMemlevel = 0;
	local	level0 = 0;
	local	level1 = 0;
	for	i = 0, nearmembercount - 1 do
		mems[i]	= GetNearTeamMember(sceneId, selfId, i);
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			tempMemlevel = GetLevel(sceneId, mems[i]);
			level0	= level0 + (tempMemlevel ^ param0);
			level1	= level1 + (tempMemlevel ^ param1);
		end
	end

	if level1 == 0 then
		nHumanLevel = 80;
	else
		nHumanLevel = level0/level1;
	end

    nHumanLevel = floor(nHumanLevel/10) * 10
	if nHumanLevel < 80 then
		nHumanLevel = 80;
	elseif nHumanLevel > 120 then
		nHumanLevel = 120
    end

	local leaderguid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "shuiyueshanzhuang.path"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x891070_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x891070_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x891070_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x891070_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;--杀死Boss的数量
	--动阻信息
	for index, item in x891070_DyInitState do --占10个 8-17
		LuaFnSetCopySceneData_Param( sceneId, 7 + index, 0 )
	end
	--击杀的家丁数量
	LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_KillJiaDing, 0) ;
	--击杀的护卫
	LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_KillHuWei, 0) ;
	--驯兽师的鹰和狼处理
	LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetYing, -1) ;
	LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetLang, -1) ;
	LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetYingAndLang, -1) ;
	
	local x,z = GetWorldPos( sceneId, selfId )		
	LuaFnSetCopySceneData_PvpRuler( sceneId, 9 )
    LuaFnSetSceneLoad_Monster( sceneId, "shuiyueshanzhuang_monster.ini" )
	LuaFnSetCopySceneData_Param(sceneId, CopyScene_LevelGap, nHumanLevel) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	-- BeginEvent(sceneId)
	-- if bRetSceneID>0 then
		-- AddText(sceneId,"#{FHGC_090706_33}");
	-- else
		-- AddText(sceneId,"#{FHGC_090706_34}");
	-- end
	-- EndEvent(sceneId)
	-- DispatchMissionTips(sceneId,selfId)
end
--**********************************
--继续
--**********************************
function x891070_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x891070_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x891070_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891070_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x891070_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891070_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x891070_OnCopySceneReady( sceneId, destsceneId )
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	--取得玩家附近的队友数量（包括自己）
	local nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
	local mems = {}
	for	i=0,nearteammembercount-1 do
		mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			NewWorld( sceneId, mems[i], destsceneId, x891070_g_Fuben_X, x891070_g_Fuben_Z);
		end
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x891070_OnPlayerEnter( sceneId, selfId )
	local lastDayCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHUIYUE)
	if lastDayCount >= x891070_g_Challenge_count then
		NewWorld(sceneId,selfId,1,x891070_g_Back_X,x891070_g_Back_Z)
		return
	end
	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo(sceneId,selfId,"%50","%50","%10",sceneId, x891070_g_Fuben_X,x891070_g_Fuben_Z);
	AddCampaignCountNum(sceneId,selfId,CAMPAIGN_SHUIYUE)
	if IsHaveMission(sceneId,selfId,2005) > 0 then
		local misIndex = GetMissionIndexByID(sceneId, selfId, 2005)
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	end
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x891070_OnHumanDie( sceneId, selfId, killerId )
end

--**********************************
--副本场景定时器事件
--**********************************
function x891070_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟读取及设置
	local oldsceneId = LuaFnGetCopySceneData_Param(sceneId,3);--取得副本入口场景号
	local TickCount = LuaFnGetCopySceneData_Param(sceneId,2) ;--取得已经执行的定时次数
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId, CopyScene_LevelGap) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId,4);
	TickCount = TickCount + 1;
	LuaFnSetCopySceneData_Param(sceneId,2,TickCount)
	if TickCount == 5 then
		--发送全屏提示和NpcTalk
		x891070_NotifyTips(sceneId,"#{SYSZ_20210203_70}")
		x891070_NotifyTips(sceneId,"#{SYSZ_20210203_71}")
		LuaFnNpcTalk(sceneId,105) --进入副本的第一个talkID
		--创建第一批怪物
		x891070_CreateMonsterData(sceneId,"Dog_Monster")
		--创建大门动阻，以及楼梯动阻
		x891070_CreateDynamicBlock(sceneId,1)
		x891070_CreateDynamicBlock(sceneId,7)
	end
	if leaveFlag == 1 then --需要离开
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId,5);
		leaveTickCount = leaveTickCount + 1;
		LuaFnSetCopySceneData_Param(sceneId,5,leaveTickCount);
		if leaveTickCount == x891070_g_CloseTick then --倒计时间到，大家都出去吧
			--将当前副本场景里的所有人传送回原来进入时候的场景
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
					NewWorld( sceneId, mems[i], oldsceneId, x891070_g_Back_X, x891070_g_Back_Z )
				end
			end
		end
	elseif TickCount == x891070_g_LimitTotalHoldTime then --副本总时间限制到了
		--此处设置副本任务有时间限制的情况，当时间到后处理...
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId, mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then
				NewWorld( sceneId, mems[i], oldsceneId, x891070_g_Back_X, x891070_g_Back_Z )
			end
		end
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId,4,1);
	end
end
--**********************************
--怪物死亡
--**********************************
function x891070_OnDie(sceneId,selfId,killerId)
	--这里用名字做死亡数据记录，方便分辨
	local szName = GetName(sceneId,selfId)
	if szName == "伪装的家丁" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_KillJiaDing);
		if nCurKill < 0 then
			nCurKill = 0
		end
		nCurKill = nCurKill + 1
		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_KillJiaDing, nCurKill) ;
		--获取当前剩余家丁的数量
		--这里多做一次检测，防止后续机制执行出错
		local nMonsterNum = 0
		for i = 0, GetMonsterCount(sceneId) - 1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			if GetName(sceneId,MonsterId) == "伪装的家丁" then
				nMonsterNum = nMonsterNum + 1
			end
		end
		if nCurKill ~= x891070_g_KillDogNum - nMonsterNum then
			if nMonsterNum == 0 then
				nCurKill = x891070_g_KillDogNum
			end
		end
		if nCurKill >= x891070_g_KillDogNum then
			x891070_CreateMonsterData(sceneId,"QiDanLiShi_NPC")
			x891070_NotifyTips(sceneId,"#{SYSZ_20210203_73}")
		else
			x891070_NotifyTips(sceneId,ScriptGlobal_Format("#{SYSZ_20210203_72}",nCurKill,x891070_g_KillDogNum))
		end
	end
	if szName == "十三" then
		--全屏提示
		x891070_NotifyTips(sceneId,"#{SYSZ_20210203_75}")
		--发送npctalk
		LuaFnNpcTalk(sceneId,107)
		x891070_ReleaseDynamicRegion(sceneId,1)
		x891070_ReleaseDynamicRegion(sceneId,6)
		x891070_ReleaseDynamicRegion(sceneId,7)
		x891070_ReleaseDynamicRegion(sceneId,10)
		x891070_CreateMonsterData(sceneId,"Cike_NPC")
	elseif szName == "梵无救" then
		--全屏提示
		x891070_NotifyTips(sceneId,"#{SYSZ_20210203_78}")
		--发送npctalk
		LuaFnNpcTalk(sceneId,109)
		--销毁动阻，打开大门
		x891070_ReleaseDynamicRegion(sceneId,2)
		x891070_ReleaseDynamicRegion(sceneId,6)
		x891070_ReleaseDynamicRegion(sceneId,7)
		x891070_ReleaseDynamicRegion(sceneId,10)
		--创建关押人员、牢笼、护卫
		x891070_CreateImprisoned_personnel(sceneId)
		x891070_CreateMonsterData(sceneId,"LongZi_1")
		x891070_CreateMonsterData(sceneId,"LongZi_2")
		x891070_CreateMonsterData(sceneId,"HuWei")
		x891070_CreateMonsterData(sceneId,"HuWeiZhang")
		--检查梵修、梵体在不在，在的话直接清理掉
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum - 1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			if GetName(sceneId,MonsterId) == "梵体" or GetName(sceneId,MonsterId) == "梵修" then
				LuaFnDeleteMonster(sceneId,MonsterId)
			end
		end	
	elseif szName == "护卫长" or szName == "护卫" then
		local KillHuWeiNum = LuaFnGetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_KillHuWei) ;--击杀护卫数据
		KillHuWeiNum = KillHuWeiNum + 1
		LuaFnSetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_KillHuWei,KillHuWeiNum)
		--全屏提示
		x891070_NotifyTips(sceneId,ScriptGlobal_Format("#{SYSZ_20210203_91}",KillHuWeiNum,x891070_g_KillHuweiNum))
		if KillHuWeiNum >= x891070_g_KillHuweiNum then
			--全屏提示
			x891070_NotifyTips(sceneId,"#{SYSZ_20210203_79}")
			--发送npctalk 诸位少侠，沿此路上山，有一名女子把守
			LuaFnNpcTalk(sceneId,110)
			--创建阿莺
			x891070_CreateMonsterData(sceneId,"XunShouShi_NPC")
			KillHuWeiNum = x891070_g_KillHuweiNum
			--销毁阿莺处的动阻
			x891070_ReleaseDynamicRegion(sceneId,3)
		end
	elseif szName == "阿莺" then
		--全屏提示
		x891070_NotifyTips(sceneId,"#{SYSZ_20210203_82}")
		--发送npctalk
		LuaFnNpcTalk(sceneId,112)
		--销毁效果npc
		local nEffectObjId = LuaFnGetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_PetYingAndLang)
		if nEffectObjId ~= -1 then
			LuaFnDeleteMonster(sceneId,nEffectObjId)
			LuaFnSetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_PetYingAndLang,-1)
		end
		--鹰和狼逃跑
		x891070_CreateXunShouShiPetEscape(sceneId)
		--销毁动阻
		for i = 2,7 do
			x891070_ReleaseDynamicRegion(sceneId,i)
		end
		x891070_ReleaseDynamicRegion(sceneId,9)
		x891070_ReleaseDynamicRegion(sceneId,10)
		--创建耶律
		x891070_CreateMonsterData(sceneId,"QiDanWuShi_NPC")
	elseif szName == "耶律泓佑" then
		--全屏提示
		x891070_NotifyTips(sceneId,"#{SYSZ_20210203_85}")
		--发送npctalk
		LuaFnNpcTalk(sceneId,114)
		--销毁动阻
		for i = 2,10 do
			x891070_ReleaseDynamicRegion(sceneId,i)
		end
		--活跃数据
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		for	i=0,membercount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
				LuaFnFinishZhouHuoYueMission(sceneId,nHumanId,16)
				--扫荡点处理
				CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, nHumanId,CAMPAIGN_SHUIYUE)
				--云侠赴战
				CallScriptFunction(890289,"OnFinish",sceneId, nHumanId,CAMPAIGN_SHUIYUE)
			end
		end
		--副本关闭数据
		LuaFnSetCopySceneData_Param(sceneId,4,1) --副本关闭标志
		--高光时刻结算
		LuaFnShowCopySceneHigntlight(sceneId,35);
		
	elseif szName == "鬼影" then
		local nPlayerID = LuaFnGetNpcIntParameter(sceneId,selfId,0)
		if nPlayerID > 0 then
			if LuaFnIsObjValid(sceneId,nPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nPlayerID) == 1 and LuaFnIsCharacterLiving(sceneId,nPlayerID) == 1 then
				--清理鬼影所覆盖的玩家数据
				LuaFnCancelSpecificImpact(sceneId,nPlayerID,10518)
				LuaFnCancelSpecificImpact(sceneId,nPlayerID,10519)
				--选中玩家的记录要清除，因为已经死了
				LuaFnSetNpcIntParameter(sceneId,selfId,0,0)
			end
		end
	end
end
--**********************************
--测试
--**********************************
function x891070_ToTest( sceneId )
	--全屏提示
	x891070_NotifyTips(sceneId,"#{SYSZ_20210203_82}")
	--发送npctalk
	LuaFnNpcTalk(sceneId,112)
	--销毁效果npc
	local nEffectObjId = LuaFnGetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_PetYingAndLang)
	if nEffectObjId ~= -1 then
		LuaFnDeleteMonster(sceneId,nEffectObjId)
		LuaFnSetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_PetYingAndLang,-1)
	end
	--鹰和狼逃跑
	x891070_CreateXunShouShiPetEscape(sceneId)
	--销毁动阻
	for i = 1,7 do
		x891070_ReleaseDynamicRegion(sceneId,i)
	end
	x891070_ReleaseDynamicRegion(sceneId,9)
	x891070_ReleaseDynamicRegion(sceneId,10)
	--创建耶律
	x891070_CreateMonsterData(sceneId,"QiDanWuShi_NPC")
	
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i = 0,membercount - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			SetPos(sceneId,mems[i],71,66)
		end
	end
end
--**********************************
--动阻创建
--**********************************
function x891070_CreateDynamicBlock( sceneId , index )
	local item = x891070_DyInitState[index]
	if item == nil then
		return 0
	end
	local DyNpcid = LuaFnGetCopySceneData_Param(sceneId, 7 + index)
	--大门动态阻挡特写，其余逻辑不变
	if index == 1 then
		if DyNpcid == 0 then
			DyNpcid = CreateMonsterWithDir(sceneId, item.npcid, item.posx, item.posy, 3, -1, -1, item.dir)
			if DyNpcid == nil or DyNpcid < 0 then
				local recordMsg = format("CreateDynamicBlocks npc ERROR sceneid=%d", sceneId)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1,recordMsg)
				return 0
			else
				--大门ID
				LuaFnSetCopySceneData_Param(sceneId, 8, DyNpcid)
				
				local DyRetId = LuaFnAddDynamicRegionByObject(sceneId, DyNpcid, item.dataid)
				if DyRetId == -1 then
					local recordMsg = format("CreateDynamicBlocks region ERROR sceneid=%d", sceneId )
					ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1,recordMsg)
					return 0
				else
					LuaFnSetNpcIntParameter(sceneId, DyNpcid, 0, DyRetId)
				end
			end
		else
			local DyregionID = LuaFnGetNpcIntParameter(sceneId, DyNpcid, 0)
			if DyregionID == 0 then
				--创建大门动阻
				local DyRetId = LuaFnAddDynamicRegionByObject(sceneId, DyNpcid, item.dataid)
				if DyRetId == -1 then
					return 0
				else
					LuaFnSetNpcIntParameter(sceneId, DyNpcid, 0, DyRetId)
					--关闭大门
					LuaFnMonsterDoSpecialAction(sceneId,DyNpcid,1004,1005,1005)
				end
			end
		end
	end
	--非大门的动态阻挡
	if index > 1 then
		if DyNpcid == 0 then
			DyNpcid = CreateMonsterWithDir(sceneId, item.npcid, item.posx, item.posy, 3, -1, -1, item.dir)
			if DyNpcid == nil or DyNpcid < 0 then
				local recordMsg = format("CreateDynamicBlocks npc ERROR sceneid=%d", sceneId)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1,recordMsg)
				return 0
			else
				local DyRetId = LuaFnAddDynamicRegionByObject(sceneId, DyNpcid, item.dataid)
				if DyRetId == -1 then
					local recordMsg = format("CreateDynamicBlocks region ERROR sceneid=%d", sceneId )
					ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1,recordMsg)
					return 0
				else
					LuaFnSetNpcIntParameter(sceneId, DyNpcid, 0, DyRetId)
				end
			end
			if index > 1 and index <= getn(x891070_DyInitState) then
				LuaFnSetCopySceneData_Param(sceneId, 7 + index, DyNpcid)
			end
		else
			local recordMsg = format("Has Been Create ERROR sceneid=%d", sceneId )
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1,recordMsg)
		end
	end
	return 0
end
--**********************************
--动阻区域销毁
--**********************************
function x891070_ReleaseDynamicRegion( sceneId,index)
	if index < 1 or index > getn(x891070_DyInitState) then
		local recordMsg = format("ReleaseDynamicRegion sceneid=%d, index=%d", sceneId, index)
		ScriptGlobal_AuditGeneralLog( LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg )
		return 0
	end
	local npcid = -1
	if index >= 1  and index <= getn(x891070_DyInitState) then
		npcid = LuaFnGetCopySceneData_Param(sceneId, index + 7)
	end
	local ret = 0
	if index == 1 then
		--大门有特写不删除怪物外观
		if npcid >= 0 then
			local DyregionID = LuaFnGetNpcIntParameter(sceneId, npcid, 0)
			if DyregionID ~= -1 then
				ret = LuaFnReleaseDynamicRegion(sceneId, DyregionID)
				if ret == 1 then
					LuaFnSetNpcIntParameter(sceneId, npcid, 0, -1)
					--敞开大门
					LuaFnMonsterDoSpecialAction(sceneId,npcid,1003,1002,1002)
				end
			end
		end
	end
	if index > 1 then
		if npcid >= 0 then
			local DyregionID = LuaFnGetNpcIntParameter(sceneId, npcid, 0)
			if DyregionID ~= -1 then
				ret = LuaFnReleaseDynamicRegion(sceneId, DyregionID)
				if ret == 1 then
					LuaFnSetNpcIntParameter(sceneId, npcid, 0, -1)
					--清理动阻的怪物数据
					LuaFnDeleteMonster(sceneId,npcid)
					if index > 1 and index <= getn(x891070_DyInitState) then
						LuaFnSetCopySceneData_Param(sceneId, index + 7,0)
					end
--					local actionid
--					local keepid
--					local closeid
--					if index == 1 then
--						closeid = x891070_g_CloseAction_1
--						keepid =x891070_g_KeepAction_1
--						actionid = x891070_g_OpenAction_1
--					elseif index == 2 then
--						closeid = x891070_g_CloseAction_2
--						keepid =x891070_g_KeepAction_2
--						actionid = x891070_g_OpenAction_2
--					end
					local teamID = LuaFnGetCopySceneData_Param( sceneId, 6)
					local recordMsg = format("CreateDynamicBlocks Release sceneid=%d, regionindex=%d, teamID=%d", sceneId, index, teamID)
					ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg)
				else
					local recordMsg = format("ReleaseDynamicRegion open err sceneid=%d, regionindex=%d", sceneId, index)
					ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg)
				end
			end
		end
	end
	return 0
end
--**********************************
--通用怪物创建
--**********************************
function x891070_CreateMonsterData(sceneId,nDataID)
	if not nDataID or nDataID == "" then
		return
	end
	--小怪特写，必须要返回，要不下面的数据会读到这里
	if nDataID == "Dog_Monster" then
		for i = 1,10 do
			CreateMonsterWithDir(sceneId, 48506, x891070_CreateDogPosTable[i][1], x891070_CreateDogPosTable[i][2], 21, -1, x891070_g_ScriptId, 0)
		end
	end
	if nDataID == "HuWei" then
		for i = 1,5 do
			CreateMonsterWithDir(sceneId, 48508, x891070_CreateHuWeiPosTable[i][1], x891070_CreateHuWeiPosTable[i][2], 21, -1, x891070_g_ScriptId,11)
		end
	end
	local monster = x891070_CreateBossTable[nDataID]
	if monster == nil or not monster then
		return
	end
	--其余怪物数据正常创建
	CreateMonsterWithDir(sceneId, monster.id, monster.posx, monster.posz, monster.baseai, monster.scriptai, monster.scriptid, monster.dir)
end
--**********************************
--创建被关押的山庄人员
--**********************************
function x891070_CreateImprisoned_personnel(sceneId)
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
--**********************************
-- 创建单独的鹰和狼
--**********************************
function x891070_CreateXunShouShiPetStart(sceneId)
	--49246	小白 140 64 pat0
	--49247	小黑 142 63 pat1
	local nMonsterLangId = CreateMonsterWithDir(sceneId,49246,140,64,3,-1,891063,8.75)
	if nMonsterLangId ~= -1 then
		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetLang, nMonsterLangId) ;
		MonsterTalk(sceneId,nMonsterLangId,"水月山庄","#{SYSZ_20210326_02}")
	else
		local recordMsg = format("x891070_CreateXunShouShiPetStart sceneid=%d, nMonsterLangId=%d", sceneId, nMonsterLangId)
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg)
	end
	local nMonsterYingId = CreateMonsterWithDir(sceneId,49247,142,63,3,-1,891064,8.75)
	if nMonsterYingId ~= -1 then
		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetYing, nMonsterYingId) ;
		MonsterTalk(sceneId,nMonsterYingId,"水月山庄","#{SYSZ_20210326_05}")
	else
		local recordMsg = format("x891070_CreateXunShouShiPetStart sceneid=%d, nMonsterYingId=%d", sceneId, nMonsterYingId)
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg)
	end
	--设置巡逻路径
	SetPatrolId(sceneId, nMonsterLangId, 0)
	SetPatrolId(sceneId, nMonsterYingId, 1)
end
--**********************************
-- 创建动作展示的鹰狼合体
--**********************************
function x891070_CreateXunShouPet(sceneId)
	--这里可能会被调用两次，所以要检测一下
	local nMonsterLangId = LuaFnGetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_PetLang)
	local nMonsterYingId = LuaFnGetCopySceneData_Param(sceneId,x891070_g_CopySceneData_Param_PetYing)
	if nMonsterLangId ~= -1 and nMonsterYingId ~= -1 then
	
--		LuaFnDeleteMonster(sceneId,nMonsterLangId)
--		LuaFnDeleteMonster(sceneId,nMonsterYingId)
		
		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetLang, -1) ;
		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetYing, -1) ;
		--49248	小白 小黑 132 55
		local nEffNpcObjId = CreateMonsterWithDir(sceneId,49248,133,55,3,-1,-1,0.785)
		if nEffNpcObjId ~= -1 then
			LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetYingAndLang, nEffNpcObjId) ;
		end
	end
end
--**********************************
-- 创建单独的鹰和狼逃跑
--**********************************
function x891070_CreateXunShouShiPetEscape(sceneId)
	local nMonsterLangId = CreateMonsterWithDir(sceneId,49246,132,56,3,-1,891063,8.75)
	if nMonsterLangId == -1 then
		local recordMsg = format("x891070_CreateXunShouShiPetEscape sceneid=%d, nMonsterLangId=%d", sceneId, nMonsterLangId)
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg)
	else
--		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetLang, nMonsterLangId) ;
	end
	local nMonsterYingId = CreateMonsterWithDir(sceneId,49247,133,54,3,-1,891064,8.75)
	if nMonsterYingId == -1 then
		local recordMsg = format("x891070_CreateXunShouShiPetEscape sceneid=%d, nMonsterYingId=%d", sceneId, nMonsterYingId)
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_SHUIYUE, -1, recordMsg)
	else
--		LuaFnSetCopySceneData_Param(sceneId, x891070_g_CopySceneData_Param_PetYing, nMonsterYingId) ;
	end
	--发送泡泡
	MonsterTalk(sceneId,nMonsterLangId,"水月山庄","#{SYSZ_20210326_04}")
	MonsterTalk(sceneId,nMonsterYingId,"水月山庄","#{SYSZ_20210326_06}")
	--设置巡逻路径
	SetPatrolId(sceneId, nMonsterLangId, 6)
	SetPatrolId(sceneId, nMonsterYingId, 7)
end

--**********************************
--全屏提示
--**********************************
function x891070_NotifyTips(sceneId,Str)
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	
	BeginEvent(sceneId)
	AddText(sceneId, Str)
	EndEvent(sceneId)
	
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			DispatchMissionTips(sceneId, PlayerId)
		end
	end
end
--**********************************
-- 获取本副本的MonsterID
--**********************************
function x891070_GetFubenMonsterDataId(sceneId,selfId,nIndex)
	if nIndex == 1 then
		return x891070_CreateBossTable["QiDanLiShi_Boss"].id,1
	elseif nIndex == 2 then
		return x891070_CreateBossTable["Cike_Boss"].id,1
	elseif nIndex == 3 then
		return x891070_CreateBossTable["XunShouShi_Boss"].id,1
	elseif nIndex == 4 then
		return x891070_CreateBossTable["QiDanWuShi_Boss"].id,1
	end
end
--**********************************
-- 获取本副本的Monster的初始位置
--**********************************
function x891070_GetFubenMonsterPos(sceneId,nIndex)
	if nIndex == 1 then
		return x891070_CreateBossTable["QiDanLiShi_Boss"].posx,x891070_CreateBossTable["QiDanLiShi_Boss"].posz
	elseif nIndex == 2 then
		return x891070_CreateBossTable["Cike_Boss"].posx,x891070_CreateBossTable["Cike_Boss"].posz
	elseif nIndex == 3 then
		return x891070_CreateBossTable["XunShouShi_Boss"].posx,x891070_CreateBossTable["XunShouShi_Boss"].posz
	elseif nIndex == 4 then
		return x891070_CreateBossTable["QiDanWuShi_Boss"].posx,x891070_CreateBossTable["QiDanWuShi_Boss"].posz
	end
end
--**********************************
-- 玩家个人全屏提示
--**********************************
function x891070_PlayerTips(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x891070_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
