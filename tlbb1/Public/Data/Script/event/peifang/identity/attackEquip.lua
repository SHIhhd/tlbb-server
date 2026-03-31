--江湖盟会 铸器产物

--本脚本的脚本号
x505020_g_ScriptID = 505020;

function x505020_AbilityCheck( sceneId, selfId, recipeId ,itemPos )
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId ~= IDENTITY_ATTACKEQUIP_IDX then
		return OR_NOT_IBIDENTITY;
	end
	--获取配方信息
	local tRecipe = LuaFnGetPrescriptionInfo(recipeId)
	if tRecipe == nil then
		return OR_ERROR;
	end
	--技能等级限制
	local abilityLevel = QueryHumanAbilityLevel(sceneId, selfId, tRecipe.AbilityID);
	if(abilityLevel < tRecipe.AbilityLevel) then
		return OR_NO_LEVEL
	end
	--神工值限制
	local ibPower = LuaFnGetIBPower(sceneId, selfId);
	if(ibPower - tRecipe.IBPower < 0) then
		return OR_NO_IBPOWER;
	end
	--参与合成的特殊物品
	local nSpecialStaff = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	if nSpecialStaff == -1 then
		return OR_ERROR;
	end
	if LuaFnGetAvailableItemCount( sceneId, selfId, nSpecialStaff ) < 3 then
		return OR_STUFF_LACK;
	end
	--计算合成所得的物品
	local nCurMenPai = GetMenPai(sceneId,selfId)
	local nResultId = LuaFnGetItemCompoundHelperResultId(recipeId,nSpecialStaff,nCurMenPai)
	if nResultId == -1 then
		return OR_ERROR;
	end
	--背包空间检查
	if(LuaFnGetPropertyBagSpace(sceneId, selfId) < 1) then
		return OR_BAG_OUT_OF_SPACE;
	end
	
	--检查材料数量是否足够
	local matList = tRecipe.Stuff_ID
	local countList = tRecipe.Stuff_Num
	for i =1,getn(matList) do
		if matList[i] ~= -1 then
			local Count = LuaFnGetAvailableItemCount( sceneId, selfId, matList[i] );
			if(Count < countList[i]) then
				return OR_STUFF_LACK;
			end
		end
	end
	
	return OR_OK
end

function x505020_AbilityProduce( sceneId, selfId, recipeId,itemPos )
	
	--获取配方信息
	local tRecipe = LuaFnGetPrescriptionInfo(recipeId)
	if tRecipe == nil then
		return OR_ERROR;
	end
	--技能等级限制
	local abilityLevel = QueryHumanAbilityLevel(sceneId, selfId, tRecipe.AbilityID);
	if(abilityLevel < tRecipe.AbilityLevel) then
		return OR_NO_LEVEL
	end
	--参与合成的特殊物品
	local nSpecialStaff = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	if nSpecialStaff == -1 then
		return OR_ERROR;
	end
	--计算合成所得的物品
	local nCurMenPai = GetMenPai(sceneId,selfId)
	local nResultId = LuaFnGetItemCompoundHelperResultId(recipeId,nSpecialStaff,nCurMenPai)
	if nResultId == -1 then
		return OR_ERROR;
	end
	--扣除神工值
	local ibPower = LuaFnGetIBPower(sceneId, selfId);
	ibPower = ibPower - tRecipe.IBPower;
	LuaFnSetIBPower(sceneId, selfId, ibPower);
	--扣除对应材料
	local matList = tRecipe.Stuff_ID
	local countList = tRecipe.Stuff_Num
	for i =1,getn(matList) do
		if matList[i] ~= -1 then
			LuaFnDelAvailableItem( sceneId, selfId, matList[i], countList[i] );
		end
	end
	--扣除特殊物品
	LuaFnDelAvailableItem( sceneId, selfId, nSpecialStaff, 3 );
	--技能熟练度处理
	local abilityLevel = QueryHumanAbilityLevel( sceneId, selfId, tRecipe.AbilityID )
	local bCanGainExp = 1
	if abilityLevel > tRecipe.AbilityID then
		abilityLevel = tRecipe.AbilityLevel
		bCanGainExp = 0
	end
	if bCanGainExp == 1 then						-- 获得熟练度
		CallScriptFunction( ABILITYLOGIC_ID, "GainExperience", sceneId, selfId, tRecipe.AbilityID, tRecipe.ExpIncrement )
	end
	
	local bagIndex = LuaFnTryRecieveItem( sceneId, selfId, nResultId, QUALITY_MUST_BE_CHANGE );
	if(bagIndex < 0) then
		LuaFnAuditAbility(sceneId, selfId,  tRecipe.AbilityID, recipeId, 0)
		return OR_ERROR
	end
	
	LuaFnSendAbilitySuccessMsg( sceneId, selfId,  tRecipe.AbilityID, recipeId, nResultId )
	LuaFnAuditAbility(sceneId, selfId,  tRecipe.AbilityID, recipeId, 1)
	--完成引导任务
	CallScriptFunction( 998658, "OnMissionFinish", sceneId, selfId )
	
	return OR_OK
	
end
