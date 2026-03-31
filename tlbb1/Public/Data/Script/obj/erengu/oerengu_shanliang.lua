--恶人谷NPC
--善良
--普通

x018047_g_ScriptId = 018047

--**********************************
--事件交互入口
--**********************************
function x018047_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	AddText(sceneId, "#{MPDYR_20220427_171}")
	AddNumText(sceneId, x018047_g_ScriptId, "#{MPDYR_20220427_25}", 11, 10)
	AddNumText(sceneId, x018047_g_ScriptId, "#{MPDYR_20220427_161}", 11, 11)
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x018047_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 10 then
		BeginEvent(sceneId)
		AddText(sceneId, "#{MPDYR_20220427_26}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	elseif GetNumText() == 11 then
		BeginEvent(sceneId)
		AddText(sceneId, "#{MPDYR_20220427_128}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	DispatchXinfaLevelInfo(sceneId, selfId, targetId, 11)
end
