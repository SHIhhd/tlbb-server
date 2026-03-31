--青丘掉落包
--掉落箱子
--BOSS云飘飘
x893119_g_SceneData_Type = 7		

--必掉落物品
x893119_DropItemMust = {
	--升魂丹
	{itemid = 38002530,minNum = 1,maxNum = 5},
}
--随机掉落物品集 只掉一个
x893119_DropItemOne = {
	--各类魂玉
	38002515,38002516,38002517,38002518,38002519,38002520,38002521,38002522,38002523,38002524,38002525,38002526,38002527,38002528,38002529
}
--50%概率掉落物品
x893119_DropItemPercent = {
	38002532,38002533,38002534
}
--青丘佩
x893119_ItemQingQiuPei = 20800020
--魂神之卷
x893119_ItemShenHunZhiJuan = 38002496

--**********************************
--产生物品掉落
--nFlag0 普通
--nFlag1 困难
--**********************************
function x893119_GenerateDropBox( sceneId,nPosX,nPosZ,nFlag )
--	local nTeamId = LuaFnGetCopySceneData_Param(sceneId,6)
--	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
--	for i=0, nHumanNum-1  do
--		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
--		if LuaFnIsObjValid(sceneId, PlayerId) == 1 
--			and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1
--			and GetTeamId(sceneId,PlayerId) == nTeamId then
--			
--			--生成掉落箱子
--			local nBoxId = DropBoxEnterScene(nPosX,nPosZ,sceneId )
--			if nBoxId ~= -1 then
--				SetItemBoxOwner(sceneId, nBoxId, LuaFnGetGUID(sceneId,PlayerId))
--				SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
--				--增加掉落物品
--				for i = 1,getn(x893119_DropItemMust) do
--					local tItem = x893119_DropItemMust[i]
--					for j = 1,random(tItem.minNum,tItem.maxNum) do
--						AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,tItem.itemid)
--					end
--				end
--				--云飘飘掉落两个
--				for i = 1,2 do
--					AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893119_DropItemOne[random(1,getn(x893119_DropItemOne))])
--				end
--				--概率掉落物品
--				for i = 1,getn(x893119_DropItemPercent) do
--					if random(1,100) <= 50 then
--						AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893119_DropItemPercent[i])
--					end
--				end
--				--神魂之卷掉落35%
--				if random(1,100) <= 35 then
--					AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893119_ItemShenHunZhiJuan)
--				end
--				--掉落青丘佩
--				local nFubenType = LuaFnGetCopySceneData_Param(sceneId, x893119_g_SceneData_Type) ;--副本类型 0-普通 1-困难
--				if nFubenType == 1 then
--					AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893119_ItemQingQiuPei)
--				else
--					if random(1,100) <= 50 then
--						AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893119_ItemQingQiuPei)
--					end
--				end
--			end
--		end
--	end
	--在地面放置一个空宝箱
	local nMonsterId = CreateMonsterWithDir( sceneId,49842 ,nPosX,nPosZ, 3, -1, -1,0.873)
	if nMonsterId ~= -1 then
		SetCharacterDieTime(sceneId, nMonsterId,5 * 60 * 1000)
	end
end

