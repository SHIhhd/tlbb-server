--珍兽舍利子

x300088_g_scriptId = 300088
x300088_g_bagIndex = -1	
x300088_g_hugeExp = 1500000
--**********************************
--事件交互入口
--**********************************
function x300088_OnDefaultEvent( sceneId, selfId, bagIndex )
	--这部分需要先写入舍利子经验才行
	--经过测试，道具生成不会默认写入舍利子的经验数据，需要独立操作一下。
	local slzExp = GetBagItemParam(sceneId, selfId, bagIndex, 4, 2) --EXP
	if slzExp <= 0 then
		SetBagItemParam(sceneId,selfId,bagIndex,4,2,x300088_g_hugeExp)
		LuaFnRefreshItemInfo(sceneId,selfId,bagIndex)
	end
	--写入后必须重新读取一下
	local nNewslzExp = GetBagItemParam(sceneId, selfId, bagIndex, 4, 2)
	local PetGuidH , PetGuidL = LuaFnGetCurrentPetGUID(sceneId, selfId)

	if PetGuidH == nil or PetGuidL == nil then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZSKSSJ_081113_18}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	if IsPilferLockFlag(sceneId, selfId)  == -1 then
		return
	end
	
	local petLevel		 = LuaFnGetPetLevelByGUID(sceneId, selfId , PetGuidH , PetGuidL)	
	local PetToHumanMaxLevel = GetPetMaxLevelToHuman(sceneId, selfId , PetGuidH , PetGuidL)
	local PetExp		 = GetPet_ExpByGUID(sceneId, selfId , PetGuidH , PetGuidL)
	
	if petLevel >= PetToHumanMaxLevel then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZSKSSJ_081126_2}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end


	local levelCanUp = 0;
	local tmpExp = PetExp + nNewslzExp
	
	local expToLevel = LuaFnGetPetNeedExp(sceneId, selfId, petLevel)	
	
	while tmpExp > expToLevel do
		levelCanUp = levelCanUp + 1	
		tmpExp = tmpExp - expToLevel
		expToLevel = LuaFnGetPetNeedExp(sceneId, selfId, petLevel + levelCanUp)
	end

	x300088_g_bagIndex = bagIndex

	BeginUICommand(sceneId);
		UICommand_AddInt(sceneId, nNewslzExp);
		UICommand_AddInt(sceneId, levelCanUp);
		UICommand_AddInt(sceneId, petLevel);
		UICommand_AddInt(sceneId, PetToHumanMaxLevel);
		UICommand_AddInt(sceneId, PetGuidH);
		UICommand_AddInt(sceneId, PetGuidL);
		UICommand_AddInt(sceneId, bagIndex)
	EndUICommand(sceneId);
	DispatchUICommand(sceneId, selfId, 300088);	

end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x300088_IsSkillLikeScript( sceneId, selfId)
	return 0; --这个脚本需要动作支持
end

function x300088_UseShelizi(sceneId, selfId , bagIndex)
	
	if LuaFnGetItemTableIndexByIndex(sceneId, selfId , bagIndex) ~= 30900059 then
		return
	end
	
	local slzExp = GetBagItemParam(sceneId, selfId, bagIndex, 4, 2) --EXP

	if slzExp < 0 then
		return
	end	
	local PetGuidH , PetGuidL = LuaFnGetCurrentPetGUID(sceneId, selfId)
	if PetGuidH == nil or PetGuidL == nil then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZSKSSJ_081113_18}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local itemInfo = GetBagItemTransfer(sceneId, selfId ,bagIndex)
	if EraseItem(sceneId, selfId, bagIndex) > 0 then
		
		PetAddExp(sceneId, selfId,slzExp)
		local str = format("#{ZSKSSJ_081126_3}%d#{ZSKSSJ_081126_4}" ,slzExp )
		BeginEvent(sceneId)
			AddText(sceneId,str)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0);
		if slzExp > x300088_g_hugeExp then
			local PetName = LuaFnGetPetTransferByGUID(sceneId, selfId ,PetGuidH , PetGuidL)
			local PlayerName = GetName(sceneId, selfId)
			local strText = format("#{_INFOUSR%s}#{ZSD_1}#{_INFOMSG%s}#{ZSD_2}#{_INFOMSG%s}#{ZSD_3}%d#{ZSD_4}" ,PlayerName,itemInfo,PetName,slzExp)
			AddGlobalCountNews( sceneId, strText)
		end
	end
end
