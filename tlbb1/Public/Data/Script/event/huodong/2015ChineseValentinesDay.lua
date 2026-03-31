--七夕情人节排行榜
--脚本号
x891396_g_ScriptId	= 891396
--开放奖励领取
x891396_g_OpenGetPrize = 1
--需要最低等级
x891396_g_MinLevel = 15
--道具栏空间最低限制
x891396_g_MinBagSize = 1
--诉情蝶兑换
x891396_g_SeventhFestivalTopList_Qingrenjie_Bonus =
{
	[1] = {neednum = 2400, itemid = 10125217, count = 1, name = "凤凰于飞", LimitMD = -1, LimitNum = -1, IsShowButton = 1},
	[2] = {neednum = 1500, itemid = 30310085, count = 1, name = "超级珍兽笼：鸾凤和鸣", LimitMD = 766, LimitNum = 3, IsShowButton = 1},
	[3] = {neednum = 1500, itemid = 38002889, count = 1, name = "惊雷隐月礼盒", LimitMD = -1, LimitNum = -1, IsShowButton = 0},
	[4] = {neednum = 600, itemid = 10125266, count = 1, name = "云酥梦裳", LimitMD = -1, LimitNum = -1, IsShowButton = 0},
	[5] = {neednum = 600, itemid = 38002878, count = 1, name = "黯然销魂礼盒", LimitMD = -1, LimitNum = -1, IsShowButton = 1},
	[6] = {neednum = 300, itemid = 30103085, count = 1, name = "动作：久别再逢", LimitMD = -1, LimitNum = -1, IsShowButton = 0},
	[7] = {neednum = 22, itemid = 30503140, count = 1, name = "虹耀石", LimitMD = -1, LimitNum = -1, IsShowButton = 0},
}
--诉情蝶
x891396_g_NeedItemID = 38002284
--榜单奖励物品【送花榜】
x891396_g_SeventhFestivalTopListPreview_SGift =
{
	--type 1:称号 2:物品 3:宠物
	[1] = { {type = 1,id = 1044},
			{type = 2,id = 10420088,num = 1},
			{type = 2,id = 38000539,num = 200},{type = 2,id = 38003055,num = 200},{type = 2,id = 38002732,num = 40},
			{type = 3,id = 30108,minPer = 4888}},
			
	[2] = { {type = 1,id = 1213},
			{type = 2,id = 10420088,num = 1},
			{type = 2,id = 38000539,num = 170},{type = 2,id = 38003055,num = 200},{type = 2,id = 38002732,num = 40},
			{type = 3,id = 30108,minPer = 3888}},
			
	[3] = { {type = 1,id = 1082},
			{type = 2,id = 10420088,num = 1},
			{type = 2,id = 38000539,num = 150},{type = 2,id = 38003055,num = 200},{type = 2,id = 38002732,num = 40},
			{type = 3,id = 30108,minPer = 3188}},
			
	[4] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 130},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},{type = 2,id = 38002732,num = 40},},
			
	[5] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 120},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},},
			
	[6] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 110},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},},
	
	[7] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 100},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},},
	
	[8] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 90},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},},
			
	[9] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 80},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},},
	
	[10] = { {type = 1,id = 1046},
			{type = 2,id = 38000539,num = 70},{type = 2,id = 38003055,num = 100},{type = 2,id = 30310096,num = 1},},
			
	[11] = { {type = 1,id = 1250},
			{type = 2,id = 38000539,num = 50},{type = 2,id = 38003055,num = 50},{type = 2,id = 30310096,num = 1},},
}
--榜单奖励物品【收花榜】
x891396_g_SeventhFestivalTopListPreview_RGift =
{
	--type 1:称号 2:物品 3:宠物
	[1] = { {type = 1,id = 1045},},
			
	[2] = { {type = 1,id = 1214},},
			
	[3] = { {type = 1,id = 1083},},
			
	[4] = { {type = 1,id = 1046},},
			
	[5] = { {type = 1,id = 1046},},
			
	[6] = { {type = 1,id = 1046},},
	
	[7] = { {type = 1,id = 1046},},
	
	[8] = { {type = 1,id = 1046},},
			
	[9] = { {type = 1,id = 1046},},
	
	[10] = { {type = 1,id = 1046},},
			
	[11] = { {type = 1,id = 1250},},
}
--榜单信息【这里时间信息待修改】
x891396_g_SeventhFestivalTopList_Info = 
{
	--配置信息说明
--	sendmd、receivemd:发送数量和接受数量的MD索引
--	minNum:上榜要求最低数量
	--一见钟情
	[1] = {minNum = 1000,sendmd = MD_QIXITOPLIST_ID4_SEND, receivemd = MD_QIXITOPLIST_ID4_RECV},
	--花好月圆
	[2] = {minNum = 1000,sendmd = MD_QIXITOPLIST_ID5_SEND, receivemd = MD_QIXITOPLIST_ID5_RECV},
	--花序榜·醉花阴
	[3] = {minNum = 1000,sendmd = MD_QIXITOPLIST_ID6_SEND, receivemd = MD_QIXITOPLIST_ID6_RECV},
}
--榜单提示信息
x891396_g_SeventhFestivalTopList_Tip = --待修改
{
	[1] = {tip1 = "#{QXLS_150724_71}", tip2 = "#{QXLS_150724_72}", tip3 = "#{QXLS_150724_73}"},
	[2] = {tip1 = "#{QXLS_150724_71}", tip2 = "#{QXLS_150724_126}", tip3 = "#{QXLS_150724_73}"},
	[3] = {tip1 = "#{QXLS_150724_71}", tip2 = "#{QXLS_150724_127}", tip3 = "#{QXLS_150724_73}"},
}
--领奖记录
x891396_g_ClientGetQixiTopListPrizeData = 
{
	[1] = {MFEX_QIXITOPLISTSEND_1_PRIZE,MFEX_QIXITOPLISTRECEIVE_1_PRIZE},
	[2] = {MFEX_QIXITOPLISTSEND_2_PRIZE,MFEX_QIXITOPLISTRECEIVE_2_PRIZE},
	[3] = {MFEX_QIXITOPLISTSEND_3_PRIZE,MFEX_QIXITOPLISTRECEIVE_3_PRIZE}
}
--领奖系统
x891396_g_ClientQixiTopListPrizeGlobal = 
{
	[1] = {"#{QXLS_150724_78}","#{QXLS_150724_83}"},
	[2] = {"#{QXLS_150724_86}","#{QXLS_150724_90}"},
	[3] = {"#{QXLS_150724_93}","#{QXLS_150724_97}"}
}
--领奖提示
x891396_g_ClientQixiTopListPrizeTips = 
{
	[1] = {"#{QXLS_150724_79}","#{QXLS_150724_84}"},
	[2] = {"#{QXLS_150724_87}","#{QXLS_150724_91}"},
	[3] = {"#{QXLS_150724_94}","#{QXLS_150724_98}"}
}
--**********************************
--客户端请求刷新排行榜
--**********************************
function x891396_ClientAskQixiTopList( sceneId,selfId,nType)
	if GetLevel(sceneId,selfId) < x891396_g_MinLevel then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_84}")
		return
	end
	
	local nValidIndex = x891396_GetCurTopListIndex(sceneId,selfId)
	--榜单时间是否再总时间内
	if x891396_GetCurTopListEndTime(sceneId,selfId) <= 0 then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_83}")
		return
	end
	-- if nValidIndex <= 0 or nValidIndex > getn(x891396_g_SeventhFestivalTopList_Info) then
		-- x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_83}")
		-- return
	-- end
	--0--默认显示页签--注：1-3标示排行榜 4-5标示兑换奖励
	if nType == 0 then
		--新页面开启
		nType = 1
	end
	if nType >= 1 and nType <= 3 then
		local nCurTime = LuaFnGetCurrentTime()
