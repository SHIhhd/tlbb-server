-- 间隔驻留BUFF回调 (周期性子BUFF发放控制)
-- @WAYLEE@XUEWU v1.0

-- 脚本ID
x768998_g_ScriptId = 768998

--**********************************
-- 间隔驻留BUFF回调
-- 在间隔驻留BUFF(StdImpact010)每次间隔触发时、子BUFF发放前调用
-- 可以用来拦截子BUFF发放、记录BUFF触发等
--**********************************
-- 参数说明:
--   sceneId:             场景ID
--   selfId:              目标ObjID  (被施加BUFF的对象)
--   casterObjId:         施法者ObjID 
--   dataIndex:           BUFF索引ID 
--   continuance:         BUFF总持续时间 (毫秒)
--   continuanceElapsed:  BUFF已过时间 (毫秒)
--
-- 返回值 (单返回值):
--   1 = 继续执行子BUFF发放 (默认)
--   0 = 跳过本次子BUFF发放
--
-- 注意:
--   此回调在每个间隔周期触发一次
--   仅当目标为玩家(ObjID 15000-29999)时触发回调
--   子BUFF的具体效果由BUFF表格配置决定
--**********************************
function x768998_callback_StdImpact010(sceneId, selfId, casterObjId, dataIndex, continuance, continuanceElapsed)
	-- 默认允许子BUFF发放
	return 1
end

--**********************************
-- 用法案例 (取消注释即可使用)
--**********************************

-- 用法1: 记录每次间隔触发
-- function x768998_callback_StdImpact010(sceneId, selfId, casterObjId, dataIndex, continuance, continuanceElapsed)
--     x768998_NotifyTip(sceneId, selfId,
--         "[间隔BUFF] 施法者:" .. tostring(casterObjId) .. " BUFF:" .. tostring(dataIndex) ..
--         " 已过:" .. tostring(continuanceElapsed) .. "/" .. tostring(continuance))
--     return 1
-- end

-- 用法2: 禁止特定BUFF的子效果发放
-- function x768998_callback_StdImpact010(sceneId, selfId, casterObjId, dataIndex, continuance, continuanceElapsed)
--     if dataIndex == 456 then
--         x768998_NotifyTip(sceneId, selfId, "该间隔BUFF效果已被禁用。")
--         return 0  -- 跳过本次子BUFF发放
--     end
--     return 1
-- end

-- 用法3: BUFF持续一半时间后停止发放子效果
-- function x768998_callback_StdImpact010(sceneId, selfId, casterObjId, dataIndex, continuance, continuanceElapsed)
--     if continuanceElapsed > continuance / 2 then
--         return 0  -- 后半段不再发放
--     end
--     return 1
-- end

--**********************************
--醒目提醒
--**********************************
function x768998_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
