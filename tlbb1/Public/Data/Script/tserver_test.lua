--T服测试NPC
x999999_g_scriptId = 999999

--**********************************
--事件交互入口
--**********************************
function x999999_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"有什么事情，可以来找我")
		AddNumText( sceneId, x999999_g_scriptId, "城市 - 洛阳", 9, 0 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x999999_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	
	if GetNumText() == 0 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 132, 183, 10 )
	end
	
end


function x999999_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
