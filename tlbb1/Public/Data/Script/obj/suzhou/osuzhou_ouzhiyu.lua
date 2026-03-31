--苏州NPC
--欧冶于
--神器炼魂
--普通
x001089_g_ScriptId = 001089
--**********************************
--事件交互入口
--**********************************
function x001089_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SQSJ_0708_08}")
		AddNumText(sceneId,x001089_g_ScriptId,"神器炼魂",6,1)
		AddNumText(sceneId, x001089_g_ScriptId,"关于神器炼魂",11,2);
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x001089_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId);
		UICommand_AddInt(sceneId,0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 19831114 )
	end
	if GetNumText() == 2 then
		BeginEvent(sceneId)
		   AddText(sceneId,"#{SQSJ_0708_01}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end

