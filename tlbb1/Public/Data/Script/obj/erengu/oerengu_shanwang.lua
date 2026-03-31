--恶人谷NPC
--山王
--普通

x018046_g_ScriptId = 018046

--**********************************
--事件交互入口
--**********************************
function x018046_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	AddText(sceneId, "#{MPDYR_20220427_23}")
	AddNumText(sceneId, x018046_g_ScriptId, "#{JXGZ_220427_17}", 11, 10)
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x018046_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 10 then
		BeginEvent(sceneId)
		AddText(sceneId, "#{JXGZ_220427_18}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
end
