--恶人谷NPC
--叶二娘
--普通

x018037_g_ScriptId = 018037

--**********************************
--事件交互入口
--**********************************
function x018037_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_03}")
		AddNumText(sceneId, x018037_g_ScriptId, "学习技能", 12, 0)
		AddNumText(sceneId, x018037_g_ScriptId, "关于心法的介绍", 11, 10)
	else
		AddText(sceneId, "#{ERMP_240620_25}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x018037_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 10 then
		BeginEvent(sceneId)
		AddText(sceneId, "#{function_xinfajieshao_001}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	DispatchXinfaLevelInfo(sceneId, selfId, targetId, 11)
end
