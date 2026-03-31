--长昼萧然考古守
x791005_g_scriptId = 791005

x791005_g_FeelFeedBack200_PrizeList =
{
	[1] ={
			[1]={ItemID = 38002218, num = 1, needbind =1,},		-- 蝶舞流芳礼包（稀有3选1,15天）	1	38002218
			[2]={ItemID = 30501361, num = 3, needbind =1,},		-- 功力丹	3	30501361　	　
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	38000060　	　
			},
	[2] ={
			[1]={ItemID = 30900045, num = 1, needbind =1,},		-- 天罡强化露	1	30900045　	
			[2]={ItemID = 30502002, num = 3, needbind =1,},		-- 高级根骨丹	3	30502002　	
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	38000060　	
			},
	[3] ={
			[1]={ItemID = 38002219, num = 1, needbind =1,},		-- 千里良驹礼包（坐骑4选1）	1	38002219　	　
			[2]={ItemID = 30008114, num = 1, needbind =1,},		-- 黄金马鞍	1	30008114　	　
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	38000060	　
			},
	[4] ={
			[1]={ItemID = 30008048, num = 1, needbind =1,},		-- 金刚锉	1	30008048
			[2]={ItemID = 30503133, num = 3, needbind =1,},		-- 千淬神玉	3	　	30503133
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060　
			},
	[5] ={
			[1]={ItemID = 20310168, num = 20,needbind =1,},		-- 金蚕丝	20	　	20310168　
			[2]={ItemID = 20310116, num = 2, needbind =1,},		-- 灵兽精魄	2	　	20310116
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060　
			},
	[6] ={
			[1]={ItemID = 20502003, num = 1, needbind =1,},		-- 3级秘银	1	　	20502003　
			[2]={ItemID = 30700241, num = 3, needbind =1,},		-- 回天神石	3	　	30700241
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060
			},
	[7] ={
			-- [1]={ItemID = 38002220, num = 1, needbind =1,},		-- 纯净晶石3级礼盒（可选择开出纯净黄晶石3级、纯净蓝晶石3级、纯净红晶石3级、纯净绿晶石3级中的1种）	1	　	38002220
			[1]={ItemID = 50313004, num = 1, needbind =1,},		-- 7	50313004 	红宝石（3级）
			[2]={ItemID = 20501003, num = 1, needbind =1,},		-- 3级棉布	1	　	20501003　
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060　
			},
};
x791005_g_FeelFeedBack200_BagSize = {
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
function x791005_CheckGetFullPrize(sceneId,selfId)
	-- --根据官方策划情况，不打到15级，这里不显示。
	-- if GetLevel(sceneId,selfId) < 15 then
		-- return
	-- end
    -- local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME_DATA)
	-- local nGetLingQu = 0;
	-- local nTab = {}
	-- for i = 1,7 do
		-- nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
		-- if nTab[i] ~= 0 then
			-- nGetLingQu = nGetLingQu + 1
		-- end
	-- end
	-- if nGetLingQu >= 7 then
		-- BeginUICommand(sceneId)
		-- UICommand_AddInt(sceneId,0)
		-- UICommand_AddInt(sceneId,0)
		-- EndUICommand(sceneId)
		-- DispatchUICommand(sceneId,selfId,79100501)
	-- else
		-- BeginUICommand(sceneId)
		-- UICommand_AddInt(sceneId,1)
		-- UICommand_AddInt(sceneId,1)
		-- EndUICommand(sceneId)
		-- DispatchUICommand(sceneId,selfId,79100501)
	-- end
end
-----------------------------------------------
--领取奖励事件
-----------------------------------------------
function x791005_GetPrize(sceneId,selfId,g_FeelFeedBack200_Click)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME_DATA)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[g_FeelFeedBack200_Click] == 1 then
	    x791005_NotifySystemMsg(sceneId,selfId,"#{XLYXY_210126_24}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME)
	if g_FeelFeedBack200_Click > nTime then
		x791005_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{XLYXY_210126_23}",g_FeelFeedBack200_Click))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][1] then
		x791005_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{XLYXY_210126_25}",x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][1]))
		return
	end
	if nMaterialSize < x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][2] then
		x791005_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{XLYXY_210126_26}",x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][2]))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,3 do
			AddBindItem(sceneId,x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click][i].ItemID,x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x791005_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{XLYXY_210126_25}",
			x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][1]
		))
		x791005_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{XLYXY_210126_26}",
			x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][2]
		))
		return
	end
	--给物品了
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	-- for i = 1,getn(x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click]) do
	    -- for j = 1,x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click][i].num do
		    -- local nPos = TryRecieveItem( sceneId,selfId,x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click][i].ItemID, 1)
			-- if nPos == -1 then
				-- x791005_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_25}",
					-- x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][1]
				-- ))
				-- x791005_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_26}",
					-- x791005_g_FeelFeedBack200_BagSize[g_FeelFeedBack200_Click][2]
				-- ))
				-- return
			-- end
			-- LuaFnItemBind(sceneId,selfId,nPos)
		-- end
	-- end
	--醒目提示
	for i = 1,3 do
		x791005_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{XLYXY_210126_27}",
			x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click][i].num,
			GetItemName(sceneId,x791005_g_FeelFeedBack200_PrizeList[g_FeelFeedBack200_Click][i].ItemID)
		))
	end
    --领取数据写入
	nTab[g_FeelFeedBack200_Click] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME_DATA)
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	--这里是用于处理小地图旁边得图标
	if nGetLingQu >= 7 then
		x791005_CheckGetFullPrize(sceneId,selfId)
	else
		x791005_OnOpenMainWindow(sceneId,selfId) --重新呼出界面
	end
end
-----------------------------------------------
--打开七日豪礼UI面板
-----------------------------------------------
function x791005_OnOpenMainWindow(sceneId,selfId)
	--CallScriptFunction(888890, "OnPlayerLogin", sceneId,selfId) --///登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK200TIME_DATA)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)--1打开 2刷新
		UICommand_AddInt(sceneId,nTime)--第几天
		UICommand_AddInt(sceneId,nLingQu)--领取情况
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 79100502)
end

function x791005_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


