--MisDescBegin

-- 脚本号
x402048_g_ScriptId 				= 402048

--角色活跃值副本的index
x402048_g_activePointIndex = 14

---- 任务号
x402048_g_MissionId 			= 1146					--杀星任务

---- 任务目标 NPC
x402048_g_Name 				= "枯荣大师"

--任务归类
x402048_g_MissionKind 		= 8

--接取任务的最低等级
x402048_g_minLevel 			= 70
x402048_g_minXinFaLevel		= 45

x402048_g_MissionLevel		= 10000

-- 任务文本描述
x402048_g_MissionName 		= "#{SXRW_090119_002}"
x402048_g_MissionInfo 		= ""										-- 任务描述
x402048_g_MissionTarget 	= "#{SXRW_090119_139}"						-- 任务目标
x402048_g_SubmitInfo 		= "#{SXRW_090119_042}"						-- 提交时的答复
x402048_g_AcceptInfo 		= "#{SXRW_090119_014}"						-- 接受任务是的答复
x402048_g_MissionComplete 	= "#{SXRW_090119_042}"					 	-- 完成任务npc说的话

x402048_g_IsMissionOkFail = 0			-- 0号索引：当前任务是否完成(0未完成；1完成；2失败)
x402048_g_KillMonsterNum 	= 1			-- 1号索引：杀十二煞星的个数
x402048_g_Param_sceneid 	= 2			-- 2号索引：当前任务数据的2位置设置为场景ID
--~ x402048_g_Parameter_Kill_CountRandom = { { id = 1700152, numNeeded = 6, numKilled = 1 } }
x402048_g_Custom	= { {id="已完成杀星任務",num=1} }

--MisDescEnd
--************************************************************************

