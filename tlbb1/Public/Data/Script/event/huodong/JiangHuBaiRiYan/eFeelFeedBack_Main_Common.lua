--七日累计登录通用脚本
x792012_g_scriptId = 792012
--活动开始及截止时间（间隔7天）
x792012_g_BeginTime = 20250522
x792012_g_EndTime = 20251231
--活动参与最低等级
x792012_g_MinLevel = 15

x792012_g_FeelFeedBack_Main_PrizeList =
{
	[1] ={
			[1]={ItemID = 38002780, num = 1, needbind =1,},		-- 千花逢雨礼包（稀有3选1,15天）
			[2]={ItemID = 30501361, num = 3, needbind =1,},		-- 功力丹　
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	　
			},
	[2] ={
			[1]={ItemID = 30900045, num = 1, needbind =1,},		-- 天罡强化露	
			[2]={ItemID = 30502002, num = 3, needbind =1,},		-- 高级根骨丹	
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝　	
			},
	[3] ={
			[1]={ItemID = 38002779, num = 1, needbind =1,},		-- 坐骑新礼包（坐骑4选1）
			[2]={ItemID = 30008115, num = 5, needbind =1,},		-- 白银马鞍 *5
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝	　
			},
	[4] ={
			[1]={ItemID = 38002519, num = 2, needbind =1,},		-- 九尾魂玉*2
			[2]={ItemID = 30503133, num = 3, needbind =1,},		-- 千淬神玉
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[5] ={
			[1]={ItemID = 20310168, num = 20,needbind =1,},		-- 金蚕丝	20	　	
			[2]={ItemID = 38002530, num = 5, needbind =1,},		-- 兽魂升级道具*5
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[6] ={
			[1]={ItemID = 20502003, num = 1, needbind =1,},		-- 3级秘银
			[2]={ItemID = 38002524, num = 3, needbind =1,},		-- 鹿蜀魂玉*3
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
	[7] ={
			[1]={ItemID = 50313004, num = 1, needbind =1,},		-- 红宝石3级	
			[2]={ItemID = 20501003, num = 1, needbind =1,},		-- 3级棉布	
			[3]={ItemID = 38000060, num = 1, needbind =1,},		-- 100绑定元宝
			},
};
-----------------------------------------------
--检测是否已经领取完毕数据
-----------------------------------------------
function x792012_CheckGetFullPrize(sceneId,selfId)
	--根据策划情况，不打到15级，这里不显示。
	if GetLevel(sceneId,selfId) < x792012_g_MinLevel then
		return
	end
	--基本时间要求
	local nCurSrvTime = GetTime2Day()
	if nCurSrvTime < x792012_g_BeginTime or nCurSrvTime > x792012_g_EndTime then
		return
	end
	--计算登录的第几天
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_TIME)
	if floor(nTime/100) ~= nCurSrvTime then
		nTime = nCurSrvTime * 100 + mod(nTime,100) + 1
		SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_TIME,nTime)
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_DATA)
	
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
	DispatchUICommand(sceneId,selfId,79201201)
end
-----------------------------------------------
--领取奖励事件
-----------------------------------------------
function x792012_GetPrize(sceneId,selfId,nClick)
	--检测玩家登录日期，如果是活动日期内，显示，不是的话直接返回
	--基本时间要求
	local nCurSrvTime = GetTime2Day()
	if nCurSrvTime < x792012_g_BeginTime or nCurSrvTime > x792012_g_EndTime then
		x792012_NotifySystemMsg(sceneId,selfId,"#{QRDL_20211229_22}")
	    return
	end
	if GetLevel(sceneId,selfId) < x792012_g_MinLevel then
		x792012_NotifySystemMsg(sceneId,selfId,"#{QRDL_20211229_21}")
	    return
	end
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_DATA)
	local nTab = {}
	local nGetLingQu = 0
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQu/10 ^ (i - 1)),10)
	end
    if nTab[nClick] == 1 then
	    x792012_NotifySystemMsg(sceneId,selfId,"#{QHKG_210329_24}")
	    return
	end
	local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_TIME)
	if nClick > mod(nTime,100) then
		x792012_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_23}",nClick))
		return
	end
	--背包空间判断
	BeginAddItem(sceneId)
	for i = 1,3 do
		AddBindItem(sceneId,x792012_g_FeelFeedBack_Main_PrizeList[nClick][i].ItemID,x792012_g_FeelFeedBack_Main_PrizeList[nClick][i].num)
	end
	if EndAddItem(sceneId,selfId,1) <= 0 then
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x792012_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_24}",iBase))
		end
		if iMat ~= nil and iMat > 0 then
			x792012_NotifySystemMsg(sceneId,selfId,ScriptGlobal_Format("#{QRDL_20211229_25}",iMat))
		end
		return
	end
	--给物品
	AddItemListToHuman(sceneId,selfId)
	--醒目提示
	for i = 1,3 do
		x792012_NotifySystemMsg(sceneId,selfId,
			ScriptGlobal_Format("#{QRDL_20211229_26}",
			x792012_g_FeelFeedBack_Main_PrizeList[nClick][i].num,
			GetItemName(sceneId,x792012_g_FeelFeedBack_Main_PrizeList[nClick][i].ItemID)
		))
	end
	--布灵布灵
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
    --领取数据写入
	nTab[nClick] = 1
	local nFinalData = 0
	for i = 1,7 do
		nFinalData = nFinalData + nTab[i] * 10 ^ (i - 1)
	end
	SetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_DATA,nFinalData)
	local nLingQuEx = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_DATA)
	for i = 1,7 do
		nTab[i] = mod(floor(nLingQuEx/10 ^ (i - 1)),10)
		if nTab[i] ~= 0 then
			nGetLingQu = nGetLingQu + 1
		end
	end
	x792012_CheckGetFullPrize(sceneId,selfId)
	x792012_OnOpenMainWindow(sceneId,selfId) --重新呼出界面
end
-----------------------------------------------
--打开七日豪礼UI面板
-----------------------------------------------
function x792012_OnOpenMainWindow(sceneId,selfId)
	--登录检测，玩家如果没有重新登陆游戏直接打开面板，进行天数检测。
    local nTime = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_TIME)
    local nLingQu = GetMissionDataEx(sceneId,selfId,MDEX_FEEDBACK_MAIN_DATA)
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,1)			--1打开 2刷新
		UICommand_AddInt(sceneId,nTime)		--登录的第几天
		UICommand_AddInt(sceneId,nLingQu)	--领取情况
		UICommand_AddInt(sceneId,x792012_g_EndTime)--截止日期
		-- 签到页签红点
		UICommand_AddInt(sceneId,0)
		-- 周活跃页签红点
		UICommand_AddInt(sceneId,0)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 79201202)
end
-----------------------------------------------
--屏幕中心提示
-----------------------------------------------
function x792012_NotifySystemMsg(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end


