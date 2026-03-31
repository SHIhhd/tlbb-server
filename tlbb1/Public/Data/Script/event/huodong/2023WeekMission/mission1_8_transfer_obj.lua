--雪山禁地NPC 墨如

x890136_g_ScriptId	= 890136
--**********************************
--事件交互入口
--**********************************
function x890136_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText(sceneId, "#{BLCC_20221214_407}");
		AddNumText( sceneId, x890136_g_ScriptId, "#{BLCC_20221214_408}", 6, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x890136_OnEventRequest( sceneId, selfId, targetId, eventId )
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, 0);
	if fubenType ~= FUBEN_BAIXIGU_XUESHANJINDI then
		x890136_NotifyTips(sceneId, selfId, "#{BLCC_20221214_409}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x890136_NotifyTips(sceneId,selfId,"#{BLCC_20221214_410}")
		return
	end
	local key = GetNumText()
	if key == 1 then
		if LuaFnGetCopySceneData_Param(sceneId, 9) < 1 then
			BeginEvent( sceneId )
				AddText(sceneId, "#{BLCC_20221214_412}");
				AddNumText( sceneId, x890136_g_ScriptId, "#{BLCC_20221214_413}", 6, 2 )
				AddNumText( sceneId, x890136_g_ScriptId, "#{BLCC_20221214_414}", 6, 3 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			x890136_GoBack(sceneId, selfId, targetId)
		end
	elseif key == 2 then
		x890136_GoBack(sceneId, selfId, targetId)
		return
	elseif key == 3 then
		--关闭对话框
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	end
end
--**********************************
--回家
--**********************************
function x890136_GoBack(sceneId, selfId, targetId)
	
	local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号
	local enterPosX = LuaFnGetCopySceneData_Param(sceneId, 7);
	local enterPosZ = LuaFnGetCopySceneData_Param(sceneId, 8);
	if IsCanNewWorld( sceneId, selfId, oldsceneId, enterPosX, enterPosZ ) ~= 1 then
		x890136_NotifyTips(sceneId, selfId, "#{BLCC_20221214_411}")
		return
	end
	NewWorld(sceneId, selfId, oldsceneId, enterPosX, enterPosZ);
end
--**********************************
--屏幕中心信息提示
--**********************************
function x890136_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x890136_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
