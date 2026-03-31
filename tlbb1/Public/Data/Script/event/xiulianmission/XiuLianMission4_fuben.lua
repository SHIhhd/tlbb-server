--武道天赋副本

x891287_g_ScriptId = 891287;				-- 脚本号

x891287_g_CopySceneName = "门派恶痞";		-- 副本名称
x891287_g_TickElapse = 1;					-- 回调脚本的时钟时间（单位：秒/次）
x891287_g_LimitTickCount = 500;				-- 副本心跳次数限制（单位：次数）
x891287_g_CloseTick = 5;					-- 副本关闭前倒计时心跳次数（单位：次数）
x891287_g_NoUserTime = 15;					-- 副本中没有人后可以继续保存的时间（单位：秒）

x891287_g_MissionId = 2033
--任务参数
x891287_g_IsMissionOkFail = 0--是否完成
x891287_g_MissionLiuPai = 1-- 流派
x891287_g_MissionMenPai = 2-- 门派
x891287_g_Param_NpcIndex = 3--目标Npc组索引
x891287_g_Param_Custom1 = 4--完成情况
x891287_g_Param_Custom2 = 5--完成情况
--副本入口NPC
x891287_g_NpcList = 
{
	[0] = { mpname="#{XLRW_210725_43}", npcname = "玄证", },--少林
	[1] = { mpname="#{XLRW_210725_38}", npcname = "石刚", },--明教
	[2] = { mpname="#{XLRW_210725_39}", npcname = "欧阳果", },--丐帮
	[3] = { mpname="#{XLRW_210725_40}", npcname = "萧天逸", },--武当
	[4] = { mpname="#{XLRW_210725_35}", npcname = "柳三妹", },--峨嵋
	[5] = { mpname="#{XLRW_210725_41}", npcname = "天璇子", },--星宿
	[6] = { mpname="#{XLRW_210725_42}", npcname = "本名", },--天龙
	[7] = { mpname="#{XLRW_210725_36}", npcname = "邓婆", },--天山
	[8] = { mpname="#{XLRW_210725_37}", npcname = "公冶子长", },--逍遥
	[10] = { mpname="#{XLRW_210725_741}", npcname = "王律之", },--曼陀
}
--副本配置
x891287_g_MenpaiInfo = {
	[0] = { Name = "少林",		Type = FUBEN_MENPAIEPI,		Map = "shaolin_3.path",		Monster = "shaolin_3_monster_%d_%d.ini", 	EntrancePos = { x = 125, z = 122 },},
	[1] = { Name = "明教",		Type = FUBEN_MENPAIEPI,		Map = "mingjiao_3.path",		Monster = "mingjiao_3_monster_%d_%d.ini", 	EntrancePos = { x = 98, z = 78 },},	
	[2] = { Name = "丐帮",		Type = FUBEN_MENPAIEPI,		Map = "gaibang_3.path",		Monster = "gaibang_3_monster_%d_%d.ini", 	EntrancePos = { x = 91, z = 123 },},
	[3] = { Name = "武当",		Type = FUBEN_MENPAIEPI,		Map = "wudang_3.path",		Monster = "wudang_3_monster_%d_%d.ini", 	EntrancePos = { x = 78, z = 104 },},
	[4] = { Name = "峨嵋",		Type = FUBEN_MENPAIEPI,		Map = "emei_3.path",			Monster = "emei_3_monster_%d_%d.ini", 		EntrancePos = { x = 145, z = 56 },},	
	[5] = { Name = "天龙寺",	Type = FUBEN_MENPAIEPI,		Map = "tianlong_3.path",		Monster = "tianlong_3_monster_%d_%d.ini", 	EntrancePos = { x = 95, z = 93 },},	
	[6] = { Name = "星宿",		Type = FUBEN_MENPAIEPI,		Map = "xingxiu_3.path",		Monster = "xingxiu_3_monster_%d_%d.ini", 	EntrancePos = { x = 95, z = 102 },},
	[7] = { Name = "天山",		Type = FUBEN_MENPAIEPI,		Map = "tianshan_3.path",		Monster = "tianshan_3_monster_%d_%d.ini", 	EntrancePos = { x = 95, z = 58 },},
	[8] = { Name = "逍遥",		Type = FUBEN_MENPAIEPI,		Map = "xiaoyao_3.path",		Monster = "xiaoyao_3_monster_%d_%d.ini", 	EntrancePos = { x = 121, z = 105 },},
	[10] = { Name = "曼陀山庄",		Type = FUBEN_MENPAIEPI,		Map = "mantuo_3.path",		Monster = "mantuo_3_monster_%d_%d.ini", 	EntrancePos = { x = 139, z = 142 },},
}

