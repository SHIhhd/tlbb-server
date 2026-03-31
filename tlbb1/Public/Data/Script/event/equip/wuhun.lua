--武魂用lua
--脚本号
x809270_g_ScriptId = 809270
--武魂合成消耗Money
x809270_m_Money_COMPOUND = {}
x809270_m_Money_COMPOUND[1] = 10000
x809270_m_Money_COMPOUND[2] = 10000
x809270_m_Money_COMPOUND[3] = 15000
x809270_m_Money_COMPOUND[4] = 15000
x809270_m_Money_COMPOUND[5] = 20000
x809270_m_Money_COMPOUND[6] = 20000
x809270_m_Money_COMPOUND[7] = 25000
x809270_m_Money_COMPOUND[8] = 25000
x809270_m_Money_COMPOUND[9] = 30000
--
x809270_INDEX_SLOT_ITEM1 = 20310158 --麟木剑
x809270_INDEX_SLOT_ITEM2 = 20310159 --破天剑
--
--魂冰石
x809270_g_HunBing = {
		20310117,	--魂冰珠（1级）
		20310118,	--魂冰珠（2级）
		20310119,	--魂冰珠（3级）
		20310120,	--魂冰珠（4级）
		20310121,	--魂冰珠（5级）
		}

--绑定魂冰石
x809270_g_HunBing_Bind = {
		20310161,	--魂冰珠（1级）
		20310162,	--魂冰珠（2级）
		20310163,	--魂冰珠（3级）
		20310164,	--魂冰珠（4级）
		20310165,	--魂冰珠（5级）
		}
		
x809270_KfsItem_YanShouDan = 30700233 --武魂延寿丹
x809270_Kfs_Magic = {"#{WH_090729_62}","#{WH_090729_63}","#{WH_090729_64}","#{WH_090729_65}"}

x809270_RunHunShiCompound_Data = 
{   
	-- 快捷
	[1] = 
	{
		[1] = { newlevel = 2, needlevel = 1, needcount = 3, needmoney = 5000, },
		[2] = { newlevel = 3, needlevel = 1, needcount = 9, needmoney = 20000, },
		[3] = { newlevel = 4, needlevel = 1, needcount = 27, needmoney = 70000, },
		[4] = { newlevel = 5, needlevel = 1, needcount = 81, needmoney = 220000, },
		[5] = { newlevel = 6, needlevel = 1, needcount = 162, needmoney = 455000, },
		[6] = { newlevel = 7, needlevel = 1, needcount = 324, needmoney = 925000, },
	},
	-- 普通
	[2] = 
	{
		[1] = { newlevel = 2, needlevel = 1, needcount = 3, needmoney = 5000, },
		[2] = { newlevel = 3, needlevel = 2, needcount = 3, needmoney = 10000, },
		[3] = { newlevel = 4, needlevel = 3, needcount = 3, needmoney = 10000, },
		[4] = { newlevel = 5, needlevel = 4, needcount = 3, needmoney = 15000, },
		[5] = { newlevel = 6, needlevel = 5, needcount = 2, needmoney = 15000, },
		[6] = { newlevel = 7, needlevel = 6, needcount = 2, needmoney = 20000, },
	},
}
x809270_RunHunShiCompound_Item = 
{
	[1]=
	{
		20310122,	--润魂石·御（1级）
		20310123,	--润魂石·御（2级）
		20310124,	--润魂石·御（3级）
		20310125,	--润魂石·御（4级）
		20310126,	--润魂石·御（5级）
		20310127,	--润魂石·御（6级）
		20310128,	--润魂石·御（7级）
		20310129,	--润魂石·御（8级）
		20310130,	--润魂石·御（9级）
	},
	[2]=
	{
		20310131,	--润魂石·击（1级）
		20310132,	--润魂石·击（2级）
		20310133,	--润魂石·击（3级）
		20310134,	--润魂石·击（4级）
		20310135,	--润魂石·击（5级）
		20310136,	--润魂石·击（6级）
		20310137,	--润魂石·击（7级）
		20310138,	--润魂石·击（8级）
		20310139,	--润魂石·击（9级）
	},
	[3]=
	{
		20310140,	--润魂石·破（1级）
		20310141,	--润魂石·破（2级）
		20310142,	--润魂石·破（3级）
		20310143,	--润魂石·破（4级）
		20310144,	--润魂石·破（5级）
		20310145,	--润魂石·破（6级）
		20310146,	--润魂石·破（7级）
		20310147,	--润魂石·破（8级）
		20310148,	--润魂石·破（9级）
	},
	[4]=
	{
		20310149,	--润魂石·暴（1级）
		20310150,	--润魂石·暴（2级）
		20310151,	--润魂石·暴（3级）
		20310152,	--润魂石·暴（4级）
		20310153,	--润魂石·暴（5级）
		20310154,	--润魂石·暴（6级）
		20310155,	--润魂石·暴（7级）
		20310156,	--润魂石·暴（8级）
		20310157,	--润魂石·暴（9级）
	},
}

