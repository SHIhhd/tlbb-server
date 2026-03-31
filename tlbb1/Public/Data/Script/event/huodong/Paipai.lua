-- 幸运拍拍 2025Q4运营活动-幸运天使
-- 雪舞制作@WAYLEE

-- 脚本号
x339103_g_ScriptId = 339103

--拍拍锤子ID
x339103_g_PaiPaiChuiZi = 30504640

--奖品信息设置
PaipaiItemNum 	= "1,2,3,1,1,1,1,1" --物品数量
PaipaiLowLimit 	= "00,16,26,30,41,46,51,56" --数字范围1
PaipaiUpLimit 	= "15,25,29,40,45,50,55,60" --数字范围2
PaipaiItem 		= "20310157,20310158,20310159,20310165,20310168,20310101,20310102,20310105" --物品ID
PaipaiTX 		= "0,0,0,0,0,1,1,1" --是否显示稀有物品特效
-- 定义奖品的概率(全部相加总和为100)
itemProbabilities = {19.979, 10.000, 10.000, 20.000, 12.000, 28.000, 0.020, 0.001} 
--**********************************
-- 打开抽奖界面
--**********************************
function x339103_OpenPaiPai(sceneId, selfId)
	BeginUICommand(sceneId)
		--奖品数量
		UICommand_AddString(sceneId,PaipaiItemNum);
		--范围一
		UICommand_AddString(sceneId,PaipaiLowLimit);
		--范围二
		UICommand_AddString(sceneId,PaipaiUpLimit);
		--奖品ID
		UICommand_AddString(sceneId,PaipaiItem) 
		--稀有度
		UICommand_AddString(sceneId,PaipaiTX);
	EndUICommand( sceneId )
	DispatchUICommand(sceneId,selfId, 20130427)
end

--**********************************
-- 抽奖前判断
--**********************************
function x339103_CheckRightTime(sceneId, selfId, param1)
	if param1 ~= 1 and param1 ~= 0 then
		return
	end
	--检查上次奖品领取了吗
	if GetMissionDataEx(sceneId, selfId,MDEX_XINGYUN_PAIPAI) > 0 then
		x339103_NotifyTip(sceneId, selfId, "请先领取上一轮奖品。")
		return
	end
	
	--检查是否有拍拍锤子
	local nNum = LuaFnGetAvailableItemCount(sceneId, selfId, x339103_g_PaiPaiChuiZi)
	if nNum < 1 then
		x339103_NotifyTip( sceneId, selfId,"您的拍拍锤子数量不足。")       
		return 0
	end
	
	--开始疯狂摇数字
	if param1 == 0 then
		DispatchUICommand(sceneId,selfId, 20130508)
		x339103_NotifyTip(sceneId, selfId, "开始抽取数字，按停止按钮进行开奖。")
	elseif param1 == 1 then
		--开始抽奖
		x339103_StartLottery(sceneId, selfId)
	end
	
end

--**********************************
-- 正式抽奖
--**********************************
function x339103_StartLottery(sceneId, selfId)
	
	--扣除道具
	local ret = LuaFnDelAvailableItem(sceneId, selfId, x339103_g_PaiPaiChuiZi, 1)
	if ret ~= 1 then
		x339103_NotifyTip( sceneId, selfId,"拍拍锤子扣除失败，请检查是否锁定。")       
		return 0 
	end
	
	-- 计算概率总和并添加填充概率以确保总和为100
	local totalProbability = 0
	for i = 1, getn(itemProbabilities) do
		totalProbability = totalProbability + itemProbabilities[i]
	end
	local fillProbability = 100 - totalProbability
	tinsert(itemProbabilities, fillProbability)
	
    local rand = random(100)

	-- 确定奖品位置
	local prizePosition = 1
	local cumulativeProbability = 0
	local i = 1
	while itemProbabilities[i] do
		cumulativeProbability = cumulativeProbability + itemProbabilities[i]
		if rand <= cumulativeProbability then
			prizePosition = i
			break
		end
		i = i + 1
	end
	
	-- 奖品位置范围
	local lowLimits = SimpleParseStringToNumberArray(PaipaiLowLimit)
	local upLimits = SimpleParseStringToNumberArray(PaipaiUpLimit)
	local lowLimit = lowLimits[prizePosition]
    local upLimit = upLimits[prizePosition]

	-- 生成符合范围的随机数字
    local num1, num2, num3 = 0, 0, 0
	local ok = 0
	local try = 0
    while ok == 0 do
		try = try + 1
        num1 = random(0, 20)
        num2 = random(0, 20)
        num3 = random(0, 20)
        local sum = num1 + num2 + num3
        if sum >= lowLimit and sum <= upLimit then
			ok = 1
		elseif try > 5000 then
			ok = 1
		end
    end

	-- 如果没有找到有效位置，设置为默认位置
    if prizePosition == 0 then
        prizePosition = 1
    end
	print(prizePosition)
    -- 将抽奖结果发送给客户端
    BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, prizePosition) -- 奖品的位置
		UICommand_AddInt(sceneId, num1) -- 数字1
		UICommand_AddInt(sceneId, num2) -- 数字2
		UICommand_AddInt(sceneId, num3) -- 数字3
    EndUICommand(sceneId)
    DispatchUICommand(sceneId, selfId, 20130428) -- 通知客户端抽奖结果
	
	--记录奖品数据
	SetMissionDataEx(sceneId, selfId,MDEX_XINGYUN_PAIPAI,prizePosition)
