--水月山庄剧情侏儒刺客梵无救
--脚本号
x891105_g_ScriptId	= 891105
x891105_PatrolTime	= 1 --对话完毕之后的移动延迟数据
--**********************************
--入口函数
--**********************************
function x891105_OnDefaultEvent( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891105_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId,selfId,x891105_PatrolTime,2000)
end

--**********************************
--心跳....
--**********************************
function x891105_OnHeartBeat(sceneId, selfId, nTick)
	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end
	local Chat_1 = LuaFnGetCopySceneData_Param(sceneId,10)
	if Chat_1 == 7 then
		local PatrolTime = MonsterAI_GetIntParamByIndex(sceneId,selfId,x891105_PatrolTime)
		if PatrolTime > 0 then
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891105_PatrolTime,PatrolTime - nTick)
		else
			--设置寻路路径走人
			SetPatrolId(sceneId,selfId,2)
			MonsterAI_SetIntParamByIndex(sceneId,selfId,x891105_PatrolTime,60*60*1000)
			return
		end
	end
end

--**********************************
--进入战斗....
--**********************************
function x891105_OnEnterCombat(sceneId, selfId, enmeyId)
end


--**********************************
--离开战斗....
--**********************************
function x891105_OnLeaveCombat(sceneId, selfId)
end


--**********************************
--杀死敌人....
--**********************************
function x891105_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891105_OnDie( sceneId, selfId, killerId )
end
