--===================================================
-- 内置在线超级管理员工具
-- 雪舞
--===================================================

--**********************************
-- GM工具V1 2022-8-26 09:29:21
--**********************************
function x666666_GMToolTypeOne(sceneId, selfId, nType, isWho, arg2, nHumanId, arg4, arg5)
    --异常数值判断
    if nType == nil or isWho == nil or arg2 == nil then
        return
    end
    if nType < 0 or isWho < 0 or arg2 < 0 then
        return
    end
    --权限检查
    if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	
	
	local LogStr = ""
	if nHumanId == nil or nHumanId == -1 then
		PushDebugMessage(sceneId, selfId, "由于未选择目标,默认发给管理员自己哦!注意一下哦!")
		nHumanId = selfId -- 参数异常，就直接给发自己
	end
	
	local PlayerName = GetName(sceneId,nHumanId) --玩家名字
    if nType == 1 then --发元宝
        if isWho == 1 then
            if YuanBao(sceneId, nHumanId, -1, 3, 0) + arg2 > 2000000000 then
                PushDebugMessage(sceneId, selfId, "超过最大数20亿，无法继续增加！")
                return
            end
            YuanBao(sceneId, nHumanId, -1, 1, arg2)
             --增加
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员为"..PlayerName.."发放！" .. arg2 .. "点元宝")
            --记录日志
            LogStr =" 刷元宝：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]元宝给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
            return
        else
			LuaFnCostYuanBao(sceneId,nHumanId,arg2)
            -- YuanBao(sceneId, nHumanId, -1, 2, arg2)
             --减少
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员扣除"..PlayerName .. arg2 .. "点元宝")
            return
        end
    elseif nType == 2 then --发道具装备
        if arg2 < 10000000 or arg2 > 99999999 then
            PushDebugMessage(sceneId, selfId, "输入的道具ID不正确！")
            return
        end
        if isWho == 1 then --增加
            TryRecieveItem(sceneId, nHumanId, arg2, 1)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员发给["..PlayerName.."]1个" .. GetItemName(sceneId, arg2), 0)
            --记录日志
            LogStr =" 刷道具：" ..GetName(sceneId, selfId) .."刷取：1个[" ..GetItemName(sceneId, arg2) .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnDelAvailableItem(sceneId, nHumanId, arg2, 1)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员删除["..PlayerName.."]的1个" .. GetItemName(sceneId, arg2), 0)
        end
    elseif nType == 3 then --金币
        if isWho == 1 then --增加
            --总金额限制
            if GetMoney(sceneId, nHumanId) + (arg2 * 10000) > 2100000000 then
                PushDebugMessage(sceneId, selfId, "携带金额不可超过21万金币，请缩减您输入的数值！")
                return
            end
            AddMoney(sceneId, nHumanId, arg2 * 10000)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "金币。")
            --记录日志
            LogStr =" 刷金币：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]金币给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnCostMoney(sceneId, nHumanId, arg2 * 10000)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "金币。")
        end
    elseif nType == 4 then --绑定元宝
        if isWho == 1 then --增加
            --总金额限制
            if BindYuanBao(sceneId, nHumanId, -1, 3, 0) + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿绑定元宝，请缩减您输入的数值！")
                return
            end
            BindYuanBao(sceneId, nHumanId, -1, 1, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "绑定元宝。")
            --记录日志
            LogStr =" 刷元宝：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]点给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            BindYuanBao(sceneId, nHumanId, -1, 2, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "绑定元宝。")
        end
    elseif nType == 5 then --返券
		local XinFaData = {
            [0] = {1, 2, 3, 4, 5, 6, 55, 72},
            [1] = {7, 8, 9, 10, 11, 12, 56, 73},
            [2] = {13, 14, 15, 16, 17, 18, 57, 74},
            [3] = {19, 20, 21, 22, 23, 24, 58, 75},
            [4] = {25, 26, 27, 28, 29, 30, 59, 76},
            [5] = {31, 32, 33, 34, 35, 36, 60, 77},
            [6] = {37, 38, 39, 40, 41, 42, 61, 78},
            [7] = {43, 44, 45, 46, 47, 48, 62, 79},
            [8] = {49, 50, 51, 52, 53, 54, 63, 80},
            [9] = {0, 0, 0, 0, 0, 0, 0, 0},
            [10] = {64, 65, 66, 67, 68, 69, 70, 71},
            [11] = {81, 82, 83, 84, 85, 86, 87, 88},
            [12] = {89, 90, 91, 92, 93, 94, 95, 96},
             --新增鬼谷
            [13] = {97, 98, 99, 100, 101, 102, 103, 104}, -- 新增桃花岛
            [14] = {105, 106, 107, 108, 109, 110, 111, 112} -- 新增绝情谷
        }
        local nMenPaiID = GetMenPai(sceneId, nHumanId)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][1], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][2], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][3], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][4], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][5], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][6], arg2)
        --后两本
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][7], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][8], arg2)
        x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员将您设置心法等级为：" .. arg2, 0)
		
    elseif nType == 6 then --红利
        if isWho == 1 then --增加
            --总金额限制
            if ZengDian(sceneId,nHumanId,-1,3,0) + arg2 > 1000000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过10亿，请缩减您输入的数值！")
                return
            end
			ZengDian(sceneId,nHumanId,-1,1,arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "赠点。")
            --记录日志
            LogStr =" 刷赠点：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
            DispatchUICommand(sceneId, nHumanId, 20231124) --[XUEWU-BUG-713] 刷新红利界面
        elseif isWho == 2 then --减少
            if (ZengDian(sceneId,nHumanId,-1,3,0) - arg2) < 0 then
                PushDebugMessage(sceneId, nHumanId, "赠点不能扣到0以下！")
                return
            end
			ZengDian(sceneId,nHumanId,-1,2,arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "赠点。")
            DispatchUICommand(sceneId, nHumanId, 20231124) --[XUEWU-BUG-713] 刷新红利界面
        end
    elseif nType == 7 then --等级
        if isWho == 1 or isWho == 2 then
            LuaFnSetHumanLevel(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]的等级设置成了" .. arg2 .. "级。")
            --记录日志
            LogStr =" 刷等级：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]级给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        end
    elseif nType == 8 then --门派
        if isWho == 1 then --增加
            LuaFnJoinMenpai(sceneId, nHumanId, nHumanId, arg2 - 1)
            --记录日志
            LogStr =" 改门派：" ..GetName(sceneId, selfId) .."刷取：[" ..(arg2 - 1) .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        end
        PushDebugMessage(sceneId, selfId, "更换门派操作成功")
    elseif nType == 9 then --//--给玩家发放道具装备
        --发放物品
        BeginAddItem(sceneId)
        AddItem(sceneId, isWho, arg2)
        ret = EndAddItem(sceneId, nHumanId)
        if ret > 0 then --发放成功
            AddItemListToHuman(sceneId, nHumanId)
            x666666_TongZhi(sceneId,selfId,nHumanId,"游戏管理员发给["..PlayerName.."]道具，获得了" .. arg2 .. "个" .. GetItemName(sceneId, isWho),0)
            --记录日志
            LogStr =" 批量刷道具：" ..GetName(sceneId, selfId) .."刷取：" ..arg2 .."个[" ..GetItemName(sceneId, isWho) .."]给" ..GetName(sceneId, nHumanId) .."[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        else --发放失败
            PushDebugMessage(sceneId, selfId, "目标背包空间不足")
        end

	elseif nType == 10 then --交子发放
        if isWho == 1 then --增加
            --总金额限制
            if GetMoneyJZ(sceneId, nHumanId) + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            AddMoneyJZ(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "交子。")
            --记录日志
            LogStr =" 刷交子：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            AddMoneyJZ(sceneId, nHumanId, -arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "交子。")
        end
    elseif nType == 11 then  --金坷垃
        --获取善恶值
        local gb_value = LuaFnGetHumanGoodBadValue(sceneId, nHumanId)
        if isWho == 1 then --增加
            --总额限制
            if gb_value + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            LuaFnSetHumanGoodBadValue(sceneId, nHumanId, gb_value + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您发放了" .. arg2 .. "点善恶。")
            --记录日志
            LogStr =" 刷善恶：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnSetHumanGoodBadValue(sceneId, nHumanId, gb_value - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您扣除了" .. arg2 .. "点善恶。")
        end
    elseif nType == 12 then --门派贡献
        if isWho == 1 then --增加
            local menpaipoint = GetHumanMenpaiPoint(sceneId, nHumanId)
            --总金额限制
            if menpaipoint + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            SetHumanMenpaiPoint(sceneId, nHumanId, menpaipoint + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "门贡。")
            --记录日志
            LogStr =" 刷门贡：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            local menpaipoint = GetHumanMenpaiPoint(sceneId, nHumanId)
            SetHumanMenpaiPoint(sceneId, nHumanId, menpaipoint - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "门贡。")
        end
    elseif nType == 13 then --帮贡
        if isWho == 1 then --增加
            --总金额限制
            if CityGetAttr(sceneId, nHumanId, GUILD_CONTRIB_POINT) + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            CityChangeAttr(sceneId, nHumanId, GUILD_CONTRIB_POINT, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "帮贡。")
            --记录日志
            LogStr =" 刷帮贡：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            CityChangeAttr(sceneId, nHumanId, GUILD_CONTRIB_POINT, -arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "帮贡。")
        end
    elseif nType == 14 then --修炼功力
        if isWho == 1 then --增加
            ResetPlayerPower(sceneId,nHumanId);
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]恢复到了100功力。")
            --记录日志
            LogStr =" 刷功力：" ..GetName(sceneId, selfId) .."刷满100点给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetMissionData(sceneId, nHumanId, XIULIAN_GONGLI, GetMissionData(sceneId, nHumanId, XIULIAN_GONGLI) - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "功力。")
        end
    elseif nType == 15 then --杀气值
         --获取杀气值
        local pk_value = LuaFnGetHumanPKValue(sceneId, nHumanId)
        if isWho == 1 then --增加
            LuaFnSetHumanPKValue(sceneId, nHumanId, pk_value + arg2)
            PushDebugMessage(sceneId, nHumanId, "游戏管理员给您加了" .. arg2 .. "点杀气。")
            PushDebugMessage(sceneId, selfId, "给玩家发放了" .. arg2 .. "点杀气。")
            --记录日志
            LogStr =" 加杀气：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnSetHumanPKValue(sceneId, nHumanId, pk_value - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您扣除了" .. arg2 .. "点杀气。")
            LuaFnAuditGoodbadDecPKValue(sceneId, selfId, arg2) --记录用善恶值减少杀气的统计信息....
            --记录日志
            LogStr =" 删杀气：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        end
    elseif nType == 16 then --称号
        if isWho == 1 then --增加
			LuaFnAwardCharTitle(sceneId,nHumanId,arg2)
			LuaFnSetCurTitleById(sceneId,nHumanId,arg2)
			LuaFnDispatchAllTitle(sceneId,nHumanId,arg2)
			x666666_TongZhi(sceneId,selfId, nHumanId, "游戏管理员为您发放称号：" .. arg2, 0)	
		else
			LuaFnDeleteTitleByID(sceneId,nHumanId,arg2)
			x666666_TongZhi(sceneId,selfId, nHumanId, "游戏管理员为您删除称号：" .. arg2, 0)	
		end
    elseif nType == 17 then --buff 
        --范围限制检测
        if arg2 < 0 or arg2 > 65535 then
            PushDebugMessage(sceneId, selfId, "输入的数值不合法，范围在0-65535")
            return
        end
        if isWho == 1 then --增加
            LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanId, arg2, 0)
            x666666_TongZhi(sceneId, selfId,nHumanId, "获得了管理员给["..PlayerName.."]的BUFF！")
            --记录日志
            LogStr =" 刷BUFF：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnCancelSpecificImpact(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]删除了一个BUFF！")
        end
    elseif nType == 18 then --宝宝珍兽
        if isWho == 1 then --增加
            --范围限制检测
            if arg2 < 558 or arg2 > 99999 then
                PushDebugMessage(sceneId, selfId, "输入的数值不合法，范围在588-99999")
                return
            end
            LuaFnCreatePetToHuman(sceneId, nHumanId, arg2, 1, 0)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]了一个宝宝。")
            --记录日志
            LogStr =" 发宝宝：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            PushDebugMessage(sceneId, nHumanId, "不支持扣除！")
            return
        end
    elseif nType == 19 then --经验
        if isWho == 1 then --增加
            AddExp(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "经验。")
            --记录日志
            LogStr =" 刷经验：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnDecExp(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "经验。")
        end
    elseif nType == 20 then --活力
        if isWho == 1 then --增加
            SetHumanVigor(sceneId, nHumanId, GetHumanVigor(sceneId, nHumanId) + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "活力。")
            --记录日志
            LogStr =" 刷活力：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetHumanVigor(sceneId, nHumanId, GetHumanVigor(sceneId, nHumanId) - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "活力。")
        end
   elseif nType == 21 then --精力
        if isWho == 1 then --增加
            SetHumanEnergy(sceneId, nHumanId, GetHumanEnergy(sceneId, nHumanId) + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "精力。")
            --记录日志
            LogStr =" 刷精力：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetHumanEnergy(sceneId, nHumanId, GetHumanEnergy(sceneId, nHumanId) - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "精力。")
        end
    elseif nType == 22 then  --传送地图
        if isWho == 99999 then
            isWho = sceneId
        end
        if isWho < 0 or isWho > 999 then
            PushDebugMessage(sceneId, selfId, "地图ID错误！")
            return
        end
        if arg2 < 0 or arg2 > 999 then
            PushDebugMessage(sceneId, selfId, "X坐标错误！")
            return
        end
        if arg4 < 0 or arg4 > 999 then
            PushDebugMessage(sceneId, selfId, "Y坐标错误！")
            return
        end
        --传送地图
        CallScriptFunction((400900), "TransferFunc", sceneId, nHumanId, isWho, arg2, arg4)
        --记录日志
        LogStr =" 刷传送：" ..GetName(sceneId, selfId) .."地图ID：[" ..isWho .."]，坐标[" ..arg2 .."," ..arg4 .."]给" ..GetName(sceneId, nHumanId) .."[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员把["..PlayerName.."]传送到新地图")
    elseif nType == 23 then --武道领悟点
        local VIPPOINT = LuaFnGetSectPoint(sceneId, nHumanId) --获取已有
        if isWho == 1 then --增加
            --总金额限制
            if VIPPOINT + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            LuaFnSetSectPoint(sceneId, nHumanId, VIPPOINT + arg2)
            x666666_TongZhi(sceneId,selfId,nHumanId, "游戏管理员给["..PlayerName.."]发放了" .. arg2 .. "武道领悟点。")
            --记录日志
            LogStr =" 刷武道领悟点：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            LuaFnSetSectPoint(sceneId, nHumanId, VIPPOINT - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "武道领悟点。")
        end
    elseif nType == 24 then --//技能
        if isWho == 1 then --增加
            AddSkill(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您学习了" .. arg2 .. "号技能。")
            --记录日志
            LogStr =" 加技能：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            DelSkill(sceneId, nHumanId, arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您删除了" .. arg2 .. "号技能。")
            --记录日志
            LogStr =" 删技能：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        end
		
	elseif nType == 25 then --道具扣除功能
        if isWho < 10000000 or isWho > 99999999 then
            PushDebugMessage(sceneId, selfId, "输入的道具ID不正确！")
            return
        end
		LuaFnDelAvailableItem(sceneId, nHumanId, isWho, arg2)
		x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员删除["..PlayerName.."]的"..arg2.."个" .. GetItemName(sceneId, isWho), 0)
    end
	
	
	--保存日志
	x666666_GMLog(sceneId, selfId, LogStr)
