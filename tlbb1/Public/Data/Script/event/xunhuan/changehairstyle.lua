--调整发型
--脚本号
x801010_g_ScriptId = 801010
x801010_g_ExteriorType = 1
--**********************************
--列举事件
--**********************************
function x801010_OnEnumerate( sceneId, selfId, targetId )
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 80101001)
	return

end

--**********************************
--调整发型
--**********************************
function x801010_UnlockAndChangeExteriorHairId( sceneId, selfId, nExteriorId,nYuanBaoPay)
	local charHairId,ItemId,ItemCount,SelectType,CostMoney,StyleName,menpaiid = LuaFnGetExteriorHairStyleInfo(sceneId,selfId,nExteriorId)
	if charHairId < 0 then
		return
	end
	-- 门派信息
	if menpaiid ~= -1 and GetMenPai(sceneId,selfId) ~= menpaiid then
		x801010_NotifyTip( sceneId, selfId,"#{GMActionSystem_Item_Info_Menpai_Limit}" )
		return
	end
	--相同不走下面的流程
	local nCurExteriorId = LuaFnGetExteriorInUse(sceneId,selfId,x801010_g_ExteriorType);
	if nCurExteriorId == nExteriorId then
		x801010_NotifyTip( sceneId, selfId, "#{GXHDZ_141121_22}")
		return
	end
	-- 先检查有无外观
	if LuaFnIsHaveExterior(sceneId,selfId,x801010_g_ExteriorType,nExteriorId) == 1 then
		--直接更换
		LuaFnSetExteriorInUse(sceneId,selfId,x801010_g_ExteriorType,nExteriorId);
		x801010_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{GXHDZ_141121_30}",StyleName))
		return
	end
	-- 返回值非法
	if ItemId < 0 or ItemCount < 0 then
		return
	end
	local nItemNum = LuaFnGetAvailableItemCount( sceneId, selfId, ItemId )
	-- 物品是否够用或锁定
	if ItemCount > nItemNum then
		--元宝快捷购买
		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,4,ItemId,nYuanBaoPay)
		if nNeedMoney ~= nil then
		
			local strTips = ScriptGlobal_Format("#{XFYH_20120221_04}",
			tostring(ItemId),tostring(nNeedMoney),"#{XFYH_20120221_10}","#{XFYH_20120221_12}",tostring(1),tostring(ItemId))
			
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 4 )
				UICommand_AddInt( sceneId, nMoneyUnit )
				UICommand_AddInt( sceneId, nNeedMoney )
				UICommand_AddInt( sceneId, itemIndex )
				UICommand_AddInt( sceneId, 0 )
				UICommand_AddInt( sceneId, x801010_g_ScriptId )
				UICommand_AddInt( sceneId, nYuanBaoPay )
				UICommand_AddInt( sceneId, -1 )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddString(sceneId,strTips)
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20120222 )
		else
			x801010_NotifyTip(sceneId,selfId,"#{GXHDZ_141121_24}")
		end
		return
	end
	-- 物品检测通过，再检查玩家金钱
	local moneyJZ = GetMoneyJZ (sceneId, selfId)
	local money = GetMoney (sceneId, selfId)
	-- 物品和金钱检测都通过
	if (moneyJZ + money < CostMoney) then
		x801010_NotifyTip( sceneId, selfId, "#{GXHDZ_141121_09}")
		return
	end
	--扣钱扣物品
	LuaFnDelAvailableItem(sceneId,selfId,ItemId,ItemCount)
	LuaFnCostMoneyWithPriority( sceneId, selfId, CostMoney);
	--激活并更换
	LuaFnActiveExterior(sceneId,selfId,x801010_g_ExteriorType,nExteriorId,-1);
	LuaFnSetExteriorInUse(sceneId,selfId,x801010_g_ExteriorType,nExteriorId);
	x801010_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{GXHDZ_141121_30}",StyleName))
end

--**********************************
--信息提示
--**********************************
function x801010_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
