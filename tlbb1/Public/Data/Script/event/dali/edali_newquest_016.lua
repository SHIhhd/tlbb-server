--MisDescBegin

--脚本号
x210265_g_ScriptId = 210265
x210265_g_NextScriptId = 210277

--接受任务NPC属性
x210265_g_Position_X = 265
x210265_g_Position_Z = 129
x210265_g_SceneID = 2
x210265_g_AccomplishNPC_Name = "云飘飘"

--任务号
x210265_g_MissionId = 1415

x210265_g_MissionIdPre = 1414

--任务目标npc
x210265_g_Name	="云飘飘"
x210265_g_Entrance_Name	="申情"

--任务归类
x210265_g_MissionKind = 13

--任务等级
x210265_g_MissionLevel = 7

--是否是精英任务
x210265_g_IfMissionElite = 0

--********下面几项是动态显示的内容，用于在任务列表中动态显示任务情况******
--任务是否已经完成
x210265_g_IsMissionOkFail = 0		--变量的第0位
--**********************************以上是动态****************************

--任务文本描述
x210265_g_MissionName="抓珍兽"
x210265_g_MissionInfo="#{XSRW_100111_35}"  --任务描述
x210265_g_MissionTarget="#{XSRW_100111_91}"		--任务目标
x210265_g_ContinueInfo="#{XSRW_100111_81}"		--未完成任务的npc对话
x210265_g_MissionComplete="#{XSRW_100111_36}"					--完成任务npc说话的话
x210265_g_SignPost = {x = 265, z = 129, tip = "云飘飘"}
x210265_g_Custom	= { {id="抓住飘飘鸭",num=1} }

--任务奖励
x210265_g_MoneyJZBonus = 100
x210265_g_ExpBonus = 8000


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210265_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210265_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210265_g_MissionId) > 0 and GetName(sceneId,targetId) == x210265_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210265_g_MissionName)
			AddText(sceneId, x210265_g_ContinueInfo)
		EndEvent()
		local bDone = x210265_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210265_g_ScriptId,x210265_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210265_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210265_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210265_g_MissionName)
			AddText(sceneId,x210265_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210265_g_MissionTarget)
			AddMoneyJZBonus( sceneId, x210265_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210265_g_ScriptId,x210265_g_MissionId)
	elseif GetName(sceneId,targetId) == x210265_g_Entrance_Name and IsHaveMission(sceneId,selfId,x210265_g_MissionId) > 0 then
		CallScriptFunction(400900,"TransferFunc",sceneId,selfId,62,100,97,x210265_g_MissionLevel)
	end
end

--**********************************
--列举事件
--**********************************
function x210265_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210265_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210265_g_MissionId) > 0 and GetName(sceneId,targetId) == x210265_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210265_g_ScriptId, x210265_g_MissionName, 2, -1);	
	--满足任务接收条件
	elseif x210265_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210265_g_Name then
		AddNumText(sceneId, x210265_g_ScriptId, x210265_g_MissionName, 1, -1);
	elseif GetName(sceneId,targetId) == x210265_g_Entrance_Name and IsHaveMission(sceneId,selfId,x210265_g_MissionId) > 0 then
		AddNumText(sceneId, x210265_g_ScriptId, "前往后花园", 10, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210265_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210265_g_MissionLevel
	and IsMissionHaveDone(sceneId,selfId,x210265_g_MissionIdPre) > 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210265_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210265_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMissionEx( sceneId,selfId, x210265_g_MissionId, x210265_g_ScriptId)
	if ret <= 0 then
		x210265_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	SetMissionEvent(sceneId,selfId, x210265_g_MissionId,3)	--设置任务事件，3表示珍兽变化事件
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210265_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210265_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210265_g_SignPost.x, x210265_g_SignPost.z, x210265_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210265_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210265_g_MissionId )
	--删除珍兽
	local petcount = LuaFnGetPetCount(sceneId, selfId) --取得珍兽数量
	for	i=0,petcount-1 do
		petdataid = LuaFnGetPet_DataID(sceneId, selfId, i) --取得珍兽编号
		if petdataid == 558 then
			LuaFnDeletePet(sceneId, selfId, i)
		end
	end
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210265_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210265_OnContinue( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,x210265_g_MissionName)
		AddText(sceneId,x210265_g_MissionComplete)
		AddMoneyJZBonus( sceneId, x210265_g_MoneyJZBonus)
	EndEvent()
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210265_g_ScriptId,x210265_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210265_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210265_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210265_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210265_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210265_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210265_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	if x210265_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210265_g_MoneyJZBonus)
	end
	if x210265_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210265_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210265_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210265_g_MissionId)
	--屏幕提示
	x210265_NotifyTips(sceneId,selfId,"完成任务："..x210265_g_MissionName)
	--下一阶段任务
	CallScriptFunction(x210265_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210265_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x210265_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210265_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--珍兽改变
--**********************************
function x210265_OnPetChanged( sceneId, selfId, petdataId )
	if petdataId == 558 then --是任务珍兽
		misIndex = GetMissionIndexByID(sceneId,selfId,x210265_g_MissionId)
		SetMissionByIndex(sceneId,selfId,misIndex,x210265_g_IsMissionOkFail,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
		x210265_NotifyTips(sceneId,selfId,"抓珍兽，任务完成!")
	end
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210265_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end