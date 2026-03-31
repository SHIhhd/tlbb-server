--灵武操作
--脚本号
x888808_g_ScriptId = 888808
x888808_g_OpMinLevel = 85
--洗练灵玉所需
x888808_g_WashNeedItemTableIndex = {20600005, 20600006, 20600045, 20600046}
x888808_g_WashExtraWashItem1 = 20600007
x888808_g_WashExtraWashItem2 = 20600008
x888808_g_WashNeed_Mondy = {10000, 20000, 30000, 50000}
--漱玉泉合成所需
x888808_g_CompoundInfo = {

	[1] = {
		src = 20600005, 
		tar = {
			[1] = {id = 20600006, money = 20000, count = 4, txt = "#{SZXT_221216_236}"},
			[2] = {id = 20600045, money = 110000, count = 16, txt = "#{SZXT_221216_237}"},
			[3] = {id = 20600046, money = 490000, count = 64, txt = "#{SZXT_221216_238}"},
		}
	},
	
	[2] = {
		src = 20600006, 
		tar = {
			[1] = {id = 20600045, money = 30000, count = 4, txt = "#{SZXT_221216_237}"},
			[2] = {id = 20600046, money = 170000, count = 16, txt = "#{SZXT_221216_238}"},
		}
	},
	
	[3] = {
		src = 20600045, 
		tar = {
			[1] = {id = 20600046, money = 50000, count = 4, txt = "#{SZXT_221216_238}"},
		}
	}
}
--灵武回收
x888808_g_RecyReturn_Item = {20600005, 20600006, 20600045, 20600046}
x888808_g_RecyNeed_Mondy = {20000, 40000, 60000, 100000}
--天鉴灵武铸炼转移
x888808_g_TransNeed_Mondy = 100000
--合成灵玉
x888808_g_CompoundLingYuInfo = {
	--产出物品 所需配方
	[1154]={Product=10157000, Stuff = 20600009,abilityId = ABILITY_TJZF_WUJI},
	[1155]={Product=10157001, Stuff = 20600010,abilityId = ABILITY_TJZF_WUJI},
	[1156]={Product=10157002, Stuff = 20600011,abilityId = ABILITY_TJZF_SHOUXIN},
	[1157]={Product=10157003, Stuff = 20600012,abilityId = ABILITY_TJZF_SHOUXIN},
	[1158]={Product=10157004, Stuff = 20600013,abilityId = ABILITY_TJZF_POZHEN},
	[1159]={Product=10157005, Stuff = 20600014,abilityId = ABILITY_TJZF_POZHEN},
	[1160]={Product=10157006, Stuff = 20600015,abilityId = ABILITY_TJZF_WUJI},
	[1161]={Product=10157007, Stuff = 20600016,abilityId = ABILITY_TJZF_WUJI},
	[1162]={Product=10157008, Stuff = 20600017,abilityId = ABILITY_TJZF_SHOUXIN},
	[1163]={Product=10157009, Stuff = 20600018,abilityId = ABILITY_TJZF_SHOUXIN},
	[1164]={Product=10157010, Stuff = 20600019,abilityId = ABILITY_TJZF_POZHEN},
	[1165]={Product=10157011, Stuff = 20600020,abilityId = ABILITY_TJZF_POZHEN},
	[1166]={Product=10157012, Stuff = 20600021,abilityId = ABILITY_TJZF_WUJI},
	[1167]={Product=10157013, Stuff = 20600022,abilityId = ABILITY_TJZF_WUJI},
	[1168]={Product=10157014, Stuff = 20600023,abilityId = ABILITY_TJZF_SHOUXIN},
	[1169]={Product=10157015, Stuff = 20600024,abilityId = ABILITY_TJZF_SHOUXIN},
	[1170]={Product=10157016, Stuff = 20600025,abilityId = ABILITY_TJZF_POZHEN},
	[1171]={Product=10157017, Stuff = 20600026,abilityId = ABILITY_TJZF_POZHEN},
	[1172]={Product=10157018, Stuff = 20600027,abilityId = ABILITY_TJZF_WUJI},
	[1173]={Product=10157019, Stuff = 20600028,abilityId = ABILITY_TJZF_WUJI},
	[1174]={Product=10157020, Stuff = 20600029,abilityId = ABILITY_TJZF_SHOUXIN},
	[1175]={Product=10157021, Stuff = 20600030,abilityId = ABILITY_TJZF_SHOUXIN},
	[1176]={Product=10157022, Stuff = 20600031,abilityId = ABILITY_TJZF_POZHEN},
	[1177]={Product=10157023, Stuff = 20600032,abilityId = ABILITY_TJZF_POZHEN},
	[1178]={Product=10157024, Stuff = 20600033,abilityId = ABILITY_TJZF_WUJI},
	[1179]={Product=10157025, Stuff = 20600034,abilityId = ABILITY_TJZF_WUJI},
	[1180]={Product=10157026, Stuff = 20600035,abilityId = ABILITY_TJZF_SHOUXIN},
	[1181]={Product=10157027, Stuff = 20600036,abilityId = ABILITY_TJZF_SHOUXIN},
	[1182]={Product=10157028, Stuff = 20600037,abilityId = ABILITY_TJZF_POZHEN},
	[1183]={Product=10157029, Stuff = 20600038,abilityId = ABILITY_TJZF_POZHEN},
	[1184]={Product=10157030, Stuff = 20600039,abilityId = ABILITY_TJZF_WUJI},
	[1185]={Product=10157031, Stuff = 20600040,abilityId = ABILITY_TJZF_WUJI},
	[1186]={Product=10157032, Stuff = 20600041,abilityId = ABILITY_TJZF_SHOUXIN},
	[1187]={Product=10157033, Stuff = 20600042,abilityId = ABILITY_TJZF_SHOUXIN},
	[1188]={Product=10157034, Stuff = 20600043,abilityId = ABILITY_TJZF_POZHEN},
	[1189]={Product=10157035, Stuff = 20600044,abilityId = ABILITY_TJZF_POZHEN},
}

