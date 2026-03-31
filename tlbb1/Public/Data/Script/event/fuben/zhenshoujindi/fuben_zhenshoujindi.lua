--青丘副本主逻辑

--脚本号
x893020_g_ScriptId = 893020

--是否开放
x893020_g_IsOpen = 1

--副本名称
x893020_g_CopySceneName="青丘"

--需要完成的任务
x893020_g_PreMissionId = 2065

--副本类型
--全局副本类型 0 为普通 1 为困难
x893020_g_TodayMax = {
	[0] = 2,
	[1] = 1,
}
x893020_g_CampainId = {
	[0] = CAMPAIGN_QINGQIU,
	[1] = CAMPAIGN_QINGQIU_DIFF,
}
--**********************************以上是动态****************************

x893020_g_CopySceneType=FUBEN_ZHENGSHOUJINGDI	--副本类型，定义在ScriptGlobal.lua里面
x893020_g_LimitMembers=1			--可以进副本的最小队伍人数
x893020_g_LimitLevel = 85			--最低进入副本的等级
x893020_g_TickTime=5				--回调脚本的时钟时间（单位：秒/次）
x893020_g_LimitTotalHoldTime=720	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败	60分钟
x893020_g_LimitTimeSuccess=500		--副本时间限制（单位：次数），如果此时间到了，任务完成
x893020_g_CloseTick=12				--副本关闭前倒计时（单位：次数）
x893020_g_NoUserTime=60				--副本中没有人后可以继续保存的时间（单位：秒）
x893020_g_Fuben_X=178				--进入副本的位置X
x893020_g_Fuben_Z=42				--进入副本的位置Z
x893020_g_BackSceneID = 1			--源场景编号
x893020_g_Back_X=133				--源场景位置X
x893020_g_Back_Z=82					--源场景位置Z
x893020_g_TotalNeedKill=1			--需要杀死怪物数量

--这里定义场景的数据接口
x893020_g_SceneData_Type = 7		--副本的难度类型
x893020_g_SceneData_MainStep = 8   	--当前的逻辑批次
x893020_g_SceneData_SaoDiKillNum = 9--扫地狐杀死的数量
x893020_g_SceneData_CurBOSSID = 10	--当前完成击杀的BOSS数量
x893020_g_SceneData_CurQingQiuHuNPCID = 11 --青丘狐ID
x893020_g_SceneData_BOSS_1_ObjId = 12	--Boss1云卷舒的ID
x893020_g_SceneData_BOSS_2_WillKillType = 13	--BOSS2 逸当前的灵狐暴走类型 0 阴 1 阳
x893020_g_SceneData_BOSS_2_WillKillNum = 14		--BOSS2 逸当前的灵狐击杀数量
x893020_g_SceneData_Dynamic_State_1 = 15		--动阻状态
x893020_g_SceneData_Dynamic_State_2 = 16		--动阻状态
x893020_g_SceneData_Dynamic_State_3 = 17		--动阻状态
x893020_g_SceneData_Dynamic_State_4 = 18		--动阻状态
x893020_g_SceneData_Dynamic_State_5 = 19		--动阻状态
x893020_g_SceneData_Dynamic_State_6 = 20		--动阻状态
x893020_g_SceneData_Dynamic_State_7 = 21		--动阻状态
x893020_g_SceneData_Dynamic_State_8 = 22		--动阻状态
x893020_g_SceneData_Dynamic_State_9 = 23		--动阻状态
x893020_g_SceneData_Dynamic_State_10 = 24		--动阻状态
x893020_g_SceneData_InitLevel = 25				--副本的难度等级
x893020_g_SceneData_Level = 26					--副本的等级

