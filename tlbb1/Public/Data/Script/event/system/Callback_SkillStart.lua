-- 技能后置回调控制
-- 在所有引擎条件判断通过后、技能实际执行前触发 (SkillCore_T::ProcessSkillRequest)

-- 脚本ID
x769009_g_ScriptId = 769009

--**********************************
-- 技能后置回调 (SkillStart)
-- sceneId:     场景ID
-- selfId:      施法者ID
-- nTargetID:   目标ID (-1表示无目标)
-- nSkillID:    技能ID
-- nMenPai:     施法者门派ID
-- fPosX:       目标坐标X (浮点数)
-- fPosZ:       目标坐标Z (浮点数)
-- fDir:        施法方向 (浮点数)
-- CharData:    角色数据对象
-- getData:     获取角色技能数据函数 getData(sceneId, selfId, CharData, nIndex)
-- setData:     设置角色技能数据函数 setData(sceneId, selfId, CharData, nIndex, nValue)
--
-- getData/setData 的 nIndex 含义:
--   0: ActivatedSkill  - 当前激活的技能ID 
--   1: TargetObjID     - 目标对象ID 
--   2: TargetGUID      - 目标GUID
--   3: TargetPos.X     - 目标坐标X (float转int)
--   4: TargetPos.Z     - 目标坐标Z (float转int)
--   5: TargetDirection  - 目标方向 (float转int)
--   6: IgnoreConditionCheck - 是否忽略条件检查
--   7: ErrCode         - 错误码
--   8: ObjID           - 对象ID (只读)
--   9: ObjType         - 对象类型 (只读, 1=人类)
--  10: MenPai          - 门派ID (只读, 仅人类有效)
--
-- 返回值: 0=放行  非0=拦截技能执行
--   (需要配合技能放行白名单，免疫nil值和异常值)
--**********************************
function x769009_callback_SkillStart(sceneId, selfId, nTargetID, nSkillID, nMenPai, fPosX, fPosZ, fDir, CharData, getData, setData)

   -- 默认放行
    return 0
end


--============================================================
-- 用法案例（取消注释即可使用）
--============================================================

-- 案例1: 打印技能详细信息（调试用）
-- function x769009_callback_SkillStart(sceneId, selfId, nTargetID, nSkillID, nMenPai, fPosX, fPosZ, fDir, CharData, getData, setData)
--     x769009_NotifyTip(sceneId, selfId,
--         "技能回调   施法者:" .. tostring(selfId) ..
--         "   受害者:" .. tostring(nTargetID) ..
--         "   技能ID:" .. tostring(nSkillID) ..
--         "   坐标:" .. tostring(fPosX) .. "," .. tostring(fPosZ) ..
--         "   方向:" .. tostring(fDir) ..
--         "   门派:" .. tostring(nMenPai))
--     return 0
-- end

-- 案例2: 拦截特定技能
-- function x769009_callback_SkillStart(sceneId, selfId, nTargetID, nSkillID, nMenPai, fPosX, fPosZ, fDir, CharData, getData, setData)
--     if nSkillID == 123 then
--         x769009_NotifyTip(sceneId, selfId, "该技能已被禁用！")
--         return 1  -- 拦截
--     end
--     return 0  -- 放行
-- end

-- 案例3: 使用getData读取角色数据
-- function x769009_callback_SkillStart(sceneId, selfId, nTargetID, nSkillID, nMenPai, fPosX, fPosZ, fDir, CharData, getData, setData)
--     local curSkill = getData(sceneId, selfId, CharData, 0)   -- 当前激活技能
--     local targetId = getData(sceneId, selfId, CharData, 1)   -- 目标ID
--     local objType  = getData(sceneId, selfId, CharData, 9)   -- 对象类型
--     local menPai   = getData(sceneId, selfId, CharData, 10)  -- 门派
--     x769009_NotifyTip(sceneId, selfId,
--         "getData: curSkill=" .. curSkill ..
--         " targetId=" .. targetId ..
--         " objType=" .. objType ..
--         " menPai=" .. menPai)
--     return 0
-- end

-- 案例4: 使用setData修改目标（将技能重定向到自己）
-- function x769009_callback_SkillStart(sceneId, selfId, nTargetID, nSkillID, nMenPai, fPosX, fPosZ, fDir, CharData, getData, setData)
--     if nSkillID == 456 then
--         setData(sceneId, selfId, CharData, 1, selfId)  -- 将目标改为自己
--     end
--     return 0
-- end

-- 案例5: 根据门派限制技能使用
-- function x769009_callback_SkillStart(sceneId, selfId, nTargetID, nSkillID, nMenPai, fPosX, fPosZ, fDir, CharData, getData, setData)
--     -- 门派0(少林)禁止使用技能ID 100
--     if nMenPai == 0 and nSkillID == 100 then
--         x769009_NotifyTip(sceneId, selfId, "少林弟子不可使用此技能！")
--         return 1
--     end
--     return 0
-- end


-- 通用提示函数
function x769009_NotifyTip( sceneId, selfId, Msg )
    BeginEvent( sceneId )
        AddText( sceneId, Msg )
    EndEvent( sceneId )
    DispatchMissionTips( sceneId, selfId )
end
