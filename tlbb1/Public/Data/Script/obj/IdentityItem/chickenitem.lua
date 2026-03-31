--斗鸡灵偶

x998725_g_ScriptId = 998725
x998725_g_MonsterDataId = 52212
x998725_g_MaxCreateNum = 512

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x998725_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x998725_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x998725_OnDeplete( sceneId, selfId )
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
function x998725_OnActivateOnce( sceneId, selfId )
	
	local PosX, PosY = LuaFnGetWorldPos( sceneId, selfId )
	local nMonsterObj = CreateMonsterWithDir(sceneId,x998725_g_MonsterDataId,PosX + 1,PosY + 1,3,-1,998726,33)
	if nMonsterObj < 0 then
		x998725_NotifyTip( sceneId, selfId, "#{SFDJ_240117_10}" )
		return
	else
		SetCharacterName(sceneId,nMonsterObj,GetName(sceneId,selfId).."的斗鸡")
		SetMonsterCurSpecialOwner(sceneId,nMonsterObj,selfId)
		SetCharacterTimer(sceneId,nMonsterObj,5000)
	end
	--存在5分钟
	SetCharacterDieTime(sceneId, nMonsterObj, 1000*60*5)	
	--记录创建者GUID
	LuaFnSetNpcIntParameter(sceneId,nMonsterObj,0,LuaFnGetGUID(sceneId,selfId))
	x998725_NotifyTip( sceneId, selfId, "#{SFDJ_240117_119}" )

	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x998725_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--条件检测
--**********************************
function x998725_OnConditionCheck( sceneId, selfId )
	--总量限制在512个
	local nCheckNum = 0
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x998725_g_MonsterDataId then
			nCheckNum = nCheckNum + 1
		end
		local nMonsterSpecialOwner = GetMonsterCurSpecialOwner(sceneId,MonsterId)
		if nMonsterSpecialOwner == selfId then
			x998725_NotifyTip( sceneId, selfId, "#{SFDJ_240117_22}" )
			return 0
		end
	end
	if nCheckNum >= x998725_g_MaxCreateNum then
		x998725_NotifyTip( sceneId, selfId, "#{SFDJ_240117_117}" )
		return 0
	end
	
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x998725_SkillOnUnitOne(sceneId,selfId, nSkillId)
	
end

--**********************************
--醒目提示
--**********************************
function x998725_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end