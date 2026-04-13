--MisDescBegin
--脚本号
x893243_g_ScriptId = 893243

--任务号
x893243_g_MissionId = 2080

--前置任务
x893243_g_PreMissionId = 2079
x893243_g_PreMissionName = "#{WDEC_220425_22}"

--目标NPC
x893243_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}},
	[MP_ERENGU] = {sceneId=504, name={[1]="山姥", [2]="山人木"}},
}

--任务归类
x893243_g_MissionKind = 9

--任务等级
x893243_g_MissionLevel = 65

--是否是精英任务
x893243_g_IfMissionElite = 0

--任务名
x893243_g_MissionName="#{WDEC_220425_73}"
x893243_g_MissionTarget=""
x893243_g_Custom = {}
--任务参数
x893243_g_IsMissionOkFail = 0	--是否完成
x893243_g_MissionLiuPai = 1		-- 本流派
x893243_g_MissionMenPai = 2		-- 本门派
x893243_g_MissionPaopao = 3	


--npc距离
x893243_g_NpcDist = 5

x893243_g_MoneyJZBonus = 10000
x893243_g_ExpBonus = 800000

--MisDescEnd
x893243_g_MissionItemID = 40005037
--**********************************
--任务入口函数
--**********************************
function x893243_OnDefaultEvent( sceneId, selfId, targetId,numText)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x893243_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893243_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		if x893243_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893243_g_AcceptNpcInfo[nCurMenPai].name[i] then
					local nMisIndex = GetMissionIndexByID( sceneId, selfId, x893243_g_MissionId )	
					local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x893243_g_IsMissionOK)
					if nFinish ~= 1 then
						BeginEvent(sceneId)
							AddText(sceneId,"#{WDEC_220425_65}")
						EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)
					else
						BeginEvent(sceneId)
							AddText(sceneId,x893243_g_MissionName)
							AddText(sceneId,"#{WDEC_220425_86}")
							AddMoneyJZBonus(sceneId,x893243_g_MoneyJZBonus)
						EndEvent()
						DispatchMissionContinueInfo(sceneId,selfId,targetId,x893243_g_ScriptId,x893243_g_MissionId)
					end
					break
				end
			end
		end

	elseif x893243_CheckAccept( sceneId, selfId ) > 0 then
		--在门派武道长老处
		if x893243_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893243_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--发送任务接受时显示的信息
					BeginEvent(sceneId)
						AddText(sceneId,x893243_g_MissionName)
						AddText(sceneId,"#{WDEC_220425_63}")
						AddMoneyJZBonus( sceneId,x893243_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionInfo(sceneId,selfId,targetId,x893243_g_ScriptId,x893243_g_MissionId)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893243_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893243_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893243_g_MissionId) > 0 then
		--在门派武道长老处
		if x893243_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893243_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId, x893243_g_ScriptId,"#G"..x893243_g_MissionName,2,-1);
					break
				end
			end
		end
	--满足任务接收条件
	elseif x893243_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x893243_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893243_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId,x893243_g_ScriptId,"#G"..x893243_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end
--**********************************
--接取任务
--**********************************
function x893243_OnAccept(sceneId,selfId,targetId)
	if x893243_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--给特殊任务道具
	BeginAddItem(sceneId)
	AddItem( sceneId,x893243_g_MissionItemID, 1 )
	ret = EndAddItem(sceneId,selfId)
	if ret > 0 then
		AddItemListToHuman(sceneId,selfId)
	else
		--背包不足
		BeginEvent(sceneId)
			AddText(sceneId,"#{WDEC_220425_68}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
						
		BeginEvent(sceneId)
			AddText(sceneId,"#{WDEC_220425_69}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x893243_g_MissionId, x893243_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_19}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--设定任务数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x893243_g_MissionId)
		
	SetMissionByIndex(sceneId,selfId,misIndex,x893243_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))	
	SetMissionByIndex(sceneId,selfId,misIndex,x893243_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, "#{WDEC_220425_71}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	BeginEvent(sceneId)
		AddText( sceneId, "#{WDEC_220425_72}" )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--检测接受条件
--**********************************
function x893243_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893243_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893243_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x893243_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893243_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893243_g_MissionId )
	--删除任务物品
	LuaFnDelAvailableItem( sceneId, selfId, x893243_g_MissionItemID, 1 )
end

--**********************************
--检测是否可以提交
--**********************************
function x893243_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893243_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x893243_g_MissionId )	
	local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x893243_g_IsMissionOK)
	if nFinish < 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x893243_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893243_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893243_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x893243_g_ExpBonus)
		DelMission( sceneId, selfId, x893243_g_MissionId )
		MissionCom( sceneId, selfId, x893243_g_MissionId )
		--删除任务物品
		LuaFnDelAvailableItem( sceneId, selfId, x893243_g_MissionItemID, 1 )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{WDEC_220425_44}",x893243_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x893243_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_45}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		--提示系列任务已全部完成
--		BeginEvent(sceneId)
--			AddText(sceneId, "#{TFYD_210729_305}")
--		EndEvent(sceneId)
--		DispatchMissionTips(sceneId,selfId)
	else
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_375}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText( sceneId, "#{TFYD_210729_374}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893243_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--进入区域事件
--**********************************
function x893243_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893243_OnItemChanged( sceneId, selfId, itemdataId )

end