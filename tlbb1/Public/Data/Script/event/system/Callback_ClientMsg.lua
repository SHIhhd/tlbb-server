-- 聊天消息回调 (Client_Msg)
-- 当玩家发送包含 "&SYSDATA&" 的聊天消息时触发
-- 用于客户端与服务端之间的自定义数据通信

-- 脚本ID
x769007_g_ScriptId = 769007

x769007_g_TrustedCallTable = {
    -- [脚本ID] = { ["函数名"] = 1, ... }
    [666660] = { ["ModifyEquip"] = 1, ["ModifyEquip2"] = 1 },
	[666666] = { ["AddGlobalCountNews"] = 1 },
}

-- 参数说明:
-- sceneId  - 场景ID
-- selfId   - 玩家ObjID
-- cParam3  - 聊天消息原文(包含 &SYSDATA& 标记的完整字符串)

-- 协议格式示例: "&SYSDATA&,脚本ID,函数名,参数1,参数2,..."
-- 通过 string.split 解析逗号分隔的参数

-- 无返回值(拦截后不执行原聊天逻辑)


function x769007_Client_Msg(sceneId, selfId, cParam3)
	print(cParam3)
	--先判断管理员权限
    if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	
	if cParam3 == nil or cParam3 == "" then
        return
    end
	
	local FG = string.split(cParam3, ",")
	
	-- 至少需要 3 段: &SYSDATA&, scriptid, funcname
    local count = table.getn(FG)
    if count < 3 then
        return
    end
	
	local scriptid = tonumber(FG[2])
    local funcname = FG[3]
    if scriptid == nil or funcname == nil or funcname == "" then
        return
    end
	
	-- 信任检测: 脚本ID + 函数名必须在白名单中
    if x769007_IsTrustedCall(scriptid, funcname) ~= 1 then
        return
    end
	
	local maxArgs = 8
    if count - 3 > maxArgs then
        count = 3 + maxArgs
    end
	
	local p = {}
    for i = 4, 3 + maxArgs do
        if i <= count then
            p[i] = FG[i]
        else
            p[i] = ""
        end
    end

	if count == 3 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId)
    elseif count == 4 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4])
    elseif count == 5 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5])
    elseif count == 6 then
		print(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6])
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6])
    elseif count == 7 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6], p[7])
    elseif count == 8 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6], p[7], p[8])
    elseif count == 9 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6], p[7], p[8], p[9])
    elseif count == 10 then
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6], p[7], p[8], p[9], p[10])
    else
        CallScriptFunction(scriptid, funcname, sceneId, selfId, p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11])
    end
end

function x769007_IsTrustedCall(scriptid, funcname)
    local funcs = x769007_g_TrustedCallTable[scriptid]
    if funcs == nil then
        return 0
    end
    if funcs[funcname] then
        return 1
    end
    return 0
end

function x769007_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
