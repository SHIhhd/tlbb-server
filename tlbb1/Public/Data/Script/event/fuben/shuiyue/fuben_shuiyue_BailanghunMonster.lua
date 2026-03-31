--水月山庄 白狼魂
--脚本号
x891065_g_ScriptId	= 891065
x891065_SpecialObjData = 1099
x891079_ImpactData = 10524 --狩猎状态
--**********************************
--入口函数
--**********************************
function x891065_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891065_OnInit(sceneId, selfId)
	
end

--**********************************
--心跳....
--**********************************
function x891065_OnHeartBeat(sceneId, selfId, nTick)
	local nTarGetID = LuaFnGetNpcIntParameter(sceneId,selfId,0)
	if nTarGetID > 0 then
		if IsInDist(sceneId,nTarGetID,selfId,3) == 1 then
			local x,z = GetWorldPos(sceneId,selfId)
			LuaFnDeleteMonster(sceneId,selfId)
			CreateSpecialObjByDataIndex(sceneId,selfId,x891065_SpecialObjData,x,z,0)
			LuaFnSetNpcIntParameter(sceneId,selfId,0,0) --清除目标讯息
			LuaFnCancelSpecificImpact(sceneId,nTarGetID,x891079_ImpactData) --清除被狩猎者状态
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x891065_OnEnterCombat(sceneId, selfId, enmeyId)
	
end


--**********************************
--离开战斗....
--**********************************
function x891065_OnLeaveCombat(sceneId, selfId)
	
end


--**********************************
--杀死敌人....
--**********************************
function x891065_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891065_OnDie( sceneId, selfId, killerId )
	LuaFnSetNpcIntParameter(sceneId,selfId,0,0) --清除目标讯息
end


--**********************************
--重置AI....
--**********************************
function x891065_ResetMyAI( sceneId, selfId )

end

--**********************************
--对话框提示
--**********************************
function x891065_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

