--雕纹用脚本
--created:2021-5-29 11:07:33
--fix:
	
--脚本号
x809272_g_ScriptId = 809272

x809272_g_Shike_Action_Type = 1		--雕纹蚀刻
x809272_g_QiangHua_Action_Type = 2	--雕纹强化
x809272_g_Chaichu_Action_Type = 3	--雕纹拆除
x809272_g_HeChen_Action_Type = 4	--雕纹合成
x809272_g_Ronghe_Action_Type = 5	--雕纹融合

x809272_g_DIAOWEN_ITEM_SHIKEFU = 30503149	--//雕纹蚀刻符
--x809272_g_DWRonghe_ItemID 		= 38001002 --雕纹融合符（绑定）
--x809272_g_DWRonghe_Bind_ItemID 	= 38001003 --雕纹融合符（非绑定）
-- 金蚕丝, 强化用的道具, 按照 绑定 -> 元宝交易 -> 随便交易 顺序使用
x809272_g_DWQIANGHUA_ToolItem = {20310168, 20310166, 20310167}

x809272_g_DWSHIKE_DemandMoney = 50000
x809272_g_DWRonghe_DemandMoney = 50000
x809272_g_DWHecheng_DemandMoney = 50000

--拆解信息
x809272_g_DWChaiJieInfo={
[2]={kangxing={28,2},jiankang={84,6},normal={28,2}},
[3]={kangxing={154,11},jiankang={462,33},normal={154,11}},
[4]={kangxing={854,61},jiankang={2562,183},normal={854,61}},
[5]={kangxing={2072,148},jiankang={6216,444},normal={2072,148}},
[6]={kangxing={4382,313},jiankang={13146,939},normal={4382,313}},
[7]={kangxing={8358,597},jiankang={25074,1791},normal={8358,597}},
[8]={kangxing={19712,1408},jiankang={59136,4224},normal={19712,1408}},
[9]={kangxing={48944,3496},jiankang={146832,10488},normal={48944,3496}},
[10]={kangxing={87164,6226},jiankang={261492,18678},normal={98924,7066}},
}
--雕纹直接升级单个费用
x809272_g_DWDirectPrice = 35
--雕纹进阶相关需求
x809272_g_DWJinJieNeedMoney = 500000
x809272_g_EquipPoint2DWJinJie_Tool_ItemID = {
	[0] = 30900200,--武器
	[1] = 30900206,--帽子
	[2] = 30900205,--衣服
	[3] = 30900209,--手套
	[4] = 30900211,--鞋
	[5] = 30900210,--腰带
	[6] = 30900212,--戒指
	[7] = 30900204,--项链
	[11] = 30900212,--戒指2
	[12] = 30900213,--护符
	[13] = 30900213,--护符2
	[14] = 30900208,--护腕
	[15] = 30900207,--护肩
	[17] = 30900201,--暗器
	[18] = 30900202,--武魂
	[37] = 30900203,--七情刃
}
-- 金蚕丝, 强化用的道具, 按照 绑定 -> 元宝交易 -> 随便交易 顺序使用
x809272_g_DWJinJieQianghua_ToolItem = {20310168, 20310166, 20310167}
x809272_g_DWJinJieQianghua_ToolItem2 = 20310174 
x809272_g_levelNames = {
	"#{DWJJ_240329_260}","#{DWJJ_240329_261}","#{DWJJ_240329_262}","#{DWJJ_240329_263}","#{DWJJ_240329_264}","#{DWJJ_240329_265}","#{DWJJ_240329_266}","#{DWJJ_240329_267}","#{DWJJ_240329_268}","#{DWJJ_240329_269}",
	"#{DWJJ_240329_270}","#{DWJJ_240329_271}","#{DWJJ_240329_272}","#{DWJJ_240329_273}","#{DWJJ_240329_274}","#{DWJJ_240329_275}","#{DWJJ_240329_276}","#{DWJJ_240329_277}","#{DWJJ_240329_278}","#{DWJJ_240329_279}",
	"#{DWJJ_240329_280}","#{DWJJ_240329_281}","#{DWJJ_240329_282}","#{DWJJ_240329_283}","#{DWJJ_240329_284}","#{DWJJ_240329_285}","#{DWJJ_240329_286}","#{DWJJ_240329_287}","#{DWJJ_240329_288}","#{DWJJ_240329_289}",
	"#{DWJJ_240329_290}","#{DWJJ_240329_291}","#{DWJJ_240329_292}","#{DWJJ_240329_293}","#{DWJJ_240329_294}","#{DWJJ_240329_295}","#{DWJJ_240329_296}","#{DWJJ_240329_297}","#{DWJJ_240329_298}","#{DWJJ_240329_299}",
	"#{DWJJ_240329_300}","#{DWJJ_240329_301}","#{DWJJ_240329_302}","#{DWJJ_240329_303}","#{DWJJ_240329_304}","#{DWJJ_240329_305}","#{DWJJ_240329_306}","#{DWJJ_240329_307}","#{DWJJ_240329_308}","#{DWJJ_240329_309}",
}
x809272_g_LCS_Yuanbao = 98
x809272_g_LCS2JCS = 5
x809272_g_LCSJ_ItemId = 38000960
--雕纹纹刻突破道具
x809272_g_TupoItemID = 20310175 


--**********************************
--雕纹纹刻更换
--**********************************
function x809272_DoDiaowenJinJieTeXingGengHuan(sceneId,selfId,targetId,nEquipPoint,nCurSelTeXingID,bAdd)
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
		return
	end
	print(targetId,nEquipPoint,nCurSelTeXingID,bAdd)
	local nCurJinJieLevel =  LuaFnGetEquipedDiaowenJinJieLevel(sceneId,selfId,nEquipPoint);
	if nCurJinJieLevel < 1 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_145}")
		return
	end
	--穿戴雕纹纹刻
	if bAdd == 1 then
		local featureId = LuaFnGetEquipDiaoWenFeaturesId(sceneId,selfId,nEquipPoint);
		if featureId == nCurSelTeXingID then
			x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_146}")
			return
		end
		local texingID,texingLevel,texingExp = LuaFnGetDiaowenJinJieTeXingByID(sceneId,selfId,nCurSelTeXingID)
		if texingID == nil then
			--数据异常
			x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_147}")
			return
		end
		if texingLevel < 1 then
			x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_147}")
			return
		end
		LuaFnSetEquipDiaoWenFeaturesId(sceneId,selfId,nEquipPoint,nCurSelTeXingID)
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_148}")
	else
		LuaFnSetEquipDiaoWenFeaturesId(sceneId,selfId,nEquipPoint,0)
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_148}")
	end
