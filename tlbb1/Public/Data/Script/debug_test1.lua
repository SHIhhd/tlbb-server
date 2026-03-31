--测试脚本 程序
x777778_g_scriptId=777778

--白狐
x777778_g_WFox = {
	49745
}

function get8PointsAround(centerX, centerZ, a)
    local inv_s2 = 1 / sqrt(2)    -- ≈0.70710678118655
	local d = a * inv_s2

	local dirs = {
		{  a,  0},  -- 东
		{  d,  d},  -- 东北
		{  0,  a},  -- 北
		{-d,  d},   -- 西北
		{-a,  0},   -- 西
		{-d, -d},   -- 西南
		{  0, -a},  -- 南
		{ d, -d},   -- 东南
	}

	local pts = {}
	for i, off in dirs do
		-- 四舍五入到整数
		local x = floor(centerX + off[1] + 0.5)
		local z = floor(centerZ + off[2] + 0.5)
		pts[i] = { x = x, z = z }
	end
	return pts
end
--**********************************
--事件交互入口
--**********************************
function x777778_DebugBegin(sceneId,selfId)
	
	--LuaFnTryRecieveMultiItem(sceneId,selfId,20103001,1,4,0)
	--LuaFnTryRecieveMultiItem(sceneId,selfId,20103085,1,12,0)
--	NewWorld(sceneId,selfId,1285,96, 152)
--	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 2692, 0);
--	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 1330, 0);
	--LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 42825, 0);
	
	local x,z = GetWorldPos( sceneId, selfId )
	
--	for i = 1,24 do
--		local nMonsterDataId = 49745;
--		if mod(i,2) == 0 then
--			nMonsterDataId = 49746
--		end
--		local nBeginPosX,nBeginPosZ = GetBeginPatrolPoint(sceneId,4 + i - 1)
----		print(nBeginPosX,nBeginPosZ)
--		local nMonsterId = LuaFnCreateMonster( sceneId,nMonsterDataId ,nBeginPosX,nBeginPosZ, 3, -1, -1 )
--		SetPatrolId(sceneId, nMonsterId, 4 + i - 1)
--		
--		SetCharacterDieTime(sceneId, nMonsterId,20000)
--	end
--	local x,z = GetWorldPos( sceneId, selfId )
--	local nObjId = LuaFnCreateMonster(sceneId,49609,x + 3,z + 3,3,-1,-1,3.14,28)
--	LuaFnMonsterDoSpecialAction( sceneId, nObjId,-1,165,-1 )
	--3592
	
--	LuaFnUnitUseSkill( sceneId, nObjId, 3592, nObjId, x, z,3.14, 1 )
	
--	LuaFnUnitUseSkill(sceneId,nMonsterId,3585,selfId,-1,-1,-1,1)
--	LuaFnGmKillObj(sceneId,selfId,selfId)
	
--	x777778_NotifyFailTips( sceneId, selfId, "LuaFnClientPlayerMovie" )
	
	--千幻大技能
	-- 使用示例
--	local cx, cz, radius = x, z, 16
--	local eightPts = get8PointsAround(cx, cz, radius)
--	for i,p in eightPts do
--		--CreateSpecialObjByDataIndex(sceneId,selfId,1505,p.x,p.z,0)
--		local nMonsterId = CreateMonster( sceneId,51457 ,x,z, 32, -1, -1)
--		if nMonsterId ~= -1 then
--			SetCharacterDieTime(sceneId, nMonsterId,8000)
--			MonsterDoMove(sceneId,nMonsterId,p.x, p.z,1)
--		end
--		
--		print(format("Point %d: (%.2f, %.2f)", i, p.x, p.z))
--	end
--	CreateSpecialObjByDataIndex(sceneId,selfId,1529,x,z,0)
	--CreateSpecialObjByDataIndex(sceneId,selfId,1505,x + 3,z + 3)
	--九尾狐扫尾
