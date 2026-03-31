--MisDescBegin
--新版本引导任务设计
--脚本号
x998789_g_ScriptId = 998789

--完成任务NPC属性
x998789_g_Position_X=150
x998789_g_Position_Z=208
x998789_g_SceneID=1
x998789_g_AccomplishNPC_Name="百晓生"

--任务号
x998789_g_MissionId = 2265

--任务归类
x998789_g_MissionKind = 9

--任务等级
x998789_g_MissionLevel = 50

--是否是精英任务
x998789_g_IfMissionElite = 0

--任务名
x998789_g_MissionName = "#{QEYD_240402_21}"
x998789_g_MissionTarget = "#{QEYD_240402_22}"
x998789_g_IsMissionOkFail = 0
x998789_g_Custom = {{ id = "询信中详情，并得九州江湖志", num = 1}}
x998789_g_ContinueInfo = ""
x998789_g_MissionComplete = "#{QEYD_240402_37}"

--MisDescEnd
x998789_g_ExpBonus = 100000

--**********************************
--任务入口函数
--**********************************
function x998789_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x998789_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x998789_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x998789_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{QEYD_240402_37}")
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x998789_g_ScriptId,x998789_g_MissionId)
		end
	end
end

--**********************************
--列举事件
--**********************************
function x998789_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998789_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998789_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x998789_g_AccomplishNPC_Name then
			AddNumText(sceneId, x998789_g_ScriptId,x998789_g_MissionName,2,-1);
		end
	end
end

--**********************************
--接受
--**********************************
function x998789_OnAccept( sceneId, selfId, targetId )
end

--**********************************
--放弃
--**********************************
function x998789_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	--DelMission( sceneId, selfId, x998789_g_MissionId )
	--任务不允许放弃
	x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_36}")
end

--**********************************
--检测是否可以提交
--**********************************
function x998789_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998789_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x998789_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x998789_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if GetLevel(sceneId,selfId) < x998789_g_MissionLevel then
			x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_39}")
			x998789_ShowNoticeBox( sceneId, selfId,targetId, "#{QEYD_240402_38}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_40}")
			return
		end
		if GetName(sceneId,targetId) ~= x998789_g_AccomplishNPC_Name then
			x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_40}")
			return
		end
		--不允许处于组队跟随模式
		if IsTeamFollow(sceneId,selfId) == 1 then
			x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_42}")
			x998789_ShowNoticeBox( sceneId, selfId,targetId, "#{QEYD_240402_41}")
			return
		end
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_46}")
			return
		end
		--添加特殊任务道具
		BeginAddItem(sceneId)
		AddItem( sceneId, 38003155, 1 )
		EndAddItem(sceneId,selfId)
		AddItemListToHuman(sceneId,selfId)
		--添加任务奖励		
		LuaFnAddExp( sceneId, selfId, x998789_g_ExpBonus)
		DelMission( sceneId, selfId, x998789_g_MissionId )
		MissionCom( sceneId, selfId, x998789_g_MissionId )
		
		x998789_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{QEYD_240402_48}",x998789_g_MissionName))
		x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_51}")
		--刷新入口UI
		x998789_OnHumanLogin( sceneId, selfId)
		--调取下一个引导任务
		CallScriptFunction(998790,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998789_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998789_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998789_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--客户端请求增加任务
--**********************************
function x998789_AddMissionToPlayer( sceneId, selfId)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x998789_g_MissionLevel then
		x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_07}")
		return
	end
	if (IsMissionHaveDone(sceneId,selfId,x998789_g_MissionId) > 0 ) then
		LuaFnUpdateQuickEnter(sceneId,selfId,27,0);
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x998789_g_MissionId, x998789_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x998789_ShowNotice( sceneId, selfId, "#{QEYD_240402_09}")
		return
	end
	--成功接取任务
	x998789_ShowNotice( sceneId, selfId, ScriptGlobal_Format("#{QEYD_240402_19}",x998789_g_MissionName))
	--服务器直接调用客户端发起自动引导
	BeginUICommand( sceneId )
	EndUICommand( sceneId)
	DispatchUICommand(sceneId,selfId,99878902)
end
--**********************************
--玩家登录
--**********************************
function x998789_OnHumanLogin( sceneId, selfId)
	--等级等前置检查
	if GetLevel(sceneId,selfId) < x998789_g_MissionLevel then
		--关闭按钮
		LuaFnUpdateQuickEnter(sceneId,selfId,27,0);
		return
	end
	--前置任务完成了
	if IsMissionHaveDone(sceneId,selfId,x998789_g_MissionId) > 0 then
	    LuaFnUpdateQuickEnter(sceneId,selfId,27,0);
		return
	end
	--开启顶部快捷入口
	LuaFnUpdateQuickEnter(sceneId,selfId,27,1);
end
--**********************************
--角色对话框
--**********************************
function x998789_ShowNoticeBox( sceneId, selfId,targetId, strNotice)
	BeginEvent(sceneId)
		AddText(sceneId,strNotice)
	EndEvent()
	DispatchEventList(sceneId,selfId,targetId) 
end
--**********************************
--屏幕中心提示
--**********************************
function x998789_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
