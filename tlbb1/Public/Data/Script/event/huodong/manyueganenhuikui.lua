--满月感恩回馈
x889906_g_scriptId = 889906

x889906_g_FeelFeedBack_PrizeList =
{
		[1] ={
				[1]={ItemID = 39920028, num = 1, needbind =0,}, --雪羽霜衣礼包//新增
				[2]={ItemID = 30008027, num = 3, needbind =0,}, --天灵丹
				[3]={ItemID = 39920019, num = 1, needbind =0,}, --100绑元
				},
	[2] ={
				[1]={ItemID = 39920012, num = 1, needbind =0,},--红宝石(3级)
				[2]={ItemID = 39920018, num = 1, needbind =0,},--3级秘银
				[3]={ItemID = 39920019, num = 1, needbind =0,},--100绑元
				},
	[3] ={
				[1]={ItemID = 39920029, num = 1, needbind =0,},--感恩回馈坐骑礼包//新增
				[2]={ItemID = 39920017, num = 1, needbind =0,},--3级棉布
				[3]={ItemID = 39920019, num = 1, needbind =0,},--100绑元
				},
	[4] ={
				[1]={ItemID = 39920014, num = 1, needbind =0,},--天罡强化露
				[2]={ItemID = 39920022, num = 1, needbind =0,},--金刚锉
				[3]={ItemID = 39920019, num = 1, needbind =0,},--100绑元
				},
	[5] ={
				[1]={ItemID = 39920016, num = 25, needbind =0,},--金蚕丝
				[2]={ItemID = 39920031, num = 5, needbind =0,},--千淬神玉
				[3]={ItemID = 39920019, num = 1, needbind =0,},--100绑元
				},
	[6] ={
				[1]={ItemID = 39920015, num = 5, needbind =0,},--回天神石
				[2]={ItemID = 39920018, num = 1, needbind =0,},--3级秘银
				[3]={ItemID = 39920019, num = 1, needbind =0,},--100绑元
				},
	[7] ={
				[1]={ItemID = 39920012, num = 1, needbind =0,},--红宝石(3级)
				[2]={ItemID = 39920017, num = 1, needbind =0,},--3级棉布
				[3]={ItemID = 39920019, num = 1, needbind =0,},--100绑元
				},
};
x889906_g_FeelFeedBack_BagSize = {
	[1] = {3,0},
	[2] = {3,0},
	[3] = {3,0},
	[4] = {3,0},
	[5] = {3,0},
	[6] = {3,0},
	[7] = {3,0},
};
-----------------------------------------------
--检测是否已经领取完毕数据
-----------------------------------------------
function x889906_CheckGetFullPrize(sceneId,selfId)
	-- --根据官方策划情况，不打到15级，这里不显示。
	-- if GetLevel(sceneId,selfId) < 15 then
		-- return
	-- end
    -- local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME_DATA)
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
		-- DispatchUICommand(sceneId,selfId,88990601)
	-- else
		-- BeginUICommand(sceneId)
		-- UICommand_AddInt(sceneId,1)
		-- UICommand_AddInt(sceneId,1)
		-- EndUICommand(sceneId)
		-- DispatchUICommand(sceneId,selfId,88990601)
	-- end
end
-----------------------------------------------
--领取奖励事件
-----------------------------------------------
function x889906_GetMYGEHKPrize(sceneId,selfId,g_FeelFeedBack_Click)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME_DATA)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[g_FeelFeedBack_Click] == 1 then
	    x889906_NotifySystemMsg(sceneId,selfId,"#{MYGEHK_20110_24}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME)
	if g_FeelFeedBack_Click > nTime then
		x889906_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{MYGEHK_20110_23}",g_FeelFeedBack_Click))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][1] then
		x889906_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{MYGEHK_20110_25}",x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][1]))
		return
	end
	if nMaterialSize < x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][2] then
		x889906_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{MYGEHK_20110_26}",x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][2]))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,3 do
			AddItem(sceneId,x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click][i].ItemID,x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x889906_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{MYGEHK_20110_25}",
			x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][1]
		))
		x889906_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{MYGEHK_20110_26}",
			x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][2]
		))
		return
	end
	--给物品了
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	-- for i = 1,getn(x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click]) do
	    -- for j = 1,x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click][i].num do
		    -- local nPos = TryRecieveItem( sceneId,selfId,x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click][i].ItemID, 1)
			-- if nPos == -1 then
				-- x889906_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_25}",
					-- x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][1]
				-- ))
				-- x889906_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_26}",
					-- x889906_g_FeelFeedBack_BagSize[g_FeelFeedBack_Click][2]
				-- ))
				-- return
			-- end
			-- LuaFnItemBind(sceneId,selfId,nPos)
		-- end
	-- end
	--醒目提示
	for i = 1,3 do
		x889906_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{MYGEHK_20110_27}",
			x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click][i].num,
			GetItemName(sceneId,x889906_g_FeelFeedBack_PrizeList[g_FeelFeedBack_Click][i].ItemID)
		))
	end
    --领取数据写入
	nTab[g_FeelFeedBack_Click] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME_DATA)
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	--这里是用于处理小地图旁边得图标
	if nGetLingQu >= 7 then
		x889906_CheckGetFullPrize(sceneId,selfId)
	else
		x889906_OnOpenMYGEHKWindow(sceneId,selfId) --重新呼出界面
	end
end
-----------------------------------------------
--打开七日豪礼UI面板
-----------------------------------------------
function x889906_OnOpenMYGEHKWindow(sceneId,selfId)
	--CallScriptFunction(888890, "OnPlayerLogin", sceneId,selfId) --///登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACKTIME_DATA)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)--1打开 2刷新
		UICommand_AddInt(sceneId,nTime)--第几天
		UICommand_AddInt(sceneId,nLingQu)--领取情况
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 88990602)
end

function x889906_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


