--情侣空间

--脚本号
x998324_g_scriptId = 998324

--**********************************
--占卜
--**********************************
function x998324_OnDoScry( sceneId, selfId )
	
end
--**********************************
--占卜
--**********************************
function x998324_BeforeDoScry( sceneId, selfId )
	
end
--**********************************
--打开空间主界面前请求
--**********************************
function x998324_OnAskCoupleZoneData( sceneId, selfId, opType )
	
end
--**********************************
--提示信息
--**********************************
function x998324_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x998324_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end