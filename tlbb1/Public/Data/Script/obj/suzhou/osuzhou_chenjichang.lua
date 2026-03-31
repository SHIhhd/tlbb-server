--苏州NPC
--陈季常
--一般

--脚本号
x001024_g_scriptId = 001024

--所拥有的事件ID列表
x001024_g_eventList={
	889053, --向前冲
}

--**********************************
--事件列表
--**********************************
function x001024_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{OBJ_suzhou_0009}")
		AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130508_03}", 6, 1000)  --惊喜三连环
		for i, eventId in x001024_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001024_OnDefaultEvent( sceneId, selfId, targetId )
	x001024_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001024_OnEventRequest( sceneId, selfId, targetId, eventId )
	local n = GetNumText()
	if n == 1000 then
		-- 刷新周时间
		x001024_RefreshWeekTime( sceneId, selfId )
		
		BeginEvent(sceneId)
			AddText(sceneId, "#{JXSLH_130508_01}")
			AddText(sceneId, "#{JXSLH_130508_02}")
			AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130508_03}", 6, 100)  --惊喜三连环
			AddNumText(sceneId, x001024_g_scriptId, "累计抽奖奖励", 6, 200)
			AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130508_04}", 6, 110000)  --关于惊喜三连环
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	end
	
    if n == 100 then
        x001024_OpenSanLianHuan(sceneId, selfId, targetId)
	elseif n == 200 then
		-- 打开累计抽奖领奖界面
		x001024_ACC_ShowMenu(sceneId, selfId, targetId)
	
    elseif n == 110000 then
		-- 关于惊喜三连环
        BeginEvent(sceneId)
            AddText(sceneId, "#{JXSLH_130508_06}")
        EndEvent(sceneId)
        DispatchEventList(sceneId, selfId, targetId)
	elseif n == 0 then
		x001024_UpdateEventList( sceneId, selfId, targetId )
    end
	
	-- 领取奖励
	if n == 10100 then
		-- 二连累计领奖
		 x001024_ACC_ShowChooseReward(sceneId, selfId, targetId, 200)
	elseif n == 10200 then
		-- 三连累计领奖
		 x001024_ACC_ShowChooseReward(sceneId, selfId, targetId, 300)
	-- 二连选择：200+i
	elseif n >= 20001 and n <= 20099 then
		sel = n - 20000
		x001024_ACC_Claim(sceneId, selfId, 200, sel)
		x001024_ACC_ShowChooseReward(sceneId, selfId, targetId, 200)
	-- 三连选择：300+i
	elseif n >= 30001 and n <= 30099 then
		local sel2 = n - 30000
		x001024_ACC_Claim(sceneId, selfId, 300, sel2)
		x001024_ACC_ShowChooseReward(sceneId, selfId, targetId, 300)

	end
	
	for i, findId in x001024_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001024_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001024_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x001024_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001024_g_eventList do
		if missionScriptId == findId then
			x001024_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001024_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001024_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001024_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001024_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001024_OnDie( sceneId, selfId, killerId )

end


-- 次数/花费配置
SLH_MaxTime_1      = 10
SLH_DefaultTimes1  = 10
SLH_DefaultTimes2  = 999999   -- 客户端显示“不限次”，这里给大值
SLH_DefaultTimes3  = 999999



SLH_ACC_NEED = 80      -- 每80次可领一次
SLH_ACC_MAX  = 3       -- 每周期最多领3次

--========================================================
-- 累计奖励
--========================================================
SLH_ACC_REWARD_2 = {
	{ id = 20400050, num = 1, new = 0 },
	{ id = 20400051, num = 2, new = 0 },
	{ id = 20400052, num = 1, new = 1 },
	{ id = 20400053, num = 1, new = 1 },
}

SLH_ACC_REWARD_3 = {
	{ id = 20400054, num = 1, new = 0 },
	{ id = 20400055, num = 1, new = 1 },
	{ id = 20400056, num = 2, new = 1 },
	{ id = 20400057, num = 2, new = 1 },
}

