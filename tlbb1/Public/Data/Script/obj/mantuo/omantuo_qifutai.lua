--曼陀山庄NPC
--祈福台
--普通

x893293_g_scriptId = 893293
x893293_g_QiFuSkill = 3658
--**********************************
--事件交互入口
--**********************************
function x893293_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_92}")
		AddNumText(sceneId, x893293_g_scriptId, "#{MPSD_220622_93}",6,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x893293_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		if sceneId ~= SCENE_MANTUOSHANZHUANG then
			x893293_NotifyTip( sceneId, selfId, "#{MPSD_220622_94}" )
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x893293_NotifyTip( sceneId, selfId, "#{MPSD_220622_95}" )
			return
		end
		if LuaFnCanUnitUseSkill(sceneId,selfId,x893293_g_QiFuSkill) ~= 1 then
			x893293_NotifyTip( sceneId, selfId, "#{MPSD_220622_96}" )
			return
		end
		if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
			x893293_NotifyTip(sceneId,selfId,"#{MPSD_220622_97}")
			return
		end
		if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
			x893293_NotifyTip(sceneId,selfId,"#{MPSD_220622_97}")
			return
		end
		if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
			x893293_NotifyTip(sceneId,selfId,"#{MPSD_220622_98}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x893293_NotifyTip(sceneId,selfId,"#{MPSD_220622_99}")
			return
		end 
		if LuaFnIsStalling(sceneId,selfId) == 1 then
			x893293_NotifyTip(sceneId,selfId,"#{MPSD_220622_100}")
			return
		end 
		local nCurPosX,nCurPosZ = GetWorldPos(sceneId,targetId)
		local nCurDir = GetObjDir(sceneId,targetId)

		LuaFnHumanScriptUseSkill(sceneId,selfId,x893293_g_QiFuSkill,targetId,nCurPosX,nCurPosZ,nCurDir)
	end
end
--**********************************
--醒目提示
--**********************************
function x893293_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end