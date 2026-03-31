--脚本号
x888810_g_ScriptId = 888810
x888810_g_ExchangeLevel = 85
--**********************************
--任务入口函数
--**********************************
function x888810_OnDefaultEvent( sceneId, selfId, targetId,opId )
	if opId == -1 or (sceneId == SCENE_LUOYANG and opId == nil) then
		BeginEvent( sceneId )
			if sceneId == SCENE_SHUNANZHUHAI then
				--蜀南竹海
				AddText(sceneId,"#{SZXT_221216_256}")
			elseif sceneId == SCENE_BAIXIHU then
				--白溪湖
				AddText(sceneId,"#{SZXT_221216_254}")
			elseif sceneId == SCENE_XILIANGFENGLIN then
				--西凉枫林
				AddText(sceneId,"#{SZXT_221216_255}")
			elseif sceneId == SCENE_LUOYANG then
				--洛阳NPC
				AddText(sceneId,"#{SZXT_221216_14}")
			end
			--天鉴灵武铸炼
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_61}", 6, 1 )
			--天鉴灵武铸炼转移
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_132}", 6, 2 )
			--铸炼回馈礼	
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_180}", 6, 3 )
			--灵武兑换漱玉泉
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_161}", 6, 4 )
			--漱玉泉合成
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_86}", 6, 5 )
			--灵武解除绑定
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_230410_11}", 6, 6 )
			--关于天鉴灵武
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_62}", 11, 7 )
			--关于套装效果
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_66}", 11, 8 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	elseif opId == 1 then
		--天鉴灵武铸炼
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880801)
		return
	elseif opId == 2 then
		--天鉴灵武铸炼转移
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880805)
		return
	elseif opId == 3 then
		--铸炼回馈礼		
		local nDiCanGetNun = floor(GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_ZHULIAN) / 60) - GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_EXCHANGE)
		local nTianCanGetNun = floor(GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_ZHULIAN) / 60) - GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_EXCHANGE)

		BeginEvent( sceneId )
			AddText(sceneId,ScriptGlobal_Format("#{SZXT_221216_181}",
			GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_ZHULIAN),
			nDiCanGetNun,
			GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_ZHULIAN),
			nTianCanGetNun
			))
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_182}", 6, 200 )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_183}", 6, 201 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	elseif opId == 4 then
		--灵武兑换漱玉泉
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880804)
		return
	elseif opId == 5 then
		--漱玉泉合成
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880807)
		return
	elseif opId == 6 then
		--灵武解除绑定
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 88880810)
		return
	elseif opId == 7 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_68}" )
	elseif opId == 8 then
		BeginEvent( sceneId )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_64}", 11, 100 )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_214}", 11, 101 )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_216}", 11, 102 )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_218}", 11, 103 )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_220}", 11, 104 )
			AddNumText( sceneId, x888810_g_ScriptId, "#{SZXT_221216_222}", 11, 105 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif opId == 100 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_69}" )
	elseif opId == 101 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_215}" )	
	elseif opId == 102 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_217}" )		
	elseif opId == 103 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_219}" )	
	elseif opId == 104 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_221}" )	
	elseif opId == 105 then
		x888810_MsgBox( sceneId, selfId, targetId, "#{SZXT_221216_223}" )	
	elseif opId == 200 then
		if GetLevel(sceneId,selfId) < x888810_g_ExchangeLevel then
			x888810_NotifyTips( sceneId, selfId, "#{SZXT_221216_184}")
			return
		end	
		local nDiCanGetNun = floor(GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_ZHULIAN) / 60) - GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_EXCHANGE)
		if nDiCanGetNun <= 0 then
			x888810_NotifyTips( sceneId, selfId, "#{SZXT_221216_186}")
			return
		end
		BeginAddItem(sceneId)
		AddItem(sceneId,20600007, 1)
		if EndAddItem(sceneId,selfId) <= 0 then
			return
		end
		SetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_EXCHANGE,GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_DIJIE_EXCHANGE) + 1);
		AddItemListToHuman(sceneId,selfId)
		
		x888810_NotifyTips( sceneId, selfId, "#{SZXT_221216_187}")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	elseif opId == 201 then
		if GetLevel(sceneId,selfId) < x888810_g_ExchangeLevel then
			x888810_NotifyTips( sceneId, selfId, "#{SZXT_221216_184}")
			return
		end	
		local nTianCanGetNun = floor(GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_ZHULIAN) / 60) - GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_EXCHANGE)
		if nTianCanGetNun <= 0 then
			x888810_NotifyTips( sceneId, selfId, "#{SZXT_221216_186}")
			return
		end
		BeginAddItem(sceneId)
		AddItem(sceneId,20600008, 1)
		if EndAddItem(sceneId,selfId) <= 0 then
			return
		end
		SetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_EXCHANGE,GetMissionDataEx(sceneId,selfId,MDEX_LINGYU_TIANJIE_EXCHANGE) + 1);
		AddItemListToHuman(sceneId,selfId)
		
		x888810_NotifyTips( sceneId, selfId, "#{SZXT_221216_187}")
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	end
	
end

--**********************************
--事件列表选中一项
--**********************************
function x888810_OnEventRequest( sceneId, selfId, targetId, eventId )
	if sceneId == SCENE_LUOYANG then
		x888810_OnDefaultEvent( sceneId, selfId, targetId,GetNumText() )
		return
	end
end

--**********************************
--列举事件
--**********************************
function x888810_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId, x888810_g_ScriptId, "#{SZXT_221216_21}", 6, -1)
end

--**********************************
-- 屏幕中间提示
--**********************************
function x888810_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x888810_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end