--MisDescBegin
--脚本号
x891080_g_ScriptId = 891080

--完成任务NPC属性
x891080_g_Position_X=160  --替代
x891080_g_Position_Z=157 --替代
x891080_g_SceneID=2
x891080_g_AccomplishNPC_Name="赵天师"

--任务号
x891080_g_MissionId = 2000
x891080_g_MissionId2 = 2001
x891080_g_MissionId3 = 2005
x891080_g_MissionId4 = 2014

--目标NPC
x891080_g_Name	="赵天师"

--任务归类
x891080_g_MissionKind = 9

--任务等级
x891080_g_MissionLevel = 80 --10000

--是否是精英任务
x891080_g_IfMissionElite = 0

--任务名
x891080_g_MissionName="#{YXDHYD_20210207_81}"
x891080_g_MissionTarget="#{YXDHYD_20210207_27}"
x891080_g_IsMissionOkFail=0
x891080_g_Custom = {{ id = "与大理赵天师交谈", num = 1}} --替代
x891080_g_ContinueInfo = ""
x891080_g_MissionComplete = "#{YXDHYD_20210207_26}"

x891080_g_MoneyJZBonus = 10000
x891080_g_ExpBonus = 100000

--MisDescEnd
--**********************************
--呼出客户端界面
--**********************************
function x891080_OpenUI(sceneId,selfId,index)
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < x891080_g_MissionLevel then
		x891080_NotifyTips(sceneId,selfId,"#{YXDHYD_20210205_04}")
		return
	end
	--试问英雄何处UI面板
	if index == 6 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,8910801)
	end
end
--**********************************
--客户端接取任务
--**********************************
function x891080_OnAccept(sceneId,selfId)
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < x891080_g_MissionLevel then
		x891080_NotifyTips(sceneId,selfId,"#{YXDHYD_20210205_51}")
		return
	end
	if IsHaveMission(sceneId,selfId,x891081_g_MissionId) > 0 then
		x891080_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_20210207_17}",x891080_g_MissionName))
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x891080_g_MissionId) > 0 then
		x891080_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_20210207_20}",x891080_g_MissionName))
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x891080_g_MissionId, x891080_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891080_NotifyTips(sceneId,selfId,"#{YXDHYD_20210205_56}")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891080_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	x891080_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_06}",x891080_g_MissionName))
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, x891080_g_SceneID, x891080_g_Position_X, x891080_g_Position_Z, x891080_g_AccomplishNPC_Name)
	--自动寻路
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,8910804)
end

--**********************************
--是否显示在客户端小地图上方
--**********************************
function x891080_OnPlayerLogin(sceneId,selfId)
	local nCurTime = LuaFnGetCurrentTime()
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < x891080_g_MissionLevel then
		return
	end
	if GetMissionDataEx(sceneId,selfId,MDEX_SYSZ_DAYTIME) == 0 then
		--设置时间为7天后
		SetMissionDataEx(sceneId,selfId,MDEX_SYSZ_DAYTIME,nCurTime + 7 * 24 * 60 * 60)
		SetMissionDataEx(sceneId,selfId,MDEX_YXDH_MISSION,1) --默认1
	end
	local nDayTime = GetMissionDataEx(sceneId,selfId,MDEX_SYSZ_DAYTIME)
	local MissionData = GetMissionDataEx(sceneId,selfId,MDEX_YXDH_MISSION)
	local param1,param2,param3 = 0,1,MissionData
	if nDayTime > nCurTime then
		param1 = 1
	end
	if IsMissionHaveDone(sceneId,selfId,x891080_g_MissionId) > 0 then
		param1 = 0
		param2 = 0
	end
--	x891080_NotifyTips(sceneId,selfId,"param1:"..param1.." param2:"..param2.." param3:"..param3)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,param1)
		UICommand_AddInt(sceneId,param2)
		UICommand_AddInt(sceneId,param3)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,8910800)
end
--**********************************
--任务入口函数
--**********************************
function x891080_OnDefaultEvent( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x891080_g_MissionId) > 0  then
		--提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x891080_g_MissionName)
			AddText(sceneId,x891080_g_MissionComplete)
			AddMoneyJZBonus(sceneId,x891080_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x891080_g_ScriptId,x891080_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x891080_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x891080_g_MissionId) > 0 then
	    AddNumText(sceneId, x891080_g_ScriptId, "#{YXDHYD_20210325_09}", 2, -1);
	end
end
--**********************************
--放弃
--**********************************
function x891080_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891080_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,x891080_g_SceneID,x891080_g_AccomplishNPC_Name)
end

--**********************************
--检测是否可以提交
--**********************************
function x891080_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891080_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	if param == 0 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891080_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x891080_g_MissionId) <= 0 then
		return
	end
	if x891080_CheckSubmit(sceneId,selfId) == 0 then
		return
	end
	if x891080_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x891080_g_MoneyJZBonus)
	end
	if x891080_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x891080_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x891080_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x891080_g_MissionId)
	x891080_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_02}",x891080_g_MissionName))
	--关闭入口UI
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,0)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,8910800)
	--下一阶段任务
	CallScriptFunction(891081,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891080_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x891080_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891080_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x891080_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end