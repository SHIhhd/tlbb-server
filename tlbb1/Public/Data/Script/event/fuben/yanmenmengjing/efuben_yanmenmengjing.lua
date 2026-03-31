--雁关·无间度厄
--难度：普通

--脚本号
x998445_g_ScriptId = 998445
--副本名称
x998445_g_CopySceneName = "雁关·无间度厄"
x998445_g_CopySceneType = FUBEN_YANMEN			--副本类型，定义在ScriptGlobal.lua里面
x998445_g_LimitLevel = 65						--限制等级

x998445_g_LimitMembers = 2						--可以进副本的最小团队人数
x998445_g_LimitMembersMax = 12					--可以进入副本的最大团队人数
x998445_g_TickTime = 1							--回调脚本的时钟时间（单位：秒/次）
x998445_g_LimitTotalHoldTime = 90 * 60			--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败 90分钟
x998445_g_CloseTick = 15						--副本关闭前倒计时（单位：次数）
x998445_g_NoUserTime = 60						--副本中没有人后可以继续保存的时间（单位：秒）
x998445_g_Fuben_X = 141							--进入副本的位置X
x998445_g_Fuben_Z = 219							--进入副本的位置Z
x998445_g_Back_X = 96							--源场景位置X
x998445_g_Back_Z = 99							--源场景位置Z
x998445_g_Back_SceneId = SCENE_YANMEN_BREAKROOM				--源场景Id

x998445_g_SceneData_TickCount = 2			--设置定时器调用次数
x998445_g_CopySceneData_Nightmare = 8		--当前梦魇值
x998445_g_CopySceneData_NightmareTick = 9	--当前梦魇的计时器
x998445_g_CopySceneData_NightmareMax = 10	--当前梦魇的最大值
x998445_g_CopySceneData_Level = 11			--副本的等级
x998445_g_CopySceneData_InitLevel = 12		--副本创建等级
x998445_g_CopySceneData_MituKillNum = 13	--迷途侠士被击杀数量
x998445_g_CopySceneData_XiaoDuKillNum = 14	--消 度范例击杀数量
x998445_g_CopySceneData_YeeKillNum = 15	--业 厄范例击杀数量
x998445_g_CopySceneData_SpecialBoss = 16	--分组boss击杀情况
x998445_g_CopySceneData_Complete = 17		--副本是否已完成
x998445_g_CopySceneData_LeaveTimeCount = 18	--离开倒计时存储
x998445_g_CopySceneData_Dynamic_State_1 = 19	--动阻状态
x998445_g_CopySceneData_Dynamic_State_2 = 20	--动阻状态
x998445_g_CopySceneData_Dynamic_State_3 = 21	--动阻状态
x998445_g_CopySceneData_Dynamic_State_4 = 22	--动阻状态
x998445_g_CopySceneData_Dynamic_State_5 = 23	--动阻状态
x998445_g_CopySceneData_Dynamic_State_6 = 24	--动阻状态
x998445_g_CopySceneData_Dynamic_State_7 = 25	--动阻状态
x998445_g_CopySceneData_Dynamic_State_8 = 26	--动阻状态
x998445_g_CopySceneData_Dynamic_State_9 = 27	--动阻状态
--动态阻挡相关
x998445_g_DyInitState =
{
	--赵钱孙入口
	[1]  = {dataid = 6, posx = 76, posz = 198, npcid = 51565, dir = 1.571},
	--赵钱孙出口
	[2]  = {dataid = 6, posx = 39, posz = 167, npcid = 51565, dir = 0},
	--汪剑通入口
	[3]  = {dataid = 6, posx = 65, posz = 115, npcid = 51695, dir = 0},
	--汪剑通出口
	[4]  = {dataid = 6, posx = 99, posz = 110, npcid = 51695, dir = 4.363},
	--带头大哥入口
	[5]  = {dataid = 6, posx = 132, posz = 134, npcid = 51695, dir = 5.933},
	--带头大哥出口
	[6]  = {dataid = 6, posx = 148, posz = 169, npcid = 51565, dir = 1.571},
	--玄慈入口
	[7]  = {dataid = 6, posx = 161, posz = 127, npcid = 51565, dir = 3.665},
	--玄慈出口
	[8]  = {dataid = 6, posx = 208, posz = 122, npcid = 51565, dir = 2.094},
	--萧峰入口
	[9]  = {dataid = 6, posx = 197, posz = 61, npcid = 51565, dir = 1.571},
}
--梦魇机制配置信息
x998445_g_InitNightmare = 800
x998445_g_MaxNightmare = 1000
--迷途侠士
x998445_g_MituxiashiMonster = 
{
	tPos = {
		{94,201},{98,203},{101,203},{106,203},{115,203},{120,204},{121,204},{120,205},
		{93,203},{97,205},{101,207},{108,206},{115,205},{118,206},{120,208},
	},
	tDataId = {51369,51369,51369,51369,51369,51369,51370,51371,51372,51373,51374},
}
x998445_g_MengYanMonster = 
{
	tXiaoDataId = {51375,51375,51375,51375,51375,51375,51376,51377,51378,51379,51380},
	tDuDataId = {51381,51381,51381,51381,51381,51381,51382,51383,51384,51385,51386},
	tYeDataId = {51387,51387,51387,51387,51387,51387,51388,51389,51390,51391,51392},
	tEDataId = {51393,51393,51393,51393,51393,51393,51394,51395,51396,51397,51398},
}
--BOSS赵钱孙
x998445_g_BossZhaoQianSun = 
{
	tPos = {52,197},
	nNpcDataId = 51331,
	tDataId = {51353,51353,51353,51353,51353,51354,51355,51356,51357,51358,51359},
	nNpcScript = 998447,
	nMonsterAi = 998448,
}
--汪剑通
x998445_g_BossWangJianTong = 
{
	tPos = {69,88},
	nNpcDataId = 51332,
	tDataId = {51400,51400,51400,51400,51400,51400,51402,51403,51404,51405,51406},
	nNpcScript = 998451,
	nMonsterAi = 998452,
}
--带头大哥
x998445_g_BossDaiTouDaGe = 
{
	tPos = {127,153},
	nNpcDataId = 51333,
	tDataId = {51416,51416,51416,51416,51416,51416,51417,51418,51419,51420,51421},
	nNpcScript = 998455,
	nMonsterAi = 998456,
}
--玄慈
x998445_g_BossXuanCi = 
{
	tPos = {194,141},
	nNpcDataId = 51409,
	tDataId = {51410,51410,51410,51410,51410,51410,51411,51412,51413,51414,51415},
	nNpcScript = 998453,
	nMonsterAi = 998454,
}
--萧峰
x998445_g_BossXiaoFeng = 
{
	tPos = {160,56},
	nNpcDataId = 51334,
	tDataId = {51442,51442,51442,51442,51442,51442,51443,51444,51445,51446,51447},
	nNpcScript = 998461,
	nMonsterAi = 998462,
}

