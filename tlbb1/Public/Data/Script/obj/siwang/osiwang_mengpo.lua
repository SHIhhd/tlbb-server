--死亡场景NPC
--孟婆
--普通

x077001_g_scriptId=077001

--**********************************
--事件交互入口
--**********************************
function x077001_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"年轻人，再见！再见就是不见，回去后一切小心。你想去哪里？")
		
		--秦皇地宫活动
		if GetMissionFlagEx(sceneId,selfId,MFEX_DIE_INDIGONG4_HD) == 1 then
			AddNumText(sceneId,x077001_g_scriptId,"#{DLZX_230314_08}",9,6)
		end
		
		if  GetLevel( sceneId, selfId)<10	then			
			AddNumText(sceneId,x077001_g_scriptId,"大理",9,2)
		end
		
		if	GetLevel( sceneId, selfId)>=10	then			
			AddNumText(sceneId,x077001_g_scriptId,"洛阳",9,0)
			AddNumText(sceneId,x077001_g_scriptId,"苏州",9,1)
			AddNumText(sceneId,x077001_g_scriptId,"大理",9,2)		
		end
		
		if	GetLevel( sceneId, selfId)>=20	then
			AddNumText(sceneId,x077001_g_scriptId,"束河古镇",9,4)
		end
		
		if	GetLevel( sceneId, selfId)>=75	then
			AddNumText(sceneId,x077001_g_scriptId,"楼兰",9,5)
		end

		AddNumText(sceneId,x077001_g_scriptId,"#{DFBZ_081016_01}",11,3)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x077001_OnEventRequest( sceneId, selfId, targetId, eventId )

	-- 洛阳
	if	GetNumText()==0	then
		CallScriptFunction((400900), "TransferFunc", sceneId, selfId, 0,132,183, 10)
			
	-- 苏州
	elseif	GetNumText()==1	then
		CallScriptFunction((400900), "TransferFunc", sceneId, selfId, 1,114,162, 10)
	
	-- 大理
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFunc", sceneId, selfId, 2,241,138)

	-- 楼兰
	elseif	GetNumText()==5	then
		CallScriptFunction((400900), "TransferFunc", sceneId, selfId, 186, 288, 136, 75 )
	end

	if	GetNumText()==6 and GetMissionFlagEx(sceneId,selfId,MFEX_DIE_INDIGONG4_HD) == 1	then
		--秦宫秘境4
		BeginEvent( sceneId )
			AddText(sceneId,"年轻人，再见！再见就是不见，回去后一切小心。你想去哪里？")
			AddNumText( sceneId, x077001_g_scriptId, "#{MJXZ_210510_47}" ,9,41 )
			AddNumText( sceneId, x077001_g_scriptId, "#{MJXZ_210510_48}" ,9,42 )
			AddNumText( sceneId, x077001_g_scriptId, "#{MJXZ_210510_49}" ,9,43 )
			AddNumText( sceneId, x077001_g_scriptId, "#{MJXZ_210510_50}" ,9,44 )
			AddNumText( sceneId, x077001_g_scriptId, "#{MJXZ_210510_51}" ,9,45 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() >= 41 and GetNumText() <= 45 and GetMissionFlagEx(sceneId,selfId,MFEX_DIE_INDIGONG4_HD) == 1 then
		CallScriptFunction(893379, "EnterSceneSiCengRand", sceneId, selfId,GetNumText() - 28)
	end
	
	if	GetNumText()==3	then
		BeginEvent(sceneId)
			AddText( sceneId, "#{DFBZ_081016_02}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return	
	end
	
	-- 束河古镇
	if	GetNumText()==4	then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, x077001_g_scriptId);			
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "#{QZDZCS_100721}");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)
		return
	end
	
end

--**********************************
--传送至束河古镇
--**********************************
function x077001_GotoShuHeGuZhen( sceneId, selfId, targetId )
	CallScriptFunction((400900), "TransferFuncFromNpc", sceneId, selfId, 420, 200, 211, 20 );
	return
end
