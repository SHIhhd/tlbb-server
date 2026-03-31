--修炼NPC
--脚本号
x002099_g_ScriptId = 002099
x002099_g_ChangShenCaoItem = {38000639,40004689}
--目前开放的修炼本数为11
x002099_g_CurMaxMijiNum = 11
--所拥有的事件ID列表
x002099_g_eventList={
	--情刃引导·旧友相引
	890273,
	--情刃引导·情刃归缘
	890277,
	--雁门团本休息室
	998443,
}
--**********************************
--事件列表
--**********************************
function x002099_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{XL_090707_01}" )
		--造化丹开放
--		AddNumText( sceneId, x002099_g_ScriptId, "#{LZZHD_130520_01}", 6, 4 )
		--
		AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_35}", 6, 0 ) --修炼
		AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_36}", 6, 1 )
		AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_37}", 6, 2 )
		--help
		AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_38}", 11,3 )
		--造化丹开放
--		AddNumText( sceneId, x002099_g_ScriptId, "#{LZZHD_130520_02}", 11, 5 )
		--
--		AddNumText( sceneId, x002099_g_ScriptId, "#G测试", 16, 888 )

		for i, eventId in x002099_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002099_OnDefaultEvent( sceneId, selfId,targetId )
	x002099_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002099_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002099_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId,GetNumText() )
			return
		end
	end
	
	local Operation = GetNumText()
	if Operation == 0 then
		if GetLevel(sceneId,selfId) < 70 then
			x002099_MsgBox( sceneId, selfId,targetId,"#{XL_090707_61}")
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)--1修炼2提升修炼境界
			UICommand_AddInt(sceneId,0)--g_IsSpecialState
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 171717)
		return
	end
	if Operation == 1 then
		if GetLevel(sceneId,selfId) < 70 then
			x002099_MsgBox( sceneId, selfId,targetId,"#{XL_090707_61}")
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,2)--1修炼2提升修炼境界
			UICommand_AddInt(sceneId,0)--g_IsSpecialState
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 171717)
		return
	end
	if Operation == 2 then
		x002099_AwardXiuLianTitle(sceneId,selfId,targetId)
		return
	end
	if Operation == 3 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{XL_090707_46}" )
			AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_60}", 11, 100 )
--			AddNumText( sceneId, x002099_g_ScriptId, "#{XLZY_120330_19}", 11, 101 )
			AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_69}", 11, 102 )
			AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_61}", 11, 103 )
			AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_63}", 11, 104 )
			AddNumText( sceneId, x002099_g_ScriptId, "#{XL_XML_64}", 11, 105 )
--			AddNumText( sceneId, x002099_g_ScriptId, "#{XLPF_110520_01}", 11, 106 )
			AddNumText( sceneId, x002099_g_ScriptId, "返回上一页", 0, 107 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)	
		return
	end
	if Operation == 4 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{LZZHD_130520_12}" )
			AddNumText( sceneId, x002099_g_ScriptId, "#{LZZHD_1300703_01}", 6, 108 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)	
		return
	end
	if Operation == 5 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{LZZHD_130520_03}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	
	if Operation == 100 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_48}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
--	if Operation == 101 then
--		BeginEvent( sceneId )
--		AddText( sceneId, "#{XLZY_120330_20}" )
--		EndEvent( sceneId )
--		DispatchEventList( sceneId, selfId, targetId )
--		return
--	end
	if Operation == 102 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_52}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 103 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_53}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 104 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_55}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 105 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_56}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
--	if Operation == 106 then
--		BeginEvent( sceneId )
--		AddText( sceneId, "#{XLPF_110520_02}" )
--		EndEvent( sceneId )
--		DispatchEventList( sceneId, selfId, targetId )
--		return
--	end
	if Operation == 107 then
		x002099_UpdateEventList( sceneId, selfId,targetId )
		return
	end
	--炼制造化丹
	if Operation == 108 then
