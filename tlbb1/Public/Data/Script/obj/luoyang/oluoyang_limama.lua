--洛阳NPC
--神医
--普通

--脚本号
x000044_g_scriptId = 000044

--所拥有的事件ID列表
x000044_g_eventList={806010,701603,890024}				-- 擂台观战脚本、“珍兽治疗”脚本、跨服校场

--游医脚本编号
x000044_g_healScriptId = 000064

-- 清除技能CD相关配置
x000044_g_clearCdCost = 50000 --5金币
x000044_g_confirmClearKey = 9991  
x000044_g_cancelClearKey = 9992  

-- 新增：清理背包分栏配置
x000044_g_clearPropConfirmKey = 8889   
x000044_g_clearPropCancelKey = 8890    
x000044_g_clearMatConfirmKey = 8891    
x000044_g_clearMatCancelKey = 8892    

--治疗设定 参见脚本000064

--**********************************
-- 通用提示框函数
--**********************************
function x000044_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 补全缺失的快捷功能函数
--**********************************
function x000044_EquipLevelupQuickly( sceneId, selfId)
    -- 空函数，仅用于避免脚本报错，不影响核心功能
    return
end

--**********************************
-- 新增：清理道具栏
--**********************************
function x000044_ClearPropBag( sceneId, selfId, targetId )
    local nClearCount = 0  -- 统计道具栏清理数量
    
    -- 遍历0-99格
    for i = 0, 99 do
        local nItemID = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)
        if nItemID > 0 then  -- 仅清理有物品的格子
            LuaFnEraseItem(sceneId, selfId, i)
            nClearCount = nClearCount + 1
        end
    end
    
    -- 精准提示结果
    if nClearCount > 0 then
        x000044_MsgBox(sceneId, selfId, targetId, "#G道具栏清理完成！共清理"..nClearCount.."个物品（0-99格）")
    else
        x000044_MsgBox(sceneId, selfId, targetId, "#W道具栏（0-99格）内无物品可清理！")
    end
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
end

--**********************************
-- 清理材料栏
--**********************************
function x000044_ClearMaterialBag( sceneId, selfId, targetId )
    local nClearCount = 0  -- 统计材料栏清理数量
    
    -- 遍历100-200格（材料栏）
    for i = 100, 200 do
        local nItemID = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)
        if nItemID > 0 then  -- 仅清理有物品的格子
            LuaFnEraseItem(sceneId, selfId, i)
            nClearCount = nClearCount + 1
        end
    end
    
    -- 精准提示结果
    if nClearCount > 0 then
        x000044_MsgBox(sceneId, selfId, targetId, "#G材料栏清理完成！共清理"..nClearCount.."个物品（100-200格）")
    else
        x000044_MsgBox(sceneId, selfId, targetId, "#W材料栏（100-200格）内无物品可清理！")
    end
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
end

