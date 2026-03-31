--料理锅
x998705_g_ScriptId = 998705
x998705_g_aItemConfig = {
	--参翅玉脍宴
	[38003070] = {
		dataId = 51945,
		strName = "#{SFDJ_240117_157}",
		maxEatNum = 30,
	},
	--牛羊全炙宴
	[38003071] = {
		dataId = 51948,			
		strName = "#{SFDJ_240117_158}",
		maxEatNum = 30,
	},
}

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998705_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998705_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x998705_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x998705_OnActivateOnce( sceneId, selfId )
	--SFDJ_240117_29	您尚未加入任意帮会，无法使用。	
	local nGuildId = GetHumanGuildID(sceneId,selfId)
	if nGuildId == -1 then
		x998705_NotifyTip( sceneId, selfId, "#{SFDJ_240117_29}" )
		return
	end
	local nItemId = LuaFnGetItemIndexOfUsedItem(sceneId,selfId)
	local tConfig = x998705_g_aItemConfig[nItemId]
	if tConfig == nil then
		return
	end
	--创建操作用NPC
	local PosX, PosY = LuaFnGetWorldPos( sceneId, selfId )
	local nMonsterObj = CreateMonsterWithDir(sceneId,tConfig.dataId,PosX + 1,PosY + 1,3,-1,998706,GetObjDir(sceneId,selfId))
	if nMonsterObj < 0 then
		x998705_NotifyTip( sceneId, selfId, "#{SFDJ_240117_10}" )
		return
	else
--		SetCharacterName(sceneId,nMonsterObj,ScriptGlobal_Format("#{SFDJ_240117_14}",GetName(sceneId,selfId),tConfig.strName))
		SetCharacterTitle(sceneId,nMonsterObj,ScriptGlobal_Format("#{SFDJ_240117_156}",GetName(sceneId,selfId)))
	end
	--存在5分钟
	SetCharacterDieTime(sceneId, nMonsterObj, 1000*60*5)	
	--记录创建者GUID
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,0,LuaFnGetGUID(sceneId,selfId))
	--记录归属类型
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,1,nItemId)
	--记录剩余数量
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,2,tConfig.maxEatNum)
	--记录归属帮会
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,3,nGuildId)
	
	x998705_NotifyTip( sceneId, selfId, "#{SFDJ_240117_119}" )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998705_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
--**********************************
--条件检测
--**********************************
function x998705_OnConditionCheck( sceneId, selfId )
	local nSafeLevel = LuaFnGetSceneSafeLevel(sceneId)
	if nSafeLevel >= 10000  then
		x998705_NotifyTip( sceneId, selfId, "#{SFDJ_240117_116}" )
		return 0
	end
	--SFDJ_240117_29	您尚未加入任意帮会，无法使用。	
	local nGuildId = GetHumanGuildID(sceneId,selfId)
	if nGuildId == -1 then
		x998705_NotifyTip( sceneId, selfId, "#{SFDJ_240117_29}" )
		return 0
	end
	local nItemId = LuaFnGetItemIndexOfUsedItem(sceneId,selfId)
	if x998705_g_aItemConfig[nItemId] == nil then
		return 0
	end
	return 1
end

--**********************************
--醒目提示
--**********************************
function x998705_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end