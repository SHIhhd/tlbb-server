-- 升级等级限制回调
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768995_g_ScriptId = 768995

--**********************************
-- 升级等级限制回调
-- 在玩家点击升级按钮后、实际升级逻辑执行前调用
-- 可以用来做等级限制、条件检查等
--**********************************
-- 参数说明:
--   sceneId:    场景ID 
--   selfId:     玩家ObjID
--   reserved:   保留参数 (当前为0)
--
-- 返回值:
--   1: 允许升级 (放行，继续执行原升级逻辑)
--   0: 拒绝升级 (拦截，不执行升级)
--
-- 注意:
--   原始升级逻辑(经验检查、等级上限等)之前执行
--**********************************
function x768995_callback_LevelUpCheck(sceneId, selfId, reserved)
	-- x768995_NotifyTip(sceneId, selfId,
	-- 	"[升级回调] 玩家ObjID=" .. tostring(selfId))

	-- 默认放行，允许升级
	return 1
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 限制最高等级为89级
-- function x768995_callback_LevelUpCheck(sceneId, selfId, reserved)
--     local level = GetLevel(sceneId, selfId)
--     if level >= 89 then
--         x768995_NotifyTip(sceneId, selfId, "当前服务器最高等级为89级，请关注等级开放公告。")
--         return 0  -- 拒绝升级
--     end
--     return 1  -- 允许升级
-- end

-- 用法2: 根据MissionData控制升级权限
-- function x768995_callback_LevelUpCheck(sceneId, selfId, reserved)
--     local canLevelUp = GetMissionData(sceneId, selfId, 300)
--     if canLevelUp == 0 then
--         x768995_NotifyTip(sceneId, selfId, "您当前无法升级，请完成前置任务。")
--         return 0
--     end
--     return 1
-- end

-- 用法3: 特定等级段需要特殊条件
-- function x768995_callback_LevelUpCheck(sceneId, selfId, reserved)
--     local level = GetLevel(sceneId, selfId)
--     if level == 69 then
--         local questDone = GetMissionData(sceneId, selfId, 301)
--         if questDone ~= 1 then
--             x768995_NotifyTip(sceneId, selfId, "突破70级需要完成飞升任务。")
--             return 0
--         end
--     end
--     return 1
-- end

--**********************************
--醒目提醒
--**********************************
function x768995_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
