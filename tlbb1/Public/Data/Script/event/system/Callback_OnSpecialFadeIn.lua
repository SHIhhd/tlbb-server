-- 陷阱FadeIn回调控制
-- 当陷阱对角色生效时触发
-- @WAYLEE@XUEWU v1.0


-- 脚本ID (与32位共用768990)
x768999_g_ScriptId = 768999

--**********************************
-- 陷阱回调 (Fade In)
-- sceneId:     场景ID
-- selfId:      施暴者（陷阱拥有者ID）
-- targetId:    受害者（被陷阱命中的角色ID）
-- nDataID:     陷阱数据ID
-- nPowerPer:   额外伤害（百分比增伤修正率）
-- SpecialData: 陷阱数据对象（userdata指针）
-- getData:     获取陷阱数据函数 getData(sceneId, selfId, SpecialData, nIndex)
-- setData:     设置陷阱数据函数 setData(sceneId, selfId, SpecialData, nIndex, nValue)
--
-- getData/setData 的 nIndex 含义:
--   0: 持续时间 (m_nContinuance)
--   1: 陷阱间隔时间 (m_nInterval)
--   2: 已经过的间隔时间 (m_nElapsedInterval)
--   3: 陷阱延迟时间 (m_nDelayTime)
--   4: 固定伤害修正值 (m_nPowerRefixByValue)
--   5: 隐身级别 (m_nStealthLevel)
--   6: 陷阱类别 (m_nClass)
--   7: 陷阱消失标志 (m_bFadeOut, 0=未消失 1=已消失)
--   8: 可以激发的次数 (m_nActiveTimes)
--   9~16: 陷阱回调额外参数 m_aParams[0]~m_aParams[7]
--
-- 返回值: 新的 nPowerPer（百分比增伤修正率）
--**********************************
function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
    -- 默认返回原始增伤率（不修改）
    return nPowerPer
end


--============================================================
-- 用法案例（取消注释即可使用）
--============================================================

-- 案例1: 打印陷阱详细信息（调试用）
-- function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
--     AddGlobalCountNews(sceneId,
--         "#r   陷阱索引："..nDataID..
--         "#r 0 持续时间："..getData(sceneId, selfId, SpecialData, 0)..
--         "#r 1 间隔时间："..getData(sceneId, selfId, SpecialData, 1)..
--         "#r 2 已过时间："..getData(sceneId, selfId, SpecialData, 2)..
--         "#r 8 激发次数："..getData(sceneId, selfId, SpecialData, 8)
--     )
--     return nPowerPer
-- end

-- 案例2: 修改陷阱增伤倍率（设为100000%超高伤害）
-- function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
--     nPowerPer = 100000
--     return nPowerPer
-- end

-- 案例3: 根据任务数据动态设置陷阱激发次数
-- function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
--     if GetMissionData(sceneId, selfId, 500) == 1 then
--         setData(sceneId, selfId, SpecialData, 8, 10)  -- 设置可激发次数为10
--         SetMissionData(sceneId, selfId, 500, 0)        -- 重置任务标记
--     end
--     return nPowerPer
-- end

-- 案例4: 给施暴者和受害者发送提示信息
-- function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
--     x768999_NotifyTip(sceneId, selfId,
--         "施暴者:"..GetName(sceneId, selfId)..
--         " 受害者:"..GetName(sceneId, targetId)..
--         " 使用 "..nDataID.." 号陷阱 增伤 "..nPowerPer.."%")
--     return nPowerPer
-- end

-- 案例5: 根据陷阱ID对特定陷阱加倍伤害
-- function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
--     if nDataID == 123 then       -- 指定陷阱ID
--         nPowerPer = nPowerPer * 2 -- 伤害翻倍
--     end
--     return nPowerPer
-- end

-- 案例6: 读取并修改陷阱持续时间
-- function x768999_OnSpecialFadeIn(sceneId, selfId, targetId, nDataID, nPowerPer, SpecialData, getData, setData)
--     local duration = getData(sceneId, selfId, SpecialData, 0)  -- 读取持续时间
--     if duration < 5000 then
--         setData(sceneId, selfId, SpecialData, 0, 10000)        -- 延长持续时间到10秒
--     end
--     return nPowerPer
-- end


-- 通用提示函数
function x768999_NotifyTip( sceneId, selfId, Msg )
    BeginEvent( sceneId )
        AddText( sceneId, Msg )
    EndEvent( sceneId )
    DispatchMissionTips( sceneId, selfId )
end
