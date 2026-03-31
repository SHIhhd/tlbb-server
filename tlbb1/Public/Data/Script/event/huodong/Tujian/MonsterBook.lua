-- ============================================================================
-- 图鉴系统 (怪物图鉴) 服务端脚本
-- 作者: 雪舞
-- 日期: 2026-1-22
-- 说明: 使用C++配表接口实现图鉴激活、升级、属性计算
-- ============================================================================

-- 脚本ID和事件列表
x912217_g_ScriptId = 912217
x912217_g_eventList = {}

-- 常量定义
x912217_GOLD_COST = 100000           -- 激活/升级消耗金币
x912217_MAX_LEVEL = 9                -- 最大等级
x912217_SLOTS_PER_PAGE = 8           -- 每页槽位数
x912217_ITEM_ID_START = 20109102     -- 图鉴道具ID起始
x912217_ITEM_ID_END = 20109536       -- 图鉴道具ID结束
x912217_UI_OPEN_CMD = 99222222       -- 打开界面UI命令
x912217_UI_REFRESH_CMD = 99222223    -- 刷新界面UI命令
x912217_EFFECT_ID = 49               -- 激活/升级特效ID

-- 操作类型枚举
x912217_OP_OPEN_UI = 0               -- 打开界面
x912217_OP_ACTIVATE = 1              -- 激活
x912217_OP_UPGRADE = 2               -- 升级
x912217_OP_CALC_ATTR = 3             -- 计算属性

-- ============================================================================
-- 默认事件处理
-- ============================================================================
function x912217_OnDefaultEvent(sceneId, selfId, targetId)
end

-- ============================================================================
-- 主入口函数: 处理图鉴激活/升级请求
-- @param sceneId     场景ID
-- @param selfId      玩家ID
-- @param pageType    分页类型(1-4)
-- @param groupIdx    分组索引
-- @param slotIdx     怪物槽位索引
-- @param subPageIdx  子页面索引(0或1)
-- @param opType      操作类型(0=打开界面, 1=激活, 2=升级, 3=计算属性)
-- ============================================================================
function x912217_MonsterBookMain(sceneId, selfId, pageType, groupIdx, slotIdx, subPageIdx, opType)
	if opType == x912217_OP_OPEN_UI then
		x912217_OpenUI(sceneId, selfId)
	elseif opType == x912217_OP_ACTIVATE then
		x912217_DoActivate(sceneId, selfId, pageType, groupIdx, slotIdx, subPageIdx)
	elseif opType == x912217_OP_UPGRADE then
		x912217_DoUpgrade(sceneId, selfId, pageType, groupIdx, slotIdx, subPageIdx)
	elseif opType == x912217_OP_CALC_ATTR then
		return x912217_CalcTotalAttr(sceneId, selfId)
	end
end

-- ============================================================================
-- 打开图鉴界面
-- ============================================================================
function x912217_OpenUI(sceneId, selfId)
	BeginUICommand(sceneId)
	UICommand_AddInt(sceneId, 1)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId, selfId, x912217_UI_OPEN_CMD)
end

