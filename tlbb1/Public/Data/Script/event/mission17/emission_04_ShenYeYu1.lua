--水月山庄剧情沈夜雨1
--脚本号
x891101_g_ScriptId	= 891101

--**********************************
--入口函数
--**********************************
function x891101_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId,"#{YXDHYD_20210207_138}")
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end


--**********************************
--初始化....
--**********************************
function x891101_OnInit(sceneId, selfId)
	LuaFnNpcChat(sceneId,selfId,0,"#{YXDHYD_20210205_19}")
end

--**********************************
--心跳....
--**********************************
function x891101_OnHeartBeat(sceneId, selfId, nTick)
end

--**********************************
--进入战斗....
--**********************************
function x891101_OnEnterCombat(sceneId, selfId, enmeyId)
end


--**********************************
--离开战斗....
--**********************************
function x891101_OnLeaveCombat(sceneId, selfId)
end


--**********************************
--杀死敌人....
--**********************************
function x891101_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x891101_OnDie( sceneId, selfId, killerId )
end
