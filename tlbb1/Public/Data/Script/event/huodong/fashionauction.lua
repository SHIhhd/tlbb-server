--时装拍卖活动

--脚本号
x888818_g_scriptId = 888818
x888818_g_MinLevel = 30
x888818_g_RefreshTime = 5	--可刷新的间隔时间
--可直接购买时装
x888818_g_FashionCloth = 10125357
--可直接购买时装花费
x888818_g_FashionClothPrice = 188888
x888818_g_FashionClothBuyLevel = 15
--**********************************
--直接购买普通时装
--**********************************
function x888818_BuyFashionCloth( sceneId, selfId,bConfrim )
	if bConfrim == 0 then
		--二次确认
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881805 )	
		return
	end
	if GetLevel(sceneId,selfId) < x888818_g_FashionClothBuyLevel then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_231218_04}")
		return
	end
	local nCurYuanbao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanbao < x888818_g_FashionClothPrice then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_231218_05}" );
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,x888818_g_FashionClothPrice) ~= 1 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_231218_06}" );
		return
	end
	--背包空间加测
	BeginAddItem(sceneId)
	AddBindItem( sceneId,x888818_g_FashionCloth,1)	
	if EndAddItem(sceneId,selfId) <= 0 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_231218_08}" );
		return
	end
	if LuaFnCostYuanBao(sceneId,selfId,x888818_g_FashionClothPrice,888818,"BuyFashionCloth",0,0) ~= 1 then
		return
	end
	--给东西
	AddItemListToHuman(sceneId,selfId)
	x888818_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SZPM_231218_07}",tostring(1),GetItemName(sceneId,x888818_g_FashionCloth)) );
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end

--**********************************
--取回返还元宝
--**********************************
function x888818_TakeBackYuanBao( sceneId, selfId )
	if LuaFnIsInFashionAuctionTime() < 1 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_37}")
		return
	end
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_38}")
		return
	end
	local nCurYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO)
	if nCurYuanBao <= 1 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_39}")
		return
	end
	local nHaveYuanBao = YuanBao(sceneId,selfId,-1,3)
	if nHaveYuanBao > 200000000 then
		x888818_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SZPM_230913_41}",tostring(nCurYuanBao)))
		return
	end
	local ybOp = YuanBao(sceneId,selfId,-1,1,nCurYuanBao)
	if ybOp == 0 then
		x888818_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SZPM_230913_40}",tostring(nCurYuanBao)))
		SetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO,0)
	else
		x888818_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SZPM_230913_42}",tostring(nCurYuanBao)))
	end
end

--**********************************
--取回奖励时装
--**********************************
function x888818_TakeBonusFashion( sceneId, selfId )
	if LuaFnIsInFashionAuctionTime() < 1 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_37}")
		return
	end
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_38}")
		return
	end
	LuaFnAskNpcScriptMail(sceneId,selfId,MAIL_FASHION_AUCTION_PRIZE)
end

--**********************************
--关注
--**********************************
function x888818_Follow( sceneId, selfId,bid_id )
	if LuaFnIsInFashionAuctionTime() < 1 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_01}")
		return
	end
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_02}")
		return
	end
	LuaFnTryChangeFashionAuctionFollow(sceneId,selfId,bid_id)
end

--**********************************
--新的叫价
--**********************************
function x888818_NewBidding( sceneId, selfId,nSection,nGroupIndex,nNewPrice )
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		--您的等级不足30级，无法出价。
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_68}")
		return
	end
	if nNewPrice > 499999999 then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_75}")
		return
	end
	local nCurYuanbao = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYuanbao < nNewPrice then
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_74}" );
		return
	end
	--其余的程序实现
	LuaFnTryFashionAuctionNewBidding(sceneId,selfId,nSection,nGroupIndex,nNewPrice)
end