-- ============================================================================
-- 激活图鉴
-- ============================================================================
function x912217_DoActivate(sceneId, selfId, pageType, groupIdx, slotIdx, subPageIdx)
	-- 计算实际怪物索引
	local monsterIdx = slotIdx
	if subPageIdx > 0 then
		monsterIdx = slotIdx + subPageIdx * x912217_SLOTS_PER_PAGE
	end
	
	-- 获取任务数据ID
	local missionId = LuaFnGetDianCangGroupMissionID(sceneId, selfId, pageType, groupIdx, subPageIdx)
	if missionId == nil or missionId <= 0 then
		return
	end

	-- 检查是否已激活
	local levelArray = x912217_ParseMissionData(sceneId, selfId, missionId)
	if levelArray[slotIdx] >= 1 then
		x912217_SendMessage(sceneId, selfId, "当前已激活")
		return
	end
	
	-- 获取怪物信息
	local monsterName = LuaFnGetDianCangMonsterName(sceneId, selfId, pageType, groupIdx, monsterIdx)
	local requiredCount = LuaFnGetDianCangMonsterNum(sceneId, selfId, pageType, groupIdx, monsterIdx)
	if monsterName == nil or monsterName == "" then
		return
	end
	

	-- 获取激活道具ID
	local itemId = x912217_FindItemIdByName(sceneId, selfId, monsterName)
	if itemId <= 0 then
		return
	end

	-- 验证并扣除资源
	if x912217_CheckAndCostResources(sceneId, selfId, itemId, requiredCount) == 0 then
		return
	end
	
	-- 设置激活状态
	x912217_SetSlotLevel(sceneId, selfId, missionId, slotIdx, 1)
	
	-- 播放特效和广播消息
	x912217_PlayEffect(sceneId, selfId)
	x912217_SendMessage(sceneId, selfId, "激活成功")
	x912217_BroadcastActivation(sceneId, selfId, monsterName)
	
	-- 通知客户端刷新
	x912217_RefreshClientUI(sceneId, selfId, pageType, groupIdx, subPageIdx)
	
	-- 重新计算属性
	x912217_RecalculateAttributes(sceneId, selfId)
end

-- ============================================================================
-- 升级图鉴
-- ============================================================================
function x912217_DoUpgrade(sceneId, selfId, pageType, groupIdx, slotIdx, subPageIdx)
	-- 计算实际怪物索引
	local monsterIdx = slotIdx
	if subPageIdx > 0 then
		monsterIdx = slotIdx + subPageIdx * x912217_SLOTS_PER_PAGE
	end

	-- 获取任务数据ID
	local missionId = LuaFnGetDianCangGroupMissionID(sceneId, selfId, pageType, groupIdx, subPageIdx)
	if missionId == nil or missionId <= 0 then
		return
	end

	-- 检查当前等级
	local levelArray = x912217_ParseMissionData(sceneId, selfId, missionId)
	local currentLevel = levelArray[slotIdx]
	
	if currentLevel == 0 then
		x912217_SendMessage(sceneId, selfId, "请先激活")
		return
	end

	if currentLevel >= x912217_MAX_LEVEL then
		x912217_SendMessage(sceneId, selfId, "已满级")
		return
	end

	-- 获取怪物信息
	local monsterName = LuaFnGetDianCangMonsterName(sceneId, selfId, pageType, groupIdx, monsterIdx)
	local requiredCount = LuaFnGetDianCangMonsterNum(sceneId, selfId, pageType, groupIdx, monsterIdx)
	
	if monsterName == nil or monsterName == "" then
		return
	end
	
	-- 获取激活道具ID
	local itemId = x912217_FindItemIdByName(sceneId, selfId, monsterName)
	if itemId <= 0 then
		return
	end

	-- 验证并扣除资源
	if x912217_CheckAndCostResources(sceneId, selfId, itemId, requiredCount) == 0 then
		return
	end
	
	-- 升级
	local newLevel = currentLevel + 1
	x912217_SetSlotLevel(sceneId, selfId, missionId, slotIdx, newLevel)
	
	-- 播放特效和广播消息
	x912217_PlayEffect(sceneId, selfId)
	x912217_SendMessage(sceneId, selfId, "升级成功")
	x912217_BroadcastUpgrade(sceneId, selfId, monsterName, newLevel)
	
	-- 通知客户端刷新
	x912217_RefreshClientUI(sceneId, selfId, pageType, groupIdx, subPageIdx)
	
	-- 重新计算属性
	x912217_RecalculateAttributes(sceneId, selfId)
end