x402048_g_CopySceneType=FUBEN_SHAXING	--副本类型，定义在ScriptGlobal.lua里面
x402048_g_LimitMembers = 1			--可以进副本的最小队伍人数
x402048_g_TickTime = 1				--回调脚本的时钟时间（单位：秒/次）
x402048_g_LimitTotalHoldTime=3000	--副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败
x402048_g_LimitTimeSuccess=500		--副本时间限制（单位：次数），如果此时间到了，任务完成
x402048_g_CloseTick=300				--副本关闭前倒计时（单位：次数）
x402048_g_NoUserTime=10			--副本中没有人后可以继续保存的时间（单位：秒）
x402048_g_DeadTrans=0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x402048_g_Fuben_X=13				--进入副本的位置X
x402048_g_Fuben_Z=33				--进入副本的位置Z
x402048_g_Back_X=130				--源场景位置X
x402048_g_Back_Z=77					--源场景位置Z
--十二煞星怪物池定义
x402048_g_BossName = {"宋姜","李魁","吴永","卢君逸","公孙圣","关盛","鲁志生","呼延啄","林充","秦冥","花容","武颂"}
x402048_g_BossScript = {402309,402315,402307,402314,402319,402316,402313,402311,402312,402317,402310,402318}
x402048_g_NpcID = {13550,13551,13552,13553,13554,13555,13556,13557,13558,13559,13560,13561}
x402048_g_BossTitle = {"天魁星","天杀星","天机星","天罡星","天闲星","天勇星","天孤星","天威星","天雄星","天猛星","天英星","天伤星"}
x402048_g_BossID = {}
x402048_g_BossID[70] = {13433,13442,13451,13460,13469,13478,13487,13496,13505,13514,13523,13532}
x402048_g_BossID[80] = {13434,13443,13452,13461,13470,13479,13488,13497,13506,13515,13524,13533}
x402048_g_BossID[90] = {13435,13444,13453,13462,13471,13480,13489,13498,13507,13516,13525,13534}
x402048_g_BossID[100] = {13436,13445,13454,13463,13472,13481,13490,13499,13508,13517,13526,13535}
x402048_g_BossID[110] = {13437,13446,13455,13464,13473,13482,13491,13500,13509,13518,13527,13536}
x402048_g_BossID[120] = {13438,13447,13456,13465,13474,13483,13492,13501,13510,13519,13528,13537}
--小怪
x402048_g_DogID = {13541,13542,13543,13544,13545,13546}
--怪物开启标记
x402048_g_MissBoss = {8,9,10,11,12,13}
--**********************************
--任务入口函数
--**********************************
function x402048_OnDefaultEvent( sceneId, selfId, targetId )
	local nNumText = GetNumText();
	--local nAddMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_COUNT)
	local nAddMissionCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHAXING)
	local nYiRongDan = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_YIRONGDAN_COUNT)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x402048_g_MissionId)
	local nIsMissionOkFail = GetMissionParam( sceneId, selfId, misIndex, x402048_g_IsMissionOkFail)
	if nNumText == 1000 then
		--存在杀星任务
		if IsHaveMission(sceneId,selfId,x402048_g_MissionId) > 0 then
			if nIsMissionOkFail == 1 then
				--任务完成了
				BeginEvent(sceneId)
					AddText(sceneId,x402048_g_MissionComplete)
				EndEvent()
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x402048_g_ScriptId,x402048_g_MissionId)
				return
			elseif nIsMissionOkFail == 2 then
				--任务失败了
				BeginEvent(sceneId)
					AddText( sceneId,"任务失败，#{SXRW_090119_016}")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			else
				--可进入
				BeginEvent(sceneId)
					AddText( sceneId,x402048_g_AcceptInfo)
					AddNumText(sceneId, x402048_g_ScriptId,"#{SXRW_090119_015}",10,1)
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
		end
		if nAddMissionCount < 2 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SXRW_090119_004}"..GetName(sceneId,selfId).."#{SXRW_090119_005}")
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x402048_g_ScriptId,x402048_g_MissionId)
			return
		end
		if nYiRongDan >= 1 and nAddMissionCount < 3 then  --必须硬性判断这个条件，要不容易出BUG
			BeginEvent(sceneId)
				AddText(sceneId,"#{SXRW_090119_004}"..GetName(sceneId,selfId).."#{SXRW_090119_005}")
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x402048_g_ScriptId,x402048_g_MissionId)
			return
		end
		if nAddMissionCount >= 2 and nYiRongDan == 0 then
			BeginEvent(sceneId)
				AddText( sceneId,"#{SXRW_090119_175}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		if nAddMissionCount >= 2 and nYiRongDan >= 1 then
			BeginEvent(sceneId)
				AddText( sceneId,"#{SXRW_090119_175}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	elseif nNumText == 1 then
		--先检测
		if x402048_CheckTeamLeader(sceneId,selfId) == 0 then
			return
		end
		local nearmembercount = GetNearTeamCount( sceneId, selfId )
		x402048_MakeCopyScene(sceneId,selfId,nearmembercount) --创建副本
	elseif nNumText == 2 then
		--三个条件，分割开来，要不容易看乱套。第一个条件，接受任务不满足2次。
		--第二个条件 现在身上没有煞星任务
		--第三个条件 煞星易容丹使用次数不足1次。
		if nAddMissionCount < 2 and nYiRongDan < 1 then
			x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_173}")
			return
		end
		if IsHaveMission(sceneId,selfId,x402048_g_MissionId) > 0 then
			BeginEvent(sceneId)
				AddText( sceneId,x402048_g_AcceptInfo)
				AddNumText(sceneId, x402048_g_ScriptId,"#{SXRW_090119_015}",10,1)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		if nYiRongDan >= 1 then
			x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_174}")
			return
		end
		if nAddMissionCount >= 2 and nYiRongDan == 0 then
			BeginEvent(sceneId)
				AddText( sceneId,"#{SXRW_090119_175}")
				AddNumText(sceneId,x402048_g_ScriptId,"#{YXJJ_091118_19}",6,12);
				AddNumText(sceneId,x402048_g_ScriptId,"#{YXJJ_091118_20}",0,13);
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	--这俩是介绍
	elseif nNumText == 10 then
		x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_069}")
		return
	elseif nNumText == 11 then
		x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090918_1}")
		return
	elseif nNumText == 12 then
		--以上条件都不满足的情况下，可以使用易容丹了就。
		--先检查身上是否存在易容丹
		if LuaFnMtl_GetCostNum(sceneId,selfId,30501359,30501363) < 1 then
			x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_177}")
			return
		end
		if LuaFnMtl_CostMaterial(sceneId,selfId,1,30501359,30501363) ~= 1 then
			x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_177}")
			return
		end
		--OK!使用成功。
		SetMissionDataEx(sceneId,selfId,MDEX_SHAXING_YIRONGDAN_COUNT,1)
		x402048_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_176}")
		return
	elseif nNumText == 13 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
	end
