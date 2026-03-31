--新服欢乐月 7日送豪礼
x892679_g_scriptId = 892679

g_XinShouNew_7DayPrize =
{
	[1] ={
				[1]={ItemID = 10141246, num = 1,}, --坐骑：如意熊（15天）
				[2]={ItemID = 30900006, num = 3,}, --天罡强化精华
				[3]={ItemID = 38000060, num = 1,}, --100绑元//新增道具
				},
	[2] ={
				[1]={ItemID = 38000080, num = 1,},--变异珍兽蛋：呆呆牛
				[2]={ItemID = 30502000, num = 3,},--低级根骨丹
				[3]={ItemID = 38000060, num = 1,},--100绑元//新增道具，同上
				},
	[3] ={
				[1]={ItemID = 10124229, num = 1,},--时装：清风怡江（15天）//新增
				[2]={ItemID = 30008034, num = 3,},--金刚砂
				[3]={ItemID = 38000060, num = 1,},--100绑元//新增道具，同上
				},
	[4] ={
				[1]={ItemID = 50313004, num = 1,},--红宝石(3级)
				[2]={ItemID = 30503132, num = 5,},--百淬神玉
				[3]={ItemID = 38000060, num = 1,},--100绑元//新增道具，同上
				},
	[5] ={
				[1]={ItemID = 30900045, num = 1,},--天罡强化露
				[2]={ItemID = 30700241, num = 3,},--回天神石
				[3]={ItemID = 38000060, num = 1,},--100绑元//新增道具，同上
				},
	[6] ={
				[1]={ItemID = 20310168, num = 20,},--金蚕丝
				[2]={ItemID = 20502003, num = 1,},--3级秘银
				[3]={ItemID = 38000060, num = 1,},--100绑元//新增道具，同上
				},
	[7] ={
				[1]={ItemID = 50313004, num = 1,},--红宝石(3级)
				[2]={ItemID = 20501003, num = 1,},--3级棉布
				[3]={ItemID = 38000060, num = 1,},--100绑元//新增道具，同上
				},	
};
--/////根据字典内容，需要单独检测道具栏和材料栏空位，新增点逻辑
--/////如果官方有更新内容需要根据具体物品计算空位数量。
g_XinShouNew_7DayPrize_BagSize = {
	[1] = {3,0},
	[2] = {3,0},
	[3] = {3,0},
	[4] = {2,1},
	[5] = {3,0},
	[6] = {1,2},
	[7] = {1,2},
};
-----------------------------------------------
--检测是否已经领取完毕数据
-----------------------------------------------
function x892679_CheckGetFullPrize(sceneId,selfId)
	--根据官方策划情况，不打到15级，这里不显示。
	if GetLevel(sceneId,selfId) < 15 then
		return
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME_DATA)
	local nGetLingQu = 0;
	local nTab = {}
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	if nGetLingQu >= 7 then
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,0)
		UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,89267901)
	else
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)
		UICommand_AddInt(sceneId,1)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,89267901)
	end
end
-----------------------------------------------
--领取奖励事件
-----------------------------------------------
function x892679_Get7DayPrize(sceneId,selfId,g_XinShouNew_7DayPrize_Click)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME_DATA)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[g_XinShouNew_7DayPrize_Click] == 1 then
	    x892679_NotifySystemMsg(sceneId,selfId,"#{QRDL_200915_24}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME)
	if g_XinShouNew_7DayPrize_Click > nTime then
		x892679_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_200915_23}",g_XinShouNew_7DayPrize_Click))
		return
	end
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	if nBagSize < g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][1] then
		x892679_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_200915_25}",g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][1]))
		return
	end
	if nMaterialSize < g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][2] then
		x892679_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_200915_26}",g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][2]))
		return
	end
	BeginAddItem(sceneId)
		for i = 1,3 do
			AddBindItem(sceneId,g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click][i].ItemID,g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click][i].num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x892679_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_200915_25}",
			g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][1]
		))
		x892679_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_200915_26}",
			g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][2]
		))
		return
	end
	--给物品了
	--使用新接口
	AddItemListToHuman(sceneId,selfId)
	-- for i = 1,getn(g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click]) do
	    -- for j = 1,g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click][i].num do
		    -- local nPos = TryRecieveItem( sceneId,selfId,g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click][i].ItemID, 1)
			-- if nPos == -1 then
				-- x892679_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_25}",
					-- g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][1]
				-- ))
				-- x892679_NotifySystemMsg(sceneId,selfId,
					-- ScriptGlobal_Format("#{QRDL_200915_26}",
					-- g_XinShouNew_7DayPrize_BagSize[g_XinShouNew_7DayPrize_Click][2]
				-- ))
				-- return
			-- end
			-- LuaFnItemBind(sceneId,selfId,nPos)
		-- end
	-- end
	--醒目提示
	for i = 1,3 do
		x892679_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_200915_27}",
			g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click][i].num,
			GetItemName(sceneId,g_XinShouNew_7DayPrize[g_XinShouNew_7DayPrize_Click][i].ItemID)
		))
	end
    --领取数据写入
	nTab[g_XinShouNew_7DayPrize_Click] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME_DATA)
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	--这里是用于处理小地图旁边得图标
	if nGetLingQu >= 7 then
		x892679_CheckGetFullPrize(sceneId,selfId)
	else
		x892679_OnOpenXinShouNewWindow(sceneId,selfId) --重新呼出界面
	end
end
-----------------------------------------------
--打开七日豪礼UI面板
-----------------------------------------------
function x892679_OnOpenXinShouNewWindow(sceneId,selfId)
	CallScriptFunction(888890, "OnPlayerLogin", sceneId,selfId) --///登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME_DATA)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)--1打开 2刷新
		UICommand_AddInt(sceneId,nTime)--第几天
		UICommand_AddInt(sceneId,nLingQu)--领取情况
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89267902)
end

function x892679_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