end

--**********************************
--雕纹纹刻强化
--**********************************
function x809272_DoTeXingQiangHua(sceneId,selfId,targetId,nCurSelTeXingID)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
--	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
--		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
--		return
--	end
	local texingID,texingLevel,texingExp = LuaFnGetDiaowenJinJieTeXingByID(sceneId,selfId,nCurSelTeXingID)
	if texingID == nil then
		--数据异常
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_180}")
		return
	end
	local texingMaxLevel = LuaFnGetDiaowenJinJieTeXingMaxLevel()
	if texingLevel >= texingMaxLevel then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_181}")
		return
	end
	local nRequiredTeXingShu,nRequiredJiaoZi,nRequiredTuPoItem = LuaFnGetDiaowenJinJieTeXingShengJiRequiredCount(texingLevel)
	if texingExp >= nRequiredTeXingShu then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_182}")
		return
	end
	local szTeXingName,nTeXingShuItemID = LuaFnGetDiaowenTeXingDescInfo(nCurSelTeXingID)
	local toolNumInBag = LuaFnGetAvailableItemCount(sceneId,selfId,nTeXingShuItemID)
	if toolNumInBag < 1 then
		x809272_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{DWJJ_240329_183}",GetItemName(sceneId,nTeXingShuItemID)))
		return
	end
	--扣除经验材料
	LuaFnDelAvailableItem(sceneId,selfId,nTeXingShuItemID,1)
	
	LuaFnAddDiaowenJinJieTeXingExpByID(sceneId,selfId,nCurSelTeXingID,1)
	
	x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_184}")

	local _,nNewTeXingLevel = LuaFnGetDiaowenJinJieTeXingByID(sceneId,selfId,nCurSelTeXingID)

	if nNewTeXingLevel ~= texingLevel and nNewTeXingLevel >= 3 then
		--DWJJ_240329_250	#P#{_INFOUSR%s0}在#G洛阳（226，171）#Y张笑狮#P处，成功使用#G雕纹纹刻升级#P功能将#Y纹刻：%s1#P的等级强化到了#G%s2级#P。	
		local nName = GetName(sceneId,selfId);
		local nGlobalMsg = ScriptGlobal_Format("#{DWJJ_240329_250}",nName,szTeXingName,tostring(nNewTeXingLevel));
		AddGlobalCountNews(sceneId,nGlobalMsg);
	end
	--刷新客户端
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,2)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89030506)
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end
--**********************************
--雕纹纹刻升级
--**********************************
function x809272_DoTeXingShengJi(sceneId,selfId,targetId,nCurSelTeXingID)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
--	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
--		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
--		return
--	end
	local texingID,texingLevel,texingExp = LuaFnGetDiaowenJinJieTeXingByID(sceneId,selfId,nCurSelTeXingID)
	if texingID == nil then
		--数据异常
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_180}")
		return
	end
	local texingMaxLevel = LuaFnGetDiaowenJinJieTeXingMaxLevel()
	if texingLevel >= texingMaxLevel then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_188}")
		return
	end
	local nRequiredTeXingShu,nRequiredJiaoZi,nRequiredTuPoItem = LuaFnGetDiaowenJinJieTeXingShengJiRequiredCount(texingLevel)
	if texingExp < nRequiredTeXingShu then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_189}")
		return
	end
	local toolNumInBag = LuaFnGetAvailableItemCount(sceneId,selfId,x809272_g_TupoItemID)
	if toolNumInBag < nRequiredTuPoItem then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_190}")
		return
	end
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) <  nRequiredJiaoZi then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_94}")
		return
	end
	local szTeXingName,nTeXingShuItemID = LuaFnGetDiaowenTeXingDescInfo(nCurSelTeXingID)
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, nRequiredJiaoZi)
	--扣除升级道具
	LuaFnDelAvailableItem(sceneId,selfId,x809272_g_TupoItemID,nRequiredTuPoItem)
	--升级
	LuaFnAddDiaowenJinJieTeXingLevelByID(sceneId,selfId,nCurSelTeXingID)
	
	x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_191}")

	--刷新客户端
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,2)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 89030506)
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end
--**********************************
--雕纹进阶回退
--**********************************
function x809272_DoDiaowenJinJieHuiTui(sceneId,selfId,targetId,itEquip,bConfirm)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
		return
	end
	if itEquip < 0 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_109}")
		return
	end
	if LuaFnIsItemAvailable(sceneId,selfId,itEquip) ~= 1 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_110}")
		return
	end
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, itEquip )
	if EquipPoint == -1 or x809272_g_EquipPoint2DWJinJie_Tool_ItemID[EquipPoint] == nil then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_109}")
		return
	end
	local curJinJieLevel =  LuaFnGetDiaowenJinJieLevel(sceneId,selfId,itEquip);
	if curJinJieLevel < 1 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_111}")
		return
	end
	local JCSNum = LuaFnGetDiaowenJinJieHuiTuiGotInfo(sceneId,selfId,itEquip);
	local getLCS = ceil(JCSNum/x809272_g_LCS2JCS)
	local nCostYuanBao = ceil(getLCS*x809272_g_LCS_Yuanbao*0.4)
	--	探测元宝是否足够
	local nCurYB = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYB < nCostYuanBao then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_112}")
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nCostYuanBao) ~= 1 then
		x809272_NotifyTip( sceneId, selfId,"#{CZHL_200916_73}")
		return
	end
	--检查背包空间
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 2 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_113}")
		return
	end
	--给灵蚕丝卷
	if getLCS > 0 then
		local nLCSJPos = TryRecieveItem(sceneId,selfId,x809272_g_LCSJ_ItemId,1)
		if nLCSJPos >= 0 then
			LuaFnItemBind(sceneId,selfId,nLCSJPos);
			SetBagItemParam	(sceneId, selfId,nLCSJPos,4 ,2 , getLCS)
			LuaFnRefreshItemInfo( sceneId, selfId, nLCSJPos )
		end
	end
	--扣除元宝
	LuaFnCostYuanBao(sceneId,selfId,nCostYuanBao,809272,"DoDiaowenJinJieShengJi",0,-1);
	--给精绘手记
	LuaFnTryRecieveSingleItem(sceneId,selfId,x809272_g_EquipPoint2DWJinJie_Tool_ItemID[EquipPoint],1,1)
	--回退雕纹
	LuaFnSetDiaowenJinJieLevel(sceneId,selfId,itEquip,0);
	x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_114}")
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end
--**********************************
--雕纹进阶升级
--**********************************
function x809272_DoDiaowenJinJieShengJi(sceneId,selfId,targetId,itEquip,bUseYuanbao,reqZZJCS,nTargetLevel)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
		return
	end
	local curJinJieLevel =  LuaFnGetDiaowenJinJieLevel(sceneId,selfId,itEquip);
	if curJinJieLevel < 1 then
		--未开启进阶
		--x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_42}")
		return
	end
	if nTargetLevel < 1 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_199}")
		return
	end
	if nTargetLevel <= curJinJieLevel  then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_199}")
		return
	end
	local dianwenLevel = LuaFnGetEquitDiaowenIndex(sceneId,selfId,itEquip);
	if dianwenLevel <= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_29}")
		return
	end
	local dianwenLevel,dwName = LuaFnGetDiaowenInfoByDWId(dianwenLevel);
	if curJinJieLevel >= dianwenLevel*5+4 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_60}")
		return
	end
	if nTargetLevel > dianwenLevel*5+4 then
		return
	end
	--计算需要的金蚕丝
	local totalNeedJCS,curLvExp = LuaFnGetDiaowenJinJieShengJiNeedJCSNum(sceneId,selfId,itEquip,nTargetLevel)
	local requireJCS = totalNeedJCS - curLvExp
	if requireJCS < curLvExp then
		return 
	end
	local nHaveZZJCS = LuaFnMtl_GetCostNum(sceneId,selfId,x809272_g_DWJinJieQianghua_ToolItem2)
	local requireZZJCS = ceil(requireJCS/x809272_g_LCS2JCS)
	local nCostYuanBao = 0
	if requireZZJCS > nHaveZZJCS then
