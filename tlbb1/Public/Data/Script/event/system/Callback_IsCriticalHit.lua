-- 暴击率回调控制
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768992_g_ScriptId = 768992

--**********************************
-- 暴击率回调
-- 在暴击判定计算完成后调用，可以修改暴击率和随机数
--**********************************
-- 参数说明:
--   sceneId:         场景ID 
--   selfId:          攻击者ObjID
--   targetId:        防御者ObjID 
--   IsCriticalHit:   当前是否暴击 (1=暴击, 0=未暴击)
--   nCriticalRate:   当前暴击率 (万分比, 例如3000=30%)
--   nRand:           暴击随机数 (当 nRand < nCriticalRate 时暴击)
--   nSkillID:        技能ID 
--
-- 返回值 (两个):
--   newCriticalRate:  新的暴击率 (万分比)
--   newRand:          新的随机数 
--
-- 注意:
--   暴击率为万分比，9999=99.99%
--   判定逻辑: nCriticalRate > nRand 时暴击
--   返回两个值可以同时控制暴击率和随机数
--**********************************
function x768992_callback_IsCriticalHit(sceneId, selfId, targetId, IsCriticalHit, nCriticalRate, nRand, nSkillID)
	-- 醒目提示: 回调已生效
	-- x768992_NotifyTip(sceneId, selfId,
		-- "[暴击率回调] 技能ID=" .. tostring(nSkillID) ..
		-- " 目标ID=" .. tostring(targetId) ..
		-- " 是否暴击=" .. tostring(IsCriticalHit) ..
		-- " 暴击率=" .. tostring(nCriticalRate) ..
		-- " 随机值=" .. tostring(nRand))

	-- 默认不修改，返回原始暴击率和随机数
	return nCriticalRate, nRand
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 特定技能必暴击 (设置暴击率为9999，随机数为0)
-- function x768992_callback_IsCriticalHit(sceneId, selfId, targetId, IsCriticalHit, nCriticalRate, nRand, nSkillID)
--     if nSkillID == 12345 then
--         return 9999, 0  -- 9999>0 必暴击
--     end
--     return nCriticalRate, nRand
-- end

-- 用法2: 根据玩家MissionData调整暴击率
-- function x768992_callback_IsCriticalHit(sceneId, selfId, targetId, IsCriticalHit, nCriticalRate, nRand, nSkillID)
--     local critBonus = GetMissionData(sceneId, selfId, 251)
--     if critBonus > 0 then
--         return nCriticalRate + critBonus, nRand
--     end
--     return nCriticalRate, nRand
-- end

-- 用法3: 所有暴击率提升5%
-- function x768992_callback_IsCriticalHit(sceneId, selfId, targetId, IsCriticalHit, nCriticalRate, nRand, nSkillID)
--     return nCriticalRate + 500, nRand  -- +500万分比 = +5%
-- end

--**********************************
--醒目提醒
--**********************************
function x768992_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