--动阻控制脚本
x893020_g_DynamicBlockScriptId	= 893038
--传送界碑位置
x893020_g_PosChuanSong = {228,70}
x893020_g_ChuanSongScript = 893021
--青丘狐的脚本
x893020_g_QingQiuHu = 893039
--扫地狐的位置
x893020_g_SaoDiFoxPos = {
	--上
	{x =195,z =34,dir = 6.28},{x=200,z=34,dir = 6.28},{x=209,z=36,dir = 6.28},{x=213,z=43,dir = 6.28},{x=214,z=47,dir = 6.28},
	--下
	{x=211,z=49,dir=3.14},{x=208,z=46,dir=3.14},{x=202,z=41,dir=3.14},{x=198,z=40,dir=3.14},{x=211,z=47,dir=3.14},
}
--扫地狐的AI脚本
x893020_g_SaoDiFoxScriptID = 893115
--云卷舒的位置
x893020_g_PosYunJuanShu = {180,123}
--云卷舒的交互脚本
x893020_g_BOSS_1_NPC = 893022
--云卷舒的AI脚本
x893020_g_BOSS_1_NPC_BOSSAI = 893023
--逸的位置
x893020_g_PosBOSS_2 = {144,200}
--逸的交互脚本
x893020_g_BOSS_2_NPC = 893025
--逸的AI脚本
x893020_g_BOSS_2_NPC_BOSSAI = 893026
--艾虎的位置
x893020_g_PosBOSS_3 = {62.9810,144.8252}
--艾虎的交互脚本
x893020_g_BOSS_3_NPC = 893027
--艾虎的AI脚本
x893020_g_BOSS_3_NPC_BOSSAI = 893028
--云飘飘的位置
x893020_g_PosBOSS_5 = {59.8329,63.3948}
--云飘飘的交互脚本
x893020_g_BOSS_5_NPC = 893031
--云飘飘的AI脚本
x893020_g_BOSS_5_NPC_BOSSAI = 893032
--九尾狐的位置
x893020_g_PosBOSS_4 = {45,41}
--死亡后的NPC脚本
x893020_g_BOSS_DieScript = {
	893034,
	893035,
	893036,
	893037
}
--困难副本下的BOSS属性增强倍率
x893020_g_BOSS_StrengthInDifficult = 2.2
--掉落箱的控制脚本
x893020_g_DropBoxScript = {
	893116,893117,893118,893119
}
--新增称号兑换
x893020_g_AgnameExchange = {
	[201] = {name = "#{ZSFB_20220105_126}",cost = 10,costitem = 20800020,id = 1091,needact = -1},
	[202] = {name = "#{ZSFB_20220105_127}",cost = 30,costitem = 20800020,id = 1092,needact = 1091},
	[203] = {name = "#{ZSFB_20220105_128}",cost = 90,costitem = 20800020,id = 1093,needact = 1092},
	[204] = {name = "#{ZSFB_20220105_129}",cost = 180,costitem = 20800020,id = 1094,needact = 1093},
	[205] = {name = "#{ZSFB_20220105_130}",cost = 300,costitem = 20800020,id = 1095,needact = 1094},
}
--**********************************
--任务入口函数
--**********************************
function x893020_OnDefaultEvent( sceneId, selfId, targetId,eventID,scriptId )
	if x893020_g_IsOpen == 1 and IsMissionHaveDone(sceneId,selfId,x893020_g_PreMissionId) then
		 if eventID == 100 then
			--条件检测
			if  x893020_CheckAccept( sceneId, selfId,targetId,0 ) ~= 1 then
				return
			end
			x893020_MakeCopyScene( sceneId, selfId, nearmembercount,0 )
			return
		end
		 if eventID == 101 then
			--条件检测
			if  x893020_CheckAccept( sceneId, selfId,targetId,1 ) ~= 1 then
				return
			end
			x893020_MakeCopyScene( sceneId, selfId, nearmembercount,1 )
			return
		end
	end
   
	if eventID == 102 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZSFB_20220105_06}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if eventID == 200 then
		BeginEvent(sceneId)
			--称号新增
			AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_126}", 6, 201 )
			AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_127}", 6, 202 )
			AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_128}", 6, 203 )
			AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_129}", 6, 204 )
			AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_130}", 6, 205 )
			
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	if eventID >= 201 and eventID <= 205 then
		if x893020_g_AgnameExchange[eventID] ~= nil then
			BeginEvent(sceneId)
				--称号新增
				AddText(sceneId,ScriptGlobal_Format("#{ZSFB_20220105_131}",x893020_g_AgnameExchange[eventID].name,x893020_g_AgnameExchange[eventID].cost,GetItemName(sceneId,x893020_g_AgnameExchange[eventID].costitem)))
				AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_132}", 6, 300 + eventID - 200 )
				AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_133}", 8, 400 )				
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	end
	
	if eventID >= 301 and eventID <= 305 then
		eventID = eventID - 100
		if x893020_g_AgnameExchange[eventID] ~= nil then
--			和对话NPC的距离不能太远
			if IsInDist( sceneId, selfId, targetId, 6 ) ~= 1 then
				x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_135}")
				return
			end
			if GetLevel(sceneId,selfId) < x893020_g_LimitLevel then
				x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_134}")
				return
			end
--			身上的够不够
			if LuaFnGetAvailableItemCount(sceneId, selfId,x893020_g_AgnameExchange[eventID].costitem) < x893020_g_AgnameExchange[eventID].cost then
				x893020_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{ZSFB_20220105_138}",GetItemName(sceneId,x893020_g_AgnameExchange[eventID].costitem),tostring( x893020_g_AgnameExchange[eventID].cost)))
				x893020_MsgBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{ZSFB_20220105_137}",
					tostring( x893020_g_AgnameExchange[eventID].cost),GetItemName(sceneId,x893020_g_AgnameExchange[eventID].costitem),GetItemName(sceneId,x893020_g_AgnameExchange[eventID].costitem)) )
				return
			end
--			检查有无兑换
			local retCanAddTitle = LuaFnCanAddTitle( sceneId, selfId, x893020_g_AgnameExchange[eventID].id )
			if ( retCanAddTitle ~= 1 ) then
				if ( retCanAddTitle == 0 ) then
					--称号已存在
					x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_145}")
					x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_146}" )
					return
				elseif ( retCanAddTitle == -1 ) then
					--有更高级的称号存在
					x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_145}")
					x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_146}" )
					return
				else
					return
				end
			end
			if x893020_g_AgnameExchange[eventID].needact ~= -1 then
				if LuaFnCanAddTitle( sceneId, selfId, x893020_g_AgnameExchange[eventID].needact ) == 1 then
					for i = 201,205 do
						if x893020_g_AgnameExchange[i].id == x893020_g_AgnameExchange[eventID].needact then
							x893020_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{ZSFB_20220105_152}",x893020_g_AgnameExchange[i].name))
						end
					end
					return
				end
			end
			--扣除
			LuaFnDelAvailableItem(sceneId,selfId,x893020_g_AgnameExchange[eventID].costitem,x893020_g_AgnameExchange[eventID].cost) 
			--给称号
			LuaFnAwardCharTitle( sceneId, selfId, x893020_g_AgnameExchange[eventID].id )
			LuaFnSetCurTitleById( sceneId, selfId, x893020_g_AgnameExchange[eventID].id )
			LuaFnDispatchAllTitle(sceneId, selfId)
			--成功激活%s
			x893020_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{ZSFB_20220105_136}",x893020_g_AgnameExchange[eventID].name))
