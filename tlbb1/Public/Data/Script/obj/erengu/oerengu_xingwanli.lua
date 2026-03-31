--恶人谷NPC
--行万里
--普通

x018042_g_ScriptId = 018042

--**********************************
--事件交互入口
--**********************************
function x018042_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_10}")
	else
		AddText(sceneId, "#{ERMP_240620_10}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
