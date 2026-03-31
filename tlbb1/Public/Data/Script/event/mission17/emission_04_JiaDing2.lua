--水月山庄剧情伪装的家丁乙
--脚本号
x891103_g_ScriptId	= 891103
x891103_g_FuBen_ScriptId = 891099
x891103_First_Chat	= 1 --第一次发送对话的延迟
x891103_Two_Chat	= 2 --第二次发送对话的延迟
--**********************************
--入口函数
--**********************************
function x891103_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891103_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891103_First_Chat,2000)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891103_Two_Chat,5000)
end

--**********************************
--心跳....
--**********************************
function x891103_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	local ChatTimeFirst = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891103_First_Chat)
	if ChatTimeFirst > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891103_First_Chat,ChatTimeFirst - nTick)
	else
		LuaFnNpcChat(sceneId,selfId,0,"#{YXDHYD_20210205_21}")
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891103_First_Chat,60*60*1000)
		return
	end
	local ChatTimeTwo = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891103_Two_Chat)
	if ChatTimeTwo > 0 then
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891103_Two_Chat,ChatTimeTwo - nTick)
	else
		LuaFnNpcChat(sceneId,selfId,0,"#{YXDHYD_20210205_23}")
		MonsterAI_SetIntParamByIndex(sceneId,selfId,x891103_Two_Chat,60*60*1000)
		return
	end
end

--**********************************
--进入战斗....
--**********************************
function x891103_OnEnterCombat(sceneId, selfId, enmeyId)
end


--**********************************
--离开战斗....
--**********************************
function x891103_OnLeaveCombat(sceneId, selfId)
end


--**********************************
--杀死敌人....
--**********************************
function x891103_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891103_OnDie( sceneId, selfId, killerId )
	CallScriptFunction(x891103_g_FuBen_ScriptId,"OnDie",sceneId,selfId,killerId)
end
