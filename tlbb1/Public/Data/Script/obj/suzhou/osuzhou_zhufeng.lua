--苏州NPC
--朱锋
--普通

x001069_g_ScriptId	= 001069

--操作集
x001069_g_Key				=
{
	["inf"]	= 1000,	--制造介绍
	["ln"]	= 1,		--我要学习精炼配方 - 精炼 - 铸造
	["zh"]	= 2,		--我要学习精制配方 - 精制 - 缝纫
	["gn"]	= 3,		--我要学习精工配方 - 精工 - 工艺
	["sh"]	= 4,		--精工配方商店
	["jhf_dh"]	= 5,	--兑换解魂符
	["jhf_jb"]	= 6,	--手工装备解绑
	["jhf_dhok"]= 7,	--确认兑换
	["inf_jhf"]	= 1001,	--关于解魂符
}

--商店编号
x001069_g_shoptableindex=196
--解绑消耗金钱
x001069_g_UnBindCostMoney = 300000
--解魂符
x001069_g_UnBindMaterial = 38002867
--**********************************
--事件交互入口
--**********************************
function x001069_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent( sceneId )
		AddText( sceneId, "    十年磨一剑，我朱锋做出来的东西是天下最好的！" )
		if GetLevel( sceneId, selfId ) >= 10 then
			AddNumText( sceneId, x001069_g_ScriptId, "我要学习精炼（锻造）配方", 2, x001069_g_Key["ln"] )
			AddNumText( sceneId, x001069_g_ScriptId, "我要学习精制（缝纫）配方", 2, x001069_g_Key["zh"] )
			AddNumText( sceneId, x001069_g_ScriptId, "我要学习精工（工艺）配方", 2, x001069_g_Key["gn"] )
			AddNumText( sceneId, x001069_g_ScriptId, "#{ZBJB_20230526_4}", 6, x001069_g_Key["jhf_dh"] )
			AddNumText( sceneId, x001069_g_ScriptId, "#{ZBJB_20230526_5}", 6, x001069_g_Key["jhf_jb"] )
			AddNumText( sceneId, x001069_g_ScriptId, "购买精工配方", 7, x001069_g_Key["sh"])
		end
		AddNumText( sceneId, x001069_g_ScriptId, "制造介绍", 11, x001069_g_Key["inf"] )
		AddNumText( sceneId, x001069_g_ScriptId, "#{ZBJB_20230526_6}", 11, x001069_g_Key["inf_jhf"] )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	
end

--**********************************
--事件列表选中一项
--**********************************
function x001069_OnEventRequest( sceneId, selfId, targetId, eventId )

	local	key	= GetNumText()

	if key == x001069_g_Key["inf"] then
		x001069_MsgBox( sceneId, selfId, targetId, "#{INTRO_ZHIZAO}" )
	elseif key == x001069_g_Key["inf_jhf"] then
		x001069_MsgBox( sceneId, selfId, targetId, "#{ZBJB_20230526_7}" )
	elseif key == x001069_g_Key["ln"] then
		if QueryHumanAbilityLevel( sceneId, selfId, 46 ) ~= 1 then
			SetHumanAbilityLevel( sceneId, selfId, 46, 1 )
		end
		for i = 644, 703 do
			SetPrescription( sceneId, selfId, i, 1 )
		end
		x001069_MsgBox( sceneId, selfId, targetId, "    恭喜你已经学会了所有的精炼配方。" )

	elseif key == x001069_g_Key["zh"] then
		if QueryHumanAbilityLevel( sceneId, selfId, 47 ) ~= 1 then
			SetHumanAbilityLevel( sceneId, selfId, 47, 1 )
		end
		for i = 704, 773 do
			SetPrescription( sceneId, selfId, i, 1 )
		end
		for i = 804, 883 do
			SetPrescription( sceneId, selfId, i, 1 )
		end
		x001069_MsgBox( sceneId, selfId, targetId, "    恭喜你已经学会了所有的精制配方。" )
	
	elseif key == x001069_g_Key["gn"] then
		if QueryHumanAbilityLevel( sceneId, selfId, 48 ) ~= 1 then
			SetHumanAbilityLevel( sceneId, selfId, 48, 1 )
		end
		for i = 774, 803 do
			SetPrescription( sceneId, selfId, i, 1 )
		end
		
		for i = 1064, 1075 do
			SetPrescription( sceneId, selfId, i, 1 )
		end
 		
		x001069_MsgBox( sceneId, selfId, targetId, "    恭喜你已经学会了所有的精工配方。" )
	elseif key == x001069_g_Key["jhf_dh"] then
		BeginEvent( sceneId )
			AddText( sceneId, ScriptGlobal_Format("#{ZBJB_20230526_8}",GetMissionData(sceneId,selfId,MD_EQUIP_MAKE_NEW_UNBIND_POINT)) )
			AddNumText( sceneId, x001069_g_ScriptId, "#{ZBJB_20230526_9}", 6, x001069_g_Key["jhf_dhok"] )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif key == x001069_g_Key["jhf_dhok"] then
		local nCurUnBindPoint = GetMissionData(sceneId,selfId,MD_EQUIP_MAKE_NEW_UNBIND_POINT)
		if nCurUnBindPoint < 1500 then
			x001069_NotifyTip( sceneId,selfId,"#{ZBJB_20230526_10}" )
			return
		end
		if LuaFnGetPropertyBagSpace(sceneId, selfId) < 1 then
			x001069_NotifyTip( sceneId,selfId,"#{ZBJB_20230526_11}" )
			return
		end
		SetMissionData(sceneId,selfId,MD_EQUIP_MAKE_NEW_UNBIND_POINT,nCurUnBindPoint - 1500)
		LuaFnTryRecieveSingleItem(sceneId,selfId,x001069_g_UnBindMaterial,1,1)
		
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		x001069_NotifyTip( sceneId,selfId,"#{ZBJB_20230526_12}" )
		
		--关闭对话框
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
	elseif key == x001069_g_Key["jhf_jb"] then	
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 998001069 )
	elseif key == x001069_g_Key["sh"] then
		DispatchShopItem( sceneId, selfId, targetId, x001069_g_shoptableindex )
	end

