--青丘NPC狐狸们

--脚本号
x893105_g_ScriptId	= 893105
--**********************************
--入口函数
--**********************************
function x893105_OnDefaultEvent( sceneId, selfId, targetId )
	if GetName(sceneId,targetId) == "洒扫狐" then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZSFB_20220105_120}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetName(sceneId,targetId) == "摸鱼狐" then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZSFB_20220105_122}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetName(sceneId,targetId) == "渊博狐" then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZSFB_20220105_121}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetName(sceneId,targetId) == "巫祝狐" then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZSFB_20220105_123}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x893105_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--初始化....
--**********************************
function x893105_OnInit(sceneId, selfId)

end

--**********************************
--心跳....
--**********************************
function x893105_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
end

--**********************************
--进入战斗....
--**********************************
function x893105_OnEnterCombat(sceneId, selfId, enmeyId)
	
end

--**********************************
--离开战斗....
--**********************************
function x893105_OnLeaveCombat(sceneId, selfId)

end

--**********************************
--杀死敌人....
--**********************************
function x893105_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x893105_OnDie( sceneId, selfId, killerId )
	
end

--**********************************
--对话框提示
--**********************************
function x893105_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