x809270_KfsItem_YiXiangDan = {30700243,30700244,30700245} --武魂易相丹
x809270_KfsItem_HuiTianShenShi = {30700240,30700241,30700242} --回天神石
x809270_KfsItem_HuiTianJinShi = {30700237,30700238,30700239} --回天精石
x809270_KfsItem_YiHunShi = {30700213,30700236,30700249} --忆魂石
--**********************************
--润魂石合成
--**********************************
function x809270_RunHunShiCompound_New( sceneId, selfId ,objId, nPage , nIndex , nSubIndex)
	--1快捷2普通
	--主类型
	--子类型
	if nIndex < 1 or nIndex > 4 then
		return
	end
	if nSubIndex < 1 or nSubIndex > 6 then
		return
	end
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x809270_NotifyBox( sceneId, selfId, "#{OR_PILFER_LOCK_FLAG}" )	
		return
	end
	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		x809270_NotifyBox( sceneId, selfId, "#{RHSYH_161104_51}" )	
		return
	end
	local tConfig = x809270_RunHunShiCompound_Data[nPage][nSubIndex]
	if tConfig == nil then
		x809270_NotifyBox( sceneId, selfId, "#{RHSYH_161104_48}" )	
		return
	end
	local nDestMaterial = x809270_RunHunShiCompound_Item[nIndex][nSubIndex + 1]
	if nDestMaterial == nil then
		return
	end
	if nPage == 1 then--快捷系统
	    local NeedItemMsg = {[1] = 20310122,[2] = 20310131,[3] = 20310140,[4] = 20310149}
		local Count = LuaFnGetAvailableItemCount(sceneId, selfId, NeedItemMsg[nIndex])
		local NeedNum = tConfig.needcount
		local nTargetName = GetItemName(sceneId,nDestMaterial)
		if Count < NeedNum then
			--背包中所携带的未锁定的%s0数量不足%s1个，无法合成%s2。
			local nMsg = ScriptGlobal_Format("#{RHSYH_161201_62}",GetItemName(sceneId,NeedItemMsg[nIndex]),NeedNum,nTargetName);
			x809270_NotifyBox( sceneId, selfId, nMsg)
		    return
		end
		local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
		if nMoneySelf < tConfig.needmoney then
			x809270_NotifyBox( sceneId, selfId,  "#{RHSYH_161104_50}" )
			return
		end
		--扣钱
		LuaFnCostMoneyWithPriority( sceneId, selfId, tConfig.needmoney );
		--删除材料
		LuaFnDelAvailableItem(sceneId,selfId,NeedItemMsg[nIndex],NeedNum)
		--给予目标材料
		TryRecieveItem( sceneId, selfId, nDestMaterial, 1 )
		--特殊闪烁
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
		--提示
		x809270_NotifyBox( sceneId, selfId, ScriptGlobal_Format("#{RHSYH_161104_52}",nTargetName))
	elseif nPage == 2 then--普通系统
		local Count = LuaFnGetAvailableItemCount(sceneId, selfId, x809270_RunHunShiCompound_Item[nIndex][nSubIndex])
		local NeedNum = tConfig.needcount
		local nTargetName = GetItemName(sceneId,nDestMaterial)
		if Count < NeedNum then
			--背包中所携带的未锁定的%s0数量不足%s1个，无法合成%s2。
			local nMsg = ScriptGlobal_Format("#{RHSYH_161201_62}",nTargetName,NeedNum,nTargetName);
			x809270_NotifyBox( sceneId, selfId, nMsg)
		    return
		end
		local nMoneyJZ = GetMoneyJZ(sceneId,selfId)
		local nMoneyJB = GetMoney(sceneId,selfId)
		local nMoneySelf = nMoneyJZ + nMoneyJB
		if nMoneySelf < tConfig.needmoney then
			x809270_NotifyBox( sceneId, selfId,  "#{RHSYH_161104_50}" )
			return
		end
		--扣钱
		LuaFnCostMoneyWithPriority( sceneId, selfId, tConfig.needmoney );
		--删除材料
		LuaFnDelAvailableItem(sceneId,selfId,x809270_RunHunShiCompound_Item[nIndex][nSubIndex],NeedNum)
		--给予目标材料
		TryRecieveItem( sceneId, selfId, nDestMaterial, 1 )
		--特殊闪烁
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
		--提示
		x809270_NotifyBox( sceneId, selfId, ScriptGlobal_Format("#{RHSYH_161104_52}",nTargetName))
	end
