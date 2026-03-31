--青丘小狐狸

--脚本号
x893039_g_ScriptId	= 893039

--副本逻辑脚本号....
x893039_g_FuBenScriptId = 893020

--AI Index....
x893039_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....
--**********************************
--入口函数
--**********************************
function x893039_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{ZSFB_20220105_03}")
		AddNumText( sceneId, x893039_g_ScriptId, "#{ZSFB_20220105_42}", 6 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x893039_OnEventRequest( sceneId, selfId, targetId, eventId )
	-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
	if GetName(sceneId,targetId) ~= "青丘狐" then
		BeginEvent( sceneId )
			AddText( sceneId, "#{ZSFB_20220105_43}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return
	end
	
	if GetNumText() == 1  then
		BeginEvent(sceneId)
			if LuaFnGetCopySceneData_Param(sceneId, 10, 0) < 4 then
				AddText(sceneId, "#{ZSFB_20220105_45}")
			end
			AddNumText( sceneId, x893039_g_ScriptId, "#{ZSFB_20220105_46}", 6 ,2  )
			AddNumText( sceneId, x893039_g_ScriptId, "#{ZSFB_20220105_47}", 6 ,3  )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 2  then
		-- 确认离开
		CallScriptFunction(893020, "LeaveScene", sceneId, selfId);
		return
	end
	
	if GetNumText() == 3  then
		-- 关闭界面
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return
	end
end

--**********************************
--初始化....
--**********************************
function x893039_OnInit(sceneId, selfId)

end

--**********************************
--心跳....
--**********************************
function x893039_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
end

--**********************************
--进入战斗....
--**********************************
function x893039_OnEnterCombat(sceneId, selfId, enmeyId)
	
end

--**********************************
--离开战斗....
--**********************************
function x893039_OnLeaveCombat(sceneId, selfId)
	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))
end

--**********************************
--杀死敌人....
--**********************************
function x893039_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x893039_OnDie( sceneId, selfId, killerId )
	
end

--**********************************
--对话框提示
--**********************************
function x893039_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