--**********************************
--任务入口函数
--**********************************
function x998445_OnDefaultEvent( sceneId, selfId, targetId )
	if GetNumText() == 1  then
		BeginEvent(sceneId)
			AddText(sceneId,"#{YMMJ_230626_5}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--条件检测
	if x998445_CheckAccept( sceneId, selfId,targetId ) ~= 1 then
		return
	end
	x998445_MakeCopyScene(sceneId, selfId,x998445_g_CopySceneType)
end

--**********************************
--列举事件
--**********************************
function x998445_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x998445_g_ScriptId, "#{YMMJ_230626_4}",11 ,1  )
	AddNumText( sceneId, x998445_g_ScriptId, "#{YMMJ_230626_26}",10 ,-1  )
end

--**********************************
--检测接受条件
--**********************************
function x998445_CheckAccept( sceneId, selfId,targetId )
	--所在位置不对
	if x998445_g_Back_SceneId ~= sceneId then
		x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_30}" )
		x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_31}")
		return 0
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_40}" )
		x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_41}")
		return 0
	end
	--取得玩家附近的团员数量（包括自己）
	if LuaFnHasRaid(sceneId,selfId) == 1 then
		if LuaFnIsRaidLeader( sceneId, selfId)==0 then
			x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_34}" )
			x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_35}")
			return 0
		end
		--等级是不是够的
		if GetLevel(sceneId,selfId) < x998445_g_LimitLevel then
			x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_36}" )
			x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_37}")
			return 0
		end
		--团队尺寸是否足够
		if LuaFnGetRaidSize(sceneId,selfId) < x998445_g_LimitMembers
		   or LuaFnGetRaidSize(sceneId,selfId) > x998445_g_LimitMembersMax	then
			x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_42}" )
			x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_43}")
			return 0
		end
		--是否都在附近....
		if LuaFnGetRaidSize(sceneId,selfId) ~= LuaFnGetNearRaidCount(sceneId,selfId) then
			x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_44}" )
			x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_45}")
			return 0
		end
	else
		x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_32}" )
		x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_33}")
		return 0
	end
	--今日的挑战次数
	local lastDayCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_YANMEMENGJING)
	if lastDayCount >= 1 then
		x998445_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_38}" )
		x998445_NotifyTips(sceneId, selfId, "#{YMMJ_230626_39}")
		return 0
	end
	
	--检测团员的等级是不是足够创建副本
	local nCanEnter = 1;
	local nMissionTips = ""
	for	i=0, LuaFnGetNearRaidCount( sceneId, selfId ) - 1 do
		local nPlayerID = LuaFnGetNearRaidMember( sceneId, selfId, i )
		if GetLevel(sceneId,nPlayerID) < x998445_g_LimitLevel then
			nMissionTips = nMissionTips..GetName( sceneId, nPlayerID ).."#{YMMJ_230626_50}#r"
			nCanEnter  = 0
		else
			nMissionTips = nMissionTips..GetName( sceneId, nPlayerID ).."#{YMMJ_230626_49}#r"
		end
		--今日的挑战次数
		if GetCampaignCountNum( sceneId, nPlayerID,CAMPAIGN_YANMEMENGJING) >= 1 then
			nMissionTips = nMissionTips.."#{YMMJ_230626_52}#r"
			nCanEnter  = 0
		else
			nMissionTips = nMissionTips.."#{YMMJ_230626_51}#r"
		end
	end
	if nCanEnter == 0 then
		x998445_MsgBox( sceneId, selfId, targetId, nMissionTips)
		return 0
	end
	
	return 1
