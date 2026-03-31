--武道 残影切磋副本

x891288_g_ScriptId = 891288;				-- 脚本号

x891288_g_CopySceneName = "参武切磋";		-- 副本名称
x891288_g_TickElapse = 1;					-- 回调脚本的时钟时间（单位：秒/次）
x891288_g_LimitTickCount = 500;				-- 副本心跳次数限制（单位：次数）
x891288_g_CloseTick = 5;					-- 副本关闭前倒计时心跳次数（单位：次数）
x891288_g_NoUserTime = 15;					-- 副本中没有人后可以继续保存的时间（单位：秒）

x891288_g_MissionId = 2034
--任务参数
x891288_g_IsMissionOkFail = 0--是否完成
x891288_g_MissionLiuPai = 1-- 流派
x891288_g_MissionMenPai = 2-- 门派
x891288_g_Param_MPIndex = 3--目标门派索引
x891288_g_Param_Custom = 4--完成情况
--副本入口NPC
x891288_g_NpcList = 
{
	[MP_SHAOLIN] = { mpname="#{XLRW_210725_43}", NPCName = "玄澄", },--少林
	[MP_MINGJIAO] = { mpname="#{XLRW_210725_38}", NPCName = "方腊", },--明教
	[MP_GAIBANG] = { mpname="#{XLRW_210725_39}", NPCName = "佛印", },--丐帮
	[MP_WUDANG] = { mpname="#{XLRW_210725_40}", NPCName = "林灵素", },--武当
	[MP_EMEI] = { mpname="#{XLRW_210725_35}", NPCName = "孟青青", },--峨嵋
	[MP_XINGSU] = { mpname="#{XLRW_210725_41}", NPCName = "红玉", },--星宿
	[MP_DALI] = { mpname="#{XLRW_210725_42}", NPCName = "本相", },--天龙
	[MP_TIANSHAN] = { mpname="#{XLRW_210725_36}", NPCName = "菊剑", },--天山
	[MP_XIAOYAO] = { mpname="#{XLRW_210725_37}", NPCName = "冯阿三", },--逍遥
	[MP_MANTUO] = { mpname="#{XLRW_210725_741}", NPCName = "王叠涓", },--曼陀
}
--副本配置
x891288_g_MenpaiInfo = {
	[0] = { Name = "少林",		Type = FUBEN_CANWUQIECUO,		Map = "tongrenxiang_3.path",		Exit = "tongrenxiang_3_area.ini",	Monster = "tongrenxiang_3_monster_%d.ini", 	EntrancePos = { x = 28, z = 52 },},
	[1] = { Name = "明教",		Type = FUBEN_CANWUQIECUO,		Map = "guangmingdong_3.path",	Exit = "guangmingdong_3_area.ini",	Monster = "guangmingdong_3_monster_%d.ini", EntrancePos = { x = 19, z = 42 },},
	[2] = { Name = "丐帮",		Type = FUBEN_CANWUQIECUO,		Map = "jiujiao_3.path",			Exit = "jiujiao_3_area.ini",		Monster = "jiujiao_3_monster_%d.ini", 		EntrancePos = { x = 45, z = 47 },},
	[3] = { Name = "武当",		Type = FUBEN_CANWUQIECUO,		Map = "lingxingfeng_3.path",		Exit = "lingxingfeng_3_area.ini",	Monster = "lingxingfeng_3_monster_%d.ini", 	EntrancePos = { x = 42, z = 46 },},
	[4] = { Name = "峨嵋",		Type = FUBEN_CANWUQIECUO,		Map = "taohuazhen_3.path",		Exit = "taohuazhen_3_area.ini",		Monster = "taohuazhen_3_monster_%d.ini", 	EntrancePos = { x = 26, z = 46 },},	
	[5] = { Name = "星宿",		Type = FUBEN_CANWUQIECUO,		Map = "wushendong_3.path",		Exit = "wushendong_3_area.ini",		Monster = "wushendong_3_monster_%d.ini", 	EntrancePos = { x = 14, z = 40 },},
	[6] = { Name = "天龙寺",	Type = FUBEN_CANWUQIECUO,		Map = "tadi_3.path",				Exit = "tadi_3_area.ini",			Monster = "tadi_3_monster_%d.ini", 			EntrancePos = { x = 45, z = 48 },},
	[7] = { Name = "天山",		Type = FUBEN_CANWUQIECUO,		Map = "zhemeifeng_3.path",		Exit = "zhemeifeng_3_area.ini",		Monster = "zhemeifeng_3_monster_%d.ini", 	EntrancePos = { x = 29, z = 49 },},
	[8] = { Name = "逍遥",		Type = FUBEN_CANWUQIECUO,		Map = "gudi_3.path",				Exit = "gudi_3_area.ini",			Monster = "gudi_3_monster_%d.ini", 			EntrancePos = { x = 42, z = 47 },},
	[10] = { Name = "曼陀山庄",	Type = FUBEN_CANWUQIECUO,		Map = "mantuofb_3.path",			Exit = "mantuofb_3_area.ini",		Monster = "mantuofb_3_monster_%d.ini", 		EntrancePos = { x = 30, z = 30 },},
}
x891288_g_npcList = {		
	[0] = { MonsterName = "少林残影", NPCName = "#{XLRW_210725_76}", mpname="#{XLRW_210725_43}", },--少林
	[1] = { MonsterName = "明教残影", NPCName = "#{XLRW_210725_80}", mpname="#{XLRW_210725_38}", },--明教
	[2] = { MonsterName = "丐帮残影", NPCName = "#{XLRW_210725_78}", mpname="#{XLRW_210725_39}", },--丐帮
	[3] = { MonsterName = "武当残影", NPCName = "#{XLRW_210725_82}", mpname="#{XLRW_210725_40}", },--武当
	[4] = { MonsterName = "峨嵋残影", NPCName = "#{XLRW_210725_88}", mpname="#{XLRW_210725_35}", },--峨嵋
	[5] = { MonsterName = "星宿残影", NPCName = "#{XLRW_210725_90}", mpname="#{XLRW_210725_41}", },--星宿
	[6] = { MonsterName = "天龙残影", NPCName = "#{XLRW_210725_84}", mpname="#{XLRW_210725_42}", },--天龙
	[7] = { MonsterName = "天山残影", NPCName = "#{XLRW_210725_92}", mpname="#{XLRW_210725_36}", },--天山
	[8] = { MonsterName = "逍遥残影", NPCName = "#{XLRW_210725_86}", mpname="#{XLRW_210725_37}", },--逍遥
	[10] = { MonsterName = "曼陀残影", NPCName = "#{XLRW_210725_755}", mpname="#{XLRW_210725_741}", },--曼陀
}
--**********************************
--列举事件
--**********************************
function x891288_OnEnumerate( sceneId, selfId, targetId )
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891288_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891288_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891288_g_IsMissionOkFail)
	if misOk == 0 then
		local nMPIndex = GetMissionParam(sceneId,selfId,misIndex,x891288_g_Param_MPIndex)
		if x891288_g_NpcList[nMPIndex] == nil then
			return
		end
		if GetName(sceneId,targetId) ~= x891288_g_NpcList[nMPIndex].NPCName then
			return
		end
		AddNumText(sceneId,x891288_g_ScriptId,"#{XLRW_210725_174}",10,1);
	end
