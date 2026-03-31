--编号时装

--脚本号
x998528_g_scriptId = 998528

--**********************************
--提示信息
--**********************************
function x998528_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end