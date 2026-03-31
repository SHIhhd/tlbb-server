--MisDescBegin
--脚本号
x998594_g_ScriptId = 998594

x998594_g_KDZZID = 1001000252
x998594_g_SubKDZZID_Mission = 5

--任务号
x998594_g_MissionId = 2250

--任务归类
x998594_g_MissionKind = 66

--任务等级
x998594_g_MissionLevel = 50

--是否是精英任务
x998594_g_IfMissionElite = 0

--任务名
x998594_g_MissionName="#{YCGZ_231225_139}"
x998594_g_MissionTarget=""
x998594_g_IsMissionOkFail=0
x998594_g_Custom = {}


--MisDescEnd
--任务主逻辑脚本
x998594_g_LogicScript = 998595
--当前等级需要制作的物品数量
x998594_g_NeedDoCount = 18
--当前对应的盟会生活技能等级
x998594_g_NeedAbilityLevel = 9
--**********************************
--任务入口函数
--**********************************
function x998594_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction( x998594_g_LogicScript, "OnDefaultEvent",sceneId, selfId, targetId,x998594_g_ScriptId,x998594_g_NeedDoCount,x998594_g_NeedAbilityLevel )
end
--**********************************
--列举事件
--**********************************
function x998594_OnEnumerate( sceneId, selfId, targetId )
	CallScriptFunction( x998594_g_LogicScript, "OnEnumerate",sceneId, selfId, targetId,x998594_g_ScriptId,x998594_g_MissionName,x998594_g_NeedAbilityLevel )
end

--**********************************
--检测接受条件
--**********************************
function x998594_CheckAccept( sceneId, selfId )
	return CallScriptFunction( x998594_g_LogicScript, "CheckAccept",sceneId, selfId, x998594_g_NeedAbilityLevel )
end

--**********************************
--客户端请求接收任务
--**********************************
function x998594_OnAccept(sceneId,selfId,targetId)
	CallScriptFunction( x998594_g_LogicScript, "OnAccept",sceneId, selfId, targetId,x998594_g_ScriptId,x998594_g_NeedDoCount,x998594_g_MissionName,x998594_g_NeedAbilityLevel )
end

--**********************************
--放弃
--**********************************
function x998594_OnAbandon( sceneId, selfId )
	CallScriptFunction( x998594_g_LogicScript, "OnAbandon",sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x998594_OnSubmit( sceneId, selfId, targetId )
	CallScriptFunction( x998594_g_LogicScript, "OnSubmit",sceneId, selfId, targetId,x998594_g_MissionName )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998594_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998594_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998594_OnItemChanged( sceneId, selfId, itemdataId )
	CallScriptFunction( x998594_g_LogicScript, "OnItemChanged",sceneId, selfId, itemdataId )
end

