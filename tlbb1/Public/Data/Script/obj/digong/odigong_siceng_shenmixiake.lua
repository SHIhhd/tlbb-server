--地宫四层传送人

-- 脚本号
x893380_g_ScriptId = 893380

--**********************************
--事件列表
--**********************************
function x893380_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{MJXZ_210510_235}" )
		AddNumText( sceneId, x893380_g_ScriptId, "#{PMFCC_150105_5}", 6, 1 )		
		AddNumText( sceneId, x893380_g_ScriptId, "#{PMFCC_150105_6}", 6, 2 )		
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--Monster Timer
--**********************************
function x893380_OnCharacterTimer( sceneId, objId, dataId, uTime )
	CallScriptFunction( 893390, "OnSceneTimer", sceneId )
end

--**********************************
--事件交互入口
--**********************************
function x893380_OnDefaultEvent( sceneId, selfId, targetId )
	x893380_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893380_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 1 then
		CallScriptFunction( 893391, "TransPlayerObjToHome", sceneId ,selfId)
	elseif GetNumText() == 2 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893380_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--拒绝此NPC的任务
--**********************************
function x893380_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--继续（已经接了任务）
--**********************************
function x893380_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--提交已做完的任务
--**********************************
function x893380_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )

end

--**********************************
--死亡事件
--**********************************
function x893380_OnDie( sceneId, selfId, killerId )
end