end

--**********************************
--列举事件
--**********************************
function x402048_OnEnumerate( sceneId,selfId,targetId)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x402048_g_MissionId) > 0 then
		AddNumText(sceneId, x402048_g_ScriptId,x402048_g_MissionName,4,1000)
    else
		AddNumText(sceneId,x402048_g_ScriptId,x402048_g_MissionName,4,1000);
    end
	AddNumText(sceneId,x402048_g_ScriptId,"#{SXRW_xml_XX(01)}",4,2);
	AddNumText(sceneId,x402048_g_ScriptId,"#{SXRW_090119_003}",11,10);
	AddNumText(sceneId,x402048_g_ScriptId,"#{SXRW_XML_1}",11,11);
end

--**********************************
-- 检测副本进入条件
--**********************************
function x402048_CheckTeamLeader( sceneId, selfId )
	local szText = "#{SXRW_090119_023}"
	local Humanlist = {}
	local nHumanNum = 0
	if GetTeamId(sceneId,selfId) < 0 then	--判断是否有队伍
		x402048_MsgBox(sceneId,selfId,-1,"#{SXRW_090119_017}")
		return 0
	end
	--取得玩家附近的队友数量（包括自己）
	local nearteammembercount = GetNearTeamCount( sceneId, selfId) 
	if nearteammembercount < x402048_g_LimitMembers then
		x402048_MsgBox(sceneId,selfId,-1,"#{SXRW_090119_019}")
		return 0
	end
	if LuaFnIsTeamLeader(sceneId,selfId) == 0 then	--只有队长才能操作。
		x402048_MsgBox(sceneId,selfId,-1,"#{SXRW_090119_018}")
		return 0
	end
	--附近有队员没来。
	if GetTeamSize(sceneId,selfId) ~= nearteammembercount then
		x402048_MsgBox(sceneId,selfId,-1,"#{SXRW_090119_020}")
		return 0
	end
	--检测队伍内玩家等级
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 then
			if GetLevel(sceneId,TeamPlayerID) < x402048_g_minLevel then
				Humanlist[nHumanNum] = GetName(sceneId,TeamPlayerID)
				nHumanNum = nHumanNum + 1
			end
		end
	end
	if nHumanNum > 0 then
		for i = 0,nHumanNum - 2 do
			szText = szText..Humanlist[i].."#{SXRW_090119_021}"
		end
		x402048_MsgBox(sceneId,selfId,-1,szText..Humanlist[nHumanNum - 1].."#{SXRW_090119_024}")
		return 0
	end
	--检测队伍玩家心法等级
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 then
			if ScriptGlobal_CheckAllXinfaLevel(sceneId,TeamPlayerID,x402048_g_minXinFaLevel) == 0 then
				Humanlist[nHumanNum] = GetName(sceneId,TeamPlayerID)
				nHumanNum = nHumanNum + 1
			end
		end
	end
	if nHumanNum > 0 then
		for i=0, nHumanNum-2 do
			szText = szText .. Humanlist[i] .. "#{SXRW_090119_021}"
		end
		x402048_MsgBox(sceneId,selfId,-1,szText..Humanlist[nHumanNum-1].."#{SXRW_090119_025}")
		return 0
	end
	--检测队伍玩家是否接取任务
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 then
			if IsHaveMission(sceneId,TeamPlayerID,x402048_g_MissionId) < 1 then
				Humanlist[nHumanNum] = GetName(sceneId,TeamPlayerID)
				nHumanNum = nHumanNum + 1
			end
		end
	end
	if nHumanNum > 0 then
		for i=0, nHumanNum-2 do
			szText = szText .. Humanlist[i] .. "#{SXRW_090119_021}"
		end
		x402048_MsgBox(sceneId,selfId,-1,szText..Humanlist[nHumanNum-1].."#{SXRW_090119_026}")
		return 0
	end
	--检测队伍中是否有人不提交任务卡副本
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 then
			if IsHaveMission(sceneId,TeamPlayerID,x402048_g_MissionId) > 0 then
				local misIndex = GetMissionIndexByID(sceneId,TeamPlayerID,x402048_g_MissionId)
				local nIsMissionOkFail = GetMissionParam(sceneId,TeamPlayerID,misIndex,x402048_g_IsMissionOkFail)
				local nKillMonsterNum = GetMissionParam(sceneId,TeamPlayerID,misIndex,x402048_g_KillMonsterNum)
				if nIsMissionOkFail >= 1 or nKillMonsterNum > 0 then
					Humanlist[nHumanNum] = GetName(sceneId,TeamPlayerID)
					nHumanNum = nHumanNum + 1
				end
			end
		end
	end
	if nHumanNum > 0 then
		for i=0, nHumanNum-2 do
			szText = szText .. Humanlist[i] .. "#{SXRW_090119_021}"
		end
		x402048_MsgBox(sceneId,selfId,-1,szText..Humanlist[nHumanNum-1].."#{SXRW_090119_022}")
		return 0
	end
	--检测队伍中是否有人已经完成两次了
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 then
			local nAddMissionCount = GetCampaignCountNum(sceneId,TeamPlayerID,CAMPAIGN_SHAXING)
			local nYiRongDan = GetMissionDataEx(sceneId,TeamPlayerID,MDEX_SHAXING_YIRONGDAN_COUNT)
			if nAddMissionCount > 2 and nYiRongDan >= 1 then
				Humanlist[nHumanNum] = GetName(sceneId,TeamPlayerID)
				nHumanNum = nHumanNum + 1
			end
		end
	end
	if nHumanNum > 0 then
		for i=0, nHumanNum-2 do
			szText = szText .. Humanlist[i] .. "#{SXRW_090119_021}"
		end
		x402048_MsgBox(sceneId,selfId,-1,szText..Humanlist[nHumanNum-1].."#{SXRW_090119_026}")
		return 0
	end
	return 1
