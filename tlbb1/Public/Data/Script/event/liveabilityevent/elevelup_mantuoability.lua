--侍花技能升级

--脚本号
x893349_g_ScriptId = 893349

--此npc可以升到的最高等级
x893349_g_nMaxLevel = 10

--**********************************
--任务入口函数
--**********************************
function x893349_OnDefaultEvent( sceneId, selfId, targetId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_SHIHUA)
	--玩家侍花技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_SHIHUA)
	--任务判断

	--判断是否是曼陀山庄弟子,不是曼陀弟子不能学习
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
			AddText(sceneId,"#{XMPSH_220628_13}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--如果生活技能等级已经超出该npc所能教的范围
	if AbilityLevel >= x893349_g_nMaxLevel then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPSH_220628_14}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		--DispatchAbilityInfo(sceneId, selfId, targetId,x893349_g_ScriptId, ABILITY_SHIHUA, LEVELUP_ABILITY_MENPAI[AbilityLevel+1].Money, LEVELUP_ABILITY_MENPAI[AbilityLevel+1].HumanExp, LEVELUP_ABILITY_MENPAI[AbilityLevel+1].AbilityExpLimitShow,LEVELUP_ABILITY_MENPAI[AbilityLevel+1].HumanLevelLimit)
		local tempAbilityId = ABILITY_SHIHUA;
		local tempAbilityLevel = AbilityLevel + 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			DispatchAbilityInfo(sceneId, selfId, targetId,x893349_g_ScriptId, tempAbilityId, demandMoney, demandExp, limitAbilityExpShow, limitLevel);
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893349_OnEnumerate( sceneId, selfId, targetId )
		--如果不到等级则不显示选项
		if 1 then
			AddNumText(sceneId,x893349_g_ScriptId,"#{XMPSH_220628_3}", 12, 1)
		end
		return
end

--**********************************
--检测接受条件
--**********************************
function x893349_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x893349_OnAccept( sceneId, selfId, ABILITY_SHIHUA )
end
