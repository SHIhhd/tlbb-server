--雁关·无间度厄
--难度：困难入口

--脚本号
x998446_g_ScriptId = 998446
--**********************************
--任务入口函数
--**********************************
function x998446_OnDefaultEvent( sceneId, selfId, targetId )
	--条件检测
	if CallScriptFunction(998445, "CheckAccept", sceneId,selfId,targetId) ~= 1 then
		return
	end
	CallScriptFunction(998445, "MakeCopyScene", sceneId,selfId,FUBEN_YANMEN_D)
end

--**********************************
--列举事件
--**********************************
function x998446_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x998446_g_ScriptId, "#{YMMJ_230626_27}",10 ,-1  )
end

--**********************************
--对话框通知事件
--**********************************
function x998446_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId,  msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--场景通知事件
--**********************************
function x998446_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end