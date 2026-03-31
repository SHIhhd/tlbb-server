--洛阳NPC
--诸葛孔亮
--算命，以后可能成为循环任务

--脚本号
x000077_g_ScriptId = 000077

x000077_g_QianShiJinSheng = {250039,250040}
x000077_g_ControlScript = 050026
x000077_g_DeliveryScript = 006668
x000077_g_DeliveryList = {1018831}

--兑换列表
x000077_g_ChangeLst	=
{
	--玩家可得到的物品，兑换所需物品，兑换所需物品数量
	--4级
	[1]	= { id = 50401002, NeedItm = 30501249, NeedNum = 72 },
	[2]	= { id = 50401001, NeedItm = 30501258, NeedNum = 72 },
	[3]	= { id = 50403001, NeedItm = 30501267, NeedNum = 72 },
	[4]	= { id = 50414001, NeedItm = 30501276, NeedNum = 72 },
	[5]	= { id = 50402006, NeedItm = 30501294, NeedNum = 72 },
	[6]	= { id = 50402007, NeedItm = 30501285, NeedNum = 72 },
	[7]	= { id = 50402005, NeedItm = 30501303, NeedNum = 72 },
	[8]	= { id = 50402008, NeedItm = 30501312, NeedNum = 72 },
	--[9]	= { id = 50413006, NeedItm = 30504031, NeedNum = 72 },
	--[10] = { id = 50413004, NeedItm = 30504031, NeedNum = 72 },
	
	
	--5级
	[11]	= { id = 50501002, NeedItm = 30501250, NeedNum = 72 },
	[12]	= { id = 50501001, NeedItm = 30501259, NeedNum = 72 },
	[13]	= { id = 50503001, NeedItm = 30501268, NeedNum = 72 },
	[14]	= { id = 50514001, NeedItm = 30501277, NeedNum = 72 },
	[15]	= { id = 50502006, NeedItm = 30501295, NeedNum = 72 },
	[16]	= { id = 50502007, NeedItm = 30501286, NeedNum = 72 },
	[17]	= { id = 50502005, NeedItm = 30501304, NeedNum = 72 },
	[18]	= { id = 50502008, NeedItm = 30501313, NeedNum = 72 },
	--[19]	= { id = 50513006, NeedItm = 30504032, NeedNum = 72 },
	--[20]	= { id = 50513004, NeedItm = 30504032, NeedNum = 72 },
	
	--6级
	[21]	= { id = 50601002, NeedItm = 30501251, NeedNum = 72 },
	[22]	= { id = 50601001, NeedItm = 30501260, NeedNum = 72 },
	[23]	= { id = 50603001, NeedItm = 30501269, NeedNum = 72 },
	[24]	= { id = 50614001, NeedItm = 30501278, NeedNum = 72 },
	[25]	= { id = 50602006, NeedItm = 30501296, NeedNum = 72 },
	[26]	= { id = 50602007, NeedItm = 30501287, NeedNum = 72 },
	[27]	= { id = 50602005, NeedItm = 30501305, NeedNum = 72 },
	[28]	= { id = 50602008, NeedItm = 30501314, NeedNum = 72 },
	--[29]	= { id = 50613006, NeedItm = 30504033, NeedNum = 72 },
	--[30]	= { id = 50613004, NeedItm = 30504033, NeedNum = 72 },
	
	--7级
	[31]	= { id = 50701002, NeedItm = 30501252, NeedNum = 72 },
	[32]	= { id = 50701001, NeedItm = 30501261, NeedNum = 72 },
	[33]	= { id = 50703001, NeedItm = 30501270, NeedNum = 72 },
	[34]	= { id = 50714001, NeedItm = 30501279, NeedNum = 72 },
	[35]	= { id = 50702006, NeedItm = 30501297, NeedNum = 72 },
	[36]	= { id = 50702007, NeedItm = 30501288, NeedNum = 72 },
	[37]	= { id = 50702005, NeedItm = 30501306, NeedNum = 72 },
	[38]	= { id = 50702008, NeedItm = 30501315, NeedNum = 72 },
	--[39]	= { id = 50713006, NeedItm = 30504034, NeedNum = 72 },
	--[40]	= { id = 50713004, NeedItm = 30504034, NeedNum = 72 },
}

