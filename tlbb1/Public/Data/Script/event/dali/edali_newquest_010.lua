--MisDescBegin
--脚本号
x210280_g_ScriptId = 210280
x210280_g_NextScriptId = 210275

--接受任务NPC属性
x210280_g_Position_X=215
x210280_g_Position_Z=284
x210280_g_SceneID=2
x210280_g_AccomplishNPC_Name="段延庆"

--任务号
x210280_g_MissionId = 1423

--上一个任务的ID
x210280_g_MissionIdPre = 1408

--目标NPC
x210280_g_Name	="段延庆"
x210280_g_StuffName = "黄公道"
x210280_g_QigaiName = "小乞丐"

--任务归类
x210280_g_MissionKind = 13

--任务等级
x210280_g_MissionLevel = 5

--是否是精英任务
x210280_g_IfMissionElite = 0

--下面几项是动态显示的内容，用于在任务列表中动态显示任务情况**********************
--任务是否已经完成
x210280_g_IsMissionOkFail = 0		--变量的第0位

--以上是动态**************************************************************

--任务文本描述
x210280_g_MissionName="何谓行善"
x210280_g_MissionInfo="#{XSRW_100111_109}"
x210280_g_MissionTarget="#{XSRW_100111_120}"
x210280_g_ContinueInfo="#{XSRW_100111_119}"
x210280_g_MissionComplete="#{XSRW_100111_121}"
x210280_g_SignPost = {x = 199, z = 256, tip = "小乞丐"}
x210280_g_Custom	= { {id="得到要赠与小乞丐的物品",num=1},{id="赠送馒头给小乞丐",num=1},{id="赠送衣服给小乞丐",num=1},{id="赠送锄头给小乞丐",num=1} }
--任务奖励
x210280_g_MoneyJZBonus=300
x210280_g_ExpBonus=1500
--g_ItemBonus={{id=40002108,num=1}}


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210280_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210280_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210280_g_MissionId) > 0 and GetName(sceneId,targetId) == x210280_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210280_g_MissionName)
			AddText(sceneId, x210280_g_ContinueInfo)
		EndEvent()
		local bDone = x210280_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210280_g_ScriptId,x210280_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210280_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210280_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210280_g_MissionName)
			AddText(sceneId,x210280_g_MissionInfo)
			AddMoneyJZBonus( sceneId, x210280_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210280_g_ScriptId,x210280_g_MissionId)
	elseif IsHaveMission(sceneId,selfId,x210280_g_MissionId) > 0 and GetName(sceneId,targetId) == x210280_g_StuffName then
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210280_g_MissionId)--得到任务在20个任务中的序列号
		BeginAddItem(sceneId)
			AddItem( sceneId,40004514,1)
			AddItem( sceneId,40004515,1)
			AddItem( sceneId,40004516,1)
		if EndAddItem(sceneId,selfId) <= 0 then
			x210280_NotifyTips(sceneId,selfId,"任务背包空间不足。")
			return
		end
		AddItemListToHuman(sceneId,selfId)
		x210280_NotifyTips(sceneId,selfId,"得到要赠与小乞丐的物品：1/1")
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
		BeginEvent(sceneId)
			AddText(sceneId, "#{XSRW_100111_122}")      
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--列举事件
--**********************************
function x210280_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210280_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210280_g_MissionId) > 0 and GetName(sceneId,targetId) == x210280_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210280_g_ScriptId, x210280_g_MissionName, 2, -1);		
	--满足任务接收条件
	elseif x210280_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210280_g_Name then
		AddNumText(sceneId, x210280_g_ScriptId, x210280_g_MissionName, 1, -1);
	elseif IsHaveMission(sceneId,selfId,x210280_g_MissionId) > 0 and GetName(sceneId,targetId) == x210280_g_StuffName then
		AddNumText(sceneId, x210280_g_ScriptId, "#{XSRW_100111_111}", 2, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210280_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210280_g_MissionLevel
	and IsMissionHaveDone(sceneId,selfId,x210280_g_MissionIdPre) > 0
	and IsHaveMission(sceneId,selfId,x210280_g_MissionId) <= 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210280_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210280_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210280_g_MissionId, x210280_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x210280_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210280_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210280_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	SetMissionByIndex(sceneId,selfId,misIndex,2,0)
	SetMissionByIndex(sceneId,selfId,misIndex,3,0)
	SetMissionByIndex(sceneId,selfId,misIndex,4,0)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210280_g_SignPost.x, x210280_g_SignPost.z, x210280_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210280_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210280_g_MissionId )
	--删除玩家任务道具
	LuaFnDelAvailableItem(sceneId,selfId,40004514,1)
	LuaFnDelAvailableItem(sceneId,selfId,40004515,1)
	LuaFnDelAvailableItem(sceneId,selfId,40004516,1)
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210280_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210280_OnContinue( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,x210280_g_MissionName)
		AddText(sceneId,x210280_g_MissionComplete)
		AddMoneyJZBonus( sceneId, x210280_g_MoneyJZBonus )
	EndEvent()
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210280_g_ScriptId,x210280_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210280_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210280_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210280_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210280_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210280_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210280_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	if x210280_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210280_g_MoneyJZBonus)
	end
	if x210280_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210280_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210280_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210280_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210280_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210280_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x210280_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210280_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210280_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end