x403052_g_scriptId = 403052
x403052_g_PosData = 
{
	{posx = 68,posz = 33},{posx = 251,posz = 27},{posx = 292,posz = 252},{posx = 258,posz = 291},
	{posx = 66,posz = 292},{posx = 28,posz = 262},{posx = 35,posz = 60},{posx = 150,posz = 146}
}
--**********************************
--事件交互入口
--**********************************
function x403052_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{FHZD_090708_48}")
		if sceneId == 180 then
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_19}",9,1)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_20}",9,2)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_22}",9,3)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_23}",9,4)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_24}",9,5)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_25}",9,6)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_26}",9,7)
			AddNumText(sceneId, x403052_g_scriptId,"#{FHZD_XML_27}",9,8)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x403052_OnEventRequest( sceneId, selfId, targetId, eventId )
	if sceneId ~= SCENE_PHOENIXPLAIN then
		return
	end
	local nNumText = GetNumText();
	local nWeek = GetTodayWeek();
	local nTime = GetHour() * 100 + GetMinute()
	--城战阶段判断
	if nNumText == 8 then
		if nWeek == 3 or nWeek == 6 then
			if nTime >= 2030 or nTime < 2200 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{FHZD_090708_49}")
					AddNumText(sceneId, x403052_g_scriptId,"确定",9,nNumText + 1000)
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
		else
			CallScriptFunction((400900), "TransferFunc",sceneId,selfId,420,x403052_g_PosData[8].posx,x403052_g_PosData[8].posz)
			return
		end
	else
		if sceneId == SCENE_PHOENIXPLAIN then
			SetPos(sceneId,selfId,x403052_g_PosData[nNumText].posx,x403052_g_PosData[nNumText].posz)
		end
	end
end
--**********************************
--信息提示
--**********************************
function x403052_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