end
--**********************************
--重洗武魂成长率
--**********************************
function x809270_KfsReWashGrowEx(sceneId,selfId,nKfsPos,nType)
	--nType 0 normal nType 1 high
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_13}" )	
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId,nKfsPos) ~= 1 then--您的武魂已加锁
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_07}")
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < 50000 then
        x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
        return
	end
	if nType == 0 then
		--需要回天精石
		if LuaFnMtl_GetCostNum(sceneId, selfId,x809270_KfsItem_HuiTianJinShi[1],x809270_KfsItem_HuiTianJinShi[2],x809270_KfsItem_HuiTianJinShi[3]) < 1 then
			x809270_NotifyBox( sceneId, selfId,"#{WHXCZL_091026_04}")
			return
		end
		LuaFnMtl_CostMaterial(sceneId,selfId,1,x809270_KfsItem_HuiTianJinShi[1],x809270_KfsItem_HuiTianJinShi[2],x809270_KfsItem_HuiTianJinShi[3])
	elseif nType == 1 then
		--需要回天神石
		if LuaFnMtl_GetCostNum(sceneId, selfId,x809270_KfsItem_HuiTianShenShi[1],x809270_KfsItem_HuiTianShenShi[2],x809270_KfsItem_HuiTianShenShi[3]) < 1 then
			x809270_NotifyBox( sceneId, selfId,"#{WHXCZL_091026_08}")
			return
		end
		LuaFnMtl_CostMaterial(sceneId,selfId,1,x809270_KfsItem_HuiTianShenShi[1],x809270_KfsItem_HuiTianShenShi[2],x809270_KfsItem_HuiTianShenShi[3])
	else
		--提交参数错误
		return
	end
	LuaFnCostMoneyWithPriority( sceneId, selfId, 50000);
	--重洗
	local bOk = LuaFnKfsRewashGrowByType(sceneId,selfId,nKfsPos,nType);
	if bOk == 1 then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--重洗成功
		x809270_NotifyBox( sceneId, selfId,"#{WHXCZL_091026_07}");
	else
		--重洗失败
		x809270_NotifyBox( sceneId, selfId,"#{WHXCZL_091026_06}");
	end
