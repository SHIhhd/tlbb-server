--MisDescBegin
--脚本号
x998353_g_ScriptId = 998353

--任务号
x998353_g_MissionId = 2211

--前置任务
x998353_g_PreMissionId = 2210
x998353_g_PreMissionName = "#{WDSC_230605_57}"

--任务归类
x998353_g_MissionKind = 9

--任务等级
x998353_g_MissionLevel = 70

--是否是精英任务
x998353_g_IfMissionElite = 0

--任务名
x998353_g_MissionName="#{WDSC_230605_73}"
x998353_g_MissionTarget=""
x998353_g_IsMissionOkFail=0
x998353_g_MissionLiuPai = 1-- 流派
x998353_g_MissionMenPai = 2-- 门派
x998353_g_Custom = {}
x998353_g_ContinueInfo = ""
x998353_g_MissionComplete = ""

x998353_g_MoneyJZBonus = 20000
x998353_g_ExpBonus = 100000


--MisDescEnd
x998353_g_AcceptNpcInfo	= {
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
	[MP_ERENGU] = {sceneId=504, name={[1]="山姥", [2]="山人木"}},
}

x998353_g_FinishNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name="玄慈"},
	[MP_MINGJIAO] = {sceneId=11, name="林世长"},
	[MP_GAIBANG] = {sceneId=10, name="宋慈"},
	[MP_WUDANG] = {sceneId=12, name="张玄素"},
	[MP_EMEI] = {sceneId=15, name="孟青青"},
	[MP_XINGSU] = {sceneId=16, name="丁春秋"},
	[MP_DALI] = {sceneId=13, name="本因"},
	[MP_TIANSHAN] = {sceneId=17, name="梅剑"},
	[MP_XIAOYAO] = {sceneId=14, name="苏星河"},
	[MP_MANTUO] = {sceneId=1283, name="王夫人"}, --替代2022
	[MP_ERENGU] = {sceneId=504, name="段延庆"},
}
--**********************************
--任务入口函数
--**********************************
function x998353_OnDefaultEvent( sceneId, selfId, targetId,numText)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x998353_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x998353_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x998353_g_MissionId )	
		if x998353_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			if GetName(sceneId,targetId) == x998353_g_FinishNpcInfo[nCurMenPai].name then
				local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x998353_g_IsMissionOkFail)
				local nLiuPai = GetMissionParam(sceneId,selfId,nMisIndex,x998353_g_MissionLiuPai) 
				if nFinish == 0 then
					BeginEvent(sceneId)
						AddText(sceneId,ScriptGlobal_Format("#{WDSC_230605_50}",x998353_g_AcceptNpcInfo[nCurMenPai].name[nLiuPai + 1]))
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)
					
					BeginEvent(sceneId)
						AddText(sceneId, ScriptGlobal_Format("#{WDSC_230605_49}",x998353_g_AcceptNpcInfo[nCurMenPai].name[nLiuPai + 1]))
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					--标记任务完成
					SetMissionByIndex(sceneId,selfId,nMisIndex,x998353_g_IsMissionOkFail,1)	
					return
				end
			end
		end
		if x998353_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			local nLiuPai = GetMissionParam(sceneId,selfId,nMisIndex,x998353_g_MissionLiuPai) 
			if GetName(sceneId,targetId) == x998353_g_AcceptNpcInfo[nCurMenPai].name[nLiuPai + 1] then
				local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x998353_g_IsMissionOkFail)
				if nFinish ~= 1 then
					BeginEvent(sceneId)
						AddText(sceneId,ScriptGlobal_Format("#{WDSC_230605_55}",x998353_g_AcceptNpcInfo[nCurMenPai].name[nLiuPai + 1]))
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)
				else
					BeginEvent(sceneId)
						AddText(sceneId,x998353_g_MissionName)
						AddText(sceneId,"#{WDEC_220425_27}")
						AddMoneyJZBonus(sceneId,x998353_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x998353_g_ScriptId,x998353_g_MissionId)
				end
			end
		end

	elseif x998353_CheckAccept( sceneId, selfId ) > 0 then
		--在门派武道长老处
		if x998353_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x998353_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--发送任务接受时显示的信息
					BeginEvent(sceneId)
						AddText(sceneId,x998353_g_MissionName)
						if i == 1 then
							AddText(sceneId,"#{WDSC_230605_34}")
						else	
							AddText(sceneId,"#{WDSC_230605_35}")
						end
						AddMoneyJZBonus( sceneId,x998353_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionInfo(sceneId,selfId,targetId,x998353_g_ScriptId,x998353_g_MissionId)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x998353_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998353_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998353_g_MissionId) > 0 then
		--在门派武道长老处
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x998353_g_MissionId )	
		local nLiuPai = GetMissionParam(sceneId,selfId,nMisIndex,x998353_g_MissionLiuPai) 
		if x998353_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			if GetName(sceneId,targetId) == x998353_g_AcceptNpcInfo[nCurMenPai].name[nLiuPai + 1] or
				GetName(sceneId,targetId) == x998353_g_FinishNpcInfo[nCurMenPai].name then
				AddNumText(sceneId, x998353_g_ScriptId,"#G"..x998353_g_MissionName,2,-1);
			end
		end
	--满足任务接收条件
	elseif x998353_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x998353_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x998353_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId,x998353_g_ScriptId,"#G"..x998353_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end
--**********************************
--接取任务
--**********************************
function x998353_OnAccept(sceneId,selfId,targetId)
	if x998353_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x998353_g_MissionId, x998353_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDSC_230605_18}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--设定任务数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998353_g_MissionId)
		
	SetMissionByIndex(sceneId,selfId,misIndex,x998353_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))	
	SetMissionByIndex(sceneId,selfId,misIndex,x998353_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, "#{WDSC_230605_42}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--检测接受条件
--**********************************
function x998353_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x998353_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x998353_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x998353_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x998353_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x998353_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x998353_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998353_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x998353_g_MissionId )	
	local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x998353_g_IsMissionOkFail)
	if nFinish < 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x998353_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x998353_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x998353_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x998353_g_ExpBonus)
		DelMission( sceneId, selfId, x998353_g_MissionId )
		MissionCom( sceneId, selfId, x998353_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{WDEC_220425_44}",x998353_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x998353_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDSC_230605_56}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		--提示系列任务已全部完成
	else
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDSC_230605_54}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998353_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--进入区域事件
--**********************************
function x998353_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998353_OnItemChanged( sceneId, selfId, itemdataId )

end