--		if nCurTime < x891396_g_SeventhFestivalTopList_Info[nType].begintime then
--			x891396_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20210701_85}"
--				,tostring(mod(floor(x891396_g_SeventhFestivalTopList_Info[nType].begintime / 100),100))
--				,tostring(mod(x891396_g_SeventhFestivalTopList_Info[nType].begintime,100))
--			))
--			return
--		end
		local nBeginTime,nEndTime = LuaFnTopListGetBaseConfig(nType - 1)
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, nType )	--page
			--活动状态 0:活动正在进行中，请于2021年8月9日24时后再来领取！		1-5 6:未能决出
			if nCurTime >= nEndTime then
				UICommand_AddInt( sceneId, 6 )	
			elseif nCurTime < nBeginTime then
				UICommand_AddInt( sceneId, 0 )	
			else
				UICommand_AddInt( sceneId, 1 )
			end
			
			UICommand_AddInt( sceneId, 1 )	--StateShow 1-3
			--是否处于榜单有效期内
			if nValidIndex == nType then
--				QXHB_20210701_206	#gff00ff距离榜单开奖：%s0天#cfff263	
--				QXHB_20210701_207	#gff00ff距离榜单开奖：%s0小时#cfff263	
--				QXHB_20210701_208	#gff00ff距离榜单开奖：%s0分钟#cfff263	
--				QXHB_20210701_209	#gff00ff距离榜单开奖：不足1分钟	
				--计算开奖时间
				local nResidueTime = nEndTime - nCurTime
				if nResidueTime > 24 * 60 * 60 then
					UICommand_AddString(sceneId,ScriptGlobal_Format("#{QXHB_20210701_206}",tostring(ceil(nResidueTime / (24 * 60 * 60)))))
				elseif nResidueTime >  60 * 60 then
					UICommand_AddString(sceneId,ScriptGlobal_Format("#{QXHB_20210701_207}",tostring(ceil(nResidueTime / (60 * 60)))))
				elseif nResidueTime >  60 then
					UICommand_AddString(sceneId,ScriptGlobal_Format("#{QXHB_20210701_208}",tostring(ceil(nResidueTime / (60)))))
				else
					UICommand_AddString(sceneId,"#{QXHB_20210701_209}")
				end
			else
				if nCurTime < nBeginTime then
					UICommand_AddString(sceneId,"#{QXHB_20210701_268}")
				elseif nCurTime >= nEndTime then
					UICommand_AddString(sceneId,"#{QXHB_20210701_210}")
				end
			end
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 891396 )
		--请求服务端数据
		--这里请求完后，程序会在客户端打开排行榜页面
		LuaFnTopListQixiAskWorldData(sceneId,selfId,nType - 1)
	end

