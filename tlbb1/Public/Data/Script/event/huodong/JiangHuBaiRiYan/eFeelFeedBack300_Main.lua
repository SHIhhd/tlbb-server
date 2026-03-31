--长昼萧然考古守
x792000_g_scriptId = 792000

x792000_g_FeelFeedBack300_PrizeList =
{
	[1] ={
			[1]={ItemID = 38002242, num = 1, needbind =1,},		-- 墨染兰香礼包（稀有3选1,15天）	1	38002242
			[2]={ItemID = 30501361, num = 3, needbind =1,},		-- 功力丹	3	30501361//需强绑	　
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	38000060　	　
			},
	[2] ={
			[1]={ItemID = 30900045, num = 1, needbind =1,},		-- 天罡强化露	1	30900045//需强绑
			[2]={ItemID = 30502002, num = 3, needbind =1,},		-- 高级根骨丹	3	30502002//需强绑
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	38000060　	
			},
	[3] ={
			[1]={ItemID = 38002243, num = 1, needbind =1,},		-- 秦月宋光礼包（坐骑4选1）	1	38002161
			[2]={ItemID = 30008114, num = 1, needbind =1,},		-- 黄金马鞍	1	30008114//需强绑
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	38000060	　
			},
	[4] ={
			[1]={ItemID = 30008048, num = 1, needbind =1,},		-- 金刚锉	1	30008048//需强绑
			[2]={ItemID = 30503133, num = 3, needbind =1,},		-- 千淬神玉	3	　	30503133
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060　
			},
	[5] ={
			[1]={ItemID = 20310168, num = 20,needbind =1,},		-- 金蚕丝	20	　	20310168　
			[2]={ItemID = 20310116, num = 2, needbind =1,},		-- 灵兽精魄	2	20310116//需强绑
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060　
			},
	[6] ={
			[1]={ItemID = 30700241, num = 3, needbind =1,},		-- 回天神石	3	30700241
			[2]={ItemID = 20502003, num = 1, needbind =1,},		-- 3级秘银	1	20502003//需强绑
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060
			},
	[7] ={
			[1]={ItemID = 50313004, num = 1, needbind =1,},		-- 红宝石3级	1	50313004//需强绑
			[2]={ItemID = 20501003, num = 1, needbind =1,},		-- 3级棉布	1	20501003//需强绑
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	1	　	38000060　
			},
};
x792000_g_FeelFeedBack300_BagSize = {
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
function x792000_CheckGetFullPrize(sceneId,selfId)
	--根据官方策划情况，不打到15级，这里不显示。
	if GetLevel(sceneId,selfId) < 15 then
		return
	end
	--检测玩家登录日期，如果是活动日期内，显示，不是的话直接返回
	local nFeedBak300Login = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300_LOGIN)
	if nFeedBak300Login < 20240606 or nFeedBak300Login > 20240619 then
		return
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME_DATA)
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME)
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
			if nGetLingQu < nTime then
				UICommand_AddInt(sceneId,1)
			else
				UICommand_AddInt(sceneId,0)
			end
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,79200001)
end
-----------------------------------------------
--领取奖励事件
-----------------------------------------------
function x792000_GetPrize(sceneId,selfId,g_FeelFeedBack300_Click)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME_DATA)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[g_FeelFeedBack300_Click] == 1 then
	    x792000_NotifySystemMsg(sceneId,selfId,"#{QHKG_210329_24}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME)
	if g_FeelFeedBack300_Click > nTime then
		x792000_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QHKG_210329_23}",g_FeelFeedBack300_Click))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][1] then
		x792000_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QHKG_210329_25}",x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][1]))
		return
	end
	if nMaterialSize < x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][2] then
		x792000_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QHKG_210329_26}",x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][2]))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,3 do
			AddBindItem(sceneId,x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click][i].ItemID,x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x792000_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QHKG_210329_25}",
			x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][1]
		))
		x792000_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QHKG_210329_26}",
			x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][2]
		))
		return
	end
	--给物品了
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	-- for i = 1,getn(x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click]) do
	    -- for j = 1,x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click][i].num do
		    -- local nPos = TryRecieveItem( sceneId,selfId,x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click][i].ItemID, 1)
			-- if nPos == -1 then
				-- x792000_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_25}",
					-- x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][1]
				-- ))
				-- x792000_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_26}",
					-- x792000_g_FeelFeedBack300_BagSize[g_FeelFeedBack300_Click][2]
				-- ))
				-- return
			-- end
			-- LuaFnItemBind(sceneId,selfId,nPos)
		-- end
	-- end
	--醒目提示
	for i = 1,3 do
		x792000_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QHKG_210329_27}",
			x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click][i].num,
			GetItemName(sceneId,x792000_g_FeelFeedBack300_PrizeList[g_FeelFeedBack300_Click][i].ItemID)
		))
	end
    --领取数据写入
	nTab[g_FeelFeedBack300_Click] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME_DATA)
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	x792000_CheckGetFullPrize(sceneId,selfId)
	x792000_OnOpenMainWindow(sceneId,selfId) --重新呼出界面
end
-----------------------------------------------
--打开七日豪礼UI面板
-----------------------------------------------
function x792000_OnOpenMainWindow(sceneId,selfId)
	CallScriptFunction(888890, "OnPlayerLogin", sceneId,selfId) --///登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK300TIME_DATA)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)--1打开 2刷新
		UICommand_AddInt(sceneId,nTime)--第几天
		UICommand_AddInt(sceneId,nLingQu)--领取情况
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 79200002)
end

function x792000_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