end

--**********************************
--检测接受条件
--**********************************
function x402048_CheckAccept( sceneId, selfId )
	--local nAddMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_COUNT)
	local nAddMissionCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHAXING)
	local nYiRongDan = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_YIRONGDAN_COUNT)
	if IsHaveMission(sceneId,selfId,x402048_g_MissionId) > 0 then
		x402048_MsgBox( sceneId, selfId, -1, "#{SXRW_090119_008}" )
		return 0
	end
	if GetLevel(sceneId,selfId) < x402048_g_minLevel then
		x402048_MsgBox( sceneId, selfId, -1, "#{SXRW_090119_011}")
		return 0
	end
	if ScriptGlobal_CheckAllXinfaLevel(sceneId,selfId,x402048_g_minXinFaLevel) == 0 then
		x402048_MsgBox( sceneId, selfId, -1, "#{SXRW_090119_012}")
		return 0
	end
	if GetMissionCount(sceneId, selfId) >= 20 then
		x808131_NotifyFailBox(sceneId,selfId,-1,"#{SXRW_090119_013}")
		return 0
	end
	if nAddMissionCount >= 2 and nYiRongDan < 1 then
		x402048_MsgBox( sceneId, selfId, -1, "#{SXRW_090119_009}")
		return 0 
	end
	--硬性检测，这个检测的作用就是使用了易容丹之后，接取任务的数据会是三次。
	if nAddMissionCount > 2 and nYiRongDan > 0 then
		x402048_MsgBox( sceneId, selfId, -1, "#{SXRW_090119_009}")
		return 0 
	end
	return 1
end

--**********************************
--接受
--**********************************
function x402048_OnAccept( sceneId, selfId )
	if x402048_CheckAccept( sceneId, selfId ) == 0 then
		return
	end
	--local nAddMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_COUNT)
	--SetMissionDataEx(sceneId,selfId,MDEX_SHAXING_COUNT,nAddMissionCount + 1) --官得做法就是接了两次你不刷，放弃了，够2次就不能再接了。
	AddCampaignCountNum(sceneId,selfId,CAMPAIGN_SHAXING)
	AddMission(sceneId,selfId,x402048_g_MissionId,x402048_g_ScriptId,0,0,0) --添加任务给玩家
	local misIndex = GetMissionIndexByID(sceneId,selfId,x402048_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,x402048_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x402048_g_KillMonsterNum,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x402048_g_Param_sceneid,-1)