end

--**********************************
-- GM工具V2 2022-8-26 09:29:21
--**********************************
function x666666_GMToolTypeTwo(sceneId, selfId, nType, isWho, arg2, nHumanId, arg4, arg5)
    --异常数值判断
    if nType == nil or isWho == nil or arg2 == nil or nHumanId == nil then
        return
    end
    if nType < 0 or isWho < 0 or isWho < 0 or arg2 < 0 or nHumanId < 0 then
        return
    end
	
	--权限检查
    if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	if nHumanId == nil or nHumanId == -1 then
		nHumanId = selfId -- 参数异常，就直接给发自己
	end
	local LogStr = ""
    if nType == 25 then --原地生成BOSS
        --获取角色所在坐标
        local posX, posZ = LuaFnGetWorldPos(sceneId, selfId)
        if isWho == 1 then --增加怪物
            --异常终止
            if arg5 == nil then
                return
            end
           local MonsterID = LuaFnCreateMonster(sceneId, arg2, posX, posZ, nHumanId, arg4, arg5)
		   print(sceneId, arg2, posX, posZ, arg3, arg4, arg5)
            PushDebugMessage(sceneId, nHumanId, "创建BOSS成功。")
            --记录日志
            LogStr =" 刷BOSS：" ..GetName(sceneId, selfId) .. "刷取：[" .. arg2 .. "]给到地图：[" .. sceneId .. "] 坐标:[" .. posX .. ",",posZ .. "]成功"
        elseif isWho == 2 then --删除怪物
            local nMonsterNum = GetMonsterCount(sceneId)
            for i = 0, nMonsterNum - 1 do
                MonsterId = GetMonsterObjID(sceneId, i)
                local MosDataID = GetMonsterDataID(sceneId, MonsterId)
                if MosDataID == arg2 then
                    --清怪
                    LuaFnDeleteMonster(sceneId, MonsterId)
                end
            end
            PushDebugMessage(sceneId, nHumanId, "删除BOSS成功。")
        end
    elseif nType == 26 then
        
    elseif nType == 27 then
       
    elseif nType == 28 then --秘籍：武学心得
        --获取武学心得
        local pk_value = GetMissionDataEx(sceneId, nHumanId, MD_LILIAN)
        if isWho == 1 then --增加
            --总额限制
            if pk_value + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            SetMissionDataEx(sceneId, selfId, MD_LILIAN, pk_value + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您加了" .. arg2 .. "点武学心得。")
            --记录日志
            LogStr =" 刷心得：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetMissionDataEx(sceneId, selfId, MD_LILIAN, pk_value - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您扣除了" .. arg2 .. "点武学心得。")
        end
    elseif nType == 29 then 
        
    elseif nType == 30 then --契灵值
        local nQiLin = GetMissionData(sceneId, nHumanId, YUSHOU_QILING) --读取角色拥有的契灵值
        if isWho == 1 then --增加
            --总额限制
            if nQiLin + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            SetMissionData(sceneId, nHumanId, YUSHOU_QILING, nQiLin + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您增加了" .. arg2 .. "点契灵值。")
            --记录日志
            LogStr =" 刷契灵：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetMissionData(sceneId, nHumanId, YUSHOU_QILING, nQiLin - arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您减少了" .. arg2 .. "点契灵值。")
        end
    elseif nType == 31 then --功勋值
        local nMilitaryXiuWei = GetMissionData(sceneId, nHumanId, HXY_MILITARYXIUWEI) --读取角色拥有的功勋值
        if isWho == 1 then --增加
            --总额限制
            if nMilitaryXiuWei + arg2 > 2100000000 then
                PushDebugMessage(sceneId, selfId, "不可携带超过21亿，请缩减您输入的数值！")
                return
            end
            SetMissionData(sceneId, nHumanId, HXY_MILITARYXIUWEI, nMilitaryXiuWei + arg2)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您增加了" .. arg2 .. "点功勋值。")
            --记录日志
            LogStr =" 刷功勋：" ..GetName(sceneId, selfId) .."刷取：[" ..arg2 .."]给" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetMissionData(sceneId, selfId,nHumanId, HXY_MILITARYXIUWEI, nMilitaryXiuWei - arg2)
            x666666_TongZhi(sceneId, nHumanId, "游戏管理员给您减少了" .. arg2 .. "点功勋值。")
        end
    elseif nType == 32 then --斩杀目标
        LuaFnGmKillObj(sceneId, nHumanId, nHumanId)
        x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员成功斩杀目标。")
        --记录日志
        LogStr =" 杀死目标：" ..GetName(sceneId, selfId) .."杀死" .. GetName(sceneId, nHumanId) .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        
    elseif nType == 33 then --查询服务端GetMissionData值
        local DataValue = GetMissionData(sceneId, nHumanId, arg2) --读取角色拥有的功勋值
        if isWho == 1 then --查询
            PushDebugMessage(sceneId, nHumanId, "服务端值：" .. DataValue, 0)
            PushDebugMessage(sceneId, selfId, "服务端值：" .. DataValue, 0)
        elseif isWho == 2 then --修改
            x666666_TongZhi(sceneId, selfId,nHumanId, "服务端值修改前为：" .. DataValue .. "   修改后为：" .. arg4, 0)
            SetMissionData(sceneId, nHumanId, arg2, arg4)
        end
    elseif nType == 34 then --设置服务端和客户端的GetMissionDataEx值
        local DataValue = GetMissionDataEx(sceneId, nHumanId, arg2) --读取角色拥有的功勋值
        if isWho == 1 then --查询
            x666666_TongZhi(sceneId, selfId,nHumanId, "服务端Ex值：" .. DataValue, 0)
        elseif isWho == 2 then --修改
            x666666_TongZhi(sceneId, selfId,nHumanId,"服务端EX值修改前为：" .. DataValue .. "   修改后为：" .. arg4, 0)
            SetMissionDataEx(sceneId, nHumanId, arg2, arg4, 1)
        end
    elseif nType == 35 then --查询服务端和客户端的GetMissionFlag
        local DataValue = GetMissionFlag(sceneId, nHumanId, arg2) --读取角色拥有的功勋值
        if isWho == 1 then --查询
            x666666_TongZhi(sceneId, selfId,nHumanId, "GetMissionFlag值：" .. DataValue, 0)
        elseif isWho == 2 then --修改
            x666666_TongZhi(sceneId, selfId,nHumanId, "GetMissionFlag修改前为：" .. DataValue .. "   修改后为：" .. arg4, 0)
            SetMissionFlag(sceneId, nHumanId, arg2, arg4)
        end
    elseif nType == 36 then --查询服务端和客户端的GetWorldGlobalData值
        local DataValue = LuaFnGetWorldGlobalData(arg2) --读取角色拥有的功勋值
        if isWho == 1 then --查询
            x666666_TongZhi(sceneId,selfId,nHumanId, "LuaFnGetWorldGlobalData值：" .. DataValue, 0)
        elseif isWho == 2 then --修改
            x666666_TongZhi(sceneId, selfId,nHumanId, "LuaFnGetWorldGlobalData修改前为：" .. DataValue .. "   修改后为：" .. arg4, 0)
            LuaFnSetWorldGlobalData(arg2, arg4)
        end
    elseif nType == 37 then --设置全部心法等级
        local XinFaData = {
            [0] = {1, 2, 3, 4, 5, 6, 55, 72},
            [1] = {7, 8, 9, 10, 11, 12, 56, 73},
            [2] = {13, 14, 15, 16, 17, 18, 57, 74},
            [3] = {19, 20, 21, 22, 23, 24, 58, 75},
            [4] = {25, 26, 27, 28, 29, 30, 59, 76},
            [5] = {31, 32, 33, 34, 35, 36, 60, 77},
            [6] = {37, 38, 39, 40, 41, 42, 61, 78},
            [7] = {43, 44, 45, 46, 47, 48, 62, 79},
            [8] = {49, 50, 51, 52, 53, 54, 63, 80},
            [9] = {0, 0, 0, 0, 0, 0, 0, 0},
            [10] = {64, 65, 66, 67, 68, 69, 70, 71},
            [11] = {81, 82, 83, 84, 85, 86, 87, 88},
            [12] = {89, 90, 91, 92, 93, 94, 95, 96},
             --新增鬼谷
            [13] = {97, 98, 99, 100, 101, 102, 103, 104}, -- 新增桃花岛
            [14] = {105, 106, 107, 108, 109, 110, 111, 112} -- 新增绝情谷
        }
        local nMenPaiID = GetMenPai(sceneId, nHumanId)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][1], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][2], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][3], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][4], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][5], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][6], arg2)
        --后两本
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][7], arg2)
        LuaFnSetXinFaLevel(sceneId, nHumanId, XinFaData[nMenPaiID][8], arg2)
        x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员将您设置心法等级为：" .. arg2, 0)
    elseif nType == 38 then
	
    elseif nType == 39 then
	
    elseif nType == 40 then
	
    elseif nType == 41 then --培元点 前面记录培元数，【斗之书】后面四位每两位分别是技能编号和等级
        local PeiYuan = GetMissionData(sceneId, nHumanId, WUYI_SKILL_A)
        -- 抽取出技能编号和等级
        local skill_part = mod(PeiYuan, 10000)
        -- 取出原培元点
        local oldPeiYuan = floor(PeiYuan / 10000)
        if isWho == 1 then --增加
            -- 计算新的值：新的培元点乘以10000（即移动4位）然后加上技能编号和等级
            local new_value = (oldPeiYuan + arg2) * 10000 + skill_part
            SetMissionData(sceneId, nHumanId, WUYI_SKILL_A, new_value)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员将您设置培元点增加：" .. arg2, 0)
        else
            -- 计算新的值：新的培元点乘以10000（即移动4位）然后加上技能编号和等级
            if oldPeiYuan - arg2 < 0 then
                x666666_TongZhi(sceneId, selfId,nHumanId, "培元点不足以扣除：" .. arg2 .. "只剩下" .. oldPeiYuan, 0)
                return
            end
            local new_value = (oldPeiYuan - arg2) * 10000 + skill_part
            SetMissionData(sceneId, nHumanId, WUYI_SKILL_A, new_value)
            x666666_TongZhi(sceneId,selfId, nHumanId, "游戏管理员将您设置培元点设置为：" .. arg2, 0)
        end
    elseif nType == 42 then
	
    elseif nType == 43 then
	
    elseif nType == 44 then 
		print(isWho)
		if isWho == 1 then --查询
			print(arg2)
			local ibPower = LuaFnGetIBPower(sceneId, nHumanId);
			LuaFnSetIBPower(sceneId, nHumanId, ibPower + arg2);
			x666666_TongZhi(sceneId, selfId,nHumanId, "神工值增加" .. arg2.."点", 0)
		elseif isWho == 2 then --修改
			local ibPower = LuaFnGetIBPower(sceneId, nHumanId);
			LuaFnSetIBPower(sceneId, nHumanId, ibPower - arg2);
			x666666_TongZhi(sceneId, selfId,nHumanId, "神工值扣除" .. arg2.."点", 0)
		end
		
	elseif nType == 45 then 
		
	elseif nType == 46 then --查询服务端和客户端的GetMissionFlagEx
        local DataValue = GetMissionFlagEx(sceneId, nHumanId, arg2) --读取角色拥有的功勋值
        if isWho == 1 then --查询
            x666666_TongZhi(sceneId, selfId,nHumanId, "GetMissionFlagEx值：" .. DataValue, 0)
        elseif isWho == 2 then --修改
            x666666_TongZhi(sceneId, selfId,nHumanId, "GetMissionFlagEx修改前为：" .. DataValue .. "   修改后为：" .. arg4, 0)
            SetMissionFlagEx(sceneId, nHumanId, arg2, arg4)
        end
	elseif nType == 48 then 
		print(arg2)
		LuaFnGMForceDestroyGuildOffline(sceneId, 100000002, arg2)
    end
	x666666_GMLog(sceneId, selfId, LogStr)
