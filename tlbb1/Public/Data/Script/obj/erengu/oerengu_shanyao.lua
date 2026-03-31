--恶人谷NPC
--山妖
--普通

x018045_g_ScriptId = 018045

--**********************************
--事件交互入口
--**********************************
function x018045_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_12}")
	else
		AddText(sceneId, "#{ERMP_240620_34}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