--**********************************
--列举事件
--**********************************
function x891287_OnEnumerate( sceneId, selfId, targetId )
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891287_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891287_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891287_g_IsMissionOkFail)
	if misOk == 0 then
		local MenpaiIndex = GetMissionParam(sceneId,selfId,misIndex,x891287_g_MissionMenPai);
		if x891287_g_NpcList[MenpaiIndex] == nil then
			return
		end
		if GetName(sceneId,targetId) ~= x891287_g_NpcList[MenpaiIndex].npcname then
			return
		end
		AddNumText(sceneId,x891287_g_ScriptId,"#{XLRW_210725_151}",10,1);
	end
end

--**********************************
--任务入口函数
--**********************************
function x891287_OnDefaultEvent( sceneId, selfId, targetId )
	if GetNumText() ~= 1 then
		return
	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891287_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891287_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891287_g_IsMissionOkFail)
	if misOk ~= 0 then
		--任务完成就不允许进去了
		return
	end
	--开启副本等操作
	local MenpaiIndex = GetMissionParam(sceneId,selfId,misIndex,x891287_g_MissionMenPai);
	if x891287_g_NpcList[MenpaiIndex] == nil then
		return
	end
	if GetName(sceneId,targetId) ~= x891287_g_NpcList[MenpaiIndex].npcname then
		return
	end
	--初始化副本
	local MenpaiInfo = x891287_g_MenpaiInfo[MenpaiIndex]
	if not MenpaiInfo then
		x891287_NotifyTips( sceneId, selfId, "严重错误！" )
		return
	end
	local misMonsterIdx = GetMissionParam(sceneId,selfId,misIndex,x891287_g_Param_NpcIndex);
	local leaderguid = LuaFnObjId2Guid( sceneId, selfId )
	LuaFnSetSceneLoad_Map( sceneId, MenpaiInfo.Map )						--地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader( sceneId, leaderguid )
	LuaFnSetCopySceneData_NoUserCloseTime( sceneId, x891287_g_NoUserTime * 1000 )
	LuaFnSetCopySceneData_Timer( sceneId, x891287_g_TickElapse * 1000 )
	LuaFnSetCopySceneData_Param( sceneId, 0, MenpaiInfo.Type )				--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param( sceneId, 1, x891287_g_ScriptId )					--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param( sceneId, 2, 0 )							--设置定时器调用次数
	LuaFnSetCopySceneData_Param( sceneId, 3, -1 )							--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param( sceneId, 4, 0 )							--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param( sceneId, 5, 0 )							--设置离开倒计时次数
	LuaFnSetCopySceneData_Param( sceneId, 6, MenpaiIndex )					--标示这是第几个场景
	LuaFnSetCopySceneData_Param( sceneId, 7, 0 )							--进入副本的位置X
	LuaFnSetCopySceneData_Param( sceneId, 8, 0 )							--进入副本的位置Z

	--起始的判定等级是60级，等级为60-110
	--计算等级段....
	local mylevel = GetLevel( sceneId, selfId )
	local PlayerMaxLevel = GetHumanMaxLevelLimit()
	local iniLevel
	if mylevel <= 60 then
		iniLevel = 60
	elseif mylevel < PlayerMaxLevel then
		iniLevel = floor(mylevel/10) * 10
	else
		iniLevel = 60
	end

	LuaFnSetSceneLoad_Area( sceneId, MenpaiInfo.Exit )
	LuaFnSetSceneLoad_Monster( sceneId, format(MenpaiInfo.Monster,misMonsterIdx,iniLevel) );

	local bRetSceneID = LuaFnCreateCopyScene( sceneId )						--初始化完成后调用创建副本函数
	if bRetSceneID > 0 then
		x891287_NotifyTips(sceneId, selfId, "#{XLRW_210725_699}");
	else
		x891287_NotifyTips( sceneId, selfId, "#{XLRW_210725_160}" )
	end
