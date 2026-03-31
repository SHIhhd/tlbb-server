--MisDescBegin
--脚本号
x893242_g_ScriptId = 893242

--任务号
x893242_g_MissionId = 2079

--任务归类
x893242_g_MissionKind = 9

--任务等级
x893242_g_MissionLevel = 65

--是否是精英任务
x893242_g_IfMissionElite = 0

--任务名
x893242_g_MissionName="#{WDEC_220425_22}"
x893242_g_MissionTarget=""
x893242_g_IsMissionOkFail=0
x893242_g_MissionLiuPai = 1-- 流派
x893242_g_MissionMenPai = 2-- 门派
x893242_g_Custom = {}
x893242_g_ContinueInfo = ""
x893242_g_MissionComplete = ""

x893242_g_MoneyJZBonus = 10000
x893242_g_ExpBonus = 80000


--MisDescEnd
--目标NPC：接任务、交任务，都是这个
x893242_g_AcceptNpcInfo	= {
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
--**********************************
--任务入口函数
--**********************************
function x893242_OnDefaultEvent( sceneId, selfId, targetId,numText)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x893242_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893242_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		if x893242_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893242_g_AcceptNpcInfo[nCurMenPai].name[i] then
					BeginEvent(sceneId)
						AddText(sceneId,x893242_g_MissionName)
						AddText(sceneId,"#{WDEC_220425_27}")
						AddMoneyJZBonus(sceneId,x893242_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionContinueInfo(sceneId,selfId,targetId,x893242_g_ScriptId,x893242_g_MissionId)
					break
				end
			end
		end
		--满足任务接收条件
	elseif x893242_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x893242_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893242_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--打开主页面
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId, 1);
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 89324201)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893242_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893242_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893242_g_MissionId) > 0 then
		--在门派武道长老处
		if x893242_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893242_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId, x893242_g_ScriptId,"#G"..x893242_g_MissionName,2,-1);
					--标记任务完成
					local misIndex = GetMissionIndexByID(sceneId,selfId,x893242_g_MissionId)
					SetMissionByIndex(sceneId,selfId,misIndex,x893242_g_IsMissionOkFail,1)	
					break
				end
			end
		end
	--满足任务接收条件
	elseif x893242_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x893242_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x893242_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId,x893242_g_ScriptId,"#G"..x893242_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end

--**********************************
--检测接受条件
--**********************************
function x893242_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893242_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893242_g_MissionLevel then
		return 0
	end
	
	-- 是否一层武道点满
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel < 20 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893242_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893242_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893242_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893242_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x893242_g_MissionId )	
	local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x893242_g_IsMissionOkFail)
	if nFinish < 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x893242_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	local nCanSubmit = 0
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if x893242_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x893242_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nCanSubmit = 1
				break
			end
		end
	end
	if nCanSubmit ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_29}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText( sceneId, "#{WDEC_220425_30}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if x893242_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893242_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x893242_g_ExpBonus)
		DelMission( sceneId, selfId, x893242_g_MissionId )
		MissionCom( sceneId, selfId, x893242_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{WDEC_220425_44}",x893242_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x893242_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_61}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		--关闭入口UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121802)
		--下一阶段任务
		CallScriptFunction(893243,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--武道二重任务状态
--**********************************
function x893242_UpdateMissionState( sceneId, selfId)
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x893242_g_MissionId) > 0 then
		--关闭入口UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121802)
	   	return 
	end
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel < 20 then
		return
	end
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89121802)
end

--**********************************
--接收武道二重任
--**********************************
function x893242_OnAccept( sceneId, selfId)
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893242_g_MissionId) > 0 ) then
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_18}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893242_g_MissionLevel then
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_16}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--未完成一重 不允许打开
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel < 20 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{WDEC_220425_17}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 没有任务的话需要接取
	if IsHaveMission(sceneId,selfId,x893242_g_MissionId) <= 0 then
		--加入任务到玩家列表
		local ret = AddMission(sceneId,selfId, x893242_g_MissionId, x893242_g_ScriptId, 0, 0, 0)
		if ret <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{WDEC_220425_19}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--设定任务数据
		local misIndex = GetMissionIndexByID(sceneId,selfId,x893242_g_MissionId)
		
		SetMissionByIndex(sceneId,selfId,misIndex,x893242_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))	
		SetMissionByIndex(sceneId,selfId,misIndex,x893242_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	
		--成功接取任务
		BeginEvent(sceneId)
			AddText(sceneId,"#{WDEC_220425_20}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 2);
		UICommand_AddInt(sceneId, GetMenPai(sceneId,selfId));
		UICommand_AddInt(sceneId, LuaFnGetSectType(sceneId,selfId) + 1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89324201)
end
