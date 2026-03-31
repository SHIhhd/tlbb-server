--洛阳NPC

--郭宝全

--安全大使

x000155_g_ScriptId=000155

--**********************************
--事件交互入口
--**********************************
function x000155_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{AQXCY_090626_01}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
