--MisDescBegin
x891281_g_ScriptId = 891281
x891281_g_MainScriptId = 891272--主脚本号
x891281_g_NpcScriptId = 891273--npc脚本号

x891281_g_KDZZID = 1006000536
x891281_g_KDZZSubID = 8

--任务号
x891281_g_MissionId = 2037
x891281_g_MissionKind = 7
x891281_g_MissionLevel = 60
x891281_g_IfMissionElite = 0

--任务名
x891281_g_MissionName="#{XLRW_210725_479}"
x891281_g_MissionTarget=""
x891281_g_Custom = {}

--任务参数
x891281_g_IsMissionOkFail = 0	--是否完成
x891281_g_MissionLiuPai = 1		-- 本流派
x891281_g_MissionMenPai = 2		-- 本门派

--npc距离
x891281_g_NpcDist = 5

--背包空位
x891281_g_BagSpace = 1

--奖励
--x891281_g_MoneyJZBonus					= 30000
--x891281_g_ExpBonus						= 2500000

--MisDescEnd
--目标NPC：接任务、交任务，都是这个
x891281_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}}, --替代2022
}
--**********************************
--接取任务
--**********************************
function x891281_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891281_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891281_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891281_g_NpcDist) ~= 1 then
		x891281_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891281_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891281_g_MissionLevel then
		x891281_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891281_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetTaskItemBagSpace( sceneId, selfId ) < x891281_g_BagSpace then
		x891281_NotifyTip( sceneId, selfId, "#{XLRW_210725_46}" )
		x891281_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891281_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891281_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891281_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891281_g_MissionId, x891281_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891281_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891281_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891281_g_MissionId)

	SetMissionByIndex(sceneId,selfId,misIndex,x891281_g_IsMissionOkFail,1)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891281_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891281_g_MissionMenPai,GetMenPai(sceneId,selfId))	

	x891281_NotifyTip( sceneId, selfId, "#{XLRW_210725_696}" )
	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891281_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--XLRW_210725_672	    修行过程中要保持谦逊姿态，多与前辈探讨，才能参悟出其中玄妙。#r    当前任务环数：#G%s0	
	x891281_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_672}",
		tostring(x891281_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891281_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891281_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891281_g_MissionId) <= 0 then
		return
	end
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891281_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
		
	CallScriptFunction(x891281_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891281_g_MissionId)
end
--**********************************
--任务当前环数
--**********************************
function x891281_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end
--**********************************
--放弃
--**********************************
function x891281_OnAbandon( sceneId, selfId )
	CallScriptFunction(x891281_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891281_g_MissionId)
end

--**********************************
--对话窗口信息提示
--**********************************
function x891281_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891281_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