end

--**********************************
--放弃
--**********************************
function x402048_OnAbandon( sceneId, selfId )

	local misIndex = GetMissionIndexByID(sceneId,selfId,x402048_g_MissionId)
	local copyscene = GetMissionParam( sceneId, selfId, misIndex, x402048_g_Param_sceneid)
	--删除玩家任务列表中对应的任务
    DelMission(sceneId,selfId,x402048_g_MissionId)
	if sceneId == copyscene then --如果在副本里删除任务，则直接传送回
		local oldsceneId = LuaFnGetCopySceneData_Param(sceneId,3) ;--取得副本入口场景号
		NewWorld(sceneId,selfId,oldsceneId,x402048_g_Back_X,x402048_g_Back_Z)
	end
end
--**********************************
--玩家主动离开副本
--**********************************
function x402048_PlayerLeave( sceneId, selfId )
	if IsHaveMission(sceneId,selfId,x402048_g_MissionId) > 0 then
		local misIndex = GetMissionIndexByID(sceneId,selfId,x402048_g_MissionId)
		SetMissionByIndex(sceneId,selfId,misIndex,x402048_g_IsMissionOkFail,2) --任务失败
	end
end
--**********************************
--创建副本
--**********************************
function x402048_MakeCopyScene( sceneId, selfId, nearmembercount )
    local teamemissdata = {}
    teamemissdata[1],teamemissdata[2],teamemissdata[3],teamemissdata[4],teamemissdata[5],teamemissdata[6] = x402048_XuanGuai(sceneId, selfId )

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
		nHumanLevel = 70;
	else
		nHumanLevel = level0/level1;
	end

    nHumanLevel = floor(nHumanLevel/10) * 10
	if nHumanLevel < 70 then
		nHumanLevel = 70;
	elseif nHumanLevel > 120 then
		nHumanLevel = 120
    end

	local leaderguid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "shengsileitai.path"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x402048_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x402048_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x402048_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x402048_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;--杀死Boss的数量
	LuaFnSetCopySceneData_PvpRuler( sceneId, 9 )

	for i = 8,13 do
	    if teamemissdata[i - 7] ~= nil then
	        LuaFnSetCopySceneData_Param( sceneId, i,teamemissdata[i-7] )
	    else
	        LuaFnSetCopySceneData_Param( sceneId, i,0 )
	    end
	end
	local x,z = GetWorldPos( sceneId, selfId )		
    LuaFnSetSceneLoad_Monster( sceneId, "shengsileitai_monster.ini" )
	LuaFnSetCopySceneData_Param(sceneId, CopyScene_LevelGap, nHumanLevel) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
	if bRetSceneID>0 then
		AddText(sceneId,"#{FHGC_090706_33}");
	else
		AddText(sceneId,"#{FHGC_090706_34}");
	end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--随机生成怪物
--**********************************
function x402048_XuanGuai(sceneId, selfId )
    local shuzu = {}
    while getn(shuzu) < 6 do
        local pdcf = 0
        local seed = random(12)
        if getn(shuzu) > 0 then
            for i = 1,getn(shuzu) do
                if seed == shuzu[i] then
                    pdcf = 1
                end
            end
        end
        if pdcf == 0 then
            shuzu[getn(shuzu)+1] = seed
        end
    end
    return shuzu[1],shuzu[2],shuzu[3],shuzu[4],shuzu[5],shuzu[6]
end
--**********************************
--继续
--**********************************
function x402048_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x402048_CheckSubmit( sceneId, selfId )
	--判断任务是否已经完成
	local misIndex = GetMissionIndexByID(sceneId,selfId,x402048_g_MissionId)
	if GetMissionParam( sceneId, selfId, misIndex,0) >= 1 then 
		return	1
	else
		return	0
	end
end

