-- 珍兽技能升级

-- 脚本号
x311112_g_ScriptId = 311112;
x311112_g_NumText_Main = 1					-- 接任务的选项
x311112_g_NumText_NewPetMedicineHC = 98
x311112_g_NumText_NewPetMedicineDesc = 99

--灵兽丹合成设计
x311112_g_PetMedchine_comp = {
	[100] = {
		{show = "#{WPDJ_140912_60}",command = 110,needitem = 30503034,neednum = 5,createitem = 30503035},
		{show = "#{WPDJ_140912_61}",command = 111,needitem = 30503035,neednum = 5,createitem = 30503036},
		{show = "#{WPDJ_140912_62}",command = 112,needitem = 30503036,neednum = 5,createitem = 30503037},
	},
	[101] = {
		{show = "#{WPDJ_140912_64}",command = 120,needitem = 30503043,neednum = 5,createitem = 30503044},
		{show = "#{WPDJ_140912_65}",command = 121,needitem = 30503044,neednum = 5,createitem = 30503045},
		{show = "#{WPDJ_140912_66}",command = 122,needitem = 30503045,neednum = 5,createitem = 30503046},
	},
	[102] = {
		{show = "#{WPDJ_140912_68}",command = 130,needitem = 30503052,neednum = 5,createitem = 30503053},
		{show = "#{WPDJ_140912_69}",command = 131,needitem = 30503053,neednum = 5,createitem = 30503054},
		{show = "#{WPDJ_140912_70}",command = 132,needitem = 30503054,neednum = 5,createitem = 30503055},
	},
	[103] = {
		{show = "#{WPDJ_140912_72}",command = 140,needitem = 30503061,neednum = 5,createitem = 30503062},
		{show = "#{WPDJ_140912_73}",command = 141,needitem = 30503062,neednum = 5,createitem = 30503063},
		{show = "#{WPDJ_140912_74}",command = 142,needitem = 30503063,neednum = 5,createitem = 30503064},
	}
}

