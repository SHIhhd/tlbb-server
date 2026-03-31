--江湖盟会 特殊制作道具

--本脚本的脚本号
x505023_g_ScriptID = 505023;

--原料表
x505023_g_Stuff =
{
	[1] = {21000016, 21000044, 21000049},
}

--原料数量
x505023_g_Count	=
{
	[1]	= {15, 5, 2},
}

x505023_g_CompoundInfo = {}
--定位符·迅
x505023_g_CompoundInfo[1358] =
{
	abilityId	= ABILITY_IDENTITY_JIQIAO,
	recipeLevel = 1,
	deleteIBPower = 5,
	matTbl = 
	{
		[30501029] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 30501043,},
		[30501030] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 30501044,},
		[30501031] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 30501045,},
		[30501032] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 30501046,},
		[30501033] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 30501047,},
		[30501034] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 30501048,},
	},
}
--奇闻小喇叭
x505023_g_CompoundInfo[1367] =
{
	abilityId	= ABILITY_IDENTITY_JIQIAO,
	recipeLevel = 1,
	deleteIBPower = 12,
	matTbl = 
	{
		[30505107] = { matList = x505023_g_Stuff[1], count = x505023_g_Count[1], Product = 38003171,},
	},
}

--背包需要的空间
x505023_g_BagSpace = 1;

function x505023_AbilityCheck( sceneId, selfId, recipeId ,itemPos )
	
	local CompoundInfo	= x505023_g_CompoundInfo[recipeId];
	if(not CompoundInfo) then
		return OR_ERROR;
	end
	
	--背包空间检查
	if(LuaFnGetPropertyBagSpace(sceneId, selfId) < x505023_g_BagSpace) then
		return OR_BAG_OUT_OF_SPACE;
	end
	
	--技能等级限制
	local abilityLevel = QueryHumanAbilityLevel(sceneId, selfId, CompoundInfo.abilityId);
	if(abilityLevel < CompoundInfo.recipeLevel) then
		return OR_NO_LEVEL
	end
	
	--神工值限制
	local ibPower = LuaFnGetIBPower(sceneId, selfId);
	if(ibPower - CompoundInfo.deleteIBPower < 0) then
		return OR_NO_IBPOWER;
	end
	
	--参与合成的特殊物品
	local nSpecialStaff = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	if CompoundInfo.matTbl[nSpecialStaff] == nil then
		return OR_ERROR
	end
	
	--检查材料数量是否足够
	local matList = CompoundInfo.matTbl[nSpecialStaff].matList
	local countList = CompoundInfo.matTbl[nSpecialStaff].count
	for i =1,getn(matList) do
		local Count = LuaFnGetAvailableItemCount( sceneId, selfId, matList[i] );
		if(Count < countList[i]) then
			return OR_STUFF_LACK;
		end
	end
	
	return OR_OK
end

function x505023_AbilityProduce( sceneId, selfId, recipeId,itemPos )

	local	CompoundInfo = x505023_g_CompoundInfo[recipeId];
	if(not CompoundInfo) then
		return OR_ERROR
	end
	
	--扣除神工值
	local ibPower = LuaFnGetIBPower(sceneId, selfId);
	ibPower = ibPower - CompoundInfo.deleteIBPower;
	LuaFnSetIBPower(sceneId, selfId, ibPower);
	
	--参与合成的特殊物品
	local nSpecialStaff = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	if CompoundInfo.matTbl[nSpecialStaff] == nil then
		return OR_ERROR
	end
	
	--扣除对应材料
	local matList = CompoundInfo.matTbl[nSpecialStaff].matList
	local countList = CompoundInfo.matTbl[nSpecialStaff].count
	for i =1,getn(matList) do
		LuaFnDelAvailableItem( sceneId, selfId, matList[i], countList[i] );
	end
	
	--扣除特殊物品
	LuaFnDelAvailableItem( sceneId, selfId, nSpecialStaff, 1 );
	
	local bagIndex = LuaFnTryRecieveItem( sceneId, selfId, CompoundInfo.matTbl[nSpecialStaff].Product, QUALITY_MUST_BE_CHANGE );
	if(bagIndex < 0) then
		LuaFnAuditAbility(sceneId, selfId, CompoundInfo.abilityId, recipeId, 0)
		return OR_ERROR
	end
	
	LuaFnSendAbilitySuccessMsg( sceneId, selfId, CompoundInfo.abilityId, recipeId, CompoundInfo.matTbl[nSpecialStaff].Product )
	LuaFnAuditAbility(sceneId, selfId, CompoundInfo.abilityId, recipeId, 1)
	
	--完成引导任务
	CallScriptFunction( 998658, "OnMissionFinish", sceneId, selfId )
	
	return OR_OK
	
end
