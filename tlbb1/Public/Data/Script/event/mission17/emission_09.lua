--MisDescBegin
--脚本号
x891088_g_ScriptId = 891088

--完成任务NPC属性
x891088_g_Position_X=137  --替代
x891088_g_Position_Z=180 --替代
x891088_g_SceneID=2
x891088_g_AccomplishNPC_Name="武泽"

--任务号
x891088_g_PreMissionId = 2007 --替代
x891088_g_MissionId = 2008 --替代

--目标NPC
x891088_g_mSceneID=2
x891088_g_Name="武泽"

--任务归类
x891088_g_MissionKind = 9

--任务等级
x891088_g_MissionLevel = 80 --10000

--是否是精英任务
x891088_g_IfMissionElite = 0

--任务名
x891088_g_PreMissionName="#{YXDHYD_20210207_88}"
x891088_g_MissionName="#{YXDHYD_20210207_89}"
x891088_g_MissionTarget="#{YXDHYD_20210207_182}"
x891088_g_IsMissionOkFail=0
x891088_g_Custom = {{ id = "激活幻魂", num = 1}}
x891088_g_ContinueInfo = "#{YXDHYD_20210207_178}"
x891088_g_MissionComplete = "#{YXDHYD_20210207_181}"

x891088_g_MoneyJZBonus = 30000
x891088_g_ExpBonus = 250000
x891088_g_ItemBonus={{id=20800013,num=2}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x891088_OnDefaultEvent( sceneId, selfId, targetId )
	local nCheck,nTips,nMsgBox = x891088_CheckAccept(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x891088_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891088_g_MissionId) > 0 then
		if x891088_CheckSubmit(sceneId,selfId) == 0 then
			x891088_MsgBox(sceneId,selfId,targetId,"#{YXDHYD_20210207_180}")
			return
		end
		--提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x891088_g_MissionName)
			AddText(sceneId,x891088_g_MissionComplete)
			AddMoneyJZBonus(sceneId,x891088_g_MoneyJZBonus)
			for _,item in x891088_g_ItemBonus do
				AddItemBonus(sceneId,item.id,item.num)
			end
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x891088_g_ScriptId,x891088_g_MissionId)
	elseif nCheck > 0 and GetName(sceneId,targetId) == x891088_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x891088_g_MissionName)
			AddText(sceneId,x891088_g_ContinueInfo)
			AddMoneyJZBonus( sceneId,x891088_g_MoneyJZBonus)
			for _,item in x891088_g_ItemBonus do
				AddItemBonus(sceneId,item.id,item.num)
			end
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x891088_g_ScriptId,x891088_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x891088_OnEnumerate( sceneId, selfId, targetId )
	local nCheck,nTips,nMsgBox = x891088_CheckAccept(sceneId,selfId)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x891088_g_MissionId) > 0 then
	    AddNumText(sceneId, x891088_g_ScriptId, "#{YXDHYD_20210325_17}", 2, -1)
	elseif nCheck > 0 then
		AddNumText(sceneId, x891088_g_ScriptId, "#{YXDHYD_20210325_17}", 1, -1)
	end
end
--**********************************
--检测接受条件
--**********************************
function x891088_CheckAccept(sceneId,selfId)
	--第一个返回接口为是否可接取，2返回tips  3返回msbox
	if GetLevel(sceneId,selfId) < x891088_g_MissionLevel then
		return 0,"#{YXDHYD_20210207_102}","#{YXDHYD_20210207_101}"
	elseif IsMissionHaveDone(sceneId,selfId,x891088_g_PreMissionId) <= 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210207_104}",x891088_g_PreMissionName),ScriptGlobal_Format("#{YXDHYD_20210207_103}",x891088_g_PreMissionName)
	elseif IsHaveMission(sceneId,selfId,x891088_g_MissionId) > 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210205_54}",x891088_g_MissionName),""
	elseif IsMissionHaveDone(sceneId,selfId,x891088_g_MissionId) > 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210207_108}",x891088_g_MissionName),ScriptGlobal_Format("#{YXDHYD_20210207_107}",x891088_g_MissionName)
	elseif GetMissionCount(sceneId,selfId) >= 20 then
		return 0,"#{YXDHYD_20210205_56}",""
	elseif LuaFnGetTaskItemBagSpace(sceneId,selfId) < 1 then
		return 0,"#{YXDHYD_20210207_168}",""
	end
	return 1,"",""
end
--**********************************
--放弃
--**********************************
function x891088_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891088_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,x891088_g_SceneID,x891088_g_AccomplishNPC_Name)
end
--**********************************
--接取任务
--**********************************
function x891088_OnAccept(sceneId,selfId)
	local nCheck,nTips,nMsgBox = x891088_CheckAccept(sceneId,selfId)
	if nCheck == 0 then
		if nTips ~= "" then
			x891088_NotifyTips(sceneId,selfId,nTips)
		end
		if nMsgBox ~= "" then
			x891088_MsgBox(sceneId,selfId,-1,nMsgBox)
		end
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x891088_g_MissionId, x891088_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891088_NotifyTips(sceneId,selfId,"#{YXDHYD_20210205_56}")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891088_g_MissionId)
	local IsLock = 0
	for i = 1,6 do
		local _,bUnlock,_ = LuaFnGetWHWGInfo(sceneId,selfId,i)
		if bUnlock == 1 then
			IsLock = i
			break
		end
	end
	if IsLock > 0 then
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	else
		SetMissionByIndex(sceneId,selfId,misIndex,0,0)
		SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	end
	x891088_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_06}",x891088_g_MissionName))
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, x891088_g_SceneID, x891088_g_Position_X, x891088_g_Position_Z, x891088_g_AccomplishNPC_Name)
	x891088_MsgBox(sceneId,selfId,-1,"#{YXDHYD_20210207_179}")
end
--**********************************
--检测是否可以提交
--**********************************
function x891088_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891088_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	if param == 0 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891088_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x891088_g_MissionId) <= 0 then
		return
	end
	if x891088_CheckSubmit(sceneId,selfId) == 0 then
		return
	end
    BeginAddItem(sceneId)
		for i, item in x891088_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	AddItemListToHuman(sceneId,selfId) --给物品
	if x891088_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x891088_g_MoneyJZBonus)
	end
	if x891088_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x891088_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x891088_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x891088_g_MissionId)
	x891088_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_20210309_03}",GetItemName(sceneId,x891088_g_ItemBonus[1].id),x891088_g_ItemBonus[1].num))
	x891088_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_02}",x891088_g_MissionName))
	--下一阶段任务
	CallScriptFunction(891089,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891088_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x891088_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891088_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x891088_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x891088_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end