--MisDescBegin
x998655_g_ScriptId = 998655
x998655_g_MissionId = 2251

--下一任务
x998655_g_NextScriptId = 998656
x998655_g_NextMissionId = 2252

--kdzz
x998655_g_KDZZID = 1006000598
x998655_g_KDZZSubID = 1

--接任务npc
x998655_g_AcceptNPC_Name=""--接任务的npc或者npc列表

--任务数据
x998655_g_MissionKind = 9
x998655_g_MissionLevel = 50
x998655_g_IfMissionElite = 0
x998655_g_IsMissionOkFail = 0--任务完成标志位(一定要为0)

x998655_g_MissionName="#{SFYD_231227_28}"--任务名
x998655_g_MissionTarget="#{SFYD_231227_281}"--任务目标(任务面板中任务信息显示内容)

--自定义完成情况，内容不能使用字典，分别对应missionparam的第1位后延
x998655_g_Custom = {{id="在江湖盟会中择一前往",num=1}}

--npc距离
x998655_g_NpcDist = 5

--任务npc
x998655_g_NpcList = 
{
	[51905] = {	IdentityId=IDENTITY_COOKING_IDX,submitsuc="#{SFYD_231227_93}",submiterror="#{SFYD_231227_101}",submitok="#{SFYD_231227_115}",},		--烹饪NPC
	[51906] = {	IdentityId=IDENTITY_PHARMACY_IDX,submitsuc="#{SFYD_231227_94}",submiterror="#{SFYD_231227_102}",submitok="#{SFYD_231227_116}", },		--制药NPC
	[51907] = {	IdentityId=IDENTITY_ATTACKEQUIP_IDX,submitsuc="#{SFYD_231227_96}",submiterror="#{SFYD_231227_104}",submitok="#{SFYD_231227_118}", },	--攻具NPC
	[51909] = {	IdentityId=IDENTITY_ENGINEER_IDX,submitsuc="#{SFYD_231227_98}",submiterror="#{SFYD_231227_106}",submitok="#{SFYD_231227_120}", },		--工程NPC
}

--MisDescEnd
x998655_g_MaxPage = 4

x998655_g_MoneyJZBonus = 20000
--**********************************
--任务入口函数
--**********************************
function x998655_OnDefaultEvent( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if (IsMissionHaveDone(sceneId,selfId,x998655_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x998655_g_MissionId) > 0)  then
		if x998655_g_NpcList[nMonsterDataId] ~= nil then
			BeginEvent(sceneId)
				AddText(sceneId,x998655_g_NpcList[nMonsterDataId].submitsuc)
--				AddMoneyJZBonus( sceneId, x998655_g_MoneyJZBonus )
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x998655_g_ScriptId,x998655_g_MissionId)
		end
	end
end
--**********************************
--列举事件
--**********************************
function x998655_OnEnumerate( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998655_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998655_g_MissionId) > 0 then
		if x998655_g_NpcList[nMonsterDataId] ~= nil then
			AddNumText(sceneId, x998655_g_ScriptId,x998655_g_MissionName,2,-1);
		end
	--满足任务接收条件
--	elseif x998655_CheckAccept(sceneId,selfId) > 0 then
--		if GetName(sceneId,targetId) == x998655_g_AccomplishNPC_Name then
--			AddNumText(sceneId,x998655_g_ScriptId,"#G"..x998655_g_MissionName,1,-1);
--		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x998655_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x998655_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x998655_g_MissionLevel then
		return 0
	end
	
	return 1
end
--**********************************
--客户端请求接收任务
--**********************************
function x998655_OnAccept(sceneId,selfId,nIndex)
	if nIndex < 1 or nIndex > x998655_g_MaxPage then
		return
	end
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < x998655_g_MissionLevel then
		x998655_NotifyTips(sceneId,selfId,"#{SFYD_231227_35}")
		return
	end
	--任务完成了
	if IsMissionHaveDone(sceneId,selfId,x998655_g_MissionId) > 0 then
		--关闭UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 2);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 99865501)
		x998655_NotifyTips(sceneId,selfId,"#{SFYD_231227_42}")
		return
	end
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x998655_NotifyTips(sceneId,selfId,"#{SFYD_231227_36}")
		return
	end
	--加入任务到玩家列表
	if IsHaveMission(sceneId,selfId,x998655_g_MissionId) <= 0 then
		local ret = AddMission(sceneId,selfId, x998655_g_MissionId, x998655_g_ScriptId, 0, 0, 0)
		if ret <= 0 then
			x998655_NotifyTips(sceneId,selfId,"#{SFYD_231227_44}")
			return
		end
		--成功接取任务
		x998655_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{SFYD_231227_45}",x998655_g_MissionName))
	end
	--自动寻路
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nIndex)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,99865502)
end

--**********************************
--放弃
--**********************************
function x998655_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x998655_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x998655_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998655_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x998655_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998655_g_NpcList[nMonsterDataId] == nil then
		return
	end
	if x998655_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x998655_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SFYD_231227_121}",format("#{_EXCHG%d}",x998655_g_MoneyJZBonus)))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
--		LuaFnAddExp( sceneId, selfId, x998655_g_ExpBonus)
		DelMission( sceneId, selfId, x998655_g_MissionId )
		MissionCom( sceneId, selfId, x998655_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SFYD_231227_122}",x998655_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--关闭入口
--		BeginUICommand(sceneId)
--			UICommand_AddInt(sceneId, 0);
--		EndUICommand(sceneId)
--		DispatchUICommand(sceneId,selfId, 9986550)
--		下一阶段任务
--		CallScriptFunction(x998655_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998655_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998655_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998655_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--呼出客户端界面
--**********************************
function x998655_OnOpenUI(sceneId,selfId)
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < x998655_g_MissionLevel then
		x998655_NotifyTips(sceneId,selfId,"#{SFYD_231227_35}")
		return
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)	--flag
		if IsHaveMission(sceneId,selfId,x998655_g_MissionId) > 0 then
			UICommand_AddInt(sceneId,1)	--bShow
		else
			UICommand_AddInt(sceneId,0)	--bShow
		end
		UICommand_AddInt(sceneId,1)	--nPage 1-4
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,99865501)
end
--**********************************
--玩家登录
--**********************************
--最终任务ID
x998655_g_FinalMissionId = 2254
function x998655_OnHumanLogin(sceneId,selfId)
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < x998655_g_MissionLevel then
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x998655_g_FinalMissionId) > 0 then
		--关闭快捷入口
		LuaFnUpdateQuickEnter(sceneId,selfId,23,0)
	else
		--打开快捷入口
		LuaFnUpdateQuickEnter(sceneId,selfId,23,1)
	end
end

--**********************************
-- 屏幕中间提示
--**********************************
function x998655_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