--			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		end
		return
	end
	
	if eventID == 400 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )	
	end
end

--**********************************
--列举事件
--**********************************
function x893020_OnEnumerate( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZSFB_20220105_03}")
		if x893020_g_IsOpen == 1 then
			--检查自身任务有无完成
			if (IsMissionHaveDone(sceneId,selfId,x893020_g_PreMissionId) > 0 ) then
				AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_04}", 10, 100 )
				AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_115}", 10, 101 )
			end
		end
		AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_05}", 11, 102 )
		--称号新增
		AddNumText( sceneId, x893020_g_ScriptId, "#{ZSFB_20220105_125}", 6, 200 )
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x893020_CheckAccept( sceneId, selfId ,targetId,nType)
	if x893020_g_BackSceneID ~= sceneId then
		x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_07}" )
		x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_08}")
		return 0
	end
	--取得玩家附近的队友数量（包括自己）
	if LuaFnHasTeam(sceneId,selfId) == 1 then
		if LuaFnIsTeamLeader( sceneId, selfId)==0 then	--只有队长才能接任务
			x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_11}" )
			x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_12}")
			return 0
		end
		--队长等级是不是够的
		if GetLevel(sceneId,selfId) < x893020_g_LimitLevel then
			x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_15}" )
			x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_16}")
			return 0
		end
		--队伍尺寸是否足够
		if GetTeamSize(sceneId,selfId) < x893020_g_LimitMembers then
			x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_21}" )
			x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_22}")
			return 0
		end
		--是否都在附近....
		local NearTeamSize = GetNearTeamCount(sceneId,selfId)
		if GetTeamSize(sceneId,selfId) ~= NearTeamSize then
			x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_23}" )
			x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_24}")
			return 0
		end
	else
		x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_09}" )
		x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_10}")
		return 0
	end
	--今日的挑战次数
	local lastDayCount = GetCampaignCountNum(sceneId,selfId,x893020_g_CampainId[nType])
	if lastDayCount >= x893020_g_TodayMax[nType] then
		x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_17}" )
		x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_18}")
		return 0
	end
	--和对话NPC的距离不能太远
	if IsInDist( sceneId, selfId, targetId, 6 ) ~= 1 then
		x893020_MsgBox( sceneId, selfId, targetId, "#{ZSFB_20220105_19}" )
		x893020_NotifyTips(sceneId, selfId, "#{ZSFB_20220105_20}")
		return 0
	end
	
	--检测队友的等级是不是足够创建副本
	local nCanEnter = 1;
	local nMissionTips = ""
	local NearTeamSize = GetNearTeamCount( sceneId, selfId )
	for	i=0, NearTeamSize - 1 do
		local nPlayerID = GetNearTeamMember( sceneId, selfId, i )
		if GetLevel(sceneId,nPlayerID) < x893020_g_LimitLevel then
			nMissionTips = nMissionTips..GetName( sceneId, nPlayerID ).."#{ZSFB_20220105_30}#r"
			nCanEnter  = 0
		else
			nMissionTips = nMissionTips..GetName( sceneId, nPlayerID ).."#{ZSFB_20220105_29}#r"
		end
		--今日的挑战次数
		if GetCampaignCountNum( sceneId, nPlayerID, x893020_g_CampainId[nType] ) >= x893020_g_TodayMax[nType] then
			nMissionTips = nMissionTips.."#r#cff0000挑战点数≥"..x893020_g_TodayMax[nType].."              不满足#r"
			nCanEnter  = 0
		else
			nMissionTips = nMissionTips.."#r#G挑战点数≥"..x893020_g_TodayMax[nType].."              满足#r"
		end
		--检查任务是否完成
		if IsMissionHaveDone(sceneId,nPlayerID,x893020_g_PreMissionId) <= 0 then
			x893020_MsgBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{ZSFB_20220105_25}",GetName(sceneId,nPlayerID)))
			x893020_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{ZSFB_20220105_26}",GetName(sceneId,nPlayerID)))
			return 0
		end
		
	end
	if nCanEnter == 0 then
		x893020_MsgBox( sceneId, selfId, targetId, nMissionTips)
		return 0
	end
	
	return	1
end

