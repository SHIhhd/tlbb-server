--幽篁里NPC 墨星翁

x890139_g_ScriptId	= 890139
--**********************************
--事件交互入口
--**********************************
function x890139_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText(sceneId, "#{BLCC_20221214_442}");
		AddNumText( sceneId, x890139_g_ScriptId, "#{BLCC_20221214_443}", 6, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x890139_OnEventRequest( sceneId, selfId, targetId, eventId )
	local fubenType = LuaFnGetCopySceneData_Param(sceneId, 0);
	if fubenType ~= FUBEN_BAIXIGU_YOUHUANGLI then
		x890139_NotifyTips(sceneId, selfId, "#{BLCC_20221214_444}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x890139_NotifyTips(sceneId,selfId,"#{BLCC_20221214_410}")
		return
	end
	local key = GetNumText()
	if key == 1 then
		if LuaFnGetCopySceneData_Param(sceneId, 9) > 0 and CallScriptFunction( 890137, "GetMonsterNumber",sceneId) > 0 then
			BeginEvent( sceneId )
				AddText(sceneId, "#{BLCC_20221214_445}");
				AddNumText( sceneId, x890139_g_ScriptId, "#{BLCC_20221214_443}", 6, 2 )
				AddNumText( sceneId, x890139_g_ScriptId, "#{BLCC_20221214_414}", 6, 3 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			x890139_GoBack(sceneId, selfId, targetId)
		end
	elseif key == 2 then
		x890139_GoBack(sceneId, selfId, targetId)
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
function x890139_GoBack(sceneId, selfId, targetId)
	
	local oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3);--取得副本入口场景号
	local enterPosX = LuaFnGetCopySceneData_Param(sceneId, 7);
	local enterPosZ = LuaFnGetCopySceneData_Param(sceneId, 8);
	if IsCanNewWorld( sceneId, selfId, oldsceneId, enterPosX, enterPosZ ) ~= 1 then
		x890139_NotifyTips(sceneId, selfId, "#{BLCC_20221214_411}")
		return
	end
	NewWorld(sceneId, selfId, oldsceneId, enterPosX, enterPosZ);
end
--**********************************
--屏幕中心信息提示
--**********************************
function x890139_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x890139_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