--		local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,15,x809272_g_DWJinJieQianghua_ToolItem2,1)
		nCostYuanBao = (requireZZJCS - nHaveZZJCS) * 98--nNeedMoney
	end
	if bUseYuanbao ~= 1 then
		--二次确认
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,itEquip)
			UICommand_AddInt(sceneId,bUseYuanbao)
			UICommand_AddInt(sceneId,requireZZJCS)
			UICommand_AddInt(sceneId,nHaveZZJCS)
			UICommand_AddInt(sceneId,nCostYuanBao)
			UICommand_AddInt(sceneId,nTargetLevel)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89030512)
		return
	end
	if nCostYuanBao > 0 then
		--	探测元宝是否足够
		local nCurYB = YuanBao(sceneId,selfId,selfId,3,0)
		if nCurYB < nCostYuanBao then
			x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_68}")
			return
		end
		if LuaFnIsCanYuanBaoCost(sceneId,selfId,nCostYuanBao) ~= 1 then
			x809272_NotifyTip( sceneId, selfId,"#{CZHL_200916_73}")
			return
		end
		LuaFnCostYuanBao(sceneId,selfId,nCostYuanBao,809272,"DoDiaowenJinJieShengJi",0,-1);
	end
	--扣除材料
	if requireZZJCS > nHaveZZJCS then
		LuaFnMtl_CostMaterial(sceneId,selfId,nHaveZZJCS,x809272_g_DWJinJieQianghua_ToolItem2)
	else
		LuaFnMtl_CostMaterial(sceneId,selfId,requireZZJCS,x809272_g_DWJinJieQianghua_ToolItem2)
	end
	
	LuaFnSetDiaowenJinJieLevel(sceneId,selfId,itEquip,nTargetLevel);
	x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_191}")
	--DWJJ_240329_251	#P#{_INFOUSR%s0}在#G洛阳（221，174）#Y张伏虎#P处，成功使用#G雕纹精绘快捷升级#P功能将蚀刻在#Y#{_INFOMSG%s1}#P上的#Y%s2#P的精绘等级快捷强化到了#G%s3#P。	
	if nTargetLevel > 9 then
		local nName = GetName(sceneId,selfId);
		local szItemTransfer = GetBagItemTransfer(sceneId, selfId, itEquip )

		local nGlobalMsg = ScriptGlobal_Format("#{DWJJ_240329_251}",nName,szItemTransfer,dwName,x809272_g_levelNames[nTargetLevel]);
		AddGlobalCountNews(sceneId,nGlobalMsg);
	end
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end

