--大理乞丐

--任务号
x002070_g_MissionId = 1423

x002070_g_scriptId=002070

x002070_g_SignPost = {x = 215, z = 284, tip = "段延庆"}

function x002070_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	local misIndex = GetMissionIndexByID(sceneId,selfId,x002070_g_MissionId)
	local param_1 = GetMissionParam(sceneId,selfId,misIndex,1)
	local param_2 = GetMissionParam(sceneId,selfId,misIndex,2)
	local param_3 = GetMissionParam(sceneId,selfId,misIndex,3)
	local param_4 = GetMissionParam(sceneId,selfId,misIndex,4)
	BeginEvent(sceneId)
		if IsHaveMission(sceneId,selfId,x002070_g_MissionId) > 0 then
			--三种情况三种对话
			if param_1 == 1 and param_2 == 0 and param_3 == 0 and param_4 == 0 then
				AddText(sceneId,"#{XSRW_100111_112}")
				AddNumText(sceneId,x002070_g_scriptId,"#{XSRW_100111_113}",2,0)
			elseif param_1 == 1 and param_2 == 1 and param_3 == 0 and param_4 == 0 then
				AddText(sceneId,"#{XSRW_100111_114}")
				AddNumText(sceneId,x002070_g_scriptId,"#{XSRW_100111_115}",2,1)
			elseif param_1 == 1 and param_2 == 1 and param_3 == 1 and param_4 == 0 then
				AddText(sceneId,"#{XSRW_100111_116}")
				AddNumText(sceneId,x002070_g_scriptId,"#{XSRW_100111_117}",2,2)
			else
				AddText(sceneId,"#{XSRW_100111_118}") --初始对话
			end
		else
			AddText(sceneId,"#{XSRW_100111_112}") --初始对话
		end
	EndEvent()
	DispatchEventList(sceneId,selfId,targetId)
end

function x002070_OnEventRequest( sceneId, selfId, targetId, eventId )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x002070_g_MissionId)
	if GetNumText() == 0 then
		DelItem(sceneId,selfId,40004514,1)	
		SetMissionByIndex( sceneId, selfId,misIndex,2,1)
		x002070_NotifyTips(sceneId,selfId,"赠送馒头给小乞丐：1/1")
		x002070_OnDefaultEvent( sceneId, selfId, targetId ) --跳转主界面
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId,sceneId, x002070_g_SignPost.x, x002070_g_SignPost.z, x002070_g_SignPost.tip )
	elseif GetNumText() == 1 then
		DelItem(sceneId,selfId,40004515,1)	
		SetMissionByIndex( sceneId, selfId,misIndex,3,1)
		x002070_NotifyTips(sceneId,selfId,"赠送衣服给小乞丐：1/1")
		x002070_OnDefaultEvent( sceneId, selfId, targetId ) --跳转主界面
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId,sceneId, x002070_g_SignPost.x, x002070_g_SignPost.z, x002070_g_SignPost.tip )
	elseif GetNumText() == 2 then
		DelItem(sceneId,selfId,40004516,1)	
		SetMissionByIndex( sceneId, selfId,misIndex,4,1)
		x002070_NotifyTips(sceneId,selfId,"赠送锄头给小乞丐：1/1")
		SetMissionByIndex( sceneId, selfId,misIndex,0,1) --走到这里的情况下任务就完成了。
		x002070_OnDefaultEvent( sceneId, selfId, targetId ) --跳转主界面
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId,sceneId, x002070_g_SignPost.x, x002070_g_SignPost.z, x002070_g_SignPost.tip )
	end
end

--**********************************
-- 屏幕中间提示
--**********************************
function x002070_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end