--MisDescBegin
x998657_g_ScriptId = 998657
x998657_g_MissionId = 2253

--前置任务
x998657_g_PreScriptId = 998657
x998657_g_PreMissionId = 2255
x998657_g_PreMissionName="#{SFYD_231227_29}"

--下一任务
x998657_g_NextScriptId = 998658
x998657_g_NextMissionId = 2254

--kdzz
x998657_g_KDZZID = 1006000598
x998657_g_KDZZSubID = 3

--接任务npc
x998657_g_AcceptNPC_Name=""--接任务的npc或者npc列表

--任务数据
x998657_g_MissionKind = 9
x998657_g_MissionLevel = 50
x998657_g_IfMissionElite = 0
x998657_g_IsMissionOkFail = 0--任务完成标志位(一定要为0)

x998657_g_MissionName="#{SFYD_231227_30}"--任务名
x998657_g_MissionTarget=""--任务目标(任务面板中任务信息显示内容)

--自定义完成情况，内容不能使用字典，分别对应missionparam的第1位后延
x998657_g_Custom = {}

--npc距离
x998657_g_NpcDist = 5

--任务npc
x998657_g_NpcList = 
{
	[51905] = {	IdentityId=IDENTITY_COOKING_IDX,acceptsuc="#{SFYD_231227_150}",accepterror="#{SFYD_231227_85}",acceptok="#{SFYD_231227_159}",
							submitfail="#{SFYD_231227_177}",submitsuc="#{SFYD_231227_190}",submiterror="#{SFYD_231227_101}",submitok="#{SFYD_231227_196}",},		--烹饪NPC
	[51906] = {	IdentityId=IDENTITY_PHARMACY_IDX,acceptsuc="#{SFYD_231227_151}",accepterror="#{SFYD_231227_86}",acceptok="#{SFYD_231227_160}",
							submitfail="#{SFYD_231227_178}",submitsuc="#{SFYD_231227_191}",submiterror="#{SFYD_231227_102}",submitok="#{SFYD_231227_197}",},		--制药NPC
	[51907] = {	IdentityId=IDENTITY_ATTACKEQUIP_IDX,acceptsuc="#{SFYD_231227_153}",accepterror="#{SFYD_231227_88}",acceptok="#{SFYD_231227_162}",
							submitfail="#{SFYD_231227_180}",submitsuc="#{SFYD_231227_193}",submiterror="#{SFYD_231227_104}",submitok="#{SFYD_231227_199}",},	--攻具NPC
	[51909] = {	IdentityId=IDENTITY_ENGINEER_IDX,acceptsuc="#{SFYD_231227_155}",accepterror="#{SFYD_231227_90}",acceptok="#{SFYD_231227_164}",
							submitfail="#{SFYD_231227_182}",submitsuc="#{SFYD_231227_195}",submiterror="#{SFYD_231227_106}",submitok="#{SFYD_231227_201}",},		--工程NPC
}

--MisDescEnd
x998657_g_MoneyJZBonus = 20000

x998657_g_List1 = 
{
	21000000,
	21000004,
	21000008,
	21000016,
}
--一夕纯火
x998657_g_List2 = 21000044
--探访场景
x998657_g_EnterScene = 3
x998657_g_EnterSceneTips = 
{
	"#{SFYD_231227_262}",
	"#{SFYD_231227_263}",
	"#{SFYD_231227_264}",
	"#{SFYD_231227_265}",
}
x998657_g_GetList1 = 1
x998657_g_GetList2 = 4
--**********************************
--任务入口函数
--**********************************
function x998657_OnDefaultEvent( sceneId, selfId, targetId )
	--设置任务的跟踪参数
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998657_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,2,nCurIdentityId)
	
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if (IsMissionHaveDone(sceneId,selfId,x998657_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x998657_g_MissionId) > 0)  then
		if x998657_g_NpcList[nMonsterDataId] ~= nil then
			if x998657_CheckSubmit( sceneId, selfId ) == 1 then
				BeginEvent(sceneId)
					AddText(sceneId,x998657_g_NpcList[nMonsterDataId].submitsuc)
				EndEvent()
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x998657_g_ScriptId,x998657_g_MissionId)
			else
				BeginEvent(sceneId)
					AddText(sceneId,x998657_g_NpcList[nMonsterDataId].submitfail)
				EndEvent()
				DispatchEventList(sceneId,selfId,targetId)
			end
		end
	elseif x998657_CheckAccept( sceneId, selfId ) > 0 then
--		发送任务接受时显示的信息
		if x998657_g_NpcList[nMonsterDataId] ~= nil then
			BeginEvent(sceneId)
				AddText(sceneId,x998657_g_NpcList[nMonsterDataId].acceptsuc)
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x998657_g_ScriptId,x998657_g_MissionId)
		end
	end
