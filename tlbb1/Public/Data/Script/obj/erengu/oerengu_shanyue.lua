--恶人谷NPC
--山月
--普通

x018052_g_ScriptId = 018052

--**********************************
--事件交互入口
--**********************************
function x018052_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_13}")
	else
		AddText(sceneId, "#{ERMP_240620_13}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