--**********************************
--创建副本
--**********************************
function x893020_MakeCopyScene( sceneId, selfId, nearmembercount,nType )
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
		tempMemlevel = GetLevel(sceneId, memId);
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
	
	local PlayerMaxLevel = GetHumanMaxLevelLimit()
	local iniLevel;
	if mylevel < 10 then
		iniLevel = 1;
	elseif mylevel < PlayerMaxLevel then
		iniLevel = floor(mylevel/10);
	else
		iniLevel = PlayerMaxLevel/10;
	end
	
	local leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "qingqiu.path"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x893020_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x893020_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x893020_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x893020_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, x893020_g_BackSceneID);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_Type, nType) ;--副本类型 0-普通 1-困难
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep, 0) ;--当前的逻辑批次
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_SaoDiKillNum, 0) ;--扫地狐杀死的数量
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_CurBOSSID, 0) ;--当前完成击杀的BOSS数量
	--动阻状态信息
	for i = x893020_g_SceneData_Dynamic_State_1,x893020_g_SceneData_Dynamic_State_10 do
		LuaFnSetCopySceneData_Param( sceneId,i, -1 )
	end
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel, iniLevel)
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_Level, mylevel)
	
	
	LuaFnSetSceneLoad_Monster(sceneId, "qingqiu_monster.ini")	

	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"副本创建成功！");
		else
			AddText(sceneId,"副本数量已达上限，请稍候再试！");
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893020_OnKillObject( sceneId, selfId, objdataId ,objId )
	--是否是副本
	local sceneType = LuaFnGetSceneType(sceneId) ;
	if sceneType~=1 then
		return
	end 
	--是否是所需要的副本
	local fubentype = LuaFnGetCopySceneData_Param(sceneId,0)
	if fubentype~=x893020_g_CopySceneType then
		return
	end
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	if 	leaveFlag==1 then --如果副本已经被置成关闭状态，则杀怪无效
		return 
	end
end

--**********************************
--进入区域事件
--**********************************
function x893020_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893020_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x893020_OnCopySceneReady( sceneId, destsceneId )
	--设置副本入口场景号
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);
	--传送队长
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	NewWorld( sceneId,leaderObjId, destsceneId, x893020_g_Fuben_X, x893020_g_Fuben_Z)
	--传送周边队员
	local nearmembercount = GetNearTeamCount( sceneId, leaderObjId )
	local member
	for	i=0, nearmembercount - 1 do
		member = GetNearTeamMember( sceneId, leaderObjId, i )
		if LuaFnIsCanDoScriptLogic( sceneId, member ) == 1 then
			NewWorld( sceneId, member, destsceneId, x893020_g_Fuben_X, x893020_g_Fuben_Z )
		end
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x893020_OnPlayerEnter( sceneId, selfId )
	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%10", -1, "0", sceneId, x893020_g_Fuben_X, x893020_g_Fuben_Z );
	--增加今日的进入次数
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId,x893020_g_SceneData_Type)
	AddCampaignCountNum(sceneId,selfId,x893020_g_CampainId[nFubenType])
	--初始化副本
	x893020_InitializationCopyScene( sceneId)
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x893020_OnHumanDie( sceneId, selfId, killerId )
end

--**********************************
--离开副本
--**********************************
function x893020_LeaveScene( sceneId, selfId )
	local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
	NewWorld( sceneId, selfId, oldsceneId, x893020_g_Back_X, x893020_g_Back_Z )
end

--**********************************
--副本逻辑调整
--**********************************
function x893020_UpdateCurMainStep( sceneId,nStep)
	local nCurStep = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep)
	--置空逻辑下
	if nCurStep == 3 and nStep <= 2 then
		return
	end
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,nStep)
end

--**********************************
--初始化副本
--**********************************
function x893020_InitializationCopyScene( sceneId)
	local nCurStep = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep)
	if nCurStep == 0 then
		--创建云兰舟
		CreateMonsterWithDir( sceneId, 49568, 181, 45, 3, -1, -1,3.14)
		--创建青丘狐
		local nNPCID = CreateMonsterWithDir( sceneId, 49569, 184, 46, 3, -1, x893020_g_QingQiuHu,3.14)
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_CurQingQiuHuNPCID,nNPCID)
		--创建传送石碑
		CreateMonsterWithDir( sceneId, 49794, x893020_g_PosChuanSong[1], x893020_g_PosChuanSong[2], 3, -1, x893020_g_ChuanSongScript,4.71 )
		--进入置空
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,1)
		--创建初始动阻
		CallScriptFunction(x893020_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,1);
		CallScriptFunction(x893020_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,2);
		CallScriptFunction(x893020_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,3);
		CallScriptFunction(x893020_g_DynamicBlockScriptId, "CreateDynamicBlock", sceneId,4);
		--创建进门口的小狐狸		
		x893020_CreateMonster_SaoDi(sceneId)
	end
end

--**********************************
--副本场景定时器事件
--**********************************
function x893020_OnCopySceneTimer( sceneId, nowTime )
	
	--副本时钟读取及设置 5s一次tick
	TickCount = LuaFnGetCopySceneData_Param(sceneId, 2) ;--取得已经执行的定时次数
	TickCount = TickCount+1 ;
	LuaFnSetCopySceneData_Param(sceneId, 2, TickCount);--设置新的定时器调用次数
	
	--取得当前的逻辑批次
	local nCurMainStep = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep)
--	print("nCurMainStep",nCurMainStep)
	if TickCount == 2 then
		--云兰舟的介绍
		LuaFnNpcTalk(sceneId,123)
	end
	if TickCount == 3 then
		--试炼分为勇气等。。
		LuaFnNpcTalk(sceneId,124)
	end
	--逻辑1为0后置空
	--逻辑2为第一只小狐狸被赶跑后触发
	if nCurMainStep == 2 then
		--青丘狐指引开始走动【废弃】
