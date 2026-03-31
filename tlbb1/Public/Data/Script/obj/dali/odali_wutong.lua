--大理NPC
--武桐

--脚本号
x002098_g_ScriptId = 002098

--所拥有的事件ID列表
x002098_g_eventList={}

--x002098_g_GhostItem = {20310117,20310118,20310119,20310120,20310121,20310161,20310162,20310163,20310164,20310165}
--**********************************
--事件列表
--**********************************
function x002098_UpdateEventList( sceneId, selfId,targetId )

    local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
		AddText(sceneId,"师傅一个人的时候，我常看到他对着一幅画像发呆，难道说这就是他们说的大人们的烦恼？")
		for i, eventId in x002098_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end	
		AddNumText(sceneId,x002098_g_ScriptId,"延长武魂寿命",6,1)  ---
		AddNumText(sceneId,x002098_g_ScriptId,"删除武魂拓展属性",6,2)
		AddNumText(sceneId,x002098_g_ScriptId,"润魂石合成",6,3)
		AddNumText(sceneId,x002098_g_ScriptId,"魂冰珠合成",6,4)
		--AddNumText(sceneId,x002098_g_ScriptId,"改变武魂属相",6,5)
		AddNumText(sceneId,x002098_g_ScriptId,"#{WHXCZL_xml_XX(01)}",6,6)
		
		AddNumText(sceneId,x002098_g_ScriptId,"关于延长武魂寿命",11,7)
		AddNumText(sceneId,x002098_g_ScriptId,"关于删除武魂拓展属性",11,8)
		--AddNumText(sceneId,x002098_g_ScriptId,"关于武魂道具的合成",11,9)
		AddNumText(sceneId,x002098_g_ScriptId,"关于改变武魂属相",11,10)
		AddNumText(sceneId,x002098_g_ScriptId,"关于重洗武魂成长率",11,11)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002098_OnDefaultEvent( sceneId, selfId,targetId )
	x002098_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002098_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002098_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end

	if GetNumText() == 1 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,3)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090721)
	elseif GetNumText() == 2 then 
	    BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090727)
	elseif GetNumText() == 3 then
		--润魂石合成界面
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,1)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,2016110701)
	elseif GetNumText() == 4 then
		--v3版本魂冰珠合成
		---- 0 关闭, 1 打开, 2 刷新, 3 二次确认框
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,1)
	        UICommand_AddInt(sceneId,targetId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,79007501)
--		BeginEvent(sceneId)
--		local HBZNum = 1
--		for i = 1,4 do
--			AddNumText(sceneId,x002098_g_ScriptId,"合成魂冰珠（"..tostring(i + 1).."级）",6,200 + i + 1)
--		end
--		AddNumText(sceneId,x002098_g_ScriptId,"返回上一页",8,100)
--		EndEvent(sceneId)
--		DispatchEventList(sceneId,selfId,targetId)
--	elseif GetNumText() == 5 then
--		BeginUICommand(sceneId)
--		    UICommand_AddInt(sceneId,targetId)
--	        UICommand_AddInt(sceneId,3)
--			UICommand_AddString(sceneId,"#{WHYH_161121_94}")
--        EndUICommand(sceneId)
--        DispatchUICommand(sceneId,selfId,20090722)
	elseif GetNumText() == 6 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{WHXCZL_091026_01}" )
			AddNumText(sceneId,x002098_g_ScriptId,"#{WHXCZL_xml_XX(04)}",6,12)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 7 then--开始介绍
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090909_06}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 8 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090909_07}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 10 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WHGBSX_091015_01}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 11 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WHXCZL_091026_02}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 12 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,5)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090722)
	elseif GetNumText() == 100 then		
		x002098_OnDefaultEvent( sceneId, selfId,targetId )