-- ============================================================================
-- 计算图鉴总属性加成
-- @return 32个属性值
-- ============================================================================
function x912217_CalcTotalAttr(sceneId, selfId)
	-- 初始化32个属性值
	local attrValues = {}
	for i = 1, 32 do
		attrValues[i] = 0
	end
	
	-- 遍历所有分页
	for pageType = 1, 4 do
		local groupCount = LuaFnGetDianCangFenYeGroupCount(sceneId, selfId, pageType)
		
		for groupIdx = 1, groupCount do
			-- 遍历子页面(0和1)
			for subPageIdx = 0, 1 do
				local missionId = LuaFnGetDianCangGroupMissionID(sceneId, selfId, pageType, groupIdx, subPageIdx)
				if missionId and missionId > 0 then
					-- 获取激活等级数组
					local levelArray = x912217_ParseMissionData(sceneId, selfId, missionId)
					
					-- 计算属性组ID
					local attrGroupId = x912217_CalcAttrGroupId(pageType, groupIdx)
					
					-- 遍历每个槽位
					for slotIdx = 1, x912217_SLOTS_PER_PAGE do
						local level = levelArray[slotIdx]
						if level and level > 0 then
							local attrSlot = slotIdx + (subPageIdx * x912217_SLOTS_PER_PAGE)
							local attrIndex = LuaFnGetDianCangAttrIndex(sceneId, selfId, attrGroupId, attrSlot)
							local attrValue = LuaFnGetDianCangAttrValue(sceneId, selfId, attrGroupId, attrSlot)
							
							if attrIndex and attrIndex > 0 and attrIndex <= 32 then
								attrValues[attrIndex] = attrValues[attrIndex] + attrValue * level
							end
						end
					end
				end
			end
		end
	end
	
	return attrValues[1], attrValues[2], attrValues[3], attrValues[4], attrValues[5], attrValues[6], attrValues[7], attrValues[8],
	       attrValues[9], attrValues[10], attrValues[11], attrValues[12], attrValues[13], attrValues[14], attrValues[15], attrValues[16],
	       attrValues[17], attrValues[18], attrValues[19], attrValues[20], attrValues[21], attrValues[22], attrValues[23], attrValues[24],
	       attrValues[25], attrValues[26], attrValues[27], attrValues[28], attrValues[29], attrValues[30], attrValues[31], attrValues[32]
end

-- ============================================================================
-- 辅助函数
-- ============================================================================

-- 根据分页和分组索引计算属性组ID
function x912217_CalcAttrGroupId(pageType, groupIdx)
	local offset = 0
	if pageType == 2 then 
		offset = 24
	elseif pageType == 3 then 
		offset = 47
	elseif pageType == 4 then 
		offset = 60
	end
	return groupIdx + offset
end

-- 根据怪物名称查找激活道具ID
function x912217_FindItemIdByName(sceneId, selfId, monsterName)
	for itemId = x912217_ITEM_ID_START, x912217_ITEM_ID_END do
		if GetItemName(sceneId, itemId) == monsterName then
			return itemId
		end
	end
	return 0
end

-- 检查并扣除资源(道具和金币)
function x912217_CheckAndCostResources(sceneId, selfId, itemId, requiredCount)
	local itemName = GetItemName(sceneId, itemId)
	
	-- 检查道具数量
	if LuaFnGetAvailableItemCount(sceneId, selfId, itemId) < requiredCount then
		x912217_SendMessage(sceneId, selfId, "抱歉,[" .. itemName .. "]不足[" .. requiredCount .. "]个")
		return 0
	end
	
	-- 检查金币
	local totalGold = GetMoney(sceneId, selfId) + GetMoneyJZ(sceneId, selfId)
	if totalGold < x912217_GOLD_COST then
		x912217_SendMessage(sceneId, selfId, "抱歉,您的金币不足")
		return 0
	end

	-- 扣除道具
	if LuaFnDelAvailableItem(sceneId, selfId, itemId, requiredCount) ~= 1 then
		x912217_SendMessage(sceneId, selfId, "抱歉,[" .. itemName .. "]不足[" .. requiredCount .. "]个")
		return 0
	end
	
	-- 扣除金币
	LuaFnCostMoneyWithPriority(sceneId, selfId, x912217_GOLD_COST)
	
	return 1