end


function x666666_AddGlobalCountNews(sceneId, selfId,str)
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	AddGlobalCountNews(sceneId,str)
end

--**********************************
-- GM工具V3 2022-8-26 09:29:21
--**********************************
function x666666_GMToolTypeThree(sceneId, selfId, nType, isWho, arg2, nHumanId, arg4, arg5)
    --异常数值判断
    if nType == nil or isWho == nil or arg2 == nil or nHumanId == nil then
        return
    end
    if nType < 0 or nType > 200 or isWho < 0 or isWho < 0 or arg2 < 0 or nHumanId < 0 then
        return
    end
   --权限检查
    if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	-- nHumanId = selfId
    if nHumanId == nil or nHumanId < 0 then
		nHumanId = selfId -- 参数异常，就直接给发自己
	end
    if nType == 101 then --修炼
        if isWho == 1 then 
            for i = 0, 10 do
				LuaFnSetXiuLianMijiLevel(sceneId, nHumanId, i, 105)
			end
			x666666_TongZhi(sceneId, selfId, nHumanId, "游戏管理员给您设置了满修炼。")
        elseif isWho == 2 then --清空修炼
            LuaFnClearAllXiuLianMijiLevel(sceneId, nHumanId)
			CallScriptFunction(866010, "StartComputeHumanData", sceneId,selfId,1);
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您设置了清空了修炼。")
		elseif isWho == 3 then --设置指定秘籍等级
			if arg2 == nil or arg2 < 1 or arg2 > 11 then
				return
			end
			if arg4 == nil or arg4 < 0 or arg4 > 150 then
				return
			end
			local nMijiId = arg2 - 1  -- 下拉框1-based转0-based
			LuaFnSetXiuLianMijiLevel(sceneId, nHumanId, nMijiId, arg4)
			x666666_TongZhi(sceneId, selfId, nHumanId, "修炼秘籍[" .. nMijiId .. "]等级已设置为" .. arg4)
        end
    elseif nType == 102 then --武意
        if isWho == 1 then --满武意
            -- --先清空数据
            -- SetMissionData(sceneId, nHumanId, WUYI_1, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_2, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_3, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_4, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_5, 0)
            -- if arg2 == nil then
                -- arg2 = 1
            -- end
            -- if arg2 > 10 or arg2 < 1 then
                -- arg2 = 1
            -- end
            -- --设置新属性
            -- local attributes = {
                -- [1] = {WUYI_1, 0000786, "血上限。"},
                -- [2] = {WUYI_2, 7860000, "冰属性。"},
                -- [3] = {WUYI_2, 0000786, "火属性。"},
                -- [4] = {WUYI_3, 7860000, "玄属性。"},
                -- [5] = {WUYI_3, 0000786, "毒属性。"},
                -- [6] = {WUYI_4, 7860000, "命中属性。"},
                -- [7] = {WUYI_4, 0000786, "闪避属性。"},
                -- [8] = {WUYI_5, 7860000, "穿刺攻击。"},
                -- [9] = {WUYI_5, 0000786, "穿刺防御。"},
                -- [10] = {WUYI_5, 0870087, "平均分配属性。"}
            -- }
            -- if arg2 == 10 then --平均分配
                -- SetMissionData(sceneId, nHumanId, WUYI_1, 87)
                -- SetMissionData(sceneId, nHumanId, WUYI_2, attributes[arg2][2])
                -- SetMissionData(sceneId, nHumanId, WUYI_3, attributes[arg2][2])
                -- SetMissionData(sceneId, nHumanId, WUYI_4, attributes[arg2][2])
                -- SetMissionData(sceneId, nHumanId, WUYI_5, attributes[arg2][2])
            -- else
                -- SetMissionData(sceneId, nHumanId, attributes[arg2][1], attributes[arg2][2])
            -- end
            -- SetMissionData(sceneId, nHumanId, WUYI_LEVEL, 150 + GetDayTime() * 10000) --设置武意等级为满级
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您设置了满武意" , 0)
        elseif isWho == 2 then --清空武意
            -- SetMissionData(sceneId, nHumanId, WUYI_LEVEL, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_EXP, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_KILL_NUM, 0)
            -- SetMissionData(sceneId, nHumanId, MD_SHUANGBEISH, 0)
            -- SetMissionData(sceneId, nHumanId, MD_WYSHAGUAI, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_1, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_2, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_3, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_4, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_5, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_SKILL_A, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_SKILL_BC, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_SKILL_DE, 0)
            -- SetMissionData(sceneId, nHumanId, WUYI_SKILL_ITEM, 0)
            x666666_TongZhi(sceneId, selfId,nHumanId, "游戏管理员给您清空了全部武意数据。")
        end
    elseif nType == 103 then --清空经脉
        -- --清空经脉技能数据
        -- SetMissionData(sceneId, nHumanId, JINGMAI_POS_1, 0)
        -- SetMissionData(sceneId, nHumanId, JINGMAI_POS_2, 0)
        -- SetMissionData(sceneId, nHumanId, JINGMAI_POS_3, 0)
        -- SetMissionData(sceneId, nHumanId, JINGMAI_POS_4, 0)
        -- --删除技能
        -- local SkillId = {829,838,847,856,865,874,883,892,901,910,920,929,830,839,848,857,866,875,884,893,902,911,921,930,917,831,840,849,858,867,876,885,894,903,912,922,931,832,841,850,859,868,877,886,895,904,913,923,932,833,842,851,860,869,878,887,896,905,918,924,933,834,835,843,844,852,853,861,862,870,871,879,880,888,889,897,898,906,907,914,919,925,926,934,935,836,837,845,846,854,855,863,864,872,873,881,882,890,891,899,900,908,909,915,918,927,928,936,937}
        -- for i = 1, 109 do
            -- DelSkill(sceneId, nHumanId, SkillId[i])
        -- end
        x666666_TongZhi(sceneId, selfId,nHumanId, "所有进阶技能已经删除")
    elseif nType == 104 then
        if isWho == 1 then --//道具
            for i = GetBasicBagStartPos(sceneId, selfId), GetBasicBagEndPos(sceneId, selfId) do
                LuaFnEraseItem(sceneId, nHumanId, i)
            end
            x666666_TongZhi(sceneId, selfId,nHumanId, "道具栏清空完成")
        elseif isWho == 2 then --//材料
            for i = 100, 199 do
                LuaFnEraseItem(sceneId, nHumanId, i)
            end
            x666666_TongZhi(sceneId, selfId,nHumanId, "材料栏清空完成")
        elseif isWho == 3 then --//任务栏
            for i = 200, 220 do
                LuaFnEraseItem(sceneId, nHumanId, i)
            end
            x666666_TongZhi(sceneId, selfId,nHumanId, "任务栏清空完成")
        elseif isWho == 4 then --//清空全部MD
            for i = 0, 1471 do
                SetMissionData(sceneId, nHumanId, i, 0)
            end
            x666666_TongZhi(sceneId, selfId,nHumanId, "MD清空完成")
        elseif isWho == 5 then --//清空全部MDEX
            for i = 0, 1023 do
                SetMissionDataEx(sceneId, nHumanId, i, 0, 1)
            end
        elseif isWho == 6 then --//清空全部FLAG
            for i = 0, 5119 do
                SetMissionFlag(sceneId, nHumanId, i, 0)
            end
        elseif isWho == 7 then --//清空全部BUFF
			local count,lists = LuaFnGetBuffList(sceneId,nHumanId)
            for i = 1, count do
                LuaFnCancelSpecificImpact(sceneId, nHumanId, lists[i])
            end
		elseif isWho == 8 then --//清空全部FLAGEX
            for i = 0, 1279 do
                SetMissionFlagEx(sceneId, nHumanId, i, 0)
            end
        end
    end
