--MisDescBegin
--脚本号
x210262_g_ScriptId = 210262
x210262_g_NextScriptId = 210255

--完成任务NPC属性
x210262_g_Position_X = 160
x210262_g_Position_Z = 156
x210262_g_SceneID = 2
x210262_g_AccomplishNPC_Name = "赵天师"

--任务号
x210262_g_MissionId = 1400

--上一个任务的ID
x210262_g_MissionIdPre = 0

--目标NPC
x210262_g_Name	="赵天师"

--任务归类
x210262_g_MissionKind = 13

--任务等级
x210262_g_MissionLevel = 1

--是否是精英任务
x210262_g_IfMissionElite = 0

--任务名
x210262_g_MissionName = "初涉江湖"
x210262_g_MissionInfo = ""
x210262_g_MissionTarget = "#{XSRW_100111_1}"
x210262_g_ContinueInfo = ""
x210262_g_MissionComplete = "#{XSRW_100111_2}"
x210262_g_MoneyJZBonus = 1
x210262_g_ExpBonus = 50
x210262_g_SignPost = {x = 160, z = 156, tip = "赵天师"}

x210262_g_Custom	= { {id="已找到赵天师",num=1} }
x210262_g_IsMissionOkFail = 0		--变量的第0位


--MisDescEnd

--**********************************
--任务入口函数
--**********************************
function x210262_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210262_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210262_g_MissionId) > 0  then
		BeginEvent(sceneId)
			AddText(sceneId, x210262_g_MissionName)
			AddText(sceneId, x210262_g_MissionComplete)
			AddMoneyJZBonus( sceneId, x210262_g_MoneyJZBonus )
		EndEvent( )
		local bDone = x210262_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210262_g_ScriptId,x210262_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210262_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210262_g_MissionName)
			AddText(sceneId,x210262_g_MissionTarget)
			AddMoneyJZBonus( sceneId, x210262_g_MoneyJZBonus )
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x210262_g_ScriptId,x210262_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210262_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210262_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210262_g_MissionId) > 0 then
	    AddNumText(sceneId, x210262_g_ScriptId, x210262_g_MissionName, 2, -1);		
	--满足任务接收条件
	elseif x210262_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId, x210262_g_ScriptId, x210262_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210262_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210262_g_MissionLevel then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210262_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210262_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210262_g_MissionId, x210262_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x210262_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210262_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210262_g_IsMissionOkFail,1)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210262_g_SignPost.x, x210262_g_SignPost.z, x210262_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210262_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210262_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210262_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210262_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
	BeginEvent(sceneId)
		AddText(sceneId,x210262_g_MissionName)
		AddText(sceneId,x210262_g_MissionComplete)
	EndEvent()
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210262_g_ScriptId,x210262_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210262_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210262_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210262_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210262_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210262_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210262_CheckSubmit(sceneId, selfId) <= 0    then
		return
	end
	if x210262_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210262_g_MoneyJZBonus)
	end
	if x210262_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210262_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210262_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210262_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210262_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210262_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x210262_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210262_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210262_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end