x888808_g_SpecialStuff =
{
	[20600000] = { Qual = 0}, ---初级长春玉
	[20600001] = { Qual = 1}, ---中级长春玉
	[20600002] = { Qual = 2}, ---高级长春玉
	[20600003] = { Qual = 3}, ---超级长春玉	有概率出现三条扩展属性
	[20600004] = { Qual = 4}, ---灵级长春玉	必定拥有三条扩展属性
}
--每日最大铸造次数
x888808_g_MaxLingYuDoTime = 50
--**********************************
--天鉴灵武铸炼检查
--**********************************
function x888808_AbilityCheck( sceneId, selfId, recipeId,itemPos )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_200}")
		return OR_ERROR
	end	
	local CompoundInfo = x888808_g_CompoundLingYuInfo[recipeId]
	if not CompoundInfo then
		return OR_ERROR
	end
	-- 检测背包是不是有空格，没有空格就不能进行
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 1 then
		return OR_BAG_OUT_OF_SPACE
	end
	local abilityLevel = QueryHumanAbilityLevel( sceneId, selfId, CompoundInfo.abilityId )
	if abilityLevel < 1 then
		return OR_NO_LEVEL
	end
	--判断当前阵营能不能用
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if CompoundInfo.abilityId == ABILITY_TJZF_WUJI and nCampId ~= 1 then
		x888808_NotifyMsg( sceneId, selfId,"#{SZXT_221216_204}")
		return OR_ERROR
	elseif CompoundInfo.abilityId == ABILITY_TJZF_SHOUXIN and nCampId ~= 2 then
		x888808_NotifyMsg( sceneId, selfId,"#{SZXT_221216_205}")
		return OR_ERROR
	elseif CompoundInfo.abilityId == ABILITY_TJZF_POZHEN and nCampId ~= 3 then
		x888808_NotifyMsg( sceneId, selfId,"#{SZXT_221216_206}")
		return OR_ERROR
	end
	--锻造图样判定
	if LuaFnGetAvailableItemCount( sceneId, selfId, CompoundInfo.Stuff ) <= 0 then
		return OR_STUFF_LACK
	end
	--长春玉判定
	local nSpecialStaff = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	if x888808_g_SpecialStuff[nSpecialStaff] == nil then
		return OR_STUFF_LACK
	end
	--判定今日是否铸造已满
	local nDayTimes = GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DO_TIME);
	if nDayTimes >= x888808_g_MaxLingYuDoTime then
		x888808_NotifyMsg( sceneId, selfId,"#{SZXT_221216_96}")
		return OR_ERROR
	end
	return OR_OK