end

--**********************************
--任务入口函数
--**********************************
function x891288_OnDefaultEvent( sceneId, selfId, targetId )
	if GetNumText() ~= 1 then
		return
	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891288_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891288_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891288_g_IsMissionOkFail)
	if misOk ~= 0 then
		--任务完成就不允许进去了
		return
	end
	--开启副本等操作
	local nMPIndex = GetMissionParam( sceneId, selfId, misIndex, x891288_g_Param_MPIndex )
	if x891288_g_NpcList[nMPIndex] == nil then
		return
	end
	if GetName(sceneId,targetId) ~= x891288_g_NpcList[nMPIndex].NPCName then
		return
	end
	--初始化副本
	local MenpaiInfo = x891288_g_MenpaiInfo[nMPIndex]
	if not MenpaiInfo then
		x891288_NotifyTips( sceneId, selfId, "严重错误！" )
		return
	end
	local leaderguid = LuaFnObjId2Guid( sceneId, selfId )
	LuaFnSetSceneLoad_Map( sceneId, MenpaiInfo.Map )						--地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader( sceneId, leaderguid )
	LuaFnSetCopySceneData_NoUserCloseTime( sceneId, x891288_g_NoUserTime * 1000 )
	LuaFnSetCopySceneData_Timer( sceneId, x891288_g_TickElapse * 1000 )
	LuaFnSetCopySceneData_Param( sceneId, 0, MenpaiInfo.Type )				--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param( sceneId, 1, x891288_g_ScriptId )					--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param( sceneId, 2, 0 )							--设置定时器调用次数
	LuaFnSetCopySceneData_Param( sceneId, 3, -1 )							--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param( sceneId, 4, 0 )							--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param( sceneId, 5, 0 )							--设置离开倒计时次数
	LuaFnSetCopySceneData_Param( sceneId, 6, nMPIndex )						--标示这是第几个场景
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
	LuaFnSetSceneLoad_Monster( sceneId, format(MenpaiInfo.Monster,iniLevel) );

	local bRetSceneID = LuaFnCreateCopyScene( sceneId )						--初始化完成后调用创建副本函数
	if bRetSceneID > 0 then
		x891288_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_700}",x891288_g_NpcList[nMPIndex].mpname));
	else
		x891288_NotifyTips( sceneId, selfId, "#{XLRW_210725_160}" )
	end
