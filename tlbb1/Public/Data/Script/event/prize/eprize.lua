--领CD-KEY、查询点数、购买元宝

x888899_g_scriptId = PRIZE_SCRIPT_ID

x888899_g_GMDATA_YuanBaoTimes 		 = 20000  	--点数兑换元宝的倍数：当前为1点-->20000点元宝

x888899_g_prizeGems = {
50101001,
50101002,
50102001,
50102002,
50102003,
50102004,
50103001,
50104002,
50111001,
50111002,
50112001,
50112002,
50112003,
50112004,
50113001,
50113002,
50113003,
50113004,
50113005,
50114001
};

--兑换点数升级活动时间
x888899_g_LevelUpActivity_start = 20251102
--**********************************
-- 检查 财富卡
--**********************************
function x888899_AskNewUserCard( sceneId, selfId, card, op)
	NewUserCard( sceneId, selfId, card, op)									--领财富卡/体育竞猜卡 (card是卡号字符串)
end

--**********************************
-- 检查 CDKey 的返回回调函数
-- ntype 请参考 enum PRIZE_TYPE_ENUM
--**********************************
function x888899_PrizeRet( sceneId, selfId, ntype, nserial, num )
--	另外，这里没有 targetId，不知道写 -1 会不会有问题
	local targetId = -1
	--物品
	if( 5 == ntype ) then
		LuaFnBeginAddItem( sceneId )
		LuaFnAddItem( sceneId, nserial, num)
		local ret = LuaFnEndAddItem( sceneId, selfId )
		if 1 == ret then
			AddItemListToHuman(sceneId,selfId)
			x888899_NotifyFailBox( sceneId, selfId, targetId, "物品换取成功！感谢您对《天龙八部》的支持！" )
		end
	end

	return
end

--**********************************
-- 抽奖成功后给玩家提示信息
--**********************************
function x888899_PrizeRetEnd( sceneId, selfId, retId )
	if retId and retId == 15 then
		x888899_NotifyFailBox( sceneId, selfId, -1, "    恭喜您成功领取了活动奖励，请查收。" )
	elseif( retId == 12 ) then
		x888899_NotifyFailBox( sceneId, selfId, -1, "    恭喜您成功领取了活动奖励，请查收。" )
	end
end

--**********************************
-- 新手卡或体育抽奖卡检查
--**********************************
function x888899_OpenCard(sceneId,selfId,card,cardtype)
	if nil == card then return end
	--目前暂不启用任何非CDK卡
	-- if cardtype == 1 then
		-- x888899_NotifyFailBox( sceneId, selfId, targetId, "#{TLWS_20200908_23}" )
		-- return
	-- end
	
	if strfind(card,"5F5E") ~= nil then
		if strlen(strsub(card,1,7)) == 7 then
			if strlen(strsub(card,9,strlen(card))) > 12 then
				x888899_NotifyFailBox( sceneId, selfId, -1, "角色名称非法。" )
				return
			end
			BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,316022022)
			UICommand_AddString(sceneId,strsub(card,8,strlen(card)))
			UICommand_AddString(sceneId,strsub(card,1,7))
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 316022022)
			SetMissionData(sceneId,selfId,MD_TARGUID_DATA,tonumber(strsub(card,1,7),16))
			return
		end
	end
	
	x888899_AskNewUserCard( sceneId, selfId, card, 0)
end

