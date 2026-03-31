-- 爆率回调控制 @WAYLEE

-- 脚本ID
x768990_g_ScriptId = 768990

--**********************************
--事件交互入口
--**********************************
function x768990_OnDefaultEvent( sceneId, selfId,targetId )

end


--**********************************
-- 怪物掉落回调 (Monster Drop Callback)
-- 在怪物死亡计算掉落前调用，可以控制爆率和是否允许掉落
--**********************************
-- 参数说明:
--   sceneId:      场景ID
--   selfId:       玩家ObjID (获得掉落的玩家)
--   monsterObjId: 怪物ObjID
--   monsterDataId:怪物模板ID (DataID)
--   playerLevel:  玩家等级
--   dropData:     掉落数据对象 (用于getData/setData)
--   getData:      获取掉落数据函数
--   setData:      设置掉落数据函数
--
-- getData/setData 索引说明:
--   0  = sceneId        (只读) 场景ID
--   1  = playerObjId    (只读) 玩家ObjID
--   2  = monsterObjId   (只读) 怪物ObjID
--   3  = monsterDataId  (只读) 怪物模板ID
--   4  = playerLevel    (只读) 玩家等级
--   5  = monsterLevel   (只读) 怪物等级
--   6  = dropBoxId      (只读) 掉落箱ID
--   7  = itemId         (读写) 物品ID
--   8  = itemQuality    (读写) 物品品质
--   9  = dropNotifyId   (读写) 掉落公告ID
--   10 = dropRate       (读写) 爆率倍率 (万分比, 10000=100%=不加成, 15000=+50%爆率)
--   11 = randomValue    (只读) 随机值 (万分比)
--   12 = allowDrop      (读写) 是否允许掉落 (1=允许, 0=禁止)
--   13 = isBoss         (只读) 是否BOSS怪物
--   14 = isTeamDrop     (只读) 是否队伍掉落
--   15 = extraField     (读写) 额外字段
--
-- 返回值:
--   返回值1: 是否允许掉落 (0=禁止掉落, 其他值=允许掉落)
--   返回值2: 爆率倍率修正 (万分比, 10000=不变, 15000=1.5倍, 5000=0.5倍, 0=使用dropData中的值, 负数=爆率设为0)
--**********************************
function x768990_callback_MonsterDrop(sceneId, selfId, monsterObjId, monsterDataId, playerLevel, dropData, getData, setData)
	-- 获取基础信息
	local monsterLevel = getData(sceneId, selfId, dropData, 5)
	local isBoss = getData(sceneId, selfId, dropData, 13)
	local isTeamDrop = getData(sceneId, selfId, dropData, 14)
	local currentDropRate = getData(sceneId, selfId, dropData, 10)  -- 万分比
	
	-- 调试输出
	-- 注意: currentDropRate 是爆率倍率(万分比), 10000=100%=不加成, 15000=150%=+50%爆率
	-- x768990_NotifyTip(sceneId, selfId, 
	    -- "怪物掉落回调: 怪物ID=" .. tostring(monsterDataId) ..
	    -- " 怪物等级=" .. tostring(monsterLevel) ..
	    -- " 是否BOSS=" .. tostring(isBoss) ..
	    -- " 爆率倍率=" .. tostring(currentDropRate/100) .. "%")
	
	-- ============ 根据条件修改爆率 ============
	local allowDrop = 1      -- 默认允许掉落
	local dropRateMultiplier = 10000  -- 默认不修改爆率 (10000 = 100%)
	
	-- 方法1: BOSS怪物爆率提升50%
	-- if isBoss == 1 then
	--     dropRateMultiplier = 15000  -- 150%
	-- end
	
	-- 方法2: 玩家等级比怪物高10级以上，爆率降低50%
	-- if playerLevel > monsterLevel + 10 then
	--     dropRateMultiplier = 5000  -- 50%
	-- end
	
	-- 方法3: 特定怪物禁止掉落
	-- if monsterDataId == 12345 then
	--     allowDrop = 0  -- 禁止掉落
	-- end
	
	-- 方法4: 根据玩家MissionData动态调整爆率
	-- local vipLevel = GetMissionData(sceneId, selfId, 100)  -- 假设MD100存储VIP等级
	-- if vipLevel >= 5 then
	--     dropRateMultiplier = 12000  -- VIP5以上爆率+20%
	-- end
	
	-- 方法5: 修改dropData中的爆率 (另一种方式)
	-- setData(sceneId, selfId, dropData, 10, currentDropRate * 2)  -- 爆率翻倍
	
	-- 返回: 是否允许掉落, 爆率倍率
	return allowDrop, dropRateMultiplier
