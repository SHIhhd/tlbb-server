--凤凰古城 中心NPC传送脚本 黄龙天

x403007_g_ScriptId	= 403007

--**********************************
--事件交互入口
--**********************************
function x403007_OnDefaultEvent( sceneId, selfId, targetId )
	if sceneId ~= SCENE_PHOENIXPLAIN then
		return
	end
	--凤凰古城争夺战已经结束，我可以带你快速离开凤凰古城，请问大侠想去哪？
	BeginEvent( sceneId )
		AddText( sceneId, "#{FHZD_090708_87}" )
		AddNumText( sceneId, x403007_g_ScriptId, "#{FHZD_XML_34}",  9, 1 )		
		AddNumText( sceneId, x403007_g_ScriptId, "#{FHZD_XML_35}",  9, 2 )		
		AddNumText( sceneId, x403007_g_ScriptId, "#{FHZD_XML_36}",  9, 3 )		
		AddNumText( sceneId, x403007_g_ScriptId, "#{FHZD_XML_37}",  9, 4 )		
		AddNumText( sceneId, x403007_g_ScriptId, "#{FHZD_XML_38}",  9, 5 )	
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x403007_OnEventRequest( sceneId, selfId, targetId, eventId )
	if sceneId ~= SCENE_PHOENIXPLAIN then
		return
	end
	local arg	= GetNumText()
	if arg == 1 then		--洛阳
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 132, 183, 10 )
		return
	end
	if arg == 2 then		--大理
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 241, 138 )
		return
	end
	if arg == 3 then		--苏州
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 114,162, 10 )
		return
	end
	if arg == 4 then		--束河古镇
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 200, 211, 20 );
		return
	end
	if arg == 5 then		--楼兰
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 288, 136, 75 )
		return
	end
end
--**********************************
--屏幕中间信息提示
--**********************************
function x403007_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403007_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


