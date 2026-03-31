--天赋子任务2 采集任务 采集脚本

x891282_g_ScriptId	= 891282
--任务脚本号
x891282_g_MissionScriptId = 891275

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891282_OnConditionCheck( sceneId, selfId, targetId )
	return CallScriptFunction(x891282_g_MissionScriptId, "CanPickCheck",sceneId, selfId, targetId)
end
--**********************************
--技能释放完毕
--**********************************
function x891282_SkillOnUnitOne(sceneId,selfId, nSkillId,targetId )
	CallScriptFunction(x891282_g_MissionScriptId, "PickItemFinish",sceneId, selfId, targetId)
end