end
--**********************************
--解绑操作
--**********************************
function x001069_UnBindEquip( sceneId,selfId,nBagPos )
	--ZBJB_20230526_16	#H仅可放入绑定且未加锁、未镶嵌宝石、未蚀刻雕纹、未强化、可修理次数上限大于1等级40级以上的手工装备。	
	if GetLevel(sceneId,selfId) < 10 then
		x001069_NotifyTip( sceneId,selfId,"#{ZBJB_20230526_26}" )
		return
	end
	local nMaterialPos = LuaFnGetAvailableItemFirstPos(sceneId,selfId,x001069_g_UnBindMaterial)
	if nMaterialPos < 0 then
		x001069_NotifyTip( sceneId,selfId,"#{ZBJB_20230526_28}" )
		return
	end
	--检查是否加锁
	if LuaFnIsItemLocked(sceneId, selfId, nBagPos) ~= 0 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}" )
		return	
	end
	if LuaFnIsItemAvailable(sceneId,selfId,nBagPos) ~= 1 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}" )
		return	
	end
	--未镶嵌宝石
	if GetGemEmbededCount( sceneId, selfId, nBagPos ) > 0 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}" )
		return	
	end
	--未蚀刻雕纹
	local nDWId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,nBagPos);
	if nDWId > 0 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}")
		return
	end
	if LuaFnGetEquipEnhanceLevel(sceneId,selfId,nBagPos) > 0 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}")
		return
	end
	local nCurFaileTimes = LuaFnGetEquipFaileTimes(sceneId,selfId,nBagPos)
	if nCurFaileTimes >= 3 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}")
		return
	end
	if GetBagItemLevel( sceneId, selfId, nBagPos ) < 40 then
		x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_16}")
		return
	end
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < x001069_g_UnBindCostMoney then
		x001069_NotifyTip( sceneId, selfId, "#{ZBJB_20230526_34}" )
		return
	end
	--扣除材料
	LuaFnDelAvailableItem(sceneId,selfId,x001069_g_UnBindMaterial,1)
	--扣钱
	LuaFnCostMoneyWithPriority( sceneId, selfId, x001069_g_UnBindCostMoney)
	
	LuaFnItemUnBind(sceneId,selfId,nBagPos)
	--增加一次修理失败次数
	LuaFnSetEquipFaileTimes(sceneId,selfId,nBagPos,nCurFaileTimes + 1)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
	--ZBJB_20230526_30	#{_INFOUSR%s0}使用#{_ITEMINFO%s1}，将#{_INFOMSG%s2}的绑定状态移除，又一件神器重出江湖！	
	local strMaterialEquip = GetBagItemTransfer(sceneId,selfId,nBagPos);
	AddGlobalCountNews(sceneId,ScriptGlobal_Format("#{ZBJB_20230526_30}",GetName(sceneId,selfId),tostring(x001069_g_UnBindMaterial),strMaterialEquip));
		
	x001069_NotifyTip( sceneId, selfId,"#{ZBJB_20230526_29}")
	--关闭客户端UI
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 998001070 )
end

--**********************************
--提示信息
--**********************************
function x001069_NotifyTip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--Message Box
--**********************************
function x001069_MsgBox( sceneId, selfId, targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
