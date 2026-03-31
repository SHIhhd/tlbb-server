--楼兰NPC....
--武器相关功能....

--脚本号
x001101_g_ScriptId = 001101

--**********************************
--事件交互入口
--**********************************
function x001101_OnDefaultEvent( sceneId, selfId, targetId )

	
	BeginEvent( sceneId )
		AddText( sceneId, "#{BSLCYH_130529_01}" )
		AddNumText( sceneId, x001101_g_ScriptId, "装备资质鉴定", 6, 1 )
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x001101_OnEventRequest( sceneId, selfId, targetId, eventId )

	
	if GetNumText() == 1 then

		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1001 )
		
	end

end