end
--**********************************
--天鉴灵武铸炼产出产品
--**********************************
function x888808_AbilityProduce( sceneId, selfId, recipeId,itemPos )
	local nCheck = x888808_AbilityCheck( sceneId, selfId, recipeId,itemPos )
	if nCheck ~= OR_OK then
		return OR_ERROR
	end
	
	local CompoundInfo = x888808_g_CompoundLingYuInfo[recipeId]
	if not CompoundInfo then
		return OR_ERROR
	end
	--扣除锻造图样
	LuaFnDelAvailableItem( sceneId, selfId, CompoundInfo.Stuff , 1 )
	--长春玉判定
	local nSpecialStaff = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	if x888808_g_SpecialStuff[nSpecialStaff] == nil then
		return OR_STUFF_LACK
	end	
	--长春玉绑定状态获取
	local matBindStatus = LuaFnGetItemBindStatus(sceneId, selfId, itemPos)
	--按绑定状态进行优先扣除
	if matBindStatus == 1 then
		LuaFnDelBindAvailableItem( sceneId, selfId, nSpecialStaff , 1 )
	else
		LuaFnDelNotBindAvailableItem( sceneId, selfId, nSpecialStaff , 1 )
	end
	--针对灵武装备，在程序上做了特殊的处理
	--这里的qual同其余的普通装备不同，Qual0-4有不同的效果，具体详见CommonItem内对于长春玉的具体描述
	local bagidx = LuaFnTryRecieveSingleItem( sceneId, selfId, CompoundInfo.Product, recipeId * 10 + x888808_g_SpecialStuff[nSpecialStaff].Qual,matBindStatus )						
	if bagidx < 0 then
		LuaFnAuditAbility(sceneId, selfId, CompoundInfo.abilityId, recipeId, 0)
		return OR_ERROR
	end
	--铸造成功特效
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 152, 0 )
	--根据品质发公告【运行屏蔽】
--	local flyQual = LuaFnGetBagLingYuData(sceneId, selfId, bagidx, "QUAL")
--	if flyQual >= 3 then
--		BroadMsgByChatPipe(sceneId,selfId, 
--			ScriptGlobal_Format("#{SZXT_221216_101}",
--				GetName(sceneId, selfId),
--				GetBagItemTransfer( sceneId, selfId, bagidx )), 4)		
--	end
	LuaFnSendAbilitySuccessMsg( sceneId, selfId, CompoundInfo.abilityId, recipeId, CompoundInfo.Product )
	LuaFnAuditAbility(sceneId, selfId, CompoundInfo.abilityId, recipeId, 1)
	--增加每日铸造次数
	local nDayTimes = GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DO_TIME);
	SetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DO_TIME,nDayTimes + 1);
	--【天鉴战令】标记完成
	CallScriptFunction(890215, "OnFinishMission",sceneId, selfId, 3)
	
	return OR_OK
