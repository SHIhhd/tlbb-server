--xbw的三个特殊宠物蛋
x999261_g_scriptId = 999261

x999261_g_petList = {};

-- JZGN_20230710_173	65级可携带	
-- JZGN_20230710_174	75级可携带	
-- JZGN_20230710_175	85级可携带	
-- JZGN_20230710_176	95级可携带
x999261_g_petList[30310127] = {type=2, dataIds={}, level=1}		--典藏珍兽蛋：千锋王蝎
x999261_g_petList[30310127].dataIds[1] = {dataId=31011,minPerception = 2240,maxPerception = 2320,takeLv=65}		-- 65

x999261_g_petList[30310128] = {type=2, dataIds={}, level=1}		--典藏珍兽蛋：千锋王蝎
x999261_g_petList[30310128].dataIds[1] = {dataId=31011,minPerception = 2240,maxPerception = 2320,takeLv=65,btn="#{JZGN_20230710_173}"}		-- 65
x999261_g_petList[30310128].dataIds[2] = {dataId=31021,minPerception = 2320,maxPerception = 2410,takeLv=75,btn="#{JZGN_20230710_174}"}		-- 75
x999261_g_petList[30310128].dataIds[3] = {dataId=31031,minPerception = 2410,maxPerception = 2500,takeLv=85,btn="#{JZGN_20230710_175}"}		-- 85

x999261_g_petList[30310129] = {type=2, dataIds={}, level=1}		--典藏珍兽蛋：千锋王蝎
x999261_g_petList[30310129].dataIds[1] = {dataId=31011,minPerception = 2240,maxPerception = 2320,takeLv=65,btn="#{JZGN_20230710_173}"}		-- 65
x999261_g_petList[30310129].dataIds[2] = {dataId=31021,minPerception = 2320,maxPerception = 2410,takeLv=75,btn="#{JZGN_20230710_174}"}		-- 75
x999261_g_petList[30310129].dataIds[3] = {dataId=31031,minPerception = 2410,maxPerception = 2500,takeLv=85,btn="#{JZGN_20230710_175}"}		-- 85
x999261_g_petList[30310129].dataIds[4] = {dataId=31041,minPerception = 2500,maxPerception = 2590,takeLv=95,btn="#{JZGN_20230710_176}"}		-- 95
--**********************************
--事件交互入口
--**********************************
function x999261_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x999261_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x999261_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x999261_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end

	local checkCreatePet = TryCreatePet(sceneId, selfId, 1);
	if not checkCreatePet or checkCreatePet ~= 1 then
		x999261_Tips(sceneId, selfId, "#{JZGN_20230710_171}");
		return 0;
	end

	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local itemUsePos = LuaFnGetBagIndexOfUsedItem(sceneId, selfId)
	local petItem = x999261_g_petList[itemTblIndex];
	if not petItem then
		x999261_Tips(sceneId, selfId, "#{JZGN_20230710_168}");
		return 0;
	end
	--一个的直接使用
	if getn(petItem.dataIds) == 1 then
		x999261_SpecialPetEggChoosePet( sceneId, selfId,itemUsePos,itemTblIndex,1 )
		return 0;
	end
	--客户端要单独弹出UI
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,itemUsePos);
		UICommand_AddInt(sceneId,itemTblIndex);
		UICommand_AddInt(sceneId,getn(petItem.dataIds));
		UICommand_AddInt(sceneId,x999261_g_scriptId);
		UICommand_AddString(sceneId,GetPetName(petItem.dataIds[1].dataId))--以第一个为准
		for i = 1, getn(petItem.dataIds) do
			UICommand_AddString(sceneId,petItem.dataIds[i].btn)
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 999261001)
		
	return 0; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x999261_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end

--**********************************
--客户端选择
--**********************************
function x999261_SpecialPetEggChoosePet( sceneId, selfId,nBagPos,nItemIndex,nSelect )
	if nBagPos == nil or nItemIndex == nil or nSelect == nil then
		return
	end
	local itemTblIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nBagPos )
	if itemTblIndex ~= nItemIndex then
		return
	end
	local bCreate = TryCreatePet(sceneId,selfId,1)
	if bCreate <= 0 then
		x999261_Tips(sceneId, selfId, "#{JZGN_20230710_171}");
		return
	end
	--删除前保存Trans....
	local ItemInfo = GetBagItemTransfer( sceneId, selfId, nBagPos )
	local petItem = x999261_g_petList[itemTblIndex];
	if not petItem then
		x999261_Tips(sceneId, selfId, "#{JZGN_20230710_168}");
		return
	end
	if nSelect < 0 or nSelect > getn(petItem.dataIds) or petItem.dataIds[nSelect] == nil or petItem.dataIds[nSelect].dataId == nil then
		x999261_Tips(sceneId, selfId, "#{JZGN_20230710_168}");
		return
	end
	if GetLevel(sceneId,selfId) < petItem.dataIds[nSelect].takeLv then
		x999261_Tips(sceneId, selfId, "#{JZGN_20230710_170}");
		return
	end
	local ret,petGUID_H,petGUID_L = CallScriptFunction( 800105, "CreateRMBPetToHuman", sceneId, selfId, petItem.dataIds[nSelect].dataId, petItem.level);
	if ret and ret == 1 then
		LuaFnSetPetGrowRateByGUID(sceneId,selfId,petGUID_H,petGUID_L,2388)
		local nPerception = random(petItem.dataIds[nSelect].minPerception,petItem.dataIds[nSelect].maxPerception)
		local nPetNum = LuaFnGetPetCount(sceneId,selfId)
		for i = 0,nPetNum -1 do
			pet_H, pet_L = LuaFnGetPetGUID(sceneId,selfId,i)
			if pet_L == petGUID_L then
				nPetIndex = i
				break;
			end
		end
		local ItemInfo = GetBagItemTransfer( sceneId, selfId, nBagPos )

		LuaFnSetPet_ConPerception(sceneId,selfId,nPetIndex,nPerception)
		x999261_Tips(sceneId,selfId,"#{SDJZH_091106_36}"..GetPetName(petItem.dataIds[nSelect].dataId))
		
		LuaFnEraseItem(sceneId,selfId,nBagPos)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		--广播
		local szPetTrans = GetPetTransString(  sceneId, selfId, petGUID_H, petGUID_L )
		local str = ScriptGlobal_Format( "#{JZGN_20230710_172}", GetName(sceneId,selfId), ItemInfo,szPetTrans)
		BroadMsgByChatPipe(sceneId, selfId, str, 4)
	end
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x999261_OnActivateOnce( sceneId, selfId )
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x999261_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x999261_Tips(sceneId,selfId,tip)
    BeginEvent(sceneId)
		AddText(sceneId,tip)
 	EndEvent(sceneId)
 	DispatchMissionTips(sceneId,selfId)
end