end
--**********************************
--玩家增加送花数
--**********************************
function x891396_AddSendFlowerNum( sceneId,selfId,nAddVal)
--	x891396_NotifyTip(sceneId,selfId,"0 x891396_AddSendFlowerNum "..nAddVal)

	local nValidIndex = x891396_GetCurTopListIndex(sceneId,selfId)
	if nValidIndex <= 0 or nValidIndex > getn(x891396_g_SeventhFestivalTopList_Info) then
		return
	end
--	x891396_NotifyTip(sceneId,selfId,"1 x891396_AddSendFlowerNum "..nAddVal)
	
	local nCurNumber = GetMissionData(sceneId,selfId,x891396_g_SeventhFestivalTopList_Info[nValidIndex].sendmd)
	nCurNumber = nCurNumber + nAddVal
	SetMissionData(sceneId,selfId,x891396_g_SeventhFestivalTopList_Info[nValidIndex].sendmd,nCurNumber)

	if nCurNumber < x891396_g_SeventhFestivalTopList_Info[nValidIndex].minNum then
		return
	end
	--这里的0表示第1个排行榜 总共有三个榜，注意
	LuaFnTopListQixiAddCharSendData(sceneId,selfId,nValidIndex - 1,nCurNumber)
end
--**********************************
--玩家增加收花数
--**********************************
function x891396_AddReciveFlowerNum( sceneId,selfId,nAddVal)
	local nValidIndex = x891396_GetCurTopListIndex(sceneId,selfId)
	if nValidIndex <= 0 or nValidIndex > getn(x891396_g_SeventhFestivalTopList_Info) then
		return
	end
	local nCurNumber = GetMissionData(sceneId,selfId,x891396_g_SeventhFestivalTopList_Info[nValidIndex].receivemd)
	nCurNumber = nCurNumber + nAddVal
	SetMissionData(sceneId,selfId,x891396_g_SeventhFestivalTopList_Info[nValidIndex].receivemd,nCurNumber)
	
	if nCurNumber < x891396_g_SeventhFestivalTopList_Info[nValidIndex].minNum then
		return
	end
	--这里的0表示第1个排行榜 总共有三个榜，注意
	LuaFnTopListQixiAddCharReciveData(sceneId,selfId,nValidIndex - 1,nCurNumber)
