--恶人谷NPC
--陆不平
--普通

x018041_g_ScriptId = 018041

--**********************************
--事件交互入口
--**********************************
function x018041_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	AddText(sceneId, "#{ERMP_240620_30}")
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