--**********************************
--事件交互入口
--**********************************
function x000077_OnDefaultEvent( sceneId, selfId,targetId )

	BeginEvent(sceneId)
		AddNumText( sceneId, x000077_g_ControlScript, "用宝石碎片兑换4级宝石", 6, 100 )
		AddNumText( sceneId, x000077_g_ControlScript, "用宝石碎片兑换5级宝石", 6, 200 )
		AddNumText( sceneId, x000077_g_ControlScript, "用宝石碎片兑换6级宝石", 6, 300 )
		AddNumText( sceneId, x000077_g_ControlScript, "用宝石碎片兑换7级宝石", 6, 400 )
		AddNumText( sceneId, x000077_g_ControlScript, "#{CJG_090413_33}", 6, 500 )
		AddNumText( sceneId, x000077_g_ControlScript, "#{QSJS_090508_002}", 6, 600 )
		AddNumText( sceneId, x000077_g_ControlScript, "#{QSJS_090508_003}", 11, 9999 )
	  if CallScriptFunction( x000077_g_ControlScript, "CheckRightTime", sceneId) == 1 then
			AddText(sceneId, "#{CHRISTMAS_LUOYANG_HTJS_1}")
			CallScriptFunction( x000077_g_ControlScript, "OnEnumerate",sceneId, selfId, targetId )
		else
			local	i=random(0,1)
		  if	i<=0	 then
			  AddText(sceneId,"#{OBJ_luoyang_0023}")
		  else
			  AddText(sceneId,"多么大富大贵的宝相啊！你这么有福的人不介意付十两卦金吧？")
		  end
		end		
	for i,Deliveryidx in x000077_g_DeliveryList do
		CallScriptFunction( x000077_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i,eventId in x000077_g_QianShiJinSheng do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000077_OnEventRequest( sceneId, selfId, targetId, eventId )

	local key = GetNumText();


	if 100 == key or 200 == key or 300 == key or 400 == key then
		BeginEvent(sceneId)
		AddText( sceneId, "#{CHANGE_BAOSHI_KONGMIMG}" )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换虎眼石", 6, 1 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换猫眼石", 6, 2 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换紫玉", 6, 3 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换祖母绿", 6, 4 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换纯净蓝晶石", 6, 5 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换纯净红晶石", 6, 6 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换纯净黄晶石", 6, 7 + key )
		AddNumText( sceneId, x000077_g_ControlScript, "兑换纯净绿晶石", 6, 8 + key )
		--AddNumText( sceneId, x000077_g_ControlScript, "兑换血精石", 6, 9 + key )
		--AddNumText( sceneId, x000077_g_ControlScript, "兑换红宝石", 6, 10 + key )	
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if key >= 100 and key < 500 then
		x000077_OnMyChange( sceneId, selfId, targetId, key )
		return
	end
	
	if key == 500 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{CJG_090413_34}" )
		AddNumText( sceneId, x000077_g_ControlScript, "#{CJG_090413_38}", 6, 1 + key)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if key == 501 then
		if LuaFnMtl_GetCostNum(sceneId,selfId,30505254,30505258) < 40 then
			BeginEvent(sceneId)
			AddText( sceneId, "#{CJG_090413_35}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			BeginEvent(sceneId)
			AddText( sceneId, "#{CJG_090413_36}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		BeginAddItem(sceneId)
		AddItem(sceneId,30501171,1)
		if EndAddItem(sceneId,selfId) <= 0 then
			BeginEvent(sceneId)
			AddText( sceneId, "#{CJG_090413_36}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if LuaFnMtl_CostMaterial(sceneId,selfId,40,30505254,30505258) ~= 1 then
			BeginEvent(sceneId)
			AddText( sceneId, "#{CJG_090413_36}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		BeginEvent(sceneId)
		AddText( sceneId, "#{CJG_090413_37}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		AddItemListToHuman(sceneId,selfId)
		return
	end
	if key == 600 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090602_006}")
		EndEvent( )
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x000077_g_ScriptId,-1,1)
		return
	end
	if key == 9999 then
		BeginEvent(sceneId)
		AddText( sceneId, "#{QSJS_090602_012}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	
	for i,Deliveryidx in x000077_g_DeliveryList do
		if eventId == x000077_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i,findId in x000077_g_QianShiJinSheng do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
		end
	end
	if eventId == x000077_g_ControlScript then
		CallScriptFunction( x000077_g_ControlScript, "OnDefaultEvent",sceneId, selfId, targetId )
		return
	end

end


--**********************************
--兑换
--**********************************
function x000077_OnMyChange( sceneId, selfId, targetId, key )

	local num = floor(key/100);
	local numMod = mod(key,100);
	local index = (num-1)*10 + numMod
	
	local unt = x000077_g_ChangeLst[index]
	
	--行为日志
	
	if  unt == nil then
		return
	end
	
	if LuaFnGetAvailableItemCount( sceneId, selfId, unt.NeedItm ) < unt.NeedNum then
	
		local strMsg = format("兑换#H#{_ITEM%d}#W需要72个#H#{_ITEM%d}#W，您的材料不足。", unt.id, unt.NeedItm)
		
		x000077_MsgBox( sceneId, selfId, targetId, strMsg )
		return
	end
	
	BeginAddItem( sceneId )
	AddItem( sceneId, unt.id, 1 )
	if EndAddItem( sceneId, selfId ) > 0 then
		if LuaFnDelAvailableItem( sceneId, selfId, unt.NeedItm, unt.NeedNum ) == 1 then
			AddItemListToHuman( sceneId, selfId )
		else
			x000077_MsgBox( sceneId, selfId, targetId, "    扣除物品失败！" )
			return
		end
	else
		x000077_MsgBox( sceneId, selfId, targetId, "    对不起，您的背包已满，无法兑换。" )
		return
	end
	
	local strMsg = format("兑换成功，你获得了#H#{_ITEM%d}#W", unt.id)
	
	x000077_MsgBox( sceneId, selfId, targetId, strMsg )
	
	--行为日志
	local strLog =  format( "change gem gem:%d gem scrap:%d", unt.id, unt.NeedItm)
	AuditChangeGem(sceneId, selfId, strLog)
	  
	--local	szTran	= GetItemTransfer( sceneId, selfId, 0 )
	--local szUser	= "#{_INFOUSR"..GetName( sceneId, selfId ).."}"
	--local szItem	= "#{_INFOMSG"..szTran.."}"
	--local	szMsg		= format( "#W%s#cff99cc历尽千辛为#G洛阳（111，163）#Y龚彩丽#cff99cc找齐了#Y古瓷碎片#cff99cc，龚彩丽献上%s作为感谢。", szUser, szItem )
	--x000077_MsgBox( sceneId, selfId, targetId, "    您成功的兑换了"..GetItemName( sceneId, unt.id ).."。" )
	--BroadMsgByChatPipe( sceneId, selfId, szMsg, 4 )

end
--**********************************
--接受此NPC的任务
--**********************************
function x000077_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x000077_g_DeliveryList do
		if missionScriptId == x000077_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
			return
		end
	end
	for i,findId in x000077_g_QianShiJinSheng do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId, targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000077_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000077_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	if missionScriptId == x000077_g_ScriptId then
		local DressTbl = {10124160,10124159,10124158}
		local isok = 0
		for i = 1,5 do
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30505248 + i) < 1 then
				isok = i
				break
			end
		end
		if isok > 0 then
			x000077_MsgBox( sceneId, selfId, targetId, "#{QSJS_090508_060}")
			return
		end
		--开始兑换
		local nRandom = random(1,3)
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			x000077_MsgBox( sceneId, selfId, targetId, "#{QSJS_090602_007}")
			return
		end
		--扣除物品
		for i = 1,5 do
			LuaFnDelAvailableItem(sceneId,selfId,30505248 + i ,1)
		end
		--随机发放
		BeginAddItem(sceneId)
			AddBindItem(sceneId,DressTbl[nRandom],1)
		if EndAddItem(sceneId,selfId) <= 0 then
			x000077_MsgBox(sceneId,selfId,targetId,"#{QSJS_090602_007}")
			return
		end
		local nBagPos = LuaFnTryRecieveSingleItem(sceneId,selfId,DressTbl[nRandom],1,1)
		if nBagPos == -1 then
			x000077_MsgBox(sceneId,selfId,targetId,"#{QSJS_090602_007}")
			return
		end
		local szTransfer = GetBagItemTransfer(sceneId,selfId,nBagPos)
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_066}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}#{QSJS_090602_009}#{_INFOMSG%s}#{QSJS_090602_010}",GetName(sceneId,selfId),szTransfer))
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
		return
	end
	--配表任务
	for i,Deliveryidx in x000077_g_DeliveryList do
		if missionScriptId == x000077_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
			return
		end
	end
	for i,findId in x000077_g_QianShiJinSheng do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000077_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x000077_g_DeliveryList do
		if missionScriptId == x000077_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
			return
		end
	end
	for i,findId in x000077_g_QianShiJinSheng do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId)
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000077_OnDie( sceneId, selfId, killerId )
end

--**********************************
--Message Box
--**********************************
function x000077_MsgBox( sceneId, selfId, targetId, str )

	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	
end
