--MisDescBegin
--脚本号
x210267_g_ScriptId = 210267
x210267_g_NextScriptId = 210269

--接受任务NPC属性
x210267_g_Position_X = 160
x210267_g_Position_Z = 158
x210267_g_SceneID = 2
x210267_g_AccomplishNPC_Name = "赵天师"

--任务号
x210267_g_MissionId = 1419

--上一个任务的ID
x210267_g_MissionIdPre = 1418

--目标NPC
x210267_g_Name	="钱龙"

--任务道具编号
--g_ItemId = 20101001

--任务道具需求数量
--g_ItemNeedNum = 1

--任务归类
x210267_g_MissionKind = 13

--任务等级
x210267_g_MissionLevel = 9

--是否是精英任务
x210267_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210267_g_IsMissionOkFail = 0		--变量的第0位
x210267_g_Custom	= { {id="已连续答对钱龙的五个问题",num=1} }

--以上是动态**************************************************************

--任务名
x210267_g_MissionName="江湖问答"
x210267_g_MissionInfo="#{XSRW_100111_43}"
x210267_g_MissionTarget="#{XSRW_100111_92}"
x210267_g_ContinueInfo="#{XSRW_100111_44}"		--未完成任务的npc对话
x210267_g_MissionComplete="#{XSRW_100111_45}"
x210267_g_MoneyJZBonus=100
x210267_g_ExpBonus=6000
x210267_g_SignPost = {x = 145, z = 138, tip = "钱龙"}
x210267_g_ItemBonus={{id=10111000,num=1}}


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210267_OnDefaultEvent( sceneId, selfId, targetId )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210267_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,1)
	if IsMissionHaveDone(sceneId,selfId,x210267_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210267_g_MissionId) > 0 and GetName(sceneId,targetId) == x210267_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210267_g_MissionName)
			AddText(sceneId, x210267_g_ContinueInfo)
		EndEvent()
		local bDone = x210267_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210267_g_ScriptId,x210267_g_MissionId,bDone)
	elseif IsHaveMission(sceneId,selfId,x210267_g_MissionId) > 0 and GetName(sceneId,targetId) == x210267_g_Name and param < 1 then
		x210267_OnQuIzUICommand(sceneId,selfId,targetId)
	--满足任务接收条件
	elseif x210267_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210267_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210267_g_MissionName)
			AddText(sceneId,x210267_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210267_g_MissionTarget)
			for _,item in x210267_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			AddMoneyJZBonus( sceneId, x210267_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210267_g_ScriptId,x210267_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210267_OnEnumerate( sceneId, selfId, targetId )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210267_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,1)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210267_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210267_g_MissionId) > 0 and GetName(sceneId,targetId) == x210267_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210267_g_ScriptId, x210267_g_MissionName, 2, -1);
	elseif IsHaveMission(sceneId,selfId,x210267_g_MissionId) > 0 and GetName(sceneId,targetId) == x210267_g_Name and param < 1 then
		x210267_OnQuIzUICommand(sceneId,selfId,targetId)
	--满足任务接收条件
	elseif x210267_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210267_g_Name then
		AddNumText(sceneId, x210267_g_ScriptId, x210267_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210267_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210267_g_MissionLevel
	and IsMissionHaveDone(sceneId,selfId,x210267_g_MissionIdPre) > 0
	and IsHaveMission(sceneId,selfId,x210267_g_MissionId) <= 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210267_OnAccept( sceneId, selfId,targetId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210267_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210267_g_MissionId, x210267_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x210267_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210267_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210267_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	--呼出答题界面
	x210267_OnQuIzUICommand(sceneId,selfId,targetId)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210267_g_SignPost.x, x210267_g_SignPost.z, x210267_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210267_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210267_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210267_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210267_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210267_g_MissionName)
		AddText(sceneId,x210267_g_MissionComplete)
		AddMoneyJZBonus( sceneId, x210267_g_MoneyJZBonus )
		for i, item in x210267_g_ItemBonus do
			AddItemBonus( sceneId,item.id, item.num )
		end
    EndEvent()
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210267_g_ScriptId,x210267_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210267_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210267_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210267_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210267_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210267_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210267_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
    BeginAddItem(sceneId)
		for i, item in x210267_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x210267_NotifyTips(sceneId,selfId,"背包已满,无法完成任务")
		return
	end
	AddItemListToHuman(sceneId,selfId) --给物品
	if x210267_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210267_g_MoneyJZBonus)
	end
	if x210267_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210267_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210267_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210267_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210267_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210267_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x210267_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210267_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--答题界面
--**********************************
function x210267_OnQuIzUICommand(sceneId,selfId,targetId)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)
		UICommand_AddString(sceneId,"#gFF0FA0智力闯关")
		UICommand_AddString(sceneId,"#{function_help_084}")
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 2)
	SetMissionData(sceneId,selfId,MD_QUIZ_TARGET,targetId)
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210267_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end