end

--**********************************
--询问玩家是否要进入副本
--**********************************
function x998445_AskEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--接受
--**********************************
function x998445_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--玩家同意进入副本
--**********************************
function x998445_AcceptEnterCopyScene( sceneId, selfId )
	
end

--**********************************
--创建副本
--**********************************
function x998445_MakeCopyScene( sceneId, selfId,nFuBenType )
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
	
	local nearmembercount = LuaFnGetNearRaidCount(sceneId,selfId)
	for	i = 0, nearmembercount - 1 do
		memId = LuaFnGetNearRaidMember(sceneId, selfId, i);
		tempMemlevel = GetLevel(sceneId, memId);
		level0 = level0 + (tempMemlevel ^ param0);
		level1 = level1 + (tempMemlevel ^ param1);
	end
	
	if level1 == 0 then
		mylevel = 0
	else
		mylevel = level0/level1;
	end
	
	if nearmembercount == -1  then  --没有团队
		mylevel = GetLevel(sceneId, selfId)
	end
	
	local PlayerMaxLevel = GetHumanMaxLevelLimit()
	local iniLevel;
	if mylevel < 10 then
		iniLevel = 1;
	elseif mylevel < PlayerMaxLevel then
		iniLevel = floor(mylevel/10);
	else
		iniLevel = PlayerMaxLevel/10;
	end
	
	local x,z = LuaFnGetWorldPos(sceneId,selfId)
	
	leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "xiriyanmen.path"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x998445_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x998445_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, nFuBenType);		--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x998445_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, x998445_g_SceneData_TickCount, 0);			--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, sceneId)	--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, x);				--设置副本的入口场景位置x
	LuaFnSetCopySceneData_Param(sceneId, 5, z);				--设置副本的入口场景位置Z
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;	--杀死Boss的数量
	LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel, iniLevel)
	LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level, mylevel)
	--动阻状态重置
	for i = x998445_g_CopySceneData_Dynamic_State_1,x998445_g_CopySceneData_Dynamic_State_9 do
		LuaFnSetCopySceneData_Param(sceneId, i, -1)
	end
	--设置场景中的各种Npc和区域
	LuaFnSetSceneLoad_Area( sceneId, "xiriyanmen_area.ini" )
	LuaFnSetSceneLoad_Monster( sceneId, "xiriyanmen_monster.ini" )

	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"#{YMMJ_230626_46}");
		else
			AddText(sceneId,"副本数量已达上限，请稍候再试！");
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

--**********************************
--副本事件
--**********************************
function x998445_OnCopySceneReady( sceneId, destsceneId )

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

	-- 检测玩家是不是有团队
	if LuaFnHasRaid( sceneId, leaderObjId ) == 0  then
		return
	else
		if LuaFnIsRaidLeader(sceneId, leaderObjId) == 0  then
			NewWorld( sceneId, leaderObjId, destsceneId, x998445_g_Fuben_X, x998445_g_Fuben_Z) ;
		else
			local	nearteammembercount = LuaFnGetNearRaidCount( sceneId, leaderObjId) 
			local mems = {}
			for	i=0,nearteammembercount-1 do
				mems[i] = LuaFnGetNearRaidMember(sceneId, leaderObjId, i)
				NewWorld( sceneId, mems[i], destsceneId, x998445_g_Fuben_X, x998445_g_Fuben_Z) ;
			end
		end		
	end

end

--**********************************
--有玩家进入副本事件
--**********************************
function x998445_OnPlayerEnter( sceneId, selfId )
	-- 设置死亡事件
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%50", -1, "0", sceneId, x998445_g_Fuben_X, x998445_g_Fuben_Z )
	--增加今日的进入次数
	AddCampaignCountNum(sceneId,selfId,CAMPAIGN_YANMEMENGJING)
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x998445_OnHumanDie( sceneId, selfId, killerId )
	
end

--**********************************
--放弃
--**********************************
function x998445_OnAbandon( sceneId, selfId )
	
end

--**********************************
-- 回城，只有城市任务副本可以调用此接口
--**********************************
function x998445_BackToCity( sceneId, selfId )
	
end

--**********************************
--继续
--**********************************
function x998445_OnContinue( sceneId, selfId, targetId )
	
end	

--**********************************
--检测是否可以提交
--**********************************
function x998445_CheckSubmit( sceneId, selfId, selectRadioId )
	
end

--**********************************
--提交
--**********************************
function x998445_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998445_OnKillObject( sceneId, selfId, objdataId, objId )
	
end

--**********************************
--进入区域事件
--**********************************
function x998445_OnEnterZone( sceneId, selfId, zoneId )
	
end

--**********************************
--道具改变
--**********************************
function x998445_OnItemChanged( sceneId, selfId, itemdataId )
	
end