--**********************************
--提交
--**********************************
function x402048_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x402048_CheckSubmit( sceneId, selfId) > 0 then		--已经完成任务了
		--local nAddMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_COUNT)
		local nAddMissionCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHAXING)
		--设置任务已经被完成过
		DelMission(sceneId,selfId,x402048_g_MissionId)
		--给经验，根据等级走
		AddExp(sceneId,selfId,GetLevel(sceneId,selfId) * 1470 * nAddMissionCount) --经验奖励构成，1470为基础经验值 * 等级 * 完成环数
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x402048_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x402048_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x402048_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x402048_OnCopySceneReady( sceneId, destsceneId )
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;	
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	--取得玩家附近的队友数量（包括自己）
	local nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
	local mems = {}
	for	i=0,nearteammembercount-1 do
		mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			local misIndex = GetMissionIndexByID(sceneId,mems[i],x402048_g_MissionId)
			--将任务的第2号数据设置为副本的场景号
			SetMissionByIndex(sceneId,mems[i],misIndex,x402048_g_Param_sceneid,destsceneId)
			NewWorld( sceneId, mems[i], destsceneId, x402048_g_Fuben_X, x402048_g_Fuben_Z);
		end
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x402048_OnPlayerEnter( sceneId, selfId )
	local nAddMissionCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_SHAXING)
	local nYiRongDan = GetMissionDataEx(sceneId,selfId,MDEX_SHAXING_YIRONGDAN_COUNT)
	if nAddMissionCount > 2 and nYiRongDan >= 1 then
		NewWorld( sceneId,selfId,2,x402048_g_Back_X, x402048_g_Back_Z )
		return
	end
	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo( sceneId, selfId,"%50","%50","%50",sceneId, x402048_g_Fuben_X, x402048_g_Fuben_Z );
	--设置随机怪
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId, 31)
	local nCount = GetMonsterCount(sceneId)
	if nCount < 2 then
		for i = 1,6 do
			local BossId = LuaFnGetCopySceneData_Param(sceneId, i+7)
			if BossId ~= 0 then
				local objId = CreateMonsterWithDir(sceneId, x402048_g_NpcID[BossId], 40, 16+i*4, 3, -1,402050,17)
				SetUnitReputationID(sceneId,objId,objId, 0)
				SetLevel(sceneId,objId,nHumanLevel)
				SetCharacterTitle(sceneId,objId,x402048_g_BossTitle[BossId])
			end
		end
	end
	--设置倒计时30s出怪 占用14号位置
	LuaFnSetCopySceneData_Param(sceneId,14,30)
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x402048_OnHumanDie( sceneId, selfId, killerId )
end

