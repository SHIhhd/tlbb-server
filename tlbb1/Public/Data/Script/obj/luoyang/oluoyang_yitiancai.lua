--洛阳NPC
--伊天彩
--普通

x000110_g_scriptId = 000157
--**********************************
--事件交互入口
--**********************************
function x000157_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{SZPR_091023_01}" )
		--染色
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_02}", 6, 1 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_03}", 6, 2 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_04}", 6, 3 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_05}", 6, 4 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_06}", 6, 5 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_07}", 6, 6 )
		--佩饰转移
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPSZY_160314_01}", 6, 7 )
		
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_08}", 11, 100 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPR_091023_09}", 11, 101 )
		AddNumText( sceneId, x000110_g_scriptId, "#{SZPSZY_160314_43}", 11, 102 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x000157_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 0 then
--		BeginAddItem(sceneId)
--		AddItem( sceneId,50431005,1)
--		AddItem( sceneId,50432004,1)
--		AddItem( sceneId,50433001,1)
--		EndAddItem(sceneId,selfId)
--		AddItemListToHuman(sceneId,selfId)
--		TryRecieveItem(sceneId,selfId,30503140,1)
	
		BeginEvent(sceneId)						
			AddText(sceneId,"#{SZZH_170111_11}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	

	if GetNumText() == 1 then
		--时装染色
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  0910281)
		return
	end
	
	if GetNumText() == 2 then
		--染色还原
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  0910282)
		return
	end
	
	if GetNumText() == 3 then
		--时装裁剪
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  20091027)
		return
	end
	
	if GetNumText() == 4 then
		--配饰点缀
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  20091029)
		return
	end
	
	if GetNumText() == 5 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  19860143)
		return
	end	
	
	if GetNumText() == 6 then
		--配饰摘除
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  19851274)
		return
	end	
	
	if GetNumText() == 7 then
		--配饰转移
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommandNew( sceneId, selfId,  3)
		return
	end	
	
	if GetNumText() == 100 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{SZPR_091023_10}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 101 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{SZPR_091023_83}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 102 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{SZPSZY_160314_33}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
end
--**********************************
--醒目提示
--**********************************
function x000157_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end