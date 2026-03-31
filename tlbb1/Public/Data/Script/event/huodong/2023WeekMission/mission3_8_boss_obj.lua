--千机木甲豹

--脚本号
x890141_g_ScriptId	= 890141
--**********************************
--入口函数
--**********************************
function x890141_OnDefaultEvent( sceneId, selfId, targetId )
	
end
--**********************************
--事件列表选中一项
--**********************************
function x890141_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--重置AI....
--**********************************
function x890141_ResetMyAI( sceneId, selfId )
end

--**********************************
--初始化....
--**********************************
function x890141_OnInit(sceneId, selfId)
	--重置AI....
	x890141_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x890141_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end	
end

--**********************************
--技能释放成功
--**********************************
function x890141_OnUseSkillSuccess(sceneId, selfId,nSkillId,targetId)
	
end
--**********************************
--进入战斗....
--**********************************
function x890141_OnEnterCombat(sceneId, selfId, enmeyId)
	--发表讲话
--	PaoPaoExEx(sceneId,selfId, 429)
end


--**********************************
--离开战斗....
--**********************************
function x890141_OnLeaveCombat(sceneId, selfId)

end


--**********************************
--杀死敌人....
--**********************************
function x890141_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡....
--**********************************
function x890141_OnDie( sceneId, selfId, killerId )
	--标记副本结束
	LuaFnSetCopySceneData_Param(sceneId, 4, 1);
end

--**********************************
--对话框提示
--**********************************
function x890141_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