end

--**********************************
--副本事件
--**********************************
function x891287_OnCopySceneReady(sceneId, destsceneId)
	LuaFnSetCopySceneData_Param( destsceneId, 3, sceneId )					--设置副本入口场景号

	local leaderguid = LuaFnGetCopySceneData_TeamLeader( destsceneId )
	local leaderObjId = LuaFnGuid2ObjId( sceneId, leaderguid )

	if leaderObjId == -1 then
		return
	end

	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then			-- 处于无法执行逻辑的状态
		return
	end

	if IsHaveMission( sceneId, leaderObjId, x891287_g_MissionId ) > 0 then			--有任务才可以走这里
		local misIndex = GetMissionIndexByID( sceneId, leaderObjId, x891287_g_MissionId )
		local MenpaiIndex = GetMissionParam( sceneId, leaderObjId, misIndex, x891287_g_MissionMenPai )
		local MenpaiInfo = x891287_g_MenpaiInfo[MenpaiIndex]
		if not MenpaiInfo then
			x891287_NotifyTips( sceneId, leaderObjId, "严重错误！" )
			return
		end
		local PlayerX = GetHumanWorldX(sceneId,leaderObjId)
		local PlayerY = GetHumanWorldZ(sceneId,leaderObjId)
		--设置副本的入口位置
		LuaFnSetCopySceneData_Param( destsceneId, 7, PlayerX )					
		LuaFnSetCopySceneData_Param( destsceneId, 8, PlayerY )

		NewWorld( sceneId, leaderObjId, destsceneId, MenpaiInfo.EntrancePos.x, MenpaiInfo.EntrancePos.z )
	end
	
end

--**********************************
--有玩家进入副本事件
--**********************************
function x891287_OnPlayerEnter(sceneId, selfId)
	
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x891287_OnHumanDie(sceneId, selfId, killerId)
end

--**********************************
--副本场景定时器事件
--**********************************
function x891287_OnCopySceneTimer(sceneId, nowTime)
	
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
		
		if leaveTickCount > x891287_g_CloseTick or leaveTickCount == x891287_g_CloseTick then --倒计时间到，大家都出去吧
		
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
			
		elseif leaveTickCount < x891287_g_CloseTick then
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号

			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
			local mems = {};
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				x891287_NotifyTips(sceneId, mems[i], ScriptGlobal_Format("#{XLRW_210725_162}",tostring((x891287_g_CloseTick-leaveTickCount)*x891287_g_TickElapse)));
			end
		end

	elseif tickCount > x891287_g_LimitTickCount or tickCount == x891287_g_LimitTickCount then
		LuaFnSetCopySceneData_Param(sceneId, 4, 1);
		return
	end
end

--**********************************
--屏幕中心信息提示
--**********************************
function x891287_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end

--**********************************
--对话窗口信息提示
--**********************************
function x891287_MessageBox(sceneId, selfId, targetId, msg)
	BeginEvent(sceneId);
		AddText(sceneId, msg);
	EndEvent(sceneId);
	DispatchEventList(sceneId, selfId, targetId);
end
