--MisDescBegin
--脚本号
x891218_g_ScriptId = 891218

--完成任务NPC属性
-- x891218_g_Position_X=160  --替代
-- x891218_g_Position_Z=157 --替代
-- x891218_g_SceneID=2
-- x891218_g_AccomplishNPC_Name="赵天师"

--任务号
x891218_g_MissionId = 2021

--目标NPC
x891218_g_Name	="赵天师"

--任务归类
x891218_g_MissionKind = 9

--任务等级
x891218_g_MissionLevel = 60

--是否是精英任务
x891218_g_IfMissionElite = 0

--任务名
x891218_g_MissionName="#{TFYD_210729_05}"
x891218_g_MissionTarget="#{TFYD_210729_15}"
x891218_g_IsMissionOkFail=0
x891218_g_Custom = {{ id = "与赵天师交谈", num = 1}}
x891218_g_ContinueInfo = ""
x891218_g_MissionComplete = ""

x891218_g_MoneyJZBonus = 10000
x891218_g_ExpBonus = 1000000

--MisDescEnd

--武道二重任务号
x891218_g_MissionIdLayer2 = 2079
--武道三重任务号
x891218_g_MissionIdLayer3 = 2210

--目标NPC：接任务、交任务，都是这个
x891218_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = "#{TFYD_210729_06}",
	[MP_MINGJIAO] = "#{TFYD_210729_07}",
	[MP_GAIBANG] = "#{TFYD_210729_08}",
	[MP_WUDANG] = "#{TFYD_210729_09}",
	[MP_EMEI] = "#{TFYD_210729_10}",
	[MP_XINGSU] = "#{TFYD_210729_11}",
	[MP_DALI] = "#{TFYD_210729_12}",
	[MP_TIANSHAN] = "#{TFYD_210729_13}",
	[MP_XIAOYAO] = "#{TFYD_210729_14}",
	[MP_MANTUO] = "#{TFYD_220523_1}",
	[MP_ERENGU] = "#{ERMP_240620_06}",
}

--**********************************
--任务入口函数
--**********************************
function x891218_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x891218_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x891218_g_MissionId) > 0)  then
		BeginEvent(sceneId)
			AddText(sceneId,x891218_g_MissionName)
			if x891218_g_AcceptNpcInfo[GetMenPai(sceneId,selfId)] ~= nil then
				AddText(sceneId,x891218_g_AcceptNpcInfo[GetMenPai(sceneId,selfId)])
			end
			AddMoneyJZBonus( sceneId, x891218_g_MoneyJZBonus )
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x891218_g_ScriptId,x891218_g_MissionId)
	elseif x891218_CheckAccept( sceneId, selfId ) > 0 then
		--在门派武道长老处
		if GetName(sceneId,targetId) == x891218_g_Name then
			--打开主页面
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId, 1);
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 89121801)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x891218_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x891218_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x891218_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x891218_g_Name then
			AddNumText(sceneId, x891218_g_ScriptId,"#G"..x891218_g_MissionName,2,-1);
		end
	--满足任务接收条件
	elseif x891218_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x891218_g_Name then
			AddNumText(sceneId,x891218_g_ScriptId,"#G"..x891218_g_MissionName,1,-1);
		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x891218_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891218_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891218_g_MissionLevel then
		return 0
	end
	
	-- 门派检测
	if GetMenPai(sceneId, selfId) == MP_WUMENPAI  then
		return 0
	end
	
	return 1
end
--**********************************
--接受
--**********************************
function x891218_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--放弃
--**********************************
function x891218_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891218_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x891218_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x891218_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x891218_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x891218_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x891218_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x891218_g_ExpBonus)
		DelMission( sceneId, selfId, x891218_g_MissionId )
		MissionCom( sceneId, selfId, x891218_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x891218_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x891218_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_27}",x891218_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--关闭入口UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121802)
		
		--下一阶段任务
		CallScriptFunction(891219,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891218_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x891218_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891218_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--客户端呼出主UI
--**********************************
function x891218_UILogic( sceneId, selfId, opType)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x891218_g_MissionLevel then
		return
	end
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)

	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x891218_g_MissionId) > 0 then
		--未达到二重条件
		if totallevel < 20 then
			--关闭入口UI
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId, 0);
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 89121802)
			return 
		end
		--二重也完成了
		if IsMissionHaveDone(sceneId,selfId,x891218_g_MissionIdLayer2) > 0 then
			--未达到三重条件
			if totallevel < 40 then
				--关闭入口UI
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId, 0);
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 89121802)
				return 
			end
			--三重已完成
			if IsMissionHaveDone(sceneId,selfId,x891218_g_MissionIdLayer3) > 0 then
				--关闭入口UI
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId, 0);
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 89121802)
				return 
			end
		end
	end
	
	if totallevel >= 40 then
		--三重页面
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, opType);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 99835201)
	elseif totallevel >= 20 then
		--二重页面
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, opType);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89324201)
	else
		--一重页面
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, opType);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121801)
	end
end

--**********************************
--客户端请求是否提供自动寻路
--**********************************
function x891218_GotoFindNpc( sceneId, selfId)
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891218_g_MissionId) > 0 ) then
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_03}",x891218_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891218_g_MissionLevel then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_02}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 门派检测
	if GetMenPai(sceneId, selfId) == MP_WUMENPAI  then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_72}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	-- 没有任务的话需要接取
	if IsHaveMission(sceneId,selfId,x891218_g_MissionId) <= 0 then
		--加入任务到玩家列表
		local ret = AddMission(sceneId,selfId, x891218_g_MissionId, x891218_g_ScriptId, 0, 0, 0)
		if ret <= 0 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{TFYD_210729_04}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--成功接取任务
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_90}",x891218_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 2);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89121801)
end

--**********************************
--玩家登录
--**********************************
function x891218_OnHumanLogin( sceneId, selfId)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x891218_g_MissionLevel then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121802)
		return
	end
	-- 门派检测
	if GetMenPai(sceneId, selfId) == MP_WUMENPAI  then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121802)
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x891218_g_MissionId) > 0 then
	    BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89121802)
		return
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89121802)
end
