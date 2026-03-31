--MisDescBegin
--脚本号
x210268_g_ScriptId = 210268
x210268_g_NextScriptId = 210279

--接受任务NPC属性
x210268_g_Position_X=160
x210268_g_Position_Z=157
x210268_g_SceneID=2
x210268_g_AccomplishNPC_Name="赵天师"

--任务号
x210268_g_MissionId = 1421

--前置任务ID
x210268_g_MissionIdPer = 0

--目标NPC
x210268_g_Name	="赵天师"

--任务归类
x210268_g_MissionKind = 13

--任务等级
x210268_g_MissionLevel = 10

--是否是精英任务
x210268_g_IfMissionElite = 0

--任务名
x210268_g_MissionName="九大门派"
--任务描述
x210268_g_MissionInfo="#{XSRW_100111_48}" --任务描述
--任务目标
x210268_g_MissionTarget="#{XSRW_100111_97}"
--未完成任务的npc对话
x210268_g_ContinueInfo="#{XSRW_100111_98}"
--提交时npc的话
x210268_g_MissionComplete="#{XSRW_100111_49}"


x210268_g_ItemBonus={}


x210268_g_IsMissionOkFail = 0		--变量的第0位
x210268_g_Custom	= { {id="加入门派",num=1} }--变量的第1位


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210268_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210268_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210268_g_MissionId) > 0 and GetName(sceneId,targetId) == x210268_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210268_g_MissionName)
			AddText(sceneId, x210268_g_ContinueInfo)
		EndEvent()
		local bDone = x210268_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210268_g_ScriptId,x210268_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210268_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210268_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210268_g_MissionName)
			AddText(sceneId,x210268_g_MissionInfo)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210268_g_ScriptId,x210268_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210268_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210268_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210268_g_MissionId) > 0 and GetName(sceneId,targetId) == x210268_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210268_g_ScriptId, x210268_g_MissionName, 2, -1);			
	--满足任务接收条件
	elseif x210268_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210268_g_Name then
		AddNumText(sceneId, x210268_g_ScriptId, x210268_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210268_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210268_g_MissionLevel then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210268_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210268_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210268_g_MissionId, x210268_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x210268_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210268_g_MissionId)--得到任务在20个任务中的序列号
	if GetMenPai(sceneId,selfId) ~= 9 then
		SetMissionByIndex(sceneId,selfId,misIndex,x210268_g_IsMissionOkFail,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	else
		SetMissionByIndex(sceneId,selfId,misIndex,x210268_g_IsMissionOkFail,0)
		SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	end
end

--**********************************
--放弃
--**********************************
function x210268_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210268_g_MissionId )
end

--**********************************
--继续
--**********************************
function x210268_OnContinue( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,x210268_g_MissionName)
		AddText(sceneId,x210268_g_MissionComplete)
	EndEvent()
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210268_g_ScriptId,x210268_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210268_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210268_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210268_g_IsMissionOkFail)
	if param > 0 and GetMenPai(sceneId,selfId) ~= 9 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210268_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210268_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210268_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	DelMission( sceneId,selfId, x210268_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210268_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210268_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210268_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x210268_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210268_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210268_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end