--**********************************
--雕纹进阶强化
--**********************************
function x809272_DoDiaowenJinJieQiangHua(sceneId,selfId,targetId,nEqPos,nNum,nExNum)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
		return
	end
	--DWJJ_240329_57	未放入已进行雕纹精绘的装备，无法继续操作。	
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nEqPos )
	if EquipPoint == -1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_57}")
		return
	end
	local nCurJinJieLevel =  LuaFnGetDiaowenJinJieLevel(sceneId,selfId,nEqPos);
	if nCurJinJieLevel < 1 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_57}")
		return
	end
	local nMaxJinjieLevel = LuaFnGetDiaowenJinJieShengJiMaxLevel()
	if nCurJinJieLevel >= nMaxJinjieLevel then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_58}")
		return
	end
	--DWJJ_240329_60	当前精绘等级已提升至上限，无法继续提升，请先强化原雕纹等级后再尝试精绘升级。	
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nEqPos);
	if nDWId <= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_29}")
		return
	end
	local dwlevel,dwName = LuaFnGetDiaowenInfoByDWId(nDWId);
	if nCurJinJieLevel >= dwlevel*5+4 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_60}")
		return
	end
	--计算输入的够不够
	local toolNumInBag1 = 0		-- 背包里强化材料的个数
	local toolNumInBag2 = 0		-- 背包里强化材料的个数
	toolNumInBag1 = LuaFnMtl_GetCostNum(sceneId,selfId,x809272_g_DWJinJieQianghua_ToolItem[1],x809272_g_DWJinJieQianghua_ToolItem[2],x809272_g_DWJinJieQianghua_ToolItem[3])
	toolNumInBag2 = LuaFnMtl_GetCostNum(sceneId,selfId,x809272_g_DWJinJieQianghua_ToolItem2)
	if nNum < 1 and nExNum < 1 then
		--DWJJ_240329_198	所输入数量不可全部为0，请检查后重新输入。	
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_198}")
		return
	end
	if toolNumInBag1 < nNum  then
		--DWJJ_240329_61	未加锁的金蚕丝数量不足，请重新输入。	
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_61}")
		return
	end
	if toolNumInBag2 < nExNum  then
		--DWJJ_240329_160	未加锁的灵蚕丝数量不足，请重新输入。	
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_160}")
		return
	end
	--放出进行强化
	--DWJJ_240329_191	雕纹纹刻升级成功。	
	local nCost,nExCost = LuaFnEquipDiaowenJinJieQiangHua(sceneId,selfId,nEqPos,nNum,nExNum)
	if nCost > 0 or nExCost > 0 then
		--扣除升级材料
		if nCost > 0 then
			LuaFnMtl_CostMaterial(sceneId,selfId,nCost,x809272_g_DWJinJieQianghua_ToolItem[1],x809272_g_DWJinJieQianghua_ToolItem[2],x809272_g_DWJinJieQianghua_ToolItem[3])
		end
		if nExCost > 0 then
			LuaFnMtl_CostMaterial(sceneId,selfId,nExCost,x809272_g_DWJinJieQianghua_ToolItem2)
		end
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_191}")
		
		nCurJinJieLevel =  LuaFnGetDiaowenJinJieLevel(sceneId,selfId,nEqPos);
		--DWJJ_240329_249	#P#{_INFOUSR%s0}在#G洛阳（221，174）#Y张伏虎#P处，成功使用#G雕纹精绘升级#P功能将蚀刻在#Y#{_INFOMSG%s1}#P上的#Y%s2#P的精绘等级强化到了#G%s3#P。	
		if nCurJinJieLevel > 9 then
			local nName = GetName(sceneId,selfId);
			local szItemTransfer = GetBagItemTransfer(sceneId, selfId, nEqPos )

			local nGlobalMsg = ScriptGlobal_Format("#{DWJJ_240329_249}",nName,szItemTransfer,dwName,x809272_g_levelNames[nCurJinJieLevel]);
			AddGlobalCountNews(sceneId,nGlobalMsg);
		end
		
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
	end
end

--**********************************
--雕纹进阶
--**********************************
function x809272_DoDiaowenJinJie(sceneId,selfId,targetId,nEqPos,nMaterialPos,isCheck)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId,selfId,1) == 0 then
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_28}")
		return
	end
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nEqPos )
	if EquipPoint == -1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_29}")
		return
	end
	--是否有雕纹
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nEqPos);
	if nDWId <= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_29}")
		return
	end
	local dwlevel = LuaFnGetDiaowenInfoByDWId(nDWId);
	if dwlevel < 4 then
		--DWJJ_240329_192	原雕纹等级不足4级，无法进行精绘。	
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_192}")
		return
	end
	local nCurJinJieLevel =  LuaFnGetDiaowenJinJieLevel(sceneId,selfId,nEqPos);
	if nCurJinJieLevel > 0 then
		--DWJJ_240329_30	当前雕纹已进行过精绘，无法重复操作。	
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_30}")
		return
	end
	if nMaterialPos < 0 then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_31}")
		return
	end
	local nMaterialId = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nMaterialPos )
	if x809272_g_EquipPoint2DWJinJie_Tool_ItemID[EquipPoint] == nil
		or nMaterialId ~= x809272_g_EquipPoint2DWJinJie_Tool_ItemID[EquipPoint] then
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_31}")
		return
	end
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < x809272_g_DWJinJieNeedMoney then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_32}" )
		return
	end
	if isCheck ~= 1 then
		if LuaFnGetItemBindStatus(sceneId,selfId,nEqPos) == 0 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId)
				UICommand_AddInt(sceneId,nEqPos)
				UICommand_AddInt(sceneId,nMaterialPos)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 89030511)
			return
		end
	end
	--扣除精绘手记
	if LuaFnDelAvailableItem(sceneId,selfId,x809272_g_EquipPoint2DWJinJie_Tool_ItemID[EquipPoint],1) ~= 1 then
		x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_36}" )
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, x809272_g_DWJinJieNeedMoney)
	--目标装备绑定
	LuaFnItemBind(sceneId,selfId,nEqPos);
	--精绘操作
	LuaFnSetDiaowenJinJieLevel(sceneId,selfId,nEqPos,1);
	x809272_NotifyTip( sceneId, selfId, "#{DWJJ_240329_37}" )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
end