--		if GetLevel(sceneId,selfId) < 70 then
--			x002099_NotifyTip( sceneId, selfId, "#{LZZHD_1300703_02}" )
--			return
--		end
--		--今日炼制的次数
--		local nTodayLianZhi = GetMissionDataEx(sceneId,selfId,MD_ZAOHUADAN_NUM)
--		if nTodayLianZhi >= 3 then
--			x002099_NotifyTip( sceneId, selfId, "#{LZZHD_1300703_03}" )
--			return
--		end
--		--
--		if LuaFnMtl_GetCostNum(sceneId,selfId,x002099_g_ChangShenCaoItem[1],x002099_g_ChangShenCaoItem[2]) < 10 then
--			x002099_NotifyTip( sceneId, selfId, "#{LZZHD_1300703_04}" )
--			return
--		end
--		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 1 then
--			x002099_NotifyTip( sceneId, selfId, "#{LZZHD_1300703_05}" )
--			return
--		end
--		--开始炼制造化丹
--		local nRet = LuaFnMtl_CostMaterial(sceneId,selfId,10,x002099_g_ChangShenCaoItem[1],x002099_g_ChangShenCaoItem[2])
--		if nRet ~= 1 then
--			BeginEvent( sceneId )
--				AddText( sceneId, StringTable_GetData(347) )
--			EndEvent( sceneId )
--			DispatchMissionTips( sceneId, selfId )
--			return
--		end
--		TryRecieveItem(sceneId,selfId,38000640,1) --给予造化丹
--		nTodayLianZhi = nTodayLianZhi + 1
--		SetMissionDataEx(sceneId,selfId,MD_ZAOHUADAN_NUM,nTodayLianZhi)
--		x002099_NotifyTip( sceneId, selfId, "#{LZZHD_1300703_06}" )
--		x002099_NotifyTip( sceneId, selfId, "#{LZZHD_1300703_07}" )
--		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
--		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002099_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002099_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId,targetId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002099_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002099_g_eventList do
		if missionScriptId == findId then
			x002099_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002099_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002099_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002099_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002099_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002099_OnDie( sceneId, selfId, killerId )
end

