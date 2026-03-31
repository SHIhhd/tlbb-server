--MisDescBegin
x891093_g_ScriptId = 891093
x891093_g_KDZZID = 1006000022
--任务号
x891093_g_MissionId = 2013
x891093_g_LastMissionId = 2012

--任务归类
x891093_g_MissionKind = 9

--任务等级
x891093_g_MissionLevel = 80

--是否是精英任务
x891093_g_IfMissionElite = 0


--任务名
x891093_g_PreMissionName="#{YXDHYD_20210207_93}"
x891093_g_MissionName="#{YXDHYD_20210207_94}"
x891093_g_MissionTarget="#{YXDHYD_20210207_206}"
x891093_g_ContinueInfo ="#{YXDHYD_20210207_202}"
x891093_g_MissionComplete="#{YXDHYD_20210207_205}"
x891093_g_IsMissionOkFail = 0		
x891093_g_Custom1 = {{id = "参与兵行四象",num = 1}}

--完成任务NPC属性
x891093_g_Position_X=193
x891093_g_Position_Z=144
x891093_g_SceneID=1
x891093_g_AccomplishNPC_Name="种师道"
--奖励
x891093_g_MoneyJZBonus					=100000
x891093_g_ExpBonus						=850000
x891093_g_ItemBonus={id=39920091 ,num=10}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x891093_OnDefaultEvent( sceneId, selfId, targetId )
	local nCheck,nTips,nMsgBox = x891093_CheckAccept(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x891093_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891093_g_MissionId) > 0 then
		if x891093_CheckSubmit(sceneId,selfId) == 0 then
			x891093_MsgBox(sceneId,selfId,targetId,"#{YXDHYD_20210207_204}")
			return
		end
		--提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x891093_g_MissionName)
			AddText(sceneId,x891093_g_MissionComplete)
			AddMoneyJZBonus(sceneId,x891093_g_MoneyJZBonus)
			AddItemBonus(sceneId,x891093_g_ItemBonus.id,x891093_g_ItemBonus.num)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x891093_g_ScriptId,x891093_g_MissionId)
	elseif nCheck > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x891093_g_MissionName)
			AddText(sceneId,x891093_g_ContinueInfo)
			AddMoneyJZBonus( sceneId,x891093_g_MoneyJZBonus)
			AddItemBonus(sceneId,x891093_g_ItemBonus.id,x891093_g_ItemBonus.num)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x891093_g_ScriptId,x891093_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x891093_OnEnumerate( sceneId, selfId, targetId )
	local nCheck,nTips,nMsgBox = x891093_CheckAccept(sceneId,selfId)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x891093_g_MissionId) > 0 then
	    AddNumText(sceneId, x891093_g_ScriptId, "#{YXDHYD_20210325_22}", 2, -1)
	elseif nCheck > 0 then
		AddNumText(sceneId, x891093_g_ScriptId, "#{YXDHYD_20210325_22}", 1, -1)
	end
end
--**********************************
--检测接受条件
--**********************************
function x891093_CheckAccept(sceneId,selfId)
	--第一个返回接口为是否可接取，2返回tips  3返回msbox
	if GetLevel(sceneId,selfId) < x891093_g_MissionLevel then
		return 0,"#{YXDHYD_20210207_102}","#{YXDHYD_20210207_101}"
	elseif IsMissionHaveDone(sceneId,selfId,x891093_g_LastMissionId) <= 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210207_104}",x891093_g_PreMissionName),ScriptGlobal_Format("#{YXDHYD_20210207_103}",x891093_g_PreMissionName)
	elseif IsHaveMission(sceneId,selfId,x891093_g_MissionId) > 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210205_54}",x891093_g_MissionName),""
	elseif IsMissionHaveDone(sceneId,selfId,x891093_g_MissionId) > 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210207_108}",x891093_g_MissionName),ScriptGlobal_Format("#{YXDHYD_20210207_107}",x891093_g_MissionName)
	elseif GetMissionCount(sceneId,selfId) >= 20 then
		return 0,"#{YXDHYD_20210205_56}",""
	end
	return 1,"",""
end
--**********************************
--放弃
--**********************************
function x891093_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891093_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,x891093_g_SceneID,x891093_g_AccomplishNPC_Name)
end
--**********************************
--接取任务
--**********************************
function x891093_OnAccept(sceneId,selfId)
	local nCheck,nTips,nMsgBox = x891093_CheckAccept(sceneId,selfId)
	if nCheck == 0 then
		if nTips ~= "" then
			x891093_NotifyTips(sceneId,selfId,nTips)
		end
		if nMsgBox ~= "" then
			x891093_MsgBox(sceneId,selfId,-1,nMsgBox)
		end
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x891093_g_MissionId, x891093_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891093_NotifyTips(sceneId,selfId,"#{YXDHYD_20210205_56}")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891093_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	x891093_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_06}",x891093_g_MissionName))
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, x891093_g_SceneID, x891093_g_Position_X, x891093_g_Position_Z, x891093_g_AccomplishNPC_Name)
	x891093_MsgBox(sceneId,selfId,-1,"#{YXDHYD_20210207_203}")
end
--**********************************
--参加一次兵行四象
--**********************************
function x891093_OnFinish(sceneId,selfId)
	if IsHaveMission(sceneId,selfId,x891093_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891093_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,1)
	SetMissionByIndex(sceneId,selfId,misIndex,1,1)
end
--**********************************
--检测是否可以提交
--**********************************
function x891093_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891093_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	if param == 0 then
		return 0
	end
	return 1
end
--**********************************
--提交
--**********************************
function x891093_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x891093_g_MissionId) <= 0 then
		return
	end
	if x891093_CheckSubmit(sceneId,selfId) == 0 then
		return
	end
	--增加四象荣誉
	local nRYFinal = 10
	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU,GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU) + nRYFinal)
	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU_HIS,GetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_SIXIANGRONGYU_HIS) + nRYFinal)
	
	if x891093_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x891093_g_MoneyJZBonus)
	end
	if x891093_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x891093_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x891093_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x891093_g_MissionId)
	x891093_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_20210309_03}",GetItemName(sceneId,x891093_g_ItemBonus.id),x891093_g_ItemBonus.num))
	x891093_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_02}",x891093_g_MissionName))
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891093_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x891093_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891093_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x891093_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x891093_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end