--**********************************
--副本场景定时器事件
--**********************************
function x402048_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟读取及设置
	local oldsceneId = LuaFnGetCopySceneData_Param(sceneId,3);--取得副本入口场景号
	local nBossNum = LuaFnGetCopySceneData_Param(sceneId,15) --这里占用15号标记，用于判断场中已经生成多少怪物了。
	local nKillNum = LuaFnGetCopySceneData_Param(sceneId,16) --这里占用16号标记，用于判断玩家们已经击杀多少个怪物了。
	local IsZhanDouFlag = LuaFnGetCopySceneData_Param(sceneId,18) --这里占用18号标记，当前正在战斗标记。
	local TickCountEx = LuaFnGetCopySceneData_Param(sceneId,17) --这里占用17号标记，记录怪物当前生成时间，每次开启新怪的时候要清零一次。
	local TickCount = LuaFnGetCopySceneData_Param(sceneId,2) ;--取得已经执行的定时次数
	local TimerCount = LuaFnGetCopySceneData_Param(sceneId,14) --刚进入副本的倒计时30s
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId, CopyScene_LevelGap) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	--副本关闭标志
	local leaveFlag = LuaFnGetCopySceneData_Param(sceneId,4);
	TickCount = TickCount + 1;
	TickCountEx = TickCountEx + 1;
	LuaFnSetCopySceneData_Param(sceneId,2,TickCount);--设置新的定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId,17,TickCountEx);--设置怪物生成定时器调用次数
	--设置默认倒计时出怪
	if TimerCount > 0 then 
		TimerCount = TimerCount - 1
		x402048_NotifyTips(sceneId,"倒计时"..TimerCount.."秒")
		local nBossId = LuaFnGetCopySceneData_Param(sceneId,x402048_g_MissBoss[1])
		--第二个条件，倒计时结束，自动出怪
		if TimerCount == 0 then
			nBossNum = nBossNum + 1
			--创建第一个怪物
			x402048_CreateMonster(sceneId,nBossId) --创建第一个怪物。
			if IsZhanDouFlag == 0 then
				LuaFnSetCopySceneData_Param(sceneId,18,1)
			end
			LuaFnSetCopySceneData_Param(sceneId,15,nBossNum)
		end
		LuaFnSetCopySceneData_Param(sceneId,14,TimerCount);--设置倒计时数据
	end
	if mod(TickCount,300) == 0 then
		--每五分钟提示一次副本剩余时间
		local remainingMilliseconds = x402048_g_LimitTotalHoldTime - TickCount
		local remainingMinutes = floor(remainingMilliseconds / 60) -- 剩余的分钟数
		x402048_NotifyTips(sceneId,"#{SXRW_090119_094}"..remainingMinutes.."#{SXRW_090119_095}")
	end
	--副本开始每五分钟执行一次。
	if nBossNum > 0 then
		--下一只煞星剩余60s的时候给一条屏幕提示
		if mod(TickCountEx,240) == 0 then
			x402048_NotifyTips(sceneId,"#{SXRW_090119_037}")
		end
		if mod(TickCountEx,300) == 0 then
			local nBossId = LuaFnGetCopySceneData_Param(sceneId,x402048_g_MissBoss[nBossNum + 1])
			x402048_CreateMonster(sceneId,nBossId) --必须开始创建怪物了。
		end
	end
	--击杀满6个，任务完成了。
	if nKillNum >= 6 then
		--遍历场内玩家，设置完成任务
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 then
				--硬性检测，必须检测是否有任务，其实意义不大，上面进入副本的时候已经检测过了。
				if IsHaveMission(sceneId,mems[i],x402048_g_MissionId) > 0 then
					local misIndex = GetMissionIndexByID(sceneId,mems[i],x402048_g_MissionId)
					--将任务的第0号数据设置为1
					if GetMissionParam(sceneId,mems[i],misIndex,x402048_g_IsMissionOkFail) < 1 then
						SetMissionByIndex(sceneId,mems[i],misIndex,x402048_g_IsMissionOkFail,1) --任务完成
						SetMissionByIndex(sceneId,mems[i],misIndex,x402048_g_KillMonsterNum,nKillNum)
						--周活跃数据埋点
						LuaFnFinishZhouHuoYueMission(sceneId,mems[i],15)
						--英雄大会埋点
						if LuaFnHaveImpactOfSpecificDataIndex(sceneId,mems[i],10541) == 1 then
							AddHerosReturnsRecoed(sceneId,mems[i],12)
						end
						CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, mems[i],CAMPAIGN_SHAXING)
						x402048_NotifyTips(sceneId,"杀星：任务完成")
					end
				end
			end
		end
		LuaFnSetCopySceneData_Param(sceneId,4,1) --设置需要离开
		--高光时刻结算
		LuaFnShowCopySceneHigntlight(sceneId,35);
	end
	if leaveFlag == 1 then --需要离开
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId,5);
		leaveTickCount = leaveTickCount + 1;
		LuaFnSetCopySceneData_Param(sceneId,5,leaveTickCount);
		if leaveTickCount == x402048_g_CloseTick then --倒计时间到，大家都出去吧
			--将当前副本场景里的所有人传送回原来进入时候的场景
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
					NewWorld( sceneId, mems[i], oldsceneId, x402048_g_Back_X, x402048_g_Back_Z )
				end
			end
		elseif leaveTickCount < x402048_g_CloseTick then
			local remainingMilliseconds = x402048_g_CloseTick - leaveTickCount
			local remainingMinutes = floor(remainingMilliseconds / 60) -- 剩余的分钟数
			local remainingSecondsInMinute = mod(remainingMilliseconds,60) -- 剩余的分钟内的秒数
			if remainingMinutes > 0 and remainingSecondsInMinute > 0 then
				x402048_NotifyTips(sceneId,"#{SXRW_090119_094}"..remainingMinutes.."分"..remainingSecondsInMinute.."#{SXRW_090119_096}")
			end
			if remainingMinutes == 0 and remainingSecondsInMinute > 0 then
				x402048_NotifyTips(sceneId,"#{SXRW_090119_094}"..remainingSecondsInMinute.."#{SXRW_090119_096}")
			end
		end
	elseif TickCount == x402048_g_LimitTotalHoldTime then --副本总时间限制到了
		--此处设置副本任务有时间限制的情况，当时间到后处理...
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId, mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then
				if IsHaveMission(sceneId,mems[i],x402048_g_MissionId) > 0 then
					local misIndex = GetMissionIndexByID(sceneId,mems[i],x402048_g_MissionId)
					local param = GetMissionParam(sceneId,mems[i],misIndex,0)
					if param ~= 1 then
						DelMission( sceneId, mems[i], x402048_g_MissionId );--任务失败,删除之
						x402048_NotifyTips(sceneId,"杀星：任务失败，出副本！")
					end
				end
			end
		end
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId,4,1);
	else
		--定时检查队伍成员的队伍号，如果不符合，则踢出副本
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId, mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then
				if IsHaveMission(sceneId,mems[i],x402048_g_MissionId) > 0 then
					local oldteamid = LuaFnGetCopySceneData_Param(sceneId,6) ; --取得保存的队伍号
					if oldteamid ~= GetTeamId(sceneId,mems[i]) then
						DelMission( sceneId, mems[i], x402048_g_MissionId );--任务失败,删除之
						oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
						NewWorld(sceneId,mems[i], oldsceneId, x402048_g_Back_X, x402048_g_Back_Z)
					end
  				end
  			end
		end
	end
