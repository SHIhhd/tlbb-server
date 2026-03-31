--武魂幻魂主脚本

x888800_g_ScriptId = 888800
--幻魂升级概率
x888800_g_SuccRadom = {
[0]=100,
[1]=85,
[2]=70,
[3]=55,
[4]=40,
[5]=40,
[6]=40,
[7]=40,
[8]=40,
[9]=40,
[10]=40,
}
--因为运营要求，修改为100次上限
x888800_g_MaxLevelUpCount = 100

--**********************************
--激活外观
--**********************************
function x888800_ActiveWg(sceneId,selfId,nSel,nIsOk)
	if GetLevel(sceneId,selfId) < 80 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_213}")
		return
	end
	--没选中
	if nSel == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_78}")
		return
	end
	local nValid,bUnlock,szName,need_item,need_item_bind,need_item_count,need_money = LuaFnGetWHWGInfo(sceneId,selfId,nSel)
	if nValid == nil or nValid == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_78}")
		return
	end
	if bUnlock == 1 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_79}")
		return
	end
	--取得所需条件
	if LuaFnMtl_GetCostNum(sceneId,selfId,need_item,need_item_bind) < need_item_count then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_80}")
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_81}")
		return
	end
	if nIsOk ~= 1 then
		--客户端二次提示
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,nSel)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,88880005)
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money );
	--扣道具
	if LuaFnMtl_CostMaterial(sceneId,selfId,need_item_count,need_item,need_item_bind) ~= 1 then
		return
	end
	--解锁
	LuaFnWHWGUnlocked(sceneId,selfId,nSel)
	--任务记录写入
	if IsHaveMission(sceneId,selfId,2008) > 0 then
		local misIndex = GetMissionIndexByID(sceneId,selfId,2008)
		--直接设置任务完成
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	end
	--提示
	x888800_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_83}", szName))
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
end
--**********************************
--升级外观
--**********************************
function x888800_LevelUpWg(sceneId,selfId,nSel)
	if GetLevel(sceneId,selfId) < 80 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_213}")
		return
	end
	--没选中
	if nSel == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_78}")
		return
	end
	local nValid,bUnlock,szName = LuaFnGetWHWGInfo(sceneId,selfId,nSel)
	if nValid == nil or nValid == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_78}")
		return
	end
	if bUnlock ~= 1 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_93}")
		return
	end
	local nCurGrade,nCurLevel = LuaFnGetWHWGLevelInfo(sceneId,selfId,nSel)
	if nCurGrade == 0 and nCurLevel == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_93}")
		return
	end
	--您选择的幻魂已升级至满级，无法继续进行升级操作。	
	if nCurGrade == 10 and nCurLevel == 10 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_94}")
		return
	end
	if nCurLevel == 10 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_95}")
		return
	end
	--检查材料及金钱
	local need_itembind,need_itemunbind,need_itemcount,need_money = LuaFnGetWHWGLevelCostInfo(nSel,nCurGrade,nCurLevel)
	--取得所需条件
	if LuaFnMtl_GetCostNum(sceneId,selfId,need_itembind,need_itemunbind) < need_itemcount then
		--升级材料不足或已加锁。	
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_182}")
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_81}")
		return
	end
	local nMDData = GetMissionDataEx(sceneId,selfId,MDEX_WUHUN_TUPU_UPDATE_TIME)
	local nRadomIdx = floor(nMDData/10000000)
	local nTodayLevelupCount = mod(nMDData,1000)
	if nTodayLevelupCount >= x888800_g_MaxLevelUpCount then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_162}")
		return
	end
	if nRadomIdx > 10 then
		nRadomIdx = 10
	end
	local nSuccessRate = x888800_g_SuccRadom[nRadomIdx]
	if nSuccessRate == nil then
		return
	end
	--之前的逻辑bug，这里扣除应该先扣除，再去找几率是否可以升级，这个是升级成功了才扣材料和金币，不对劲。
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money );
	--扣道具
	if LuaFnMtl_CostMaterial(sceneId,selfId,need_itemcount,need_itembind,need_itemunbind) ~= 1 then
		return
	end
	if LuaFnGemEmbedRandom() > nSuccessRate then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_163}")
		--失败也要更新总次数
		nTodayLevelupCount = nTodayLevelupCount + 1
		nMDData = nRadomIdx * 10000000 + nTodayLevelupCount
		SetMissionDataEx(sceneId,selfId,MDEX_WUHUN_TUPU_UPDATE_TIME,nMDData)
	else
		--升级
		LuaFnWHWGUpdateLevel(sceneId,selfId,nSel)
		--更新重洗次数
		nTodayLevelupCount = nTodayLevelupCount + 1
		nRadomIdx = nRadomIdx + 1;
		if nRadomIdx > 10 then
			nRadomIdx = 10
		end
		nMDData = nRadomIdx * 10000000 + nTodayLevelupCount
		SetMissionDataEx(sceneId,selfId,MDEX_WUHUN_TUPU_UPDATE_TIME,nMDData)
		--提示
		x888800_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_96}", szName))
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	end
	
	--更新客户端显示
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,-1)
		UICommand_AddInt(sceneId,GetMissionDataEx(sceneId,selfId,MDEX_WUHUN_TUPU_UPDATE_TIME))
    EndUICommand(sceneId)
    DispatchUICommand(sceneId,selfId,88880002)
