--恶人谷NPC
--银婆
--普通

x018043_g_ScriptId = 018043

--**********************************
--事件交互入口
--**********************************
function x018043_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_10}")
	else
		AddText(sceneId, "#{ERMP_240620_32}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