--**********************************
--领取修炼称号
--**********************************
function x002099_AwardXiuLianTitle(sceneId,selfId,targetId)
	--获取条件：
	--1、登堂入室，最高修炼境界到3重。
	--2、鹤立鸡群，最高修炼境界到4重。
	--3、驾轻就熟，最高修炼境界到5重。
	--4、非比寻常，最高修炼境界到6重。
	--5、登峰造极，最高修炼境界到7重。
	--6、技冠群雄，最高修炼境界到8重。
	--7、一代宗师，最高修炼境界到9重。
	--8、震古烁今，最高修炼境界到10重。
	--9、超凡入圣，最高修炼境界到11重。
	--注：只要有一本修炼达到以上要求，即可获得称号。
	--遍历玩家修炼境界是否达到要求。
	local nTitleTbl = 
	{
		{titleid = 265, level = 3, tips = "#{XL_090707_43}", countnews = "#{XL_090707_44}"},
		{titleid = 266, level = 4, tips = "#{XL_090707_41}", countnews = "#{XL_090707_42}"},
		{titleid = 267, level = 5, tips = "#{XL_090707_39}", countnews = "#{XL_090707_40}"},
		{titleid = 268, level = 6, tips = "#{XL_090707_37}", countnews = "#{XL_090707_38}"},
		{titleid = 269, level = 7, tips = "#{XL_090707_35}", countnews = "#{XL_090707_36}"},
		{titleid = 270, level = 8, tips = "#{XL_090707_33}", countnews = "#{XL_090707_34}"},
		{titleid = 271, level = 9, tips = "#{XL_090707_31}", countnews = "#{XL_090707_32}"},
		{titleid = 272, level = 10, tips = "#{XL_090707_29}", countnews = "#{XL_090707_30}"},
		{titleid = 273, level = 11, tips = "#{XL_090707_27}", countnews = "#{XL_090707_28}"},
		
		{titleid = 274, level = 12, tips = "#{XL_090707_24}", countnews = "#{XL_090707_25}"},
		{titleid = 275, level = 12, tips = "#{XL_090707_21}", countnews = "#{XL_090707_22}"},
		{titleid = 276, level = 12, tips = "#{XL_090707_18}", countnews = "#{XL_090707_19}"},
	}
	local WuXingLevel = LuaFnGetXiuLianBookLevel(sceneId,selfId,0) --五行宝典
	local WuYaLevel = LuaFnGetXiuLianBookLevel(sceneId,selfId,1) --无涯宝典
	local szName = GetName(sceneId,selfId)
	local titleindex = 20 --程序用
	if floor(WuXingLevel / 10) < 3 and floor(WuYaLevel / 10) < 3 then
		x002099_MsgBox(sceneId,selfId,targetId,"#{XL_090707_45}")
		return
	end
	--查询是否领取了全部称号
	local HaveTitle = 0
	for i = 1,getn(nTitleTbl) do
		if GetTitle(sceneId,selfId,titleindex) >= nTitleTbl[i].titleid then
		else
			HaveTitle = i
			break
		end
	end
	if HaveTitle == 0 then
		x002099_NotifyTip(sceneId,selfId,"您已经领取过称号了，需要继续提升修炼境界才能领取更高的修炼称号。")--这块字典没有，用文字代替。
		return
	end
	if HaveTitle > 0 then
		if floor(WuXingLevel / 10) >= nTitleTbl[HaveTitle].level or floor(WuYaLevel / 10) >= nTitleTbl[HaveTitle].level then
			--给予称号
			AwardTitle(sceneId,selfId,titleindex,nTitleTbl[HaveTitle].titleid)
			--更新客户端
			DispatchAllTitle(sceneId,selfId)
			--设置当前称号
			SetCurTitle(sceneId,selfId,45,nTitleTbl[HaveTitle].titleid)
			--领取成功醒目提示
			x002099_NotifyTip(sceneId,selfId,nTitleTbl[HaveTitle].tips)
			--发送系统提示
			AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}",szName)..nTitleTbl[HaveTitle].countnews)
		else
			x002099_NotifyTip(sceneId,selfId,"您已经领取过称号了，需要继续提升修炼境界才能领取更高的修炼称号。")--这块字典没有，用文字代替。
			return
		end
	end
	--领取成功醒目提示
	--x002099_NotifyTip(sceneId,selfId,nTitleTbl[titleidx].tips)
	--发送系统提示
	--AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}",szName)..nTitleTbl[titleidx].countnews)
	
	--超凡入圣之后的称号特写
	if floor(WuYaLevel / 10) >= nTitleTbl[10].level then
		--预留判断称号是否拥有
		if GetTitle(sceneId,selfId,titleindex) == nTitleTbl[10].titleid then
			x002099_NotifyTip(sceneId,selfId,"您已经领取过称号了，需要继续提升修炼境界才能领取更高的修炼称号。")--这块字典没有，用文字代替。
			return
		end
		--给予称号
		AwardTitle(sceneId,selfId,titleindex,nTitleTbl[10].titleid)
		--更新客户端
		DispatchAllTitle(sceneId,selfId)
		--设置当前称号
		SetCurTitle(sceneId,selfId,45,nTitleTbl[10].titleid)
		--领取成功醒目提示
		x002099_NotifyTip(sceneId,selfId,nTitleTbl[10].tips)
		--领取成功的对话框提示
		x002099_MsgBox(sceneId,selfId,targetId,"#{XL_090707_23}")
		--发送系统提示
		AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}",szName)..nTitleTbl[10].countnews)
	end
	
	if floor(WuXingLevel / 10) >= nTitleTbl[11].level then
		--预留判断称号是否拥有
		if GetTitle(sceneId,selfId,titleindex) == nTitleTbl[11].titleid then
			x002099_NotifyTip(sceneId,selfId,"您已经领取过称号了，需要继续提升修炼境界才能领取更高的修炼称号。")--这块字典没有，用文字代替。
			return
		end
		--给予称号
		AwardTitle(sceneId,selfId,titleindex,nTitleTbl[11].titleid)
		--更新客户端
		DispatchAllTitle(sceneId,selfId)
		--设置当前称号
		SetCurTitle(sceneId,selfId,45,nTitleTbl[11].titleid)
		--领取成功醒目提示
		x002099_NotifyTip(sceneId,selfId,nTitleTbl[11].tips)
		--领取成功的对话框提示
		x002099_MsgBox(sceneId,selfId,targetId,"#{XL_090707_20}")
		--发送系统提示
		AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}",szName)..nTitleTbl[11].countnews)
	end

	if floor(WuYaLevel / 10) >= nTitleTbl[12].level and floor(WuXingLevel / 10) >= nTitleTbl[12].level then
		--预留判断称号是否拥有
		if GetTitle(sceneId,selfId,titleindex) == nTitleTbl[12].titleid then
			x002099_NotifyTip(sceneId,selfId,"您已经领取过称号了，需要继续提升修炼境界才能领取更高的修炼称号。")--这块字典没有，用文字代替。
			return
		end
		--给予称号
		AwardTitle(sceneId,selfId,titleindex,nTitleTbl[12].titleid)
		--更新客户端
		DispatchAllTitle(sceneId,selfId)
		--设置当前称号
		SetCurTitle(sceneId,selfId,45,nTitleTbl[12].titleid)
		--领取成功醒目提示
		x002099_NotifyTip(sceneId,selfId,nTitleTbl[12].tips)
		--领取成功的对话框提示
		x002099_MsgBox(sceneId,selfId,targetId,"#{XL_090707_17}")
		--发送系统提示
		AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}",szName)..nTitleTbl[12].countnews)
	end
	