--**********************************
--事件列表
--**********************************
function x000044_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#少侠你好，我这里可以传送和使用快捷功能")

		-- AddNumText(sceneId,x000044_g_scriptId,"#G快捷传送",9,888) 		
		AddNumText(sceneId,x000044_g_scriptId,"满怒治疗",6,0)		
        AddNumText(sceneId, x000044_g_scriptId,"#R快捷功能", 6, 8881)
		AddNumText( sceneId, x000044_g_scriptId, "内测领取", 6,11001)		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000044_OnDefaultEvent( sceneId, selfId,targetId )
	x000044_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000044_OnEventRequest( sceneId, selfId, targetId, eventId )
	-- 调用“江湖游医”脚本中计算金钱的函数
	local	gld = CallScriptFunction( x000044_g_healScriptId, "CalcMoney_hpmp",sceneId, selfId, targetId )* 0.1

	local	key	= GetNumText()
	
	-- 快捷功能列表
	if key == 8881 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x000044_g_scriptId,"#R一键完成引导任务",2,11111) 
			AddNumText(sceneId, x000044_g_scriptId, "#R一键学习新手技能", 2, 9999)		
			AddNumText(sceneId,x000044_g_scriptId,"#R一键清除技能CD",2,999) 
			--AddNumText(sceneId, x000044_g_scriptId, "#R一键清理道具栏", 2, 8888)			
			--AddNumText(sceneId, x000044_g_scriptId, "#R一键清理材料栏", 2, 8887)
			AddNumText(sceneId, x000044_g_scriptId, "#G快捷使用元宝票", 2, 6666)	
			AddNumText(sceneId, x000044_g_scriptId, "#G快捷使用绑定元宝票", 2, 7777)
			AddNumText(sceneId, x000044_g_scriptId, "#G快捷使用武道丹", 2, 1011)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		x000044_EquipLevelupQuickly( sceneId, selfId)
		return
	end	
	-- **************************
	-- 清理道具栏
	-- **************************
	if key == 8888 then
		BeginEvent(sceneId)
			AddText(sceneId, "#Y警告：确认清理道具栏所有物品吗？")
			AddText(sceneId, "#R（物品销毁后无法恢复，请谨慎操作！）")
			AddNumText(sceneId, x000044_g_scriptId, "#G确认清理", 6, x000044_g_clearPropConfirmKey)
			AddNumText(sceneId, x000044_g_scriptId, "#R取消", 6, x000044_g_clearPropCancelKey)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	-- 确认清理道具栏
	if key == x000044_g_clearPropConfirmKey then
		x000044_ClearPropBag(sceneId, selfId, targetId)
		return
	end
	-- 取消清理道具栏
	if key == x000044_g_clearPropCancelKey then
		x000044_MsgBox(sceneId, selfId, targetId, "#W已取消道具栏清理操作！")
		return
	end

	-- **************************
	-- 新增：清理材料栏
	-- **************************
	if key == 8887 then
		BeginEvent(sceneId)
			AddText(sceneId, "#Y警告：确认清理材料栏所有物品吗？")
			AddText(sceneId, "#R（物品销毁后无法恢复，请谨慎操作！）")
			AddNumText(sceneId, x000044_g_scriptId, "#G确认清理", 6, x000044_g_clearMatConfirmKey)
			AddNumText(sceneId, x000044_g_scriptId, "#R取消", 6, x000044_g_clearMatCancelKey)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	-- 确认清理材料栏
	if key == x000044_g_clearMatConfirmKey then
		x000044_ClearMaterialBag(sceneId, selfId, targetId)
		return
	end
	-- 取消清理材料栏
	if key == x000044_g_clearMatCancelKey then
		x000044_MsgBox(sceneId, selfId, targetId, "#W已取消材料栏清理操作！")
		return
	end
	
	-- 元宝票兑换逻辑
	local xiaoxiang_ybpd = {
	[38000350] = 50,
	[38000351] = 100,
	[38000352] = 200,
	[38000353] = 500,
	[38000354] = 1000,
	[38000355] = 2000,
	[38000356] = 5000,
	[38000357] = 10000,
	[38000358] = 30000,
	[38000359] = 50000,
	[38000360] = 100000,
	}
	if key == 6666 then
		local xiaoxiang_yuanbao = 0
		for i = 0, 99 do
			local xiaoxiang_t = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)
			if xiaoxiang_ybpd[xiaoxiang_t] ~= nil then
				local xiaoxiang_y = LuaFnGetItemCountInBagPos(sceneId, selfId, i)
				xiaoxiang_yuanbao = xiaoxiang_yuanbao + xiaoxiang_ybpd[xiaoxiang_t] * xiaoxiang_y
			end
		end
		BeginEvent(sceneId)
		AddText(sceneId, "#Y你背包里的元宝票总共可以兑换")
		AddText(sceneId, "#cFF0000" .. xiaoxiang_yuanbao)
		AddText(sceneId, "#G元宝")
		if xiaoxiang_yuanbao > 0 then
			AddNumText(sceneId, x000044_g_scriptId, "#G确定兑换", 6, 986512)
		end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	if key == 986512 then
		local xiaoxiang_yuanbao = 0
		for i = 0, 99 do
			local xiaoxiang_t = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)
			if xiaoxiang_ybpd[xiaoxiang_t] ~= nil then
				local xiaoxiang_y = LuaFnGetItemCountInBagPos(sceneId, selfId, i)
				LuaFnEraseItem(sceneId, selfId, i)
				xiaoxiang_yuanbao = xiaoxiang_yuanbao + xiaoxiang_ybpd[xiaoxiang_t] * xiaoxiang_y
			end
		end
		YuanBao(sceneId, selfId, -1, 1, xiaoxiang_yuanbao)
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:兑换成功", 0);
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, 1000)
		return
	end
	-- 绑定元宝票兑换逻辑
	local xxiaoxiang_bdybpd = { 
		[38000060] = 100,
		[38000202] = 50,
		[38000203] = 200,
		[38000300] = 1000,
		[38000301] = 2000,
		[38000302] = 3000,
		[38000303] = 5000,
		[38000304] = 10000,
		[38000305] = 20000,
		[38002162] = 70,
		[38002163] = 75,
		[38002164] = 80,
		[38002165] = 85,
		[38002166] = 90,
		[38002167] = 95,
		[38002168] = 300,
		[38002169] = 500,
		[38002174] = 110,
		[38002175] = 130,
		[38002176] = 150,
		[38002224] = 40,
		[38002225] = 45,
		[38002226] = 55,
		[38002227] = 60,
		[38002263] = 20,
		[38002264] = 30,
	}
	if GetNumText() == 7777 then
		local xiaoxiang_yuanbao = 0
		for i = 0, 99 do
			local xiaoxiang_t = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)
			if xxiaoxiang_bdybpd[xiaoxiang_t] ~= nil then
				local xiaoxiang_y = LuaFnGetItemCountInBagPos(sceneId, selfId, i)
				xiaoxiang_yuanbao = xiaoxiang_yuanbao + xxiaoxiang_bdybpd[xiaoxiang_t] * xiaoxiang_y
			end
		end
		BeginEvent(sceneId)
		AddText(sceneId, "#Y你背包里的绑元元宝票总共可以兑换")
		AddText(sceneId, "#G     " .. xiaoxiang_yuanbao)
		AddText(sceneId, "    绑定元宝")
		if xiaoxiang_yuanbao > 0 then
			AddNumText(sceneId, x000044_g_scriptId, "#G确定兑换", 6, 986511)
		end
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	if GetNumText() == 986511 then
		local xiaoxiang_yuanbao = 0
		for i = 0, 99 do
			local xiaoxiang_t = LuaFnGetItemTableIndexByIndex(sceneId, selfId, i)
			if xxiaoxiang_bdybpd[xiaoxiang_t] ~= nil then
				local xiaoxiang_y = LuaFnGetItemCountInBagPos(sceneId, selfId, i)
				if LuaFnEraseItem(sceneId, selfId, i) == 1 then
					xiaoxiang_yuanbao = xiaoxiang_yuanbao + xxiaoxiang_bdybpd[xiaoxiang_t] * xiaoxiang_y
				end
			end
		end
		BindYuanBao(sceneId, selfId, targetId, 1, xiaoxiang_yuanbao)
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:兑换成功", 0);
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, 1000)
		return
	end	
	if key == 9999 then
		AddSkill( sceneId, selfId, 238)	
		AddSkill( sceneId, selfId, 241)
		AddSkill( sceneId, selfId, 242)
		AddSkill( sceneId, selfId, 243)
		AddSkill( sceneId, selfId, 244) 
		AddSkill( sceneId, selfId, 245)
		AddSkill( sceneId, selfId, 246)
		AddSkill( sceneId, selfId, 247)
		AddSkill( sceneId, selfId, 248)
		AddSkill( sceneId, selfId, 249)
		AddSkill( sceneId, selfId, 277)  
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	end
	-- 快捷使用武道玄元丹
	if key == 1011 then
		local HaveJSC = LuaFnMtl_GetCostNum(sceneId, selfId, 38002397, 38002398)
		if HaveJSC ~= nil and HaveJSC ~= 0 then
			local ret = LuaFnMtl_CostMaterial(sceneId, selfId, HaveJSC, 38002397, 38002398)
			if ret == 1 then
				LuaFnSetSectPoint(sceneId, selfId, LuaFnGetSectPoint(sceneId, selfId) + HaveJSC)
				BeginEvent(sceneId) 
				AddText(sceneId, "#47温馨提示：您背包内的武道玄元丹已自动使用，使用个数:" .. HaveJSC)
				EndEvent(sceneId)
				DispatchMissionTips(sceneId, selfId)
			end
		else
			BeginEvent(sceneId)
			AddText(sceneId, "  背包没有武道玄元丹！")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, selfId)
		end
	end	
	
	if key == 999 then
		local playerMoney = GetMoney(sceneId, selfId) + GetMoneyJZ(sceneId, selfId)  
		if playerMoney < x000044_g_clearCdCost then
			x000044_MsgBox(sceneId, selfId, targetId, "#R金币不足5金币！无法清除技能CD")
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId, "#Y确认花费5金币清除所有技能CD吗？")
			AddNumText(sceneId, x000044_g_scriptId, "#G确认清除", 6, x000044_g_confirmClearKey)
			AddNumText(sceneId, x000044_g_scriptId, "#R取消", 6, x000044_g_cancelClearKey)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	if GetNumText() == x000044_g_confirmClearKey then
		LuaFnCostMoneyWithPriority(sceneId, selfId, x000044_g_clearCdCost)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,1330,0)
		if LuaFnClearAllSkillCooldown then
			LuaFnClearAllSkillCooldown(sceneId, selfId)
		elseif LuaFnResetAllSkillCD then
			LuaFnResetAllSkillCD(sceneId, selfId)
		end
		x000044_MsgBox(sceneId, selfId, targetId, "#G您成功消耗5金币，所有技能CD已清除！")
		return
	end
	if GetNumText() == x000044_g_cancelClearKey then
		x000044_MsgBox(sceneId, selfId, targetId, "#W已取消清除技能CD操作。")
		return
	end	

	if key == 11111 then
		if not sceneId or not selfId then
			x000044_MsgBox(sceneId, selfId, targetId, "#R操作失败：参数异常！")
			return
		end
		MissionCom(sceneId,selfId, 2002)
		MissionCom(sceneId,selfId, 2003)
		MissionCom(sceneId,selfId, 2004)
		MissionCom(sceneId,selfId, 2005)
		MissionCom(sceneId,selfId, 2006)
		MissionCom(sceneId,selfId, 2162)
		MissionCom(sceneId,selfId, 2066)
		MissionCom(sceneId,selfId, 2065)	
		MissionCom(sceneId,selfId, 2000)
		MissionCom(sceneId,selfId, 2001)
		MissionCom(sceneId,selfId, 2014)
		MissionCom(sceneId,selfId, 2024)
		MissionCom(sceneId,selfId, 2025)
		MissionCom(sceneId,selfId, 2026)
		MissionCom(sceneId,selfId, 2027)
		MissionCom(sceneId,selfId, 2030)
		MissionCom(sceneId,selfId, 2031)
		MissionCom(sceneId,selfId, 2032)
		MissionCom(sceneId,selfId, 2033)
		MissionCom(sceneId,selfId, 2034)
		MissionCom(sceneId,selfId, 2035)
		MissionCom(sceneId,selfId, 2036)
		MissionCom(sceneId,selfId, 2037)
		MissionCom(sceneId,selfId, 2021)
		MissionCom(sceneId,selfId, 2022)
		MissionCom(sceneId,selfId, 2023)
		MissionCom(sceneId,selfId, 2079)
		MissionCom(sceneId,selfId, 2080)
		MissionCom(sceneId,selfId, 2210)
		MissionCom(sceneId,selfId, 2211)   
		x000044_MsgBox(sceneId, selfId, targetId, "#G已完成所有引导任务！")
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)	
		return
	end	
	if key == 888 then
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, 1)
		UICommand_AddString(sceneId, "123456")
		UICommand_AddString(sceneId, "123486")
		UICommand_AddString(sceneId, "123456")
		EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, 20170503)
		return
	end	
	if key == 889 then
		-- BeginUICommand(sceneId)
		-- UICommand_AddInt(sceneId, 1)
		-- UICommand_AddString(sceneId, "123456")
		-- UICommand_AddString(sceneId, "123486")
		-- UICommand_AddString(sceneId, "123456")
		-- EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, 20240417)
		-- CallScriptFunction(899097, "GetItemHCJ",sceneId,selfId)
		return
	end		
