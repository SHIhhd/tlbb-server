--*****************************************************************
-- 游戏管理员工具V6 焚尽铅华
--*****************************************************************

x199998_g_XinFaInfo = {
	{1,2,3,4,5,6,55},
	{7,8,9,10,11,12,56},
	{13,14,15,16,17,18,57},
	{19,20,21,22,23,24,58},
	{25,26,27,28,29,30,59},
	{31,32,33,34,35,36,60},
	{37,38,39,40,41,42,61},
	{43,44,45,46,47,48,62},
	{49,50,51,52,53,54,63},
	{0,0,0,0,0,0,0,0},
	{64,65,66,67,68,69,70},
	{81,82,83,84,85,86,87},
	{64,65,66,67,68,69,70},
}
--**************************************
-- 回调测试1
--**************************************
function x199998_GameMasterControl_ServerCallOne(sceneId,selfId, A)
	--权限检查
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	
	if A ~= nil and A == 76 then		--内部GM	
		local nAccount = LuaFnGetAccountName(sceneId, selfId)
		if LuaFnIsAdminAccount(sceneId, selfId) ~= 1 then
			return
		end
		--这里作为GM工具跳转接口
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20200427)
		return
	end


	RestoreHp(sceneId,selfId)
	RestoreMp(sceneId,selfId)
	RestoreRage(sceneId,selfId)
end

--**************************************
-- 回调测试2
--**************************************
function x199998_GameMasterControl_ServerCallTwo(sceneId,selfId,nIndex,A,B,C,D,E,F)
	--权限检查
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	if nIndex == 1 then
		PushDebugMessage(sceneId,selfId,"暂不开放此功能。Two-001")
	elseif nIndex == 2 then
		PushDebugMessage(sceneId,selfId,"暂不开放此功能。Two-002")
	end
end

--**************************************
-- 全局操作
--**************************************
function x199998_GameMasterControl_AllUse(sceneId,selfId,nIndex,nPar1,nPar2,nPar3)
	--权限检查
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	if nIndex == 1 then --创建怪物，全场景操作，直接给怪物生成在身边。。
		if nPar1 < 0 or nPar1 > 65535 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-AllUse-Error_1!!!")
			return
		end
		if nPar2 < -1 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-AllUse-Error_2!!!")
			return
		end
		if nPar2 == -1 then
			nPar2 = sceneId;
		end
		local x,z = GetWorldPos(sceneId,selfId)
		LuaFnCreateMonster(nPar2,nPar1, x, z, 21, 0,nPar3)
		
	end
	if nIndex == 2 then
		if nPar1 < 0 or nPar1 > 65535 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-AllUse-Error_1!!!")
			return
		end
		if nPar2 < -1 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-AllUse-Error_2!!!")
			return
		end
		if nPar2 == -1 then
			nPar2 = sceneId;
		end
		local x,z = GetWorldPos(sceneId,selfId)
		LuaFnCreateMonster(nPar2,nPar1, x, z, 185, -1,nPar3)
	end
	if nIndex == 3 then
		if nPar1 < 0 or nPar1 > 65535 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-AllUse-Error_1!!!")
			return
		end
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,i)
			if GetMonsterDataID(sceneId,nMonsterId) == nPar1 then
				LuaFnDeleteMonster(sceneId,nMonsterId)
			end
		end
	end
	
	if nIndex == 4 then
		if nPar1 < 0 or nPar1 > 9999999 then
			PushDebugMessage(sceneId,selfId,"nPar1 超过限制")
			return
		end

		LuaFnRefreshScript(sceneId,selfId,nPar1)

		PushDebugMessage(sceneId,selfId,"LUA重载成功,脚本号:"..nPar1)
	end
	
	if nIndex == 5 then
		LuaFnReloadGlobalScript(sceneId, selfId)
		PushDebugMessage(sceneId,selfId,"全局脚本ScriptGlobal重载成功")
	end
	
	if nIndex == 6 then
		LuaFnReloadShopTables(sceneId, selfId)
		PushDebugMessage(sceneId,selfId,"商店重载成功")
	end
	
	if nIndex == 7 then
		LuaFnReloadDropTables(sceneId, selfId)
		PushDebugMessage(sceneId,selfId,"商店爆率重载成功")
	end
	if nIndex == 8 then
		LuaFnReloadMonsterAttrTable()
		PushDebugMessage(sceneId,selfId,"商店怪物文件重载成功")
	end
	
	if nIndex == 9 then
		if nPar1 == 1 then
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_SPEAKEROPENCLICK,1)
			PushDebugMessage(sceneId,selfId,"关闭全局喇叭权限,现在全服均无法使用小喇叭")
		else
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_SPEAKEROPENCLICK,0)
			PushDebugMessage(sceneId,selfId,"开放全局喇叭权限,现在全服可使用小喇叭")
		end
	end
	if nIndex == 10 then -- 重载 DropNotify.txt 文件 掉落公告
		LuaFnReloadItemDropNotifyTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"掉落公告文件重载成功")
	end
	
	if nIndex == 11 then -- 重载 EquipBase.txt
		LuaFnReloadBlueItemTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"装备文件重载成功")
	end
	
	if nIndex == 12 then -- 重载手工品质分布表/起始数值段对应文件 ItemSegAffect.txt  ItemSegValue.txt
		LuaFnReloadItemSegAffectTable(sceneId,selfId)
		LuaFnReloadItemSegValueTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"装备属性表重载成功")
	end
	
	if nIndex == 13 then -- 重载放行脚本表 ./Config/AllowableScriptFunc.txt
		LuaFnReloadAllowableScriptFuncTable()
		PushDebugMessage(sceneId,selfId,"重载放行脚本表重载成功")
	end
	
	if nIndex == 14 then -- 重载物品表  CommonItem.txt
		LuaFnReloadCommItemInfoTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"重载物品表成功")
	end
	if nIndex == 15 then -- 重载宝石表  GemInfo.txt
		LuaFnReloadGemInfoTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"重载宝石表成功")
	end
	
	if nIndex == 16 then -- 重载珍兽表  PetAttrTable.txt
		LuaFnReloadPetAttrTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"重载珍兽表成功")
	end
	if nIndex == 17 then -- 重载怪物表  MonsterAttrExTable.txt
		LuaFnReloadMonsterAttrTable(sceneId,selfId)
		PushDebugMessage(sceneId,selfId,"重载怪物表成功")
	end
	if nIndex == 18 then -- 重载灵性表
		LuaFnReloadPetLingXingTable()
		PushDebugMessage(sceneId,selfId,"重载灵性表成功")
	end
	if nIndex == 19 then -- 重载幻化表
		LuaFnReloadPetHuanhuaTable()
		PushDebugMessage(sceneId,selfId,"重载幻化表成功")
	end
	