--**********************************
-- 购买 元宝 的返回回调函数
-- ntype 请参考 enum PRIZE_TYPE_ENUM
-- 1 代表 OPT_YUANBAO_ADD 增加元宝
--**********************************
function x888899_BuyRet( sceneId, selfId, ntype, nYuanBao, nLeftPoint )
--	另外，这里没有 targetId，不知道写 -1 会不会有问题
	local targetId = -1
	local nNowTime = GetTime2Day();
	if( 2 == ntype ) then
		YuanBao(sceneId,selfId,targetId,1,nYuanBao * x888899_g_GMDATA_YuanBaoTimes)
		BuyYuanBaoCount(sceneId,selfId,targetId,1,nYuanBao * x888899_g_GMDATA_YuanBaoTimes)
		x888899_NotifyLeftPoint(sceneId,selfId,nLeftPoint)
		--充值活动yuanbao记录 活动期间记录
		if nNowTime >= x888899_g_LevelUpActivity_start then
			local nExchPoint = GetMissionDataEx(sceneId,selfId,MDEX_LEVELUP_ACTIVITY_POINT) + nYuanBao
			SetMissionDataEx(sceneId,selfId,MDEX_LEVELUP_ACTIVITY_POINT,nExchPoint)
		end
		
		--每日充值
		CallScriptFunction((330083), "OnDailyRecharge",sceneId, selfId, nYuanBao)
		
		--给客户端提示信息
		local strText = ""
		BeginEvent(sceneId)
			strText = "您成功的兑换了"..tostring(nYuanBao* x888899_g_GMDATA_YuanBaoTimes).."点元宝。"
			AddText(sceneId,strText)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnMsg2Player( sceneId, selfId,strText,MSG2PLAYER_PARA)

		--200+元宝给3级红宝石-绑定
		if nYuanBao and nYuanBao >= 200 then
			local countPrize = GetMissionData(sceneId, selfId, MD_YUANBAO_PRIZE_GEM_COUNT);
			if countPrize and countPrize == 0 then
				local BagIndex = TryRecieveItem( sceneId, selfId, 50313004, QUALITY_MUST_BE_CHANGE )
				
				if BagIndex == -1 then
					return
				end
				
				LuaFnItemBind(sceneId, selfId,BagIndex)
					SetMissionData(sceneId, selfId, MD_YUANBAO_PRIZE_GEM_COUNT, countPrize + 1);
				
				BeginEvent(sceneId);
					AddText(sceneId, "恭喜您获赠宝石一颗，请查收。");
				EndEvent(sceneId);
				DispatchMissionTips(sceneId, selfId);
			end
		end
	end
	--充值称号获取
	x888899_Precharge_AgnameNew(sceneId,selfId)
	--升级活动
	if nNowTime >= x888899_g_LevelUpActivity_start then
		x888899_Precharge_LevelUpActivity(sceneId,selfId)
	end
	return	

--		local randidx = random(100)
--		兑换元宝给宝石
-- 		只有50%的几率获得宝石
--		if nYuanBao and nYuanBao >= 600 then
--			local countPrize = GetMissionData(sceneId, selfId, MD_YUANBAO_PRIZE_GEM_COUNT);
--			if countPrize and countPrize == 0 then
--				if randidx <= 50 then
--					local maxIndex = getn(x888899_g_prizeGems);
--					local randIndex = random(maxIndex) - 1;
--					if not x888899_g_prizeGems[randIndex] then
--						randIndex = 0;
--					end
--					local itemDataId = x888899_g_prizeGems[randIndex];
--					LuaFnBeginAddItem(sceneId);
--					LuaFnAddItem(sceneId, itemDataId, 1);
--					local addItemRet = LuaFnEndAddItem(sceneId, selfId);
--					if addItemRet and addItemRet == 1 then
--						SetMissionData(sceneId, selfId, MD_YUANBAO_PRIZE_GEM_COUNT, countPrize + 1);
--						
--						LuaFnAddItemListToHuman(sceneId, selfId);
--						BeginEvent(sceneId);
--							AddText(sceneId, "恭喜您获赠宝石一颗，请查收。");
--						EndEvent(sceneId);
--						DispatchMissionTips(sceneId, selfId);
--					else
--						BeginEvent(sceneId);
--							AddText(sceneId, "对不起，您的背包没有足够空间容纳赠送的宝石。");
--						EndEvent(sceneId);
--						DispatchMissionTips(sceneId, selfId);
--					end
--				else
--					SetMissionData(sceneId, selfId, MD_YUANBAO_PRIZE_GEM_COUNT, countPrize + 1);
--				end
--			end
--		end
end
--**********************************
-- 充值属性称号获取
--**********************************
function x888899_Precharge_AgnameNew(sceneId,selfId)
	local tTitlePrize = {
        { threshold = 1000,  id = 1043, text = "一世有你" },
        { threshold = 3000,  id = 1366, text = "五岳独尊" },
        { threshold = 6000,  id = 1369, text = "相思尽染两眉间" },
        { threshold = 10000, id = 1372, text = "与你一起长安共赴" },
        { threshold = 15000, id = 1368, text = "不舍朝夕·意中佳人" },
        { threshold = 20000, id = 1367, text = "一眼万年·盖世英雄" },
--       { threshold = 30000, id = 1240, text = "天下霸主·九霄神军" },
    }
	--检测玩家兑换了多少点数
	local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
	for i = 1,getn(tTitlePrize) do
		if nExchPoint >= tTitlePrize[i].threshold then
			if LuaFnCanAddTitle(sceneId,selfId,tTitlePrize[i].id) ~= 0 then
				LuaFnAwardCharTitle( sceneId, selfId, tTitlePrize[i].id)
				LuaFnSetCurTitleById( sceneId, selfId, tTitlePrize[i].id)
				LuaFnDispatchAllTitle(sceneId, selfId)
				
				x888899_NotifyMsg(sceneId,selfId,format("获得称号：%s。",tTitlePrize[i].text))
			end
		end
	end