--		local nQingQiuHuId = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_CurQingQiuHuNPCID)
--		SetPatrolId(sceneId, nQingQiuHuId, 0)
		--进入置空
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,3)
	end
	--逻辑3为2后置空
	--逻辑4为赶走所有扫地狐后触发
	if nCurMainStep == 4 then
		--关闭起始点第一道门禁
		CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
		--青丘狐位置直设
		local nQingQiuHuId = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_CurQingQiuHuNPCID)
		if nQingQiuHuId ~= -1 then
			SetPos(sceneId,nQingQiuHuId,194,131)
		end
		--创建BOSS云卷舒
		x893020_CreateMonster_BOSS_1_NPC(sceneId);
		--逻辑5：等待玩家进入云卷舒范围
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,5)	
	end
	--逻辑6：玩家进入云卷舒范围 可切换BOSS版
	--逻辑7：云卷舒BOSS状态
	if nCurMainStep == 7 then
--		x893020_TipAllHuman( sceneId, "云卷舒目前是可以PK的状态")
	end
	--逻辑8：完成云卷舒击杀 青丘狐走动 等待进入弈的area范围
	--逻辑9：进入弈的area范围 触发对话 
	if nCurMainStep == 9 then
		--进入逻辑10：第二段青丘狐的对话等待
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,10)
	end
	if nCurMainStep == 10 then
		LuaFnNpcTalk(sceneId,127)
		--进入逻辑11：可切换逸BOSS
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,11)
	end
	--逻辑12为切换逻辑，切换出逸BOSS
--	if nCurMainStep == 13 then
--		--创建BOSS逸
--		x893020_CreateMonster_BOSS_2_BOSS(sceneId);
--		--进入置空
--		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,14)
--	end
	--逻辑11：逸BOSS状态
	if nCurMainStep == 11 then
--		x893020_TipAllHuman( sceneId, "逸目前是可以PK的状态")
	end
	--逻辑12：完成逸击杀 青丘狐走动 等待进入艾虎的area范围
	--逻辑13：下一阶段对话
	--逻辑14：玩家可切换艾虎BOSS版
	if nCurMainStep == 13 then
		LuaFnNpcTalk(sceneId,129)
		--进入逻辑11：可切换逸BOSS
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,14)
	end
	--逻辑15: 艾虎BOSS状态
	if nCurMainStep == 15 then
--		x893020_TipAllHuman( sceneId, "艾虎BOSS状态")
	end
	--逻辑16：完成艾虎击杀 青丘狐走动 等待进入九尾狐的area范围
	--逻辑17：进入BOSS区域
	if nCurMainStep == 17 then
		--全场播放进入动画
		x893020_PlayerMovie( sceneId, 0 )
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,18)
	end
	--逻辑18：等待对话【玩家可切换云飘飘BOSS版】
	if nCurMainStep == 18 then
--		x893020_TipAllHuman( sceneId, "云飘飘等待循环")
		--青丘狐的提醒 灵狐大人，这便是试炼者。
		LuaFnNpcTalk(sceneId,130)
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,19)
	end
	--逻辑19：等待对话【玩家可切换云飘飘BOSS版】
	if nCurMainStep == 19 then
		LuaFnNpcTalk(sceneId,131)
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,20)
	end
	--逻辑20: 玩家可切换云飘飘BOSS版
	--逻辑21: 云飘飘BOSS状态
	if nCurMainStep == 21 then
		
	end
	--逻辑22: 击杀全部BOSS
	if nCurMainStep == 22 then
		
	end
	
	--副本关闭标志
	leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	
	if leaveFlag == 1 then --需要离开
		
		--离开倒计时间的读取和设置
		leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5) ;
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount) ;
		
		if leaveTickCount == x893020_g_CloseTick then --倒计时间到，大家都出去吧
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
			
			--将当前副本场景里的所有人传送回原来进入时候的场景
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId, mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then
					NewWorld( sceneId, mems[i], oldsceneId, x893020_g_Back_X, x893020_g_Back_Z )
				end
			end
			
		elseif leaveTickCount<x893020_g_CloseTick then
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号

			--通知当前副本场景里的所有人，场景关闭倒计时间
			x893020_TipAllHuman( sceneId, ScriptGlobal_Format("#{ZSFB_20220105_41}", (x893020_g_CloseTick-leaveTickCount)*x893020_g_TickTime ))
		end
	elseif TickCount == x893020_g_LimitTimeSuccess then
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
		
	elseif TickCount == x893020_g_LimitTotalHoldTime then --副本总时间限制到了
	
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
		
	else 
		--定时检查队伍成员的队伍号，如果不符合，则踢出副本
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId, mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then
			
			end
		end
		
	end
end

--**********************************
-- 清除场景内的XX怪
--**********************************
function x893020_ClearMonsterByName(sceneId, szName)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, nMonsterId)== szName  then
			SetCharacterDieTime( sceneId, nMonsterId, 100 )
--			LuaFnDeleteMonster(sceneId, nMonsterId)
		end
	end
end

--**********************************
-- 清理旧BOSS云飘飘
--**********************************
function x893020_ClearMonster_BOSS_4(sceneId)
	--清理旧的
	x893020_ClearMonsterByName(sceneId, "云飘飘")
	
	local monsterID = x893020_EnterFinalBossProcedure(sceneId)
	if monsterID ~= -1 then
		--说个话
		PaoPaoExEx(sceneId,monsterID, 526)
	end	
end

