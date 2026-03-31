--恶人谷NPC
--山鬼
--普通

x018035_g_ScriptId = 018035

--**********************************
--事件列表
--**********************************
function x018035_UpdateEventList( sceneId, selfId, targetId )
	local PlayerName = GetName(sceneId, selfId)
	BeginEvent(sceneId)
	if GetMenPai(sceneId, selfId) ~= 11 then
		AddText(sceneId, "#{ERMP_240620_23}")
	else
		AddText(sceneId, "#{ERMP_240620_01}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件交互入口
--**********************************
function x018035_OnDefaultEvent( sceneId, selfId, targetId )
	x018035_UpdateEventList( sceneId, selfId, targetId )
end
