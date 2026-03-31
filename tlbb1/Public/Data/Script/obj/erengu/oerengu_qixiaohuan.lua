--恶人谷NPC
--齐小欢
--普通

x018051_g_ScriptId = 018051

--**********************************
--事件交互入口
--**********************************
function x018051_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_16}")
	else
		AddText(sceneId, "#{ERMP_240620_16}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
