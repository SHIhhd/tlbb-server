--云姗姗
--珍兽装备坊

--脚本号
x001087_g_scriptId = 001087

x001087_g_shoptableindex = 1

--所拥有的事件ID列表
x001087_g_eventList = {}
x001087_g_DeliveryScript = 006668
x001087_g_DeliveryList = {1018835}

--圣兽鳞兑换宠物装备
x001087_g_PetEquipList = {
	[85] = {
		--兑换85级珍兽套装
		title = "#{ZSZBDH_XML_1}",
		titleSub = "#{ZSZBDH_090806_2}",
		needMaterial = {20301007,20301009},
		needMaterialCnt = 30,
		equipTb = {
			{title = "#{ZSZBDH_XML_3}",prize = {70500045,70501045,70502045,70503045,70504045}},
			{title = "#{ZSZBDH_XML_4}",prize = {70500050,70501050,70502050,70503050,70504050}},
			{title = "#{ZSZBDH_XML_5}",prize = {70500055,70501055,70502055,70503055,70504055}},
			{title = "#{ZSZBDH_XML_6}",prize = {70500060,70501060,70502060,70503060,70504060}},
			{title = "#{ZSZBDH_XML_7}",prize = {70500065,70501065,70502065,70503065,70504065}},
			{title = "#{ZSZBDH_XML_8}",prize = {70500070,70501070,70502070,70503070,70504070}},
			{title = "#{ZSZBDH_XML_9}",prize = {70500075,70501075,70502075,70503075,70504075}},
			{title = "#{ZSZBDH_XML_10}",prize = {70500080,70501080,70502080,70503080,70504080}},
			{title = "#{ZSZBDH_XML_11}",prize = {70500085,70501085,70502085,70503085,70504085}},
		}
	},
	
	
	[95] = {
		--兑换95级珍兽套装
		title = "#{ZSZBDH_XML_2}",
		titleSub = "#{ZSZBDH_090806_3}",
		needMaterial = {20301007,20301009},
		needMaterialCnt = 100,
		equipTb = {
			{title = "#{ZSZBDH_XML_13}",prize = {70500090,70501090,70502090,70503090,70504090}},
			{title = "#{ZSZBDH_XML_14}",prize = {70500095,70501095,70502095,70503095,70504095}},
			{title = "#{ZSZBDH_XML_15}",prize = {70500100,70501100,70502100,70503100,70504100}},
			{title = "#{ZSZBDH_XML_16}",prize = {70500105,70501105,70502105,70503105,70504105}},
			{title = "#{ZSZBDH_XML_17}",prize = {70500110,70501110,70502110,70503110,70504110}},
			{title = "#{ZSZBDH_XML_18}",prize = {70500115,70501115,70502115,70503115,70504115}},
			{title = "#{ZSZBDH_XML_19}",prize = {70500120,70501120,70502120,70503120,70504120}},
			{title = "#{ZSZBDH_XML_20}",prize = {70500125,70501125,70502125,70503125,70504125}},
			{title = "#{ZSZBDH_XML_21}",prize = {70500130,70501130,70502130,70503130,70504130}},
		}
	},
}
--**********************************
--事件列表
--**********************************
function x001087_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZSZB_090421_09}")
		AddNumText(sceneId,x001087_g_scriptId,"珍兽套装星级提升",6,1)
		AddNumText(sceneId,x001087_g_scriptId,"珍兽套装拆解",6,2)
		AddNumText(sceneId,x001087_g_scriptId,"珍兽套装兑换",6,3)
		AddNumText(sceneId,x001087_g_scriptId,"珍兽套装星级提升介绍",11,4)
		AddNumText(sceneId,x001087_g_scriptId,"珍兽套装拆解介绍",11,5)
		for i, Deliveryidx in x001087_g_DeliveryList do
			CallScriptFunction( x001087_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x001087_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 0  then
		-- 关闭窗口
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return
	end

	if GetNumText() == 1 then
		BeginUICommand(sceneId);
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddInt(sceneId, 1);
		EndUICommand(sceneId);
		DispatchUICommand(sceneId, selfId, 19831204);
	end

	if GetNumText() == 2 then
		BeginUICommand(sceneId);
			UICommand_AddInt(sceneId, targetId)
			UICommand_AddInt(sceneId, 30)
		EndUICommand(sceneId);
		DispatchUICommand(sceneId, selfId, 19831205);
	end


	if GetNumText() == 3 then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZBDH_090806_1}")
		    AddNumText( sceneId, x001087_g_scriptId, x001087_g_PetEquipList[85].title, 6, 85 )
		    AddNumText( sceneId, x001087_g_scriptId, x001087_g_PetEquipList[95].title, 6, 95 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetNumText() == 4 then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZBSJ_090706_14}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetNumText() == 5 then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZBSJ_090706_16}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	local numKey = GetNumText()
	if x001087_g_PetEquipList[numKey] ~= nil then
		BeginEvent(sceneId)
			AddText(sceneId, x001087_g_PetEquipList[numKey].titleSub)
			for i = 1,getn(x001087_g_PetEquipList[numKey].equipTb) do
				AddNumText( sceneId, x001087_g_scriptId, x001087_g_PetEquipList[numKey].equipTb[i].title, 6,numKey * 100 + i )
			end
			AddNumText( sceneId, x001087_g_scriptId, "返回", 0, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	if numKey > 8500 then
		local nIndex = floor(numKey / 100)
		local nSubIndex = mod(numKey,100)
		if x001087_g_PetEquipList[nIndex] ~= nil and x001087_g_PetEquipList[nIndex].equipTb[nSubIndex] ~= nil then
			BeginEvent(sceneId)
				AddText(sceneId, format("%s#{ZSZBDH_090806_4}#G%d#W#{ZSZBDH_090806_5}",
					x001087_g_PetEquipList[nIndex].equipTb[nSubIndex].title,x001087_g_PetEquipList[nIndex].needMaterialCnt))
				for i = 1,getn(x001087_g_PetEquipList[nIndex].equipTb[nSubIndex].prize) do
					AddRadioItemBonus( sceneId, x001087_g_PetEquipList[nIndex].equipTb[nSubIndex].prize[i], 4 )
				end
			EndEvent(sceneId)
			DispatchMissionContinueInfo(sceneId,selfId,targetId, x001087_g_scriptId, 0)	
		end
	end
	--配表任务
	for i,Deliveryidx in x001087_g_DeliveryList do
		if eventId == x001087_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, findId in x001087_g_eventList do
		if eventId == findId then			
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001087_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x001087_g_DeliveryList do
		if missionScriptId == x001087_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x001087_g_eventList do
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
function x001087_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001087_g_eventList do
		if missionScriptId == findId then
			x001087_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001087_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x001087_g_DeliveryList do
		if missionScriptId == x001087_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x001087_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001087_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--处理提交后的显示情况
	local tNeedItem = nil
	local nNeedCnt = 0
	
	local tEquip = x001087_g_PetEquipList[85].equipTb
	for i = 1,getn(tEquip) do
		for j = 1,getn(tEquip[i].prize) do
			if tEquip[i].prize[j] == selectRadioId then
				tNeedItem = x001087_g_PetEquipList[85].needMaterial
				nNeedCnt = x001087_g_PetEquipList[85].needMaterialCnt
				break
			end
		end
	end
	tEquip = x001087_g_PetEquipList[95].equipTb
	for i = 1,getn(tEquip) do
		for j = 1,getn(tEquip[i].prize) do
			if tEquip[i].prize[j] == selectRadioId then
				tNeedItem = x001087_g_PetEquipList[95].needMaterial
				nNeedCnt = x001087_g_PetEquipList[95].needMaterialCnt
				break
			end
		end
	end
	if tNeedItem == nil then
		return
	end
	
	-- 检查是不是有足够的石头可以扣除
	if LuaFnMtl_GetCostNum(sceneId, selfId, tNeedItem[1],tNeedItem[2]) < nNeedCnt then
		x001087_Tips( sceneId, selfId,"#{ZSZBDH_090806_7}" )
		return
	end
	
	-- 检查背包空间
	BeginAddItem(sceneId)
	AddItem(sceneId, selectRadioId, 1)	
	if EndAddItem(sceneId, selfId) < 1 then
		x001087_Tips( sceneId, selfId,"#{ZSZBDH_090806_8}" )
		return
	end	
	-- 删除相关的石头
	LuaFnMtl_CostMaterial(sceneId,selfId,nNeedCnt,tNeedItem[1],tNeedItem[2])
	
	--给玩家东西，完成
	AddItemListToHuman(sceneId,selfId)
	
	x001087_Tips( sceneId, selfId,"#{ZSZBDH_090806_9}" )

	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
		
	--配表任务
	for i,Deliveryidx in x001087_g_DeliveryList do
		if missionScriptId == x001087_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x001087_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--*************************************************
--屏幕中间对话提示
--*************************************************
function x001087_Tips( sceneId, selfId,msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