--**********************************
--副本场景定时器事件
--**********************************
function x998445_OnCopySceneTimer( sceneId, nowTime )
	
	local nCopySceneFlag = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Complete )
	if nCopySceneFlag == 1 then --副本关闭
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_LeaveTimeCount)
		if leaveTickCount == x998445_g_CloseTick then --倒计时间到，大家都出去吧
			x998445_GoAwayAllPeople(sceneId)
		elseif leaveTickCount < x998445_g_CloseTick then
			if mod(leaveTickCount,10) == 0 then
				x998445_TipAllHuman( sceneId, ScriptGlobal_Format("#{CJWK_221220_90}", tostring((x998445_g_CloseTick-leaveTickCount)*x998445_g_TickTime )))
			end
		end
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_LeaveTimeCount, leaveTickCount) ;
		return
	end
	
	
	--副本时钟递增
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, x998445_g_SceneData_TickCount )
	LuaFnSetCopySceneData_Param(sceneId,x998445_g_SceneData_TickCount,TickCount + 1)
	--梦魇机制心跳
	x998445_NightmareHeartBeat( sceneId )
	--副本初始化
	if TickCount == 5 then
		--进入副本的第一个talkID
		--诸位少侠，各位沿路向前到尽头，即可通过这无间炼狱，完成度厄，不过这无间中变化多端、险恶万分，请少侠们一定小心行事！	
		LuaFnNpcTalk(sceneId,225)
		--启动梦魇机制
		LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,x998445_g_InitNightmare )
		LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_NightmareMax,x998445_g_MaxNightmare )
		--生成迷途侠士
		x998445_CreateMonsterMituxiashi(sceneId)
		--生成动阻系统赵钱孙出口至萧峰
		for i = 2,8 do
			x998445_CreateDynamicBlock( sceneId , i )
		end
	end
	if TickCount == 10 then
		--迷途侠士小怪提示
		LuaFnNpcTalk(sceneId,226)
	end
	if TickCount == x998445_g_LimitTotalHoldTime then --副本总时间限制到了
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Complete, 1) ;
	end
end
--*********************************
--副本人员清空
--*********************************
function x998445_GoAwayAllPeople(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanId) == 1 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, nHumanId, SCENE_YANMEN_BREAKROOM, 96,99, 65 );
		end
    end
end
--**********************************
-- 创建萧峰BOSS
--**********************************
function x998445_CreateMonsterXiaoFengBoss(sceneId)	
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)

	CreateDelayMonsterWithDir( sceneId, x998445_g_BossXiaoFeng.tDataId[nFubenInitLev], 
		x998445_g_BossXiaoFeng.tPos[1], x998445_g_BossXiaoFeng.tPos[2], 21, -1,x998445_g_BossXiaoFeng.nMonsterAi,1.571 ,200)
	--创建入口动阻
	x998445_CreateDynamicBlock( sceneId , 9 )
end
--**********************************
-- 创建萧峰
--**********************************
function x998445_CreateMonsterXiaoFeng(sceneId)	
	
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)

	local monsterID = CreateMonsterWithDir( sceneId, x998445_g_BossXiaoFeng.nNpcDataId, 
		x998445_g_BossXiaoFeng.tPos[1], x998445_g_BossXiaoFeng.tPos[2], 31, -1,x998445_g_BossXiaoFeng.nNpcScript,1.571 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "魔煞" )
	end
end

--**********************************
-- 创建玄慈BOSS
--**********************************
function x998445_CreateMonsterXuanCiBoss(sceneId)	
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)

	CreateDelayMonsterWithDir( sceneId, x998445_g_BossXuanCi.tDataId[nFubenInitLev], 
		x998445_g_BossXuanCi.tPos[1], x998445_g_BossXuanCi.tPos[2], 21, -1,x998445_g_BossXuanCi.nMonsterAi,1.571 ,200)
end

--**********************************
-- 创建玄慈
--**********************************
function x998445_CreateMonsterXuanCi(sceneId)	
	
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)

	local monsterID = CreateMonsterWithDir( sceneId, x998445_g_BossXuanCi.nNpcDataId, 
		x998445_g_BossXuanCi.tPos[1], x998445_g_BossXuanCi.tPos[2], 31, -1,x998445_g_BossXuanCi.nNpcScript,1.571 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "伏虎罗汉" )
	end
end

--**********************************
-- 创建带头大哥BOSS
--**********************************
function x998445_CreateMonsterDaitoudageBoss(sceneId)	
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)

	CreateDelayMonsterWithDir( sceneId, x998445_g_BossDaiTouDaGe.tDataId[nFubenInitLev], 
		x998445_g_BossDaiTouDaGe.tPos[1], x998445_g_BossDaiTouDaGe.tPos[2], 21, -1,x998445_g_BossDaiTouDaGe.nMonsterAi,1.571 ,200)
		
	--入口增加动阻
	x998445_CreateDynamicBlock( sceneId , 5)
	x998445_CreateDynamicBlock( sceneId , 6)
end