--**********************************
--最终BOSS死亡
--**********************************
function x893020_OnFinalBossDie(sceneId,selfId)
	--云飘飘被拿下
	x893020_ClearMonster_BOSS_4(sceneId)
	--标记副本结束
	LuaFnSetCopySceneData_Param(sceneId, 4 , 1) ;
	--进入置空
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,22)
	--调整击杀数量
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_CurBOSSID, 4)
	--清理动阻
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,9);
	--生成一个宝箱，具体掉落宝箱控制
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	CallScriptFunction(x893020_g_DropBoxScript[4], "GenerateDropBox",sceneId,nCurPosX,nCurPosZ,nFubenType);

	--其他系统处理
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i=0,membercount-1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then

			if nFubenType == 0 then
				LuaFnFinishZhouHuoYueMission(sceneId,mems[i],30)
				CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, mems[i],CAMPAIGN_QINGQIU)
			else
				LuaFnFinishZhouHuoYueMission(sceneId,mems[i],31)
				CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, mems[i],CAMPAIGN_QINGQIU_DIFF)
			end
			--任务标记完成
			CallScriptFunction(893046,"OnFinish",sceneId, mems[i])
			--云侠赴战
			CallScriptFunction(890289,"OnFinish",sceneId, mems[i],CAMPAIGN_QINGQIU)
			--高光时刻结算
			LuaFnShowCopySceneHigntlight(sceneId,35);
		end
	end
end

--**********************************
-- 云飘飘激活
--**********************************
function x893020_ActiveBOSSYunPiaoPiao(sceneId)
	--进入逻辑19：云飘飘BOSS状态
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,21)
	--清理旧的云飘飘
	x893020_ClearMonsterByName(sceneId, "云飘飘")
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49630,49630,49630,49630,49630,49630,49630,49642,49653,49664,49675},
		[1] = {49686,49686,49686,49686,49686,49686,49697,49708,49719,49730,49741},
	}
	local monsterID = CreateMonsterWithDir( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosBOSS_5[1], x893020_g_PosBOSS_5[2], 21, -1,x893020_g_BOSS_5_NPC_BOSSAI,6.283 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
	end
end

--**********************************
--进入最终BOSS预计逻辑
--**********************************
function x893020_EnterFinalBossProcedure(sceneId)
	--掌门云飘飘生成
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49629,49629,49629,49629,49629,49629,49629,49641,49652,49663,49674},
		[1] = {49685,49685,49685,49685,49685,49685,49696,49707,49718,49729,49740},
	}
	local monsterID = CreateMonsterWithDir( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosBOSS_5[1], x893020_g_PosBOSS_5[2], 3, -1,x893020_g_BOSS_5_NPC,6.283 )
	if monsterID ~= -1 then
		SetCharacterTitle( sceneId, monsterID, "云家掌门" )
		SetLevel( sceneId, monsterID, nFubenLev )
	end	
	
	return monsterID
end

--**********************************
-- 清理旧BOSS艾虎
--**********************************
function x893020_ClearMonster_BOSS_3(sceneId)
	--清理旧的
	x893020_ClearMonsterByName(sceneId, "艾虎")
	
	local monsterID = x893020_CreateMonster_BOSS_3_NPC(sceneId)
	if monsterID ~= -1 then
		--说个话
		PaoPaoExEx(sceneId,monsterID, 524)
	end
end

--**********************************
--艾虎死亡
--**********************************
function x893020_OnBOSSAiHuDie(sceneId,selfId)
	--逻辑16：完成艾虎击杀 青丘狐走动 等待进入九尾狐的area范围
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,16)
	--标记BOSS击杀完成度
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_CurBOSSID, 3)
	--清理艾虎尸体 
	x893020_ClearMonster_BOSS_3(sceneId)
	--进入最终BOSS主逻辑
	x893020_EnterFinalBossProcedure(sceneId)
	--青丘狐指引开始走动
	local nQingQiuHuId = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_CurQingQiuHuNPCID)
	if nQingQiuHuId ~= -1 then
		SetPatrolId(sceneId, nQingQiuHuId, 3)
		PaoPaoExEx(sceneId,nQingQiuHuId, 534)
	end
	--清理动阻
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,4);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,7);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,8);
	--生成一个宝箱，具体掉落宝箱控制
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	CallScriptFunction(x893020_g_DropBoxScript[3], "GenerateDropBox",sceneId,nCurPosX,nCurPosZ,nFubenType);
end
--**********************************
-- 创建BOSS-艾虎
-- 180 123
--**********************************
function x893020_CreateMonster_BOSS_3_BOSS(sceneId)
	--进入逻辑15
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,15)
	--清理旧的艾虎
	x893020_ClearMonsterByName(sceneId, "艾虎")
	
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49628,49628,49628,49628,49628,49628,49628,49640,49651,49662,49673},
		[1] = {49684,49684,49684,49684,49684,49684,49695,49706,49717,49728,49739},
	}
	local monsterID = CreateMonsterWithDir( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosBOSS_3[1], x893020_g_PosBOSS_3[2], 21, -1, x893020_g_BOSS_3_NPC_BOSSAI,0.873 )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
	end
end

--**********************************
-- 创建NPC-艾虎
-- 144 200
--**********************************
function x893020_CreateMonster_BOSS_3_NPC(sceneId)
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49627,49627,49627,49627,49627,49627,49627,49639,49650,49661,49672},
		[1] = {49683,49683,49683,49683,49683,49683,49694,49705,49716,49727,49738},
	}
	local monsterID = CreateMonsterWithDir( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosBOSS_3[1], x893020_g_PosBOSS_3[2], 3, -1,x893020_g_BOSS_3_NPC ,0.873)
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "云家奇才" )
	end
	
	return monsterID