end
--**********************************
--武魂属相更换
--2024-4-6 幻魂上线废止
--**********************************
--function x809270_KfsChangeMagic(sceneId,selfId,nKfsPos,nIndex)
--	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
--	if nKfsMainPoint ~= HEQUIP_KFS then
--		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_13}" )	
--		return
--	end
--	if LuaFnIsItemAvailable( sceneId, selfId,nKfsPos) ~= 1 then--您的武魂已加锁
--		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_07}")
--		return
--	end
--	if nIndex < 1 or nIndex > 4 then
--		x809270_NotifyBox( sceneId, selfId, "#{WHYH_161121_103}");
--		return
--	end
--	if LuaFnMtl_GetCostNum(sceneId, selfId,x809270_KfsItem_YiXiangDan[1],x809270_KfsItem_YiXiangDan[2],x809270_KfsItem_YiXiangDan[3]) < 1 then
--		x809270_NotifyBox( sceneId, selfId, "#{WHGBSX_091015_06}");
--		return
--	end
--	--属相比较
--	local nMagic = LuaFnGetKfsMagicType(sceneId,selfId,nKfsPos);
--	if nIndex == nMagic then
--		x809270_NotifyBox( sceneId, selfId, "#{WHYH_161121_104}");
--		return
--	end
--	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
--	if nMoneySelf < 50000 then
--        x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
--        return
--	end
--	--扣除材料
--	LuaFnMtl_CostMaterial(sceneId,selfId,1,x809270_KfsItem_YiXiangDan[1],x809270_KfsItem_YiXiangDan[2],x809270_KfsItem_YiXiangDan[3])
--	--调整属相
--	LuaFnSetKfsMagicType(sceneId,selfId,nKfsPos,nIndex);
--	
--	LuaFnCostMoneyWithPriority( sceneId, selfId, 50000);
--	x809270_NotifyBox( sceneId, selfId,x809270_Kfs_Magic[nIndex]);
--	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
--end
--**********************************
--武魂拓展属性删除
--**********************************
function x809270_KfsAttrExDelete(sceneId,selfId,nKfsPos,nMatPos,nIndex)
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_13}" )	
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId,nKfsPos) ~= 1 then--您的武魂已加锁
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_07}")
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < 1000 then
        x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
        return
	end
	local nRet = LuaFnKfsDeleteAttrEx(sceneId,selfId,nKfsPos,nIndex);
	if nRet == 1 then
		LuaFnCostMoneyWithPriority( sceneId, selfId, 1000);
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_58}")
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	elseif nRet == -1 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_57}") -- 该武魂没有扩展属性
		return
	end
	
end
--**********************************
--武魂延寿
--**********************************
function x809270_AddKfsLife(sceneId,selfId,nKfsPos,nMaiterialPos)
	local nKfsID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nMaiterialPos )
	if nKfsID ~= x809270_KfsItem_YanShouDan then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_36}" )	
		return
	end
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_13}" )	
		return
	end
	if LuaFnIsItemLocked( sceneId, selfId,nKfsPos) == 1 then--您的武魂已加锁
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_07}")
		return
	end
	local ret = DoKfsAddLife( sceneId, selfId, nKfsPos);
	if ret == -1 then
		--该武魂不需要延长寿命
		x809270_NotifyBox(sceneId,selfId,"#{WH_090729_60}")
	elseif ret == 0 then
		x809270_NotifyBox(sceneId,selfId,"#{WH_090729_37}")
		LuaFnDelAvailableItem(sceneId, selfId, x809270_KfsItem_YanShouDan, 1)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	end
end
--**********************************
--武魂技能升级
--**********************************
function x809270_KfsSkillUp(sceneId,selfId,nKfsPos,nMaterialPos,skillSelected)
	--02_0090的客户端没有启用nMaterialPos
--	x809270_NotifyBox( sceneId, selfId, "nKfsPos:"..nKfsPos.."nMaterialPos:"..nMaterialPos.."skillSelected:"..skillSelected )	
	--看看材料是不是上锁了
