-- 命中率回调控制
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768991_g_ScriptId = 768991

--**********************************
-- 命中率回调 
-- 在命中判定计算完成后调用，可以修改命中率和随机数
--**********************************
-- 参数说明:
--   sceneId:    场景ID
--   selfId:     攻击者ObjID 
--   targetId:   防御者ObjID 
--   bHit:       当前是否命中 (1=命中, 0=闪避)
--   nHitRate:   当前命中率 (千分比, 例如800=80%)
--   nRand:      命中随机数 (当 nRand < nHitRate 时为命中状态)
--   nSkillID:   技能ID 
--
-- 返回值 (两个):
--   newHitRate:  新的命中率 (千分比)
--   newRand:     新的随机数 
--
-- 注意:
--   命中率为千分比，1000=100%必中
--   判定逻辑: nHitRate > nRand 时命中
--   返回两个值可以同时控制命中率和随机数
--**********************************
function x768991_callback_IsHit(sceneId, selfId, targetId, bHit, nHitRate, nRand, nSkillID)
	-- 醒目提示: 回调已生效
	-- x768991_NotifyTip(sceneId, selfId,
	-- 	"[命中率回调] 技能ID=" .. tostring(nSkillID) ..
	-- 	" 目标ID=" .. tostring(targetId) ..
	-- 	" 是否命中=" .. tostring(bHit) ..
	-- 	" 命中率=" .. tostring(nHitRate) ..
	-- 	" 随机值=" .. tostring(nRand))

	-- 默认不修改，返回原始命中率和随机数
	return nHitRate, nRand
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 特定技能必中 (设置命中率为1000，随机数为0)
-- function x768991_callback_IsHit(sceneId, selfId, targetId, bHit, nHitRate, nRand, nSkillID)
--     if nSkillID == 12345 then
--         return 1000, 0  -- 1000>0 必中
--     end
--     return nHitRate, nRand
-- end

-- 用法2: 根据玩家MissionData调整命中率
-- function x768991_callback_IsHit(sceneId, selfId, targetId, bHit, nHitRate, nRand, nSkillID)
--     local hitBonus = GetMissionData(sceneId, selfId, 250)
--     if hitBonus > 0 then
--         return nHitRate + hitBonus, nRand
--     end
--     return nHitRate, nRand
-- end

-- 用法3: 所有命中率提升10%
-- function x768991_callback_IsHit(sceneId, selfId, targetId, bHit, nHitRate, nRand, nSkillID)
--     return nHitRate + 100, nRand  -- +100千分比 = +10%
-- end

--**********************************
--醒目提醒
--**********************************
function x768991_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