SLH_Cost = {
    [1] = 5,
    [2] = 30,
    [3] = 500,
}

-- 花费类型
SLH_CostType = {
    [1] = "YUANBAO",
    [2] = "YUANBAO",
    [3] = "YUANBAO",
}

-- 奖池
SLH_Items = {
    [1] = {
        {id=20310101,num=2,new=0},
        {id=20310102,num=3,new=0},
        {id=20310103,num=4,new=0},
        {id=20310104,num=5,new=1},
        {id=20310105,num=6,new=1},
        {id=20310106,num=7,new=1},
        {id=20310107,num=8,new=1},
        {id=20310108,num=9,new=1},
    },
    [2] = {
        {id=20310109,num=5,new=0},
        {id=20310110,num=1,new=0},
        {id=20310111,num=1,new=0},
        {id=20310112,num=10,new=1},
        {id=20310113,num=1,new=1},
        {id=20310114,num=1,new=1},
        {id=20310115,num=1,new=1},
        {id=20310116,num=3,new=1},
    },
    [3] = {
        {id=20310165,num=1,new=0},
        {id=20310114,num=1,new=0},
        {id=20310114,num=1,new=0},
        {id=20310115,num=1,new=1},
        {id=20310169,num=1,new=1},
        {id=20310170,num=1,new=1},
        {id=20310171,num=1,new=1},
        {id=20310172,num=1,new=1},
    },
}

-- 每个档位(1/2/3) 对应 8 个奖品的概率（百分比）
-- 自己改数即可。总和100
SLH_Prob = {
	[1] = { 20, 15, 15, 10, 10, 10, 10, 10 },   -- pos=1
	[2] = { 30, 20, 15, 10, 10, 8, 5, 2  },     -- pos=2
	[3] = { 10, 20, 15, 40, 7, 5, 2, 1   },     -- pos=3
}

function x001024_SLH_GetWeightedIndex(pos)
	local probs = SLH_Prob[pos]
	if probs == nil then
		return random(1, 8)
	end
	local total = 0
	local i = 1
	while i <= 8 do
		local p = probs[i]
		if p == nil then p = 0 end
		if p < 0 then p = 0 end
		total = total + p
		i = i + 1
	end

	if total <= 0 then
		return random(1, 8)
	end

	if total < 100 then
		probs[8] = (probs[8] or 0) + (100 - total)
		total = 100
	end

	local r = random(1, total)
	local cum = 0
	local idx = 1
	while idx <= 8 do
		local p2 = probs[idx]
		if p2 == nil then p2 = 0 end
		if p2 < 0 then p2 = 0 end
		cum = cum + p2
		if r <= cum then
			return idx
		end
		idx = idx + 1
	end
	
	return 8
end

--========================================================
-- 每日重置次数
--========================================================
function x001024_SLH_InitIfNeed(sceneId, selfId)
	local today = GetTime2Day()
    local last = GetMissionDataEx(sceneId, selfId, MDEX_SLH_INITED)
    if last ~= today then
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_INITED, today)
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_1, SLH_DefaultTimes1)
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_2, SLH_DefaultTimes2)
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_3, SLH_DefaultTimes3)
    end
end

function x001024_SLH_GetTimes(sceneId, selfId, idx)
    if idx == 1 then
        return GetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_1)
    elseif idx == 2 then
        return GetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_2)
    elseif idx == 3 then
        return GetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_3)
    end
    return 0
end

function x001024_SLH_SetTimes(sceneId, selfId, idx, v)
    if idx == 1 then
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_1, v)
    elseif idx == 2 then
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_2, v)
    elseif idx == 3 then
        SetMissionDataEx(sceneId, selfId, MDEX_SLH_TIMES_3, v)
    end
end

--========================================================
-- 货币查询接口
--========================================================
function x001024_SLH_GetCurrency(sceneId, selfId, ctype)
    if ctype == "YUANBAO" then
        return YuanBao(sceneId, selfId, selfId, 3, 0)
    end
    return GetMoney(sceneId, selfId) + GetMoneyJZ(sceneId, selfId)
