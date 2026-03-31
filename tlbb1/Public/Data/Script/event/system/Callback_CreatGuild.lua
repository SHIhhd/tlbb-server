-- 创建帮会回调控制 (完整重写版)
-- 在玩家申请创建帮会时触发，可拦截创建、修改等级/金钱需求
-- 脚本ID: 769002

x769002_g_ScriptId = 769002


-- 参数说明:
  -- sceneId    - 场景ID
  -- selfId     - 玩家ObjID
  -- guildName  - 帮会名称 (字符串)
  -- guildDesc  - 帮会描述 (字符串)
  -- level      - 玩家当前等级
  -- money      - 玩家当前总金钱 (金币+交子)

-- 返回值 (多返回值):
  -- retValue0: 1=拦截(不允许创建帮会), 其他=放行
  -- retValue1: 修改后的金币需求 (>0时生效, 0=使用默认500000)
  -- retValue2: 修改后的等级需求 (>0时生效, 0=使用默认40级)


function x769002_CreatGuild(sceneId, selfId, guildName, guildDesc, level, money)
	-- 默认放行，使用默认需求
	return 0, 0, 0
end


-- 用法案例:

-- -- 案例1: 自定义等级和金钱需求
-- function x769002_CreatGuild(sceneId, selfId, guildName, guildDesc, level, money)
    -- -- 需要119级，100万金币
    -- local requiredLevel = 119
    -- local requiredMoney = 1000000
    
    -- if level < requiredLevel then
        -- x769002_NotifyTip(sceneId, selfId, "创建帮会需要角色等级达到"..requiredLevel.."级，当前等级："..level)
        -- return 1, 0, 0  -- 拦截
    -- end
    
    -- if money < requiredMoney then
        -- x769002_NotifyTip(sceneId, selfId, "创建帮会需要"..requiredMoney.."金币，当前金币："..money)
        -- return 1, 0, 0  -- 拦截
    -- end
    
    -- -- 放行，使用自定义金币需求
    -- return 0, requiredMoney, requiredLevel
-- end

-- -- 案例2: 禁止特定名称
-- function x769002_CreatGuild(sceneId, selfId, guildName, guildDesc, level, money)
    -- -- 检查帮会名称
    -- if string.find(guildName, "GM") or string.find(guildName, "管理") then
        -- x769002_NotifyTip(sceneId, selfId, "帮会名称包含违禁词，请重新输入。")
        -- return 1, 0, 0
    -- end
    
    -- -- 记录日志
    -- -- print("[CreatGuild] 玩家"..selfId.." 创建帮会: "..guildName.." 描述: "..guildDesc)
    
    -- return 0, 0, 0  -- 放行
-- end


function x769002_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
