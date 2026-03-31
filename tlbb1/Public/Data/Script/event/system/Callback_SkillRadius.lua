-- 技能范围回调控制
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768993_g_ScriptId = 768993

--**********************************
-- 技能范围回调
-- 在群体技能获取半径并经过门派修正后调用，可以修改技能范围半径
--**********************************
-- 参数说明:
--   sceneId:        场景ID 
--   selfId:         施法者ObjID
--   skillId:        技能ID
--   currentRadius:  当前半径值 (实际半径*100, 例如500=5.00米)

-- 返回值:
--   newRadius: 新的半径值 (实际半径*100)
--             返回原始currentRadius表示不修改
--             返回0或负数表示C++层不替换(保持原值)
--             返回正整数则替换半径值
--
-- 注意:
--   半径值为实际半径*100的整数，例如500表示5.00米
--   C++层判定: 如果返回值 > 0，则用返回值/100.0还原为float替换半径
--**********************************
function x768993_callback_SkillRadius(sceneId, selfId, skillId, currentRadius)
	-- 醒目提示: 回调已生效
	-- x768993_NotifyTip(sceneId, selfId,
		-- "[技能范围回调] 技能ID=" .. tostring(skillId) ..
		-- " 当前半径=" .. tostring(currentRadius / 100) .. "米")
		
	-- 默认不修改，返回原始半径
	return currentRadius
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 特定技能范围扩大50%
-- function x768993_callback_SkillRadius(sceneId, selfId, skillId, currentRadius)
--     if skillId == 12345 then
--         return currentRadius * 150 / 100  -- 扩大50%
--     end
--     return currentRadius
-- end

-- 用法2: 根据玩家MissionData调整技能范围
-- function x768993_callback_SkillRadius(sceneId, selfId, skillId, currentRadius)
--     local rangeBonus = GetMissionData(sceneId, selfId, 252)  -- 假设MD252存储范围加成(百分比)
--     if rangeBonus > 0 then
--         return currentRadius * (100 + rangeBonus) / 100
--     end
--     return currentRadius
-- end

-- 用法3: 所有群体技能范围+2米
-- function x768993_callback_SkillRadius(sceneId, selfId, skillId, currentRadius)
--     return currentRadius + 200  -- +200 = +2.00米
-- end

--**********************************
--醒目提醒
--**********************************
function x768993_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end