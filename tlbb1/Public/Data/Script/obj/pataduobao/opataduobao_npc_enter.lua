--南海千洲传送NPC
--脚本号

x998567_g_scriptId = 998567
--**********************************
--事件交互入口
--**********************************
function x998567_OnDefaultEvent( sceneId, selfId, targetId)
	BeginEvent(sceneId)  
		AddText(sceneId, "#{PTDB_231225_74}")
        AddNumText(sceneId, x998567_g_scriptId,"#{YJGZ_20231228_9}", 6, 1)
		AddNumText(sceneId, x998567_g_scriptId,"#{YJGZ_20231228_10}", 6, 2)
		AddNumText(sceneId, x998567_g_scriptId,"#{YJGZ_20231228_11}", 6, 3)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x998567_OnEventRequest( sceneId, selfId, targetId, eventId )
	--回到洛阳 199 200

	local key=GetNumText()
	if key == 1 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_SHENGJING_HUO, 202,57, 75 );
	elseif key == 2 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_SHENGJING_MU, 58, 181, 75 );
	elseif key == 3 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_SHENGJING_SHUI, 188,211, 75 );
	end
end
--**********************************
--对话窗口信息提示
--**********************************
function x998567_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x998567_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--关闭对话框
--**********************************
function x998567_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end