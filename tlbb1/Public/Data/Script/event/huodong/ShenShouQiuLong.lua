--道具：至尊神兽囚笼<ID:30309764>
--脚本号 809320
x809320_g_scriptId = 809320
x809320_g_ItemID = 30309764
x809320_g_petList = {}
x809320_g_petList[30309764] = {dataIds = {}}
x809320_g_petList[30309764].dataIds[1] = {dataId=22869,minHumanLevel=1,maxHumanLevel=44}
x809320_g_petList[30309764].dataIds[2] = {dataId=22879,minHumanLevel=45,maxHumanLevel=54}
x809320_g_petList[30309764].dataIds[3] = {dataId=22889,minHumanLevel=55,maxHumanLevel=64}
x809320_g_petList[30309764].dataIds[4] = {dataId=22899,minHumanLevel=65,maxHumanLevel=74}
x809320_g_petList[30309764].dataIds[5] = {dataId=22909,minHumanLevel=75,maxHumanLevel=84}
x809320_g_petList[30309764].dataIds[6] = {dataId=22919,minHumanLevel=85,maxHumanLevel=94}
x809320_g_petList[30309764].dataIds[7] = {dataId=22929,minHumanLevel=95,maxHumanLevel=150}
--**********************************
--事件交互入口
--**********************************
function x809320_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x809320_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x809320_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x809320_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	local PlayerLevel = GetLevel( sceneId, selfId )
	local itemSn = LuaFnGetItemIndexOfUsedItem(sceneId, selfId);
	if x809320_g_petList[itemSn] == nil then
		x809320_Tips(sceneId,selfId,"未开放道具，无法使用。")
		return 0
	end
	local checkCreatePet = TryCreatePet(sceneId,selfId,2);
	if not checkCreatePet or checkCreatePet ~= 1 then
		x809320_Tips(sceneId, selfId, "#{QXHD_090807_9}");
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
function x809320_OnDeplete( sceneId, selfId )
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
function x809320_OnActivateOnce( sceneId, selfId )
    
    --检测是否可以添加珍兽
    local bCreate = TryCreatePet(sceneId,selfId,2)
    local itemSn = LuaFnGetItemIndexOfUsedItem(sceneId, selfId);
	local petItem = x809320_g_petList[itemSn];
	local level = GetLevel( sceneId, selfId );
    if bCreate > 0 then
		for i,pet in petItem.dataIds do
			if level >= pet.minHumanLevel and level <= pet.maxHumanLevel then
				LuaFnCreatePetDiffSexToHuman(sceneId,selfId,pet.dataId,1,1)
				LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
				x809320_Tips(sceneId,selfId,"#{CZDS_090902_1}")
			end
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
function x809320_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x809320_Tips(sceneId,selfId,tip)
    BeginEvent(sceneId)
		AddText(sceneId,tip)
 	EndEvent(sceneId)
 	DispatchMissionTips(sceneId,selfId)
end