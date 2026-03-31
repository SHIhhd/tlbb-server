--LandReward
x892678_g_scriptId = 892678

g_LandReward_Gifts = {
	[1] ={
				[1]={ItemID = 30503133, num = 3, needbind =1,}, 
				[2]={ItemID = 20310168, num = 5, needbind =1,},
				[3]={ItemID = 38000202, num = 1, needbind =1,},
				},
	[2] ={
				[1]={ItemID = 30700241, num = 3, needbind =1,},
				[2]={ItemID = 20310168, num = 7, needbind =1,},
				[3]={ItemID = 38002162, num = 1, needbind =1,}
				},
	[3] ={
				[1]={ItemID = 30900045, num = 1, needbind =1,},
				[2]={ItemID = 20310168, num = 9, needbind =1,},
				[3]={ItemID = 38002166, num = 1, needbind =1,},
				},
	[4] ={
				[1]={ItemID = 30008048, num = 1, needbind =1,},
				[2]={ItemID = 20310168, num = 11, needbind =1,},
				[3]={ItemID = 38002174, num = 1, needbind =1,},
				},
	[5] ={
				[1]={ItemID = 20502003, num = 1, needbind =1,},
				[2]={ItemID = 20310168, num = 13, needbind =1,},
				[3]={ItemID = 38002175, num = 1, needbind =1,},
				},
	[6] ={
				[1]={ItemID = 20501003, num = 1, needbind =1,},
				[2]={ItemID = 20310168, num = 15, needbind =1,},
				[3]={ItemID = 38002176, num = 1, needbind =1,},
				},									
}
--/////根据字典内容，需要单独检测道具栏和材料栏空位，新增点逻辑
--/////如果官方有更新内容需要根据具体物品计算空位数量。
g_LandReward_Gifts_BagSize = {
	[1] = {2,1},
	[2] = {2,1},
	[3] = {2,1},
	[4] = {2,1},
	[5] = {1,2},
	[6] = {1,2},
};
--/////登录天数
g_NeedLoginDays = {1,3,5,8,12,15}
-----------------------------------------------
--检测是否已经领取完毕数据
-----------------------------------------------
function x892678_CheckGetFullPrize(sceneId,selfId)
	--根据官方策划情况，不打到30级，这里不显示。
	if GetLevel(sceneId,selfId) < 30 then
		return
	end
	--三月份活动，取消不显示
	if GetTime2Day() < 20240311 or GetTime2Day() > 20240331 then
		return
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME_DATA)
	local nGetLingQu = 0;
	local nTab = {}
	for i = 1,6 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end    
	if nGetLingQu >= 6 then
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,0)
		UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,89267802)
	else
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)
		UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,89267802)
	end
end
-----------------------------------------------
--领取事件
-----------------------------------------------
function x892678_GetLoginDaysPrize(sceneId,selfId,btnId)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME_DATA)
	if GetLevel(sceneId,selfId) < 30 then
		x892678_NotifySystemMsg(sceneId,selfId,"#{LJDL_170823_37}")
		return
	end
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,6 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[btnId] == 1 then
	    x892678_NotifySystemMsg(sceneId,selfId,"#{LJDL_170823_19}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME)
	if g_NeedLoginDays[btnId] > nTime then
		x892678_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{LJDL_170823_20}",g_NeedLoginDays[btnId]))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < g_LandReward_Gifts_BagSize[btnId][1] then
		x892678_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{LJDL_170823_21}",g_LandReward_Gifts_BagSize[btnId][1]))
		return
	end
	if nMaterialSize < g_LandReward_Gifts_BagSize[btnId][2] then
		x892678_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{LJDL_170823_22}",g_LandReward_Gifts_BagSize[btnId][2]))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,3 do
			AddBindItem(sceneId,g_LandReward_Gifts[btnId][i].ItemID,g_LandReward_Gifts[btnId][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x892678_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{LJDL_170823_21}",
			g_LandReward_Gifts_BagSize[btnId][1]
		))
		x892678_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{LJDL_170823_22}",
			g_LandReward_Gifts_BagSize[btnId][2]
		))
		return
	end
	--给物品了
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	-- for i = 1,getn(g_LandReward_Gifts[btnId]) do
	    -- for j = 1,g_LandReward_Gifts[btnId][i].num do
		    -- local nPos = TryRecieveItem( sceneId,selfId,g_LandReward_Gifts[btnId][i].ItemID, 1)
			-- if nPos == -1 then
				-- x892678_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{LJDL_170823_21}",
					-- g_LandReward_Gifts_BagSize[btnId][1]
				-- ))
				-- x892678_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{LJDL_170823_22}",
					-- g_LandReward_Gifts_BagSize[btnId][2]
				-- ))
				-- return
			-- end
			-- if g_LandReward_Gifts[btnId][i].needbind == 1 then
				-- LuaFnItemBind(sceneId,selfId,nPos)
			-- end
		-- end
	-- end
	--醒目提示
	for i = 1,3 do
		x892678_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{LJDL_170823_23}",
			g_LandReward_Gifts[btnId][i].num,
			GetItemName(sceneId,g_LandReward_Gifts[btnId][i].ItemID)
		))
	end
    --领取数据写入
	nTab[btnId] = 1
	local nFinalData = 0
	for i = 1,6 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME_DATA)
	for i = 1,6 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	--这里是用于处理小地图旁边得图标
	if nGetLingQu >= 6 then
		x892678_CheckGetFullPrize(sceneId,selfId)
	else
		x892678_UpdatePrizeUI(sceneId,selfId) --更新界面
	end
end
-----------------------------------------------
--更新客户端
-----------------------------------------------
function x892678_UpdatePrizeUI(sceneId,selfId)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME_DATA)
	local nTab = {}
	for i = 1,6 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,2)
		for i = 1,6 do
			UICommand_AddInt(sceneId,nTab[i])--领取情况
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89267801)
end
-----------------------------------------------
--通过客户端小地图点开打开主界面
-----------------------------------------------
function x892678_OpenPrizeUI(sceneId,selfId)
	CallScriptFunction(888890, "OnPlayerLogin", sceneId,selfId) --///登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME_DATA)
	local nTab = {}
	for i = 1,6 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)
		UICommand_AddInt(sceneId,nTime)--第几天
		for i = 1,6 do
			UICommand_AddInt(sceneId,nTab[i])--领取情况
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89267801)
end
-----------------------------------------------
--屏幕提示
-----------------------------------------------
function x892678_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


