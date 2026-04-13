--MisDescBegin
--脚本号
x210256_g_ScriptId = 210256
x210256_g_NextScriptId = 210257

--交任务NPC属性
x210256_g_Position_X=238
x210256_g_Position_Z=171
x210256_g_SceneID=2
x210256_g_AccomplishNPC_Name="黄公道"

--任务号
x210256_g_MissionId = 1402

--上一个任务的ID
x210256_g_MissionIdPre = 1401

--接任务NPC
x210256_g_Name	="蒲良"

--任务归类
x210256_g_MissionKind = 13

--任务等级
x210256_g_MissionLevel = 1
x210256_g_MinMissionLevel = 1

--是否是精英任务
x210256_g_IfMissionElite = 0

--任务名
x210256_g_MissionName="第一件防具"
x210256_g_MissionTarget="#{XSRW_100111_56}"
x210256_g_MissionInfo="#{XSRW_100111_6}"
x210256_g_ContinueInfo ="#{XSRW_100111_68}"
x210256_g_MissionComplete="#{XSRW_100111_7}"
x210256_g_MoneyJZBonus=1
x210256_g_ExpBonus = 500
x210256_g_SignPost = {x = 238, z = 171, tip = "黄公道"}

x210256_g_RadioItemBonus={}
x210256_g_ItemBonus={{id=10113000 ,num=1}}

x210256_g_Custom	= { {id="已找到黄公道",num=1} }
x210256_g_IsMissionOkFail = 0		--变量的第0位


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210256_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210256_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210256_g_MissionId) > 0 and GetName(sceneId,targetId) == x210256_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210256_g_MissionName)
			AddText(sceneId, x210256_g_MissionComplete)
			AddMoneyJZBonus( sceneId, x210256_g_MoneyJZBonus )
			for _,item in x210256_g_ItemBonus do
				AddItemBonus(sceneId,item.id,item.num)
			end
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x210256_g_ScriptId,x210256_g_MissionId)
	--满足任务接收条件
  elseif x210256_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210256_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210256_g_MissionName)
			AddText(sceneId,x210256_g_MissionInfo)
			for _,item in x210256_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
			AddMoneyJZBonus( sceneId, x210256_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210256_g_ScriptId,x210256_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210256_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210256_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210256_g_MissionId) > 0 and GetName(sceneId,targetId) == x210256_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210256_g_ScriptId, x210256_g_MissionName, 2, -1);		
	--满足任务接收条件
	elseif x210256_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210256_g_Name then
		AddNumText(sceneId, x210256_g_ScriptId, x210256_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210256_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210256_g_MissionLevel
	and IsMissionHaveDone(sceneId,selfId,x210256_g_MissionIdPre) > 0
	and IsHaveMission(sceneId,selfId,x210256_g_MissionId) <= 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210256_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210256_g_MissionId) > 0 then
		return 
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210256_g_MissionId, x210256_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x210256_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210256_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210256_g_IsMissionOkFail,1)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210256_g_SignPost.x, x210256_g_SignPost.z, x210256_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210256_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210256_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210256_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210256_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x210256_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210256_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210256_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210256_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210256_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210256_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
    BeginAddItem(sceneId)
		for i, item in x210256_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x210256_NotifyTips(sceneId,selfId,"背包已满,无法完成任务")
		return
	end
	AddItemListToHuman(sceneId,selfId) --给物品
	if x210256_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210256_g_MoneyJZBonus)
	end
	if x210256_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210256_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210256_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210256_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210256_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210256_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x210256_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210256_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210256_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end