--**********************************
-- 任务入口函数
--**********************************
function x311112_OnDefaultEvent(sceneId, selfId, targetId)
	local numText = GetNumText()
	
	if GetName(sceneId,targetId) == "云渺渺" then
		if numText == x311112_g_NumText_Main then
			--x311112_NotifyFailTips(sceneId, selfId, "good...")
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 19823 )	--调用珍兽技能升级界面
		end
	end
	if GetName(sceneId,targetId) == "云涵儿" or GetName(sceneId,targetId) == "云思儿" then
		if numText == x311112_g_NumText_NewPetMedicineDesc then
			BeginEvent( sceneId )
			AddText( sceneId, "#{JNHC_81015_12}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if numText == x311112_g_NumText_NewPetMedicineHC then
			--新的灵兽丹合成界面
			BeginEvent( sceneId )
				AddText( sceneId, "#{WPDJ_140912_58}" )
				AddNumText(sceneId,x311112_g_ScriptId,"#{WPDJ_140912_59}",6,100)
				AddNumText(sceneId,x311112_g_ScriptId,"#{WPDJ_140912_63}",6,101)
				AddNumText(sceneId,x311112_g_ScriptId,"#{WPDJ_140912_67}",6,102)
				AddNumText(sceneId,x311112_g_ScriptId,"#{WPDJ_140912_71}",6,103)
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
		if numText >= 100 and numText <= 103 then
			--灵兽丹合成设计
			local tShowGroup = x311112_g_PetMedchine_comp[numText]
			BeginEvent(sceneId)
				for i = 1,3 do
					AddNumText(sceneId,x311112_g_ScriptId,tShowGroup[i].show,6,tShowGroup[i].command)
				end
				AddNumText(sceneId,x311112_g_ScriptId,"返回",0,4)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif numText >= 110 and numText <= 142 then
			local tShowGroup = nil
			local nGroupIndex = 100 + (mod(floor(numText / 10),10) - 1)
			for i = 1,3 do
				if x311112_g_PetMedchine_comp[nGroupIndex][i].command == numText then
					tShowGroup = x311112_g_PetMedchine_comp[nGroupIndex][i];
					break
				end
			end
			--提交的参数非法
			if tShowGroup == nil then
				return
			end
			if LuaFnGetAvailableItemCount(sceneId,selfId,tShowGroup.needitem) < tShowGroup.neednum then
				--WPDJ_140912_9	#H对不起，您身上没有足够的%s0，或%s1已加锁。
				local szItemName = GetItemName(sceneId,tShowGroup.needitem)
				x311112_NotifyFailTips( sceneId, selfId, ScriptGlobal_Format("#{WPDJ_140912_9}", szItemName,szItemName) )
				return
			end
			--查找有无绑定物品
			if GetBagPosByItemSnAvailableBind(sceneId, selfId, tShowGroup.needitem, 1 ) ~= -1 then
				BeginUICommand( sceneId )
					UICommand_AddInt( sceneId, 1083 )
					UICommand_AddInt( sceneId, targetId )
					UICommand_AddString(sceneId,"PetMedicineHC")
					--参数
					UICommand_AddInt( sceneId, numText )
					UICommand_AddString(sceneId,"#{WPDJ_140912_8}")
					
				EndUICommand( sceneId )
				DispatchUICommand( sceneId, selfId, 255 )	--Server控制弹出的提示框的扩展版 --如果有第二个整形参数，表明有需要关心的NPC
				return
			end
			--合成开始
			local needBind = 0
			local nDelRet = LuaFnDelAvailableItemRetHaveBind( sceneId, selfId, tShowGroup.needitem, tShowGroup.neednum )
			if nDelRet == 2 then
				needBind = 1
			end
			--直接生成一个的物品
			local BagIndex = TryRecieveItem( sceneId, selfId, tShowGroup.createitem, QUALITY_MUST_BE_CHANGE )
			if BagIndex ~= -1 then
				local szItemName = GetItemName(sceneId,tShowGroup.createitem)
				x311112_NotifyFailTips( sceneId, selfId, ScriptGlobal_Format("#{WPDJ_140912_7}", tostring(1),szItemName) )
				AuditPetSkillLevelUpAndCompound(sceneId, selfId, 2, tShowGroup.createitem)
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
				LuaFnSendAbilitySuccessMsg( sceneId, selfId, -1, -1, tShowGroup.createitem )		-- 提示生成物
			end
		end
	end
end

--**********************************
-- 列举事件
--**********************************
function x311112_OnEnumerate(sceneId, selfId, targetId)
	if GetName(sceneId,targetId) == "云涵儿" or GetName(sceneId,targetId) == "云思儿" then
		AddNumText(sceneId, x311112_g_ScriptId, "灵兽丹合成" , 6, x311112_g_NumText_NewPetMedicineHC);
		AddNumText(sceneId, x311112_g_ScriptId, "灵兽丹合成介绍" , 11, x311112_g_NumText_NewPetMedicineDesc);
	end
	if GetName(sceneId,targetId) == "云渺渺" then
		AddNumText(sceneId, x311112_g_ScriptId, "珍兽技能升级" , 6, x311112_g_NumText_Main);
	end
end

--**********************************
--珍兽升超级技能
--**********************************
function x311112_PetSkillLevelup( sceneId, selfId, petHid, petLid, skillindex, ItemIndexInBag )
	local checkAvailable = LuaFnIsPetAvailableByGUIDNoPW(sceneId, selfId, petHid, petLid);
	if checkAvailable and checkAvailable == 1 then
		local SkillID,SkillLevelUpID,ConsumeGoodsID,ConsumeMoney,IsBroadCast = GetPetSkillLevelupTbl(sceneId, selfId, petHid, petLid, skillindex)
		if not SkillID or not SkillLevelUpID or not ConsumeGoodsID or not ConsumeMoney or not IsBroadCast or SkillID == -1 then
			x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_03}")
			return
		end
		
		local itemid = LuaFnGetItemTableIndexByIndex(sceneId, selfId, ItemIndexInBag) --获取物品ID
		local ItemInfo = GetBagItemTransfer(sceneId, selfId, ItemIndexInBag)
		if itemid ~= ConsumeGoodsID then --如果ConsumeGoodsID为0说明可能是策划忘记配消耗物品ID了，也不能通过
			x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_04}")
			return
		end
		
		local havemoney = GetMoney(sceneId, selfId)
		local haveJiaoZi = GetMoneyJZ(sceneId, selfId)
		if havemoney+haveJiaoZi < ConsumeMoney then
			x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_08}")
			return
		end
		
		--扣除金钱
		if ConsumeMoney > 0 then
			local jz, jb = LuaFnCostMoneyWithPriority(sceneId, selfId, ConsumeMoney)
			if jz == -1 then
				x311112_NotifyFailTips(sceneId, selfId, "扣除金钱失败！")
				return
			end
		end
		
		--消耗物品
		if LuaFnDelAvailableItem(sceneId,selfId,itemid,1) ~= 1 then--EraseItem(sceneId, selfId, ItemIndexInBag)
			x311112_NotifyFailTips(sceneId, selfId, "扣除物品失败！")
			return
		end
		
		LuaFnPetSkillUp(sceneId, selfId, petHid, petLid, skillindex, SkillLevelUpID)
		x311112_NotifyFailTips(sceneId, selfId, "升级成功！")
		AuditPetSkillLevelUpAndCompound(sceneId, selfId, 1, ConsumeGoodsID)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		
		if IsBroadCast == 1 then
			local szPetTrans = GetPetTransString(sceneId, selfId, petHid, petLid)
			local message = format("#H#{_INFOUSR%s}#{J_09}#{_INFOMSG%s}#{J_10}#{_INFOMSG%s}#{J_11}#G%s#P！",LuaFnGetName(sceneId, selfId),szPetTrans,ItemInfo,GetSkillName(SkillLevelUpID))--[tx43999]
			BroadMsgByChatPipe(sceneId, selfId, message, 4);
		end
		
	else
		x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_05}")
	end
