-- 百分比恢复BUFF回调 (HP恢复量修改)
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768997_g_ScriptId = 768997

--**********************************
-- 百分比恢复BUFF回调
-- 在百分比恢复BUFF(StdImpact005)激活时、HealthIncrement执行前调用
-- 可以用来修改HP恢复量、拦截恢复等
--**********************************
-- 参数说明:
--   sceneId:      场景ID
--   casterObjId:  施法者ObjID  (谁施放的BUFF)
--   skillId:      技能ID 
--   dataIndex:    BUFF索引ID 
--   nHP:          HP变化量 (已经过百分比和等级计算)
--   targetId:     目标ObjID (被恢复的对象)
--
-- 返回值 (单返回值):
--   nHP: 修改后的HP变化量
--
-- 注意:
--   此回调仅修改HP恢复量，MP/Rage/StrikePoint不受影响
--   仅当施法者为玩家(ObjID 15000-29999)时触发回调
--**********************************
function x768997_callback_StdImpact005(sceneId, casterObjId, skillId, dataIndex, nHP, targetId)

	-- 默认不修改，原样返回
	return nHP
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 记录所有恢复操作
-- function x768997_callback_StdImpact005(sceneId, casterObjId, skillId, dataIndex, nHP, targetId)
--     x768997_NotifyTip(sceneId, targetId,
--         "[恢复回调] 施法者:" .. tostring(casterObjId) .. " 技能:" .. tostring(skillId) ..
--         " BUFF:" .. tostring(dataIndex) .. " HP:" .. tostring(nHP))
--     return nHP
-- end

-- 用法2: 双倍恢复
-- function x768997_callback_StdImpact005(sceneId, casterObjId, skillId, dataIndex, nHP, targetId)
--     return nHP * 2
-- end

-- 用法3: 根据BUFF索引禁止特定恢复
-- function x768997_callback_StdImpact005(sceneId, casterObjId, skillId, dataIndex, nHP, targetId)
--     if dataIndex == 123 then
--         x768997_NotifyTip(sceneId, targetId, "该恢复BUFF已被禁用。")
--         return 0  -- 恢复量设为0
--     end
--     return nHP
-- end

-- 用法4: 自己给自己加BUFF时恢复量减半
-- function x768997_callback_StdImpact005(sceneId, casterObjId, skillId, dataIndex, nHP, targetId)
--     if casterObjId == targetId then
--         return nHP / 2
--     end
--     return nHP
-- end

--**********************************
--醒目提醒
--**********************************
function x768997_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