if GetNumText() == 11001 then
				BeginEvent( sceneId )
					AddText( sceneId, "    这里是我的神秘档口，少侠交了大米，那自然是要服务到位！" )
					AddNumText( sceneId, x000044_g_scriptId, "飞花阁-只需要一个材料兑换", 14,10000)
					AddNumText( sceneId, x000044_g_scriptId, "领取新坐骑", 14,10001)
					AddNumText( sceneId, x000044_g_scriptId, "领取打造相关材料", 14,10002)
					AddNumText( sceneId, x000044_g_scriptId, "领取武魂残篇礼盒", 14,10003)
					AddNumText( sceneId, x000044_g_scriptId, "领取兽魂及武道材料", 14,10009)
					AddNumText( sceneId, x000044_g_scriptId, "领取高级兽魂材料", 14,10010)
					AddNumText( sceneId, x000044_g_scriptId, "领取武魂技能书相关材料", 14,10012)
					AddNumText( sceneId, x000044_g_scriptId, "领取暗器冰魄神针", 14,10013)
					AddNumText( sceneId, x000044_g_scriptId, "领取雕纹相关材料", 14,10014)
					AddNumText( sceneId, x000044_g_scriptId, "领取长春玉", 14,10015)
					AddNumText( sceneId, x000044_g_scriptId, "领取七情刃礼盒", 14,10016)
					AddNumText( sceneId, x000044_g_scriptId, "领取雕纹精绘相关材料", 14,10017)
					AddNumText( sceneId, x000044_g_scriptId, "领取经验500W", 14,10006)
					AddNumText( sceneId, x000044_g_scriptId, "升级至102级", 14,10011)
					AddNumText( sceneId, x000044_g_scriptId, "领取绑定元宝", 14,10004)
				EndEvent( sceneId )
				DispatchEventList( sceneId, selfId, targetId )
			elseif GetNumText() == 10000 then
				 BeginAddItem(sceneId)
					 AddItem( sceneId, 38500031, 10 )
					 AddItem( sceneId, 38500032, 10 )
					 AddItem( sceneId, 38500030, 10 )
					 AddItem( sceneId, 38500037, 10 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
		         x000044_NotifyFailTips( sceneId, selfId, "领取飞花阁兑换材料成功" )
			elseif GetNumText() == 10001 then
				 BeginAddItem(sceneId)
					 AddItem( sceneId, 10147418, 1 )
					 AddItem( sceneId, 10147619, 1 )
					 AddItem( sceneId, 10147635, 1 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
		         x000044_NotifyFailTips( sceneId, selfId, "领取新坐骑成功" )				 
			elseif GetNumText() == 10002 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 30900057, 10 )
					AddItem( sceneId, 20502009, 250 )
					AddItem( sceneId, 30700232, 250 )
					AddItem( sceneId, 30503118, 250 )
					AddItem( sceneId, 38003055, 50 )
					AddItem( sceneId, 20501004, 200 )
					AddItem( sceneId, 20502004, 200 )
					AddItem( sceneId, 30505906, 1 )
					AddItem (sceneId,30505908,250)
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
				 x000044_NotifyFailTips( sceneId, selfId, "成功领取打造相关材料。")
			elseif GetNumText() == 10003 then
				 BeginAddItem(sceneId)
					 AddItem( sceneId, 38002229, 250 )
					 AddItem( sceneId, 38002231, 250 )
					 AddItem( sceneId, 10156003, 5)
					 AddItem( sceneId, 10156004, 5)
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				 AddItemListToHuman(sceneId,selfId)
				 x000044_NotifyFailTips( sceneId, selfId, "成功领取幻魂残篇礼盒。")
			elseif GetNumText() == 10009 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 38002397, 250 )
					AddItem( sceneId, 38002498, 250 )
					AddItem( sceneId, 38002499, 250 )
					AddItem( sceneId, 38002732, 40 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取兽魂及武道材料")
			elseif GetNumText() == 10010 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 38002540, 250 )
					AddItem( sceneId, 38002541, 250 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "领取成功")	
			elseif GetNumText() == 10012 then
				 BeginAddItem(sceneId)
					AddItem( sceneId, 30700226, 1 )
					AddItem( sceneId, 30700227, 1 )
					AddItem( sceneId, 30700228, 1 )
					AddItem( sceneId, 30700229, 1 )
					AddItem( sceneId, 30700222, 1 )
					AddItem( sceneId, 30700223, 1 )
					AddItem( sceneId, 30700224, 1 )
					AddItem( sceneId, 30700225, 1 )
					AddItem( sceneId, 30700214, 1 )
					AddItem( sceneId, 30700215, 1 )
					AddItem( sceneId, 30700216, 1 )
					AddItem( sceneId, 30700217, 1 )
					AddItem( sceneId, 30700218, 1 )
					AddItem( sceneId, 30700219, 1 )
					AddItem( sceneId, 30700220, 1 )
					AddItem( sceneId, 30700221, 1 )
				 if EndAddItem(sceneId,selfId) <= 0 then
					 return
				 end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取武魂技能书相关材料。")	
			elseif GetNumText() == 10013 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 10155002, 1 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取暗器冰魄神针。")
			elseif GetNumText() == 10014 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 30120028, 1 )
					AddItem( sceneId, 30120023, 1 )
					AddItem( sceneId, 30120042, 1 )
					AddItem( sceneId, 30120041, 1 )
					AddItem( sceneId, 30120010, 1 )
					AddItem( sceneId, 30120008, 1 )
					AddItem( sceneId, 30120050, 1 )
					AddItem( sceneId, 30120014, 1 )
					AddItem( sceneId, 30120015, 1 )
					AddItem( sceneId, 30120016, 1 )
					AddItem( sceneId, 30120017, 1 )
					AddItem( sceneId, 30120035, 1 )
					AddItem( sceneId, 30120036, 1 )
					AddItem( sceneId, 30120037, 1 )
					AddItem( sceneId, 30120038, 1 )
					AddItem( sceneId, 30120066, 1 )
					AddItem( sceneId, 30120067, 1 )
					AddItem( sceneId, 30120068, 1 )
					AddItem( sceneId, 30120069, 1 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取雕纹相关材料。")
			elseif GetNumText() == 10015 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 20600000, 10 )
					AddItem( sceneId, 20600001, 10 )
					AddItem( sceneId, 20600002, 10 )
					AddItem( sceneId, 20600003, 10 )
					AddItem( sceneId, 20600004, 10 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取长春玉。")
			elseif GetNumText() == 10016 then
				BeginAddItem(sceneId)
					AddItem( sceneId, 38002986, 10 )
					AddItem( sceneId, 38002969, 10 )
					AddItem( sceneId, 38002970, 10 )
					AddItem( sceneId, 38002971, 10 )
					AddItem( sceneId, 20900001, 100 )
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取七情刃礼盒。")	
			elseif GetNumText() == 10017 then
				BeginAddItem(sceneId)
					AddItem( sceneId,30900200,1)
					AddItem( sceneId,30900201,1)
					AddItem( sceneId,30900202,1)
					AddItem( sceneId,30900203,1)
					AddItem( sceneId,30900204,1)
					AddItem( sceneId,30900205,1)
					AddItem( sceneId,30900206,1)
					AddItem( sceneId,30900207,1)
					AddItem( sceneId,30900208,1)
					AddItem( sceneId,30900209,1)
					AddItem( sceneId,30900210,1)
					AddItem( sceneId,30900211,1)
					AddItem( sceneId,30900212,1)
					AddItem( sceneId,30900213,1)
					AddItem( sceneId,38003161,5)
				if EndAddItem(sceneId,selfId) <= 0 then
					return
				end
				AddItemListToHuman(sceneId,selfId)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取雕纹精绘相关材料。")	
				
			elseif GetNumText() == 10004 then
				local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
				-- if nExchPoint < x000044_g_TestNeedPoint then
					-- x000044_NotifyFailBox(sceneId,selfId,targetId,"尚未达到预充最低领取要求。")
					-- return
				-- end
				-- if YuanBao(sceneId,selfId,targetId,3,0) + 1000000 > 2000000000 then
					-- x000044_NotifyFailBox(sceneId,selfId,targetId,"所携带元宝过多，请消耗一些再来领取。")
					-- return
				-- end
				if BindYuanBao(sceneId,selfId,targetId,3,0) + 1000000 > 2000000000 then
					x000044_NotifyFailBox(sceneId,selfId,targetId,"所携带绑定元宝过多，请消耗一些再来领取。")
					return
				end
				--YuanBao(sceneId,selfId,targetId,1,1000000)
				BindYuanBao(sceneId,selfId,targetId,1,1000000)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取100W元宝。")
				return
			elseif GetNumText() == 10006 then
				AddExp(sceneId,selfId,5000000)
				x000044_NotifyFailTips( sceneId, selfId, "成功领取500W经验")
			elseif GetNumText() == 10011 then
				if GetLevel(sceneId,selfId) < 1 then
					x000044_NotifyFailTips( sceneId, selfId, "等级小于10级无法直升102级" )
					return
				end
				if GetMenPai(sceneId,selfId) == MP_WUMENPAI then
					x000044_NotifyFailTips( sceneId, selfId, "请你至少加入一个门派后再来直升102级" )
					return
				end
				if GetLevel(sceneId,selfId) >= 102 then
					x000044_NotifyFailTips( sceneId, selfId, "你的等级已经不需要直升了，请回吧" )
					return
				end
				LuaFnHumanLevelUpTo(sceneId,selfId,102)
			end	
	if key == 1000 then	--不愿再治疗
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
	if key == 1001 then	--确认要治疗
		-- 调用“江湖游医”脚本中计算金钱的函数
		gld = CallScriptFunction( x000044_g_healScriptId, "CalcMoney_hpmp",sceneId, selfId, targetId )* 0.1

		-- 得到交子和金钱数目
		local nMoneyJZ = GetMoneyJZ ( sceneId, selfId )
		local nMoney = GetMoney ( sceneId, selfId )
		
		--检查玩家是否有足够的现金
		if (nMoneyJZ + nMoney >= gld) then
			--扣钱
			LuaFnCostMoneyWithPriority (sceneId, selfId, gld)
			-- 调用“江湖游医”脚本
			CallScriptFunction( x000044_g_healScriptId, "Restore_hpmp",sceneId, selfId, targetId )
			RestoreStrikePoint( sceneId, selfId )			
			return
		
		else
			BeginEvent( sceneId )
				AddText( sceneId, "  你的金钱不足！" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
		end
	end
	
	--加血
	if key == 0 then
		if GetHp( sceneId, selfId ) == GetMaxHp( sceneId, selfId ) and
			 GetRage( sceneId, selfId ) == GetMaxRage( sceneId, selfId ) and
			 GetMp( sceneId, selfId ) == GetMaxMp( sceneId, selfId ) and
			 IsStrikePointFull( sceneId, selfId ) == 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "  你现在很健康，不需要治疗！" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			
			--取消指定玩家身上的所有敌对可驱散驻留效果
			LuaFnDispelAllHostileImpacts( sceneId, selfId )
			return
		end
	
		if gld <= 0 then
			-- 调用“江湖游医”脚本
			CallScriptFunction( x000044_g_healScriptId, "Restore_hpmp",sceneId, selfId, targetId )
			RestoreStrikePoint( sceneId, selfId )
		else
			BeginEvent( sceneId )
				AddText( sceneId, "  你可以花费#G#{_EXCHG"..gld.."}#W，来恢复气血和怒气，确定要治疗吗？" )
				AddNumText( sceneId, x000044_g_scriptId, "是", -1, 1001 )
				AddNumText( sceneId, x000044_g_scriptId, "否", -1, 1000 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif key == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{LTJS_090910_01}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	else
		for i, findId in x000044_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText() )
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000044_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000044_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000044_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000044_g_eventList do
		if missionScriptId == findId then
			x000044_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000044_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000044_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000044_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000044_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000044_OnDie( sceneId, selfId, killerId )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x000044_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x000044_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--客户端回调传送事件完成
--**********************************
function x000044_OnCloseTransSceneEffect( sceneId, selfId )
	local nCurSel = GetMissionCacheData(sceneId,selfId,0)
	if nCurSel == 101 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_JINGHU_HUANJING, 272,47, 10 )
	elseif nCurSel == 102 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_JINGHU_HUANJING, 41,276, 10 )
	elseif nCurSel == 103 then
		CallScriptFunction(400900, "TransferFunc", sceneId, selfId, SCENE_JINGHU_HUANJING, 39,234, 10 )			
	end
	SetMissionCacheData(sceneId,selfId,0,0)
end