end

--**************************************
-- 个人操作
--**************************************
function x199998_GameMasterControl_SelfUse(sceneId,selfId,nIndex,nPar1,nPar2,nPar3)
	--权限检查
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	if sceneId < 0 or selfId < 14999 or selfId > 29999 then
		PushDebugMessage( sceneId,selfId,"GM_TOOL-SelfUse-Error_1!!!")
		return
	end
	if nIndex < 1 or nIndex > 37 then
		PushDebugMessage( sceneId,selfId,"GM_TOOL-SelfUse-Error_2!!!")
		return
	end
	local Logstr = ""
	local nowYear = GetTodayYear();
	local nowMonth = GetTodayMonth();
	nowMonth=nowMonth+1;
	local nowDate = GetTodayDate();
	local nHour	 = GetHour()
	local nMinute = GetMinute()
	local nName = GetName( sceneId, selfId )
	if nIndex == 1 then --刷物品
		if nPar1 < 10000000 or nPar1 > 59999999 then
			PushDebugMessage( sceneId,selfId,"输入的物品代码有误，建议使用GM工具物品搜索功能获取物品代码。")
			return
		end
		if nPar2 < 1 or nPar2 > 9999 then
			PushDebugMessage( sceneId,selfId,"物品数量不得小于1或者大于9999，防止出现BUG。")
			return
		end
		BeginAddItem(sceneId)
			AddItem(sceneId,nPar1,nPar2)
			if EndAddItem(sceneId,selfId) <= 0 then
				return
			end
		AddItemListToHuman(sceneId,selfId)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限领取了%d个%s。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar2,GetItemName(sceneId,nPar1))
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("已获得%s个%s",tostring(nPar2),GetItemName(sceneId,nPar1)))
	end
	if nIndex == 2 then --查物品字符串
		if nPar1 < 0 or nPar1 > 118 then
			PushDebugMessage( sceneId,selfId,"GM_TOOL-idx_2_Error_1!!!")
			return
		end
		local nItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nPar1)
		if nItemID <= 0 then
			PushDebugMessage(sceneId,selfId,format("查询结果：%s号格子没有放置任何物品，未查询到任何字符串。",nPar1))
			return
		end
		local _,Creator = LuaFnGetItemCreator(sceneId,selfId,nPar1)
		if Creator == nil then
			PushDebugMessage(sceneId,selfId,format("查询结果：%s号格子物品字符串信息为：nil。",nPar1))
			else
			PushDebugMessage(sceneId,selfId,format("查询结果：%s号格子物品字符串信息为：%s。",nPar1,Creator))
		end
	end
	if nIndex == 3 then --清背包
		if nPar1 < 0 or nPar2 < nPar1 or nPar2 > 220 or nPar1 > nPar2 then
			PushDebugMessage( sceneId,selfId,"GM_TOOL-idx_3_Error_1!!!")
			return
		end
		if nPar1 == nPar2 then --等于的情况下只清理一个格子。
			LuaFnEraseItem(sceneId,selfId,nPar1)
			PushDebugMessage(sceneId,selfId,"清理完毕。")
			return
		end
		for i = nPar1,nPar2 do --不等于的情况下直接全清理。
			local nItemID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,i)
			if nItemID > 0 then  --只有有物品的清理，没物品的不循环。
				LuaFnEraseItem(sceneId,selfId,i)
			end
		end
		PushDebugMessage(sceneId,selfId,"清理完毕。")
	end
	if nIndex == 4 then --领金币
		if nPar1 < 0 or nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"领取数量不得小于0，或大于20万金。")
			return
		end
		local Money = GetMoney(sceneId,selfId)
		if Money + nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"自身金币与领取金币相加已达上限，请减少领取数量。")
			return
		end
		AddMoney(sceneId,selfId,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限领取了%d金。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
	end
	if nIndex == 5 then --扣金币
		if nPar1 < 0 or nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_5_Error_1!!!")
			return
		end
		local Money = GetMoney(sceneId,selfId)
		if nPar1 > Money then
			AddMoney(sceneId,selfId,-Money) --扣剩余全部金币。
			return
		end
		AddMoney(sceneId,selfId,-nPar1) --只扣输入金币。
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限扣除了%d金。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
	end
	if nIndex == 6 then --领交子
		if nPar1 < 0 or nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"领取数量不得小于0，或大于20万交子。")
			return
		end
		local MoneyJz = GetMoneyJZ(sceneId,selfId)
		if MoneyJz + nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"自身交子与领取交子相加已达上限，请减少领取数量。")
			return
		end
		AddMoneyJZ(sceneId,selfId,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限领取了%d交子。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("你获得了#{_EXCHG%s}。",nPar1))
	end
	if nIndex == 7 then --扣交子
		if nPar1 < 0 or nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_7_Error_1!!!")
			return
		end
		local MoneyJz = GetMoneyJZ(sceneId,selfId)
		if nPar1 > MoneyJz then
			LuaFnCostMoneyWithPriority(sceneId,selfId,MoneyJz)
			PushDebugMessage(sceneId,selfId,format("已扣除#{_EXCHG%s}。",MoneyJz))
			return
		end
		LuaFnCostMoneyWithPriority(sceneId,selfId,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限扣除了%d交子。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("已扣除#{_EXCHG%s}。",nPar1))
	end
	if nIndex == 8 then   --领元宝
		if nPar1 < 0 or nPar1 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_8_Error_1!!!")
			return
		end
		local nYuanBao = YuanBao(sceneId,selfId,-1,3,0)
		if nYuanBao + nPar1 >= 2100000000 then
			PushDebugMessage(sceneId,selfId,"自身元宝与领取元宝相加已达上限，请减少领取数量。")
			return
		end
		YuanBao(sceneId,selfId,-1,1,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限领取了%d点元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("已获得%s点元宝。",nPar1))
	end
	if nIndex == 9 then --扣元宝
		if nPar1 < 0 or nPar1 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_9_Error_1!!!")
			return
		end
		local nYuanBao = YuanBao(sceneId,selfId,-1,3,0)
		if nPar1 > nYuanBao then
			YuanBao(sceneId,selfId,-1,2,nYuanBao)
			Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限扣除了%d点元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nYuanBao)
			x199998_GameLog(sceneId,selfId,1,Logstr)
			PushDebugMessage(sceneId,selfId,format("已扣除%s点元宝。",nYuanBao))
			return
		end
		YuanBao(sceneId,selfId,-1,2,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限扣除了%d点元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("已扣除%s点元宝。",nPar1))
	end
	if nIndex == 10 then   --领绑定元宝
		if nPar1 < 0 or nPar1 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_10_Error_1!!!")
			return
		end
		local BindYuanBao = BindYuanBao(sceneId,selfId,-1,3,0)
		if BindYuanBao + nPar1 >= 2100000000 then
			PushDebugMessage(sceneId,selfId,"自身绑定元宝与领取绑定元宝相加已达上限，请减少领取数量。")
			return
		end
		BindYuanBao(sceneId,selfId,-1,1,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限领取了%d点绑定元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("已获得%s点绑定元宝。",nPar1))
	end
	if nIndex == 11 then --扣绑定元宝
		if nPar1 < 0 or nPar1 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_11_Error_1!!!")
			return
		end
		local BindYuanBao = BindYuanBao(sceneId,selfId,-1,3,0)
		if nPar1 > BindYuanBao then
			BindYuanBao(sceneId,selfId,-1,2,BindYuanBao)
			PushDebugMessage(sceneId,selfId,format("已扣除%s点绑定元宝。",BindYuanBao))
			Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限扣除了%d点绑定元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,BindYuanBao)
			x199998_GameLog(sceneId,selfId,1,Logstr)
			return
		end
		BindYuanBao(sceneId,selfId,-1,2,nPar1)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，成功使用管理员权限扣除了%d点绑定元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,1,Logstr)
		PushDebugMessage(sceneId,selfId,format("已扣除%s点绑定元宝。",nPar1))
	end
	if nIndex == 12 then --加经验
		if nPar1 <= 0 then
			PushDebugMessage(sceneId,selfId,"填写经验数不得小于等于0。")
			return
		end
		local Exp = 0
		if nPar1 <= 700000 then
			Exp = AddExp(sceneId,selfId,nPar1)
			else
			Exp = floor(nPar1/700000)
			for i = 1,Exp do
				AddExp(sceneId,selfId,nPar1)
			end
		end
	end
	if nIndex == 13 then --扣经验
		if nPar1 <= 0 then
			PushDebugMessage(sceneId,selfId,"填写经验数不得小于等于0。")
			return
		end
		local nExp = GetExp(sceneId,selfId)
		if nExp <= 0 then
			PushDebugMessage(sceneId,selfId,"经验为0无需扣除。")
			return
		end
		if nPar1 > nExp then
			LuaFnCostExp(sceneId,selfId,nExp)
			PushDebugMessage(sceneId,selfId,"已将经验全部扣除。")
			return
		end
		LuaFnCostExp(sceneId,selfId,nPar1)
		PushDebugMessage(sceneId,selfId,format("已扣除%s点经验。",nPar1))
	end
	if nIndex == 14 then --设置个人等级
		if nPar1 < 1 or nPar1 > 119 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_14_Error_1!!!")
			return
		end
		LuaFnSetHumanLevel(sceneId,selfId,nPar1) --直接设置等级
		PushDebugMessage(sceneId,selfId,format("已将等级设置为%s级。",nPar1))
	end
	if nIndex == 15 then --加入门派
		if nPar1 < 0 or nPar1 > 9 then
			PushDebugMessage(sceneId,selfId,"暂未开放九大门派以外的门派，请重新输入。")
			return
		end
		local nMenPai = GetMenPai(sceneId,selfId)
		local nLevel = GetLevel(sceneId,selfId) 
		if nLevel < 10 then
			PushDebugMessage(sceneId,selfId,"等级不足10级。")
			return
		end
		if nMenPai == nPar1 then
			PushDebugMessage(sceneId,selfId,"已经加入本门派了。")
			return
		end
		LuaFnJoinMenpai(sceneId, selfId, selfId, nPar1)
		for i =1,7 do
			LuaFnSetXinFaLevel(sceneId,selfId,x199998_g_XinFaInfo[nPar1+1][i],119)
		end
		--CallScriptFunction(900030, "CleanMenPaiBuff", sceneId, selfId);
		PushDebugMessage(sceneId,selfId,"成功加入门派。")
	end
	if nIndex == 16 then --学心法
		local nMenPai = GetMenPai(sceneId,selfId)
		if nMenPai == 9 then
			PushDebugMessage(sceneId,selfId,"请先加入门派。")
			return
		end
		local nXinFaData = 0;
		for i =1,7 do
			if LuaFnGetXinFaLevel(sceneId,selfId,x199998_g_XinFaInfo[nMenPai+1][i]) < 1 then
				nXinFaData = i;
				break
			end
		end
		if nXinFaData ~= 0 then
			PushDebugMessage(sceneId,selfId,"已成功学习本门派未学习心法。")
			else
			PushDebugMessage(sceneId,selfId,"本门派心法已经全部习得，无可学心法。")
		end
	end
	if nIndex == 17 then --设置心法等级
		if nPar1 < 0 or nPar1 > 119 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_17_Error_1!!!")
			return
		end
		local nMenPai = GetMenPai(sceneId,selfId)
		if nMenPai == 9 then
			PushDebugMessage(sceneId,selfId,"请先加入门派。")
			return
		end
		for i =1,7 do
			LuaFnSetXinFaLevel(sceneId,selfId,x199998_g_XinFaInfo[nMenPai+1][i],nPar1)
		end
		PushDebugMessage(sceneId,selfId,format("已将全部心法设置为%s级。",nPar1))
	end
	if nIndex == 18 then --查看buff
		x199998_GetBuff(sceneId,selfId,-1)
	end
	if nIndex == 19 then --查询MD
		if nPar1 < 0 or nPar1 > 511 then
			PushDebugMessage(sceneId,selfId,"超出MissionData定义最大值，请重新输入。")
			return
		end
		local MissionData = GetMissionData(sceneId,selfId,nPar1)
		PushDebugMessage(sceneId,selfId,format("当前查询MD编号为：%s#r当前MD编号数据为：%s",nPar1,MissionData))
	end
	if nIndex == 20 then --查询MDEX
		if nPar1 < 0 or nPar1 > 1535 then
			PushDebugMessage(sceneId,selfId,"超出MissionDataEx定义最大值，请重新输入。")
			return
		end
		local MissionDataEx = GetMissionDataEx(sceneId,selfId,nPar1)
		PushDebugMessage(sceneId,selfId,format("当前查询MDEX编号为：%s#r当前MDEX编号数据为：%s",nPar1,MissionDataEx))
	end
	if nIndex == 21 then --查询FLAG
		if nPar1 < 0 or nPar1 > 319 then
			PushDebugMessage(sceneId,selfId,"超出MissionFlag定义最大值，请重新输入。")
			return
		end
		local MissionFlag = GetMissionFlag(sceneId,selfId,nPar1)
		PushDebugMessage(sceneId,selfId,format("当前查询Flag编号为：%s#r当前Flag编号数据为：%s",nPar1,MissionFlag))
	end
	if nIndex == 22 then --查询World
		if nPar1 < 0 or nPar1 > 100 then
			PushDebugMessage(sceneId,selfId,"超出GlobalWorld定义最大值，请重新输入。")
			return
		end
		local GlobalWorld = LuaFnGetWorldGlobalData(nPar1)
		PushDebugMessage(sceneId,selfId,format("当前查询World编号为：%s#r当前World编号数据为：%s",nPar1,GlobalWorld))
	end
	if nIndex == 23 then --学习技能
		PushDebugMessage(sceneId,selfId,"此功能需要使用时开放。")
	end
	if nIndex == 24 then --删除技能
		PushDebugMessage(sceneId,selfId,"此功能需要使用时开放。")
	end
	if nIndex == 25 then --获取BUFF
		if nPar1 < 0 or nPar1 > 65520 then
			PushDebugMessage(sceneId,selfId,"超出BUFF上限，请重新输入。")
			return
		end
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,nPar1,0)
		PushDebugMessage(sceneId,selfId,format("已获取%s号BUFF。",nPar1))
	end
	if nIndex == 26 then --删BUFF
		if nPar1 < 0 or nPar1 > 65520 then
			PushDebugMessage(sceneId,selfId,"超出BUFF上限，请重新输入。")
			return
		end
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,nPar1) == 1 then
			LuaFnCancelSpecificImpact(sceneId,selfId,nPar1)
			PushDebugMessage(sceneId,selfId,format("已清除%s号BUFF。",nPar1))
			else
			PushDebugMessage(sceneId,selfId,"不存在此BUFF，无需清除。")
		end
	end
	if nIndex == 27 then --查场景数据
		local nSceneName = GetSceneName(sceneId) --场景名称
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		PushDebugMessage(sceneId,selfId,format("当前场景为：%s。#r场景内存在人数为：%s人。",nSceneName,nHumanNum))
	end
	if nIndex == 28 then --换场景
		if nPar1 < 0 or nPar1 > 1289 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_28_Error_1!!!")
			return
		end
		if nPar2 < 10 or nPar2 > 500 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_28_Error_2!!!")
			return
		end
		if nPar3 < 10 or nPar3 > 500 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_28_Error_3!!!")
			return
		end
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId,nPar1,nPar2,nPar3)
	end
	if nIndex == 29 then --设置MD
		if nPar1 < 0 or nPar1 > 991 then
			PushDebugMessage(sceneId,selfId,"超出MissionData定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"超出MissionData设置最大上限，请重新输入。")
			return
		end
		--这个设置MD就别继承了，反正是随意输入。
		SetMissionData(sceneId,selfId,nPar1,nPar2)
		PushDebugMessage(sceneId,selfId,format("成功将MD编号：%s设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 30 then --设置Ex
		if nPar1 < 0 or nPar1 > 1023 then
			PushDebugMessage(sceneId,selfId,"超出MissionDataEx定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"超出MissionDataEx设置最大上限，请重新输入。")
			return
		end
		--这个设置MD就别继承了，反正是随意输入。
		SetMissionDataEx(sceneId,selfId,nPar1,nPar2)
		PushDebugMessage(sceneId,selfId,format("成功将MDEX编号：%s设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 31 then --设置Flag
		if nPar1 < 0 or nPar1 > 5119 then
			PushDebugMessage(sceneId,selfId,"超出MissionFlag定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 1 then
			PushDebugMessage(sceneId,selfId,"超出MissionFlag设置最大上限，请重新输入。")
			return
		end
		--这个设置MD就别继承了，反正是随意输入。
		SetMissionFlag(sceneId,selfId,nPar1,nPar2)
		PushDebugMessage(sceneId,selfId,format("成功将Flag编号：%s设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 32 then --设置World
		if nPar1 < 0 or nPar1 > 76 then
			PushDebugMessage(sceneId,selfId,"超出GlobalWorld定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"超出GlobalWorld设置最大上限，请重新输入。")
			return
		end
		--这个设置MD就别继承了，反正是随意输入。
		LuaFnSetWorldGlobalData(nPar1,nPar2)
		PushDebugMessage(sceneId,selfId,format("成功将World编号：%s设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 33 then --设置超级属性
		--默认属性测试看看
		--给GM号一个属性标记，然后直接生成属性就行。

		if GetMissionFlag(sceneId,selfId,MF_GM_ATTRMAX) == 1 then
			SetMissionFlag(sceneId,selfId,MF_GM_ATTRMAX,0)
			CallScriptFunction( 866010, "StartComputeHumanData", sceneId, selfId ,1 ) ;
			PushDebugMessage(sceneId,selfId,"已取消属性。")
			return
		end
		SetMissionFlag(sceneId,selfId,MF_GM_ATTRMAX,1)
		CallScriptFunction( 866010, "StartComputeHumanData", sceneId, selfId ,1 ) ;
		PushDebugMessage(sceneId,selfId,"已将属性设置为MAX。")
	end
	if nIndex == 34 then
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,2690,0)
		PushDebugMessage(sceneId,selfId,"已获取GM状态。")
	end
	if nIndex == 35 then
		local createPetRet, retGUID_H, retGUID_L = LuaFnCreatePetToHuman(sceneId, selfId, nPar1, 1 , 0)
		if createPetRet == 1 then 
			PushDebugMessage( sceneId, selfId,"  看看你的宠物栏，你领取到了宠物" )
			--设置五维资质
			LuaFnSetPetData(sceneId,selfId,retGUID_H,retGUID_L,6,nPar2)
			LuaFnSetPetData(sceneId,selfId,retGUID_H,retGUID_L,7,nPar2)
			LuaFnSetPetData(sceneId,selfId,retGUID_H,retGUID_L,8,nPar2)
			LuaFnSetPetData(sceneId,selfId,retGUID_H,retGUID_L,9,nPar2)
			LuaFnSetPetData(sceneId,selfId,retGUID_H,retGUID_L,10,nPar2)
			--设置成长率
			LuaFnSetPetData(sceneId,selfId,retGUID_H,retGUID_L,13,nPar3)
		else
			PushDebugMessage(sceneId,selfId,"你已经不能携带更多珍兽了")
		end
	end
	if nIndex == 36 then
		RestoreHp(sceneId, selfId)
        RestoreMp(sceneId, selfId)
        RestoreRage(sceneId, selfId)
		PushDebugMessage(sceneId,selfId,"状态恢复成功")
	end
	if nIndex == 37 then
		LuaFnResetSkillCooldowns(sceneId, selfId)
		PushDebugMessage(sceneId,selfId,"冷却恢复成功")
	end
	
end

--**************************************
-- 目标操作(他人)
--**************************************
function x199998_GameMasterControl_TarUse(sceneId,selfId,nIndex,nPar1,nPar2,nPar3)
	--权限检查
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	
	local Logstr = ""
	local nowYear = GetTodayYear();
	local nowMonth = GetTodayMonth()+1
	local nowDate = GetTodayDate();
	local nHour	 = GetHour()
	local nMinute = GetMinute()
	local nName = GetName(sceneId,selfId)
	
	
	if nIndex < 1 or nIndex > 16 then
		PushDebugMessage( sceneId,selfId,"GM_TOOL-TarUse-Error_1!!!")
		return
	end

	local nTarGUID = GetMissionData(sceneId,selfId,MD_TARGUID_DATA)
	if nTarGUID == 0 then
		PushDebugMessage(sceneId,selfId,"请选择要操作的目标。")
		return
	end
	local ParID = LuaFnGuid2ObjId(sceneId,nTarGUID) 
	--操作事件时，一定要限制好，否则会出现大问题。
	if nIndex == 1 then  --查看对方元宝、绑元、金币、交子。
		if ParID == -1 then
			PushDebugMessage(sceneId,selfId,"查看目标财富状态，必须是对方和管理员再同一场景方可查看。")
			return
		end
		local YuanBaoNum = YuanBao(sceneId,ParID,-1,3,0)
		local BindYuanBaoNum = BindYuanBao(sceneId,ParID,-1,3,0) 
		local ZengDianNum = ZengDian(sceneId,ParID,-1,3,0)
		local Money = GetMoney(sceneId,ParID)
		local MoneyJZ = GetMoneyJZ(sceneId,ParID)
		PushDebugMessage(sceneId,selfId,format("角色名：%s#r持有元宝数量：%s#r持有绑定元宝数量：%s#r持有赠点数量：%s#r持有金币数量：#{_EXCHG%s}#r持有交子数量：#{_EXCHG%s}",
			GetName(sceneId,ParID),
			YuanBaoNum,
			BindYuanBaoNum,
			ZengDianNum,
			Money,
			MoneyJZ))
	end
	if nIndex == 2 then --发放物品。
		--检查物品ID
		if nPar1 < 10000000 or nPar1 > 59999999 then
			PushDebugMessage( sceneId,selfId,"输入的物品代码有误，建议使用GM工具物品搜索功能获取物品代码。")
			return
		end
		--检查发放数量
		if nPar2 < 1 or nPar2 > 9999 then
			PushDebugMessage( sceneId,selfId,"物品数量不得小于1或者大于9999，防止出现BUG。")
			return
		end
		--正式发放道具
		BeginAddItem(sceneId)
			AddItem(sceneId,nPar1,nPar2)
			if EndAddItem(sceneId,ParID) <= 0 then
				return
			end
		AddItemListToHuman(sceneId,ParID)
		--给玩家的提示
		PushDebugMessage(sceneId,ParID,format("#Y我去，你被一包裹砸到头，打开一看里面有#G#{_ITEM%d}#Y * #G%d",nPar1,nPar2))
		--给GM的提示和日志
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员成功发放%d个%s。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar2,GetItemName(sceneId,nPar1))
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,"发放成功。")
	end
	if nIndex == 3 then --领金币
		if nPar1 < 0 or nPar1 > 2000000000 then
			PushDebugMessage(sceneId,selfId,"发放数量不得小于0，或大于20万金。")
			return
		end
		--检查玩家金币数量
		if GetMoney(sceneId,ParID) + nPar1 >= 2000000000 then
			PushDebugMessage(sceneId,ParID,"请联系管理员重新发放，发放失败，发的太多了。")
			return
		end
		AddMoney(sceneId,ParID,nPar1) --自带提示
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员成功发放%d金。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,"发放成功。")
	end
	if nIndex == 4 then --领交子
		if nPar1 < 0 or nPar1 > 144000000 then
			PushDebugMessage(sceneId,selfId,"发放数量不得小于0，或大于14400交子。")
			return
		end
		if GetMoneyJZ(sceneId,ParID) + nPar1 >= 144000000 then
			--上限通知
			PushDebugMessage(sceneId,ParID,"请联系管理员重新发放，发放失败，发的太多了。")
			return
		end
		AddMoneyJZ(sceneId,ParID,nPar1)
		PushDebugMessage(sceneId,ParID,format("你获得了#{_EXCHG%s}。",nPar1))
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员成功发放%d交子。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,"发放成功。")
	end
	if nIndex == 5 then   --领元宝
		if nPar1 < 0 or nPar1 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_8_Error_1!!!")
			return
		end
		if YuanBao(sceneId,ParID,-1,3,0) + nPar1 >= 2100000000 then
			--上限通知
			PushDebugMessage(sceneId,ParID,"请联系管理员重新发放，发放失败，发的太多了。")
			return
		end
		YuanBao(sceneId,ParID,-1,1,nPar1)
		PushDebugMessage(sceneId,ParID,format("#Y我去，你被一包裹砸到头，打开一看里面有#G%d点元宝。",nPar1))
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员成功发放%d元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,"发放成功。")
	end
	if nIndex == 6 then   --领绑定元宝
		if nPar1 < 0 or nPar1 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"GM_TOOL-idx_10_Error_1!!!")
			return
		end
		if BindYuanBao(sceneId,ParID,-1,3,0) + nPar1 >= 2100000000 then
			--上限通知
			PushDebugMessage(sceneId,ParID,"请联系管理员重新发放，发放失败，发的太多了。")
			return
		end
		BindYuanBao(sceneId,ParID,-1,1,nPar1)
		PushDebugMessage(sceneId,ParID,format("#Y我去，你被一包裹砸到头，打开一看里面有#G%d点绑定元宝。",nPar1))
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员成功发放%d绑定元宝。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,"发放成功。")
	end
	if nIndex == 7 then --查询MD
		if ParID == -1 then
			PushDebugMessage(sceneId,selfId,"查看目标玩家MD数据，必须是对方和管理员再同一场景方可查看。")
			return
		end
		if nPar1 < 0 or nPar1 > 991 then
			PushDebugMessage(sceneId,selfId,"超出MissionData定义最大值，请重新输入。")
			return
		end
		local MissionData = GetMissionData(sceneId,ParID,nPar1)
		PushDebugMessage(sceneId,selfId,format("目标玩家角色名：%s#r查询目标MD编号为：%s#r当前目标MD编号数据为：%s",GetName(sceneId,ParID),nPar1,MissionData))
	end
	if nIndex == 8 then --查询MDEX
		if ParID == -1 then
			PushDebugMessage(sceneId,selfId,"查看目标玩家MDEX数据，必须是对方和管理员再同一场景方可查看。")
			return
		end
		if nPar1 < 0 or nPar1 > 1023 then
			PushDebugMessage(sceneId,selfId,"超出MissionDataEx定义最大值，请重新输入。")
			return
		end
		local MissionDataEx = GetMissionDataEx(sceneId,ParID,nPar1)
		PushDebugMessage(sceneId,selfId,format("目标玩家角色名：%s#r查询目标MDEX编号为：%s#r当前目标MDEX编号数据为：%s",GetName(sceneId,ParID),nPar1,MissionDataEx))
	end
	if nIndex == 9 then --查询FLAG
		if ParID == -1 then
			PushDebugMessage(sceneId,selfId,"查看目标玩家Flag数据，必须是对方和管理员再同一场景方可查看。")
			return
		end
		if nPar1 < 0 or nPar1 > 5119 then
			PushDebugMessage(sceneId,selfId,"超出MissionFlag定义最大值，请重新输入。")
			return
		end
		local MissionFlag = GetMissionFlag(sceneId,ParID,nPar1)
		PushDebugMessage(sceneId,selfId,format("目标玩家角色名：%s#r查询目标Flag编号为：%s#r当前目标Flag编号数据为：%s",GetName(sceneId,ParID),nPar1,MissionFlag))
	end
	if nIndex == 10 then --设置MD
		if nPar1 < 0 or nPar1 > 991 then
			PushDebugMessage(sceneId,selfId,"超出MissionData定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"超出MissionData设置最大上限，请重新输入。")
			return
		end
		SetMissionData(sceneId,ParID,nPar1,nPar2)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员将MD编号：%d，数据设置为：%d。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1,nPar2)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,format("成功将目标玩家MD编号：%s#r设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 11 then --设置Ex
		if nPar1 < 0 or nPar1 > 1023 then
			PushDebugMessage(sceneId,selfId,"超出MissionDataEx定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 2100000000 then
			PushDebugMessage(sceneId,selfId,"超出MissionDataEx设置最大上限，请重新输入。")
			return
		end
		SetMissionDataEx(sceneId,ParID,nPar1,nPar2,0)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员将MDEX编号：%d，数据设置为：%d。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1,nPar2)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,format("成功将目标玩家MDEX编号：%s设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 12 then --设置Flag
		if nPar1 < 0 or nPar1 > 5119 then
			PushDebugMessage(sceneId,selfId,"超出MissionFlag定义最大值，请重新输入。")
			return
		end
		if nPar2 < 0 or nPar2 > 1 then
			PushDebugMessage(sceneId,selfId,"超出MissionFlag设置最大上限，请重新输入。")
			return
		end
		SetMissionFlag(sceneId,ParID,nPar1,nPar2)
		Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员将FLAG编号：%d，数据设置为：%d。",nowYear,nowMonth,nowDate,nHour,nMinute,nName,nPar1,nPar2)
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		PushDebugMessage(sceneId,selfId,format("成功将目标玩家Flag编号：%s设置为：%s。",nPar1,nPar2))
	end
	if nIndex == 13 then --属性生效
		if GetMissionFlag(sceneId,ParID,MF_GM_ATTRMAX) == 1 then
			SetMissionFlag(sceneId,ParID,MF_GM_ATTRMAX,0)
			Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员将设置为超级属性。",nowYear,nowMonth,nowDate,nHour,nMinute,nName)
			PushDebugMessage(sceneId,selfId,"已将目标玩家属性设置为[生效超级属性]。")
		else
			SetMissionFlag(sceneId,ParID,MF_GM_ATTRMAX,1)
			Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员取消了超级属性。",nowYear,nowMonth,nowDate,nHour,nMinute,nName)
			PushDebugMessage(sceneId,selfId,"已将目标玩家属性设置为[取消超级属性]。")
		end
		x199998_GameLog(sceneId,selfId,2,Logstr) 
		--刷新属性
		LuaFnRefreshHumanData(sceneId,ParID)
	end
	
	if nIndex == 14 then
		local createPetRet, retGUID_H, retGUID_L = LuaFnCreatePetToHuman(sceneId, ParID, nPar1, 1 , 0)
		if createPetRet == 1 then 
			PushDebugMessage( sceneId, ParID,"  看看你的宠物栏，管理员给你发放了新宠物" )
			--设置五维资质
			LuaFnSetPetData(sceneId,ParID,retGUID_H,retGUID_L,6,nPar2)
			LuaFnSetPetData(sceneId,ParID,retGUID_H,retGUID_L,7,nPar2)
			LuaFnSetPetData(sceneId,ParID,retGUID_H,retGUID_L,8,nPar2)
			LuaFnSetPetData(sceneId,ParID,retGUID_H,retGUID_L,9,nPar2)
			LuaFnSetPetData(sceneId,ParID,retGUID_H,retGUID_L,10,nPar2)
			--设置成长率
			LuaFnSetPetData(sceneId,ParID,retGUID_H,retGUID_L,13,nPar3)
			Logstr = format("[发放时间：%d-%d-%d-%d-%d]，角色名：%s，被管理员发放了 "..nPar1.." 宠物",nowYear,nowMonth,nowDate,nHour,nMinute,nName)
			x199998_GameLog(sceneId,selfId,2,Logstr) 
		else
			PushDebugMessage(sceneId,selfId,"请联系管理员重新发放，发放失败，您的宠物背包已经满了。")
		end
	end
	
	if nIndex == 15 then --查看buff
		x199998_GetBuff(sceneId,ParID,-1)
	end
	
	if nIndex == 16 then --提升等级
		LuaFnHumanLevelUpTo(sceneId,ParID,nPar1)
		PushDebugMessage( sceneId, ParID,"  管理员给你的等级提升为:"..tostring(nPar1).."级" )
		PushDebugMessage(sceneId,selfId,"成功将玩家等级提升为:"..tostring(nPar1).."级")
	end
	
end

--**********************************
--查询身上存在多少BUFF
--**********************************
function x199998_GetBuff(sceneId,selfId,targetId)
	local count,lists = LuaFnGetBuffList(sceneId,selfId)
	local str = ""
	for j = 1, getn(lists) do 
		str =str ..lists[j]..","
	end
	BeginEvent( sceneId )
		AddText( sceneId, "BUFF NUM:"..count.."\n"..str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 游戏管理员工具日志记录
--**********************************
function x199998_GameLog(sceneId,selfId,nIndex,Logstr)
	local LogTxt = {"Self_Log","Tar_Log"}
	local LogFile = openfile("./PlayerLog/GMLog/"..LogTxt[nIndex]..".txt", "a+")
	if nil ~= LogFile then
	    if Logstr == nil then
			Logstr = "" 
		end
		write(LogFile,Logstr)
		write(LogFile,tostring("\n"))
		closefile(LogFile)
	end

end

--**********************************
-- 打开道具搜索功能
--**********************************
function x199998_OpenGameMasterControl_ItemSearch(sceneId,selfId,nX,nY)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, nX)
		UICommand_AddInt( sceneId, nY)
	EndUICommand( sceneId )
	DispatchUICommand(sceneId,selfId, 707022022)
end

--**********************************
-- 对话框提示
--**********************************
function PushDebugMessage(sceneId,selfId,Tip)
	BeginEvent( sceneId )
		AddText( sceneId,Tip)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId,-1 )
end