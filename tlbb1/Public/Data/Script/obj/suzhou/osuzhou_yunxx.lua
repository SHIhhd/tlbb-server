--云宸宸

--脚本号
x999902_g_ScriptId = 999902

--**********************************
--事件交互入口
--**********************************
function x999902_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHRH_20220427_33}")
		AddNumText(sceneId,x999902_g_ScriptId,"#{SHRH_20220427_34}",6,1)
		
		AddNumText(sceneId,x999902_g_ScriptId,"#{SHRS_230621_6}",6,3)
		
		AddNumText(sceneId,x999902_g_ScriptId,"#{SHRH_20220427_35}",11,2)

		AddNumText(sceneId,x999902_g_ScriptId,"#{SHRS_230621_7}",11,4)		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x999902_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		if GetLevel(sceneId,selfId) < 85 then
			x999902_NotifyTip( sceneId, selfId, "#{SHRH_20220427_37}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99990301 )
		return
	end
	if GetNumText() == 2 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHRH_20220427_36}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	
	if GetNumText() == 3 then
		if GetLevel(sceneId,selfId) < 85 then
			x999902_NotifyTip( sceneId, selfId, "#{SHRS_230621_9}" )
			return
		end
		if sceneId ~= SCENE_SUZHOU then
			x999902_NotifyTip( sceneId, selfId, "#{SHRS_230621_10}" )
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x999902_NotifyTip( sceneId, selfId, "#{SHRS_230621_11}" )
			return
		end
		
		LuaFnOpenExteriorRanSe(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 4 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHRS_230621_8}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
end

--**********************************
--醒目提示
--**********************************
function x999902_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