end
--**********************************
--情人结兑换奖励
--**********************************
function x891396_Qingrenjie_Exchange( sceneId,selfId,nIndex)
	if GetLevel(sceneId,selfId) < x891396_g_MinLevel then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_84}")
		return
	end
	local tBouns = x891396_g_SeventhFestivalTopList_Qingrenjie_Bonus[nIndex];
	if tBouns == nil then
		return
	end
	local HaveNum = LuaFnGetAvailableItemCount(sceneId,selfId,x891396_g_NeedItemID)
	if HaveNum < tBouns.neednum then
		x891396_NotifyTip(sceneId,selfId,
			ScriptGlobal_Format("#{QXHB_20210701_168}"
			,tBouns.neednum
		))
		return
	end
	--判断背包格子是否充足
	BeginAddItem(sceneId)
	AddBindItem(sceneId,tBouns.itemid,tBouns.count)
	if EndAddItem(sceneId,selfId,1) <= 0 then
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x891396_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{QXHB_20210701_161}",tostring(iBase)))
		end
		if iMat ~= nil and iMat > 0 then
			x891396_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{QXHB_20210701_162}",tostring(iMat)))
		end
		return
	end
	--判断是否兑换过这个道具
--	local nExchangeData = GetMissionDataEx(sceneId,selfId,MDEX_SUQINGSHOP_DATA)
--	local tExchangeFlag = ScriptGlobal_MathCilCompute_1_InEx(nExchangeData)
--	if tExchangeFlag[nIndex] == 1 then
--		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_169}")
--		return
--	end
	local nLimitedMd = tBouns.LimitMD
	if nLimitedMd ~= -1 then
		local nExchangeCount = GetMissionData(sceneId,selfId,nLimitedMd)
		if nExchangeCount >= tBouns.LimitNum  then
			x891396_NotifyTip(sceneId,selfId,"#{QRZM_211119_306}")
			return
		end
		SetMissionData(sceneId,selfId,nLimitedMd,nExchangeCount + 1)
	end
	--扣除道具，发放道具
	LuaFnDelAvailableItem(sceneId,selfId,x891396_g_NeedItemID,tBouns.neednum)
	--给物品
	AddItemListToHuman(sceneId,selfId)
	--写入记录
--	tExchangeFlag[nIndex] = 1
--	nExchangeData = ScriptGlobal_MathCilCompute_1_OutEx(tExchangeFlag)
--	SetMissionDataEx(sceneId,selfId,MDEX_SUQINGSHOP_DATA,nExchangeData)
	--检测结束，兑换流程走起
	x891396_NotifyTip(sceneId,selfId,
		ScriptGlobal_Format("#{QXHB_20210701_170}"
		,tBouns.count
		,GetItemName(sceneId,tBouns.itemid)
	))
	--更新客户端数量显示
	HaveNum = LuaFnGetAvailableItemCount(sceneId,selfId,x891396_g_NeedItemID)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 2 )
		UICommand_AddInt( sceneId, HaveNum )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89139603 )
end
--**********************************
--诉情蝶兑换
--**********************************
function x891396_SeventhFestivalDoDuiHuan( sceneId,selfId,nExchangeCount)	
	if nExchangeCount < 1 then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20230711_10}")
		return
	end
	local HaveNum = LuaFnGetAvailableItemCount(sceneId,selfId,x891396_g_NeedItemID)
	if nExchangeCount > HaveNum then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20230711_11}")
		return
	end
	--检查当前交子量
	if nExchangeCount + LuaFnGetMoneyJZ(sceneId,selfId) > 144000000 then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20230711_9}")
		return
	end
	--扣除道具
	if LuaFnDelAvailableItem(sceneId,selfId,x891396_g_NeedItemID,nExchangeCount) ~= 1 then
		return
	end
	AddMoneyJZ(sceneId,selfId,nExchangeCount)
	x891396_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20230711_8}",tostring(nExchangeCount)))