end

--**********************************
--副本事件
--**********************************
function x891288_OnCopySceneReady(sceneId, destsceneId)
	LuaFnSetCopySceneData_Param( destsceneId, 3, sceneId )					--设置副本入口场景号

	local leaderguid = LuaFnGetCopySceneData_TeamLeader( destsceneId )
	local leaderObjId = LuaFnGuid2ObjId( sceneId, leaderguid )

	if leaderObjId == -1 then
		return
	end

	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then			-- 处于无法执行逻辑的状态
		return
	end

	if IsHaveMission( sceneId, leaderObjId, x891288_g_MissionId ) > 0 then			--有任务才可以走这里
		local misIndex = GetMissionIndexByID( sceneId, leaderObjId, x891288_g_MissionId )
		local MenpaiIndex = GetMissionParam( sceneId, leaderObjId, misIndex, x891288_g_Param_MPIndex )
		local MenpaiInfo = x891288_g_MenpaiInfo[MenpaiIndex]
		if not MenpaiInfo then
			x891288_NotifyTips( sceneId, leaderObjId, "严重错误！" )
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
function x891288_OnPlayerEnter(sceneId, selfId)
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891288_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891288_g_MissionId)
	local nMPIndex = GetMissionParam( sceneId, selfId, misIndex, x891288_g_Param_MPIndex )
	--XLRW_210725_701	请少侠在此中击败%s0，以修武道。
	--找到指引人
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, nMonsterId)== "门派传送指引人" then
			MonsterTalk(sceneId, nMonsterId, x891288_g_npcList[nMPIndex].mpname, ScriptGlobal_Format("#{XLRW_210725_701}",x891288_g_npcList[nMPIndex].MonsterName))
			return
		end
	end
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x891288_OnHumanDie(sceneId, selfId, killerId)
end

--**********************************
--副本场景定时器事件
--**********************************
function x891288_OnCopySceneTimer(sceneId, nowTime)
	
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
		
		if leaveTickCount > x891288_g_CloseTick or leaveTickCount == x891288_g_CloseTick then --倒计时间到，大家都出去吧
		
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
			
		elseif leaveTickCount < x891288_g_CloseTick then
		
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号

			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
			local mems = {};
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
				x891288_NotifyTips(sceneId, mems[i], ScriptGlobal_Format("#{XLRW_210725_162}",tostring((x891288_g_CloseTick-leaveTickCount)*x891288_g_TickElapse)));
			end
		end

	elseif tickCount > x891288_g_LimitTickCount or tickCount == x891288_g_LimitTickCount then
		LuaFnSetCopySceneData_Param(sceneId, 4, 1);
		return
	end
end

--**********************************
--屏幕中心信息提示
--**********************************
function x891288_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end

--**********************************
--对话窗口信息提示
--**********************************
function x891288_MessageBox(sceneId, selfId, targetId, msg)
	BeginEvent(sceneId);
		AddText(sceneId, msg);
	EndEvent(sceneId);
	DispatchEventList(sceneId, selfId, targetId);
end