--	if LuaFnIsItemLocked(sceneId, selfId, nMaterialPos) ~= 0 then
--		x809270_NotifyBox( sceneId, selfId,  "#{WHYH_161121_68}" )
--		return
--	end
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_13}" )	
		return
	end
--	if LuaFnIsItemAvailable( sceneId, selfId,nKfsPos) ~= 1 then--您的武魂已加锁
--		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_07}")
--		return
--	end
	if skillSelected < 0 or skillSelected > 2 then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_26}" )	
		return
	end
--	local nSkillNum = LuaFnGetKfsSkillNum(sceneId,selfId,nKfsPos);
--	if nSkillNum <= 0 then--当前武魂没有领悟技能
--		x809270_NotifyBox( sceneId, selfId, "#{WHYH_161121_71}" )	
--		return
--	end
	local upSkillID,needItem,nMoney = Lua_GetkfsSkillLevelUp(sceneId,selfId,nKfsPos,skillSelected);
	if upSkillID == nil or upSkillID == 0 then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_26}" )
		return
	end
	--校验金币
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < nMoney then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
		return
	end
	if needItem ~= nil and needItem <= 0 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_26}")
		return
	end
	--绑定物品获取
	local needItemBind = x809270_GetBindItemIndex(needItem)
	if needItemBind ~= nil and needItemBind <= 0 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_26}")
		return
	end
	--忆魂石检查
	if LuaFnMtl_GetCostNum(sceneId, selfId,needItem,needItemBind) < 1 then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_27}" )
		return
	end
	--材料消耗
	LuaFnMtl_CostMaterial(sceneId,selfId,1,needItemBind,needItem)
--	local nItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nMaterialPos)
--	if nItemID ~= needItem and nItemID ~= needItemBind then
--		local needItemName = GetItemName(sceneId,needItem)
--		local strSkillName = GetSkillName(upSkillID);
--		local tips = ScriptGlobal_Format("#{WHYH_161121_69}", strSkillName, needItemName)
--		x809270_NotifyBox( sceneId, selfId,tips)
--		return
--	end
	--升级操作
	local nNewLevel = LuaFnKfsSkillLevelUp(sceneId,selfId,nKfsPos,skillSelected);
	LuaFnCostMoneyWithPriority( sceneId, selfId, nMoney);
	x809270_NotifyBox( sceneId, selfId,"#{WH_090729_28}");
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	--3级以上发小喇叭
--	if nNewLevel >= 3 then
--		local szKfsTrans = GetBagItemTransfer( sceneId, selfId, nKfsPos )
--		local nGlobalText = ScriptGlobal_Format("#{WHYH_161121_77}",
--			GetName(sceneId,selfId),
--			szKfsTrans,
--			GetSkillName(upSkillID))
--		AddGlobalCountNews( sceneId,nGlobalText);
--	end
end
-- 获得所需的材料对应的绑定材料
function x809270_GetBindItemIndex(needItem)
	if needItem == nil or needItem <= 0 then
		return 0
	end

	-- 所需材料id对应的索引
	local needLevelIndex = 0
	for i=1, getn(x809270_g_HunBing) do
		if x809270_g_HunBing[i] == needItem then
			needLevelIndex = i
			break
		end
	end
	if needLevelIndex == 0 then
		return 0
	end
	
	-- 所需材料对应的绑定材料
	return x809270_g_HunBing_Bind[needLevelIndex]
