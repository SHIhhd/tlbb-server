-- 取自 鱼&熊掌 的UI
-- 服务端制作 鲸落 1292366050


x330083_g_ScriptId = 330083
x330083_g_MuDingPlayerMissionData = {391, 392, 393, 394} -- 任务ID

x330083_g_rechargeMissionId = 389  -- 充值点数任务ID
x330083_g_dateCheckMissionId = 390  -- 日期检查任务ID

-- 玩家选择数据结构
x330083_g_XuanZe = {
    [1] = { -- 第1档  玄机药尘*5 琉璃幻魂残篇礼包*5 灵玑幻魂残篇礼包*5 绘金尘*10
        itemID = {20310166, 38002229, 38002231, 20800012,},
        itemnum = {5, 5, 5, 10,},
    },
    [2] = { -- 第2档   玄机药尘*10 琉璃幻魂残篇礼包*10 灵玑幻魂残篇礼包*10 绘金尘*15
        itemID = {20310166, 38002229, 38002231, 20800012,},
        itemnum = {10, 10, 10, 15,},
    },
    [3] = { -- 第3档   玄机药尘*15 琉璃幻魂残篇礼包*15 灵玑幻魂残篇礼包*15 绘金尘*20
        itemID = {20310166, 38002229, 38002231, 20800012,3},
        itemnum = {15, 15, 15, 20,},
    },
    [4] = { -- 第4档   玄机药尘*20 琉璃幻魂残篇礼包*20 灵玑幻魂残篇礼包*20 绘金尘*30
        itemID = {20310166, 38002229, 38002231, 20800012,},
        itemnum = {20, 20, 20, 30,},
    },
}

-- 档位需求点数
x330083_g_Point = { 50, 100,150,200} -- 金额

-- 表连接函数
function x330083_tableConcat(t, delimiter)
    local result = ""
    for i = 1, getn(t) do
        if i > 1 then
            result = result .. delimiter
        end
        result = result .. tostring(t[i])
    end
    return result
end

-- 打开选择界面
function x330083_MuDingOpenPagePayReward(sceneId, selfId, index)
    if index < 1 or index > 4 then
        return
    end
    BeginUICommand(sceneId)
        UICommand_AddInt(sceneId, index)  -- 选择的第几重
        UICommand_AddString(sceneId, x330083_tableConcat(x330083_g_XuanZe[index].itemID, ","))
        UICommand_AddString(sceneId, x330083_tableConcat(x330083_g_XuanZe[index].itemnum, ","))
    EndUICommand(sceneId)
    DispatchUICommand(sceneId, selfId, 202501281)
		
end

-- 打开活动主界面
function x330083_OpenPay(sceneId, selfId)
	-- 检测是否需要重置
	x330083_PayReward_Reset(sceneId, selfId)
    local itemIDs = ""
    local itemNum = ""
    
    -- 构建16个物品的ID和数量字符串
    for grade = 1, 4 do
        local missionId = x330083_g_MuDingPlayerMissionData[grade]
        local missionValue = GetMissionData(sceneId, selfId, missionId) or 0
        local choices = x330083_PayReward_PlayerNumToData(missionValue)
        
        for pos = 1, 4 do
            local choice = choices[pos]
            if choice and choice > 0 then
                if x330083_g_XuanZe[grade] and x330083_g_XuanZe[grade].itemID[choice] then
                    -- 添加已选择的物品
                    if itemIDs ~= "" then itemIDs = itemIDs .. "," end
                    if itemNum ~= "" then itemNum = itemNum .. "," end
                    
                    itemIDs = itemIDs .. tostring(x330083_g_XuanZe[grade].itemID[choice])
                    itemNum = itemNum .. tostring(x330083_g_XuanZe[grade].itemnum[choice] or 1)
                else
                    -- 选择无效时填充0
                    if itemIDs ~= "" then itemIDs = itemIDs .. "," end
                    if itemNum ~= "" then itemNum = itemNum .. "," end
                    itemIDs = itemIDs .. "0"
                    itemNum = itemNum .. "0"
                end
            else
                -- 未选择时填充0
                if itemIDs ~= "" then itemIDs = itemIDs .. "," end
                if itemNum ~= "" then itemNum = itemNum .. "," end
                itemIDs = itemIDs .. "0"
                itemNum = itemNum .. "0"
            end
        end
    end
    
    -- 转换点数表为字符串
    local pointStr = x330083_tableConcat(x330083_g_Point, ",")
    -- 发送UI命令打开活动主界面
    BeginUICommand(sceneId)
        UICommand_AddString(sceneId, itemIDs)   -- 物品ID
        UICommand_AddString(sceneId, itemNum)    -- 物品数量
        UICommand_AddString(sceneId, pointStr)   -- 档位点数
    EndUICommand(sceneId)
    DispatchUICommand(sceneId, selfId, 418042021)