--**********************************
--雕纹直接升级
--**********************************
function x809272_DoEquipDWLevelUp(sceneId,selfId,nPos,iToLevelSel,bYuanBaoCheck)
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nPos )
	if EquipPoint == -1 then
		x809272_NotifyTip( sceneId, selfId, "#{SSXDW_140819_51}")--H请先放入已蚀刻了一个雕纹的装备
		return
	end
	--是否有雕纹
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nPos);
	if nDWId <= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWSJ_141202_21}")--H请先放入已蚀刻了一个雕纹的装备
		return
	end
	--雕纹是否满级
	local ret = LuaFnCanEquipDiaowen_Enchase(sceneId,selfId,nPos);
	if ret == -1 then
		-- 非装备
		x809272_NotifyTip( sceneId, selfId, "#{DWSJ_141202_21}")
		return
	end
	if ret == -2 then
		-- 不是一个已经蚀刻了雕纹的装备
		x809272_NotifyTip( sceneId, selfId, "#{DWSJ_141202_21}")
		return
	end
	if ret == -3 then
		--满级
		x809272_NotifyTip( sceneId, selfId, "#{DWSJ_141202_22}")
		return
	end
	if iToLevelSel<=0 then--未选择升级哪个
		x809272_NotifyTip( sceneId, selfId,"#{DWSJ_141202_23}")
		return
	end
	if iToLevelSel > 10 then
		--封号10年
		LuaFnBanAndKickPlayer(sceneId,selfId,2082729599)
		return
	end
	local dwlevel,dwName = LuaFnGetDiaowenInfoByDWId(nDWId);
	if iToLevelSel<=dwlevel then
		x809272_NotifyTip( sceneId, selfId,"#{DWSJ_141202_24}")
		return
	end
	local requireJCS,newDWID1 = LuaFnGetReqMatforEquipDWLevelUp(sceneId,selfId,nPos,iToLevelSel)--参数1、2是必须的
	if requireJCS<=0 then
		return
	end
	--数量判断
	local UserjcsCnt=requireJCS
	local UserBYBCnt=0
	local UserYBCnt=0
	--各种够不？
	local toolNumInBag = LuaFnMtl_GetCostNum(sceneId, selfId,x809272_g_DWQIANGHUA_ToolItem[1], x809272_g_DWQIANGHUA_ToolItem[2], x809272_g_DWQIANGHUA_ToolItem[3]);
	if requireJCS > toolNumInBag then
--		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_13}")--金蚕丝不足
--		return
		--拥有绑定元宝
		local curBYB= BindYuanBao(sceneId,selfId,selfId,3,0)
		--拥有元宝
		local curYB=YuanBao(sceneId,selfId,selfId,3,0)
		--元宝
		if toolNumInBag>=requireJCS then
			--金蚕丝足够
			UserjcsCnt=requireJCS
		else
			UserjcsCnt=toolNumInBag
			local leftyuanbao=(requireJCS-UserjcsCnt)*x809272_g_DWDirectPrice
			if curBYB>=leftyuanbao then
				--金蚕丝+绑定元宝足够
				UserBYBCnt=leftyuanbao
			else
				UserBYBCnt=curBYB
				--元宝够不
				leftyuanbao=leftyuanbao-UserBYBCnt
				if curYB>=leftyuanbao then
					UserYBCnt=leftyuanbao
				else
					--钱不够啊
					x809272_NotifyTip( sceneId, selfId,"#{DWSJ_141202_33}")--元宝不足，请确认后再操作。
					return
				end
			end
		end
		--简单校验一下
		if (UserjcsCnt*x809272_g_DWDirectPrice+UserBYBCnt+UserYBCnt)~=requireJCS*x809272_g_DWDirectPrice then
			return
		end
		--扣除元宝
		if UserBYBCnt > 0 then
			BindYuanBao(sceneId,selfId,selfId,2,UserBYBCnt);
		end
		if UserYBCnt > 0 then
			LuaFnCostYuanBao(sceneId,selfId,UserYBCnt,809272,"x809272_DoEquipDWLevelUp",0,-1);
		end
--		print("UserBYBCnt",UserBYBCnt,"UserYBCnt",UserYBCnt)
	end
	--扣除金蚕丝
	if UserjcsCnt > 0 then
		LuaFnMtl_CostMaterial(sceneId,selfId,UserjcsCnt,x809272_g_DWQIANGHUA_ToolItem[1], x809272_g_DWQIANGHUA_ToolItem[2], x809272_g_DWQIANGHUA_ToolItem[3]);
	end
	--强制升级
	LuaFnEquipDiaowenLevelUp(sceneId,selfId,nPos,iToLevelSel)

	x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_14}")--强化成功
	--公告
	if iToLevelSel > 0 then
		local nName = GetName(sceneId,selfId);
		local szItemTransfer = GetBagItemTransfer(sceneId, selfId, nPos )
		--DWSJ_141202_27	#H#{_INFOUSR%s0}在#G洛阳#{_INFOAIM318,315,0,张降龙}#Y张降龙#H处，成功使用#G雕纹快捷强化#H功能将蚀刻在#Y#{_INFOMSG%s1}#H上的#Y%s2#H快捷强化到了#G%s3级#H。
		local nGlobalMsg = ScriptGlobal_Format("#{DWSJ_141202_27}",nName,szItemTransfer,dwName,iToLevelSel);
		AddGlobalCountNews(sceneId,nGlobalMsg);
	end
end
--**********************************
--雕纹合成
--**********************************
function x809272_DoDiaowenAction( sceneId, selfId, nType,nParam1,nParam2,nParam3 )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if nType == x809272_g_Shike_Action_Type then
		x809272_DWShike( sceneId, selfId, nParam1 ,nParam2,nParam3)
	end
	if nType == x809272_g_QiangHua_Action_Type then
		x809272_DWQiangHua( sceneId, selfId, nParam1 ,nParam2)
	end
	if nType == x809272_g_HeChen_Action_Type then
		x809272_DWHecheng( sceneId, selfId, nParam1 )
	end
--	if nType == x809272_g_Ronghe_Action_Type then
--		x809272_DWRongHe( sceneId, selfId, nParam1 ,nParam2,nParam3)
--	end
	if nType == x809272_g_Chaichu_Action_Type then
		x809272_DWChaiChu( sceneId, selfId, nParam1 ,nParam2)
	end
	