end

--**********************************
--请求修炼升级
--**********************************
function x002099_AskXiuLianLevelUp( sceneId, selfId,targetId,nIndex )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if GetLevel(sceneId,selfId) < 70 then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_02}")
		return
	end
	if nIndex < 0 or nIndex >= x002099_g_CurMaxMijiNum then
		x002099_NotifyTip( sceneId, selfId, "#{XL_090707_03}" )
		return
	end
--	if nIndex >= x002099_g_CurMaxMijiNum and GetLevel(sceneId,selfId) < 90 then
--		x002099_NotifyTip( sceneId, selfId, "#{XLZY_120330_12}" ) --需要等级90
--		return
--	end
	--需要五行宝典的当前最高修炼境界达到第3重才能修炼。
	if nIndex >= 6 and nIndex <= 11 then
		local XiuLianBook1Level = LuaFnGetXiuLianBookLevel(sceneId,selfId,0)
		if XiuLianBook1Level < 3 then
			x002099_NotifyTip( sceneId, selfId, "#{XL_090707_08}" )
			return
		end
	end
	--昊天真经特殊判断
--	if nIndex >= 11 and nIndex <= 14 then
--		if nIndex == 12 then
--			local nlevel_12 = LuaFnGetXiuLianMiJiLevel(sceneId,selfId,11)
--			if tonumber(nlevel_12) < 10 then
--				x002099_NotifyTip( sceneId, selfId, "需要手少阳卷修炼到10级" )
--				return
--			end
--		end
--		if  nIndex == 13 or nIndex == 14 then
--			local level_12 = LuaFnGetXiuLianMiJiLevel(sceneId,selfId,11)
--			local level_13 = LuaFnGetXiuLianMiJiLevel(sceneId,selfId,12)
--			if tonumber(level_12) >= 20 and tonumber(level_13) >= 20 then
--			else
--				x002099_NotifyTip( sceneId, selfId, "需要手少阳卷和足太阴卷都修炼到20级" )
--				return
--			end
--		end
--	end
	-- 该秘籍的修炼等级已经到达上限，您需要提升修炼境界才能继续修炼该秘籍。
	local XiuLianMiJiLevel = LuaFnGetXiuLianMiJiLevel( sceneId,selfId,nIndex );
	local nXiulianMaxLvl = LuaFnGetXiuLianMiJiMaxLevel(sceneId,selfId, nIndex );
	if ( XiuLianMiJiLevel >= nXiulianMaxLvl ) then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_04}")
		return
	end
	--修炼所需的经验值不足。
	local nUpLevelNeedExp,nUpLevelNeedMoney = LuaFnGetXiuLianMiJiUpLevelNeed( sceneId,selfId,nIndex);
	local nExp = GetExp(sceneId,selfId)
	if ( nUpLevelNeedExp > nExp ) then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_06}")
		return
	end
	--修炼所需的金钱不足。
	local nMoney = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if ( nUpLevelNeedMoney > nMoney ) then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_05}")
		return
	end
	--计算需要功力
	local nXiulianNeedPower = 0;
	if (XiuLianMiJiLevel >= 0 and XiuLianMiJiLevel < 30)  then
		nXiulianNeedPower = 33
	elseif(XiuLianMiJiLevel >= 30 and XiuLianMiJiLevel < 60 )  then
		nXiulianNeedPower = 50
	elseif(XiuLianMiJiLevel >= 60 and XiuLianMiJiLevel <= 150)  then
		nXiulianNeedPower = 100
	end
	--您的功力不足，请明天再来吧！
	local nPower = GetPlayerPower(sceneId,selfId)
	if nXiulianNeedPower > nPower then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_51}")
		return
	end
	--升级
	AddXiuLianMijiLevel(sceneId,selfId,nIndex);
	
	x002099_NotifyTip( sceneId, selfId, "#{XL_090707_07}" )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 87, 0);