--**********************************
-- 创建带头大哥
--**********************************
function x998445_CreateMonsterDaitoudage(sceneId)	
	
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)

	local monsterID = CreateMonsterWithDir( sceneId, x998445_g_BossDaiTouDaGe.nNpcDataId, 
		x998445_g_BossDaiTouDaGe.tPos[1], x998445_g_BossDaiTouDaGe.tPos[2], 31, -1,x998445_g_BossDaiTouDaGe.nNpcScript,1.571 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "夜行罗汉" )
	end
end

--**********************************
-- 创建汪剑通BOSS
--**********************************
function x998445_CreateMonsterZhaoWangJianTongBoss(sceneId)	
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)

	CreateDelayMonsterWithDir( sceneId, x998445_g_BossWangJianTong.tDataId[nFubenInitLev], 
		x998445_g_BossWangJianTong.tPos[1], x998445_g_BossWangJianTong.tPos[2], 21, -1,x998445_g_BossWangJianTong.nMonsterAi,1.571 ,200)
		
	--入口增加动阻
	x998445_CreateDynamicBlock( sceneId , 3)
end

--**********************************
-- 创建汪剑通
--**********************************
function x998445_CreateMonsterZhaoWangJianTong(sceneId)	
	
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)

	local monsterID = CreateMonsterWithDir( sceneId, x998445_g_BossWangJianTong.nNpcDataId, 
		x998445_g_BossWangJianTong.tPos[1], x998445_g_BossWangJianTong.tPos[2], 31, -1,x998445_g_BossWangJianTong.nNpcScript,1.571 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "江湖剑鬓" )
	end
end

--**********************************
-- 创建赵钱孙BOSS
--**********************************
function x998445_CreateMonsterZhaoQianSunBOSS(sceneId)	
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)

	CreateDelayMonsterWithDir( sceneId, x998445_g_BossZhaoQianSun.tDataId[nFubenInitLev], 
		x998445_g_BossZhaoQianSun.tPos[1], x998445_g_BossZhaoQianSun.tPos[2], 21, -1,x998445_g_BossZhaoQianSun.nMonsterAi,1.571 ,200)
		
	--入口增加动阻
	x998445_CreateDynamicBlock( sceneId , 1 )
end

--**********************************
-- 创建赵钱孙
--**********************************
function x998445_CreateMonsterZhaoQianSun(sceneId)	
	LuaFnNpcTalk(sceneId,275)
	
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)

	local monsterID = CreateMonsterWithDir( sceneId, x998445_g_BossZhaoQianSun.nNpcDataId, 
		x998445_g_BossZhaoQianSun.tPos[1], x998445_g_BossZhaoQianSun.tPos[2], 31, -1,x998445_g_BossZhaoQianSun.nNpcScript,1.571 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "无踪行者" )
	end
end

--**********************************
-- BOSS周边随机创建消、度、业 厄
--**********************************
function x998445_CreateSpecialMonster(sceneId,selfId,number)	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)
	
	local x,z = GetWorldPos( sceneId, selfId )
	for i = 1,number do
		local nRandX,nRandZ = LuaFnRandPosInCenter(x,z,16.0);
		local nRandType = random(1,4)
		local nMonsterDataId = -1
		if nRandType == 1 then
			nMonsterDataId = x998445_g_MengYanMonster.tYeDataId[nFubenInitLev]
		elseif nRandType == 2 then
			nMonsterDataId = x998445_g_MengYanMonster.tEDataId[nFubenInitLev]
		elseif nRandType == 3 then
			nMonsterDataId = x998445_g_MengYanMonster.tXiaoDataId[nFubenInitLev]
		elseif nRandType == 4 then
			nMonsterDataId = x998445_g_MengYanMonster.tDuDataId[nFubenInitLev]
		end
		if nMonsterDataId ~= -1 then
			local monsterID = CreateMonsterWithDir( sceneId, nMonsterDataId, 
				nRandX,nRandZ,
				13, -1,x998445_g_ScriptId,1.571 )
			if monsterID ~= -1 then
				SetUnitCampID(sceneId,monsterID, monsterID, 110)
				SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
				SetLevel(sceneId,monsterID,nFubenLev)
			end
		end
	end
end
--**********************************
-- 创建消、度 范例
--**********************************
function x998445_CreateMonsterXiaoDuExpamle(sceneId)	
	--消、度提示
	LuaFnNpcTalk(sceneId,286)
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)
	--创建三个monster
	--消 度
	local nXiaoMonsterDataId = x998445_g_MengYanMonster.tXiaoDataId[nFubenInitLev]
	local nDuMonsterDataId = x998445_g_MengYanMonster.tDuDataId[nFubenInitLev]
	
	local monsterID = CreateMonsterWithDir( sceneId, nXiaoMonsterDataId, 
		72,196,
		13, -1,x998445_g_ScriptId,1.571 )
	if monsterID ~= -1 then
		SetUnitCampID(sceneId,monsterID, monsterID, 110)
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
		SetLevel(sceneId,monsterID,nFubenLev)
	end
	
	monsterID = CreateMonsterWithDir( sceneId, nXiaoMonsterDataId, 
		69,201,
		13, -1,x998445_g_ScriptId,1.571 )
	if monsterID ~= -1 then
		SetUnitCampID(sceneId,monsterID, monsterID, 110)
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
		SetLevel(sceneId,monsterID,nFubenLev)
	end
	
	monsterID = CreateMonsterWithDir( sceneId, nDuMonsterDataId, 
		65,194,
		13, -1,x998445_g_ScriptId,1.571 )
	if monsterID ~= -1 then
		SetUnitCampID(sceneId,monsterID, monsterID, 110)
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
		SetLevel(sceneId,monsterID,nFubenLev)
	end
