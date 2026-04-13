--MisDescBegin
--脚本号
x210273_g_ScriptId  = 210273
x210273_g_NextScriptId = 210274

--接受任务NPC属性
x210273_g_Position_X=58
x210273_g_Position_Z=133
x210273_g_SceneID=2
x210273_g_AccomplishNPC_Name="高升祥"

--上一个任务的ID
x210273_g_MissionIdPre = 1406

--任务号
x210273_g_MissionId = 1407

--目标NPC
x210273_g_Name	="卢三七"

--任务归类
x210273_g_MissionKind = 13

--任务等级
x210273_g_MissionLevel = 4
x210273_g_MinMissionLevel = 4

--是否是精英任务
x210273_g_IfMissionElite = 0

--任务文本描述
x210273_g_MissionName="剑阁猴患"
x210273_g_MissionTarget="#{XSRW_100111_66}"	--任务目标
x210273_g_MissionInfo="#{XSRW_100111_18}" --任务描述
x210273_g_ContinueInfo="#{XSRW_100111_84}"	--未完成任务的npc对话
x210273_g_MissionComplete="#{XSRW_100111_19}"	--完成任务npc说话的话
x210273_g_SignPost = {x = 58, z = 133, tip = "高升祥"}
--任务奖励
x210273_g_MoneyJZBonus=30
x210273_g_ExpBonus=11400
x210273_g_RadioItemBonus={}
x210273_g_RadioItemBonus={{id=10401072,num=1},{id=10402082,num=1},{id=10403072,num=1},{id=10404077,num=1}}

x210273_g_DemandTrueKill ={{name="蜀道白猿",num=4}}
--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210273_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x210273_g_DemandKill ={{id=719,num=4}}		--变量第1位

--以上是动态**************************************************************


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210273_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210273_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210273_g_MissionId) > 0 and GetName(sceneId,targetId) == x210273_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210273_g_MissionName)
			AddText(sceneId, x210273_g_ContinueInfo)
		EndEvent()
		local bDone = x210273_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210273_g_ScriptId,x210273_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210273_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210273_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210273_g_MissionName)
			AddText(sceneId,x210273_g_MissionInfo)
			for _,item in x210273_g_RadioItemBonus do
				AddRadioItemBonus( sceneId, item.id, item.num )
			end
			AddMoneyJZBonus( sceneId, x210273_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210273_g_ScriptId,x210273_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210273_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210273_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210273_g_MissionId) > 0 and GetName(sceneId,targetId) == x210273_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210273_g_ScriptId, x210273_g_MissionName, 2, -1);		
	--满足任务接收条件
	elseif x210273_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210273_g_Name then
		AddNumText(sceneId, x210273_g_ScriptId, x210273_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210273_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210273_g_MissionLevel
	and IsMissionHaveDone(sceneId,selfId,x210273_g_MissionIdPre) > 0
	and IsHaveMission(sceneId,selfId,x210273_g_MissionId) <= 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210273_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210273_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210273_g_MissionId, x210273_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		x210273_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210273_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210273_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210273_g_SignPost.x, x210273_g_SignPost.z, x210273_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210273_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210273_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210273_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210273_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x210273_g_MissionName)
		AddText(sceneId,x210273_g_MissionComplete)
		AddMoneyJZBonus( sceneId, x210273_g_MoneyJZBonus )
		for i, item in x210273_g_RadioItemBonus do
			AddRadioItemBonus( sceneId,item.id, item.num )
		end
    EndEvent()
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210273_g_ScriptId,x210273_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210273_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210273_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210273_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210273_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210273_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210273_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
    BeginAddItem(sceneId)
		for i, item in x210273_g_RadioItemBonus do
			if item.id == selectRadioId then
				AddItem( sceneId,item.id, item.num )
			end
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x210273_NotifyTips(sceneId,selfId,"背包已满,无法完成任务")
		return
	end
	AddItemListToHuman(sceneId,selfId) --给物品
	if x210273_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210273_g_MoneyJZBonus)
	end
	if x210273_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210273_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210273_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210273_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210273_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210273_OnKillObject( sceneId, selfId, objdataId ,objId )
	if GetName(sceneId,objId) == x210273_g_DemandTrueKill[1].name then
		-- 看有没有这个任务
		if IsHaveMission(sceneId, selfId, x210273_g_MissionId) > 0 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x210273_g_MissionId)
			local nKillNum = GetMissionParam(sceneId,selfId,misIndex,1)
			if nKillNum < x210273_g_DemandTrueKill[1].num then
				if nKillNum == x210273_g_DemandTrueKill[1].num - 1 then
					SetMissionByIndex(sceneId,selfId,misIndex,x210273_g_IsMissionOkFail,1)
				end
				SetMissionByIndex(sceneId,selfId,misIndex,1,nKillNum+1)
				BeginEvent(sceneId)
					strText = "已杀死蜀道白猿"..GetMissionParam(sceneId,selfId,misIndex,1).."/"..x210273_g_DemandTrueKill[1].num
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x210273_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210273_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210273_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end