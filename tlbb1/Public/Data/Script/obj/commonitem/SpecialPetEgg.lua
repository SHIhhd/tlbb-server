--狭路逢三个珍兽蛋
x891217_g_scriptId = 891217
x891217_g_PetInfo = 
{
	[30309086] = {dataId = 24661,minPerception = 2500,maxPerception = 2650,level = 1},
	[30309087] = {dataId = 24661,minPerception = 2350,maxPerception = 2500,level = 1},
	[30309088] = {dataId = 24661,minPerception = 2200,maxPerception = 2350,level = 1}
}
--**********************************
--事件交互入口
--**********************************
function x891217_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x891217_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x891217_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891217_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	local itemSn = LuaFnGetItemIndexOfUsedItem(sceneId, selfId);
	if x891217_g_PetInfo[itemSn] == nil then
		x891217_Tips(sceneId,selfId,"未开放道具，无法使用。")
		return 0
	end
	local checkCreatePet = TryCreatePet(sceneId,selfId,1);
	if not checkCreatePet or checkCreatePet ~= 1 then
		x891217_Tips(sceneId, selfId, "#{SDJZH_091106_35}");
		return 0;
	end
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x891217_OnDeplete( sceneId, selfId )
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
function x891217_OnActivateOnce( sceneId, selfId )
    --检测是否可以添加珍兽
    local bCreate = TryCreatePet(sceneId,selfId,1)
    local itemSn = LuaFnGetItemIndexOfUsedItem(sceneId, selfId);
	local petItem = x891217_g_PetInfo[itemSn];
	local szPetName = GetPetName(petItem.dataId)
	local nPetIndex,pet_H,pet_L = -1,0,0
    if bCreate > 0 then
		local ret,petGUID_H,petGUID_L = CallScriptFunction( 800105, "CreateRMBPetToHuman", sceneId, selfId, petItem.dataId, petItem.level);
		if ret and ret == 1 then
			LuaFnSetPetGrowRateByGUID(sceneId,selfId,petGUID_H,petGUID_L,2388)
			local nPerception = random(petItem.minPerception,petItem.maxPerception)
			local nPetNum = LuaFnGetPetCount(sceneId,selfId)
			for i = 0,nPetNum -1 do
				pet_H, pet_L = LuaFnGetPetGUID(sceneId,selfId,i)
				if pet_L == petGUID_L then
					nPetIndex = i
					break;
				end
			end
			LuaFnSetPet_ConPerception(sceneId,selfId,nPetIndex,nPerception)
			x891217_Tips(sceneId,selfId,"#{SDJZH_091106_36}"..szPetName)
		end
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x891217_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x891217_Tips(sceneId,selfId,tip)
    BeginEvent(sceneId)
		AddText(sceneId,tip)
 	EndEvent(sceneId)
 	DispatchMissionTips(sceneId,selfId)
end