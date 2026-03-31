--神兵引导任务
--脚本号
x998388_g_ScriptId = 998388

--**********************************
--神兵引导 自动寻路
--**********************************
function x998388_GotoFindNpc( sceneId, selfId )
	BeginUICommand(sceneId)
		--自动寻路
		UICommand_AddInt(sceneId, 1);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89027202)
end

--**********************************
--对话框提示
--**********************************
function x998388_NotifyBox( sceneId, selfId,targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--信息提示
--**********************************
function x998388_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