--**********************************
--打开竞价UI
--**********************************
function x888818_OpenBidUI( sceneId, selfId,bFlag,nSection,nGroupIndex,bCheckCD )
	--bFlag 0:open 1:update
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		if bFlag == 0 then
			--您的等级不足30级，无法出价。
			x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_68}")
		else
			--尚未达到30级，无法刷新。	
			x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_58}")
		end
		return
	end
	if bCheckCD == 1 then
		local nLastOp = GetMissionDataEx(sceneId,selfId,MDEX_LAST_BID_FASHIONAUCTION)
		local nCurTime = LuaFnGetCurrentTime()
		if nLastOp > 0 and nCurTime - nLastOp < x888818_g_RefreshTime then
			--SZPM_230913_59	点击过于频繁，请于%s0秒后再尝试刷新。	
			x888818_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SZPM_230913_59}",
				tostring(nLastOp + x888818_g_RefreshTime - nCurTime)))
			return
		end
		SetMissionDataEx(sceneId,selfId,MDEX_LAST_BID_FASHIONAUCTION,nCurTime)
	end
	--请求程序操作
	--tips 竞价行为本身是2000ms的冷却时间 刷新最低程序限制1000ms刷新时间
	local nRet = LuaFnTryFashionAuctionBid(sceneId,selfId,bFlag,nSection,nGroupIndex,bCheckCD)
	if nRet == 0 then
		return
	elseif nRet == -1 then
		if bFlag == 1 then
			--当前不在竞价时间内，无法刷新。	
			x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_57}")
		else
			--当前不在活动时间内，无法进行此操作。	
			x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_01}")
		end
		return
	elseif nRet == -2 then
		--当前不在竞拍时间内，无法出价。	
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_69}")
		return
	elseif nRet == -3 then
		--该物品无法竞拍，请重新选择。	
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_71}")
		return
	elseif nRet == -4 then
		--参与竞拍物品数达到上限20项，无法再出价其他竞拍物品。	
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_72}")
		return
	end
end

--**********************************
--客户端请求打开拍卖入口
--**********************************
function x888818_TryOpenFashionAuction( sceneId, selfId ,bInPage,nSection,bCheckCD )
	if bInPage ~= 0 and bInPage ~= 1 then
		return
	end
	
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		if bInPage == 1 then
			--尚未达到30级，无法刷新。	
			x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_58}")
		else
			--当前不在活动时间内，无法进行此操作。	
			x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_02}")
		end
		return
	end
	if bCheckCD == 1 then
		local nLastOp = GetMissionDataEx(sceneId,selfId,MDEX_LAST_OP_FASHIONAUCTION)
		local nCurTime = LuaFnGetCurrentTime()
		if nLastOp > 0 and nCurTime - nLastOp < x888818_g_RefreshTime then
			--SZPM_230913_59	点击过于频繁，请于%s0秒后再尝试刷新。	
			x888818_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SZPM_230913_59}",
				tostring(nLastOp + x888818_g_RefreshTime - nCurTime)))
			return
		end
		SetMissionDataEx(sceneId,selfId,MDEX_LAST_OP_FASHIONAUCTION,nCurTime)
	end

	--请求程序操作
	--tips 打开操作是2000ms的冷却时间 刷新最低程序限制1000ms刷新时间
	local nRet = LuaFnTryOpenFashionAuction(sceneId,selfId,bInPage,nSection,bCheckCD)
	if nRet == 0 then
		return
	elseif nRet == -1 then
		--当前不在活动时间内，无法进行此操作。	
		x888818_NotifyTips(sceneId, selfId, "#{SZPM_230913_01}")
		return
	elseif nRet == 1 then
		if bInPage == 0 then
			LuaFnAskCheckNpcScriptMail(sceneId,selfId,MAIL_FASHION_AUCTION_PRIZE)
		end
	end
end

--**********************************
--玩家登录游戏
--**********************************
function x888818_OnHumanLogin( sceneId, selfId )
	if LuaFnIsInFashionAuctionTime() < 1 then
		x888818_UpdateEnterState( sceneId, selfId,0,0 )
		return
	end
	if GetLevel(sceneId,selfId) < x888818_g_MinLevel then
		x888818_UpdateEnterState( sceneId, selfId,0,0 )
		return
	end
	x888818_UpdateEnterState( sceneId, selfId,1,1 )
	--提示还有需要领取的元宝
	local nCurYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_FASHIONAUCTION_BACKYUANBAO)
	if nCurYuanBao > 0 then
		LuaFnSendSystemMail( sceneId, GetName( sceneId, selfId ), "#{SZPM_230913_93}" )
	end
end

--**********************************
--更新入口状态
--**********************************
function x888818_UpdateEnterState( sceneId, selfId,bShow,bShowAnimate )
	if bShow ~= nil then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, bShow)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881803 )
	end
	if bShowAnimate ~= nil then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, bShowAnimate)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 88881804 )
	end
end

--**********************************
-- 信息提示
--**********************************
function x888818_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