end

-- 设置单个槽位等级
function x912217_SetSlotLevel(sceneId, selfId, missionId, slotIdx, level)
	if missionId == nil or slotIdx < 1 or slotIdx > x912217_SLOTS_PER_PAGE then
		return -1
	end
	
	local levelArray = x912217_ParseMissionData(sceneId, selfId, missionId)
	levelArray[slotIdx] = level
	
	-- 将8位数组编码为整数
	local encodedValue = 0
	for i = 1, x912217_SLOTS_PER_PAGE do
		encodedValue = encodedValue + (levelArray[i] or 0) * (10 ^ (i - 1))
	end
	
	SetMissionData(sceneId, selfId, missionId, floor(encodedValue))
	return 1
end

-- 解析任务数据为8位激活等级数组
-- 每位数字(0-9)代表一个槽位的等级
function x912217_ParseMissionData(sceneId, selfId, missionId)
	local levelArray = {}
	for i = 1, x912217_SLOTS_PER_PAGE do
		levelArray[i] = 0
	end
	
	if missionId ~= nil then
		local rawValue = GetMissionData(sceneId, selfId, missionId)
		levelArray[1] = mod(floor(rawValue / 1), 10)
		levelArray[2] = mod(floor(rawValue / 10), 10)
		levelArray[3] = mod(floor(rawValue / 100), 10)
		levelArray[4] = mod(floor(rawValue / 1000), 10)
		levelArray[5] = mod(floor(rawValue / 10000), 10)
		levelArray[6] = mod(floor(rawValue / 100000), 10)
		levelArray[7] = mod(floor(rawValue / 1000000), 10)
		levelArray[8] = mod(floor(rawValue / 10000000), 10)
	end
	
	return levelArray
end

-- 发送系统消息给玩家
function x912217_SendMessage(sceneId, selfId, message)
	BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:" .. message, 0)
end

-- 播放特效
function x912217_PlayEffect(sceneId, selfId)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x912217_EFFECT_ID, 0)
end

-- 广播激活消息
function x912217_BroadcastActivation(sceneId, selfId, monsterName)
	local playerName = GetName(sceneId, selfId)
	local broadcastMsg = format("#P恭喜玩家#{_INFOUSR%s}#Y怪物图鉴#P激活了#Y[%s]", playerName, monsterName)
	BroadMsgByChatPipe(sceneId, selfId, broadcastMsg, 4)
end

-- 广播升级消息
function x912217_BroadcastUpgrade(sceneId, selfId, monsterName, newLevel)
	local playerName = GetName(sceneId, selfId)
	local broadcastMsg = format("#P恭喜玩家#{_INFOUSR%s}#Y怪物图鉴#P升级了#Y[%s],#P当前等级为#Y[%s级]", playerName, monsterName, newLevel)
	BroadMsgByChatPipe(sceneId, selfId, broadcastMsg, 4)
end

-- 通知客户端刷新UI
function x912217_RefreshClientUI(sceneId, selfId, pageType, groupIdx, subPageIdx)
	BeginUICommand(sceneId)
	UICommand_AddInt(sceneId, pageType)
	UICommand_AddInt(sceneId, groupIdx - 1)
	UICommand_AddInt(sceneId, subPageIdx)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId, selfId, x912217_UI_REFRESH_CMD)
end

-- 重新计算玩家属性
function x912217_RecalculateAttributes(sceneId, selfId)
	CallScriptFunction(866010, "StartComputeHumanData", sceneId, selfId, 1)
end

-- 显示提示信息
function x912217_NotifyTips(sceneId, selfId, message)
	BeginEvent(sceneId)
	AddText(sceneId, message)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)
end

-- 技能脚本检查
function x912217_IsSkillLikeScript(sceneId, selfId)
	return 0
end
