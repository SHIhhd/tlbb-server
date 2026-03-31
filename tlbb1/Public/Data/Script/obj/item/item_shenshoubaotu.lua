--魂神之卷

--脚本号
x893081_g_scriptId = 893081

x893081_g_PetIsLandMissionId = 2062
--随机出现的点位种子
x893081_g_RandomPosTable = {
	{startX = 123,endX = 176,startY = 91,endY = 160},
	{startX = 243,endX = 275,startY = 90,endY = 101},
	{startX = 258,endX = 276,startY = 137,endY = 191},
	{startX = 173,endX = 194,startY = 219,endY = 233},
	{startX = 72,endX = 86,startY = 231,endY = 246},
	{startX = 65,endX = 75,startY = 106,endY = 121},
}

--随机出现的怪物
x893081_g_RandomMonsterID = {
	{mosterid = 49556,bossid = 148},
	{mosterid = 49557,bossid = 149},
	{mosterid = 49558,bossid = 150},
	{mosterid = 49559,bossid = 151},
	{mosterid = 49564,bossid = 152},
}
--神兽特效NPC
x893081_g_ShenShouEffectNpc = 49585
--神兽的怪物脚本
x893081_g_ShenShouScriptID = 893084
--召唤的延迟
x893081_g_Delay = 15 * 1000 --15s
--目前允许单场景上限128
x893081_g_MaxMonsterInScene = 128

--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x893081_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x893081_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
--得到item的参数信息
--**********************************
function x893081_GetItemParam(sceneId, selfId, BagPos)							
	local targetsceneId = GetBagItemParam(sceneId, selfId, BagPos, 1, 1)
	local targetX = GetBagItemParam(sceneId, selfId, BagPos, 3, 1)
	local targetZ = GetBagItemParam(sceneId, selfId, BagPos, 5, 1)
	local r = GetBagItemParam(sceneId, selfId, BagPos, 7, 1)
	return targetsceneId, targetX, targetZ, r
end

--**********************************
--生成随机场景信息
--**********************************
function x893081_GenerateItemParam(sceneId, selfId, BagPos)							
	SetBagItemParam(sceneId, selfId, BagPos, 0, 0, 1)
	SetBagItemParam(sceneId, selfId, BagPos, 1, 1, SCENE_PETISLANDPVP)
	local nRandIdx = random(1,getn(x893081_g_RandomPosTable))
	local nRandPosX = random(x893081_g_RandomPosTable[nRandIdx].startX,x893081_g_RandomPosTable[nRandIdx].endX)
	local nRandPosZ = random(x893081_g_RandomPosTable[nRandIdx].startY,x893081_g_RandomPosTable[nRandIdx].endY)
	SetBagItemParam(sceneId, selfId, BagPos, 3, 1, nRandPosX)
	SetBagItemParam(sceneId, selfId, BagPos, 5, 1, nRandPosZ)
	
	SetBagItemParam(sceneId, selfId, BagPos, 7, 1, 5)
end


--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x893081_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end
	if GetLevel(sceneId,selfId) < 85 then
		x893081_NotifyTips( sceneId, selfId, "#{ZSPVP_211231_08}" )
		return 0
	end
	if IsMissionHaveDone(sceneId,selfId,x893081_g_PetIsLandMissionId) <= 0 then
		x893081_NotifyTips( sceneId, selfId, "#{ZSPVP_211231_56}" )
		return 0
	end
	if GetMonsterCount(sceneId) >= x893081_g_MaxMonsterInScene then
		x893081_NotifyTips( sceneId, selfId, "#{ZSPVP_211231_69}" )
		return 0
	end
	--当前玄武岛·镜还未开放，请在8:00~24:00期间使用。	
--	if sceneId ~= SCENE_PETISLANDPVP then
--		x893081_NotifyTips( sceneId, selfId, "#{ZSPVP_211231_09}" )
--		return 0
--	end
	-- 先取出物品中数据，如果是默认值0则说明是第一次使用，立即生成数据
	-- 如果已经有数据则什么都不做
	local BagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local targetSceneId, targetX, targetZ, r = x893081_GetItemParam(sceneId, selfId, BagPos)
	if targetSceneId==nil or targetSceneId<=0
		or targetX==nil or targetX<=0
		or targetZ==nil or targetZ<=0
		or r==nil or r<=0 then
		--立即生成数据
		x893081_GenerateItemParam(sceneId, selfId, BagPos)		
		--重新获取物品数据
		targetSceneId, targetX, targetZ, r = x893081_GetItemParam(sceneId, selfId, BagPos)
	end
	--取得玩家当前坐标
	local PlayerX = GetHumanWorldX(sceneId, selfId)
	local PlayerZ = GetHumanWorldZ(sceneId, selfId)
	--计算玩家与目标点的距离
	local Distance = floor(sqrt((targetX-PlayerX)*(targetX-PlayerX)+(targetZ-PlayerZ)*(targetZ-PlayerZ)))
	
	if targetSceneId ~= sceneId or Distance > r then
		if targetSceneId ~= sceneId then
			x893081_NotifyTips( sceneId, selfId, "#{ZSPVP_211231_11}" )
		end
		if Distance > r then
			x893081_NotifyTips( sceneId, selfId, "#{ZSPVP_211231_12}" )
		end
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{ZSPVP_211231_10}",targetX,targetZ,579));
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,-1)
		return 0
	end

	return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x893081_OnDeplete( sceneId, selfId )
	if LuaFnDepletingUsedItem( sceneId, selfId ) > 0 then
		return 1
	end

	return 0
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x893081_OnActivateOnce( sceneId, selfId )
	-- 找到相应条目
	local PlayerX = GetHumanWorldX(sceneId, selfId)
	local PlayerZ = GetHumanWorldZ(sceneId, selfId)
	local nRandMosterIdx = random(1,getn(x893081_g_RandomMonsterID))
	local nMonsterID = x893081_g_RandomMonsterID[nRandMosterIdx].mosterid
	local nMonsterBossId = x893081_g_RandomMonsterID[nRandMosterIdx].bossid
	local szMonsterName = GetMonsterNamebyDataId(nMonsterID);
	--ZSPVP_211231_57	#H您已成功召唤%s0，%s0将在15秒后降临。	
	x893081_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{ZSPVP_211231_57}",szMonsterName) )
	--创建一个展示NPC
	local nEffectNpc = LuaFnCreateMonster(sceneId,x893081_g_ShenShouEffectNpc,PlayerX, PlayerZ,3,-1,-1)
	if nEffectNpc ~= -1 then
		SetCharacterDieTime(sceneId, nEffectNpc,x893081_g_Delay)
	end
	--延迟创建神兽
	CreateDelayMonsterWithDir(sceneId, nMonsterID, PlayerX, PlayerZ, 21, -1, x893081_g_ShenShouScriptID,3.14,x893081_g_Delay)
	-- 给个事件通报
	local strText = ScriptGlobal_Format("#{ZSPVP_211231_54}", nMonsterBossId)
	BroadMsgByChatPipe(sceneId, selfId, strText, 4)
	return 1
end
--**********************************
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x893081_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x893081_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