end

function x001024_SLH_DelCurrency(sceneId, selfId, ctype, amount)
    if amount <= 0 then
        return 1
    end
    if ctype == "YUANBAO" then
        local ret = LuaFnCostYuanBao(sceneId,selfId,amount,001024,"SLH_DelCurrency",0,-1); 
        if ret == nil then
            return 1
        end
        return ret
    end

    local ret2 = LuaFnCostMoneyWithPriority(sceneId, selfId, amount)
    if ret2 == nil then
        return 1
    end
    return ret2
end

--========================================================
-- 奖池打包为字符串：id,itemcn|id,itemcn|...
-- itemcn = num*10 + new
--========================================================
function x001024_SLH_BuildItemStr(pos)
    local s = ""
    local i = 1
    while SLH_Items[pos] and SLH_Items[pos][i] do
        local it = SLH_Items[pos][i]
        local itemcn = it.num * 10 + it.new
        if s ~= "" then
            s = s .. "|"
        end
        s = s .. it.id .. "," .. itemcn
        i = i + 1
    end
    return s
end

function x001024_SLH_BuildCostStr()
    return tostring(SLH_Cost[1]) .. "," .. tostring(SLH_Cost[2]) .. "," .. tostring(SLH_Cost[3])
end

--========================================================
-- 打开UI
--========================================================
function x001024_OpenSanLianHuan(sceneId, selfId, targetId)
    x001024_SLH_InitIfNeed(sceneId, selfId)

    local t1 = x001024_SLH_GetTimes(sceneId, selfId, 1)
    local t2 = x001024_SLH_GetTimes(sceneId, selfId, 2)
    local t3 = x001024_SLH_GetTimes(sceneId, selfId, 3)

    BeginUICommand(sceneId)
        UICommand_AddInt(sceneId, t1)   
        UICommand_AddInt(sceneId, t2)  
        UICommand_AddInt(sceneId, t3)   
        UICommand_AddInt(sceneId, targetId) 
		UICommand_AddString(sceneId, x001024_SLH_BuildItemStr(1))
        UICommand_AddString(sceneId, x001024_SLH_BuildItemStr(2))
        UICommand_AddString(sceneId, x001024_SLH_BuildItemStr(3))
        UICommand_AddString(sceneId, x001024_SLH_BuildCostStr())
    EndUICommand(sceneId)
    DispatchUICommand(sceneId, selfId, 20130513)
end

