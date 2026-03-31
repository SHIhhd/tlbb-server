--曼陀山庄NPC
--王灵均
--普通

x893282_g_scriptId = 893282

--**********************************
--事件交互入口
--**********************************
function x893282_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_67}")
		AddNumText(sceneId, x893282_g_scriptId, "#{MPSD_220622_68}",-1,0)
		AddNumText(sceneId, x893282_g_scriptId, "#{MPSD_220622_69}",-1,1)
		AddNumText(sceneId, x893282_g_scriptId, "#{MPSD_220622_70}",-1,2)
		AddNumText(sceneId, x893282_g_scriptId, "#{MPSD_220622_71}",-1,3)
		AddNumText(sceneId, x893282_g_scriptId, "#{MPSD_220622_72}",-1,4)
		AddNumText(sceneId, x893282_g_scriptId, "#{MPSD_220622_73}",-1,5)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x893282_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_74}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_75}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 2 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_76}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 3 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_77}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 4 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_78}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 5 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_79}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end