end
--**********************************
--雕纹拆解
--**********************************
function x809272_DoDiaoWenChaiJie(sceneId,selfId,nPos)
--	安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if LuaFnGetPropertyBagSpace( sceneId, selfId) < 1  then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_17}" ) --H背包道具栏空位不足，请至少留出两个空位。
		return 		 
	end
	local nDiaoWen = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nPos )
	local dwId = LuaFnCheckItemIsDW(nDiaoWen);
	local nDiaoWenLevel,nDWName,_,nDiaoWenType = LuaFnGetDiaowenInfoByDWId(dwId);
	if x809272_g_DWChaiJieInfo[nDiaoWenLevel]==nil then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_11}")
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWCJJ_140606_12}")
		return
	end
	local nNeedYuanbao = 0;
	local nGetJCS = 0;
	if nDiaoWenType==1 then
		nNeedYuanbao = x809272_g_DWChaiJieInfo[nDiaoWenLevel].normal[1]--yuanbao
		nGetJCS = x809272_g_DWChaiJieInfo[nDiaoWenLevel].normal[2]--jcs
	elseif nDiaoWenType==2 then --减抗
		nNeedYuanbao = x809272_g_DWChaiJieInfo[nDiaoWenLevel].jiankang[1]--yuanbao
		nGetJCS = x809272_g_DWChaiJieInfo[nDiaoWenLevel].jiankang[2]--jcs
	elseif nDiaoWenType==3 then
		nNeedYuanbao = x809272_g_DWChaiJieInfo[nDiaoWenLevel].kangxing[1]--yuanbao
		nGetJCS = x809272_g_DWChaiJieInfo[nDiaoWenLevel].kangxing[2]--jcs
	else
		return
	end
	
--	探测元宝是否足够
	local nCurYB = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYB < nNeedYuanbao then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_15}")
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_16}")
		return
	end
	local nJCSJPos = TryRecieveItem(sceneId,selfId,38000959,1)
	if nJCSJPos < 0 then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_17}")
		return
	end
	LuaFnCostYuanBao(sceneId,selfId,nNeedYuanbao,809272,"DoDiaoWenChaiJie",0,-1);
--	删除雕纹
	LuaFnEraseItem(sceneId,selfId,nPos)
--	给金蚕丝卷
	LuaFnItemBind(sceneId,selfId,nJCSJPos);
	SetBagItemParam	(sceneId, selfId,nJCSJPos,4 ,2 , nGetJCS)
	LuaFnRefreshItemInfo( sceneId, selfId, nJCSJPos )
--	通知
	x809272_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{DWCJJ_140606_18}",nDWName));
end
--**********************************
--雕纹拆解检查
--**********************************
function x809272_CheckDiaoWenChaiJie(sceneId,selfId,nPos)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	--消费上限 背包空间 服务器端判断
	if LuaFnGetPropertyBagSpace( sceneId, selfId) < 1  then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_17}" ) --H背包道具栏空位不足，请至少留出两个空位。
		return 		 
	end
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWCJJ_140606_12}")
		return
	end
	local nDiaoWen = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nPos )
	local dwId = LuaFnCheckItemIsDW(nDiaoWen);
	local nDiaoWenLevel,_,_,nDiaoWenType = LuaFnGetDiaowenInfoByDWId(dwId);
	if x809272_g_DWChaiJieInfo[nDiaoWenLevel]==nil then
		x809272_NotifyTip( sceneId, selfId,"#{DWCJJ_140606_11}")
		return
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nPos)
		if nDiaoWenType==1 then
			UICommand_AddInt(sceneId,x809272_g_DWChaiJieInfo[nDiaoWenLevel].normal[1])--yuanbao
			UICommand_AddInt(sceneId,x809272_g_DWChaiJieInfo[nDiaoWenLevel].normal[2])--jcs
		elseif nDiaoWenType==2 then--减抗
			UICommand_AddInt(sceneId,x809272_g_DWChaiJieInfo[nDiaoWenLevel].jiankang[1])--yuanbao
			UICommand_AddInt(sceneId,x809272_g_DWChaiJieInfo[nDiaoWenLevel].jiankang[2])--jcs
		elseif nDiaoWenType==3 then
			UICommand_AddInt(sceneId,x809272_g_DWChaiJieInfo[nDiaoWenLevel].kangxing[1])--yuanbao
			UICommand_AddInt(sceneId,x809272_g_DWChaiJieInfo[nDiaoWenLevel].kangxing[2])--jcs
		end
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 8092720)
end
--**********************************
--雕纹拆除
--**********************************
function x809272_DWChaiChu(sceneId,selfId,nPosEquip,nPosItem)
	if LuaFnGetPropertyBagSpace( sceneId, selfId) < 2  then
		x809272_NotifyTip( sceneId, selfId,"#{SSXDW_140819_58}" ) --H背包道具栏空位不足，请至少留出两个空位。
		return 		 
	end
	local nMaterial = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nPosItem )
	if nMaterial ~= 30503150 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_20}") --必须放入熔金粉
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, nPosItem) ~= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{SSXDW_140819_42}")--该物品已经加锁，不可进行该操作
		return
	end
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nPosEquip);
	if nDWId <= 0 then
		x809272_NotifyTip( sceneId, selfId,"#{ZBDW_091105_12}") --请先放入一件蚀刻过雕纹的装备
		return
	end
	local nCurJinJieLevel =  LuaFnGetDiaowenJinJieLevel(sceneId,selfId,nPosEquip);
	if nCurJinJieLevel > 0 then
		--DWJJ_240329_149	已精绘雕纹无法拆除，需精绘复旧后方可进行此操作。	
		x809272_NotifyTip( sceneId, selfId,"#{DWJJ_240329_149}")
		return
	end
	--摘除
	local nTakeOutId = LuaFnEquipDiaowenTakeOut(sceneId,selfId,nPosEquip,0);
	if nTakeOutId > 0 then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
		LuaFnEraseItem( sceneId, selfId, nPosItem )
