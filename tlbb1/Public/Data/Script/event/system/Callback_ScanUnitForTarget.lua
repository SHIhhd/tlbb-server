-- 群体技能扫描目标数量回调控制
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768994_g_ScriptId = 768994

--**********************************
-- 群体技能人数影响
-- 在群体技能扫描完目标后、截断目标数量前调用，可以修改最大目标数
-- 同时可以通过 getTargetID 遍历目标列表获取每个目标的ObjID
--**********************************
-- 参数说明:
--   sceneId:            场景ID
--   selfId:             施法者ObjID
--   skillId:            技能ID
--   defaultTargetCount: 扫描到的实际目标数量 
--   maxTargetCount:     最大攻击目标数量 (来自技能表配置)
--   targetData:         目标数据 (传给getTargetID使用)
--   getTargetID:        获取目标ObjID的函数 (function)
--
-- getTargetID 用法:
--   local targetID = getTargetID(sceneId, selfId, targetData, index)
--   index 从0开始，范围 0 ~ maxTargetCount-1
--   返回目标的ObjID，无效时返回nil
--
-- 返回值:
--   newMaxTargetCount: 新的最大目标数 (安全范围:0~254)
--                      返回正整数则替换maxTargetCount
--                      返回0或负数表示C++层不替换(保持原值)
--**********************************
function x768994_callback_ScanUnitForTarget(sceneId, selfId, skillId, defaultTargetCount, maxTargetCount, targetData, getTargetID)
	-- 醒目提示: 回调已生效
	-- x768994_NotifyTip(sceneId, selfId,
	-- 	"[扫描目标回调] 技能ID=" .. tostring(skillId) ..
	-- 	" 扫描到=" .. tostring(defaultTargetCount) ..
	-- 	" 最大目标=" .. tostring(maxTargetCount))

	-- 遍历目标列表示例 (取消注释可查看)
	-- local nMax = 0
	-- for i = 0, maxTargetCount - 1 do
		-- local targetID = getTargetID(sceneId, selfId, targetData, i)
		-- if targetID ~= nil and targetID > 0 and targetID <= 29999 then
			-- x768994_NotifyTip(sceneId, selfId,
				-- "名字:" .. GetName(sceneId, targetID) ..
				-- " 目标血量:" .. GetHp(sceneId, targetID) ..
				-- " ObjID:" .. targetID)
			-- nMax = nMax + 1
		-- end
	-- end
	-- x768994_NotifyTip(sceneId, selfId, "获取到有效obj的数量 " .. tostring(nMax))

	-- 默认不修改，返回原始最大目标数
	return maxTargetCount
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 特定技能目标数翻倍
-- function x768994_callback_ScanUnitForTarget(sceneId, selfId, skillId, defaultTargetCount, maxTargetCount, targetData, getTargetID)
--     if skillId == 12345 then
--         return maxTargetCount * 2
--     end
--     return maxTargetCount
-- end

-- 用法2: 根据玩家MissionData调整最大目标数
-- function x768994_callback_ScanUnitForTarget(sceneId, selfId, skillId, defaultTargetCount, maxTargetCount, targetData, getTargetID)
--     local targetBonus = GetMissionData(sceneId, selfId, 253)
--     if targetBonus > 0 then
--         return maxTargetCount + targetBonus
--     end
--     return maxTargetCount
-- end

-- 用法3: 命中所有扫描到的目标 (不截断)
-- function x768994_callback_ScanUnitForTarget(sceneId, selfId, skillId, defaultTargetCount, maxTargetCount, targetData, getTargetID)
--     return defaultTargetCount
-- end

-- 用法4: 只攻击血量低于50%的目标 (需要配合其他逻辑)
-- function x768994_callback_ScanUnitForTarget(sceneId, selfId, skillId, defaultTargetCount, maxTargetCount, targetData, getTargetID)
--     local count = 0
--     for i = 0, maxTargetCount - 1 do
--         local targetID = getTargetID(sceneId, selfId, targetData, i)
--         if targetID ~= nil and targetID > 0 and targetID <= 29999 then
--             local hp = GetHp(sceneId, targetID)
--             local maxHp = GetMaxHp(sceneId, targetID)
--             if maxHp > 0 and hp * 100 / maxHp < 50 then
--                 count = count + 1
--             end
--         end
--     end
--     if count > 0 then
--         return count
--     end
--     return maxTargetCount
-- end

--**********************************
--醒目提醒
--**********************************
function x768994_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