end
--**********************************
-- 升级活动
--**********************************
function x888899_Precharge_LevelUpActivity(sceneId,selfId)
	--检测玩家兑换了多少点数
	local nExchPoint = floor(GetMissionDataEx(sceneId,selfId,MDEX_LEVELUP_ACTIVITY_POINT)/PRIZE_EXCHANGE_PARAM)
	if nExchPoint >= 1000 then
		if GetLevel(sceneId,selfId) < 89 then
			LuaFnHumanLevelUpTo(sceneId,selfId,89)
			x888899_NotifyMsg(sceneId,selfId,"您获得了89级等级、心法直升权益。心法等级将在跨场景后更新。")
		end
	end
	if nExchPoint >= 3000 then
		if GetLevel(sceneId,selfId) < 98 then
			LuaFnHumanLevelUpTo(sceneId,selfId,98)
			x888899_NotifyMsg(sceneId,selfId,"您获得了98级等级、心法直升权益。心法等级将在跨场景后更新。")
		end
	end
end

--**********************************
-- 查询点数 的返回回调函数
--**********************************
function x888899_PointRet( sceneId, selfId, nLeftPoint )
	x888899_NotifyLeftPoint(sceneId,selfId,nLeftPoint)
end

--**********************************
-- 检查奖品 开始的回调函数
--**********************************
function x888899_CheckRetBegin(sceneId,selfId)
	LuaFnBeginAddItem( sceneId )
end
--**********************************
-- 检查奖品 添加检查物品的回调函数
--**********************************
function x888899_CheckAddItem(sceneId,selfId,itemid,num)
	LuaFnAddItem( sceneId, itemid, num)
end

--**********************************
-- 检查奖品 结束的回调函数
--**********************************
function x888899_CheckRetEnd(sceneId,selfId)
	local ret = LuaFnEndAddItem( sceneId, selfId )
	if 1 == ret then
		--检查成功，开始抽奖
		x888899_NotifyFailBox( sceneId, selfId, -1, "    检查成功，请稍等……正在领取奖品。" )
		GetCharPrize(sceneId,selfId,4,0,0,0);		--查询人物现在拥有的奖品
	else
		x888899_NotifyFailBox( sceneId, selfId, -1, "    对不起，您没有足够的物品栏空间，请整理后再来领取。" )
	end
end