end
--**********************************
--武魂技能重洗请求
--**********************************
function x809270_AskWashKfsSkill(sceneId,selfId,nKfsPos)
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId, "#{WHZN_141216_23}" )	
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId,nKfsPos) ~= 1 then --您的武魂已加锁
		x809270_NotifyBox( sceneId, selfId,"#{WHZN_141216_24}")
		return
	end
	local nSkillNum = LuaFnGetKfsSkillNum(sceneId,selfId,nKfsPos);
	if nSkillNum <= 0 then--您的武魂还未曾领悟到技能
		x809270_NotifyBox( sceneId, selfId, "#{WHZN_141216_25}" )	
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < 50000 then
		x809270_NotifyBox( sceneId, selfId,  "#{WHZN_141216_27}" )
		return
	end
	--忆魂石检查
	if LuaFnMtl_GetCostNum(sceneId, selfId,x809270_KfsItem_YiHunShi[1],x809270_KfsItem_YiHunShi[2],x809270_KfsItem_YiHunShi[3]) < 1 then
		x809270_NotifyBox( sceneId, selfId,  "#{WHZN_141216_26}" )
		return
	end
	--材料消耗
	LuaFnMtl_CostMaterial(sceneId,selfId,1,x809270_KfsItem_YiHunShi[1],x809270_KfsItem_YiHunShi[2],x809270_KfsItem_YiHunShi[3])
	LuaFnCostMoneyWithPriority( sceneId, selfId, 50000);
	--洗属性
	AskWashKfsSkill(sceneId,selfId,nKfsPos);
end
--**********************************
--武魂技能学习
--**********************************
function x809270_KfsStudySkill(sceneId,selfId,nKfsPos)
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_13}" )
		return
	end
	local nSkillNum = LuaFnGetKfsSkillNum(sceneId,selfId,nKfsPos)
	local needMoney = 0
	if nSkillNum == 0 then
		needMoney = 50000			--第一个技能5金
	elseif 	nSkillNum == 1 then
		needMoney = 100000			--第二个技能10金
	elseif 	nSkillNum == 2 then
		needMoney = 150000			--第三个技能15金
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < needMoney then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
		return
	end
	if nSkillNum >= 3 then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_22}" )
		return
	end
	local nLevel = LuaFnGetKfsLevel(sceneId,selfId,nKfsPos);
	local nCanHaveSkill = 0;
	if tonumber(nLevel) >= 40 and tonumber(nLevel) < 70 then
		nCanHaveSkill = 1;
	elseif tonumber(nLevel) >= 70 and tonumber(nLevel) < 90 then
		nCanHaveSkill = 2;
	elseif tonumber(nLevel) >= 90 then
		nCanHaveSkill = 3;
	end
	if nCanHaveSkill <= nSkillNum then
		x809270_NotifyBox( sceneId, selfId, "#{WH_090729_23}" )	--对不起，你的武魂还没有达到领悟下一个技能的级别
		return
	end
	--领悟新技能
	LuaFnKfsStudySkill(sceneId,selfId,nKfsPos);
	LuaFnCostMoneyWithPriority( sceneId, selfId, needMoney);
	x809270_NotifyBox( sceneId, selfId,"#{WH_090729_24}");
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
end
--**********************************
--武魂拓展属性升级
--**********************************
function x809270_KfsAttrExLevelUp(sceneId,selfId,nKfsPos,nMaterialPos,nIndex)
	if nIndex < 0 or nIndex >= 10 then
		x809270_NotifyBox( sceneId, selfId,"#{WHYH_161121_41}" )
		return
	end
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId,"#{WHYH_161121_33}" )
		return
	end
	local needItem,needMoney = LuaFnGetKfsAttrExLevelUpCost(sceneId,selfId,nKfsPos,nIndex);
	if needItem == nil then
		x809270_NotifyBox( sceneId, selfId,"#{WHYH_161121_41}" ) --请先选择需要升级的属性条目
		return
	end
	--当前材料已加锁
	if LuaFnIsItemAvailable( sceneId, selfId,nMaterialPos) ~= 1 then
		x809270_NotifyBox( sceneId, selfId,"#{WHYH_161121_38}")
		return
	end
	local nKfsID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nMaterialPos )
	if nKfsID ~= needItem then
		x809270_NotifyBox( sceneId, selfId,"#{WH_xml_XX(98)}"..GetItemName(sceneId,needItem))
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < needMoney then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
		return
	end