end

-- 保存玩家选择的物品
function x330083_MuDingSetPayRewardSelect(sceneId, selfId, index, index1, index2, index3, index4)
    if index < 1 or index > 4 then
        x330083_NotifyTips(sceneId, selfId, "无效档位")
        return
    end
    
    local missionId = x330083_g_MuDingPlayerMissionData[index]
    local currentMissionValue = GetMissionData(sceneId, selfId, missionId) or 0
    
    -- 获取当前状态
    local currentData = x330083_PayReward_PlayerNumToData(currentMissionValue)
    local currentState = currentData[5] or 0  -- 状态: 0未达成,1可领取,2已领取
    
    -- 只有未达成或可领取状态才能更改选择
    if currentState == 2 then
        x330083_NotifyTips(sceneId, selfId, "已领取奖励，无法更改选择")
        return
    end
    
    -- 验证选择是否有效
    local validSelections = 1
    local choices = {index1, index2, index3, index4}
    
    for i, choice in (choices) do
        if type(choice) ~= "number" or choice < 0 or choice > getn(x330083_g_XuanZe[index].itemID) then
            validSelections = 0
            break
        end
    end
    
    if validSelections == 0 then
        x330083_NotifyTips(sceneId, selfId, "选择无效")
        return
    end
    
    -- 将选择编码为数值保存，保持原始状态
    local encodedValue = index1 * 10000000 + index2 * 100000 + index3 * 1000 + index4 * 10 + currentState
    
    SetMissionData(sceneId, selfId, missionId, encodedValue)

    x330083_NotifyTips(sceneId, selfId, "选择已保存")
end

function x330083_MuDingGetPayReward(sceneId, selfId, index, index1, index2, index3, index4)
    if index < 1 or index > 4 then
        x330083_NotifyTips(sceneId, selfId, "无效档位")
        return
    end
    
    local missionId = x330083_g_MuDingPlayerMissionData[index]
    local missionValue = GetMissionData(sceneId, selfId, missionId) or 0
    local choices = x330083_PayReward_PlayerNumToData(missionValue)
	
    -- 检查状态是否可以领取
    if choices[5] ~= 1 then
        x330083_NotifyTips(sceneId, selfId, "状态错误，无法领取")
        return
    end
    
    -- 验证选择是否完整（所有位置都必须选择）
    if index1 == 0 or index2 == 0 or index3 == 0 or index4 == 0 then
        x330083_NotifyTips(sceneId, selfId, "请选择所有位置的奖励")
        return
    end
    for i = 1,4 do
		if choices[i] < 1 then
			x330083_NotifyTips(sceneId, selfId, "请选择所有位置的奖励")
			return
		end
	end


    -- 准备添加物品
    BeginAddItem(sceneId)
    
    -- 发放奖励物品（使用服务端配置的物品ID）
    for i = 1, 4 do
        local choice = choices[i]  -- 使用服务端保存的选择索引
        if choice > 0 and choice <= getn(x330083_g_XuanZe[index].itemID) then
            local itemId = x330083_g_XuanZe[index].itemID[choice]
            local itemNum = x330083_g_XuanZe[index].itemnum[choice] or 1
            
            -- 使用服务端配置的物品ID
            AddBindItem(sceneId, itemId, itemNum)
        else
            -- 选择无效，无法添加物品
            x330083_NotifyTips(sceneId, selfId, "选择无效，无法领取")
            return
        end
    end
    
    if EndAddItem(sceneId, selfId) < 1 then
        return
    end
    
    local newValue = choices[1] * 10000000 + choices[2] * 100000 + 
                    choices[3] * 1000 + choices[4] * 10 + 2
    SetMissionData(sceneId, selfId, missionId, newValue)
    
    -- 添加物品到玩家
    AddItemListToHuman(sceneId, selfId)
    
    -- 通知客户端更新UI
    BeginUICommand(sceneId)
        UICommand_AddInt(sceneId, index)
    EndUICommand(sceneId)
    DispatchUICommand(sceneId, selfId, 202501291)
    
    x330083_NotifyTips(sceneId, selfId, "奖励领取成功")
