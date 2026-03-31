--雁门团本 休息室
--脚本号
x998443_g_ScriptId = 998443
x998443_g_MinLevel = 65
x998443_g_TitleExchange = {
	{tip = "#{YMMJ_230626_213}",need = 2,titleId = 1304},
	{tip = "#{YMMJ_230626_214}",need = 10,titleId = 1305},
	{tip = "#{YMMJ_230626_215}",need = 30,titleId = 1306},
	{tip = "#{YMMJ_230626_216}",need = 60,titleId = 1307},
	{tip = "#{YMMJ_230626_217}",need = 100,titleId = 1308},
}
--通过纪念
x998443_g_TitleNeedItem = 20900010
--**********************************
--任务入口函数
--**********************************
function x998443_OnDefaultEvent( sceneId, selfId, targetId )
	
	if GetNumText() == 1000 then
		if GetLevel(sceneId,selfId) < x998443_g_MinLevel then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_6}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_7}" )
			return
		end
		--今日的挑战次数
		local lastDayCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_YANMEMENGJING)
		if lastDayCount >= 1 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_8}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_9}" )
			return
		end
		--杀气缠身
		local pk_value = LuaFnGetHumanPKValue( sceneId, selfId )
		if pk_value and pk_value > 0 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_10}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_11}" )
			return
		end
		--组队跟随
		if IsTeamFollow(sceneId,selfId) == 1 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_12}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_13}" )
			return
		end
		--处于同骑
		local nHasRide_Two = LuaFnGetDRideFlag(sceneId, selfId);
		if nHasRide_Two and nHasRide_Two == 1 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_14}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_15}" )
			return
		end
		if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_14}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_15}" )
			return
		end
		--处于变身状态
		if LuaFnIsModelOrMount( sceneId, selfId ) == 2 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_20}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_21}" )
			return
		end
		if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_18}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_19}" )
			return
		elseif LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113) == 1 then
			x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_16}")
			x998443_MsgBox( sceneId, selfId, targetId, "#{YMMJ_230626_17}" )
			return
		end
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, SCENE_YANMEN_BREAKROOM, 96,99, 65 );
		return
	end
	if GetNumText() == 1001 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{YMMJ_230626_5}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--度业念珠兑换称号
	if GetNumText() == 1002 then
		BeginEvent( sceneId )
			for i = 1,getn(x998443_g_TitleExchange) do
				AddNumText(sceneId, x998443_g_ScriptId,x998443_g_TitleExchange[i].tip,9,x998443_g_TitleExchange[i].titleId);
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if GetNumText() == 2000 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
	--兑换具体称号
	for i = 1,getn(x998443_g_TitleExchange) do
		if x998443_g_TitleExchange[i].titleId == GetNumText() then
			BeginEvent( sceneId )
				AddText( sceneId, ScriptGlobal_Format("#{YMMJ_230626_218}",
					LuaFnGetTitleNameById(x998443_g_TitleExchange[i].titleId),
					tostring(x998443_g_TitleExchange[i].need),
					GetItemName(sceneId,x998443_g_TitleNeedItem)) )
				AddNumText(sceneId, x998443_g_ScriptId,"#{YMMJ_230626_219}",8,x998443_g_TitleExchange[i].titleId * 10);
				AddNumText(sceneId, x998443_g_ScriptId,"#{YMMJ_230626_220}",8,2000);
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if x998443_g_TitleExchange[i].titleId * 10 == GetNumText() then
			if GetLevel(sceneId,selfId) < 65 then
				x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_221}")
				return
			end
			if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
				x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_222}")
				return
			end
			local retCanAddTitle = LuaFnCanAddTitle( sceneId, selfId, x998443_g_TitleExchange[i].titleId )
			if ( retCanAddTitle ~= 1 ) then
				if ( retCanAddTitle == 0 ) then
--					称号已存在
					x998443_NotifyTips(sceneId, selfId, "#{YMMJ_230626_225}")
					return
				else
					return
				end
			end
			if i ~= 1 then
				--检查此前的激活没有
				if LuaFnCanAddTitle( sceneId, selfId, x998443_g_TitleExchange[i - 1].titleId ) ~= 0 then
					x998443_NotifyTips(sceneId, selfId,ScriptGlobal_Format( "#{YMMJ_230626_224}",LuaFnGetTitleNameById(x998443_g_TitleExchange[i - 1].titleId)))
					return
				end
			end
--			检查物品够不够
			if LuaFnGetAvailableItemCount(sceneId,selfId,x998443_g_TitleNeedItem) < x998443_g_TitleExchange[i].need then
				x998443_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{YMMJ_230626_227}",GetItemName(sceneId,x998443_g_TitleNeedItem),tostring(x998443_g_TitleExchange[i].need)))
				x998443_MsgBox(sceneId, selfId,targetId,
					ScriptGlobal_Format("#{YMMJ_230626_226}",
						tostring(x998443_g_TitleExchange[i].need),
						GetItemName(sceneId,x998443_g_TitleNeedItem),
						x998443_g_TitleExchange[i].tip))
				return
			end
			--扣除物品增加称号
			LuaFnDelAvailableItem(sceneId,selfId,x998443_g_TitleNeedItem,x998443_g_TitleExchange[i].need)
			
			LuaFnAwardCharTitle( sceneId, selfId, x998443_g_TitleExchange[i].titleId )
			LuaFnSetCurTitleById( sceneId, selfId, x998443_g_TitleExchange[i].titleId )
			LuaFnDispatchAllTitle(sceneId, selfId)
			
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		end
	end
end

--**********************************
--列举事件
--**********************************
function x998443_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId, x998443_g_ScriptId,"#{YMMJ_230626_3}",9,1000);
	AddNumText(sceneId, x998443_g_ScriptId,"#{YMMJ_230626_212}",6,1002);
	AddNumText(sceneId, x998443_g_ScriptId,"#{YMMJ_230626_4}",11,1001);
end

--**********************************
--对话框通知事件
--**********************************
function x998443_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId,  msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--通知事件
--**********************************
function x998443_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

