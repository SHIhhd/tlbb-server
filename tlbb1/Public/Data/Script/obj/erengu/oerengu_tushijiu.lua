--恶人谷NPC
--屠十九
--普通

x018048_g_ScriptId = 018048

--**********************************
--事件交互入口
--**********************************
function x018048_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_163}")
	else
		AddText(sceneId, "#{ERMP_240620_163}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