end

--**********************************
-- 清理旧BOSS逸
--**********************************
function x893020_ClearMonster_BOSS_2(sceneId)
	--清理旧的逸
	x893020_ClearMonsterByName(sceneId, "逸")
	--逸本人再次创建
	local monsterID = x893020_CreateMonster_BOSS_2_NPC(sceneId)
	if monsterID ~= -1 then
		--说个话
		PaoPaoExEx(sceneId,monsterID, monsterID)
	end
end
--**********************************
-- 逸死亡
--**********************************
function x893020_OnBOSSYiDie(sceneId,selfId)
	--逻辑12：完成逸击杀 青丘狐走动 等待进入艾虎的area范围
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,12)
	--标记BOSS击杀完成度
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_CurBOSSID, 2)
	--清理旧BOSS逸
	x893020_ClearMonster_BOSS_2(sceneId)
	--创建下一个BOSS
	x893020_CreateMonster_BOSS_3_NPC(sceneId);
	--青丘狐指引开始走动
	local nQingQiuHuId = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_CurQingQiuHuNPCID)
	if nQingQiuHuId ~= -1 then
		SetPatrolId(sceneId, nQingQiuHuId, 2)
		PaoPaoExEx(sceneId,nQingQiuHuId, 531)
	end
	--清理动阻
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,3);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,6);
	--生成一个宝箱，具体掉落宝箱控制
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	CallScriptFunction(x893020_g_DropBoxScript[2], "GenerateDropBox",sceneId,nCurPosX,nCurPosZ,nFubenType);
end
--**********************************
-- 创建BOSS-逸
-- 180 123
--**********************************
function x893020_CreateMonster_BOSS_2_BOSS(sceneId)
	--进入逻辑11
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,11)
	--清理旧的逸
	x893020_ClearMonsterByName(sceneId, "逸")
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49626,49626,49626,49626,49626,49626,49626,49638,49649,49660,49671},
		[1] = {49682,49682,49682,49682,49682,49682,49693,49704,49715,49726,49737},
	}
	local monsterID = LuaFnCreateMonster( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosBOSS_2[1], x893020_g_PosBOSS_2[2], 21, -1, x893020_g_BOSS_2_NPC_BOSSAI )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
	end	
end

--**********************************
-- 创建NPC-逸
--**********************************
function x893020_CreateMonster_BOSS_2_NPC(sceneId)
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49625,49625,49625,49625,49625,49625,49625,49637,49648,49659,49670},
		[1] = {49681,49681,49681,49681,49681,49681,49692,49703,49714,49725,49736},
	}
	
	local monsterID = LuaFnCreateMonster( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosBOSS_2[1], x893020_g_PosBOSS_2[2], 3, -1,x893020_g_BOSS_2_NPC )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "云家客卿" )
	end
	
	return monsterID
end

--**********************************
-- 清理旧BOSS云卷舒
--**********************************
function x893020_ClearMonster_BOSS_1(sceneId)
	--清理旧的云卷舒
	x893020_ClearMonsterByName(sceneId, "云卷舒")
	--云卷舒本人再次创建
	local monsterID = x893020_CreateMonster_BOSS_1_NPC(sceneId)
	if monsterID ~= -1 then
		--说个话
		PaoPaoExEx(sceneId,monsterID, 522)
	end
end

--**********************************
-- 云卷舒死亡
--**********************************
function x893020_OnYunJuanShuDie(sceneId,selfId)
	--逻辑8：完成云卷舒击杀 青丘狐走动 等待进入弈的area范围
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,8)
	--标记BOSS击杀完成度
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_CurBOSSID, 1)
	--清理旧的BOSS云卷舒
	x893020_ClearMonster_BOSS_1(sceneId);
	--创建BOSS NPC 逸
	x893020_CreateMonster_BOSS_2_NPC(sceneId);
	--青丘狐指引开始走动
	local nQingQiuHuId = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_CurQingQiuHuNPCID)
	if nQingQiuHuId ~= -1 then
		SetPatrolId(sceneId, nQingQiuHuId, 1)
		PaoPaoExEx(sceneId,nQingQiuHuId, 529)
	end
	--清理动阻
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,1);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,2);
	CallScriptFunction(x893020_g_DynamicBlockScriptId, "ReleaseDynamicRegion", sceneId,5);
	--生成一个宝箱，具体掉落宝箱控制
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	CallScriptFunction(x893020_g_DropBoxScript[1], "GenerateDropBox",sceneId,nCurPosX,nCurPosZ,nFubenType);
end

--**********************************
-- 创建BOSS-云卷舒
-- 180 123
--**********************************
function x893020_CreateMonster_BOSS_1_BOSS(sceneId)
	--进入逻辑7
	LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,7)
	--清理旧的云卷舒
	x893020_ClearMonsterByName(sceneId, "云卷舒")
	
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49624,49624,49624,49624,49624,49624,49624,49636,49647,49658,49669},
		[1] = {49680,49680,49680,49680,49680,49680,49691,49702,49713,49724,49735},
	}
	local monsterID = LuaFnCreateMonster( sceneId,tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosYunJuanShu[1], x893020_g_PosYunJuanShu[2], 27, 0, x893020_g_BOSS_1_NPC_BOSSAI )
	if monsterID ~= -1 then
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_BOSS_1_ObjId,monsterID)
		SetLevel( sceneId, monsterID, nFubenLev )
		SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
	end
