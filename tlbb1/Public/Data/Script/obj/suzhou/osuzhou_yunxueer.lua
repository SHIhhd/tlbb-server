--苏州NPC
--云雪儿
--珍兽
x001088_g_ScriptId = 001088
--**********************************
--事件交互入口
--**********************************
function x001088_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZSZB_090421_01}")
		AddNumText(sceneId,x001088_g_ScriptId,"#{ZSZB_090421_02}",6,1)
		AddNumText(sceneId,x001088_g_ScriptId,"#{ZSZB_090421_03}",6,2)
		AddNumText(sceneId,x001088_g_ScriptId,"#{ZSZB_090421_08}",11,3)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--远程调用
--**********************************
function x001088_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		BeginUICommand(sceneId);
			UICommand_AddInt(sceneId, targetId)
		EndUICommand(sceneId);
		DispatchUICommand(sceneId, selfId, 20092461);
	end
	if GetNumText() == 2 then
		BeginUICommand(sceneId);
			UICommand_AddInt(sceneId, targetId)
		EndUICommand(sceneId);
		DispatchUICommand(sceneId, selfId, 20092462);
	end
	if GetNumText() == 3  then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZB_090820_1}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end