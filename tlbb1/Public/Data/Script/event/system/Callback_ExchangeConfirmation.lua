-- 交易确认回调控制
-- 当双方确认交易时触发
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x769000_g_ScriptId = 769000

--**********************************
-- 交易确认回调
-- sceneId:     场景ID
-- selfId:      发起确认的玩家ID
-- targetId:    交易对方的玩家ID
-- GetData:     获取交易盒数据函数
--
-- GetData 用法:
--   获取物品信息: local item_id, count = GetData(sceneId, playerId, "ITEM", index)
--     item_id: 物品表索引 (0=空格)
--     count:   叠加数量
--   获取珍兽信息: local guid_high, guid_low = GetData(sceneId, playerId, "PET", index)
--     guid_high: 珍兽GUID高位 (0=空格)
--     guid_low:  珍兽GUID低位
--   index 范围: 0~4 (物品), 0~4 (珍兽)
--
-- 返回值: 0=允许交易, 非0=阻止交易
--**********************************
function x769000_ExchangeConfirmation(sceneId, selfId, targetId, GetData)
    local Allow = 0 -- 默认允许交易
	
    -- --遍历自己的交易物品
    -- for i = 0, 4 do
        -- local item_id, count = GetData(sceneId, selfId, "ITEM", i)
        -- if item_id > 0 then
            -- AddGlobalCountNews(sceneId, tostring(i) .. " 物品ID:" .. tostring(item_id) .. " 数量:" .. tostring(count))
        -- end
    -- end

    -- --遍历自己的交易珍兽
    -- for i = 0, 4 do
        -- local pet_id_H, pet_id_L = GetData(sceneId, selfId, "PET", i)
        -- if pet_id_H > 0 then
            -- AddGlobalCountNews(sceneId, tostring(i) .. " 珍兽高位:" .. tostring(pet_id_H) .. " 低位:" .. tostring(pet_id_L))
        -- end
    -- end

    -- --遍历对方的交易物品
    -- for i = 0, 4 do
        -- local item_id, count = GetData(sceneId, targetId, "ITEM", i)
        -- if item_id > 0 then
            -- AddGlobalCountNews(sceneId, "[对方]" .. tostring(i) .. " 物品ID:" .. tostring(item_id) .. " 数量:" .. tostring(count))
        -- end
    -- end

    -- if Allow ~= 0 then
        -- x769000_NotifyTip(sceneId, selfId, "存在违禁品，请检查交易物品后再次尝试。")
    -- end

    return Allow
end


--============================================================
-- 用法案例（取消注释即可使用）
--============================================================

-- 案例1: 禁止交易指定物品（违禁品检查）
-- function x769000_ExchangeConfirmation(sceneId, selfId, targetId,GetData)
--     local BannedItems = { [12345] = true, [67890] = true }  -- 违禁物品ID列表
--     -- 检查双方交易物品
--     for _, playerId in ipairs({selfId, targetId}) do
--         for i = 0, 4 do
--             local item_id, count = GetData(sceneId, playerId, "ITEM", i)
--             if item_id > 0 and BannedItems[item_id] then
--                 x769000_NotifyTip(sceneId, selfId, "交易中包含违禁物品，交易已取消。")
--                 x769000_NotifyTip(sceneId, targetId, "交易中包含违禁物品，交易已取消。")
--                 return 1  -- 阻止交易
--             end
--         end
--     end
--     return 0  -- 允许交易
-- end

-- 案例2: 记录交易日志
-- function x769000_ExchangeConfirmation(sceneId, selfId, targetId, GetData)
--     local log = "[交易] " .. GetName(sceneId, selfId) .. " <-> " .. GetName(sceneId, targetId) .. " 物品:"
--     for i = 0, 4 do
--         local item_id, count = GetData(sceneId, selfId, "ITEM", i)
--         if item_id > 0 then
--             log = log .. " [" .. item_id .. "x" .. count .. "]"
--         end
--     end
--     AddGlobalCountNews(sceneId, log)
--     return 0
-- end


-- 通用提示函数
function x769000_NotifyTip(sceneId, selfId, Msg)
    BeginEvent(sceneId)
        AddText(sceneId, Msg)
    EndEvent(sceneId)
    DispatchMissionTips(sceneId, selfId)
end
