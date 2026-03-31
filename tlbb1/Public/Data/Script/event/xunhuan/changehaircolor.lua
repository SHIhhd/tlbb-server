--调整发色
--脚本号
x801011_g_ScriptId = 801011
x801011_g_MaxColorCount = 20

--**********************************
--列举事件
--**********************************
function x801011_OnEnumerate( sceneId, selfId, targetId )
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 80101101)
	return

end

--**********************************
--调整发色
--**********************************
function x801011_ChangeHairColor( sceneId, selfId, nIndex)
	if nIndex < 0 or nIndex >= x801011_g_MaxColorCount then
		return
	end
	--取得有效的发色数量
	local nValidCount = LuaFnGetExteriorHairColorCount(sceneId,selfId)
	if nIndex >= nValidCount then
		x801011_NotifyTip(sceneId,selfId,"#{GXHDZ_141121_57}")
		return	
	end
	--执行发色更换
	LuaFnExteriorChangeHairColorByIndex(sceneId,selfId,nIndex);
	
	x801011_NotifyTip( sceneId, selfId, "#{GXHDZ_141121_56}" )
end

--**********************************
--调整发色
--**********************************
function x801011_SaveNewHairColor( sceneId, selfId, ColorValue,nYuanBaoPay,nReplaceIdx)
	-- 染发剂
	local item = {20307001, 20307002} -- zchw
	-- 颜色的有效性检查
--	local color_r, color_g, color_b, color_a = ConventOgreColor2RGBA(ColorValue)
--	if color_a > 126 then
--		x801011_NotifyTip(sceneId,selfId,"#{WGYH_210827_05}")
--		return
--	end
	-- 检查可用道具
	local itemCount = LuaFnGetAvailableItemCount ( sceneId, selfId, item[1] ); -- zchw
	local itemCount2 = LuaFnGetAvailableItemCount ( sceneId, selfId, item[2] ); 
	if (itemCount < 1) and (itemCount2 < 1) then
		--元宝快捷购买
		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,6, item[1],nYuanBaoPay)
		if nNeedMoney ~= nil then
		
			local strTips = ScriptGlobal_Format("#{XFYH_20120221_18}",
			tostring(item[1]),tostring(nNeedMoney),"#{XFYH_20120221_10}","#{XFYH_20120221_12}",tostring(item[1]))
			
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 6 )
				UICommand_AddInt( sceneId, nMoneyUnit )
				UICommand_AddInt( sceneId, nNeedMoney )
				UICommand_AddInt( sceneId, itemIndex )
				UICommand_AddInt( sceneId, 0 )
				UICommand_AddInt( sceneId, x801011_g_ScriptId )
				UICommand_AddInt( sceneId, nYuanBaoPay )
				UICommand_AddInt( sceneId, -1 )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddString(sceneId,strTips)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20120222 )
		else
			x801011_NotifyTip(sceneId,selfId,"#{GXHDZ_141121_54}")
		end
		return	
	end
	
	-- 检查金钱
	local money = GetMoney(sceneId, selfId);
	local moneyJZ = GetMoneyJZ(sceneId, selfId);
	if money + moneyJZ < 50000 then
		x801011_NotifyTip(sceneId,selfId,"#{WGYH_210827_06}")
		return	
	end
	
	-- 扣除交子和金钱	
	local costMoneyJZ, costMoney = LuaFnCostMoneyWithPriority (sceneId, selfId, 50000)
	
	-- 如果入口参数错误
	if costMoneyJZ == -1 then
		return
	end
	
	-- 交子和金钱数目足额扣除
	if (costMoneyJZ + costMoney == 50000) then	
		--检查有无重复
		local count = LuaFnGetExteriorHairColorCount(sceneId,selfId)
		if count >= x801011_g_MaxColorCount then
			if nReplaceIdx == -1 then
				--不替换？吃干饭？
				BeginUICommand( sceneId )
					UICommand_AddInt( sceneId, ColorValue )
					UICommand_AddInt( sceneId, nYuanBaoPay )
				EndUICommand( sceneId )
				DispatchUICommand( sceneId, selfId, 80101102 )
				return
			end
		end
		-- 消耗物品
		if (itemCount2 >= 1) then
			DelItem( sceneId, selfId, item[2], 1 ); -- zchw 优先删除绑定的染发剂
		else
			DelItem( sceneId, selfId, item[1], 1 );
		end
		--增加新的发色
		LuaFnAddNewExteriorHairColorAndSave(sceneId,selfId,ColorValue,nReplaceIdx)
		--发色UI更新
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 201203141 )   
		if nReplaceIdx ~= -1 then
			BeginUICommand( sceneId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 80101103 )   
		end
		
		x801011_NotifyTip(sceneId,selfId,"#{GXHDZ_141121_43}")
		
		-- 发送广播
		local message;	
		local randMessage = random(3);	
		if randMessage == 1 then		
		message = format("#W#{_INFOUSR%s}#{FaSe_00}", LuaFnGetName(sceneId, selfId));
		elseif randMessage == 2 then
			message = format("#{FaSe_01}#W#{_INFOUSR%s}#{FaSe_02}", LuaFnGetName(sceneId, selfId));
		else
			message = format("#{FaSe_03}#W#{_INFOUSR%s}#{FaSe_04}", LuaFnGetName(sceneId, selfId));
		end

		BroadMsgByChatPipe(sceneId, selfId, message, 4);
	-- 交子和金钱的数目不足 50000
	else
		x801011_NotifyTip(sceneId,selfId,"#{WGYH_210827_06}")
		return	
	end
	
end

--**********************************
--醒目提示
--**********************************
function x801011_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