end

--**********************************
--灵兽丹合成功能
--**********************************
function x311112_PetMedicineHC( sceneId, selfId, ItemIndex1, ItemIndex2, ItemIndex3, ItemIndex4, ItemIndex5)
	if not ItemIndex1 or not ItemIndex2 or not ItemIndex3 or not ItemIndex4 or not ItemIndex5 then
		return
	end
	
	-- 不允许有重复的ItemIndex1出现 added by dun.liu 2009.2.5
	if ScriptGlobal_IsUniqueNumberTable({ItemIndex1, ItemIndex2, ItemIndex3, ItemIndex4, ItemIndex5}) == 0 then
		return
	end
	
	local itemindex = {}
	local itemid = LuaFnGetItemTableIndexByIndex(sceneId, selfId, ItemIndex1) --获取物品ID
	local afteritemID,money = GetPetMedicineHCTbl(sceneId, itemid)
	itemindex[1] = ItemIndex1
	itemindex[2] = ItemIndex2
	itemindex[3] = ItemIndex3
	itemindex[4] = ItemIndex4
	itemindex[5] = ItemIndex5
	--PrintStr(" itemid "..itemid.." afteritemID "..afteritemID.." money "..money)
	
	--表里面没有的就不是灵兽丹
	if not afteritemID or not money or afteritemID == -100 then
		x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_13}")
		return
	end
	
	--表里面有但是合成后ID是-1的表示暂不开放的，目前合成最高开放到2级合3级
	if afteritemID == -1 then
		x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_14}")
		return
	end
	
	--是否同种类型并且等级相同的灵兽丹
	for i = 2, 5 do
		if LuaFnGetItemTableIndexByIndex(sceneId, selfId, itemindex[i]) ~= itemid then
			x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_15}")
			return
		end
	end
	
	--是否金钱足够，为0说明是没有金钱要求
	local havemoney = GetMoney(sceneId, selfId)
	local haveJiaoZi = GetMoneyJZ(sceneId, selfId)
	if money > 0 and havemoney+haveJiaoZi < money then
		x311112_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_18}#{_EXCHG"..money.."}。")
		return
	end
	
	--扣除金钱，为0说明是没有金钱要求
	if money > 0 then
		local jz, jb = LuaFnCostMoneyWithPriority(sceneId, selfId, money)
		if jz == -1 then
			x311112_NotifyFailTips(sceneId, selfId, "扣除金钱失败！")
			return
		end
	end
	
	local needBind = 0
	--扣除物品
	for i = 1, 5 do
		if LuaFnGetItemBindStatus( sceneId, selfId, itemindex[i] ) == 1 then
			needBind = 1
		end
		--LuaFnItemBind( sceneId, selfId, itemindex[i] )
		if LuaFnEraseItem(sceneId, selfId, itemindex[i]) ~= 1 then
			x311112_NotifyFailTips(sceneId, selfId, "扣除物品失败！")
			return
		end
	end
	
	--给物品
	local BagIndex = TryRecieveItem( sceneId, selfId, afteritemID, QUALITY_MUST_BE_CHANGE )
	if BagIndex ~= -1 then
		if needBind == 1 then
			LuaFnItemBind( sceneId, selfId, BagIndex )
		end
		x311112_NotifyFailTips(sceneId, selfId, "合成成功！")
		AuditPetSkillLevelUpAndCompound(sceneId, selfId, 2, afteritemID)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
		LuaFnSendAbilitySuccessMsg( sceneId, selfId, -1, -1, afteritemID )		-- 提示生成物
	end
	
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x311112_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
