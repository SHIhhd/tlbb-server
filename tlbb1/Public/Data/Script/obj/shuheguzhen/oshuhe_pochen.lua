--脚本号
x001242_g_scriptId = 001242
--**********************************
--事件列表
--**********************************
function x001242_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{SXRW_090119_068}" )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end