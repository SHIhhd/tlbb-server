--恶人谷NPC
--胡玉郎
--普通

x018050_g_ScriptId = 018050

--**********************************
--事件交互入口
--**********************************
function x018050_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_162}")
	else
		AddText(sceneId, "#{ERMP_240620_162}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