end

--**********************************
-- 解析字符串为数字数组
--**********************************
function SimpleParseStringToNumberArray(str)
    local nums = {}
    local number = ""
    for i = 1, strlen(str) do
        local nChar = strsub(str, i, i)
        if nChar == ',' then
            if number ~= "" then
                tinsert(nums, tonumber(number))
                number = ""
            end
        else
            number = number .. nChar
        end
    end
    if number ~= "" then
        tinsert(nums, tonumber(number))
    end
    return nums
end

--**********************************
-- 发放奖品
--**********************************
function x339103_GiveItem(sceneId, selfId)
	local Index = GetMissionDataEx(sceneId, selfId,MDEX_XINGYUN_PAIPAI)
	if Index > 8 then
		SetMissionDataEx(sceneId, selfId, MDEX_XINGYUN_PAIPAI, 0)
		x339103_NotifyTip(sceneId, selfId, "领奖数据异常，已重置，请重新抽奖。")
		return
	end
	if Index < 1 then
		x339103_NotifyTip(sceneId, selfId, "您目前没有奖品等待领取。")
		return
	end
	
	--字符串转数组
	local ItemID = SimpleParseStringToNumberArray(PaipaiItem)
	local ItemNum= SimpleParseStringToNumberArray(PaipaiItemNum)
	local ItemXiyou = SimpleParseStringToNumberArray(PaipaiTX)

	if tonumber(ItemID[Index]) <= 0 or tonumber(ItemNum[Index]) <= 0 then
		SetMissionDataEx(sceneId, selfId, MDEX_XINGYUN_PAIPAI, 0, 1)
		x339103_NotifyTip(sceneId, selfId, "奖品配置异常，已重置。")
		return
	end
	
	-- 发放奖品给用户
	BeginAddItem(sceneId);
		AddItem(sceneId,ItemID[Index],ItemNum[Index]);
		local ret = EndAddItem(sceneId,selfId)
		if ret <= 0 then
			x339103_NotifyTip(sceneId, selfId, "背包空间不足，请先清理出空间再领取奖励。")
			return
		end
	AddItemListToHuman(sceneId,selfId);
	local prizeName = GetItemName(sceneId,ItemID[Index])
	--清空奖品数据
	SetMissionDataEx(sceneId, selfId,MDEX_XINGYUN_PAIPAI,0)
    x339103_NotifyTip(sceneId, selfId, "奖品领取成功，获得："..prizeName)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)

	--发送公告（仅稀有物品）
	-- if ItemXiyou[Index] == 1 then
		local nItemBagIndex = GetBagPosByItemSn(sceneId, selfId, ItemID[Index]);
		local szTranItm = GetBagItemTransfer( sceneId, selfId, nItemBagIndex )
		local playerName = GetName(sceneId, selfId)
		local singleStr = "#P恭喜玩家#{_INFOUSR" .. playerName .."}#P在#G幸运拍拍#P中使用#G拍拍锤子#P拍到了#G#{_INFOMSG"..szTranItm.."}#P！恭喜！"
		BroadMsgByChatPipe(sceneId, selfId, singleStr, 4)
	-- end
end

--**********************************
--事件交互入口
--**********************************
function x339103_OnDefaultEvent( sceneId, selfId,targetId )
	local PlayerGender = GetSex( sceneId, selfId )
	local rank
	if PlayerGender == 0 then
		rank = "侠女"
	else
		rank = "少侠"
	end
	BeginEvent(sceneId)
		AddText(sceneId, "   "..GetName(sceneId, selfId)..rank.."欢迎来进行幸运拍拍！")
		AddNumText(sceneId, x339103_g_ScriptId, "#{PAIPAI_05}", 6, 1)
		AddNumText(sceneId, x339103_g_ScriptId, "#{PAIPAI_06}", 6, 2)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x339103_OnEventRequest( sceneId, selfId, targetId, eventId)
	local nNum = GetNumText()
	if nNum == 1 then
		x339103_OpenPaiPai(sceneId, selfId)
	elseif nNum == 2 then 
		BeginEvent(sceneId)
			AddText(sceneId, "#{PAIPAI_04}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--醒目提示
--**********************************
function x339103_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end