end
--**********************************
--打开诉情蝶兑换页面
--**********************************
function x891396_SeventhFestivalOpenDuiHuan( sceneId,selfId)	
	local HaveNum = LuaFnGetAvailableItemCount(sceneId,selfId,x891396_g_NeedItemID)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1 )
		UICommand_AddInt( sceneId, HaveNum )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89139603 )
end

--**********************************
--点击送花榜领奖
--**********************************
function x891396_ClientGetQixiSendTopListPrize( sceneId,selfId,nIndex)
	if GetLevel(sceneId,selfId) < x891396_g_MinLevel then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_84}")
		return
	end
	if nIndex < 1 or nIndex > 3 then
		x891396_NotifyTip(sceneId,selfId,"当前页签不是排行榜")
		return
	end
	--检测是否到了领取时间,防止有人篡改客户端绕过检测
	local nBeginTime,nEndTime = LuaFnTopListGetBaseConfig(nIndex - 1)
	local nCurTime = LuaFnGetCurrentTime()
	local SeventhFestivalTopList_State = 0;
	if nCurTime >= nEndTime then
		SeventhFestivalTopList_State = 6
	elseif nCurTime < nBeginTime then
		SeventhFestivalTopList_State = 0
	else
		SeventhFestivalTopList_State = 1
	end
	if SeventhFestivalTopList_State == 0 then--理论上不存在
		x891396_NotifyTip(sceneId,selfId,x891396_g_SeventhFestivalTopList_Tip[nIndex].tip1)
		return
	elseif SeventhFestivalTopList_State >= 1 and SeventhFestivalTopList_State <= 5 then--排行榜计时中
		x891396_NotifyTip(sceneId,selfId,x891396_g_SeventhFestivalTopList_Tip[nIndex].tip2)
		return
	elseif SeventhFestivalTopList_State == 6 then--可以领奖
	else--理论上不存在
		x891396_NotifyTip(sceneId,selfId,x891396_g_SeventhFestivalTopList_Tip[nIndex].tip3)
		return
	end
	if x891396_g_OpenGetPrize == 0 then
		x891396_NotifyTip(sceneId,selfId,"当前暂时不允许领取奖励")
		return
	end
	--读取送花数据和玩家个人guid是否是和当前名次匹配。
	local nRank = 0;
	local nGuid = LuaFnGetGUID(sceneId,selfId)
	for i = 1,20 do
		local index,guid,name,score = LuaFnTopListGetQixiSendTopListInfo(nIndex - 1,i-1)
		if nGuid == guid and score >= 1000 then
			nRank = i
			break
		end
	end
	--识别奖励领取哪一阶段的数据
	if nRank >= 11 and nRank <= 20 then
		nRank = 11
	end
	--开始走领奖流程
	if nRank == 0 then
		x891396_NotifyTip(sceneId,selfId,"#{QXLS_150724_75}")
		return
	end
	local tCurGift = x891396_g_SeventhFestivalTopListPreview_SGift[nRank]
	if tCurGift == nil then
		x891396_NotifyTip(sceneId,selfId,"领奖物品配置异常，请联系客服处理")
		return
	end
	--读取当前玩家是否已经领取过奖励了
	if GetMissionFlagEx(sceneId,selfId,x891396_g_ClientGetQixiTopListPrizeData[nIndex][1]) > 0 then
		x891396_NotifyTip(sceneId,selfId,"#{QXLS_150724_76}")
		return
	end
	local bCreate = TryCreatePet(sceneId,selfId,1)
	if bCreate < 1 then
		x891396_NotifyTip(sceneId,selfId,"当前已达可携带珍兽数量上限，请清理一些再来领取。")
		return
	end
	--增加奖励
	local bHaveItemPrize = 0
	BeginAddItem(sceneId)
	for i = 1,getn(tCurGift) do
		local tItem = tCurGift[i]
		if tItem.type == 2 then
			AddBindItem( sceneId, tItem.id, tItem.num )
			bHaveItemPrize = 1
		end
	end
	if bHaveItemPrize == 1 then
		if EndAddItem(sceneId,selfId) <= 0 then													 
			local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
			if iBase ~= nil and iBase > 0 then
				x891396_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{QXLS_150724_82}",tostring(iBase)))
			end
			if iMat ~= nil and iMat > 0 then
				x891396_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{QXHB_20210701_162}",tostring(iMat)))
			end
			return
		end
		AddItemListToHuman(sceneId,selfId)
	end

	local szItemTransfer = LuaFnGetItemTransfer(sceneId,selfId,0)
	--领取称号
	for i = 1,getn(tCurGift) do
		local tItem = tCurGift[i]
		if tItem.type == 1 then
			if LuaFnCanAddTitle(sceneId,selfId,tItem.id) ~= 0 then
				LuaFnAwardCharTitle( sceneId, selfId, tItem.id)
				LuaFnSetCurTitleById( sceneId, selfId, tItem.id)
				LuaFnDispatchAllTitle(sceneId, selfId)
			end
		end
	end
	--宠物奖励
	for i = 1,getn(tCurGift) do
		local tItem = tCurGift[i]
		if tItem.type == 3 then
			local ret,petGUID_H,petGUID_L = CallScriptFunction( 800105, "CreateRMBPetToHuman", sceneId, selfId, tItem.id, 1);
			if ret and ret == 1 then
				LuaFnSetPetGrowRateByGUID(sceneId,selfId,petGUID_H,petGUID_L,2388)
				local nPerception = random(tItem.minPer,tItem.minPer + 300)
				local nPetNum = LuaFnGetPetCount(sceneId,selfId)
				for j = 0,nPetNum -1 do
					pet_H, pet_L = LuaFnGetPetGUID(sceneId,selfId,j)
					if pet_L == petGUID_L then
						nPetIndex = j
						break;
					end
				end
				LuaFnSetPet_StrPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_ConPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_DexPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_SprPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_IntPerception(sceneId,selfId,nPetIndex,nPerception)
			end
		end
	end
	
	--写入领取记录
	SetMissionFlagEx(sceneId,selfId,x891396_g_ClientGetQixiTopListPrizeData[nIndex][1],1)
	--醒目提示
	x891396_NotifyTip(sceneId,selfId,x891396_g_ClientQixiTopListPrizeTips[nIndex][1])
	--系统提示
	AddGlobalCountNews(sceneId,"@*;SrvMsg;SCA:"..ScriptGlobal_Format
		(x891396_g_ClientQixiTopListPrizeGlobal[nIndex][1]
		,GetName(sceneId,selfId)
		,szItemTransfer
	))
