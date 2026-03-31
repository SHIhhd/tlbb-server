--累计充值消费
x889053_g_ScriptId	= 889053;

x889053_g_CTUID = 1001000002

x889053_g_CTUIDEx = 1001000003
--**********************************
--列举事件
--**********************************
function x889053_OnEnumerate( sceneId, selfId, targetId )
	
	if LuaFnCTUCheckIsShutDown(sceneId,selfId,x889053_g_CTUID) == 0 then
		AddNumText( sceneId, x889053_g_ScriptId, "预充值活动奖励领取", 6, 1 );
	end
	if LuaFnCTUCheckIsShutDown(sceneId,selfId,x889053_g_CTUIDEx) == 0 then
		AddNumText( sceneId, x889053_g_ScriptId, "充值回馈领取", 6, 2 );
	end
	
	local nAddExpCount = GetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT)
	if nAddExpCount > 0 then
		AddNumText( sceneId, x889053_g_ScriptId, "领取50W经验奖励", 6, 3);
	end
end

--**********************************
--任务入口函数
--**********************************
function x889053_OnDefaultEvent( sceneId, selfId, targetId )	--点击天龙向前冲

	local opt = GetNumText();
	if opt == 1 then
		if LuaFnCTUCheckIsShutDown(sceneId,selfId,x889053_g_CTUID) == 1 then
			return
		end
		x889053_Precharge(sceneId,selfId,targetId)
		return
	end
	if opt == 2 then
		if LuaFnCTUCheckIsShutDown(sceneId,selfId,x889053_g_CTUIDEx) == 1 then
			return
		end
		x889053_ChargePrize(sceneId,selfId,targetId)
		return
	end
	if opt == 3 then
		local nAddExpCount = GetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT)
		if nAddExpCount <= 0 then
			x889053_ReturnDlg(sceneId, selfId, targetId, "  你似乎无法再领取这个奖励了")
			return
		end
		AddExp(sceneId,selfId,500000)
		nAddExpCount = nAddExpCount - 1
		SetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT,nAddExpCount)
		x889053_Tips(sceneId, selfId, "您成功领取了经验奖励，当前剩余可领取次数为"..nAddExpCount.."次")
		return
	end
end

