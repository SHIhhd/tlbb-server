--MisDescBegin
--脚本号
x210266_g_ScriptId = 210266
x210266_g_NextScriptId = 210278

--交任务NPC属性
x210266_g_Position_X = 160
x210266_g_Position_Z = 158
x210266_g_SceneID = 2
x210266_g_AccomplishNPC_Name = "赵天师" 

--上一个任务的ID
x210266_g_MissionIdPre =0

--任务号
x210266_g_MissionId = 1417

--任务目标npc
x210266_g_Name	="赵天师" 

x210266_g_ItemId = 30505273

--任务归类
x210266_g_MissionKind = 13

--任务等级
x210266_g_MissionLevel = 8

--是否是精英任务
x210266_g_IfMissionElite = 0

--********下面几项是动态显示的内容，用于在任务列表中动态显示任务情况******
x210266_g_IsMissionOkFail = 0					--变量的第0位
--**********************************以上是动态****************************


--任务文本描述
x210266_g_MissionName="喜庆焰火"
x210266_g_MissionInfo="#{XSRW_100111_39}"  --任务描述至于什么地方合适，你只要打开#Y背包#W里的任务道具栏，右键点一下这个#Y传讯焰火#W，它就能给你相关的提示。
x210266_g_MissionTarget="#{XSRW_100111_95}"		--任务目标
x210266_g_ContinueInfo="#{XSRW_100111_96}"		--未完成任务的npc对话
x210266_g_MissionComplete="#{XSRW_100111_40}"					--完成任务npc说话的话
--x210266_g_ItemBonus={{id=10111000,num=1}}
x210266_g_SignPost = {x = 160, z = 157, tip = "赵天师"}
x210266_g_MoneyJZBonus=100
x210266_g_ExpBonus = 600
x210266_g_SignPost_1 = {x = 139, z = 169, tip = "焰火燃放点"}

x210266_g_Custom	= { {id="已燃放焰火",num=1} }


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210266_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x210266_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x210266_g_MissionId) > 0 and GetName(sceneId,targetId) == x210266_g_AccomplishNPC_Name then
		BeginEvent(sceneId)
			AddText(sceneId, x210266_g_MissionName)
			AddText(sceneId, x210266_g_ContinueInfo)
		EndEvent()
		local bDone = x210266_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x210266_g_ScriptId,x210266_g_MissionId,bDone)
	--满足任务接收条件
  elseif x210266_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210266_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x210266_g_MissionName)
			AddText(sceneId,x210266_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}")
			AddText(sceneId,x210266_g_MissionTarget)
			AddMoneyJZBonus( sceneId, x210266_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x210266_g_ScriptId,x210266_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x210266_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210266_g_MissionId) > 0 then
		return
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x210266_g_MissionId) > 0 and GetName(sceneId,targetId) == x210266_g_AccomplishNPC_Name then
		AddNumText(sceneId, x210266_g_ScriptId, x210266_g_MissionName, 2, -1);		
	--满足任务接收条件
	elseif x210266_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x210266_g_Name then
		AddNumText(sceneId, x210266_g_ScriptId, x210266_g_MissionName, 1, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x210266_CheckAccept( sceneId, selfId )
	--需要1级才能接
	if GetLevel(sceneId,selfId) >= x210266_g_MissionLevel then
		return 1
	else
		return 0
	end
end

--**********************************
--接受
--**********************************
function x210266_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x210266_g_MissionId) > 0 then
		return 
	end
	--给焰火
	BeginAddItem(sceneId)
		AddItem( sceneId,x210266_g_ItemId,1)
	if EndAddItem(sceneId,selfId) <= 0 then
		x210266_NotifyTips(sceneId,selfId,"背包已满，无法接受任务")
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x210266_g_MissionId, x210266_g_ScriptId,0,0,0)
	if ret <= 0 then
		x210266_NotifyTips(sceneId,selfId,"你的任务已满。")
		return
	end
	AddItemListToHuman(sceneId,selfId)
	x210266_NotifyTips(sceneId,selfId,"你得到了喜庆焰火。")
	local misIndex = GetMissionIndexByID(sceneId, selfId, x210266_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x210266_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210266_g_SignPost_1.x, x210266_g_SignPost_1.z, x210266_g_SignPost_1.tip )
end

--**********************************
--放弃
--**********************************
function x210266_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x210266_g_MissionId )
	--删除物品
	DelItem(sceneId,selfId,x210266_g_ItemId,1)
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210266_g_SignPost_1.tip)
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,sceneId,x210266_g_SignPost.tip)
end

--**********************************
--继续
--**********************************
function x210266_OnContinue( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,x210266_g_MissionName)
		AddText(sceneId,x210266_g_MissionComplete)
		AddMoneyJZBonus( sceneId, x210266_g_MoneyJZBonus)
	EndEvent()
	DispatchMissionContinueInfo(sceneId,selfId,targetId,x210266_g_ScriptId,x210266_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210266_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210266_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x210266_g_IsMissionOkFail)
	if param > 0 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x210266_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x210266_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x210266_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	if x210266_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x210266_g_MoneyJZBonus)
	end
	if x210266_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x210266_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x210266_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x210266_g_MissionId)
	--下一阶段任务
	CallScriptFunction(x210266_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210266_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x210266_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210266_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--道具使用
--**********************************
function x210266_OnUseItem( sceneId, selfId, BagIndex )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x210266_g_MissionId)
	--地图不在大理无法使用
	if sceneId ~= 2 then
		return
	end
	--取得玩家当前坐标
	local PlayerX = GetHumanWorldX(sceneId,selfId)
	local PlayerZ = GetHumanWorldZ(sceneId,selfId)
	--计算玩家与宝藏的距离
	local Distance = floor(sqrt((x210266_g_SignPost_1.x-PlayerX)*(x210266_g_SignPost_1.x-PlayerX)+(x210266_g_SignPost_1.z-PlayerZ)*(x210266_g_SignPost_1.z-PlayerZ)))
	if Distance > 5 then
		x210266_NotifyTips(sceneId,selfId,"距离施放喜庆焰火的地方还有"..Distance.."米")
		return
	end
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,4825,0);
	x210266_NotifyTips(sceneId,selfId,"施放喜庆焰火成功，快回去找赵天师吧。")
	SetMissionByIndex(sceneId,selfId,misIndex,x210266_g_IsMissionOkFail,1)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	DelItem(sceneId,selfId,x210266_g_ItemId,1) --扣除物品
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, sceneId, x210266_g_SignPost.x, x210266_g_SignPost.z, x210266_g_SignPost.tip )
end
--**********************************
--珍兽改变
--**********************************
function x210266_OnPetChanged( sceneId, selfId, petdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x210266_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end