end

--**********************************
--点击收花榜领奖
--**********************************
function x891396_ClientGetQixiReceiveTopListPrize( sceneId,selfId,nIndex)
	if GetLevel(sceneId,selfId) < x891396_g_MinLevel then
		x891396_NotifyTip(sceneId,selfId,"#{QXHB_20210701_84}")
		return
	end
	if nIndex < 1 or nIndex > 3 then
		x891396_NotifyTip(sceneId,selfId,"当前页签不是排行榜")
		return
	end
	--检测是否到了领取时间,防止有人篡改客户端绕过检测
	local nBeginTime,nEndTime = LuaFnTopListGetBaseConfig(nIndex - 1)
	local nCurTime = LuaFnGetCurrentTime()
	local SeventhFestivalTopList_State = 0;
	if nCurTime >= nEndTime then
		SeventhFestivalTopList_State = 6
	elseif nCurTime < nBeginTime then
		SeventhFestivalTopList_State = 0
	else
		SeventhFestivalTopList_State = 1
	end
	if SeventhFestivalTopList_State == 0 then--理论上不存在
		x891396_NotifyTip(sceneId,selfId,x891396_g_SeventhFestivalTopList_Tip[nIndex].tip1)
		return
	elseif SeventhFestivalTopList_State >= 1 and SeventhFestivalTopList_State <= 5 then--排行榜计时中
		x891396_NotifyTip(sceneId,selfId,x891396_g_SeventhFestivalTopList_Tip[nIndex].tip2)
		return
	elseif SeventhFestivalTopList_State == 6 then--可以领奖
	else--理论上不存在
		x891396_NotifyTip(sceneId,selfId,x891396_g_SeventhFestivalTopList_Tip[nIndex].tip3)
		return
	end
	if x891396_g_OpenGetPrize == 0 then
		x891396_NotifyTip(sceneId,selfId,"当前暂时不允许领取奖励")
		return
	end
	--读取收花数据和玩家个人guid是否是和当前名次匹配。
	local nRank = 0;
	local nGuid = LuaFnGetGUID(sceneId,selfId)
	for i = 1,20 do
		local index,guid,name,score = LuaFnTopListGetQixiReciveTopListInfo(nIndex - 1,i-1)
		if nGuid == guid and score >= 1000 then
			nRank = i
			break
		end
	end
	--识别奖励领取哪一阶段的数据
	if nRank >= 11 and nRank <= 20 then
		nRank = 11
	end
	--开始走领奖流程
	if nRank == 0 then
		x891396_NotifyTip(sceneId,selfId,"#{QXLS_150724_75}")
		return
	end
	local tCurGift = x891396_g_SeventhFestivalTopListPreview_RGift[nRank]
	if tCurGift == nil then
		x891396_NotifyTip(sceneId,selfId,"当前位次没有奖励可以领取")
		return
	end
	--读取当前玩家是否已经领取过奖励了
	if GetMissionFlagEx(sceneId,selfId,x891396_g_ClientGetQixiTopListPrizeData[nIndex][2]) > 0 then
		x891396_NotifyTip(sceneId,selfId,"#{QXLS_150724_75}")
		return
	end
	local bCreate = TryCreatePet(sceneId,selfId,1)
	if bCreate < 1 then
		x891396_NotifyTip(sceneId,selfId,"当前已达可携带珍兽数量上限，请清理一些再来领取。")
		return
	end
	--增加奖励
	local bHaveItemPrize = 0
	BeginAddItem(sceneId)
	for i = 1,getn(tCurGift) do
		local tItem = tCurGift[i]
		if tItem.type == 2 then
			AddBindItem( sceneId, tItem.id, tItem.num )
			bHaveItemPrize = 1
		end
	end
	if bHaveItemPrize == 1 then
		if EndAddItem(sceneId,selfId) <= 0 then													 
			local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
			if iBase ~= nil and iBase > 0 then
				x891396_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{QXLS_150724_82}",tostring(iBase)))
			end
			if iMat ~= nil and iMat > 0 then
				x891396_NotifyTip(sceneId, selfId,ScriptGlobal_Format("#{QXHB_20210701_162}",tostring(iMat)))
			end
			return
		end
		AddItemListToHuman(sceneId,selfId)
	end

	local szItemTransfer = LuaFnGetItemTransfer(sceneId,selfId,0)
	--领取称号
	for i = 1,getn(tCurGift) do
		local tItem = tCurGift[i]
		if tItem.type == 1 then
			if LuaFnCanAddTitle(sceneId,selfId,tItem.id) ~= 0 then
				LuaFnAwardCharTitle( sceneId, selfId, tItem.id)
				LuaFnSetCurTitleById( sceneId, selfId, tItem.id)
				LuaFnDispatchAllTitle(sceneId, selfId)
			end
		end
	end
	--宠物奖励
	for i = 1,getn(tCurGift) do
		local tItem = tCurGift[i]
		if tItem.type == 3 then
			local ret,petGUID_H,petGUID_L = CallScriptFunction( 800105, "CreateRMBPetToHuman", sceneId, selfId, tItem.id, 1);
			if ret and ret == 1 then
				LuaFnSetPetGrowRateByGUID(sceneId,selfId,petGUID_H,petGUID_L,2388)
				local nPerception = random(tItem.minPer,tItem.minPer + 300)
				local nPetNum = LuaFnGetPetCount(sceneId,selfId)
				for j = 0,nPetNum -1 do
					pet_H, pet_L = LuaFnGetPetGUID(sceneId,selfId,j)
					if pet_L == petGUID_L then
						nPetIndex = j
						break;
					end
				end
				LuaFnSetPet_StrPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_ConPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_DexPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_SprPerception(sceneId,selfId,nPetIndex,nPerception)
				LuaFnSetPet_IntPerception(sceneId,selfId,nPetIndex,nPerception)
			end
		end
	end
	
	--写入领取记录
	SetMissionFlagEx(sceneId,selfId,x891396_g_ClientGetQixiTopListPrizeData[nIndex][2],1)
	--醒目提示
	x891396_NotifyTip(sceneId,selfId,x891396_g_ClientQixiTopListPrizeTips[nIndex][2])
	--系统提示
	AddGlobalCountNews(sceneId,"@*;SrvMsg;SCA:"..ScriptGlobal_Format
		(x891396_g_ClientQixiTopListPrizeGlobal[nIndex][2]
		,GetName(sceneId,selfId)
		,szItemTransfer
	))
