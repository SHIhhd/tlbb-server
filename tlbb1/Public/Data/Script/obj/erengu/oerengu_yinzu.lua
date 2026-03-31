--恶人谷NPC
--银祖
--普通

x018053_g_ScriptId = 018053

--**********************************
--事件交互入口
--**********************************
function x018053_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_14}")
	else
		AddText(sceneId, "#{ERMP_240620_14}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
