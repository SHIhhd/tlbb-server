--洛阳NPC
--彭怀玉
--普通

x000110_g_scriptId = 000110

--**********************************
--事件交互入口
--**********************************
function x000110_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )

		AddText( sceneId, "#{BSLCYH_130529_02}" )
		AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_05}", 11, 0 )
		AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_06}", 11, 20 )
	
		AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_02}", 6, 1 )
		AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_03}", 6, 2 )
		AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_04}", 6, 121 )--old 4
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件列表选中一项
--**********************************
function x000110_OnEventRequest( sceneId, selfId, targetId, eventId )

		if GetNumText() == 0 then
			BeginEvent(sceneId)	
			
				AddText(sceneId,"#{function_help_054}#r")
			
				AddNumText(sceneId, x000110_g_scriptId,"装备打孔介绍",11,8);
				AddNumText(sceneId, x000110_g_scriptId,"宝石合成介绍",11,9);
				AddNumText(sceneId, x000110_g_scriptId,"宝石镶嵌介绍",11,10);
				AddNumText(sceneId, x000110_g_scriptId,"宝石摘除介绍",11,11);
	--				AddNumText(sceneId, x000110_g_scriptId,"装备修理介绍",11,12);
				AddNumText(sceneId, x000110_g_scriptId,"宝石雕琢介绍",11,13);
				AddNumText(sceneId, x000110_g_scriptId,"宝石熔炼介绍",11,14);
				AddNumText(sceneId, x000110_g_scriptId,"宝石转移介绍",11,15);
				AddNumText(sceneId, x000110_g_scriptId,"胜利宝石介绍",11,16);
				AddNumText(sceneId, x000110_g_scriptId,"#{JXDK_20220121_17}",11,17);

			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
			
		-- addstart 2008-10-21 add by cuiyinjie
		if GetNumText() == 20 then  -- add by cuiyinjie 材料合成介绍
			BeginEvent(sceneId)			
				AddText(sceneId,"#{SJSJ_081021_001}#r")
				AddNumText(sceneId, x000110_g_scriptId,"精铁的操作介绍",11,21);
				AddNumText(sceneId, x000110_g_scriptId,"秘银的操作介绍",11,22);
				AddNumText(sceneId, x000110_g_scriptId,"棉布的操作介绍",11,23);					
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if GetNumText() == 21 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{SJSJ_081021_004}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 22 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{SJSJ_081021_005}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 23 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{SJSJ_081021_006}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		-- addend 2008-10-21 
		
		if GetNumText() == 8 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_039}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 9 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_040}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 10 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_041}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 11 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_042}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 12 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{function_help_043}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 13 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{INTERFACE_XML_GemCarve_6}#r")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end	
		if GetNumText() == 14 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{JKBS_081021_022}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		if GetNumText() == 15 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{BSQKY_20110506_25}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		if GetNumText() == 16 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{JKBS_081021_023}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		if GetNumText() == 17 then
			BeginEvent(sceneId)						
				AddText(sceneId,"#{XQC_20080509_34}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		--------------------------------------------------------------------------
		--装备工坊
		if GetNumText() == 1 then
			BeginEvent(sceneId)		
				AddNumText(sceneId, x000110_g_scriptId,"#{JXDK_20220121_07}",6,200);
				AddNumText(sceneId, x000110_g_scriptId,"#{JXDK_20220121_08}",6,201);
				AddNumText(sceneId, x000110_g_scriptId,"#{JXDK_20220121_09}",6,202);	
--				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_10}", 6, 203 )
--				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_11}", 6, 204 )
--				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_12}", 6, 205 )				
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		--宝石工坊
		if GetNumText() == 2 then
			BeginEvent(sceneId)			
				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_13}", 6, 100 )	
				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_14}", 6, 101 )
				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_15}", 6, 102 )
				AddNumText( sceneId, x000110_g_scriptId, "#{JXDK_20220121_16}", 6, 103 )	
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	
		--宝石合成
		if GetNumText() == 100 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 23 )
			return
		end

		--宝石雕琢
		if GetNumText() == 101 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 112236 )
			return
		end
		
		--宝石熔炼
		if GetNumText() == 102 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 112237 )
			return
		end
		
		--宝石转移
		if GetNumText() == 103 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20110509 )
			return
		end

		--宝石转移
--		if GetNumText() == 104 then
--			BeginUICommand( sceneId )
--			UICommand_AddInt( sceneId, targetId )
--			EndUICommand( sceneId )
--			DispatchUICommand( sceneId, selfId, 201302201 )
--			return
--		end
		
		--材料合成
		if GetNumText() == 121 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 1 )
				UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 920170825 )--新界面
			return
		end

		--装备打孔
		if GetNumText() == 200 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 2013060601 )	--25
			return
		end
		
		if GetNumText() == 202 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 2013060603 )	--27
			return
		end
		
		if GetNumText() == 201 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 2013060602 )	--19830424
			return
		end
		
		--极限打孔一套
--		if GetNumText() == 203 then
--			BeginEvent(sceneId)		
--				AddText(sceneId,"请选择极限打孔的方式：")
--				AddNumText(sceneId, x000110_g_scriptId,"使用点金之箭打孔",6,206);
--				AddNumText(sceneId, x000110_g_scriptId,"使用寒玉精粹打孔",6,207);			
--			EndEvent(sceneId)
--			DispatchEventList(sceneId,selfId,targetId)
--			return
--		end	
--		if GetNumText() == 204 then
--			BeginUICommand( sceneId )
--				UICommand_AddInt( sceneId, targetId )
--			EndUICommand( sceneId )
--			DispatchUICommand( sceneId, selfId, 751107 )
--			return
--		end
--			
--		if GetNumText() == 205 then
--			BeginUICommand( sceneId )
--				UICommand_AddInt( sceneId, targetId )
--			EndUICommand( sceneId )
--			DispatchUICommand( sceneId, selfId, 25702 )
--			return
--		end			
		
		if GetNumText() == 206 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, targetId )
				UICommand_AddInt( sceneId, 1 )		 --打孔类型，1点金，2寒玉
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 75117 )
			return
		end		
		
		if GetNumText() == 207 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, targetId )
				UICommand_AddInt( sceneId, 2 )		 --打孔类型，1点金，2寒玉
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 75117 )
			return
		end		

end