end




--**********************************
-- GM工具使用记录 
-- GM工具_20220901 雪舞 新增日志功能
--**********************************
function x666666_GMLog(sceneId, selfId,str)
	local nowYear = GetTodayYear();
	local nowMonth = GetTodayMonth() + 1;
	local nowDate = GetTodayDate();
	local nHour	 = GetHour()
	local nMinute = GetMinute()
	local nName = GetName( sceneId, selfId )
	local nGuid = LuaFnGetGUID( sceneId, selfId)
	local HuamanID = LuaFnGetAccountName(sceneId,selfId)
	local handle = openfile("./PlayerLog/GMLog/GM_TOOLS_Log_"..nowYear..nowMonth..".txt", "a+")
	if nil ~= handle then
		write(handle,format("帐号：%s 名字:%s ID：%s \t %s \t时间：%s",HuamanID,nName,nGuid,str,tostring(nowYear * 10000 + nowMonth * 100 + nowDate).." "..nHour..":"..nMinute)..tostring("\n"))
		closefile(handle)
	end
end

--**********************************
--通知双方
--**********************************
function x666666_TongZhi(sceneId,selfId,nHumanId,nStr)
	if nHumanId == selfId then
		PushDebugMessage(sceneId, selfId, nStr)
	else
		PushDebugMessage(sceneId, selfId, nStr)
		PushDebugMessage(sceneId, nHumanId, nStr)
	end
