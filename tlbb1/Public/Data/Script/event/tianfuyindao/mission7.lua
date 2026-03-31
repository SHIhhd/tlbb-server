--MisDescBegin
--脚本号
x891224_g_ScriptId = 891224

--完成任务NPC属性
-- x891224_g_Position_X=160  --替代
-- x891224_g_Position_Z=157 --替代
-- x891224_g_SceneID=2
-- x891224_g_AccomplishNPC_Name="赵天师"

--任务号
x891224_g_MissionId = 2027

--前置任务
x891224_g_PreMissionId = 2026
x891224_g_PreMissionName = "#{TFYD_210729_376}"

--目标NPC：接任务、交任务，都是这个
x891224_g_AcceptNpcInfo	= {
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

--任务归类
x891224_g_MissionKind = 9

--任务等级
x891224_g_MissionLevel = 60

--是否是精英任务
x891224_g_IfMissionElite = 0

--任务名
x891224_g_MissionName="#{TFYD_210729_454}"
x891224_g_MissionTarget=""
x891224_g_IsMissionOkFail=0
x891224_g_Custom = {}
x891224_g_ContinueInfo = ""
x891224_g_MissionComplete = ""

x891224_g_MoneyJZBonus = 40000
x891224_g_ExpBonus = 370000

--MisDescEnd
x891224_g_AcceptInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_455}", [2]="#{TFYD_210729_456}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_457}", [2]="#{TFYD_210729_458}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_459}", [2]="#{TFYD_210729_460}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_461}", [2]="#{TFYD_210729_462}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_463}", [2]="#{TFYD_210729_464}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_465}", [2]="#{TFYD_210729_466}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_467}", [2]="#{TFYD_210729_468}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_469}", [2]="#{TFYD_210729_470}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_471}", [2]="#{TFYD_210729_472}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_40}", [2]="#{TFYD_220523_41}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_50}", [2]="#{ERMP_240620_51}"}},
}

x891224_g_NotCompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_473}", [2]="#{TFYD_210729_474}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_475}", [2]="#{TFYD_210729_476}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_477}", [2]="#{TFYD_210729_478}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_479}", [2]="#{TFYD_210729_480}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_481}", [2]="#{TFYD_210729_482}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_483}", [2]="#{TFYD_210729_484}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_485}", [2]="#{TFYD_210729_486}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_487}", [2]="#{TFYD_210729_488}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_489}", [2]="#{TFYD_210729_490}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_42}", [2]="#{TFYD_220523_43}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_52}", [2]="#{ERMP_240620_53}"}},
}

x891224_g_CompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_491}", [2]="#{TFYD_210729_492}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_493}", [2]="#{TFYD_210729_494}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_495}", [2]="#{TFYD_210729_496}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_497}", [2]="#{TFYD_210729_498}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_499}", [2]="#{TFYD_210729_500}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_501}", [2]="#{TFYD_210729_502}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_503}", [2]="#{TFYD_210729_504}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_505}", [2]="#{TFYD_210729_506}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_507}", [2]="#{TFYD_210729_508}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_44}", [2]="#{TFYD_220523_45}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_54}", [2]="#{ERMP_240620_55}"}},
}
--**********************************
--任务入口函数
--**********************************
function x891224_OnDefaultEvent( sceneId, selfId, targetId,numText)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x891224_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891224_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		if x891224_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891224_g_AcceptNpcInfo[nCurMenPai].name[i] then
					local nMisIndex = GetMissionIndexByID( sceneId, selfId, x891224_g_MissionId )	
					local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x891224_g_IsMissionOK)
					if nFinish ~= 1 then
						BeginEvent(sceneId)
							AddText(sceneId,x891224_g_NotCompInfo[nCurMenPai].tips[i])
						EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)
					else
						BeginEvent(sceneId)
							AddText(sceneId,x891224_g_MissionName)
							if x891224_g_CompInfo[nCurMenPai] ~= nil then
								AddText(sceneId,x891224_g_CompInfo[nCurMenPai].tips[i])
							end
							AddMoneyJZBonus(sceneId,x891224_g_MoneyJZBonus)
						EndEvent()
						DispatchMissionContinueInfo(sceneId,selfId,targetId,x891224_g_ScriptId,x891224_g_MissionId)
					end
					break
				end
			end
		end

	elseif x891224_CheckAccept( sceneId, selfId ) > 0 then
		--在门派武道长老处
		if x891224_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891224_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--发送任务接受时显示的信息
					BeginEvent(sceneId)
						AddText(sceneId,x891224_g_MissionName)
						if x891224_g_AcceptInfo[nCurMenPai] ~= nil then
							AddText(sceneId,x891224_g_AcceptInfo[nCurMenPai].tips[i])
						end
						AddMoneyJZBonus( sceneId,x891224_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionInfo(sceneId,selfId,targetId,x891224_g_ScriptId,x891224_g_MissionId)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x891224_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x891224_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x891224_g_MissionId) > 0 then
		--在门派武道长老处
		if x891224_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891224_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId, x891224_g_ScriptId,"#G"..x891224_g_MissionName,2,-1);
					break
				end
			end
		end
	--满足任务接收条件
	elseif x891224_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x891224_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891224_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId,x891224_g_ScriptId,"#G"..x891224_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end
--**********************************
--接取任务
--**********************************
function x891224_OnAccept(sceneId,selfId,targetId)
	if x891224_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891224_g_MissionId, x891224_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_04}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_90}",x891224_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--刷新一次，没选就是浏览
	x891224_OnDefaultEvent( sceneId, selfId, targetId )
end

--**********************************
--检测接受条件
--**********************************
function x891224_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891224_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891224_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x891224_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x891224_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891224_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x891224_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x891224_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local nMisIndex = GetMissionIndexByID( sceneId, selfId, x891224_g_MissionId )	
	local nFinish = GetMissionParam(sceneId,selfId,nMisIndex,x891224_g_IsMissionOK)
	if nFinish < 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891224_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x891224_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x891224_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x891224_g_ExpBonus)
		DelMission( sceneId, selfId, x891224_g_MissionId )
		MissionCom( sceneId, selfId, x891224_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x891224_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x891224_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_27}",x891224_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		--提示系列任务已全部完成
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_305}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
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
function x891224_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--进入区域事件
--**********************************
function x891224_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891224_OnItemChanged( sceneId, selfId, itemdataId )

end