end

--**********************************
--帮助信息
--**********************************
function x891396_SeventhFestivalTopListHelp( sceneId,selfId,nPage)	
	--这里似乎没有采用nPage 预留着
	BeginEvent(sceneId)
		AddText( sceneId, "#{QXHB_20210701_141}" )		
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end
--**********************************
--玩家登陆
--**********************************
function x891396_OnHumanLogin( sceneId, selfId )
	if GetLevel(sceneId,selfId) < x891396_g_MinLevel then
		return
	end
	if x891396_GetCurTopListEndTime(sceneId,selfId) > 0 then
		--【运行调整】屏蔽入口显示
--		BeginUICommand( sceneId )
--			UICommand_AddInt( sceneId, 0 )	--flash
--		EndUICommand( sceneId )
--		DispatchUICommand( sceneId, selfId, 89139601 )
	end
end

--**********************************
--获取当前有效的排行榜索引
--**********************************
function x891396_GetCurTopListIndex(sceneId,selfId)
	local nCurTime = LuaFnGetCurrentTime()
	for i = 1,getn(x891396_g_SeventhFestivalTopList_Info) do
		local nBeginTime,nEndTime = LuaFnTopListGetBaseConfig(i - 1)
		if nBeginTime == 0 then
			return 0;
		end
		--榜单是否是开启时间内
		if nCurTime >= nBeginTime and nCurTime < nEndTime then
			return i;
		end
	end
	return 0