--
	local nRet,nNewLevel,outName = LuaFnKfsAddAttrExLevel(sceneId,selfId,nKfsPos,nIndex);
	if nRet == 1 then
		--升级拓展属性成功
		LuaFnCostMoneyWithPriority( sceneId, selfId, needMoney);
		--LuaFnEraseItem(sceneId,selfId,nMaterialPos);
		LuaFnDelAvailableItem(sceneId,selfId,nKfsID,1)
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_32}");
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		--4级以上小喇叭
--		if nNewLevel > 4 then
--			--H武惊日月，魂慑乾坤！
--			local szKfsTrans = GetBagItemTransfer( sceneId, selfId, nKfsPos )
--			local nGlobalText = ScriptGlobal_Format("#{WHYH_161121_46}",
--				GetName(sceneId,selfId),
--				szKfsTrans,
--				outName)
--			AddGlobalCountNews( sceneId,nGlobalText);
--		end
	elseif nRet == 2 then
		--您选择的属性条目已满级
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090828_01}" )
	elseif nRet == 3 then
		-- 请选择需要升级的属性 tips:这里表示没有学习的技能
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_30}")
	end
	--
end
--**********************************
--武魂拓展属性学习
--**********************************
function x809270_KfsAttrExStudy(sceneId,selfId,nKfsPos,nBookPos)
	if LuaFnIsItemAvailable( sceneId, selfId,nBookPos) ~= 1 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_52}")
		return
	end
	
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_13}" ) --此处只能放入武魂
		return
	end
	
	local slotNum = GetKfsSlotNum(sceneId,selfId,nKfsPos);
	local attrNum = GetBagKfsAttrExNum(sceneId,selfId,nKfsPos)
	if attrNum >= slotNum and slotNum >= 0 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_56}") -- 需要有空余的属性栏，才能学习扩展属性。
		return
	end
	
	--金钱检查
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < 80000 then
        x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
        return
	end
	
	
	local nRet = LuaFnKfsStudyAttrEx(sceneId,selfId,nKfsPos,nBookPos);
	if nRet == 1 then
		--学习扩展属性成功
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_61}" )
	elseif nRet == 2 then
		--同种类型的属性不能重复学习
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_66}" )
		return
	elseif nRet == 3 then
		--此处只能放入武魂属性书
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_20}" )
		return
	elseif nRet == 4 then
		-- 需要有空余的属性栏，才能学习扩展属性。
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_56}")
		return
	end
	
	--扣除金币
	LuaFnCostMoneyWithPriority( sceneId, selfId, 80000);
	--扣除道具
	LuaFnEraseItem(sceneId,selfId,nBookPos)
	
end
--**********************************
--增加武魂拓展属性栏
--**********************************
function x809270_AddKfsSlot(sceneId,selfId,nKfsPos,nMaterialPos)
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsPos )
	if nKfsMainPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_13}" )
		return
	end
	if LuaFnIsItemAvailable( sceneId, selfId,nMaterialPos) ~= 1 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_52}")
		return
	end
	local nKfsID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nMaterialPos )
	if nKfsID ~=  x809270_INDEX_SLOT_ITEM1 and nKfsID ~= x809270_INDEX_SLOT_ITEM2 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_51}") --此处只能放入麟木箭、破天剑
		return
	end
	
	local nSlotNum = GetKfsSlotNum(sceneId,selfId,nKfsPos);
	local nExLevel = GetKfsExtendLevel(sceneId,selfId,nKfsPos);
	if tonumber(nSlotNum) >= tonumber(nExLevel) then
		if tonumber(nSlotNum) == 10 then
			x809270_NotifyBox( sceneId, selfId,"#{WH_090817_13}") -- 武魂的扩展属性栏数已经到达最大值10栏。
		else
			x809270_NotifyBox( sceneId, selfId,"#{WH_090729_50}") -- 该武魂不能开辟新的属性栏。提升灵力等级后，可以开辟新的属性栏。
		end
		return
	end
	local needMoney = GetBagKfsSlotMoney(sceneId,selfId,nKfsPos);
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < needMoney or needMoney <= 0 then
        x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
        return
	end
	
	LuaFnCostMoneyWithPriority( sceneId, selfId, needMoney);