end
--**********************************
--列举事件
--**********************************
function x998657_OnEnumerate( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998657_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998657_g_MissionId) > 0 then
		if x998657_g_NpcList[nMonsterDataId] ~= nil then
			AddNumText(sceneId, x998657_g_ScriptId,x998657_g_MissionName,2,-1);
		end
	--满足任务接收条件
	elseif x998657_CheckAccept(sceneId,selfId) > 0 then
		if x998657_g_NpcList[nMonsterDataId] ~= nil then
			AddNumText(sceneId,x998657_g_ScriptId,x998657_g_MissionName,1,-1);
		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x998657_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x998657_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x998657_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x998657_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end
--**********************************
--客户端请求接收任务
--**********************************
function x998657_OnAccept(sceneId,selfId,targetId)
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998657_g_NpcList[nMonsterDataId] == nil then
		return
	end
	if x998657_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId ~= 0 and nCurIdentityId ~= x998657_g_NpcList[nMonsterDataId].IdentityId then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SFYD_231227_37}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		
		BeginEvent(sceneId)
			AddText(sceneId,"#{SFYD_231227_38}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x998657_g_MissionId, x998657_g_ScriptId, 0, 0, 1 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SFYD_231227_44}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{SFYD_231227_45}",x998657_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,x998657_g_NpcList[nMonsterDataId].acceptok);
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	--设置任务的跟踪参数
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998657_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,2,nCurIdentityId)
end

--**********************************
--放弃
--**********************************
function x998657_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x998657_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x998657_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998657_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998657_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x998657_g_IsMissionOkFail)
	if misOk ~= 1 then
		return 0
	end
		
	return 1
end

--**********************************
--提交
--**********************************
function x998657_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998657_g_NpcList[nMonsterDataId] == nil then
		return
	end
	if x998657_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x998657_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SFYD_231227_121}",format("#{_EXCHG%d}",x998657_g_MoneyJZBonus)))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
--		LuaFnAddExp( sceneId, selfId, x998657_g_ExpBonus)
		DelMission( sceneId, selfId, x998657_g_MissionId )
		MissionCom( sceneId, selfId, x998657_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SFYD_231227_122}",x998657_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--关闭入口
--		BeginUICommand(sceneId)
--			UICommand_AddInt(sceneId, 0);
--		EndUICommand(sceneId)
--		DispatchUICommand(sceneId,selfId, 9986570)
--		下一阶段任务
		CallScriptFunction(x998657_g_NextScriptId,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998657_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998657_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998657_OnItemChanged( sceneId, selfId, itemdataId )
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if x998657_g_List1[nCurIdentityId] == nil then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998657_g_MissionId)
	--纯火采集
	if itemdataId == x998657_g_List2 then
		SetMissionByIndex(sceneId,selfId,misIndex,x998657_g_GetList2,1)
		x998657_CheckFinish(sceneId,selfId)
	end
	--其他必须物品
	if itemdataId == x998657_g_List1[nCurIdentityId] then
		SetMissionByIndex(sceneId,selfId,misIndex,x998657_g_GetList1,1)
		x998657_CheckFinish(sceneId,selfId)
	end
end

--**********************************
-- 检查任务是否完成
--**********************************
function x998657_CheckFinish(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998657_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,x998657_g_EnterScene) == 1
		and GetMissionParam(sceneId,selfId,misIndex,x998657_g_GetList1) == 1 
		and GetMissionParam(sceneId,selfId,misIndex,x998657_g_GetList2) == 1 then
		
		
		SetMissionByIndex(sceneId,selfId,misIndex,x998657_g_IsMissionOkFail,1)
	end
end

--**********************************
--进入特殊场景，任务完成
--**********************************
function x998657_OnEnterScene( sceneId, selfId )
	if sceneId ~= SCENE_SHENGJING_MU and  sceneId ~= SCENE_SHENGJING_HUO and  sceneId ~= SCENE_SHENGJING_SHUI then
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x998657_g_MissionId) > 0 then
		return 
	elseif IsHaveMission(sceneId,selfId,x998657_g_MissionId) > 0 then
		local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
		if x998657_g_EnterSceneTips[nCurIdentityId] == nil then
			return
		end
		--标记完成
		local misIndex = GetMissionIndexByID(sceneId,selfId,x998657_g_MissionId)
		SetMissionByIndex(sceneId,selfId,misIndex,x998657_g_EnterScene,1)
		x998657_CheckFinish(sceneId,selfId)
		
		x998657_NotifyTips(sceneId,selfId,x998657_g_EnterSceneTips[nCurIdentityId])
	end
end

--**********************************
-- 屏幕中间提示
--**********************************
function x998657_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