--========================================================
-- 抽奖入口
--========================================================
function x001024_MSOnAuguryEx(sceneId, selfId,pos)
    if pos < 1 or pos > 3 then
        x866010_Tips(sceneId, selfId, "三连环参数错误。")
        return 0
    end

    x001024_SLH_InitIfNeed(sceneId, selfId)

    local times = x001024_SLH_GetTimes(sceneId, selfId, pos)
    if times <= 0 then
        x866010_Tips(sceneId, selfId, "今日次数不足。")
        return 0
    end

    local cost  = SLH_Cost[pos]
    local ctype = SLH_CostType[pos]

    local nowMoney = x001024_SLH_GetCurrency(sceneId, selfId, ctype)
    if nowMoney < cost then
        x866010_Tips(sceneId, selfId, "货币不足，无法抽取。")
        return 0
    end

    -- 抽奖概率
    local idx = x001024_SLH_GetWeightedIndex(pos)
    local it = SLH_Items[pos][idx]
    if it == nil or it.id <= 0 or it.num <= 0 then
        x866010_Tips(sceneId, selfId, "奖池配置异常。")
        return 0
    end

    -- 先检查背包空间
    BeginAddItem(sceneId)
        AddItem(sceneId, it.id, it.num)
        local ret = EndAddItem(sceneId, selfId)
        if ret <= 0 then
            x866010_Tips(sceneId, selfId, "背包空间不足，请先清理背包。")
            return 0
        end
    local delOk = x001024_SLH_DelCurrency(sceneId, selfId, ctype, cost)
    if delOk ~= 1 then
        x866010_Tips(sceneId, selfId, "扣费失败，请稍后再试。")
        return 0
    end

    -- 扣抽奖次数
    x001024_SLH_SetTimes(sceneId, selfId, pos, times - 1)
    -- 发放奖励
    AddItemListToHuman(sceneId, selfId)
	
	--累计抽奖次数 +1
	x001024_ACC_AddDraw(sceneId, selfId, pos, 1)

    -- 发送给客户端点亮 + 更新次数
    local t1 = x001024_SLH_GetTimes(sceneId, selfId, 1)
    local t2 = x001024_SLH_GetTimes(sceneId, selfId, 2)
    local t3 = x001024_SLH_GetTimes(sceneId, selfId, 3)

    BeginUICommand(sceneId)
        UICommand_AddInt(sceneId, pos)   
        UICommand_AddInt(sceneId, t1)     
        UICommand_AddInt(sceneId, t2)     
        UICommand_AddInt(sceneId, t3)     
        UICommand_AddInt(sceneId, it.id)  
        UICommand_AddInt(sceneId, it.num) 
    EndUICommand(sceneId)
    DispatchUICommand(sceneId, selfId, 20130514)

    -- 稀有公告（new==1）
    if it.new == 1 then
        local playerName = GetName(sceneId, selfId)
        local nItemBagIndex = GetBagPosByItemSn(sceneId, selfId, it.id)
        local szTranItm = GetBagItemTransfer(sceneId, selfId, nItemBagIndex)
        local msg = "#P恭喜玩家#{_INFOUSR" .. playerName .."}#P在#G三连环#P中获得#G#{_INFOMSG"..szTranItm.."}#P！"
        BroadMsgByChatPipe(sceneId, selfId, msg, 4)
    end

	-- 刷新周时间
	x001024_RefreshWeekTime( sceneId, selfId )
	
    return 1
end


--玩家新的一周刷新数据 (604800)
function x001024_RefreshWeekTime( sceneId, selfId )
	local NewWeek = GetMissionDataEx(sceneId,selfId,MDEX_SLH_WEEK)
	local nCurrentTime = LuaFnGetCurrentTime()
	if NewWeek == nil or NewWeek == 0 or (nCurrentTime - NewWeek) >= 604800 then 
		--记录刷新时间
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_WEEK,nCurrentTime)
		--重置累计抽奖&领取记录
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_2_DRAW, 0)
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_2_CLAIM,0)
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_3_DRAW, 0)
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_3_CLAIM,0)
	end
end
	
	

--========================================================
-- 累计抽奖
--========================================================
function x001024_ACC_GetMaxCanClaim(totalDraw)
	-- 可领取次数 = floor(total/80)，但最多3次
	if totalDraw == nil then totalDraw = 0 end
	local can = floor(totalDraw / SLH_ACC_NEED)
	if can > SLH_ACC_MAX then
		can = SLH_ACC_MAX
	end
	return can
end

function x001024_ACC_BuildText(sceneId, selfId)
	local draw2  = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_DRAW)
	local claim2 = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_CLAIM)
	local draw3  = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_DRAW)
	local claim3 = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_CLAIM)

	if draw2 == nil then draw2 = 0 end
	if claim2 == nil then claim2 = 0 end
	if draw3 == nil then draw3 = 0 end
	if claim3 == nil then claim3 = 0 end

	local max2 = x001024_ACC_GetMaxCanClaim(draw2)
	local max3 = x001024_ACC_GetMaxCanClaim(draw3)
	
	local t2 = ScriptGlobal_Format("#{JXSLH_130526_20}", tostring(draw2), tostring(max2), tostring(claim2))
	local t3 = ScriptGlobal_Format("#{JXSLH_130526_22}", tostring(draw3), tostring(max3), tostring(claim3))

	return t2, t3