--		LuaFnDelAvailableItem(sceneId,selfId,nMaterial,1)
		local nPos = TryRecieveItem(sceneId,selfId,nTakeOutId,1)
		LuaFnItemBind(sceneId,selfId,nPos);
	end
	
end
--**********************************
--雕纹转移
--**********************************
function x809272_DoDiaowenDivert(sceneId,selfId,arg1,arg2)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	local EquipPoint1 = LuaFnGetBagEquipType( sceneId, selfId, arg1 )
	local EquipPoint2 = LuaFnGetBagEquipType( sceneId, selfId, arg2 )
	if EquipPoint1 == 8 or EquipPoint1 == 9 or EquipPoint1 == 10 or EquipPoint1 == 16 then
		x809272_NotifyTip( sceneId, selfId,"#{DWZY_141216_22}") --请放入一件装备。
		return
	end
	if EquipPoint2 == 8 or EquipPoint2 == 9 or EquipPoint2 == 10 or EquipPoint2 == 16 then
		x809272_NotifyTip( sceneId, selfId,"#{DWZY_141216_22}") --请放入一件装备。
		return
	end
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,arg1);
	if nDWId <= 0 then
		x809272_NotifyTip( sceneId, selfId,"#{DWZY_141216_14}") --请放入一件装备。
		return
	end
	local ItemLevel_1 = GetBagItemLevel(sceneId, selfId, arg1,1) --目标装备等级
	if ItemLevel_1 < 50 then
		x809272_NotifyTip( sceneId, selfId,"#{DWZY_141216_25}") --只有50级及以上的装备才可以进行雕纹转移操作。
		return
	end
	local ItemLevel_2 = GetBagItemLevel(sceneId, selfId, arg2,1) --目标装备等级
	if ItemLevel_2 < 50 then
		x809272_NotifyTip( sceneId, selfId,"#{DWZY_141216_37}") --目标装备等级需要大于等于50级方可进行雕纹转移操作。
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, arg1) ~= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWZY_141216_27}")--该装备尚处于锁定状态，无法转移该装备上蚀刻的雕纹。
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, arg2) ~= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{DWZY_141216_32}")--要进行雕纹转移的装备尚处于锁定状态，无法进行转移。
		return
	end
	if EquipPoint1 ~= EquipPoint2 then
		x809272_NotifyTip( sceneId, selfId, "#{DWZY_141216_36}")--只有同类型的装备之间才可以进行雕纹转移。
		return
	end
	local ret_judge = LuaFnIsJudgeApt( sceneId, selfId, arg2 )
	if ret_judge == 2 then--没有鉴定
		x809272_NotifyTip( sceneId, selfId, "#{DWZY_141216_43}")--该装备尚未鉴定，无法向其上转移雕纹
		return
	end
	local nNewDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,arg2);
	if nNewDWId ~= nil and nNewDWId > 0 then
		--有了转移你吗呢
		x809272_NotifyTip( sceneId, selfId,"#{DWZY_141216_18}")
		return
	end
	
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,arg1);
	local costMoney = 100000
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < costMoney then
		x809272_NotifyTip( sceneId, selfId, "#{ResultText_154}" )
		return
	end
	--雕纹转移
	LuaFnDiaowenDivert(sceneId,selfId,arg1,arg2)
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, costMoney)
	--目标装备绑定
	LuaFnItemBind(sceneId,selfId,arg2);
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
	x809272_NotifyTip( sceneId, selfId, "#{DWZY_141216_41}" )--雕纹转移成功。
	local nGlobalMsg = ""
	local szItemTransfer = GetBagItemTransfer(sceneId, selfId, arg2 )
	--DWZY_141216_42	#H#{_INFOUSR%s0}在#G洛阳#{_INFOAIM318,315,0,张降龙}#Y张降龙#H的指点下，将#Y%s1#H上的雕纹转移到了#Y#{_INFOMSG%s2}#H上，只见一道七彩光柱冲天而起，良久后才渐渐消散。	
	nGlobalMsg = ScriptGlobal_Format("#{DWZY_141216_42}",
				GetName(sceneId,selfId),
				GetItemName(sceneId,LuaFnGetItemTableIndexByIndex( sceneId, selfId, arg1 )),
				szItemTransfer)
	AddGlobalCountNews(sceneId,nGlobalMsg);
end
--**********************************
--雕纹强化
--**********************************
function x809272_DWQiangHua(sceneId,selfId,nPos,nNum)
	local EquipPoint	= LuaFnGetBagEquipType( sceneId, selfId, nPos )
	if EquipPoint == -1 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_11}")--必须放入蚀刻了雕纹的装备
		return
	end
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nPos);
	if nDWId <= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_12}")--请先放入一件蚀刻过雕纹的装备
		return
	end
	--雕纹满级
	local nCan = LuaFnCanEquipDiaowen_Enchase(sceneId,selfId,nPos);
	if nCan == -3 then
		return
	end
	if nNum < 1 then
		return
	end
	--数量判断
	local nMaterialNum = LuaFnMtl_GetCostNum(sceneId, selfId,x809272_g_DWQIANGHUA_ToolItem[1], x809272_g_DWQIANGHUA_ToolItem[2], x809272_g_DWQIANGHUA_ToolItem[3]);
	if nNum > nMaterialNum then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_13}")--金蚕丝不足
		return
	end
	--放出进行强化
	local nCostNumber,nNewDWId = LuaFnEquipDiaowenQiangHua(sceneId,selfId,nPos,nNum)
	if nCostNumber > 0 then
		--金蚕丝扣除
		LuaFnMtl_CostMaterial(sceneId,selfId,nCostNumber,x809272_g_DWQIANGHUA_ToolItem[1], x809272_g_DWQIANGHUA_ToolItem[2], x809272_g_DWQIANGHUA_ToolItem[3]);
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_14}")--雕纹强化成功
		--按等级给通知
		local nDWLevel,nDWName = LuaFnGetDiaowenInfoByDWId(nNewDWId);
		if nDWLevel > 2 then
			local nName = GetName(sceneId,selfId);
			local szItemTransfer = GetBagItemTransfer(sceneId, selfId, nPos )
			--ZBDW_091105_15	#{_INFOUSR%s0}#H在#G洛阳（220，170）#R张降龙#H处成功的将蚀刻在#{_INFOMSG%s1}#H上的雕纹升到了#G等级%s2#H。
			local nGlobalMsg = ScriptGlobal_Format("#{ZBDW_091105_15}",nName,szItemTransfer,tostring(nDWLevel));
			AddGlobalCountNews(sceneId,nGlobalMsg);
		end
	end