--**********************************
-- 充值活动奖励领取
--**********************************
function x889053_ChargePrize(sceneId,selfId,targetId)
	--检测玩家兑换了多少点数
	local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
	local aGiftInfo = {
		{
			needPoint = 2000,
			--重楼戒*1  百相绘卷·骨翼*1  背饰：紫霄宝葫*1
			aItem = {
				{10422016,1,0},
				{38003229,1,0},
				{38003682,1,0},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 10000,
			--重楼戒*1  幻世武器：泰阿剑*1  坐骑：惊流云*1
			aItem = {
				{10422016,1,0},
				{38003582,1,0},
				{10143024,1,0},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 20000,
			--重楼玉*1  幻世武器：引墨*1  坐骑：掠千峰*1
			aItem = {
				{10423024,1,0},
				{38003672,1,0},
				{10143004,1,0},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 4000,
			--3级秘银*20  3级棉布*20  神魂檀箱*100   高级长春玉*5   淬火玉*30    魔尊魂武*20
			aItem = {
				{20502003,20,0},
				{20501003,20,0},
				{38002499,100,1},
				{20600002,5,1},
				{38003055,30,1},
				{38000540,20,1},
          	},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 5000,
			--3级秘银*20  3级棉布*20  神魂檀箱*100   高级长春玉*5   淬火玉*30    魔尊魂武*20 
			aItem = {
				{20502003,20,0},
				{20501003,20,0},
				{38002499,100,1},
				{20600002,5,1},
				{38003055,30,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 6000,
			--3级秘银*20  3级棉布*20  神魂檀箱*100   高级长春玉*5   淬火玉*30    魔尊魂武*20
			aItem = {
				{20502003,20,0},
				{20501003,20,0},
				{38002499,100,1},
				{20600002,5,1},
				{38003055,30,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 7000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   高级长春玉*5   淬火玉*30    魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600002,5,1},
				{38003055,30,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 8000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   高级长春玉*5   淬火玉*30    魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600002,5,1},
				{38003055,30,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 9000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   高级长春玉*5   淬火玉*30    魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600002,5,1},
				{38003055,30,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 10000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   超级长春玉*5   淬火玉*50  魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600003,5,1},
				{38003055,50,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 12000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   超级长春玉*5   淬火玉*50  魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600003,5,1},
				{38003055,50,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 14000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   超级长春玉*5   淬火玉*50  魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600003,5,1},
				{38003055,50,1},
				{38000540,20,1},
          	},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 16000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   超级长春玉*5   淬火玉*50  魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600003,5,1},
				{38003055,50,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 18000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   超级长春玉*5   淬火玉*50  魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600003,5,1},
				{38003055,50,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 20000,
			--4级秘银*20  4级棉布*20  神魂檀箱*100   超级长春玉*5   淬火玉*50  魔尊魂武*20
			aItem = {
				{20502004,20,0},
				{20501004,20,0},
				{38002499,100,1},
				{20600003,5,1},
				{38003055,50,1},
				{38000540,20,1},
			},
			expCount = 0,			--增加可领50W经验的次数
		},
	}
	
	local nCurGetPoint = GetMissionDataEx(sceneId,selfId,MDEX_CHARGE_HAD_GET_POINT)
	local bGetPirze = 0
	BeginAddItem(sceneId)
	for i = 1,getn(aGiftInfo) do
		if nExchPoint >= aGiftInfo[i].needPoint and aGiftInfo[i].needPoint > nCurGetPoint then
			for iItem = 1,getn(aGiftInfo[i].aItem) do
				local tItem = aGiftInfo[i].aItem[iItem]
				if tItem[3] ~= nil and tItem[3] == 1 then
					AddBindItem(sceneId,tItem[1],tItem[2])
				else
					AddItem(sceneId,tItem[1],tItem[2])
				end
			end
			bGetPirze = 1
		end
	end
	if bGetPirze == 0 then
		x889053_ReturnDlg(sceneId, selfId, targetId, "  你似乎没有可以领取的奖励，再接再厉吧#r  您当前已经兑换了#G"..nExchPoint.."#W元的点数")
		return
	end
	if EndAddItem(sceneId,selfId,1) <= 0 then
		
		x889053_Tips(sceneId, selfId, "你的背包似乎不够了，请清理下再来吧！")
		
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x889053_ReturnDlg(sceneId, selfId, targetId,ScriptGlobal_Format("#{NSHDLB_220318_02}",tostring(iBase)));
		end
		if iMat ~= nil and iMat > 0 then
			x889053_ReturnDlg(sceneId, selfId, targetId,ScriptGlobal_Format("#{NSHDLB_220318_03}",tostring(iMat)));
		end		
		return
	end
	--发放成功
	AddItemListToHuman(sceneId,selfId)
	--标记奖励领取
	for i = 1,getn(aGiftInfo) do
		if nExchPoint >= aGiftInfo[i].needPoint and aGiftInfo[i].needPoint > nCurGetPoint then
			--设置目前领取的标记点数
			SetMissionDataEx(sceneId,selfId,MDEX_CHARGE_HAD_GET_POINT,aGiftInfo[i].needPoint)
			if aGiftInfo[i].expCount > 0 then
				local nAddExpCount = GetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT)
				nAddExpCount = nAddExpCount + aGiftInfo[i].expCount
				SetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT,nAddExpCount)
				x889053_Tips(sceneId, selfId, "您可领取50W经验奖励的次数增加了"..aGiftInfo[i].expCount.."次，请也在我这里领取哦!")
			end
		end
	end
	x889053_ReturnDlg(sceneId, selfId, targetId, "  奖励已经发到你的背包了，请查收")
end
--**********************************
-- 预充活动
--**********************************
function x889053_Precharge(sceneId,selfId,targetId)
	--检测玩家兑换了多少点数
	local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
	local aGiftInfo = {
		{
			needPoint = 200,
			--3级秘银*20   3级棉布*20    淬火玉*20   仙灵鹤武礼盒*38002656
			aItem = {
				{20502003,20},
				{20501003,20},
				{38003055,20},
				{38002656,1},
			},
			aPet = {
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 1000,
			-- 神魂檀箱*200  武道玄元丹*1000   淬火玉*50   幻饰武器冰河*1 38002994
			aItem = {
				{38002499,200},
				{38002397,1000},
				{38003055,50},
				{38002994,1},
				--重楼戒
				-- {10422016,1},
				--重楼玉
				-- {10423024,1},
				--重楼肩
				-- {10415055,1},
				--重楼甲
				-- {10413102,1},
			},
			aPet = {
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 3000,
			--神魂檀箱*300  武道玄元丹*1500    淬火玉100  幻饰武器金箍棒*1   典藏珍兽蛋：千锋王蝎*1（ID：30310127）（资质2600） 
			aItem = {
				{38002499,300},
				{38002397,1500},
				{38003055,100},
				{38003215,1},
        	},
			--典藏珍兽蛋：千锋王蝎*1
			aPet = {
				{dataId = 31041,minPer = 2600},	--资质限制
			},
			expCount = 0,			--增加可领50W经验的次数
		},
		{
			needPoint = 5000,
			--神魂檀箱*500  武道玄元丹*2000    淬火玉150   幻饰武器混天玄戟*1  典藏珍兽蛋：平天大圣*1（ID：30310137）（资质3000） 
			aItem = {
				{38002499,500},
				{38002397,2000},
				{38003055,150},
				{38003024,1},
			},
			--典藏珍兽蛋：平天大圣*1
			aPet = {
				{dataId = 30281,minPer = 3000},	--资质限制
			},
			expCount = 0,			--增加可领50W经验的次数
		},
	}
	
	local nCurGetPoint = GetMissionDataEx(sceneId,selfId,MDEX_PRE_CHARGE_HAD_GET_POINT)
	local bGetPirze = 0
	local nWillAddPetCount = 0
	BeginAddItem(sceneId)
	for i = 1,getn(aGiftInfo) do
		if nExchPoint >= aGiftInfo[i].needPoint and aGiftInfo[i].needPoint > nCurGetPoint then
			for iItem = 1,getn(aGiftInfo[i].aItem) do
				local tItem = aGiftInfo[i].aItem[iItem]
				if tItem[1] == 20501003 or tItem[1] == 20502003
				or tItem[1] == 20501004 or tItem[1] == 20502004 then
					AddItem(sceneId,tItem[1],tItem[2])
				else
					AddBindItem(sceneId,tItem[1],tItem[2])
				end
			end
			nWillAddPetCount = nWillAddPetCount + getn(aGiftInfo[i].aPet)
			bGetPirze = 1
		end
	end
	if bGetPirze == 0 then
		x889053_ReturnDlg(sceneId, selfId, targetId, "  你似乎没有可以领取的奖励，再接再厉吧#r  您当前已经兑换了#G"..nExchPoint.."#W元的点数")
		return
	end
	if EndAddItem(sceneId,selfId,1) <= 0 then
		x889053_Tips(sceneId, selfId, "你的背包似乎不够了，请清理下再来吧！")
		
		local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
		if iBase ~= nil and iBase > 0 then
			x889053_ReturnDlg(sceneId, selfId, targetId,ScriptGlobal_Format("#{NSHDLB_220318_02}",tostring(iBase)));
		end
		if iMat ~= nil and iMat > 0 then
			x889053_ReturnDlg(sceneId, selfId, targetId,ScriptGlobal_Format("#{NSHDLB_220318_03}",tostring(iMat)));
		end		
		return
	end
	--宠物是否放得下
	if nWillAddPetCount > 0 and TryCreatePet(sceneId,selfId,nWillAddPetCount) ~= 1 then
		x889053_ReturnDlg(sceneId, selfId, targetId, "  你不能携带更多的珍兽了，请稍后再来吧！")
		return
	end
	--发放成功
	AddItemListToHuman(sceneId,selfId)
	--标记奖励领取
	for i = 1,getn(aGiftInfo) do
		if nExchPoint >= aGiftInfo[i].needPoint and aGiftInfo[i].needPoint > nCurGetPoint then
			SetMissionDataEx(sceneId,selfId,MDEX_PRE_CHARGE_HAD_GET_POINT,aGiftInfo[i].needPoint)
			if aGiftInfo[i].expCount > 0 then
				local nAddExpCount = GetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT)
				nAddExpCount = nAddExpCount + aGiftInfo[i].expCount
				SetMissionDataEx(sceneId,selfId,MDEX_PRIZE_ADDEXPCOUNT,nAddExpCount)
				x889053_Tips(sceneId, selfId, "您可领取50W经验奖励的次数增加了"..aGiftInfo[i].expCount.."次，请也在我这里领取哦!")
			end
			--增加宠物
			for iPet = 1,getn(aGiftInfo[i].aPet) do
				local aPet = aGiftInfo[i].aPet[iPet]
				local ret,petGUID_H,petGUID_L = CallScriptFunction( 800105, "CreateRMBPetToHuman", sceneId, selfId, aPet.dataId, 1);
				if ret and ret == 1 then
					LuaFnSetPetGrowRateByGUID(sceneId,selfId,petGUID_H,petGUID_L,2388)
					local nPerception = random(aPet.minPer,aPet.minPer + 300)
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
	end
	x889053_ReturnDlg(sceneId, selfId, targetId, "  奖励已经发到你的背包了，请查收")
end
--**********************************
--返回对话
--**********************************
function x889053_ReturnDlg(sceneId, selfId, targetId, msg)
	BeginEvent(sceneId)
		AddText(sceneId, msg);
	EndEvent()
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--ReturnTips
--**********************************
function x889053_Tips(sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId, msg);
	EndEvent()
	DispatchMissionTips(sceneId, selfId)
end

--**********************************
--关闭对话框
--**********************************
function x889053_CloseDlg(sceneId, selfId, targetId)
	BeginUICommand( sceneId )
	UICommand_AddInt( sceneId, targetId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 1000 )	
end

--**********************************
--接受
--**********************************
function x889053_OnAccept( sceneId, selfId )


end

--**********************************
--放弃
--**********************************
function x889053_OnAbandon( sceneId, selfId )

end

--**********************************
--继续
--**********************************
function x889053_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x889053_CheckSubmit( sceneId, selfId )

end

--**********************************
--提交
--**********************************
function x889053_OnSubmit( sceneId, selfId, targetId,selectRadioId )

end

--**********************************
--杀死怪物或玩家
--**********************************
function x889053_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x889053_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x889053_OnItemChanged( sceneId, selfId, itemdataId )
end

