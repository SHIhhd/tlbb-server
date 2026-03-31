--MisDescBegin

--脚本号
x210264_g_ScriptId = 210264
x210264_g_NextScriptId = 210265

--完成任务NPC属性
x210264_g_Position_X = 265
x210264_g_Position_Z = 129
x210264_g_SceneID = 2
x210264_g_AccomplishNPC_Name = "云飘飘"

--上一个任务的ID
x210264_g_MissionIdPre = 1413

--任务号
x210264_g_MissionId = 1414

--任务目标npc
x210264_g_Name	="云飘飘"

--任务归类
x210264_g_MissionKind = 13

--任务等级
x210264_g_MissionLevel = 7

--是否是精英任务
x210264_g_IfMissionElite = 0

--********下面几项是动态显示的内容，用于在任务列表中动态显示任务情况******

--**********************************以上是动态****************************

--任务文本描述
x210264_g_MissionName="第一只珍兽"
x210264_g_MissionInfo="#{XSRW_100111_32}"  --任务描述
x210264_g_MissionTarget="#{XSRW_100111_90}"		--任务目标
x210264_g_ContinueInfo="#{XSRW_100111_80}"		--未完成任务的npc对话
x210264_g_MissionComplete="#{XSRW_100111_34}"					--完成任务npc说话的话
x210264_g_SignPost = {x = 263, z = 129, tip = "云飘飘"}

x210264_g_IsMissionOkFail = 0		--变量的第0位
x210264_g_Custom	= { {id="小兔子升到2级",num=1} }

--任务奖励
x210264_g_MoneyJZBonus=100
x210264_g_ExpBonus=1000
x210264_g_ItemBonus={{id = 30603001,num = 20}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210264_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210264_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210264_g_MissionId) > 0 and GetName(sceneId,targetId) == x210264_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210264_g_MissionName)
			AddText(sceneId, x210264_g_ContinueInfo)
		EndEvent()
		local bDone = x210264_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210264_g_ScriptId,x210264_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210264_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210264_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210264_g_MissionName)
			AddText(sceneId,x210264_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210264_g_MissionTarget)
			AddMoneyJZBonus( sceneId, x210264_g_MoneyJZBonus )
			for _,item in x210264_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210264_g_ScriptId,x210264_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210264_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210264_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210264_g_MissionId) > 0 and GetName(sceneId,targetId) == x210264_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210264_g_ScriptId, x210264_g_MissionName, 2, -1);			
	--满足任务接收条件
	elseif x210264_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210264_g_Name then
		AddNumText(sceneId, x210264_g_ScriptId, x210264_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210264_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210264_g_MissionLevel
	and IsMissionHaveDone(sceneId,selfId,x210264_g_MissionIdPre) > 0 then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210264_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210264_g_MissionId) > 0 then
		return 
	end
	local checkCreatePet = TryCreatePet(sceneId, selfId, 1);
	if not checkCreatePet or checkCreatePet ~= 1 then
		x210264_NotifyTips(sceneId, selfId, "您不能携带更多的珍兽。");
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210264_g_MissionId, x210264_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		x210264_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210264_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210264_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	--给玩家一只珍兽
	LuaFnCreatePetToHuman(sceneId,selfId,559,1,1)
	x210264_NotifyTips(sceneId,selfId,"你得到了一个珍兽!")
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210264_g_SignPost.x, x210264_g_SignPost.z, x210264_g_SignPost.tip )
end

--**********************************
--放弃
--**********************************
function x210264_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210264_g_MissionId )
    --删除任务珍兽
	local petcount = LuaFnGetPetCount(sceneId, selfId) --取得珍兽数量
	for	i=0,petcount-1 do
		petdataid = LuaFnGetPet_DataID(sceneId, selfId, i) --取得珍兽编号
		if petdataid == 559 then
			LuaFnDeletePet(sceneId, selfId, i)
		end
   end
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210264_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210264_OnContinue( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,x210264_g_MissionName)
		AddText(sceneId,x210264_g_MissionComplete)
		AddMoneyJZBonus( sceneId, x210264_g_MoneyJZBonus)
		for _,item in x210264_g_ItemBonus do
			AddItemBonus( sceneId, item.id, item.num )
		end
	EndEvent()
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210264_g_ScriptId,x210264_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210264_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210264_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210264_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210264_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210264_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210264_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
    BeginAddItem(sceneId)
		for i, item in x210264_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x210264_NotifyTips(sceneId,selfId,"背包已满,无法完成任务")
		return
	end
	AddItemListToHuman(sceneId,selfId) --给物品
	if x210264_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210264_g_MoneyJZBonus)
	end
	if x210264_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210264_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210264_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210264_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210264_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210264_OnKillObject( sceneId, selfId, objdataId ,objId )
	local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
	if pgH == nil or pgH <= 0 or pgL == nil or pgL <= 0 then
		return
	end
	local nPetObjLevel = LuaFnGetPetLevelByGUID(sceneId,selfId,pgH,pgL)
	local nPetID = LuaFnGetPetDataIDByGUID(sceneId,selfId,pgH,pgL)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210264_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,x210264_g_IsMissionOkFail)
	if nPetID ~= nil and nPetID == 559 
		and nPetObjLevel ~= nil and nPetObjLevel >= 2 
		and param ~= nil and param == 0 then
		
		SetMissionByIndex(sceneId,selfId,misIndex,x210264_g_IsMissionOkFail,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
		x210264_NotifyTips(sceneId,selfId,"#{XSRW_100111_33}".."1/1")
	end
end

--**********************************
--进入区域事件
--**********************************
function x210264_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210264_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210264_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end