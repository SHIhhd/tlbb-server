--**********************************
--事件交互入口
--**********************************
x332208_g_MissionId = 1159;
x332208_g_ItemId = 40004488;
x332208_g_Tab = {}
x332208_g_Tab[6] = {1,"#{ZXCM_090602_34}1/1",53,264}
x332208_g_Tab[7] = {2,"#{ZXCM_090602_35}1/1",130,135}
x332208_g_Tab[8] = {3,"#{ZXCM_090602_36}1/1",260,260}
x332208_g_Tab[4] = {4,"#{ZXCM_090602_37}1/1",160,252}
x332208_g_Tab[3] = {5,"#{ZXCM_090602_38}1/1",275,85}
x332208_g_Tab[30] = {6,"#{ZXCM_090602_39}1/1",170,235}
function x332208_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x332208_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x332208_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x332208_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	if 1 ~= IsHaveMission(sceneId, selfId, x332208_g_MissionId) then
		return 0
	end
	local ItemId = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x332208_g_ItemId ~= ItemId then
		return 0
	end
	local missionidx = x332208_g_Tab[sceneId];
	if not missionidx then
		return 0
	end
	--取得玩家当前坐标
	local PlayerX = GetHumanWorldX(sceneId,selfId)
	local PlayerZ = GetHumanWorldZ(sceneId,selfId)
	--计算玩家与设阵点的距离
	local Distance = floor(sqrt((missionidx[3]-PlayerX)*(missionidx[3]-PlayerX)+(missionidx[4]-PlayerZ)*(missionidx[4]-PlayerZ)))
	if Distance > 5 then
		x332208_Tip(sceneId,selfId,"#{ZXCM_090602_24}")
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x332208_g_MissionId)
	local Isok = GetMissionParam(sceneId,selfId,misIndex,missionidx[1])
	if Isok == 1 then
		x332208_Tip( sceneId,selfId,"#{ZXCM_090602_25}" )
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
function x332208_OnDeplete( sceneId, selfId )
	-- if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		-- return 1;
	-- end
	return 1;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x332208_OnActivateOnce( sceneId, selfId )
	if 1 ~= IsHaveMission(sceneId, selfId, x332208_g_MissionId) then
		return 0
	end
	local ItemId = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x332208_g_ItemId ~= ItemId then
		return 0
	end
	local missionidx = x332208_g_Tab[sceneId];
	if not missionidx then
		return 0
	end
	--取得玩家当前坐标
	local PlayerX = GetHumanWorldX(sceneId,selfId)
	local PlayerZ = GetHumanWorldZ(sceneId,selfId)
	--计算玩家与设阵点的距离
	local Distance = floor(sqrt((missionidx[3]-PlayerX)*(missionidx[3]-PlayerX)+(missionidx[4]-PlayerZ)*(missionidx[4]-PlayerZ)))
	if Distance > 5 then
		x332208_Tip(sceneId,selfId,"#{ZXCM_090602_24}")
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x332208_g_MissionId)
	local Isok = GetMissionParam(sceneId,selfId,misIndex,missionidx[1])
	if Isok == 1 then
		x332208_Tip( sceneId,selfId,"#{ZXCM_090602_25}" )
		return 0
	end
	SetMissionByIndex(sceneId, selfId,misIndex,missionidx[1],1)
	x332208_Tip(sceneId,selfId,missionidx[2]);
	Isok = 1;
	for i = 1,6 do
		if 1 ~= GetMissionParam(sceneId,selfId,misIndex,i) then
			Isok = nil;
			break
		end
	end
	if Isok == 1 then
		SetMissionByIndex(sceneId, selfId,misIndex,0,Isok);
	end
	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x332208_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x332208_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end


