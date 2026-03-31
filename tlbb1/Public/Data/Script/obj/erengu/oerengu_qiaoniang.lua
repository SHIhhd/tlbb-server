--恶人谷NPC
--巧娘
--普通

x018049_g_ScriptId = 018049

--**********************************
--事件交互入口
--**********************************
function x018049_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_161}")
	else
		AddText(sceneId, "#{ERMP_240620_161}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
