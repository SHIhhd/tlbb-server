--兽魂生
x792006_g_scriptId = 792006
--活动开始及截止时间（间隔7天）
x792006_g_BeginTime = 20241024
x792006_g_EndTime = 20241106
--活动参与最低等级
x792006_g_MinLevel = 15

x792006_g_FeelFeedBack300_PrizeList =
{
	[1] ={
			[1]={ItemID = 38002492, num = 1, needbind =1,},		-- 仙侣情缘礼包（稀有3选1,15天）	
			[2]={ItemID = 30501361, num = 3, needbind =1,},		-- 功力丹	
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[2] ={
			[1]={ItemID = 30900045, num = 1, needbind =1,},		-- 天罡强化露	
			[2]={ItemID = 30502002, num = 3, needbind =1,},		-- 高级根骨丹	
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[3] ={
			[1]={ItemID = 38002493, num = 1, needbind =1,},		-- 月云湮落礼包（坐骑4选1）	
			[2]={ItemID = 30008114, num = 1, needbind =1,},		-- 黄金马鞍
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[4] ={
			[1]={ItemID = 30008048, num = 1, needbind =1,},		-- 金刚锉
			[2]={ItemID = 30503133, num = 3, needbind =1,},		-- 千淬神玉
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	
			},
	[5] ={
			[1]={ItemID = 20310168, num = 20,needbind =1,},		-- 金蚕丝	
			[2]={ItemID = 38002530, num = 5, needbind =1,},		-- 升魂丹
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	
			},
	[6] ={
			[1]={ItemID = 30700241, num = 3, needbind =1,},		-- 回天神石	
			[2]={ItemID = 20502003, num = 1, needbind =1,},		-- 3级秘银
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[7] ={
			[1]={ItemID = 50313004, num = 1, needbind =1,},		-- 红宝石3级	
			[2]={ItemID = 20501003, num = 1, needbind =1,},		-- 3级棉布
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
};
x792006_g_FeelFeedBack300_BagSize = {
	[1] = {3,0},
	[2] = {3,0},
	[3] = {3,0},
	[4] = {3,0},
	[5] = {1,2},
	[6] = {2,1},
	[7] = {1,2},
};
-----------------------------------------------
--检测是否已经领取完毕数据
-----------------------------------------------
function x792006_CheckGetFullPrize(sceneId,selfId)
	--根据策划情况，不打到15级，这里不显示。
	if GetLevel(sceneId,selfId) < x792006_g_MinLevel then
		return
	end
	--基本时间要求
	local nCurSrvTime = GetTime2Day()
	if nCurSrvTime < x792006_g_BeginTime or nCurSrvTime > x792006_g_EndTime then
		return
	end
	--计算登录的第几天
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME)
	if floor(nTime/100) ~= nCurSrvTime then
		nTime = nCurSrvTime * 100 + mod(nTime,100) + 1
		SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME,nTime)
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME_DATA)
	
	local nGetLingQu = 0;
	local nTab = {}
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	BeginUICommand(sceneId)
		if nGetLingQu >= 7 then
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
		else
			UICommand_AddInt(sceneId,1)
			if nGetLingQu < mod(nTime,100) then
				UICommand_AddInt(sceneId,1)
			else
				UICommand_AddInt(sceneId,0)
			end
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,79200601)
end
-----------------------------------------------
--领取奖励事件
-----------------------------------------------
function x792006_GetPrize(sceneId,selfId,nClick)
	--检测玩家登录日期，如果是活动日期内，显示，不是的话直接返回
	--基本时间要求
	local nCurSrvTime = GetTime2Day()
	if nCurSrvTime < x792006_g_BeginTime or nCurSrvTime > x792006_g_EndTime then
		x792006_NotifySystemMsg(sceneId,selfId,"#{QRDL_20211229_22}")
	    return
	end
	if GetLevel(sceneId,selfId) < x792006_g_MinLevel then
		x792006_NotifySystemMsg(sceneId,selfId,"#{QRDL_20211229_21}")
	    return
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME_DATA)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[nClick] == 1 then
	    x792006_NotifySystemMsg(sceneId,selfId,"#{QHKG_210329_24}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME)
	if nClick > mod(nTime,100) then
		x792006_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_23}",nClick))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < x792006_g_FeelFeedBack300_BagSize[nClick][1] then
		x792006_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_24}",x792006_g_FeelFeedBack300_BagSize[nClick][1]))
		return
	end
	if nMaterialSize < x792006_g_FeelFeedBack300_BagSize[nClick][2] then
		x792006_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_25}",x792006_g_FeelFeedBack300_BagSize[nClick][2]))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,3 do
			AddBindItem(sceneId,x792006_g_FeelFeedBack300_PrizeList[nClick][i].ItemID,x792006_g_FeelFeedBack300_PrizeList[nClick][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x792006_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_20211229_24}",
			x792006_g_FeelFeedBack300_BagSize[nClick][1]
		))
		x792006_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_20211229_25}",
			x792006_g_FeelFeedBack300_BagSize[nClick][2]
		))
		return
	end
	--给物品了
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	-- for i = 1,getn(x792006_g_FeelFeedBack300_PrizeList[nClick]) do
	    -- for j = 1,x792006_g_FeelFeedBack300_PrizeList[nClick][i].num do
		    -- local nPos = TryRecieveItem( sceneId,selfId,x792006_g_FeelFeedBack300_PrizeList[nClick][i].ItemID, 1)
			-- if nPos == -1 then
				-- x792006_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_25}",
					-- x792006_g_FeelFeedBack300_BagSize[nClick][1]
				-- ))
				-- x792006_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_26}",
					-- x792006_g_FeelFeedBack300_BagSize[nClick][2]
				-- ))
				-- return
			-- end
			-- LuaFnItemBind(sceneId,selfId,nPos)
		-- end
	-- end
	--醒目提示
	for i = 1,3 do
		x792006_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_20211229_26}",
			x792006_g_FeelFeedBack300_PrizeList[nClick][i].num,
			GetItemName(sceneId,x792006_g_FeelFeedBack300_PrizeList[nClick][i].ItemID)
		))
	end
	--布灵布灵
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
    --领取数据写入
	nTab[nClick] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME_DATA)
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	x792006_CheckGetFullPrize(sceneId,selfId)
	x792006_OnOpenMainWindow(sceneId,selfId) --重新呼出界面
end
-----------------------------------------------
--打开七日豪礼UI面板
-----------------------------------------------
function x792006_OnOpenMainWindow(sceneId,selfId)
	--登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
	CallScriptFunction(888890, "OnPlayerLogin", sceneId,selfId)
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK600TIME_DATA)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)--1打开 2刷新
		UICommand_AddInt(sceneId,nTime)		--登录的第几天
		UICommand_AddInt(sceneId,nLingQu)	--领取情况
		UICommand_AddInt(sceneId,x792006_g_EndTime)--截止日期
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 79200602)
end

function x792006_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


