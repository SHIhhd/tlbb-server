--恶人谷NPC
--银弓
--普通

x018054_g_ScriptId = 018054

--**********************************
--事件交互入口
--**********************************
function x018054_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_15}")
	else
		AddText(sceneId, "#{ERMP_240620_15}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
