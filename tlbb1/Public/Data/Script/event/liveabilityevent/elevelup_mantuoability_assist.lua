--调香技能升级

--脚本号
x893350_g_ScriptId = 893350

--此npc可以升到的最高等级
x893350_g_nMaxLevel = 10

--**********************************
--任务入口函数
--**********************************
function x893350_OnDefaultEvent( sceneId, selfId, targetId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_TIAOXIANG)
	--玩家调香技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_TIAOXIANG)
	--任务判断

	if GetMenPai(sceneId,selfId) ~= MP_MANTUO then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPSH_220628_4}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--如果还没有学会该生活技能
	if AbilityLevel < 1	then
		BeginEvent(sceneId)
			AddText(sceneId,"你还没有学会调香技能！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--如果生活技能等级已经超出该npc所能教的范围
	if AbilityLevel >= x893350_g_nMaxLevel then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPSH_220628_14}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		--DispatchAbilityInfo(sceneId, selfId, targetId,x893350_g_ScriptId, ABILITY_TIAOXIANG, LEVELUP_ABILITY_MENPAI[AbilityLevel+1].Money, LEVELUP_ABILITY_MENPAI[AbilityLevel+1].HumanExp, LEVELUP_ABILITY_MENPAI[AbilityLevel+1].AbilityExpLimitShow,LEVELUP_ABILITY_MENPAI[AbilityLevel+1].HumanLevelLimit)
		local tempAbilityId = ABILITY_TIAOXIANG;
		local tempAbilityLevel = AbilityLevel + 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			DispatchAbilityInfo(sceneId, selfId, targetId,x893350_g_ScriptId, tempAbilityId, demandMoney, demandExp, limitAbilityExpShow, limitLevel);
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893350_OnEnumerate( sceneId, selfId, targetId )
		--如果不到等级则不显示选项
		if 1 then
			AddNumText(sceneId,x893350_g_ScriptId,"#{XMPSH_220628_17}", 12, 1)
		end
		return
end

--**********************************
--检测接受条件
--**********************************
function x893350_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x893350_OnAccept( sceneId, selfId, ABILITY_TIAOXIANG )
end