--    elseif GetNumText() >= 200 and GetNumText() <= 205 then
--		BeginEvent(sceneId)
--		if GetNumText() == 202 then
--			AddText(sceneId,"#{WU_090908_05}")
--			AddNumText(sceneId,x002098_g_ScriptId,"我要合成",6,206)
--		elseif GetNumText() == 203 then
--			AddText(sceneId,"#{WU_090908_06}")
--			AddNumText(sceneId,x002098_g_ScriptId,"我要合成",6,207)
--	    elseif GetNumText() == 204 then
--			AddText(sceneId,"#{WU_090908_07}")
--			AddNumText(sceneId,x002098_g_ScriptId,"我要合成",6,208)
--	    elseif GetNumText() == 205 then
--		    AddText(sceneId,"#{WU_090908_08}")
--			AddNumText(sceneId,x002098_g_ScriptId,"我要合成",6,209)
--		end
--		AddNumText(sceneId,x002098_g_ScriptId,"取消",8,100)
--	    EndEvent(sceneId)
--		DispatchEventList(sceneId,selfId,targetId)
--    elseif GetNumText() == 206 then
--		x002098_CombineHunBingZhu(sceneId,selfId,targetId,1)
--	elseif GetNumText() == 207 then
--		x002098_CombineHunBingZhu(sceneId,selfId,targetId,2)
--	elseif GetNumText() == 208 then
--		x002098_CombineHunBingZhu(sceneId,selfId,targetId,3)
--	elseif GetNumText() == 209 then
--		x002098_CombineHunBingZhu(sceneId,selfId,targetId,4)
	end
	
end
--**********************************
--合成魂冰珠
--**********************************
--function x002098_CombineHunBingZhu(sceneId,selfId,targetId,nIndex)
--	--x002098_NotifyTip( sceneId, selfId,  "#G您身上不足#{_MONEY5000}，无法进行操作！" )
--	if nIndex < 1 or nIndex > 4 then
--	    return
--	end
--	local needMoney = 0
--	if nIndex == 1 or nIndex == 2 then
--	    needMoney = 5000
--	elseif nIndex == 3 or nIndex == 4 then
--		needMoney = 10000
--	end
--	local nMoneyJB = GetMoney(sceneId,selfId)
--	if nMoneyJB < needMoney then
--        x002098_NotifyTip( sceneId, selfId,  "#G您身上不足#{_MONEY"..tostring(needMoney).."}，无法进行操作！" )
--	    return
--	end
--	
--	local NextConItem,DelItem,ConNum,AddNum,AddNum2,AddNum3 = 0,0,0,0,0,0,0
--	local BackItemNum,BackItemNum2 ={},{}
--	local ConItem = LuaFnMtl_GetCostNum(sceneId,selfId,x002098_g_GhostItem[nIndex],x002098_g_GhostItem[nIndex + 5])
--	if ConItem < 5 then
--		x002098_NotifyTip( sceneId, selfId, "对不起，你身上没有足够的#{_ITEM"..x002098_g_GhostItem[nIndex].."}，或道具被加锁。")
--		return
--	end
--	local nRet = LuaFnMtl_CostMaterial(sceneId,selfId,5,x002098_g_GhostItem[nIndex],x002098_g_GhostItem[nIndex + 5])
--	if nRet ~= 1 then
--		BeginEvent( sceneId )
--			AddText( sceneId, StringTable_GetData(347) )
--		EndEvent( sceneId )
--		DispatchMissionTips( sceneId, selfId )
--		return
--	end
--	TryRecieveItem( sceneId, selfId, x002098_g_GhostItem[nIndex + 1], 1 )
--    LuaFnCostMoney( sceneId, selfId, needMoney );
--	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
--    x002098_NotifyTip( sceneId, selfId, "你合成了一个#{_ITEM"..x002098_g_GhostItem[nIndex + 1].."}！" )
--end
--**********************************
--醒目提示
--**********************************
function x002098_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- --对话窗口信息提示
--**********************************
function x002098_NotifyFailBox( sceneId, selfId,  msg )
	BeginEvent( sceneId )
		AddText( sceneId,msg)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end