end
--**********************************
--天鉴灵武铸炼转移
--**********************************
function x888808_LingYuTransition( sceneId, selfId, targetId,nFromBagIndex,nToBagIndex,nCheck )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_155}")
		return
	end	
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_135}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end
	if LuaFnIsBagItemLingYu( sceneId, selfId, nFromBagIndex) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_154}")
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId, nFromBagIndex) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	if LuaFnIsBagItemLingYu( sceneId, selfId, nToBagIndex) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_154}")
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId, nToBagIndex) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	--仅同品质可转移铸炼
	local flyQual = LuaFnGetBagLingYuData(sceneId, selfId, nFromBagIndex, "QUAL")
	local tlyQual = LuaFnGetBagLingYuData(sceneId, selfId, nToBagIndex, "QUAL")
	if flyQual ~= tlyQual then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_158}")
		return
	end
	local flyExCount = LuaFnGetBagLingYuData(sceneId, selfId, nFromBagIndex, "EX_COUNT")
	local tlyExCount = LuaFnGetBagLingYuData(sceneId, selfId, nToBagIndex, "EX_COUNT")
	if flyExCount ~= tlyExCount then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_159}")
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < x888808_g_TransNeed_Mondy then
		x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_143}" )
		return
	end
	local lyBindStatus = LuaFnGetItemBindStatus(sceneId, selfId, nFromBagIndex)
	local tlyBindStatus = LuaFnGetItemBindStatus(sceneId, selfId, nToBagIndex)
	if lyBindStatus == 1 and tlyBindStatus ~= 1 and nCheck ~= 1 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt(sceneId,nFromBagIndex);
			UICommand_AddInt(sceneId,nToBagIndex);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880811)
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, x888808_g_TransNeed_Mondy);
	
	LuaFnLingYuTransition(sceneId,selfId,nFromBagIndex,nToBagIndex)
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_160}" )
end
--**********************************
--灵武回收
--**********************************
function x888808_LingYuRecycle( sceneId, selfId, targetId,nBagPos,nCheck )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_175}")
		return
	end	
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_135}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end
	if LuaFnIsItemAvailable( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	if LuaFnIsBagItemLingYu( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_154}")
		return
	end
	local lyQual = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "QUAL")
	local give_item = x888808_g_RecyReturn_Item[1]
	if x888808_g_RecyReturn_Item[lyQual + 1] ~= nil then
		give_item = x888808_g_RecyReturn_Item[lyQual + 1]
	end
	if give_item == nil then
		return
	end
	local need_money = x888808_g_RecyNeed_Mondy[1]
	if x888808_g_RecyNeed_Mondy[lyQual + 1] ~= nil then
		need_money = x888808_g_RecyNeed_Mondy[lyQual + 1]
	end
	if need_money == nil then
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_143}" )
		return
	end
	BeginAddItem(sceneId)
	AddItem(sceneId,give_item, 1)
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--是否已经铸炼
	for i = 1, 3 do
		local fix_rate = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "FIXRATE", i - 1)
		if fix_rate ~= 0 and nCheck == 1 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId);
				UICommand_AddInt(sceneId,nBagPos);
			EndUICommand(sceneId )
			DispatchUICommand(sceneId,selfId, 88880809)
			return
		end
	end
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money);
	LuaFnEraseItem(sceneId,selfId,nBagPos)
	
	AddItemListToHuman(sceneId,selfId)
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	
	x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_178}" )