end
--**********************************
--获得七夕花榜总结束时间数据
--**********************************
function x891396_GetCurTopListEndTime(sceneId,selfId)
	local nCurTime = LuaFnGetCurrentTime()
	local nBeginTime,nEndTime = LuaFnTopListGetBaseConfig(0)
	for i = 2,getn(x891396_g_SeventhFestivalTopList_Info) do
		local iBeginTime,iEndTime = LuaFnTopListGetBaseConfig(i - 1)
		if iBeginTime < nBeginTime then
			nBeginTime = iBeginTime
		end
		if iEndTime > nEndTime then
			nEndTime = iEndTime
		end
	end
	--最后一个榜单，结束后多一天，将数据+1天，空余一天的领奖，再过一天就关闭了
	if nCurTime <= nEndTime + 24 * 60 * 60 then
		if nEndTime > GetMissionDataEx(sceneId,selfId,MDEX_QIXITOPLIST_ENDTIME) then
			SetMissionDataEx(sceneId,selfId,MDEX_QIXITOPLIST_ENDTIME,nEndTime) --记录本次开榜时间
			--清空所有个人数据
			for i = 1,getn(x891396_g_SeventhFestivalTopList_Info) do
				SetMissionData(sceneId,selfId,x891396_g_SeventhFestivalTopList_Info[i].sendmd,0)
				SetMissionData(sceneId,selfId,x891396_g_SeventhFestivalTopList_Info[i].receivemd,0)
				SetMissionFlagEx(sceneId,selfId,x891396_g_ClientGetQixiTopListPrizeData[i][1],0)
				SetMissionFlagEx(sceneId,selfId,x891396_g_ClientGetQixiTopListPrizeData[i][2],0)
				--兑换商店次数也清空
				SetMissionDataEx(sceneId,selfId,MDEX_SUQINGSHOP_DATA,0)
			end
		end
		return 1
	end
	return 0
end
--**********************************
-- 信息提示
--**********************************
function x891396_NotifyTip(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
