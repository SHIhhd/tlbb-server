--愿灵泉
x300084_g_scriptId = 300084
x300084_g_event = 808131
x300084_g_MissionId = 1161
x300084_g_IsMissionOkFail = 0
x300084_g_IsMissionCount=1
--**********************************
--事件交互入口
--**********************************
function x300084_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x300084_IsSkillLikeScript( sceneId, selfId)
	--计算玩家与许愿树的距离
	local Isok = CallScriptFunction(x300084_g_event,"OnUseItem",sceneId,selfId)
	if Isok ~= 1 then
		return 0
	end
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID >= 13290 and MosDataID <= 13293 then
			if IsInDist(sceneId,selfId,MonsterId,2) ~= 1 then
				x300084_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_14}")
				return 0
			end
		end
	end
	x300084_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_17}")
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x300084_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x300084_OnConditionCheck( sceneId, selfId )
	local Isok = CallScriptFunction(x300084_g_event,"OnUseItem",sceneId,selfId)
	if Isok ~= 1 then
		return 0
	end
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x300084_OnDeplete( sceneId, selfId )
	local Isok = CallScriptFunction(x300084_g_event,"OnUseItem",sceneId,selfId)
	if Isok ~= 1 then
		return 0
	end
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
function x300084_OnActivateOnce(sceneId,selfId)
	--记录次数使用次数
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x300084_g_MissionId)
	local Isok = GetMissionParam(sceneId,selfId,nMisIndex,x300084_g_IsMissionOkFail)
	local szName = GetName(sceneId,selfId)
	local nPlayerWishCount = GetMissionDataEx(sceneId,selfId,MDEX_WISHES_COUNT)
	nPlayerWishCount = nPlayerWishCount + 1
	local nWorldAllWishCount = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_WISHES_1001Count) --这是降临奇迹数据
	local nWorldWishCount = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_WISHES_ALLCOUNT) --全区玩家次数记录
	--每日许愿树只能爆发三次
	if nWorldAllWishCount < 3 then
		nWorldWishCount = nWorldWishCount + 1
		if mod(nWorldWishCount,501) == 0 then
			AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}#{SQXY_09061_1}",szName))
			CallScriptFunction(4112,"CreateMonster",sceneId,selfId,1)
		end
		if mod(nWorldWishCount,801) == 0 then
			AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}#{SQXY_09061_2}",szName))
			CallScriptFunction(4112,"CreateMonster",sceneId,selfId,2)
		end
		if mod(nWorldWishCount,1001) == 0 then
			AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}#{SQXY_09061_3}",szName)) --达到1001次了就爆发。
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_WISHES_1001Count,nWorldAllWishCount + 1)
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_WISHES_ALLCOUNT,0) --清零重新记录下一轮
			CallScriptFunction(4112,"CreateMonster",sceneId,selfId,3)
		else
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_WISHES_ALLCOUNT,nWorldWishCount) --记录全区使用次数
		end
	end
	--记录任务次数
	SetMissionDataEx(sceneId,selfId,MDEX_WISHES_COUNT,nPlayerWishCount) --增加玩家个人次数
	--写入任务记录
	SetMissionByIndex(sceneId,selfId,nMisIndex,x300084_g_IsMissionCount,nPlayerWishCount)
	if nPlayerWishCount >= 5 then
		--完成任务设置
		if Isok == 0 then
			SetMissionByIndex(sceneId,selfId,nMisIndex,x300084_g_IsMissionOkFail,1) --设置完成任务
		end
	end
	x300084_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_18}")
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x300084_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x300084_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end