end
--**********************************
--漱玉泉合成
--**********************************
function x888808_LingYuWashItemCompound( sceneId, selfId, targetId,nSourItemId,nDestItemId,nCheck )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_245}")
		return
	end	
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_135}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end
	local nCompoundIndex = 0
	if nSourItemId == x888808_g_CompoundInfo[1].src then
		nCompoundIndex = 1
	elseif nSourItemId == x888808_g_CompoundInfo[2].src then
		nCompoundIndex = 2
	elseif nSourItemId == x888808_g_CompoundInfo[3].src then
		nCompoundIndex = 3
	end
	if nCompoundIndex == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_246}")
		return
	end
	local nCompoundSubIndex = 0
	for i = 1,getn(x888808_g_CompoundInfo[nCompoundIndex].tar) do
		if x888808_g_CompoundInfo[nCompoundIndex].tar[i].id == nDestItemId then
			nCompoundSubIndex = i
			break
		end
	end
	if nCompoundSubIndex == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_247}")
		return
	end
	local need_money = x888808_g_CompoundInfo[nCompoundIndex].tar[nCompoundSubIndex].money
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_143}" )
		return
	end
	local need_item = x888808_g_CompoundInfo[nCompoundIndex].src
	local need_count = x888808_g_CompoundInfo[nCompoundIndex].tar[nCompoundSubIndex].count
	if LuaFnGetAvailableItemCount(sceneId,selfId,need_item) < need_count then
		x888808_NotifyMsg( sceneId, selfId,  ScriptGlobal_Format("#{SZXT_221216_249}",GetItemName(sceneId,need_item)) )
		return
	end
	--检查目标物是否需要绑定
	local nNeedBind = 0
	local nBindMatNum = LuaFnGetBindItemCountInBag(sceneId, selfId, need_item) --优先寻找绑定材料
	if nBindMatNum > 0 and nBindMatNum < need_count then
		--这种情况下要混入非绑定材料
		if nCheck == 1 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId);
				UICommand_AddInt(sceneId,nSourItemId);
				UICommand_AddInt(sceneId,nDestItemId);
			EndUICommand(sceneId )
			DispatchUICommand(sceneId,selfId, 88880808)
			return
		end
		nNeedBind = 1
		--扣除绑定
		LuaFnDelBindAvailableItem(sceneId,selfId,need_item,nBindMatNum)
		need_count = need_count - nBindMatNum
	end
	
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money);
	LuaFnDelAvailableItem(sceneId,selfId,need_item,need_count)
	--给予物品
	LuaFnTryRecieveMultiItem(sceneId,selfId,nDestItemId,1,1,nNeedBind)
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_251}" )
end
--**********************************
--灵玉解绑
--**********************************
function x888808_LingYuUnbind( sceneId, selfId, targetId,nBagPos,nCheck )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_230410_18}")
		return
	end	
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_135}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end
	if LuaFnIsBagItemLingYu( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_230410_06}")
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	local lyQual = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "QUAL")
	if lyQual ~= 2 and lyQual ~= 3 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_230410_06}")
		return
	end
	local lyBindStatus = LuaFnGetItemBindStatus(sceneId, selfId, nBagPos)
	if lyBindStatus ~= 1 then
		x888808_NotifyMsg( sceneId, selfId,"#{SZXT_230410_06}")
		return
	end
	for i = 1, 3 do
		local fix_rate = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "FIXRATE", i - 1)
		if fix_rate ~= 0  then
			x888808_NotifyMsg( sceneId, selfId,"#{SZXT_230410_07}")
			return
		end
	end
	local need_money = 100000
	local need_item = 38002817
	if lyQual == 2 then
	elseif lyQual == 3 then
		need_money = 200000
		need_item = 38002818
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_143}" )
		return
	end
	--天阶、地阶解绑令
	if LuaFnGetAvailableItemCount(sceneId,selfId,need_item) < 1 then
		if lyQual == 2 then
			x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_230410_13}" )
		elseif lyQual == 3 then
			x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_230410_12}" )
		end
		return
	end
	--存在可替换铸炼
	for i = 1, 3 do
		local fix_rate = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "NEWFIXRATE", i - 1)
		if fix_rate ~= 0  then
			if nCheck == 1 then
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId,targetId);
					UICommand_AddInt(sceneId,nBagPos);
				EndUICommand(sceneId )
				DispatchUICommand(sceneId,selfId, 88880812)
				return
			end
		end
	end
	--扣钱、物
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money);
	LuaFnDelAvailableItem(sceneId,selfId,need_item,1)
	--清理铸炼
	LuaFnResetBagLingYuNewFixRate(sceneId, selfId, nBagPos)
	--解绑
	LuaFnItemUnBind(sceneId,selfId,nBagPos)
	
	LuaFnRefreshItemInfo(sceneId,selfId,nBagPos)
	--impact
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	
	x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_230410_14}" )
	
	