end


--**********************************
-- 物品掉落回调 (Item Drop Callback)
-- 在具体物品掉落时调用，可以修改物品ID、品质等
-- 此回调在 my_ItemBoxRuler_CreateItemFromMonsterDrop 中调用
-- 通过线程局部上下文传递玩家和场景对象
--**********************************
-- 参数说明:
--   sceneId:      场景ID
--   selfId:       玩家ObjID
--   dropBoxId:    掉落箱ID
--   itemId:       原始物品ID
--   itemQuality:  原始物品品质
--   dropData:     掉落数据对象 (用于getData/setData)
--   getData:      获取掉落数据函数
--   setData:      设置掉落数据函数
--
-- getData/setData 索引说明:
--   0  = sceneId        (只读) 场景ID
--   1  = playerObjId    (只读) 玩家ObjID
--   2  = monsterObjId   (只读) 怪物ObjID
--   3  = monsterDataId  (只读) 怪物模板ID
--   4  = playerLevel    (只读) 玩家等级
--   5  = monsterLevel   (只读) 怪物等级
--   6  = dropBoxId      (只读) 掉落箱ID
--   7  = itemId         (读写) 物品ID
--   8  = itemQuality    (读写) 物品品质
--   9  = dropNotifyId   (读写) 掉落公告ID
--   10 = allowDrop      (读写) 是否允许掉落 (1=允许, 0=禁止)
--   11 = newItemId      (读写) 新物品ID (0=不修改)
--   12 = newQuality     (读写) 新品质 (0=不修改)
--   13 = isBoss         (只读) 是否BOSS怪物
--   14 = isTeamDrop     (只读) 是否队伍掉落
--   15 = extraField     (读写) 额外字段
--
-- 返回值:
--   返回值1: 是否允许此物品掉落 (0=禁止, 其他=允许)
--   返回值2: 新物品ID (0=不修改)
--   返回值3: 新物品品质 (0=不修改)
--**********************************
function x768990_callback_ItemDrop(sceneId, selfId, dropBoxId, itemId, itemQuality, dropData, getData, setData)
	-- 获取基础信息
	local monsterObjId = getData(sceneId, selfId, dropData, 2)
	local monsterDataId = getData(sceneId, selfId, dropData, 3)
	local playerLevel = getData(sceneId, selfId, dropData, 4)
	local monsterLevel = getData(sceneId, selfId, dropData, 5)
	local dropNotifyId = getData(sceneId, selfId, dropData, 9)
	local isBoss = getData(sceneId, selfId, dropData, 13)
	local isTeamDrop = getData(sceneId, selfId, dropData, 14)
	
	-- 调试输出
	-- x768990_NotifyTip(sceneId, selfId, 
	    -- "物品掉落回调: 掉落箱ID=" .. tostring(dropBoxId) ..
	    -- " 物品ID=" .. tostring(itemId) ..
	    -- " 品质=" .. tostring(itemQuality) ..
	    -- " 怪物ID=" .. tostring(monsterDataId) ..
	    -- " 是否BOSS=" .. tostring(isBoss))
	
	local allowDrop = 1  -- 允许掉落
	local newItemId = 0  -- 不修改物品ID
	local newQuality = 0 -- 不修改品质
	
	-- ============ 案例 ============
	
	-- 方法1: 替换特定物品
	-- if itemId == 30505013 then
	    -- newItemId = 10413104  -- 替换为另一个物品
	-- end
	
	-- 方法2: 提升品质
	-- if itemQuality < 5 then
	--     newQuality = itemQuality + 1
	-- end
	
	-- 方法3: 禁止特定物品掉落
	-- if itemId == 30000000 then
	--     allowDrop = 0  -- 禁止掉落
	-- end
	
	-- 方法4: BOSS掉落特殊处理
	-- if isBoss == 1 then
	--     -- BOSS掉落的物品品质+1
	--     if itemQuality < 9 then
	--         newQuality = itemQuality + 1
	--     end
	-- end
	
	-- 方法5: 根据玩家等级调整掉落
	-- if playerLevel > 80 then
	--     -- 高等级玩家有几率获得更好的物品
	--     local rand = random(1, 100)
	--     if rand <= 10 then
	--         newQuality = itemQuality + 1
	--     end
	-- end
	
	-- 方法6: 通过setData修改数据
	-- setData(sceneId, selfId, dropData, 11, 10001002)  -- 设置新物品ID
	-- setData(sceneId, selfId, dropData, 12, 5)         -- 设置新品质
	
	return allowDrop, newItemId, newQuality
end



--**********************************
--醒目提醒
--**********************************
function x768990_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end