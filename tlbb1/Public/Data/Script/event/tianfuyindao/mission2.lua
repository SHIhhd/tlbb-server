--MisDescBegin
--脚本号
x891219_g_ScriptId = 891219

--完成任务NPC属性
-- x891219_g_Position_X=160  --替代
-- x891219_g_Position_Z=157 --替代
-- x891219_g_SceneID=2
-- x891219_g_AccomplishNPC_Name="赵天师"
x891219_g_AccomplishNPCInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name="玄难", posx=91, posz=71, script=9002},			
	[MP_MINGJIAO] = {sceneId=11, name="庞万春", posx=109, posz=59, script=11005},
	[MP_GAIBANG] = {sceneId=10, name="奚三祁", posx=94, posz=99, script=10007},
	[MP_WUDANG] = {sceneId=12, name="俞远山", posx=82, posz=84, script=12010},
	[MP_EMEI] = {sceneId=15, name="崔绿华", posx=98, posz=51, script=15003},
	[MP_XINGSU] = {sceneId=16, name="施全", posx=87, posz=70, script=16007},
	[MP_DALI] = {sceneId=13, name="本观", posx=97, posz=67, script=13003},
	[MP_TIANSHAN] = {sceneId=17, name="兰剑", posx=88, posz=44, script=17002},
	[MP_XIAOYAO] = {sceneId=14, name="康广陵", posx=125, posz=142, script=14001},
	[MP_MANTUO] = {sceneId=1283, name="王和铃", posx=155, posz=114, script=893263}, --替代2022
	[MP_ERENGU] = {sceneId=504, name="岳老三", posx=122, posz=151, script=018039},
}

--任务号
x891219_g_MissionId = 2022

--前置任务
x891219_g_PreMissionId = 2021
x891219_g_PreMissionName = "#{TFYD_210729_05}"

--目标NPC
x891219_g_AcceptNpcInfo	= {name="赵天师", sceneId=2, posx=160, posz=157}

--任务归类
x891219_g_MissionKind = 9

--任务等级
x891219_g_MissionLevel = 60

--是否是精英任务
x891219_g_IfMissionElite = 0

--任务名
x891219_g_MissionName="#{TFYD_210729_28}"
x891219_g_MissionTarget=""
x891219_g_IsMissionOkFail=0
x891219_g_Custom = {}
x891219_g_ContinueInfo = ""
x891219_g_MissionComplete = ""

x891219_g_MoneyJZBonus = 15000
x891219_g_ExpBonus = 120000

--MisDescEnd

x891219_g_AcceptInfo	= {
	[MP_SHAOLIN] = "#{TFYD_210729_29}",
	[MP_MINGJIAO] = "#{TFYD_210729_30}",
	[MP_GAIBANG] = "#{TFYD_210729_31}",
	[MP_WUDANG] = "#{TFYD_210729_32}",
	[MP_EMEI] = "#{TFYD_210729_33}",
	[MP_XINGSU] = "#{TFYD_210729_34}",
	[MP_DALI] = "#{TFYD_210729_35}",
	[MP_TIANSHAN] = "#{TFYD_210729_36}",
	[MP_XIAOYAO] = "#{TFYD_210729_37}",
	[MP_MANTUO] = "#{TFYD_220523_2}",
	[MP_ERENGU] = "#{ERMP_240620_07}",
}

x891219_g_CompleteInfo	= {
	[MP_SHAOLIN] = "#{TFYD_210729_38}",
	[MP_MINGJIAO] = "#{TFYD_210729_39}",
	[MP_GAIBANG] = "#{TFYD_210729_40}",
	[MP_WUDANG] = "#{TFYD_210729_41}",
	[MP_EMEI] = "#{TFYD_210729_42}",
	[MP_XINGSU] = "#{TFYD_210729_43}",
	[MP_DALI] = "#{TFYD_210729_44}",
	[MP_TIANSHAN] = "#{TFYD_210729_45}",
	[MP_XIAOYAO] = "#{TFYD_210729_46}",
	[MP_MANTUO] = "#{TFYD_220523_3}",
	[MP_ERENGU] = "#{ERMP_240620_08}",
}

--**********************************
--任务入口函数
--**********************************
function x891219_OnDefaultEvent( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x891219_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891219_g_MissionId) > 0 
		and x891219_g_AccomplishNPCInfo[nCurMenPai] ~= nil
		and GetName(sceneId,targetId) == x891219_g_AccomplishNPCInfo[nCurMenPai].name
		and x891219_g_AccomplishNPCInfo[nCurMenPai].sceneId == sceneId then
		--提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x891219_g_MissionName)
			if x891219_g_CompleteInfo[nCurMenPai] ~= nil then
				AddText(sceneId,x891219_g_CompleteInfo[nCurMenPai])
			end
			AddMoneyJZBonus(sceneId,x891219_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x891219_g_ScriptId,x891219_g_MissionId)
	elseif IsHaveMission(sceneId,selfId,x891219_g_MissionId) > 0 and GetName(sceneId,targetId) == x891219_g_AcceptNpcInfo.name then
		
	elseif x891219_CheckAccept( sceneId, selfId ) > 0 and GetName(sceneId,targetId) == x891219_g_AcceptNpcInfo.name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x891219_g_MissionName)
			if x891219_g_AcceptInfo[nCurMenPai] ~= nil then
				AddText(sceneId,x891219_g_AcceptInfo[nCurMenPai])
			end
			AddMoneyJZBonus( sceneId,x891219_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x891219_g_ScriptId,x891219_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x891219_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x891219_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x891219_g_MissionId) > 0 
		and x891219_g_AccomplishNPCInfo[nCurMenPai] ~= nil
		and GetName(sceneId,targetId) == x891219_g_AccomplishNPCInfo[nCurMenPai].name
		and x891219_g_AccomplishNPCInfo[nCurMenPai].sceneId == sceneId then
		
		AddNumText(sceneId, x891219_g_ScriptId,"#G"..x891219_g_MissionName,2,-1);
	--满足任务接收条件
	elseif x891219_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x891219_g_AcceptNpcInfo.name then
			AddNumText(sceneId,x891219_g_ScriptId,"#G"..x891219_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x891219_OnAccept(sceneId,selfId)
	if x891219_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x891219_g_MissionId, x891219_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_04}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_90}",x891219_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--检测接受条件
--**********************************
function x891219_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891219_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891219_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x891219_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x891219_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891219_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x891219_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x891219_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x891219_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x891219_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x891219_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x891219_g_ExpBonus)
		DelMission( sceneId, selfId, x891219_g_MissionId )
		MissionCom( sceneId, selfId, x891219_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x891219_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x891219_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_27}",x891219_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(891220,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891219_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x891219_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891219_OnItemChanged( sceneId, selfId, itemdataId )
end
