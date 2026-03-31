--雁门梦境掉落包

--必掉落物品
x998468_DropItemMust = {
	--破级石
	{itemid = 20900001,minNum = 30,maxNum = 80},
}
--随机掉落物品集 只掉一个
x998468_DropItemOne = {
	10158007,10158008,10158009,10158010,10158011,10158012,10158013,
	10158014,10158015,10158016,10158017,10158018,10158019,10158020,
	10158021,10158022,10158023,10158024,10158025,10158026,10158027
}
--40%概率掉落物品
x998468_DropItemPercent = {
	38002969,38002970,38002971
}
--通过纪念
x998468_FinishPrizeItem = 20900010
--**********************************
--产生物品掉落
--**********************************
function x998468_GenerateDropBox( sceneId,selfId,nSpecialFlag )
	local nFlag = LuaFnGetCopySceneData_Param(sceneId, 0)
	
	local nPosX,nPosZ = GetWorldPos( sceneId, selfId )
	
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 
			and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			
--			生成掉落箱子
			local nBoxId = DropBoxEnterSceneEx(nPosX,nPosZ,sceneId,LuaFnGetGUID(sceneId,PlayerId))
			if nBoxId ~= -1 then
				SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
--				增加掉落物品
				for i = 1,getn(x998468_DropItemMust) do
					local tItem = x998468_DropItemMust[i]
					for j = 1,random(tItem.minNum,tItem.maxNum) do
						AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,tItem.itemid)
					end
				end
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x998468_DropItemOne[random(1,getn(x998468_DropItemOne))])
--				概率掉落物品
				for i = 1,getn(x998468_DropItemPercent) do
					if random(1,100) <= 20 then
						AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x998468_DropItemPercent[i])
					end
				end
				if nSpecialFlag == 1 then
					if nFlag == FUBEN_YANMEN_D then
						AddMutilItemToBox(sceneId,nBoxId,x998468_FinishPrizeItem,4,QUALITY_CREATE_BY_BOSS)
					elseif nFlag == FUBEN_YANMEN then
						AddMutilItemToBox(sceneId,nBoxId,x998468_FinishPrizeItem,2,QUALITY_CREATE_BY_BOSS)
					end
					
				end
			end
		end
	end
end