end
--**********************************
--洗练灵玉
--**********************************
function x888808_LingYu_Wash( sceneId, selfId, targetId,nBagPos,nItemBagPos,nCheck )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_133}")
		return
	end	
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_135}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end
	if nBagPos < 0 or nItemBagPos < 0 then
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	
	if LuaFnIsItemAvailable( sceneId, selfId, nItemBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	
	if LuaFnIsBagItemLingYu( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_105}")
		return
	end
	
	local iQual = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "QUAL")
	if iQual < 0 or iQual > 3 then
		iQual = 0
	end
	
	local special_item = 0
	local bag_item_index = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nItemBagPos)
	if bag_item_index == x888808_g_WashExtraWashItem1 then
		if iQual ~= 2 then
			x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_142}")
			return
		end
		special_item = 1
	elseif bag_item_index == x888808_g_WashExtraWashItem2 then
		if iQual ~= 3 then
			x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_141}")
			return
		end
		special_item = 1
	else
		if bag_item_index ~= x888808_g_WashNeedItemTableIndex[iQual + 1] then
			local need_item_name = GetItemName(sceneId,x888808_g_WashNeedItemTableIndex[iQual + 1])
			local strTemp = ScriptGlobal_Format("#{SZXT_221216_109}", need_item_name)
			x888808_NotifyMsg( sceneId, selfId, strTemp)
			return
		end
	end
	
	local need_money = x888808_g_WashNeed_Mondy[1]
	if x888808_g_WashNeed_Mondy[iQual + 1] ~= nil then
		need_money = x888808_g_WashNeed_Mondy[iQual + 1]
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_143}" )
		return
	end
	local nNeedBindLingY = 0
	local matBindStatus = LuaFnGetItemBindStatus(sceneId, selfId, nItemBagPos)
	if matBindStatus == 1 and LuaFnGetItemBindStatus(sceneId, selfId, nBagPos) == 0 then
		if nCheck == 1 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId);
				UICommand_AddInt(sceneId,nBagPos);
				UICommand_AddInt(sceneId,nItemBagPos);
			EndUICommand(sceneId )
			DispatchUICommand(sceneId,selfId, 88880802)
			return
		end
		nNeedBindLingY = 1
	end
	--增加铸炼数量
	if iQual == 2 then
		SetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_ZHULIAN,GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_ZHULIAN) + 1);
	elseif iQual == 3 then
		SetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_ZHULIAN,GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_ZHULIAN) + 1);
	end
	--扣钱、物
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money);
	LuaFnDelAvailableItem(sceneId,selfId,bag_item_index,1)
	
	LuaFnLingYuWash(sceneId,selfId,nBagPos,special_item)
	LuaFnRefreshItemInfo(sceneId,selfId,nBagPos)
	x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_131}" )
end
--**********************************
--洗练灵玉替换
--**********************************
function x888808_LingYu_Switch( sceneId, selfId, targetId,nBagPos,nCheck )
	if GetLevel(sceneId,selfId) < x888808_g_OpMinLevel then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_133}")
		return
	end	
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_135}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return
		end
	end
	if nBagPos < 0 then
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{Item_Locked}")
		return
	end
	if LuaFnIsBagItemLingYu( sceneId, selfId, nBagPos) ~= 1 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_136}")
		return
	end
	local nHaveNew = 0
	for i = 1, 3 do
		local fix_rate = LuaFnGetBagLingYuData(sceneId, selfId, nBagPos, "NEWFIXRATE", i - 1)
		if fix_rate ~= 0  then
			nHaveNew = 1
			break
		end
	end
	if nHaveNew == 0 then
		x888808_NotifyMsg( sceneId, selfId, "#{SZXT_221216_137}")
		return
	end
	if nCheck == 1 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt(sceneId,nBagPos);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880803)
		return
	end
	
	LuaFnLingYuSwitch(sceneId,selfId,nBagPos)
	LuaFnRefreshItemInfo(sceneId,selfId,nBagPos)
	x888808_NotifyMsg( sceneId, selfId,  "#{SZXT_221216_139}" )
end

--**********************************
--信息提示
--**********************************
function x888808_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
