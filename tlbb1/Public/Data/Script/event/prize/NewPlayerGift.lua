--新手倒计时开奖
x889103_g_ScriptId = 889103
x889103_g_TimeAndEquipData = {1,1,1,1,1,1,1,1,1,1}
x889103_g_TimeItem = {
[1] = {{itemId = 10414054,num = 1},{itemId = 10423060,num = 1},{itemId = 10121016,num = 1},{itemId = 10112056,num = 1},{itemId = 10111056,num = 1}},--无忧套 10111056   10112056  10113056 10121016
[2] = {{itemId = 10141040,num = 1},{itemId = 10141030,num = 1}},--百宝箱，百宝囊
[3] = {{itemId = 10422152,num = 2}},--无忧套
[4] = {{itemId = 10423061,num = 2}},--无忧套
[5] = {{itemId = 10415054,num = 1},{itemId = 10423060,num = 1}},--无忧套 10423060
[6] = {{itemId = 50513004,num = 2},{itemId = 38002987,num = 1}},--5级红宝石，七情刃4星自选
[7] = {{itemId = 20501003,num = 10}},--3级棉布
[8] = {{itemId = 20500003,num = 10}},--3级精铁
[9] = {{itemId = 20501003,num = 10}},--元宝票（10万）

[10] = {{itemId = 10156004,num = 1},{itemId = 10156003,num = 1}},--武魂内外功
}
x889103_BagSize = {1,2,1,1,1,2,1,1,1,2}
--**********************************
--新手倒计时领奖点击按钮
--**********************************
function x889103_TakeGift(sceneId,selfId,nState)
	if nState == nil or nState < 0 or nState > 10 then
		return
	end
	if sceneId == SCENE_DIFU then
		return
    end
	
	local nGiftLevel = GetMissionDataEx(sceneId,selfId,MDEX_NEWPLAYERGIFT_DATA)
	
	-- 发生以下这种情况直接隐藏界面
	if nGiftLevel >= 10 then
		--隐藏UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 889103)
		return
	end
	if nGiftLevel ~= (nState - 1) or x889103_g_TimeItem[nState] == nil then
		--隐藏UI
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 889103)
		return
	end
	
	--背包空间判断
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	if nBagSize < x889103_BagSize[nState] then
		x889103_NotifyTip(sceneId,selfId,
			ScriptGlobal_Format("#{XRLJ_100104_6}",
			x889103_BagSize[nState]
			))
		return
	end
	BeginAddItem(sceneId)
		for _,nData in  x889103_g_TimeItem[nState] do
			AddItem(sceneId,nData.itemId,nData.num)
		end
	if EndAddItem(sceneId,selfId) <= 0 then
		x889103_NotifyTip(sceneId,selfId,
			ScriptGlobal_Format("#{XRLJ_100104_6}",
			x889103_BagSize[nState]
			))
		return
	end
	
	--时间判断
	local nNowSelfTime = GetMissionDataEx(sceneId,selfId,MDEX_NEWPLAYERGIFT_TIME);
	local nLastTime = LuaFnGetCurrentTime() - nNowSelfTime
	if nLastTime < 1 or nLastTime <  x889103_g_TimeAndEquipData[nGiftLevel + 1] * 60 then
		return
	end
	
	--写入领取奖励记录
	SetMissionDataEx( sceneId, selfId, MDEX_NEWPLAYERGIFT_DATA, nGiftLevel + 1 )
	SetMissionDataEx( sceneId, selfId, MDEX_NEWPLAYERGIFT_TIME, LuaFnGetCurrentTime())
	--物品给予+绑定
	for _,nData in  x889103_g_TimeItem[nState] do
		for j=1,nData.num do
			local Bind = 1
			local pos =TryRecieveItem( sceneId, selfId,nData.itemId,1,Bind)--发奖励物品
			if pos >=0 then
				x889103_NotifyTip( sceneId, selfId,
					ScriptGlobal_Format("#{XRLJ_100104_8}",
					nData.itemId
				))
			end
		end
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	--隐藏UI
	if nState == 10 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,0)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 889103)
		return
	end
	--未领取到第十阶段得情况下
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nState + 1);
		UICommand_AddInt(sceneId,x889103_g_TimeAndEquipData[nState + 1])
		UICommand_AddInt(sceneId,0) --领取奖励后这个接口发送0给客户端。
	EndUICommand(sceneId )
	DispatchUICommand(sceneId,selfId, 889103)
end
--**********************************
--打开新手倒计时UI
--**********************************
function x889103_OpenFreshManTime(sceneId,selfId)
	local nGiftLevel = GetMissionDataEx(sceneId,selfId,MDEX_NEWPLAYERGIFT_DATA)
	if nGiftLevel >= 10 then
		return
	end
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nGiftLevel + 1);
		UICommand_AddInt(sceneId,x889103_g_TimeAndEquipData[nGiftLevel + 1])  --time
		UICommand_AddInt(sceneId,1) --登录时发送1给客户端。
	EndUICommand(sceneId )
	DispatchUICommand(sceneId,selfId, 889103)
end
--**********************************
--醒目提示
--**********************************
function x889103_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end