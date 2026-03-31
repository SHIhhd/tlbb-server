--脚本号
x999360_g_scriptId = 999360

--**********************************
--事件交互入口
--**********************************
function x999360_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{BGTS_220125_58}")
		
		AddNumText( sceneId,x999360_g_scriptId,"#{BGTS_220125_01}",6,1)
		AddNumText( sceneId,x999360_g_scriptId,"#{BGTS_220125_02}",6,2)

		AddNumText( sceneId, x999360_g_scriptId, "#{BGTS_220125_03}", 11, 10 )
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x999360_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 10 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{BGTS_220125_04}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	if GetNumText() == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  99936101)
	    return
	end
	
	if GetNumText() == 2 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  99936101)
	    return
	end
end
