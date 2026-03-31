--恶人谷NPC
--善六儿
--普通

x018044_g_ScriptId = 018044

--**********************************
--事件交互入口
--**********************************
function x018044_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_11}")
	else
		AddText(sceneId, "#{ERMP_240620_33}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