end
--**********************************
--雕纹蚀刻
--**********************************
function x809272_DWShike(sceneId,selfId, nEquipBagPos,arg2,arg3)
	local EquipPoint	= LuaFnGetBagEquipType( sceneId, selfId, nEquipBagPos )
	local nMaterial = LuaFnGetItemTableIndexByIndex( sceneId, selfId, arg2 )
	local nDiaoWen = LuaFnGetItemTableIndexByIndex( sceneId, selfId, arg3 )
	if EquipPoint == -1 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_9}")
		return
	end
	local nItemLevel = GetBagItemLevel(sceneId, selfId, nEquipBagPos,1) --装备等级
	--这里要直接获取配表里的携带等级
	if nItemLevel < 50 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_24}")
		return
	end
	if nMaterial ~= x809272_g_DIAOWEN_ITEM_SHIKEFU then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_8}")
		return
	end
	local ret_judge = LuaFnIsJudgeApt( sceneId, selfId, nEquipBagPos )
	if ret_judge == 2 then--没有鉴定
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_22}")--未鉴定装备不能蚀刻
		return
	end
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nEquipBagPos);
	if nDWId > 0 then
		x809272_NotifyTip( sceneId, selfId,"#{ZBDW_091105_17}") --请先拆除装备上已蚀刻的雕纹，之后便可蚀刻新的雕纹。	
		return
	end
	--开始检测雕纹类型和装备的对应关系
	local dwId = LuaFnCheckItemIsDW(nDiaoWen);
	if dwId < 0 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_10}")--请放入雕纹。
		return
	end
	-- 判断雕纹和装备是否配套
	if LuaFnCheckDwAndEquipPoint(dwId, EquipPoint) <= 0 then
		x809272_NotifyTip( sceneId, selfId, "#{ZBDW_091105_23}")--雕纹与装备不匹配
		return
	end
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < x809272_g_DWSHIKE_DemandMoney then
		x809272_NotifyTip( sceneId, selfId, "#{ResultText_154}" )
		return
	end
	--材料有无绑定
	local isBind = false
	if LuaFnGetItemBindStatus(sceneId,selfId,arg2) == 1 or LuaFnGetItemBindStatus(sceneId,selfId,arg3) == 1 then
		isBind = true
	end
	--if isBind then
	--装备强制绑定要不有人卡金蚕丝
		LuaFnItemBind(sceneId,selfId,nEquipBagPos);
	--end
	--蚀刻雕纹
	--这里有个默认规则，只要存在雕纹，就直接挤掉，不再提示了
	LuaFnShikeDWForEquip(sceneId,selfId,nEquipBagPos,dwId);
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, x809272_g_DWSHIKE_DemandMoney)
	LuaFnDelAvailableItem(sceneId,selfId,nMaterial,1)
	LuaFnDelAvailableItem(sceneId,selfId,nDiaoWen,1)--扣除雕纹
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
	x809272_NotifyTip( sceneId, selfId, "蚀刻成功" )
end
--**********************************
--雕纹合成
--**********************************
function x809272_DWHecheng( sceneId, selfId, itemPos )
	local itemTableIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemPos )
	local nProductItem,nDQID_1,nDQID_2,nDQID_3,nHZID_1,nHZID_2,nDQNum,nHZNum = LuaFnGetDWHechengCostInfo(itemTableIndex);
	if nProductItem < 0 then
		x809272_NotifyTip( sceneId, selfId,"#{ZBDW_091105_2}")
		return
	end
	local nMaterialNum = LuaFnMtl_GetCostNum(sceneId, selfId,nDQID_1, nDQID_2, nDQID_3);
	if nMaterialNum < nDQNum then
		x809272_NotifyTip( sceneId, selfId,"#{ZBDW_091105_4}")
		return
	end
	local nMaterialNum = LuaFnMtl_GetCostNum(sceneId, selfId,nHZID_1, nHZID_2);
	if nMaterialNum < nHZNum then
		x809272_NotifyTip( sceneId, selfId,"#{ZBDW_091105_4}")
		return
	end
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < x809272_g_DWHecheng_DemandMoney then
		x809272_NotifyTip( sceneId, selfId, "#{ResultText_154}" )
		return
	end
	--丹青扣除
	if nDQNum > 0 then
		LuaFnMtl_CostMaterial(sceneId,selfId,nDQNum,nDQID_1,nDQID_2,nDQID_3)
	end
	--黄纸扣除
	if nHZNum > 0 then
		LuaFnMtl_CostMaterial(sceneId,selfId,nHZNum,nHZID_1,nHZID_2)
	end
	--材料有无绑定
	local isBind = 0
	if LuaFnGetItemBindStatus(sceneId,selfId,itemPos) == 1 then
		isBind = 1
	end
	--销毁原材料
	LuaFnEraseItem( sceneId, selfId, itemPos )
	LuaFnCostMoneyWithPriority( sceneId, selfId, x809272_g_DWHecheng_DemandMoney)
	LuaFnTryRecieveSingleItem( sceneId, selfId, nProductItem, 1,isBind)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
	--CLHC_170828_47
	x809272_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{CLHC_170828_47}",1,GetItemName( sceneId,nProductItem) ));
	
end
--**********************************
--信息提示
--**********************************
function x809272_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
