--地宫四层传送人
--地宫内部传送

--脚本号
x998261_g_ScriptId = 998261
x998261_g_MinLevel = 60
x998261_g_BuyCount = 5

--**********************************
--事件列表
--**********************************
function x998261_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		local nQuDuGetCount = GetMissionDataEx(sceneId,selfId,MDEX_DILING_QUDUTIME)
		AddText( sceneId, ScriptGlobal_Format("#{DLZX_230314_125}",0,nQuDuGetCount,x998261_g_BuyCount - nQuDuGetCount) )
--		AddNumText( sceneId, x998261_g_ScriptId, ScriptGlobal_Format("#{DLZX_230314_12}",nQuDuGetCount), 6, 1 )	
		--返回大理
		AddNumText( sceneId, x998261_g_ScriptId, "#{DLZX_230314_126}", 9, 2)		
		AddNumText( sceneId, x998261_g_ScriptId, "#{DLZX_230314_127}", 11, 100 )	
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--Monster Timer
--**********************************
function x998261_OnCharacterTimer( sceneId, objId, dataId, uTime )
	CallScriptFunction( 998262, "OnSceneTimer", sceneId )
end

--**********************************
--事件交互入口
--**********************************
function x998261_OnDefaultEvent( sceneId, selfId, targetId )
	x998261_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998261_OnEventRequest( sceneId, selfId, targetId, eventId )
	
--	if GetNumText() == 1 then
--		--补充驱毒时间
--		CallScriptFunction(998260, "AddQuDuTime", sceneId, selfId, targetId,0 )
--	else
	if GetNumText() == 2 then
		if GetLevel(sceneId,selfId) < x998261_g_MinLevel then
			x998261_NotifyTip( sceneId, selfId, "#{DLZX_230314_05}" )
			return
		end
		if IsInDist(sceneId, selfId, targetId,6) ~= 1 then
			return
		end
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, 2, 160, 113 )
	elseif GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{DLZX_230314_112}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x998261_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--拒绝此NPC的任务
--**********************************
function x998261_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--继续（已经接了任务）
--**********************************
function x998261_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--提交已做完的任务
--**********************************
function x998261_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )

end

--**********************************
--死亡事件
--**********************************
function x998261_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x998261_NotifyBox( sceneId, selfId,targetId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x998261_NotifyTip( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
