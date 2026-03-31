--水月山庄剧情沈夜雨2
--脚本号
x891104_g_ScriptId	= 891104

--**********************************
--入口函数
--**********************************
function x891104_OnDefaultEvent( sceneId, selfId, targetId )
	--触发就完成任务
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,2003)
	SetMissionByIndex(sceneId,selfId,nMisIndex,0,1)
	--再来一条全屏提示就行了
	CallScriptFunction(891099,"NotifyTips",sceneId,ScriptGlobal_Format("#{YXDHYD_20210304_01}",30))
	--后面啥样没看到，没办法...
	BeginEvent( sceneId )
		AddText( sceneId,"#{YXDHYD_20210304_08}")
		AddNumText(sceneId,x891104_g_ScriptId,"#{YXDHYD_20210304_09}",9,1)
	EndEvent( sceneId )
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x891104_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumText = GetNumText()
	if nNumText == 1 then
		--清除变身BUFF
		LuaFnCancelSpecificImpact(sceneId,selfId,10514)
		NewWorld(sceneId,selfId,1,130,107)
	end
end

--**********************************
--初始化....
--**********************************
function x891104_OnInit(sceneId, selfId)
end

--**********************************
--心跳....
--**********************************
function x891104_OnHeartBeat(sceneId, selfId, nTick)
end

--**********************************
--进入战斗....
--**********************************
function x891104_OnEnterCombat(sceneId, selfId, enmeyId)
end


--**********************************
--离开战斗....
--**********************************
function x891104_OnLeaveCombat(sceneId, selfId)
end


--**********************************
--杀死敌人....
--**********************************
function x891104_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891104_OnDie( sceneId, selfId, killerId )
end