end

--**********************************
-- 创建业 厄 范例
--**********************************
function x998445_CreateMonsterYeeExpamle(sceneId)	
	LuaFnNpcTalk(sceneId,287)
	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)
	
	local tMosterPos = {
		{62,190},{65,191},{66,193},{64,195},{61,197},{61,194},{57,196},{53,196},{53,199}
	}	
	for i = 1, getn( tMosterPos ) do
		local nMonsterDataId = -1
		if random(1,2) == 1 then
			nMonsterDataId = x998445_g_MengYanMonster.tYeDataId[nFubenInitLev]
		else
			nMonsterDataId = x998445_g_MengYanMonster.tEDataId[nFubenInitLev]
		end
		
		local monsterID = CreateMonsterWithDir( sceneId, nMonsterDataId, 
			tMosterPos[i][1], tMosterPos[i][2], 
			13, -1,x998445_g_ScriptId,1.571 )
		if monsterID ~= -1 then
			SetUnitCampID(sceneId,monsterID, monsterID, 110)
			SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
			SetLevel(sceneId,monsterID,nFubenLev)
		end
	end
end

--**********************************
-- 创建迷途侠士
--**********************************
function x998445_CreateMonsterMituxiashi(sceneId)	
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Level)
	for i = 1, getn( x998445_g_MituxiashiMonster.tPos ) do
		local tPos = x998445_g_MituxiashiMonster.tPos
		local nMonsterDataId = x998445_g_MituxiashiMonster.tDataId[nFubenInitLev]
		
		local monsterID = CreateMonsterWithDir( sceneId, nMonsterDataId, 
			tPos[i][1], tPos[i][2], 
			11, -1,x998445_g_ScriptId,1.571 )
		if monsterID ~= -1 then
			SetUnitCampID(sceneId,monsterID, monsterID, 110)
			SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
			SetLevel(sceneId,monsterID,nFubenLev)
		end
	end
end

--**********************************
--梦魇机制心跳
--**********************************
function x998445_NightmareHeartBeat( sceneId )
	local nCurNightmareMax = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_NightmareMax )
	if nCurNightmareMax <= 0 then
		return
	end
	local nCurNightmare = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare )
	--梦魇发生期间不激活逻辑
	local nCurNightmareTick = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_NightmareTick )
	if nCurNightmareTick > 0 then
		LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_NightmareTick,nCurNightmareTick - 1 )
		return
	end
	nCurNightmare = nCurNightmare + 5
	LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,nCurNightmare )
	--触发梦魇后启动计时器
	if nCurNightmare >= x998445_g_MaxNightmare then
		nCurNightmare = x998445_g_MaxNightmare
		--梦魇的tick为25s
		LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_NightmareTick,25 )
		--清空当前的梦魇值
		LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,0 )
		--激活客户端的effect
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, x998445_g_MaxNightmare)			
			UICommand_AddInt( sceneId, x998445_g_MaxNightmare )		
			UICommand_AddInt( sceneId, 25 )			
		EndUICommand( sceneId )
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		if nHumanNum > 0 then
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
					DispatchUICommand( sceneId, PlayerId, 99844502 )
				end
			end
		end
		return
	end
	--每10s更新一次
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, x998445_g_SceneData_TickCount )
	if mod(TickCount,10) ~= 0 then
		return
	end
	x998445_NightmareUpdate( sceneId )
end
--**********************************
--更新最新的梦魇信息
--**********************************
function x998445_NightmareUpdate( sceneId )
	--梦魇发生期间不更新客户端UI
	local nCurNightmareTick = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_NightmareTick )
	if nCurNightmareTick > 0 then
		return
	end
	local nCurNightmare = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare )
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nCurNightmare)
		UICommand_AddInt( sceneId, x998445_g_MaxNightmare )
		UICommand_AddInt( sceneId, 0 )
	EndUICommand( sceneId )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			DispatchUICommand( sceneId, PlayerId, 99844501 )
		end
	end
