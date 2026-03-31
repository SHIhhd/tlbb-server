x403061_g_scriptId = 403061

--**********************************
--事件交互入口
--**********************************
function x403061_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{FHZD_090708_90}")
		AddNumText(sceneId, x403061_g_scriptId, "#{BHXZ_081103_83}",7,0)
		AddNumText(sceneId, x403061_g_scriptId, "#{BHXZ_081103_84}",7,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x403061_OnEventRequest( sceneId, selfId, targetId, eventId )
	if sceneId ~= SCENE_PHOENIXPLAIN then
		return
	end
	if GetNumText() == 0 then
		DispatchShopItem( sceneId, selfId,targetId, 143 )
	end
	if GetNumText() == 1 then
		DispatchShopItem( sceneId, selfId,targetId, 27 )
	end
end
