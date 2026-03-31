--水月山庄副本剧情引导任务用百里香
x891098_g_scriptId = 891098
x891098_g_MissionId = 2003
x891098_g_IsMissionOkFail = 0
x891098_g_IsMissionCheck = 1
--**********************************
--事件交互入口
--**********************************
function x891098_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x891098_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x891098_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891098_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	if IsHaveMission(sceneId,selfId,x891098_g_MissionId) > 0 then
		local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891098_g_MissionId)
		local param = GetMissionParam(sceneId,selfId,nMisIndex,1)
		if param >= 2 then
			return 0
		end
		if GetLevel(sceneId,selfId) < 80 then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_235}")
			return 0
		end
		--探查玩家是否是在夜探水月山庄副本内
		local sceneType = LuaFnGetSceneType(sceneId)
		if sceneType ~= 1 then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_241}")
			return 0
		end
		if LuaFnGetCopySceneData_Param(sceneId,0) ~= FUBEN_YETANSHUIYUESHANZHAUNG then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_241}")
			return 0
		end
		--双人坐骑状态下
		if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_243}")
			return 0
		end
		--坐骑状态下
		if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_243}")
			return 0
		end
		--变身状态下
		if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_242}")
			return 0
		end
		--取得玩家当前坐标
		local PlayerX = GetHumanWorldX(sceneId,selfId)
		local PlayerZ = GetHumanWorldZ(sceneId,selfId)
		--计算玩家与宝藏的距离
		local Distance = floor(sqrt((120-PlayerX)*(120-PlayerX)+(186-PlayerZ)*(186-PlayerZ)))
		if Distance > 2 then
			x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_241}")
			return 0
		end
	else
		x891098_NotifyFailTips(sceneId,selfId,"#{YXDHYD_20210207_237}")
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
function x891098_OnDeplete( sceneId, selfId )
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
function x891098_OnActivateOnce(sceneId,selfId)
	--记录次数使用次数
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891098_g_MissionId)
	SetMissionByIndex(sceneId,selfId,nMisIndex,x891098_g_IsMissionCheck,2) --设置第二个任务已完成，客户端有动态显示
	--脚下释放极品百里香
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	LuaFnCreateMonster(sceneId,49013,nPosX,nPosZ,3,-1,-1)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i = 0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID(sceneId,MonsterId)
		if MosDataID == 49003 then
			--先清除门口那俩家丁然后再创建两个可以打架的家丁
			LuaFnDeleteMonster(sceneId,MonsterId)
		end
	end
	--创建伪装的家丁入场
	local Npc_1 = CreateMonsterWithDir(sceneId,49001,122,163,21,-1,891102,0)
	local Npc_2 = CreateMonsterWithDir(sceneId,49002,128,163,21,-1,891103,0)
	if Npc_1 > 0 then
		--设置寻路
		SetPatrolId(sceneId,Npc_1,0)
	end
	if Npc_2 > 0 then
		--设置寻路
		SetPatrolId(sceneId,Npc_2,1)
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x891098_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891098_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end