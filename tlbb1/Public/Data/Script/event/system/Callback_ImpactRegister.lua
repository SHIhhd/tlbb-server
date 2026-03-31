-- 通用Impact注册回调
-- 在任何Impact(BUFF/效果)注册到角色时触发
-- 可通过 getData/setData 读写 OWN_IMPACT 结构体的任意字段

-- 脚本ID: 769005
x769005_g_ScriptId = 769005

--**********************************
-- 通用Impact注册回调
-- sceneId:     场景ID
-- nSender:     施法者ObjID
-- nReceiver:   目标(受BUFF者)ObjID
-- dataIndex:   BUFF数据索引 (ImpactDataID)
-- logicId:     Impact逻辑ID (ImpactLogicID)
-- pImpact:     Impact数据对象（userdata指针）
-- getData:     获取Impact数据函数 getData(sceneId, selfId, pImpact, nIndex)
-- setData:     设置Impact数据函数 setData(sceneId, selfId, pImpact, nIndex, nValue)
--
-- getData/setData 的 nIndex 索引映射:
--   0:  DataIndex          (uint16_t)  BUFF数据索引
--   1:  ImpactID           (uint16_t)  Impact逻辑ID
--   2:  SkillID            (int16_t)   技能ID
--   3:  CasterObjID        (int32_t)   施法者ObjID
--   4:  CasterUniqueID     (int32_t)   施法者唯一ID
--   5:  CasterLogicCount   (int32_t)   施法者逻辑计数
--   6:  Continuance        (int32_t)   持续时间(毫秒)
--   7:  ContinuanceElapsed (int32_t)   已过持续时间
--   8:  IntervalElapsed    (int32_t)   已过间隔时间
--   9:  SubLevel           (int32_t)   子等级
--   10: m_aParams[0]       (int32_t)   效果参数0
--   11: m_aParams[1]       (int32_t)   效果参数1
--   12: m_aParams[2]       (int32_t)   效果参数2
--   13: m_aParams[3]       (int32_t)   效果参数3
--   14: m_aParams[4]       (int32_t)   效果参数4
--   15: m_aParams[5]       (int32_t)   效果参数5
--   16: m_aParams[6]       (int32_t)   效果参数6
--   17: m_aParams[7]       (int32_t)   效果参数7
--
-- 注意: 索引 0~2 为16位字段，setData写入时会截断为16位
--       索引 3~17 为32位字段
--       索引超出 0~17 范围时，getData返回-1，setData返回0
--
-- 返回值: 无（通过 setData 直接修改Impact字段）
--**********************************
function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
 
	-- 默认不修改任何字段
end


--============================================================
-- 用法案例（取消注释即可使用）
--============================================================

-- 案例1: 修改BUFF持续时间（将所有BUFF持续时间翻倍）
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     local continuance = getData(sceneId, nReceiver, pImpact, 6)  -- 读取持续时间
--     setData(sceneId, nReceiver, pImpact, 6, continuance * 2)     -- 持续时间翻倍
-- end

-- 案例2: 修改效果参数（将 m_aParams[0] 设为指定值）
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     local param0 = getData(sceneId, nReceiver, pImpact, 10)  -- 读取 m_aParams[0]
--     setData(sceneId, nReceiver, pImpact, 10, param0 + 100)   -- 增加100
-- end

-- 案例3: 按 LogicID 过滤，只修改特定Impact逻辑
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     if logicId == 141 then
--         -- 只对 StdImpact141（减少治疗量）生效
--         local healReduction = getData(sceneId, nReceiver, pImpact, 10)  -- m_aParams[0]
--         setData(sceneId, nReceiver, pImpact, 10, 50)                   -- 强制减少治疗50%
--     end
-- end

-- 案例4: 按 DataIndex 过滤，指定BUFF修改持续时间
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     if dataIndex == 100 then
--         setData(sceneId, nReceiver, pImpact, 6, 60000)  -- 强制持续60秒
--     elseif dataIndex == 200 then
--         setData(sceneId, nReceiver, pImpact, 6, 0)      -- 立即消失
--     end
-- end

-- 案例5: 打印Impact详细信息（调试用）
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     x769005_NotifyTip(sceneId, nReceiver,
--         "Impact注册 sender:"..nSender..
--         " receiver:"..nReceiver..
--         " dataIndex:"..dataIndex..
--         " logicId:"..logicId..
--         " skillId:"..getData(sceneId, nReceiver, pImpact, 2)..
--         " continuance:"..getData(sceneId, nReceiver, pImpact, 6)..
--         " param0:"..getData(sceneId, nReceiver, pImpact, 10))
-- end

-- 案例6: 输出全部BUFF字段信息（调试用，分两条公告输出）
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     local d0  = getData(sceneId, nReceiver, pImpact, 0)
--     local d1  = getData(sceneId, nReceiver, pImpact, 1)
--     local d2  = getData(sceneId, nReceiver, pImpact, 2)
--     local d3  = getData(sceneId, nReceiver, pImpact, 3)
--     local d4  = getData(sceneId, nReceiver, pImpact, 4)
--     local d5  = getData(sceneId, nReceiver, pImpact, 5)
--     local d6  = getData(sceneId, nReceiver, pImpact, 6)
--     local d7  = getData(sceneId, nReceiver, pImpact, 7)
--     local d8  = getData(sceneId, nReceiver, pImpact, 8)
--     local d9  = getData(sceneId, nReceiver, pImpact, 9)
--     local d10 = getData(sceneId, nReceiver, pImpact, 10)
--     local d11 = getData(sceneId, nReceiver, pImpact, 11)
--     local d12 = getData(sceneId, nReceiver, pImpact, 12)
--     local d13 = getData(sceneId, nReceiver, pImpact, 13)
--     local d14 = getData(sceneId, nReceiver, pImpact, 14)
--     local d15 = getData(sceneId, nReceiver, pImpact, 15)
--     local d16 = getData(sceneId, nReceiver, pImpact, 16)
--     local d17 = getData(sceneId, nReceiver, pImpact, 17)
--     x769005_NotifyTip(sceneId, nReceiver,
--         "[Impact1] DI:"..d0.." ID:"..d1.." Skill:"..d2
--         .." Caster:"..d3.." UID:"..d4.." LC:"..d5
--         .." Dur:"..d6.." Elapsed:"..d7.." Interval:"..d8.." SubLv:"..d9)
--     x769005_NotifyTip(sceneId, nReceiver,
--         "[Impact2] P0:"..d10.." P1:"..d11.." P2:"..d12.." P3:"..d13
--         .." P4:"..d14.." P5:"..d15.." P6:"..d16.." P7:"..d17)
-- end

-- 案例7: 综合示例 - 根据技能ID和施法者等级动态调整BUFF
-- function x769005_callback_ImpactRegister(sceneId, nSender, nReceiver, dataIndex, logicId, pImpact, getData, setData)
--     local skillId = getData(sceneId, nReceiver, pImpact, 2)  -- 读取技能ID
--     if skillId == 500 then
--         -- 特定技能：根据施法者等级调整持续时间
--         local senderLevel = GetLevel(sceneId, nSender)
--         local baseDuration = getData(sceneId, nReceiver, pImpact, 6)
--         setData(sceneId, nReceiver, pImpact, 6, baseDuration + senderLevel * 100)
--     end
-- end


-- 通用提示函数
function x769005_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