end
--**********************************
--BOSS死亡
--**********************************
function x998445_OnBossDie(sceneId, objId, killerId)
	if GetName(sceneId,objId) == "赵钱孙" then
		--生成掉落包
		CallScriptFunction(998468, "GenerateDropBox",sceneId,objId,0)
		--特殊提示
		LuaFnNpcTalk(sceneId,277)
		--创建汪剑通
		x998445_CreateMonsterZhaoWangJianTong(sceneId)
		--销毁入口及出口
		x998445_ReleaseDynamicRegion( sceneId,1)
		x998445_ReleaseDynamicRegion( sceneId,2)
		x998445_ReleaseDynamicRegion( sceneId,3)
	end
	if GetName(sceneId,objId) == "汪剑通" then
		--生成掉落包
		CallScriptFunction(998468, "GenerateDropBox",sceneId,objId,0)
		--特殊提示
		LuaFnNpcTalk(sceneId,229)
		--创建下一个boss
		x998445_CreateMonsterDaitoudage(sceneId)
		x998445_CreateMonsterXuanCi(sceneId)
		--销毁入口及出口
		x998445_ReleaseDynamicRegion( sceneId,3)
		x998445_ReleaseDynamicRegion( sceneId,4)
		--销毁带头大哥入口
		x998445_ReleaseDynamicRegion( sceneId,5)
		x998445_ReleaseDynamicRegion( sceneId,6)
	end
	if GetName(sceneId,objId) == "带头大哥" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_SpecialBoss)
		nCurKill = nCurKill + 1
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_SpecialBoss,nCurKill)
		if nCurKill == 2 then
			--特殊提示
			LuaFnNpcTalk(sceneId,280)
			--创建萧峰
			x998445_CreateMonsterXiaoFeng(sceneId)
			--销毁入口及出口
			x998445_ReleaseDynamicRegion( sceneId,5)
			x998445_ReleaseDynamicRegion( sceneId,6)
			x998445_ReleaseDynamicRegion( sceneId,7)
			x998445_ReleaseDynamicRegion( sceneId,8)
		end
		--生成掉落包
		CallScriptFunction(998468, "GenerateDropBox",sceneId,objId,0)
	end
	if GetName(sceneId,objId) == "玄慈" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_SpecialBoss)
		nCurKill = nCurKill + 1
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_SpecialBoss,nCurKill)
		if nCurKill == 2 then
			--特殊提示
			LuaFnNpcTalk(sceneId,280)
			--创建萧峰
			x998445_CreateMonsterXiaoFeng(sceneId)	
			--销毁入口及出口
			x998445_ReleaseDynamicRegion( sceneId,5)
			x998445_ReleaseDynamicRegion( sceneId,6)
			x998445_ReleaseDynamicRegion( sceneId,7)
			x998445_ReleaseDynamicRegion( sceneId,8)
		end
		--生成掉落包
		CallScriptFunction(998468, "GenerateDropBox",sceneId,objId,0)
	end
	--最终BOSS死亡
	if GetName(sceneId,objId) == "萧峰心魔" then
		--生成掉落包
		CallScriptFunction(998468, "GenerateDropBox",sceneId,objId,1)
		--特殊提示
		LuaFnNpcTalk(sceneId,282)
		--标记完成
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Complete,1)		
		--结算玩家奖励
		for	i=0,LuaFnGetCopyScene_HumanCount(sceneId)-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then

				if LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN then
					LuaFnFinishZhouHuoYueMission(sceneId,nHumanId,41)
--					CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, nHumanId,CAMPAIGN_WANGRIMENGJING)
				elseif LuaFnGetCopySceneData_Param(sceneId, 0) == FUBEN_YANMEN_D then
					LuaFnFinishZhouHuoYueMission(sceneId,nHumanId,41)
--					CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, nHumanId,CAMPAIGN_WANGRIMENGJING_D)
				end
			end
		end
		--高光时刻结算
		LuaFnShowCopySceneHigntlight(sceneId,35);
	end
end
--**********************************
--Monster死亡
--**********************************
function x998445_OnDie(sceneId, objId, killerId)
	--杀死怪物的是宠物则获取其主人的ID....
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
	end
	
	if GetName(sceneId,objId) == "迷途侠士" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_MituKillNum);
		nCurKill = nCurKill + 1
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_MituKillNum, nCurKill) ;
		
		x998445_TipAllHuman( sceneId, ScriptGlobal_Format("#{YMMJ_230626_131}",tostring(nCurKill)) )
		--击杀完毕
		if nCurKill >= getn(x998445_g_MituxiashiMonster.tPos) then
			x998445_CreateMonsterXiaoDuExpamle(sceneId)
			return
		end
	end
	if GetName(sceneId,objId) == "消" or GetName(sceneId,objId) == "度" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_XiaoDuKillNum);
		nCurKill = nCurKill + 1
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_XiaoDuKillNum, nCurKill) ;
		
		if nCurKill <= 3 then
			x998445_TipAllHuman( sceneId, ScriptGlobal_Format("#{YMMJ_230626_185}",tostring(nCurKill)) )
		end
		--范例结束，创建下一组范例
		if nCurKill == 3 then
			x998445_CreateMonsterYeeExpamle(sceneId)
		end
		--消减少50点
		if GetName(sceneId,objId) == "消" then
			local nCurNightmare = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare )
			nCurNightmare = nCurNightmare - 50
			if nCurNightmare < 0 then
				nCurNightmare = 0
			end
			LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,nCurNightmare )
		end
		--度减少25%
		if GetName(sceneId,objId) == "度" then
			local nCurNightmare = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare )
			nCurNightmare = floor(nCurNightmare * 0.75)
			if nCurNightmare < 0 then
				nCurNightmare = 0
			end
			LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,nCurNightmare )
		end
		x998445_NightmareUpdate( sceneId )
	end
	
	if GetName(sceneId,objId) == "业" or GetName(sceneId,objId) == "厄" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_YeeKillNum);
		nCurKill = nCurKill + 1
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_YeeKillNum, nCurKill) ;
		--特殊提示
		if nCurKill == 2 then
			LuaFnNpcTalk(sceneId,276)
		end
		if nCurKill <= 9 then
			x998445_TipAllHuman( sceneId, ScriptGlobal_Format("#{YMMJ_230626_187}",tostring(nCurKill)) )
		end
		--范例结束
		if nCurKill == 9 then
			--创建赵钱孙
			x998445_CreateMonsterZhaoQianSun(sceneId)
		end
		--增加35点
		if GetName(sceneId,objId) == "业" then
			local nCurNightmare = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare )
			nCurNightmare = nCurNightmare + 35
			if nCurNightmare > x998445_g_MaxNightmare then
				nCurNightmare = x998445_g_MaxNightmare
			end
			LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,nCurNightmare )
		end
		--增加50点
		if GetName(sceneId,objId) == "厄" then
			local nCurNightmare = LuaFnGetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare )
			nCurNightmare = nCurNightmare + 50
			if nCurNightmare > x998445_g_MaxNightmare then
				nCurNightmare = x998445_g_MaxNightmare
			end
			LuaFnSetCopySceneData_Param( sceneId, x998445_g_CopySceneData_Nightmare,nCurNightmare )
		end
		x998445_NightmareUpdate( sceneId )
	end
