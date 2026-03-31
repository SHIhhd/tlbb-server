--MisDescBegin
x212136_g_ScriptId 				= 212136
x212136_g_NextScriptId		= 250040
x212136_g_MissionId 			= 1164
x212136_g_SceneID					=	121
-- 任务目标 NPC
x212136_g_Name = "桃夭夭"
--任务归类
x212136_g_MissionKind 		= 1
--任务等级
x212136_g_MissionLevel 		= 10000
x212136_g_MissionName 		= "#{QSJS_090508_015}"
x212136_g_MissionInfo 		= "    "														-- 任务描述
x212136_g_MissionTarget 	= "#{QSJS_090508_042}"					-- 任务目标
x212136_g_IsMissionOkFail = 0														-- 0 号索引：当前任务是否完成(0未完成；1完成；2失败)
x212136_g_IsSuccTimes 		= 1														-- 1 号索引：当前挑战桃花阵的关数

x212136_g_Custom					= { {id="已挑战桃花阵:",num=5} }
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x212136_OnDefaultEvent( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x212136_g_MissionId) > 0 and GetName(sceneId,targetId) == x212136_g_Name then
		if x212136_CheckSubmit(sceneId,selfId) == 0 then
			x212136_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_045}")
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_046}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x212136_g_ScriptId,x212136_g_MissionId)
	elseif GetName(sceneId,targetId) == x212136_g_Name and IsMissionHaveDone(sceneId,selfId,1163) > 0 then 
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_016}")
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x212136_g_ScriptId,x212136_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x212136_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x212136_g_MissionId) > 0 and GetName(sceneId,targetId) == x212136_g_Name then
		AddNumText(sceneId, x212136_g_ScriptId, x212136_g_MissionName, 4, -1);
	--满足任务接收条件
	elseif GetName(sceneId,targetId) == x212136_g_Name and IsMissionHaveDone(sceneId,selfId,1163) > 0 then
		AddNumText(sceneId, x212136_g_ScriptId, x212136_g_MissionName, 3, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x212136_CheckAccept( sceneId, selfId )
	if GetTeamId(sceneId,selfId) < 0 then
		x212136_NotifyTips(sceneId,selfId,"#{QSJS_090508_019}")
		return 0
	end
	if GetTeamSize(sceneId,selfId) ~= GetNearTeamCount( sceneId, selfId) then
		x212136_NotifyTips(sceneId,selfId,"#{QSJS_090508_019}")
		return 0
	end
	if GetLevel(sceneId,selfId) < 20 then
		x212136_NotifyTips(sceneId,selfId,"#{QSJS_090508_007}")
		return 0
	end
	if GetMissionDataEx(sceneId,selfId,MDEX_QSJSDAYTIME) >= GetDayTime() then
		x212136_NotifyTips(sceneId,selfId,"#{QSJS_090508_020}")
		return 0
	end
	--没看到字典里有判断队伍人数得，但是这是个双人任务，我还是限制下吧
	if GetNearTeamCount( sceneId, selfId) < 2 then
		x212136_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_019}")
		return 0
	end
	if GetNearTeamCount( sceneId, selfId) > 2 then
		x212136_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_019}")
		return 0
	end
	return 1
end

--**********************************
--接受
--**********************************
function x212136_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x212136_g_MissionId) > 0 then
		return 
	end
	if x212136_CheckAccept( sceneId, selfId ) == 0 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x212136_g_MissionId, x212136_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x212136_NotifyTips(sceneId,selfId,"#{QSJS_090508_009}")
		return
	end
	x212136_NotifyTips(sceneId,selfId,"#{QSJS_090508_021}")
	x212136_MsgBox(sceneId,selfId,-1,"#{QSJS_090611_3}")
	local misIndex = GetMissionIndexByID(sceneId, selfId, x212136_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x212136_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

--**********************************
--放弃
--**********************************
function x212136_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x212136_g_MissionId )
	--放弃这个任务就代表不能再继续开始了
	SetMissionDataEx(sceneId,selfId,MDEX_QSJSDAYTIME,GetDayTime())
end

--**********************************
--继续
--**********************************
function x212136_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x212136_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x212136_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x212136_g_IsMissionOkFail)
	if param == 0 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x212136_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x212136_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x212136_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	DelMission( sceneId,selfId, x212136_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x212136_g_MissionId)
	--设置完成过了今日
	SetMissionDataEx(sceneId,selfId,MDEX_QSJSDAYTIME,GetDayTime())
	--下一阶段任务
	CallScriptFunction(x212136_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
	--封魂录埋点更新
	CallScriptFunction(791010, "AddPointData", sceneId, selfId, 10);
end

--**********************************
--杀死怪物或玩家
--**********************************
function x212136_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x212136_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x212136_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x212136_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

function x212136_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
	AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