end

-- JXSLH_130526_20	    您在#G月华二连环#W中抽奖次数已经达到#G%s0#W次，最多可领取#Y奖励#G%s1#W个，已经领取#Y奖励#W#G%s2#W个。
-- JXSLH_130526_22	    您在#G日耀三连环#W中抽奖次数已经达到#G%s0#W次，最多可领取#Y奖励#G%s1#W个，已经领取#Y奖励#W#G%s2#W个。
-- JXSLH_130526_06	二连环领奖
-- JXSLH_130526_07	三连环领奖
-- JXSLH_130508_07	返回上一页
function x001024_ACC_ShowMenu(sceneId, selfId, targetId)

	x001024_RefreshWeekTime( sceneId, selfId,targetId )
	
	local t2, t3 = x001024_ACC_BuildText(sceneId, selfId)
	-- 计算下次重置剩余时间
	local nNow = LuaFnGetCurrentTime()
	local nWeek = GetMissionDataEx(sceneId, selfId, MDEX_SLH_WEEK)
	if nWeek == nil or nWeek == 0 then
		nWeek = nNow
	end
	local nNext = nWeek + 604800
	local nLeft = nNext - nNow
	if nLeft < 0 then
		nLeft = 0
	end

	-- 拆成 天/小时/分钟
	local nDay = floor(nLeft / 86400)
	local nLeft2 = mod(nLeft, 86400)
	local nHour = floor(nLeft2 / 3600)
	local nLeft3 = mod(nLeft2, 3600)
	local nMin = floor(nLeft3 / 60)

	-- 组装提示文本
	local szResetTip = "#G小提醒:#W 每个项目每7天最多领取#Y3次#W。#P下次重置倒计时：#G" .. tostring(nDay) .. "天" .. tostring(nHour) .. "小时" .. tostring(nMin) .. "分#W。"
		
	BeginEvent(sceneId)
		AddText(sceneId, t2)
		AddText(sceneId, t3)
		AddText(sceneId, szResetTip)
		AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130526_06}", 6, 10100) -- 二连环领奖
		AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130526_07}", 6, 10200) -- 三连环领奖
		AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130508_07}", 8, 0)   -- 返回上一页
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--========================================================
-- 累计抽奖：领取
-- kind=2 二连，kind=3 三连
--========================================================
function x001024_ACC_Claim(sceneId, selfId, kind, selIndex)
	draw = 0
	claimed = 0

	if kind == 200 then
		draw = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_DRAW)
		claimed = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_CLAIM)
	else
		draw = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_DRAW)
		claimed = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_CLAIM)
	end
	if draw == nil then draw = 0 end
	if claimed == nil then claimed = 0 end

	maxCan = x001024_ACC_GetMaxCanClaim(draw)

	if maxCan <= 0 then
		x866010_Tips(sceneId, selfId, "累计次数不足，暂不可领取。")
		return 0
	end
	if claimed >= maxCan then
		x866010_Tips(sceneId, selfId, "您可领取的奖励已全部领取完毕。")
		return 0
	end

	list = x001024_ACC_GetRewardList(kind)
	if list == nil then
		x866010_Tips(sceneId, selfId, "奖励列表配置为空。")
		return 0
	end

	if selIndex == nil or selIndex <= 0 then
		x866010_Tips(sceneId, selfId, "请选择要领取的奖励。")
		return 0
	end

	it = list[selIndex]
	if it == nil or it.id == nil or it.id <= 0 or it.num == nil or it.num <= 0 then
		x866010_Tips(sceneId, selfId, "选择的奖励配置异常。")
		return 0
	end

	-- 背包空间检查 & 发放
	BeginAddItem(sceneId)
		AddItem(sceneId, it.id, it.num)
		ret = EndAddItem(sceneId, selfId)
		if ret <= 0 then
			x866010_Tips(sceneId, selfId, "背包空间不足，请先清理背包。")
			return 0
		end
	AddItemListToHuman(sceneId, selfId)

	-- 记录领取+1
	if kind == 200 then
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_2_CLAIM, claimed + 1)
	else
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_3_CLAIM, claimed + 1)
	end

	x866010_Tips(sceneId, selfId, "累计奖励领取成功！")

	-- 可选：稀有公告（new==1）
	if it.new == 1 then
		playerName = GetName(sceneId, selfId)
		nItemBagIndex = GetBagPosByItemSn(sceneId, selfId, it.id)
		szTranItm = GetBagItemTransfer(sceneId, selfId, nItemBagIndex)
		msg = "#P恭喜玩家#{_INFOUSR" .. playerName .. "}#P在#G累计领奖#P中获得#G#{_INFOMSG" .. szTranItm .. "}#P！"
		BroadMsgByChatPipe(sceneId, selfId, msg, 4)
	end

	return 1
