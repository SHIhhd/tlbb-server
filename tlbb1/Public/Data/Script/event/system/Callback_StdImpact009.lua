-- 瞬移类BUFF回调 (传送角色到指定位置)
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768996_g_ScriptId = 768996

--**********************************
-- 瞬移类BUFF回调
-- 在瞬移类BUFF(StdImpact009)激活时、实际传送执行前调用
-- 可以用来修改传送目标坐标、拦截传送等
--**********************************
-- 参数说明:
--   sceneId:    场景ID
--   selfId:     施法者ObjID
--   fX:         传送目标X坐标 (原始浮点值的整数部分)
--   fZ:         传送目标Z坐标 (原始浮点值的整数部分)
--   DataIndex:  BUFF索引ID 
--
-- 返回值 (双返回值):
--   fX: 修改后的X坐标 (>0时替换原坐标)
--   fZ: 修改后的Z坐标 (>0时替换原坐标)
--
-- 注意:
--   此回调仅在同场景传送时触发
--   跨场景传送不经过此回调
--**********************************
function x768996_callback_StdImpact009(sceneId, selfId, fX, fZ, DataIndex)
	-- x768996_NotifyTip(sceneId, selfId,
		-- "[瞬移回调] fX:" .. tostring(fX) .. " fZ:" .. tostring(fZ) .. " DataIndex:" .. tostring(DataIndex))

	-- 默认不修改坐标，原样返回
	return fX, fZ
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 记录所有瞬移操作
-- function x768996_callback_StdImpact009(sceneId, selfId, fX, fZ, DataIndex)
--     x768996_NotifyTip(sceneId, selfId,
--         "[瞬移] 目标坐标: (" .. tostring(fX) .. ", " .. tostring(fZ) .. ") BUFF索引: " .. tostring(DataIndex))
--     return fX, fZ
-- end

-- 用法2: 修改传送坐标到固定位置
-- function x768996_callback_StdImpact009(sceneId, selfId, fX, fZ, DataIndex)
--     fX = 100
--     fZ = 200
--     return fX, fZ
-- end

-- 用法3: 根据BUFF索引拦截特定瞬移 (返回-1使坐标不被替换)
-- function x768996_callback_StdImpact009(sceneId, selfId, fX, fZ, DataIndex)
--     if DataIndex == 123 then
--         x768996_NotifyTip(sceneId, selfId, "该瞬移技能已被禁用。")
--         return -1, -1  -- 坐标<=0不会替换，但原函数仍会执行传送到原坐标
--     end
--     return fX, fZ
-- end

--**********************************
--醒目提醒
--**********************************
function x768996_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