end

--**********************************
-- 创建NPC-云卷舒
--**********************************
function x893020_CreateMonster_BOSS_1_NPC(sceneId)
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tMonsterDataId = 
	{
		[0] = {49623,49623,49623,49623,49623,49623,49623,49635,49646,49657,49668},
		[1] = {49679,49679,49679,49679,49679,49679,49690,49701,49712,49723,49734},
	}
	--云卷舒
	local monsterID = LuaFnCreateMonster( sceneId, tMonsterDataId[nFubenType][nFubenInitLev], x893020_g_PosYunJuanShu[1], x893020_g_PosYunJuanShu[2], 3, -1,x893020_g_BOSS_1_NPC )
	if monsterID ~= -1 then
		SetLevel( sceneId, monsterID, nFubenLev )
		SetCharacterTitle( sceneId, monsterID, "云家戍卫总领" )
	end
	return monsterID
end

--**********************************
-- 有Monster死亡
--**********************************
function x893020_OnDie(sceneId, selfId, killerId )
	if GetName(sceneId,selfId) == "扫地狐" then
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_SaoDiKillNum);--扫地狐杀死的数量
		if nCurKill == 0 then
			--第一只小狐狸被赶跑
			LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,2)
		end
		nCurKill = nCurKill + 1
		--已赶跑扫地狐
		x893020_TipAllHuman( sceneId, ScriptGlobal_Format("#{ZSFB_20220105_113}",tostring(nCurKill)) )
		if nCurKill >= 10 then
			x893020_TipAllHuman( sceneId, "#{ZSFB_20220105_114}")
			--进入扫地狐清空后逻辑
			LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_MainStep,4)
		end
		--更新扫地狐杀死的数量
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_SaoDiKillNum, nCurKill) ;
	end
	if GetCharacterTitle(sceneId,selfId) == "阴" then
		local nCurType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_BOSS_2_WillKillType);
		if nCurType ~= 0 then
			return
		end
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_BOSS_2_WillKillNum);
		nCurKill = nCurKill + 1
		--当前击败黑狐%s0/12个。	
		x893020_TipAllHuman( sceneId, ScriptGlobal_Format("#{ZSFB_20220105_149}",tostring(nCurKill)) )
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_BOSS_2_WillKillNum, nCurKill) ;
	elseif GetCharacterTitle(sceneId,selfId) == "阳" then
		if nCurType ~= 1 then
			return
		end
		local nCurKill = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_BOSS_2_WillKillNum);
		nCurKill = nCurKill + 1
		--当前击败白狐%s0/12个。	
		x893020_TipAllHuman( sceneId, ScriptGlobal_Format("#{ZSFB_20220105_150}",tostring(nCurKill)) )
		LuaFnSetCopySceneData_Param(sceneId, x893020_g_SceneData_BOSS_2_WillKillNum, nCurKill) ;
	end
	if GetName(sceneId,selfId) == "灵狐守护" then
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,i)
			if GetName(sceneId, nMonsterId)== "云飘飘"  then
				--标记灵狐守护被杀
				MonsterAI_SetBoolParamByIndex(sceneId,nMonsterId,2,1)
				CallScriptFunction(x893020_g_BOSS_5_NPC_BOSSAI, "UseSkill_LingHuShouHuActive", sceneId,nMonsterId);
			end
		end
	end
end

--**********************************
-- 创建扫地狐
--**********************************
function x893020_CreateMonster_SaoDi(sceneId)
	local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Type) ;--副本类型 0-普通 1-困难
	local nFubenInitLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_InitLevel)
	local nFubenLev = LuaFnGetCopySceneData_Param(sceneId, x893020_g_SceneData_Level)
	--nFubenLev:8-11
	local tFoxAttrId = 
	{
		[0] = {49767,49767,49767,49767,49767,49767,49767,49768,49769,49770,49771},
		[1] = {49772,49772,49772,49772,49772,49772,49773,49774,49775,49776,49777},
	}
	for i = 1, getn( x893020_g_SaoDiFoxPos ) do
		local nMonsterDataId = tFoxAttrId[nFubenType][nFubenInitLev]
		local monsterID = CreateMonsterWithDir( sceneId, nMonsterDataId, x893020_g_SaoDiFoxPos[i].x, x893020_g_SaoDiFoxPos[i].z, 28, -1,x893020_g_ScriptId,x893020_g_SaoDiFoxPos[i].dir )
		if monsterID ~= -1 then
			SetUnitCampID(sceneId,monsterID, monsterID, 110)
			SetMonsterFightWithNpcFlag(sceneId, monsterID, 1)
			SetLevel(sceneId,monsterID,nFubenLev)
		end
	end
end

--**********************************
-- 获取本副本的MonsterID
--**********************************
function x893020_GetFubenMonsterDataId(sceneId,selfId,nIndex)
	if nIndex == 1 then
		return 49669,0
	elseif nIndex == 2 then
		return 49671,0
	elseif nIndex == 3 then
		return 49673,0
	elseif nIndex == 4 then
		return 49675,1
	end
end

--**********************************
--副本里的所有玩家播放动画
--**********************************
function x893020_PlayerMovie( sceneId, nMovieId )
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
function x893020_TipAllHuman( sceneId, Str )
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
function x893020_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId,  msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--场景通知事件
--**********************************
function x893020_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