end
--**********************************
--动阻创建
--**********************************
function x998445_CreateDynamicBlock( sceneId , index )
	local item = x998445_g_DyInitState[index]
	if item == nil then
		return 0
	end
	local DyNpcid = LuaFnGetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Dynamic_State_1 + index - 1)
	if DyNpcid == -1 then
		DyNpcid = CreateMonsterWithDir(sceneId, item.npcid, item.posx, item.posz, 3, -1, -1, item.dir)
		if DyNpcid == nil or DyNpcid < 0 then
			local recordMsg = format("CreateDynamicBlocks npc ERROR sceneid=%d", sceneId)
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_YANMENMENGJING, -1,recordMsg)
			return 0
		else
			local DyRetId = LuaFnAddDynamicRegionByObject(sceneId, DyNpcid, item.dataid)
			if DyRetId == -1 then
				local recordMsg = format("CreateDynamicBlocks region ERROR sceneid=%d", sceneId )
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_YANMENMENGJING, -1,recordMsg)
				return 0
			else
				LuaFnSetNpcIntParameter(sceneId, DyNpcid, 0, DyRetId)
				local recordMsg = format("CreateDynamicBlocks sceneid=%d, regionindex=%d, DyRetId=%d", sceneId, index, DyRetId)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_YANMENMENGJING, -1, recordMsg)
			end
		end
		LuaFnSetCopySceneData_Param(sceneId, x998445_g_CopySceneData_Dynamic_State_1 + index - 1, DyNpcid)
	else
		local recordMsg = format("Has Been Create ERROR sceneid=%d", sceneId )
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_YANMENMENGJING, -1,recordMsg)
	end
	return 0
end
--**********************************
--动阻区域销毁
--**********************************
function x998445_ReleaseDynamicRegion( sceneId,index)
	if index < 1 or index > getn(x998445_g_DyInitState) then
		local recordMsg = format("ReleaseDynamicRegion sceneid=%d, index=%d", sceneId, index)
		ScriptGlobal_AuditGeneralLog( LUAAUDIT_FUBEN_YANMENMENGJING, -1, recordMsg )
		return 0
	end
	local npcid = -1
	if index >= 1  and index <= getn(x998445_g_DyInitState) then
		npcid = LuaFnGetCopySceneData_Param(sceneId, index + x998445_g_CopySceneData_Dynamic_State_1 - 1)
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
				LuaFnSetCopySceneData_Param(sceneId, index + x998445_g_CopySceneData_Dynamic_State_1 - 1,-1)
				
				local teamID = LuaFnGetCopySceneData_Param( sceneId, 6)
				local recordMsg = format("ReleaseDynamicRegion sceneid=%d, regionindex=%d, teamID=%d", sceneId, index, teamID)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_YANMENMENGJING, -1, recordMsg)
			else
				local recordMsg = format("ReleaseDynamicRegion open err sceneid=%d, regionindex=%d", sceneId, index)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_YANMENMENGJING, -1, recordMsg)
			end
		end
	end
	return 0
end
--**********************************
--副本里的所有玩家播放动画
--**********************************
function x998445_PlayerMovie( sceneId, nMovieId )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			LuaFnClientPlayerMovie(sceneId,PlayerId,nMovieId)
		end
	end
end

--**********************************
--提示所有副本内玩家
--**********************************
function x998445_TipAllHuman( sceneId, Str )
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
--对话框通知事件
--**********************************
function x998445_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId,  msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--场景通知事件
--**********************************
function x998445_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end