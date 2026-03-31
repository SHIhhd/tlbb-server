--MisDescBegin
--脚本号
x890273_g_ScriptId = 890273
--任务号
x890273_g_MissionId = 2241
--任务归类
x890273_g_MissionKind = 9 --引导任务 类型：9 路径：\Client\Config\MissionKind.txt
--任务等级
x890273_g_MissionLevel = 65
--任务名
x890273_g_MissionName = "#{SQYD_230802_14}"
--任务目标
x890273_g_MissionTarget = "#{SQYD_230802_32}"
--标记成功是哪号位 这里标记的是0号位
x890273_g_IsMissionOkFail = 0
-- 任务完成情况,占用任务参数的第1位
x890273_g_Custom = { { id = "寻扫地僧问询长恨刀", num = 1 } }
--x890273_g_ItemBonus={id=38002948, num=1}

--MisDescEnd
--前置任务
x890273_g_PreMissionId = 2240
x890273_g_AcceptNPC_Name = "萧峰"
x890273_g_FinishedNPC_Name = "扫地神僧"
x890273_g_ExpBonus = 300000
--**********************************
--任务入口函数
--**********************************
function x890273_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x890273_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x890273_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x890273_g_FinishedNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SQYD_230802_34}")
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x890273_g_ScriptId,x890273_g_MissionId)
		end
	elseif x890273_CheckAccept( sceneId, selfId ) > 0 then
--		发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{SQYD_230802_26}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890273_g_ScriptId,x890273_g_MissionId)
	end
end
--**********************************
--列举事件
--**********************************
function x890273_OnEnumerate( sceneId, selfId, targetId )
--	如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890273_g_MissionId) > 0 then
		return 
--	如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890273_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x890273_g_FinishedNPC_Name then
			AddNumText(sceneId, x890273_g_ScriptId,x890273_g_MissionName,2,-1);
		end
--	满足任务接收条件
	elseif x890273_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890273_g_AcceptNPC_Name then
			AddNumText(sceneId,x890273_g_ScriptId,x890273_g_MissionName,1,-1);
		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x890273_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890273_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890273_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890273_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end
--**********************************
--接受
--**********************************
function x890273_OnAccept( sceneId, selfId, targetId )
	if x890273_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890273_g_MissionId, x890273_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SQYD_230802_11}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{SQYD_230802_12}",x890273_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{SQYD_230802_65}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x890273_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890273_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890273_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890273_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x890273_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890273_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{SQYD_230802_38}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if GetName(sceneId,targetId) ~= x890273_g_FinishedNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId, "#{SQYD_230802_38}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x890273_g_ExpBonus)
		DelMission( sceneId, selfId, x890273_g_MissionId )
		MissionCom( sceneId, selfId, x890273_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SQYD_230802_24}",x890273_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(890277,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890273_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890273_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890273_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
--客户端呼出主UI
--**********************************
function x890273_OpenUI( sceneId, selfId)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x890273_g_MissionLevel then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SQYD_230802_08}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x890273_g_MissionId) > 0 then
		--关闭入口UI
		LuaFnUpdateQuickEnter(sceneId,selfId,18,0);
		return
	end
	BeginUICommand(sceneId)
		--是龙门 到时候测试特殊更新服务器脚本传1
		UICommand_AddInt(sceneId, 0);
		--是否完成七个引导任务
		UICommand_AddInt(sceneId, 0);
		--是否完成引导任务一
		UICommand_AddInt(sceneId, 0);
		--是否完成剧情任务一
		UICommand_AddInt(sceneId, 1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89027302)
end