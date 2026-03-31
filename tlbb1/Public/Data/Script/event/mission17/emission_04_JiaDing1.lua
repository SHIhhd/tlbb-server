--水月山庄剧情伪装的家丁甲
--脚本号
x891102_g_ScriptId	= 891102
x891102_g_FuBen_ScriptId = 891099
x891102_First_Chat	= 1 --第一次发送对话的延迟
x891102_Two_Chat	= 2 --第二次发送对话的延迟
--**********************************
--入口函数
--**********************************
function x891102_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891102_OnInit(sceneId,selfId)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891102_First_Chat,2000)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891102_Two_Chat,5000)
end

--**********************************
--心跳....
--**********************************
function x891102_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	local ChatTimeFirst = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891102_First_Chat)
	if ChatTimeFirst > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891102_First_Chat,ChatTimeFirst - nTick)
	else
		LuaFnNpcChat(sceneId,selfId,0,"#{YXDHYD_20210205_20}")
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891102_First_Chat,60*60*1000)
		return
	end
	local ChatTimeTwo = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891102_Two_Chat)
	if ChatTimeTwo > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891102_Two_Chat,ChatTimeTwo - nTick)
	else
		LuaFnNpcChat(sceneId,selfId,0,"#{YXDHYD_20210205_22}")
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891102_Two_Chat,60*60*1000)
		return
	end
end

--**********************************
--进入战斗....
--**********************************
function x891102_OnEnterCombat(sceneId, selfId, enmeyId)
end


--**********************************
--离开战斗....
--**********************************
function x891102_OnLeaveCombat(sceneId, selfId)
end


--**********************************
--杀死敌人....
--**********************************
function x891102_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891102_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x891102_g_FuBen_ScriptId,"OnDie",sceneId,selfId,killerId)
end