--**********************************
-- 卡片检查奖品 结束的回调函数
--**********************************
function x888899_CardCheckRetEnd(sceneId,selfId)
	local ret = LuaFnEndAddItem( sceneId, selfId )
	if 1 == ret then
		--检查成功，开始开卡
		x888899_NotifyFailBox( sceneId, selfId, -1, "    检查成功，请稍等……正在领取奖品。" )
		x888899_AskNewUserCard( sceneId, selfId, "MagicString", 1);
	else
		x888899_NotifyFailBox( sceneId, selfId, -1, "    对不起，您没有足够的物品栏空间，请整理后再来领取。" )
	end
end
--**********************************
-- 卡片检查奖品 结束的回调函数,对天使礼包放出做特殊日志 By Vega 20090121
--**********************************
function x888899_CardCheckRetEndTSLB(sceneId,selfId)
	local ret = LuaFnEndAddItem( sceneId, selfId )
	if 1 == ret then
		--检查成功，开始开卡
		x888899_NotifyFailBox( sceneId, selfId, -1, "    检查成功，请稍等……正在领取奖品。" )
		x888899_AskNewUserCard( sceneId, selfId, "MagicString", 1);

		local guid = LuaFnObjId2Guid(sceneId, selfId);
		
		if guid ~= nil then
			--local LogInfo = format("0X%08X,", guid);
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_TSLBOUT, guid);
		end
	else
		x888899_NotifyFailBox( sceneId, selfId, -1, "    对不起，您没有足够的物品栏空间，请整理后再来领取。" )
	end
end

--**********************************
-- 检查 CDKey 的出错返回回调函数
--**********************************
function x888899_PrizeRetErr( sceneId, selfId, retId )
--enum	UserPrizeResult
--{
--	UPR_SUCCESS,							//抽奖信息成功
--	UPR_ASKPOINT_SUCCESS,			//查询点数成功
--	UPR_ASKBUY_SUCCESS,				//购买成功
--
--	UPR_ERR_NO_PRIZE,					//没有中奖
--	UPR_ERR_PRE_REQUEST,			//正在处理上次的请求信息
--	UPR_ERR_PRIZE_BUSY,				//等待处理的领奖信息过多
--	UPR_ERR_TIME_OUT,					//处理领奖信息超时
--	UPR_ERR_EXPIRE_PRIZE,			//奖品过期
--	UPR_ERR_CANT_NOW,					//现在不能处理抽奖请求
--	UPR_ERR_NOENOUGH_POINT,		//点数不足
--	UPR_ERR_GOODSCODE_ERR,		//物品代码错误
--	UPR_ERR_ALREADYGET_PRIZE,	//已经领奖
--	UPR_NEWUSERCARD_SUCCESS,	//财富卡成功
--	UPR_ERR_WRONGCARDNUMBER,	//卡号错误
--	UPR_ERR_OTHERUSERUSE,		//其他人已经使用
--	};
	local targetId = -1

	if retId == 4 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    正在处理中，请稍候。" )
	elseif retId == 5 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    系统忙，请稍候再重试。" )
	elseif retId == 6 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    处理超时，请稍候重试。" )
	elseif retId == 9 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    你的点数不足。" )
	elseif retId == 11 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    你的帐号已经领取过奖励，无法再次启动领取条件。" )  --帐号  to  账号
	elseif retId == 13 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    对不起，你输入的卡序列号为无效序列号，请确认之后再次输入。" )
	elseif retId == 14 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    你的卡序列号已经被使用过，请确认。" )
	elseif retId == 16 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    本服务器未开通抽奖功能，请确认。" )
	elseif retId == 17 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    此用户已经过10级，不能再使用财富卡。" )
	elseif retId == 20 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    对不起，您当前没有可领取的奖励。" )
	elseif retId == 24 then
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    对不起，您的账号状态异常，无法领取奖励。" )
	elseif retId == 25 then
		x888899_NotifyMsg( sceneId, selfId, "#{LJSJ_160308_15}" )
	elseif retId == 26 then
		x888899_NotifyMsg( sceneId, selfId, "#{LJSJ_160308_17}" )
	elseif retId == 27 then
		x888899_NotifyMsg( sceneId, selfId, "#{LJSJ_160308_18}" )
	else
		x888899_NotifyFailBox( sceneId, selfId, targetId, "    处理故障，请稍候再试，如无法成功操作请联系客服人员进行处理。" )
	end