end

--**********************************
--请求修炼进阶
--**********************************
function x002099_AskXiuLianAdvanceJingJie( sceneId, selfId,targetId,nIndex )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	if GetLevel(sceneId,selfId) < 70 then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_02}")
		return
	end
	if nIndex < 0 or nIndex >= x002099_g_CurMaxMijiNum then
		x002099_NotifyTip( sceneId, selfId, "#{XL_090707_03}" )
		return
	end
--	if nIndex >= x002099_g_CurMaxMijiNum and GetLevel(sceneId,selfId) < 90 then
--		x002099_NotifyTip( sceneId, selfId, "#{XLZY_120330_12}" ) --需要等级90
--		return
--	end
	-- 您这本秘籍的修为还不够，只有修炼等级达到上限才能提升修炼境界！
	local XiuLianMiJiLevel = LuaFnGetXiuLianMiJiLevel( sceneId,selfId,nIndex );
	local nXiulianMaxLvl = LuaFnGetXiuLianMiJiMaxLevel(sceneId,selfId, nIndex );
	if ( XiuLianMiJiLevel ~= nXiulianMaxLvl ) then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_10}")
		return
	end
	--现有的进阶条件是同时有三个或三个以上的秘籍境界相等或高于此境界才可以
	--需要五行宝典中其他2本修炼秘籍的修炼境界也达到第 H重或者更高。
	local XiuLianMiJiJingJie = LuaFnGetXiuLianMiJiJingJie( sceneId,selfId,nIndex);
	if XiuLianMiJiJingJie >= 9 then --本秘籍的修炼等级已达极限
		x002099_NotifyTip( sceneId, selfId,"#{XL_XML_77}")
		return
	end
	if nIndex >= 0 and nIndex <= 4 then
		local nAllowNum = 0
		for i = 1,5 do
			if LuaFnGetXiuLianMiJiJingJie( sceneId,selfId,i - 1) >= XiuLianMiJiJingJie then
				nAllowNum = nAllowNum + 1
			end
		end
		nAllowNum = nAllowNum - 1 --去除本身
		if nAllowNum < 2 then
			x002099_NotifyTip( sceneId, selfId,"#{XL_090707_11}"..XiuLianMiJiJingJie.."#{XL_090707_12}")
			return
		end
	end
	if nIndex >= 5 and nIndex <= 10 then
		local nAllowNum = 0
		for i = 5,10 do
			if LuaFnGetXiuLianMiJiJingJie( sceneId,selfId,i ) >= XiuLianMiJiJingJie then
				nAllowNum = nAllowNum + 1
			end
		end
		nAllowNum = nAllowNum - 1 --去除本身
		if nAllowNum < 2 then
			--需要无涯遗书中有其他2本修炼秘籍的修炼境界也达到第
			x002099_NotifyTip( sceneId, selfId,"#{XL_090707_65}"..XiuLianMiJiJingJie.."#{XL_090707_66}")
			return
		end
	end
	--计算金钱消耗
	local CurMaxLevel = nXiulianMaxLvl
	local nJingJieNum = 0;
	if(CurMaxLevel <= 60)   then
		nJingJieNum = CurMaxLevel/10;
	else
		nJingJieNum = ((CurMaxLevel-60)/15) + 6
	end
	nJingJieNum = nJingJieNum + 1
	local nNeedMoney = nJingJieNum*10000
	local nMoney = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if ( nNeedMoney > nMoney ) then
		x002099_NotifyTip( sceneId, selfId,"#{XL_090707_13}")
		return
	end
	local money_ret = LuaFnCostMoneyWithPriority(sceneId, selfId, nNeedMoney)
    if money_ret ==-1 then
        x002099_NotifyTip( sceneId, selfId, "#{XL_090707_13}" )
        return
    end
	--境界提升
	AddXiuLianMijiJingJie(sceneId,selfId,nIndex);
	x002099_NotifyTip( sceneId, selfId, "#{XL_090707_15}"..tostring(XiuLianMiJiJingJie + 1).."#{XL_090707_16}" )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 88, 0);

end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x002099_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 对话框信息提示
--**********************************
function x002099_MsgBox(sceneId,selfId,targetId,txt)
	BeginEvent( sceneId )
		AddText( sceneId,txt )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end