end

--========================================================
-- 累计抽奖：加次数（供二连/三连抽奖时调用）
-- kind=2 二连，kind=3 三连
--========================================================
function x001024_ACC_AddDraw(sceneId, selfId, kind, addv)
	if addv == nil then addv = 1 end
	if addv <= 0 then 
		return 
	end

	if kind == 200 then
		local v = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_DRAW)
		if v == nil then v = 0 end
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_2_DRAW, v + addv)
	elseif kind == 300 then
		local v2 = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_DRAW)
		if v2 == nil then v2 = 0 end
		SetMissionDataEx(sceneId,selfId,MDEX_SLH_3_DRAW, v2 + addv)
	end
end

function x001024_ACC_GetRewardList(kind)
	if kind == 200 then
		return SLH_ACC_REWARD_2
	end
	if kind == 300 then
		return SLH_ACC_REWARD_3
	end
	return nil
end

function x001024_ACC_ShowChooseReward(sceneId, selfId, targetId, kind)
	-- 读取累计信息
	local draw = 0
	local claimed = 0
	if kind == 200 then
		draw = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_DRAW)
		claimed = GetMissionDataEx(sceneId,selfId,MDEX_SLH_2_CLAIM)
	else
		draw = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_DRAW)
		claimed = GetMissionDataEx(sceneId,selfId,MDEX_SLH_3_CLAIM)
	end
	if draw == nil then draw = 0 end
	if claimed == nil then claimed = 0 end
	local maxCan = x001024_ACC_GetMaxCanClaim(draw)

	local list = x001024_ACC_GetRewardList(kind)
	if list == nil then
		x866010_Tips(sceneId, selfId, "奖励列表配置为空。")
		return
	end

	BeginEvent(sceneId)
		if kind == 200 then
			AddText(sceneId, "#G二连环累计领奖 - 请选择一个奖励#W")
		else
			AddText(sceneId, "#G三连环累计领奖 - 请选择一个奖励#W")
		end
		AddText(sceneId, "累计次数："..tostring(draw).."；最多可领："..tostring(maxCan).."；已领取："..tostring(claimed))
		i = 1
		while list[i] do
			it = list[i]
			if it.id ~= nil and it.id > 0 and it.num ~= nil and it.num > 0 then
				local itName = GetItemName(sceneId, it.id)
				-- 事件号：二连 200+i，三连 300+i
				if kind == 200 then
					AddNumText(sceneId, x001024_g_scriptId, "领取："..itName.." x"..tostring(it.num), 6, 20000 + i)
				else
					AddNumText(sceneId, x001024_g_scriptId, "领取："..itName.." x"..tostring(it.num), 6, 30000 + i)
				end
			end
			i = i + 1
		end

		AddNumText(sceneId, x001024_g_scriptId, "#{JXSLH_130508_07}", 8, 200) -- 返回累计界面（用2代表回去）
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--========================================================
-- 提示
--========================================================
function x866010_Tips(sceneId, selfId, msg)
    BeginEvent(sceneId)
        AddText(sceneId, msg)
    EndEvent(sceneId)
    DispatchMissionTips(sceneId, selfId)
end