end




--===================================================
-- GM工具 刷隐藏属性 (GameTools3客户端)
-- 客户端调用: Set_XSCRIPT_Function_Name("GMToolType")
-- nType 44~75: 单个属性增减
-- nType 76:    生效/取消/获取所有GM属性
-- 雪舞 2022-8-26
--===================================================

-- 属性MDEX索引列表 (顺序必须与客户端ATTR_CONFIG一致!)
-- 客户端编辑框522~553 -> 此表索引1~32
-- nType 44~75 -> 此表索引1~32 (nType - 43)
GM_ATTR_MDEX_LIST = {
    MDEX_MAX_HP,        -- [1]  血量
    MDEX_STR,           -- [2]  力量
    MDEX_SPR,           -- [3]  灵气
    MDEX_CON,           -- [4]  体力
    MDEX_INT,           -- [5]  定力
    MDEX_DEX,           -- [6]  身法
    MDEX_WG,            -- [7]  外功攻击
    MDEX_NG,            -- [8]  内功攻击
    MDEX_WF,            -- [9]  外功防御
    MDEX_NF,            -- [10] 内功防御
    MDEX_HUIXINGONG,    -- [11] 会心攻击
    MDEX_HUIXINFANG,    -- [12] 会心防御
    MDEX_ICE_ATTR,      -- [13] 冰攻
    MDEX_FIRE_ATTR,     -- [14] 火攻
    MDEX_LIGHT_ATTR,    -- [15] 玄攻
    MDEX_POSION_ATTR,   -- [16] 毒攻
    MDEX_ICE_DEC,       -- [17] 冰抗
    MDEX_FIRE_DEC,      -- [18] 火抗
    MDEX_LIGHT_DEC,     -- [19] 玄抗
    MDEX_POSION_DEC,    -- [20] 毒抗
    MDEX_ICE_SUB_DEC,   -- [21] 减冰抗
    MDEX_FIRE_SUB_DEC,  -- [22] 减火抗
    MDEX_LIGHT_SUB_DEC, -- [23] 减玄抗
    MDEX_POSION_SUB_DEC,-- [24] 减毒抗
    MDEX_ICE_SUB_LIMIT, -- [25] 减冰抗下限
    MDEX_FIRE_SUB_LIMIT,-- [26] 减火抗下限
    MDEX_LIGHT_SUB_LIMIT,--[27] 减玄抗下限
    MDEX_POSION_SUB_LIMIT,--[28]减毒抗下限
    MDEX_HIT,           -- [29] 命中
    MDEX_MISS,          -- [30] 闪避
    MDEX_CHUANCI_SH,    -- [31] 穿刺伤害
    MDEX_CHUANCI_JM,    -- [32] 穿刺减免
}

