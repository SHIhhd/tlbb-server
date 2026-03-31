-- 普通聊天消息回调 (ChatMsg)
-- 当玩家发送任何非 &SYSDATA& 的聊天消息时触发
-- 参考 OnSpecialFadeIn 模式，所有参数都可通过 getData/setData 自由读写修改

-- 脚本ID
x769008_g_ScriptId = 769008

--**********************************
-- 聊天消息回调
-- sceneId:     场景ID
-- selfId:      发送者ObjID
-- contex:      聊天内容字符串（只读快照，修改请用 setData）
-- targetName:  目标名字（只读快照，修改请用 setData）
-- PacketData:  聊天数据包对象（userdata指针）
-- getData:     获取数据函数 getData(sceneId, selfId, PacketData, nIndex)
-- setData:     设置数据函数 setData(sceneId, selfId, PacketData, nIndex, value)
--
-- getData/setData 的 nIndex 含义:
--   0: 聊天频道类型 ChatType (int)
--      0=当前/附近  1=队伍  2=场景  3=私聊  4=帮会
--      5=阵营  6=门派  7=门派2  10=跨服  11=IP区域
--      12=自定义频道  13=当前2  14=好友  15=跨服2
--      16=全服公告  18=即时通讯
--   1: 聊天内容 Contex (string, 最大319字符)
--   2: 目标名字 TargetName (string, 最大29字符, 私聊时为对方名字)
--   3: 队伍ID TeamID (int)
--   4: 频道ID ChannelID (int)
--   5: 帮会ID GuildID (int)
--   6: 普通数据 NormalData (int)
--
-- 返回值:
--   0 = 拦截（消息不发送）
--   1 = 放行（如果用setData修改过，则用修改后的数据发送）
--**********************************
function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
    -- 默认放行
    return 1
end


--============================================================
-- 用法案例（取消注释即可使用）
--============================================================

-- 案例1: 记录所有聊天消息（调试用）
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local chatType = getData(sceneId, selfId, PacketData, 0)
--     local name = GetName(sceneId, selfId)
--     DiskLog("./Log/ChatLog", "["..chatType.."] "..name..": "..contex)
--     return 1
-- end

-- 案例2: 禁止某个频道发言
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local chatType = getData(sceneId, selfId, PacketData, 0)
--     if chatType == 10 then  -- 跨服频道
--         x769008_NotifyTip(sceneId, selfId, "跨服聊天已关闭")
--         return 0  -- 拦截
--     end
--     return 1
-- end

-- 案例3: 修改聊天频道（场景频道强制转队伍频道）
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local chatType = getData(sceneId, selfId, PacketData, 0)
--     if chatType == 2 then  -- 场景频道
--         setData(sceneId, selfId, PacketData, 0, 1)  -- 改为队伍频道
--     end
--     return 1
-- end

-- 案例4: 修改聊天内容（给消息加前缀）
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     if GetMissionData(sceneId, selfId, 100) == 1 then
--         setData(sceneId, selfId, PacketData, 1, "[VIP] "..contex)
--     end
--     return 1
-- end

-- 案例5: 修改私聊目标（重定向私聊）
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local chatType = getData(sceneId, selfId, PacketData, 0)
--     if chatType == 3 then  -- 私聊
--         local curTarget = getData(sceneId, selfId, PacketData, 2)
--         if curTarget == "OldName" then
--             setData(sceneId, selfId, PacketData, 2, "NewName")
--         end
--     end
--     return 1
-- end

-- 案例6: 聊天内容关键词过滤+替换
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local filtered = string.gsub(contex, "违禁词", "***")
--     if filtered ~= contex then
--         setData(sceneId, selfId, PacketData, 1, filtered)
--         x769008_NotifyTip(sceneId, selfId, "您的消息包含敏感词，已自动替换")
--     end
--     return 1
-- end

-- 案例7: 根据等级限制发言频道
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local chatType = getData(sceneId, selfId, PacketData, 0)
--     local level = GetLevel(sceneId, selfId)
--     if level < 30 and (chatType == 2 or chatType == 10) then
--         x769008_NotifyTip(sceneId, selfId, "30级以上才能使用该频道")
--         return 0
--     end
--     return 1
-- end

-- 案例8: 读取所有包字段（完整调试）
-- function x769008_callback_ChatMsg(sceneId, selfId, contex, targetName, PacketData, getData, setData)
--     local chatType   = getData(sceneId, selfId, PacketData, 0)
--     local msgContex  = getData(sceneId, selfId, PacketData, 1)
--     local tarName    = getData(sceneId, selfId, PacketData, 2)
--     local teamId     = getData(sceneId, selfId, PacketData, 3)
--     local channelId  = getData(sceneId, selfId, PacketData, 4)
--     local guildId    = getData(sceneId, selfId, PacketData, 5)
--     local normalData = getData(sceneId, selfId, PacketData, 6)
--     AddGlobalCountNews(sceneId,
--         "#r 频道:"..chatType..
--         "#r 内容:"..msgContex..
--         "#r 目标:"..tarName..
--         "#r 队伍:"..teamId..
--         "#r 频道ID:"..channelId..
--         "#r 帮会:"..guildId..
--         "#r 数据:"..normalData
--     )
--     return 1
-- end


-- 通用提示函数
function x769008_NotifyTip( sceneId, selfId, Msg )
    BeginEvent( sceneId )
        AddText( sceneId, Msg )
    EndEvent( sceneId )
    DispatchMissionTips( sceneId, selfId )
end
