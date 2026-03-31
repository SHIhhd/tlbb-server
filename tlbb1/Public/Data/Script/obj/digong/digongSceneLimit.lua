--地宫秘境场景限制

x893391_g_ScriptId = 893391

x893391_g_BackPos = {
	[SCENE_LUOYANG] = {169,101},
	[SCENE_SUZHOU] = {191,130},
	[SCENE_DALI] = {185,122},
}
--**********************************
--传送地图内所有玩家到三大主城
--**********************************
function x893391_TransPlayerToHome( sceneId )
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount <= 0 then
		return
	end
	for i = 0,nHumanCount - 1 do
		local nHumanID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanID) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanID) == 1 then
			x893391_TransPlayerObjToHome( sceneId , nHumanID)
		end
	end
end
--**********************************
--传送地图内某个玩家到三大主城
--**********************************
function x893391_TransPlayerObjToHome( sceneId , selfId)
	if sceneId ~= SCENE_ID_DIGONG_1HD and sceneId ~= SCENE_ID_DIGONG_2HD and sceneId ~= SCENE_ID_DIGONG_3HD and sceneId ~= SCENE_ID_DIGONG_4HD then
		x893391_Tips( sceneId, selfId, "#{MJXZ_210510_177}" )
		return
	end
	local CanEnter = IsCanNewWorld(sceneId,selfId,SCENE_LUOYANG,x893391_g_BackPos[SCENE_LUOYANG][1],x893391_g_BackPos[SCENE_LUOYANG][2])
	if CanEnter ~= nil and CanEnter == 1 then
		NewWorld(sceneId,selfId,SCENE_LUOYANG,x893391_g_BackPos[SCENE_LUOYANG][1],x893391_g_BackPos[SCENE_LUOYANG][2])
	else
		x893391_Tips( sceneId, selfId, "#{MJXZ_210510_250}" )
		NewWorld(sceneId,selfId,SCENE_DALI,x893391_g_BackPos[SCENE_DALI][1],x893391_g_BackPos[SCENE_DALI][2])
	end
end
--**********************************
--提示信息
--**********************************
function x893391_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x893391_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

