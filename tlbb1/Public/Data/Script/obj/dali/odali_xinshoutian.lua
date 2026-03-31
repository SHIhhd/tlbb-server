--赵天师

--脚本号
x002030_g_scriptId = 002030


--所拥有的事件ID列表
--旧的需要重新整理
--x002030_g_eventList={210200,210204,210205,210208,210210,210212,210213,210214,210216,210217,210220,210223, 210224, 210225, 210229, 210230, 210232, 210238, 210239, 210237, 210240, 200080, 200083, 200086, 200091, 200094,200095,210241,050022}
x002030_g_eventList = {
	--新手系列任务
	891080,891081,891084,891085,891086,891087,891089,891090,210270,210262,210255,210258,210263,210275,210276,210277,210266,210278,210267,210269,210268,210279,
	--剧情任务
	200080, 200083, 200086, 200091, 200094,200095,
	--如何才能去九大门派指引
	210241,
	--喜从天降活动
	--050022
	--武道引导任务
	891218,891219
}
x002030_g_DeliveryScript = 006668
x002030_g_DeliveryList = {1018700}

--是否开启维护补偿礼包
x002030_g_StopPrize = 0		
--维护礼包道具内容
x002030_g_StopPrizeItem = 
{
	{item = 20501003,num = 10},
	{item = 20502003,num = 10},
	{item = 30505076,num = 5}
}
x002030_g_StopPrizeBindYuanBao = 22222
--**********************************
--事件列表
--**********************************
function x002030_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)

	local  PlayerName=GetName(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)
	local  nLevel=GetLevel(sceneId,selfId)
	
	if PlayerSex == 0 then
		PlayerSex = "妹妹"
	else
		PlayerSex = "兄弟"
	end
	local IsNew = GetMissionFlag( sceneId, selfId, MF_Dialog_01 )
	if IsNew == 0 then
		AddText(sceneId,"  "..PlayerName..PlayerSex.."#{OBJ_dali_0011}") --#r  在你等级低的时候，你也可以来我这里帮我做些事情，我会给你经验以及金钱等不同的奖励，帮助你成为一个真正的大侠。
		SetMissionFlag( sceneId, selfId, MF_Dialog_01, 1 )
	elseif IsNew == 1 then
		if GetLevel( sceneId, selfId ) >= 10 and GetMenPai( sceneId, selfId ) == MP_WUMENPAI then
			AddText( sceneId, "  "..PlayerName..PlayerSex.."#{OBJ_dali_0054}" )
		else
			AddText( sceneId, "  "..PlayerName..PlayerSex.."#{OBJ_dali_0012}" )
		end
	end
	--无字典内容，文字代替。
	AddNumText( sceneId, x002030_g_scriptId, "领取版本预约礼", 6, 24640 )
	if x002030_g_StopPrize == 1 then
		AddNumText( sceneId, x002030_g_scriptId, "领取维护补偿礼", 6, 24642 )
	end
	if nLevel >= 20 then
		AddNumText( sceneId, x002030_g_scriptId, "剧情任务介绍", 11, 10 )
	end

	if nLevel >= 50 then
		AddNumText( sceneId, x002030_g_scriptId, "天下武学", 6, 199 )
		AddNumText( sceneId, x002030_g_scriptId, "天下武学介绍", 11, 200 )
	end
	--无字典内容，文字代替。
	AddNumText( sceneId, x002030_g_scriptId, "关于领取版本预约礼", 11, 24641 )
	
	for i, Deliveryidx in x002030_g_DeliveryList do
		CallScriptFunction( x002030_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, eventId in x002030_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	
	
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002030_OnDefaultEvent( sceneId, selfId,targetId )
	x002030_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002030_OnEventRequest( sceneId, selfId, targetId, eventId )
	--版本预约礼内容
	if GetNumText() == 24640 then
		--预约礼包道具内容
		local iteminfo = 
		{
			{item = 20501003,num = 10},{item = 20502003,num = 10},{item = 30900056,num = 5},{item = 50513004,num = 1}
		}
		--绑元数量
		local bindybnum = 5000;
		--背包空间检测数据
		local bagsize = {Property = 1,Material = 3}
		local nPropertySize = LuaFnGetPropertyBagSpace(sceneId,selfId)
		local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
		local giftflag = GetMissionFlagEx(sceneId,selfId,MFEX_YuYuePacket)
		if giftflag == 1 then
			BeginEvent(sceneId)	
				AddText(sceneId,"#{YYBW_200915_04}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--检查背包空间
		if nPropertySize < bagsize.Property or nMaterialSize < bagsize.Material then
			BeginEvent(sceneId)	
				AddText(sceneId,
					ScriptGlobal_Format("#{CZHL_200916_24}",
					bagsize.Property,
					bagsize.Material
				))
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--开始发奖励
		BeginAddItem(sceneId)
			for i = 1,getn(iteminfo) do
				AddBindItem(sceneId,iteminfo[i].item,iteminfo[i].num)
			end
			if EndAddItem(sceneId,selfId) <= 0 then
				BeginEvent(sceneId)	
					AddText(sceneId,
						ScriptGlobal_Format("#{CZHL_200916_24}",
						bagsize.Property,
						bagsize.Material
					))
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
		--发放成功
		AddItemListToHuman(sceneId,selfId)
		--增加绑定元宝
		BindYuanBao(sceneId,selfId,targetId,1,bindybnum)
		--发送屏幕提示
		for i = 1,getn(iteminfo) do
			BeginEvent(sceneId)
				AddText(sceneId,format("您获得%d个%s。",iteminfo[i].num,GetItemName(sceneId,iteminfo[i].item)))
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, selfId)
		end
		--给个领取状态
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
		--设置玩家领取标记
		SetMissionFlagEx(sceneId,selfId,MFEX_YuYuePacket,1)
	end
	if GetNumText() == 24641 then
		BeginEvent(sceneId)	
			AddText( sceneId, "    为庆祝官方预约重返新天龙八部的群侠数突破2万，大理赵天师特奉上感恩礼馈，与江湖众侠士同庆。#r    点击领取版本预约礼按钮，即可领取#G10个#Y3级棉布#W、#G10个#Y3级秘银#W、#G1个#Y5000点绑定元宝#W、#G5个#Y低级宝石熔炼符#W、#G1顆#Y红宝石(5級)#W。#r    #G注意：每个角色仅可领取1次版本预约礼。" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--维护补偿礼内容
	 if GetNumText() == 24642 and x002030_g_StopPrize == 1 then
--		 背包空间检测数据
		 local bagsize = {Property = 1,Material = 2}
		 local nPropertySize = LuaFnGetPropertyBagSpace(sceneId,selfId)
		 local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
		 local giftflag = GetMissionFlagEx(sceneId,selfId,MFEX_BuChangPacket)
		 if giftflag == 1 then
			 BeginEvent(sceneId)	
				 AddText(sceneId,"你已经领取过维护补偿礼了。")
			 EndEvent(sceneId)
			 DispatchEventList(sceneId,selfId,targetId)
			 return
		 end
--		 检查背包空间
		 if nPropertySize < bagsize.Property or nMaterialSize < bagsize.Material then
			 BeginEvent(sceneId)	
				 AddText(sceneId,
					 ScriptGlobal_Format("#{CZHL_200916_24}",
					 bagsize.Property,
					 bagsize.Material
				 ))
			 EndEvent(sceneId)
			 DispatchEventList(sceneId,selfId,targetId)
			 return
		 end
--		 开始发奖励
		 BeginAddItem(sceneId)
			 for i = 1,getn(x002030_g_StopPrizeItem) do
				 AddBindItem(sceneId,x002030_g_StopPrizeItem[i].item,x002030_g_StopPrizeItem[i].num)
			 end
			 if EndAddItem(sceneId,selfId) <= 0 then
				 BeginEvent(sceneId)	
					 AddText(sceneId,
						 ScriptGlobal_Format("#{CZHL_200916_24}",
						 bagsize.Property,
						 bagsize.Material
					 ))
				 EndEvent(sceneId)
				 DispatchEventList(sceneId,selfId,targetId)
				 return
			 end
--		 发放成功
		 AddItemListToHuman(sceneId,selfId)
--		 增加绑定元宝
		 BindYuanBao(sceneId,selfId,targetId,1,x002030_g_StopPrizeBindYuanBao)
--		 发送屏幕提示
		 for i = 1,getn(x002030_g_StopPrizeItem) do
			 BeginEvent(sceneId)
				 AddText(sceneId,format("您获得%d个%s。",x002030_g_StopPrizeItem[i].num,GetItemName(sceneId,x002030_g_StopPrizeItem[i].item)))
			 EndEvent(sceneId)
			 DispatchMissionTips(sceneId, selfId)
		 end
--		 给个领取状态
		 LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
--		 设置玩家领取标记
		 SetMissionFlagEx(sceneId,selfId,MFEX_BuChangPacket,1)
	 end
	if GetNumText() == 10 then
			BeginEvent(sceneId)	
					
				AddText( sceneId, "#{function_help_073}" )
				AddNumText( sceneId, x002030_g_scriptId, "我现在进行到哪里了？", 11, 11 )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	end
	
	if GetNumText() == 11 then
		CallScriptFunction( 200098, "DispatchJuqintInfo",sceneId, selfId, targetId )
		return
	end

	--天下武学功能
	if GetNumText() == 198 then
		--检查善恶值
		local gbvalue = LuaFnGetHumanGoodBadValue( sceneId, selfId )
		if gbvalue < 100 then
			BeginEvent( sceneId )
				AddText( sceneId, "您没有足够的善恶值，我还不能把联名推荐信送给你。" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end

		--检查任务栏空间
		LuaFnBeginAddItem( sceneId )
			LuaFnAddItem( sceneId, 40002108, 1)
		local retc = LuaFnEndAddItem( sceneId, selfId )
		if 1 ~= retc then
			BeginEvent( sceneId )
				AddText( sceneId, "您任务道具栏位置不够了。" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		--加推荐信
		BeginAddItem(sceneId)
			AddItem( sceneId,40002108,1)
		local ret = EndAddItem(sceneId,selfId)
		if 1 == ret then
			AddItemListToHuman(sceneId,selfId)
			--扣善恶值
			gbvalue = gbvalue - 100
			LuaFnSetHumanGoodBadValue( sceneId, selfId, gbvalue )
			
			--屏幕中间提示信息
			BeginEvent(sceneId)
				AddText(sceneId,"您得到了联名推荐信")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
			--发送特效
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,1000)
		end
		return
	end	
	
	--天下武学
	if GetNumText() == 199 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{function_help_100}" )
			AddNumText( sceneId, x002030_g_scriptId, "1百善恶值换取1封联名推荐信", 7, 198)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	--天下武学介绍
	if GetNumText() == 200 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{function_help_100}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--配表任务
	for i,Deliveryidx in x002030_g_DeliveryList do
		if eventId == x002030_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, findId in x002030_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002030_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x002030_g_DeliveryList do
		if missionScriptId == x002030_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				if missionScriptId == 210267 then --答题任务要单独处理下传个targetID
					CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,targetId)
				else
					CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId)
				end
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002030_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			x002030_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002030_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x002030_g_DeliveryList do
		if missionScriptId == x002030_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002030_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x002030_g_DeliveryList do
		if missionScriptId == x002030_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x002030_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end
--**********************************
--死亡事件
--**********************************
function x002030_OnDie( sceneId, selfId, killerId )
end

--**********************************
--时钟事件
--**********************************
function x002030_OnCharacterTimer( sceneId, selfId, dataId, nowtime )
--场景号，ObjID，怪物表号，时间值(毫秒)

end