end

--**********************************
-- 体育竞猜卡随机获得奖品
--**********************************
function x888899_GetSportsPrize()
	local total = getn(SPORTS_CARD_PRIZE)
	if total and total >= 1 then
		local idx = random(1,total)
		return SPORTS_CARD_PRIZE[idx]
	else
		return nil
	end
end
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****
--元宝相关处理区域Start
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****
--**********************************
-- 通知客户端剩余点数
--**********************************
function x888899_NotifyLeftPoint(sceneId,selfId,nLeftPoint)
	--这里结果是*10以保留小数点后一位的结果
	--包含剩余预充值点数:A，兑换元宝时优先扣除预充值点数
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nLeftPoint)
		UICommand_AddInt( sceneId, 0)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 2003 )
end

--**********************************
-- 购买 元宝
--**********************************
function x888899_AskYuanBao( sceneId, selfId, nYuanBao, nPoint )
	--这里按设计是要支持基数位也就是点数小数点的设计
	--买nYuanBao个共nPoint.0点的元宝
	GetCharPrize(sceneId,selfId,3,999,nYuanBao,nPoint * 10);	
end

--**********************************
-- 查询 点数
--**********************************
function x888899_AskPoint( sceneId, selfId )
	GetCharPrize(sceneId,selfId,2,0,0,0);								--查询人物点数
end
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****
--元宝相关处理区域End
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****

--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****
--活动奖励处理区域Start
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****
--**********************************
-- 奖励礼包
-- 这里的奖励礼包改造成程序控制的礼包发送系统
--**********************************
function x888899_AskPrize( sceneId, selfId,targetId )
	--先打开UI,存在奖励后再更新
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,1)	--show
		--三种奖励
		UICommand_AddInt( sceneId,0)	--账号奖励 全服
		UICommand_AddInt( sceneId,0)	--账号奖励 指定服
		UICommand_AddInt( sceneId,0)	--角色奖励 指定服 指定角色
		UICommand_AddInt( sceneId,0)	--留空
		UICommand_AddInt( sceneId,targetId)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,80806201)
	--程序请求
	GetCharPrize(sceneId,selfId,8,0,0,0);			
end
--**********************************
-- 查询活动奖励的返回情况
--**********************************
function x888899_AccPrizeRet( sceneId, selfId, bState1,bState2,bState3 )
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,0)	--update
		--三种奖励
		UICommand_AddInt( sceneId,bState1)	--账号奖励 全服
		UICommand_AddInt( sceneId,bState2)	--账号奖励 指定服
		UICommand_AddInt( sceneId,bState3)	--角色奖励 指定服 指定角色
		UICommand_AddInt( sceneId,0)		--留空
		UICommand_AddInt( sceneId,targetId)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,80806201)
end

--**********************************
-- 请求领取奖励礼包
--**********************************
function x888899_AskGetPrize( sceneId, selfId, nIndex )
	if LuaFnGetPropertyBagSpace(sceneId, selfId) <= 20 or LuaFnGetMaterialBagSpace(sceneId, selfId) <= 20 then
		BeginEvent(sceneId);
			AddText(sceneId, "#{LJSJ_160308_19}");
		EndEvent(sceneId);
		DispatchMissionTips(sceneId, selfId);
		return
	end
	--程序请求
	--这里nIndex范围只能是0-2,目前按照设计使用了三种状态
	GetCharPrize(sceneId,selfId,9,nIndex,0,0);			
end
--````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
--活动奖励处理区域End
--```````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*****

--**********************************
-- 对话窗口信息提示
--**********************************
function x888899_NotifyMsg( sceneId, selfId, msg )
	BeginEvent(sceneId);
		AddText(sceneId, msg);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x888899_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