-- 属性名称列表 (用于日志和提示，顺序与上面一致)
GM_ATTR_NAME_LIST = {
    "血量","力量","灵气","体力","定力","身法",
    "外功攻击","内功攻击","外功防御","内功防御",
    "会心攻击","会心防御",
    "冰攻","火攻","玄攻","毒攻",
    "冰抗","火抗","玄抗","毒抗",
    "减冰抗","减火抗","减玄抗","减毒抗",
    "减冰抗下限","减火抗下限","减玄抗下限","减毒抗下限",
    "命中","闪避","穿刺伤害","穿刺减免",
}

--**********************************
-- GM工具 刷隐藏属性 主入口
-- 客户端 GameTools3 调用
-- Set_XSCRIPT_Function_Name("GMToolType")
-- Set_XSCRIPT_ScriptID(666666)
--**********************************
function x666666_GMToolType(sceneId, selfId, nType, isWho, arg2, GUID, arg4, arg5)
    --异常数值判断
    if nType == nil or isWho == nil then
        return
    end
    --权限检查
    if LuaFnIsAdminAccount(sceneId, selfId) == 0 then
        return
    end
	local nHumanId = LuaFnGuid2ObjId(sceneId,GUID)
    if nHumanId == nil or nHumanId == -1 then
        nHumanId = selfId
    end
	print(GetMissionDataEx(sceneId, selfId,MDEX_MAX_HP))
	
	print(sceneId, selfId, nType , isWho)
	
    local PlayerName = GetName(sceneId, nHumanId)
    local LogStr = ""

    if nType >= 44 and nType <= 75 then
        --========================================
        -- 单个属性增减 (nType 44~75)
        -- isWho: 1=增加 2=减少
        -- arg2: 数值
        --========================================
        if arg2 == nil or arg2 < 0 then
            return
        end
        local attrIndex = nType - 43
        local mdexId = GM_ATTR_MDEX_LIST[attrIndex]
        local attrName = GM_ATTR_NAME_LIST[attrIndex]
        if mdexId == nil then
            PushDebugMessage(sceneId, selfId, "属性索引超出范围")
            return
        end

        local curVal = GetMissionData(sceneId, nHumanId, mdexId)
        if curVal == nil then curVal = 0 end

        if isWho == 1 then --增加
            SetMissionDataEx(sceneId, nHumanId, mdexId, curVal + arg2)
            x666666_TongZhi(sceneId, selfId, nHumanId, "游戏管理员给["..PlayerName.."]增加了" .. arg2 .. "点" .. attrName .. "。")
            LogStr = " 刷属性：" .. GetName(sceneId, selfId) .. "刷取[" .. attrName .. "+" .. arg2 .. "]给" .. PlayerName .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        elseif isWho == 2 then --减少
            SetMissionDataEx(sceneId, nHumanId, mdexId, curVal - arg2)
            x666666_TongZhi(sceneId, selfId, nHumanId, "游戏管理员给["..PlayerName.."]扣除了" .. arg2 .. "点" .. attrName .. "。")
            LogStr = " 刷属性：" .. GetName(sceneId, selfId) .. "刷取[" .. attrName .. "-" .. arg2 .. "]给" .. PlayerName .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"
        end
		

    elseif nType == 76 then
        --========================================
        -- 生效/取消/获取 所有GM属性
        -- isWho: 1=生效 2=取消 3=获取属性值
        --========================================
        if isWho == 1 then 
            -- 生效: 遍历所有99999属性，应用GM加成到角色
            for i = 1, getn(GM_ATTR_MDEX_LIST) do
                local mdexId = GM_ATTR_MDEX_LIST[i]
				SetMissionDataEx(sceneId, nHumanId, mdexId, 99999)
            end
            x666666_TongZhi(sceneId, selfId, nHumanId, "游戏管理员给["..PlayerName.."]生效了所有GM属性。")
            LogStr = " 生效GM属性：" .. GetName(sceneId, selfId) .. "给" .. PlayerName .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"

        elseif isWho == 2 then
            -- 取消: 清除所有GM属性加成
            for i = 1, getn(GM_ATTR_MDEX_LIST) do
                local mdexId = GM_ATTR_MDEX_LIST[i]
                SetMissionDataEx(sceneId, nHumanId, mdexId, 0)
            end
            x666666_TongZhi(sceneId, selfId, nHumanId, "游戏管理员给["..PlayerName.."]取消了所有GM属性。")
            LogStr = " 取消GM属性：" .. GetName(sceneId, selfId) .. "给" .. PlayerName .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]成功"

        elseif isWho == 3 then
            -- 获取: 读取所有属性值，拼接逗号分隔字符串传回客户端
            -- 客户端通过 Get_XParam_STR(0) 接收，Split(str,",") 分割
            local str = ""
            for i = 1, getn(GM_ATTR_MDEX_LIST) do
                local val = GetMissionDataEx(sceneId, nHumanId, GM_ATTR_MDEX_LIST[i])
                if val == nil then val = 0 end
                if i > 1 then
                    str = str .. ","
                end
                str = str .. val
            end
            -- 字符串传输给客户端
            BeginUICommand(sceneId)
                UICommand_AddString(sceneId, str)
            EndUICommand(sceneId)
            DispatchUICommand(sceneId, nHumanId, 20220902)
            LogStr = " 获取GM属性：" .. GetName(sceneId, selfId) .. "查询" .. PlayerName .. "[GUID:" .. LuaFnGetGUID(sceneId, nHumanId) .. "]"
        end
    end
	
	
	CallScriptFunction(866010, "StartComputeHumanData", sceneId,selfId,1);
    --保存日志
    x666666_GMLog(sceneId, selfId, LogStr)
end