end
--**********************************
-- 创建BOSS
--**********************************
function x402048_CreateMonster(sceneId,nBossID)
	--先清除NPC目标，再创建BOSS到指定位置。
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId,CopyScene_LevelGap)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i = 0, nMonsterNum - 1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID(sceneId,MonsterId)
		if MosDataID == x402048_g_NpcID[nBossID] then
			LuaFnDeleteMonster(sceneId,MonsterId) --必须要清理下NPC
		end
	end
	local nObjID = CreateMonsterWithDir(sceneId,x402048_g_BossID[nHumanLevel][nBossID],30,32,27,-1,x402048_g_BossScript[nBossID],0)
	SetUnitReputationID(sceneId,nObjID,nObjID,28)
	SetCharacterTitle(sceneId,nObjID,x402048_g_BossTitle[nBossID])
	--发送屏幕提示
	x402048_NotifyTips(sceneId,x402048_g_BossName[nBossID].."#{SXRW_090714_127}")
	LuaFnSetCopySceneData_Param(sceneId,17,0) --创建怪物这里就清零，然后重新读取新怪物的生成时间为多久。
end
--**********************************
--怪物死亡
--**********************************
function x402048_OnDie(sceneId,selfId,killerId)
	
end
--**********************************
--成功击杀杀星
--**********************************
function x402048_OnKillBoss( sceneId, selfId )
	if LuaFnIsObjValid(sceneId,selfId) ~= 1 then
		return
	end
	if LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then
		return
	end
	if IsHaveMission(sceneId,selfId,x402048_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x402048_g_MissionId)
	local nKillNum = LuaFnGetCopySceneData_Param(sceneId,16) --这里占用16号标记，用于判断玩家们已经击杀多少个怪物了。
	SetMissionByIndex(sceneId,selfId,misIndex,x402048_g_KillMonsterNum,nKillNum)
end
--**********************************
--全屏提示
--**********************************
function x402048_NotifyTips(sceneId,tip)
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i = 0,membercount - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 then
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
function x402048_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
-- 获取本副本的MonsterID
--**********************************
function x402048_GetFubenMonsterDataId(sceneId,selfId,nIndex)
	local nLevel = floor(GetLevel(sceneId,selfId) / 10) * 10 --取整
	return x402048_g_BossID[nLevel][nIndex],1
end