end
-- 重置入口
function x330083_PayReward_Reset(sceneId, selfId) 
    local currentDay = GetTime2Day()
    -- 获取上次充值日期
    local lastRechargeDay = GetMissionData(sceneId, selfId, x330083_g_dateCheckMissionId) or 0
    -- 检查是否同一天
    if lastRechargeDay ~= currentDay then
        -- 日期变化，重置充值点数
        SetMissionData(sceneId, selfId, x330083_g_rechargeMissionId, 0)
        
        -- 重置所有档位的领取状态（但保留选择）
        for grade = 1, 4 do
            local missionId = x330083_g_MuDingPlayerMissionData[grade]
            local missionValue = GetMissionData(sceneId, selfId, missionId) or 0
            local choices = x330083_PayReward_PlayerNumToData(missionValue)
            -- 这边是每日充值 直接给0 未达成
            choices[5] = 0
            local newValue = choices[1] * 10000000 + choices[2] * 100000 + 
                            choices[3] * 1000 + choices[4] * 10 + choices[5]
            SetMissionData(sceneId, selfId, missionId, newValue)
        end
        
        -- 更新日期记录
        SetMissionData(sceneId, selfId, x330083_g_dateCheckMissionId, currentDay)
    end
end
function x330083_OnDailyRecharge(sceneId, selfId, amount)
    x330083_PayReward_Reset(sceneId, selfId)
    local currentPoints = GetMissionData(sceneId, selfId, x330083_g_rechargeMissionId) or 0
    SetMissionData(sceneId, selfId, x330083_g_rechargeMissionId, currentPoints + amount)
    
    -- 检查是否可以解锁新档位
    for grade = 1, 4 do
        local missionId = x330083_g_MuDingPlayerMissionData[grade]
        local missionValue = GetMissionData(sceneId, selfId, missionId) or 0
        local choices = x330083_PayReward_PlayerNumToData(missionValue)
        
        -- 如果当前未达成且满足点数要求，更新为可领取状态
        if choices[5] == 0 and (currentPoints + amount) >= x330083_g_Point[grade] then
            choices[5] = 1
            local newValue = choices[1] * 10000000 + choices[2] * 100000 + 
                            choices[3] * 1000 + choices[4] * 10 + choices[5]
            SetMissionData(sceneId, selfId, missionId, newValue)
        end
    end
end
function x330083_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
	AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
function x330083_PayReward_PlayerNumToData(num)
	local tempArr = {}
	tempArr[5] = mod(num,10)
	tempArr[4] = mod(floor(num/10),100) 
	tempArr[3] = mod(floor(num/1000),100) 
	tempArr[2] = mod(floor(num/100000),100) 
	tempArr[1] = mod(floor(num/10000000),100) 
	return tempArr
end