--	local nMonsterNum = GetMonsterCount(sceneId)
--	for i=0, nMonsterNum-1 do
--		local MonsterId = GetMonsterObjID(sceneId,i)
--		if GetName(sceneId,MonsterId) == "萧峰心魔" then
--			LuaFnUnitUseSkill( sceneId, MonsterId, 3893, selfId, x, z,-1, 1)
--		end
--		
--	end
	--49592	如是我闻中场空NPC 大招中心效果
	
	--右扫尾
--	local nMonsterNum = GetMonsterCount(sceneId)
--	for i=0, nMonsterNum-1 do
--		local MonsterId = GetMonsterObjID(sceneId,i)
--		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
--		if MosDataID == 49645 then
--			LuaFnUnitUseSkill( sceneId, MonsterId, 3369, selfId, x, z,-1, 1)
--		end
--	end
	--创建随机移动的特殊土包
--	local nMonsterId = CreateMonsterWithDir( sceneId,51560 ,x,z, 6, -1, -1,0.873)
--	if nMonsterId ~= -1 then
--		SetCharacterDieTime(sceneId, nMonsterId,50000)
--	end
	local nMonsterId = CreateMonsterWithDir( sceneId,51947 ,x,z, 3, -1, -1,0.873)
	SetCharacterDieTime(sceneId, nMonsterId,3000)
--	--左扫尾
--	local nMonsterNum = GetMonsterCount(sceneId)
--	for i=0, nMonsterNum-1 do
--		local MonsterId = GetMonsterObjID(sceneId,i)
--		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
--		if MosDataID == 49645 then
----			LuaFnUnitUseSkill( sceneId, MonsterId, 3363, selfId, x, z,-1, 1)
--			LuaFnMonsterDoSpecialAction( sceneId, MonsterId,170,171,-1 )
--			LuaFnMonsterDoSpecialAction( sceneId, MonsterId,172,-1,-1 )
--		end
--	end
	
--	SetPos(sceneId,selfId,54,41)
	--金
	--3372
	--生成本次如是我闻的元素顺序
--	local tTemp = {1,2,3,4,5}
--	local n = getn(tTemp)
--    for i = n, 2, -1 do
--        local j = random(i)
--        tTemp[i], tTemp[j] =tTemp[j], tTemp[i]
--    end
--	for i = 1, getn(tTemp) do
--		print(tTemp[i])
--	end
--	for i = 1,10 do
--		print("test",random(-314,314) / 100.0);
--	end
--	CallScriptFunction(893038, "ReleaseDynamicRegion", sceneId,1);

--	CallScriptFunction(893032, "UseSkill_LingHuJingGu", sceneId,selfId);
--	x893032_UseSkill_LingHuJingGu( sceneId, selfId )

	--辽阻挡
--	CallScriptFunction(998445,"CreateDynamicBlock",sceneId,1)
--	local nMonsterId = CreateMonsterWithDir( sceneId,51660 ,x,z, 4, -1, -1,2.094)
--	SetCharacterDieTime(sceneId, nMonsterId,5000)
----	print("id",LuaFnAddDynamicRegionByObject(sceneId, nMonsterId, 6))
--
--	LuaFnReleaseDynamicRegion(sceneId, 0)
--	LuaFnReleaseDynamicRegion(sceneId, 1)
	
	--创建BOSS
--	local nMonId = CreateMonsterWithDir(sceneId,60000 , 210, 33, 19, -1, 810101,6.283)
--	if nMonId ~= -1 then
--		SetCharacterTitle(sceneId, nMonId, "“中原霸主”")
--		local str = "#P帝释天已经出现在#G束河古镇（210，33）#P！请天下英雄速去剿灭！最后将其斩杀者朝廷将给予获得丰厚奖励！"
--		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:"..str)
--	end

--	LuaFnBanAndKickPlayer(sceneId,selfId,2082729599)
--	AddMoneyJZ(sceneId,selfId, 20000 );
--	SetHumanAbilityLevel(sceneId,selfId,59,1)
--	for i = 1190, 1384 do
--			SetPrescription( sceneId, selfId, i, 1 )
--		end
--	LuaFnSetIBPower(sceneId,selfId,1000)
--	LuaFnSendOResultToPlayer(sceneId,selfId,-379)
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x777778_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end