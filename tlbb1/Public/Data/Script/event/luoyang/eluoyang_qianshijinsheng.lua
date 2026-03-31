--MisDescBegin
x250039_g_ScriptId 				= 250039
x250039_g_NextScriptId 		= 212136
x250039_g_MissionId 			= 1163
x250039_g_SceneID					=	0
-- 任务目标 NPC
x250039_g_Name 						= "诸葛孔亮"
-- 任务目标 NPC
x250039_g_AccomplishNPC_Name 		= "桃夭夭"
--任务归类
x250039_g_MissionKind 		= 1
--任务等级
x250039_g_MissionLevel 		= 10000

x250039_g_MissionName 		= "#{QSJS_090508_001}"
x250039_g_MissionInfo 		= "   "						-- 任务描述
x250039_g_MissionTarget 	= "#{QSJS_090602_002}"						-- 任务目标
x250039_g_IsMissionOkFail = 0														-- 0 号索引：当前任务是否完成(0未完成；1完成；2失败)
x250039_g_MissionItem = 40004471 --基础任务道具
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x250039_OnDefaultEvent( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x250039_g_MissionId) > 0 and GetName(sceneId,targetId) == x250039_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_013}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x250039_g_ScriptId,x250039_g_MissionId)
	elseif GetName(sceneId,targetId) == x250039_g_Name and IsHaveMission(sceneId,selfId,x250039_g_MissionId) <= 0 and IsHaveMission(sceneId,selfId,1164) <= 0 and IsHaveMission(sceneId,selfId,1165) then 
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_004}")
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x250039_g_ScriptId,x250039_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x250039_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x250039_g_MissionId) > 0 and GetName(sceneId,targetId) == x250039_g_AccomplishNPC_Name then
		AddNumText(sceneId, x250039_g_ScriptId, x250039_g_MissionName, 4, -1);		
	--满足任务接收条件
	elseif GetName(sceneId,targetId) == x250039_g_Name and IsHaveMission(sceneId,selfId,x250039_g_MissionId) <= 0 and IsHaveMission(sceneId,selfId,1164) <= 0 and IsHaveMission(sceneId,selfId,1165) then
		AddNumText(sceneId, x250039_g_ScriptId, x250039_g_MissionName, 3, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x250039_CheckAccept( sceneId, selfId )
	--判断是否组队而且必须是异性
	if GetTeamId(sceneId,selfId) < 0 then
		x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_005}")
		return 0
	end
	if GetTeamSize(sceneId,selfId) ~= GetNearTeamCount( sceneId, selfId) then
		x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_006}")
		return 0
	end
	if GetLevel(sceneId,selfId) < 20 then
		x250039_NotifyTips(sceneId,selfId,"#{QSJS_090508_007}")
		return 0
	end
	if GetMissionDataEx(sceneId,selfId,MDEX_QSJSDAYTIME) >= GetDayTime() then
		x250039_NotifyTips(sceneId,selfId,"#{QSJS_090508_008}")
		return 0
	end
	if LuaFnGetAvailableItemCount(sceneId,selfId,x250039_g_MissionItem) > 0 then
		x250039_NotifyTips(sceneId,selfId,"#{QSJS_090602_001}")
		return 0
	end
	if LuaFnGetTaskItemBagSpace(sceneId,selfId) < 1 then
		x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_010}")
		return 0
	end
	--没看到字典里有判断队伍人数得，但是这是个双人任务，我还是限制下吧
	if GetNearTeamCount( sceneId, selfId) < 2 then
		x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_005}")
		return 0
	end
	if GetNearTeamCount( sceneId, selfId) > 2 then
		x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_005}")
		return 0
	end
	return 1
end

--**********************************
--接受
--**********************************
function x250039_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x250039_g_MissionId) > 0 then
		return 
	end
	if x250039_CheckAccept( sceneId, selfId ) == 0 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x250039_g_MissionId, x250039_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x250039_NotifyTips(sceneId,selfId,"#{QSJS_090508_009}")
		return
	end
	BeginAddItem(sceneId)
	AddItem(sceneId,x250039_g_MissionItem,1)
	if EndAddItem(sceneId,selfId) <= 0 then
		x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_010}")
		return 0
	end
	AddItemListToHuman(sceneId,selfId)
	x250039_NotifyTips(sceneId,selfId,"#{QSJS_090508_011}")
	x250039_NotifyTips(sceneId,selfId,"#{QSJS_090508_012}")
	local nearteammembercount = GetNearTeamCount( sceneId, selfId)
	local TeamID = -1;
	for i = 0,nearteammembercount - 1 do
		local TeamPlayerID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,TeamPlayerID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,TeamPlayerID) == 1 and LuaFnIsCharacterLiving(sceneId,TeamPlayerID) == 1 then
			if selfId ~= TeamPlayerID then
				TeamID = TeamPlayerID
			end
		end
	end
	x250039_MsgBox(sceneId,selfId,-1,"#{QSJS_090611_1}#P"..GetName(sceneId,TeamID).."#{QSJS_090611_2}")
	local misIndex = GetMissionIndexByID(sceneId, selfId, x250039_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x250039_g_IsMissionOkFail,1)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
end

--**********************************
--放弃
--**********************************
function x250039_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x250039_g_MissionId )
	LuaFnDelAvailableItem(sceneId,selfId,x250039_g_MissionItem,1)
end

--**********************************
--继续
--**********************************
function x250039_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x250039_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x250039_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x250039_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x250039_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x250039_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x250039_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	-- 3、检测是否有三生石
	if LuaFnGetAvailableItemCount(sceneId,selfId,x250039_g_MissionItem) < 1 then
		x250039_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_014}")
		return
	end
	DelMission( sceneId,selfId, x250039_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x250039_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x250039_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x250039_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x250039_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x250039_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x250039_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

function x250039_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
	AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end