--雁关·无间度厄 传送NPC
--脚本号
x998466_g_ScriptId	= 998466
x998466_g_CopySceneData_Complete = 17		--副本是否已完成

--**********************************
--入口函数
--**********************************
function x998466_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText( sceneId,"#{YMMJ_230626_63}")
		AddNumText( sceneId, x998466_g_ScriptId, "#{YMMJ_230626_64}", 9 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x998466_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1  then
		BeginEvent(sceneId)
			if LuaFnGetCopySceneData_Param(sceneId, x998466_g_CopySceneData_Complete) ~= 1 then
				AddText( sceneId,"#{YMMJ_230626_67}")
			end
			AddNumText( sceneId, x998466_g_ScriptId, "#{YMMJ_230626_68}", 6 ,10  )
			AddNumText( sceneId, x998466_g_ScriptId, "#{YMMJ_230626_69}", 6 ,11  )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if GetNumText() == 10  then
		if LuaFnGetCopySceneData_Param(sceneId, 0) ~= FUBEN_YANMEN then
			x998466_NotifyTip( sceneId, selfId, "#{YMMJ_230626_65}" )
			return
		end
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, SCENE_YANMEN_BREAKROOM, 96,99, 65 );
	end
	if GetNumText() == 11  then
		-- 关闭界面
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
	end
end
--**********************************
--屏幕中央提示
--**********************************
function x998466_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框提示
--**********************************
function x998466_MsgBox( sceneId, selfId,targetId,Msg )
	BeginEvent(sceneId)
		AddText(sceneId,Msg)
	EndEvent()
	DispatchEventList(sceneId, selfId, targetId)
end

