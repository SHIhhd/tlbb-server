--MisDescBegin
--脚本号
x891083_g_ScriptId = 891083

--完成任务NPC属性
x891083_g_Position_X=129  --替代
x891083_g_Position_Z=107 --替代
x891083_g_SceneID=1
x891083_g_AccomplishNPC_Name="沈夜雨"

--任务号
x891083_g_PreMissionId = 2002 --替代
x891083_g_MissionId = 2003 --替代

--目标NPC
x891083_g_mPosX = 129
x891083_g_mPosZ = 107
x891083_g_mSceneID = 1
x891083_g_Name	="沈夜雨"

--任务归类
x891083_g_MissionKind = 9

--任务等级
x891083_g_MissionLevel = 80 --10000

--是否是精英任务
x891083_g_IfMissionElite = 0

--任务名
x891083_g_PreMissionName="#{YXDHYD_20210207_83}"
x891083_g_MissionName="#{YXDHYD_20210207_84}"
x891083_g_MissionTarget=""
x891083_g_IsMissionOkFail=0
x891083_g_Custom = {} --替代
x891083_g_ContinueInfo = "#{YXDHYD_20210207_134}"
x891083_g_MissionComplete = "#{YXDHYD_20210207_138}"

x891083_g_MoneyJZBonus = 30000
x891083_g_ExpBonus = 2000000

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x891083_OnDefaultEvent( sceneId, selfId, targetId )
	local nCheck,nTips,nMsgBox = x891083_CheckAccept(sceneId,selfId)
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891083_g_MissionId)
	local Isok = GetMissionParam(sceneId,selfId,nMisIndex,x891083_g_IsMissionOkFail)
	if GetNumText() == 2003 then
		CallScriptFunction(891099,"OnDefaultEvent",sceneId,selfId,targetId) --跳转夜探水月山庄接口
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x891083_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891083_g_MissionId) > 0 then
		if Isok == 0 then
			local nCount = LuaFnGetAvailableItemCount(sceneId,selfId,38002222)
			BeginEvent(sceneId)
				if nCount >= 1 then
					AddText(sceneId,"#{YXDHYD_20210207_136}")
					AddNumText(sceneId,x891083_g_ScriptId,"#{YXDHYD_20210325_04}",10,2003)
				else
					AddText(sceneId,"#{YXDHYD_20210207_137}")
				end
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x891083_g_MissionName)
			AddText(sceneId,x891083_g_MissionComplete)
			AddMoneyJZBonus(sceneId,x891083_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x891083_g_ScriptId,x891083_g_MissionId)
	elseif nCheck > 0 and GetName(sceneId,targetId) == x891083_g_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x891083_g_MissionName)
			AddText(sceneId,x891083_g_ContinueInfo)
			AddMoneyJZBonus( sceneId,x891083_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x891083_g_ScriptId,x891083_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x891083_OnEnumerate( sceneId, selfId, targetId )
	local nCheck,nTips,nMsgBox = x891083_CheckAccept(sceneId,selfId)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x891083_g_MissionId) > 0 then
	    AddNumText(sceneId, x891083_g_ScriptId, "#{YXDHYD_20210325_12}", 2, -1)
	elseif nCheck > 0 then
		AddNumText(sceneId, x891083_g_ScriptId, "#{YXDHYD_20210325_12}", 1, -1)
	end
end
--**********************************
--检测接受条件
--**********************************
function x891083_CheckAccept(sceneId,selfId)
	--第一个返回接口为是否可接取，2返回tips  3返回msbox
	if GetLevel(sceneId,selfId) < x891083_g_MissionLevel then
		return 0,"#{YXDHYD_20210207_102}","#{YXDHYD_20210207_101}"
	elseif IsMissionHaveDone(sceneId,selfId,x891083_g_PreMissionId) <= 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210207_104}",x891083_g_PreMissionName),ScriptGlobal_Format("#{YXDHYD_20210207_103}",x891083_g_PreMissionName)
	elseif IsHaveMission(sceneId,selfId,x891083_g_MissionId) > 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210205_54}",x891083_g_MissionName),""
	elseif IsMissionHaveDone(sceneId,selfId,x891083_g_MissionId) > 0 then
		return 0,ScriptGlobal_Format("#{YXDHYD_20210207_108}",x891083_g_MissionName),ScriptGlobal_Format("#{YXDHYD_20210207_107}",x891083_g_MissionName)
	elseif GetMissionCount(sceneId,selfId) >= 20 then
		return 0,"#{YXDHYD_20210205_56}",""
	end
	return 1,"",""
end
--**********************************
--放弃
--**********************************
function x891083_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891083_g_MissionId )
	--去除问路
	CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId,selfId,x891083_g_SceneID,x891083_g_AccomplishNPC_Name)
end
--**********************************
--接取任务
--**********************************
function x891083_OnAccept(sceneId,selfId,targetId)
	local nCheck,nTips,nMsgBox = x891083_CheckAccept(sceneId,selfId)
	if nCheck == 0 then
		if nTips ~= "" then
			x891083_NotifyTips(sceneId,selfId,nTips)
		end
		if nMsgBox ~= "" then
			x891083_MsgBox(sceneId,selfId,-1,nMsgBox)
		end
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x891083_g_MissionId, x891083_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891083_NotifyTips(sceneId,selfId,"#{YXDHYD_20210205_56}")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891083_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	x891083_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_06}",x891083_g_MissionName))
	--问路
	CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, x891083_g_SceneID, x891083_g_Position_X, x891083_g_Position_Z, x891083_g_AccomplishNPC_Name)
	x891083_OnDefaultEvent(sceneId,selfId,targetId)
end
--**********************************
--检测是否可以提交
--**********************************
function x891083_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x891083_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	if param == 0 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891083_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x891083_g_MissionId) <= 0 then
		return
	end
	if x891083_CheckSubmit(sceneId,selfId) == 0 then
		return
	end
	if x891083_g_MoneyJZBonus > 0 then
		AddMoneyJZ(sceneId,selfId,x891083_g_MoneyJZBonus)
	end
	if x891083_g_ExpBonus > 0 then
		LuaFnAddExp(sceneId,selfId,x891083_g_ExpBonus)
	end
	DelMission( sceneId,selfId, x891083_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x891083_g_MissionId)
	--扣除百里香
	LuaFnDelAvailableItem(sceneId, selfId, 38002222, 1)
	x891083_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YXDHYD_210223_02}",x891083_g_MissionName))
	--下一阶段任务
	CallScriptFunction(891084,"OnDefaultEvent",sceneId,selfId,targetId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891083_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x891083_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891083_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x891083_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x891083_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end