--	LuaFnEraseItem(sceneId,selfId,nMaterialPos);
	LuaFnDelAvailableItem(sceneId,selfId,nKfsID,1);
	local nRet = AddKfsSlotNum(sceneId,selfId,nKfsPos,nKfsID);
	if nRet ~= 1 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_54}");
		return
	end
	x809270_NotifyBox( sceneId, selfId,"#{WH_090729_55}");
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
end
--**********************************
--武魂合成
--**********************************
function x809270_KfsCompoud(sceneId,selfId,nKfsMain,nKfsCom)
	if LuaFnIsItemLocked(sceneId, selfId, nKfsCom) ~= 0 then
		x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_15}" )
		return
	end
	local nKfsMainPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsMain )
	local nKfsComPoint = LuaFnGetBagEquipType( sceneId, selfId, nKfsCom )
	if nKfsMainPoint ~= HEQUIP_KFS or nKfsComPoint ~= HEQUIP_KFS then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_13}" )
		return
	end
	local gem_count = GetGemEmbededCount(sceneId,selfId,nKfsCom)
	if gem_count > 0 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_20090904_01}")	--WH_20090904_01 镶嵌有宝石的武魂不能作为合成材料！
		return
	end
	
	local nHave = LuaFnIsEquipHaveDiaowen(sceneId,selfId,nKfsCom);
	if nHave == 1 then
		x809270_NotifyBox( sceneId, selfId,"#{ZBDW_091105_17}")	--有雕纹的武魂不能作为材料武魂
		return
	end
	local main_lv = GetKfsExtendLevel(sceneId,selfId,nKfsMain);
	local sub_lv = GetKfsExtendLevel(sceneId,selfId,nKfsCom);
	if  main_lv ~= sub_lv then 
		x809270_NotifyBox( sceneId, selfId,"#{WH_090729_17}")  --参与合成的武魂灵力等级需要等于要提升灵力等级的武魂
		return
	end
	if main_lv == nil or sub_lv >= 7 then
		x809270_NotifyBox( sceneId, selfId,"#{WH_090828_04}")  --7级以上合成暂不开放。
		return
	end
	local needMoney = 0
	if main_lv ~= nil and main_lv > 0 and main_lv < 10 then
		needMoney = x809270_m_Money_COMPOUND[main_lv]
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < needMoney then
        x809270_NotifyBox( sceneId, selfId,  "#{WH_090729_18}" )
        return
	end
	AddKfsExtendLevel(sceneId,selfId,nKfsMain);
	
	--修复不显示外观的补救办法 雪舞 2025-8-2 22:05:56
	local nKfsID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nKfsMain )
	local KFSVisual = {
		[10156001] = 4, --属相外观
		[10156003] = 4,
		[10156002] = 1,
		[10156004] = 1,
	}
	local nMagic = LuaFnGetKfsMagicType(sceneId,selfId,nKfsMain)
	if nMagic == 0 and main_lv >= 4 and KFSVisual[nKfsID] ~= nil then
		LuaFnSetKfsMagicType(sceneId,selfId,nKfsMain,KFSVisual[nKfsID]);
	end
	
	--设置绑定状态
	if LuaFnGetItemBindStatus(sceneId,selfId,nKfsCom) == 1 then
	    LuaFnItemBind(sceneId,selfId,nKfsMain)
	end
	LuaFnEraseItem(sceneId,selfId,nKfsCom);
	LuaFnCostMoneyWithPriority( sceneId, selfId, needMoney);
	x809270_NotifyBox( sceneId, selfId,"#{WH_090729_19}")
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
end
--**********************************
--信息提示
--**********************************
function x809270_NotifyBox( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