end
--**********************************
--外观进阶
--**********************************
function x888800_GradeUpWg(sceneId,selfId,nSel)
	if GetLevel(sceneId,selfId) < 80 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_213}")
		return
	end
	--没选中
	if nSel == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_78}")
		return
	end
	--未激活
	local nValid,bUnlock,szName = LuaFnGetWHWGInfo(sceneId,selfId,nSel)
	if nValid == nil or nValid == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_103}")
		return
	end
	if bUnlock ~= 1 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_103}")
		return
	end
	local nCurGrade,nCurLevel = LuaFnGetWHWGLevelInfo(sceneId,selfId,nSel)
	if nCurGrade == 0 and nCurLevel == 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_103}")
		return
	end
	--您选择的幻魂已进阶至满级，无法继续进行进阶操作。	
	if nCurGrade == 10 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_104}")
		return
	end
	if nCurLevel ~= 10 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_105}")
		return
	end
	--检查材料及金钱
	local need_itembind,need_itemunbind,need_itemcount,need_money = LuaFnGetWHWGLevelCostInfo(nSel,nCurGrade,10)
	--取得所需条件
	if LuaFnMtl_GetCostNum(sceneId,selfId,need_itembind,need_itemunbind) < need_itemcount then
		--升级材料不足或已加锁。	
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_183}")
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < need_money then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_81}")
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, need_money );
	--扣道具
	if LuaFnMtl_CostMaterial(sceneId,selfId,need_itemcount,need_itembind,need_itemunbind) ~= 1 then
		return
	end
	--升阶
	LuaFnWHWGUpdateGrade(sceneId,selfId,nSel)
	--提示
	x888800_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_107}", szName))
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
end
--**********************************
--取下幻魂
--**********************************
function x888800_TakeOut(sceneId,selfId,slot)
	if GetLevel(sceneId,selfId) < 80 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_213}")
		return
	end
	local nSlodWhWgId = LuaFnGetWHWGInSlot(sceneId,selfId,slot)
	if nSlodWhWgId == nil or nSlodWhWgId <= 0 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_53}")
		return
	end
	local nValid,_,szName = LuaFnGetWHWGInfo(sceneId,selfId,nSlodWhWgId)
	if nValid == nil or nValid == 0 then
		return
	end
	LuaFnActiveWhWgSlot(sceneId,selfId,slot,0)
	x888800_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{WH_210223_54}", szName))
end
--**********************************
--打开幻魂变更页面
--**********************************
function x888800_OpenChangeWg(sceneId,selfId)
	if GetLevel(sceneId,selfId) < 80 then
		x888800_NotifyTip( sceneId, selfId, "#{WH_210223_213}")
		return
	end
	
end
--**********************************
--切换幻魂外观
--**********************************
function x888800_SwitchYY(sceneId,selfId,bShow)
	LuaFnWHWGSwitchYY(sceneId,selfId,bShow)
end

--**********************************
--醒目提示
--**********************************
function x888800_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end