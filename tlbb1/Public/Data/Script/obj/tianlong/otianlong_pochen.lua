--天龙NPC
--破嗔
--普通

--脚本号
x013005_g_ScriptId = 013005
--所拥有的事件ID列表
x013005_g_eventList = {
	--武道任务
	891279,
	--玄武岛
	400918,
}	

--门派信息(门派名称，SceneID，PosX，PosY，门派ID)
x013005_g_mpInfo		= {}
x013005_g_mpInfo[0]	= { "星宿", 16,  96, 152, MP_XINGSU }
x013005_g_mpInfo[1]	= { "逍遥", 14,  67, 145, MP_XIAOYAO }
x013005_g_mpInfo[2]	= { "少林",  9,  95, 137, MP_SHAOLIN }
x013005_g_mpInfo[3]	= { "天山", 17,  95, 120, MP_TIANSHAN }
x013005_g_mpInfo[4]	= { "天龙", 13,  96, 120, MP_DALI }
x013005_g_mpInfo[5]	= { "峨嵋", 15,  89, 144, MP_EMEI }
x013005_g_mpInfo[6]	= { "武当", 12, 103, 140, MP_WUDANG }
x013005_g_mpInfo[7]	= { "明教", 11,  98, 167, MP_MINGJIAO }
x013005_g_mpInfo[8]	= { "丐帮", 10,  91, 116, MP_GAIBANG }
x013005_g_mpInfo[10] = { "曼陀", SCENE_MANTUOSHANZHUANG,  139, 162, MP_MANTUO }
x013005_g_mpInfo[11] = { "恶人谷", 504,  122, 151, MP_ERENGU }

--**********************************
--事件列表
--**********************************
function x013005_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPXL_090113_02}")
		if	GetLevel( sceneId, selfId)>=10  then	
			AddNumText(sceneId,x013005_g_ScriptId,"洛阳",9,0)
			AddNumText(sceneId,x013005_g_ScriptId,"苏州",9,1)
			AddNumText( sceneId, x013005_g_ScriptId, "洛阳 - 九州商会", 9, 3 )
			AddNumText( sceneId, x013005_g_ScriptId, "苏州 - 铁匠铺", 9, 4 )
		end
		
		--add by WTT
		if	GetLevel( sceneId, selfId)>=20  then	
			AddNumText( sceneId, x013005_g_ScriptId, "束河古镇", 9, 6 )
		end
		
		if	GetLevel( sceneId, selfId)>=75  then	
			AddNumText( sceneId, x013005_g_ScriptId, "#{MPCSLL_80925_01}", 9, 5 )
		end
		AddNumText(sceneId,x013005_g_ScriptId,"大理",9,2)
		
		for i, eventId in x013005_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddNumText(sceneId,x013005_g_ScriptId,"带我去其他门派吧",9,11)
	
		-- 我怎样才能去敦煌和嵩山
		if GetLevel(sceneId,selfId) < 30 then
			AddNumText( sceneId, x013005_g_ScriptId, "我怎样才能去敦煌和嵩山", 11, 2000 )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x013005_OnDefaultEvent( sceneId, selfId,targetId )
	x013005_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x013005_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	for i, findId in x013005_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x013005_g_ScriptId )
			return
		end
	end
	
	if GetNumText() == 2000 then		--
		BeginEvent( sceneId )
			AddText( sceneId, "#{GOTO_DUNHUANF_SONGSHAN}" ) 
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		
		return
	end
  
    if  GetNumText() == 11 then
        
		BeginEvent(sceneId)
		    for i, mp in x013005_g_mpInfo do
				AddNumText( sceneId, x013005_g_ScriptId, "门派 - "..mp[1], 9, i+12 )
			end		
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)	
		return 
    end
    
    num = GetNumText()

 	if num > 11 then
 		-- 检测玩家身上是不是有113号BUFF
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113) == 1   then
			BeginEvent( sceneId )
				AddText( sceneId, "  处于漕运，跑商状态是不能从我这里传送的" ) 
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			
			return
 		end
 	
 	    i = num - 12
		CallScriptFunction( (400900), "TransferFuncFromNpc", sceneId, selfId, x013005_g_mpInfo[i][2], x013005_g_mpInfo[i][3], x013005_g_mpInfo[i][4] )
		return
	end
------------------------------------------------------------------------------------------ 

	if	GetNumText()==0	then
		CallScriptFunction((400900), "TransferFuncFromNpc",sceneId, selfId, 0,132,183, 10)
	elseif	GetNumText()==1	then
		CallScriptFunction((400900), "TransferFuncFromNpc",sceneId, selfId, 1,114,162, 10)
	elseif	GetNumText()==3	then
		CallScriptFunction((400900), "TransferFuncFromNpc",sceneId, selfId, 0,234,132, 10)
	elseif	GetNumText()==4	then
		CallScriptFunction((400900), "TransferFuncFromNpc",sceneId, selfId, 1,235,132, 10)
	elseif	GetNumText()==2	then
		CallScriptFunction((400900), "TransferFuncFromNpc",sceneId, selfId, 2,241,141)
	elseif  GetNumText()==5	then
		CallScriptFunction((400900), "TransferFuncFromNpc",sceneId, selfId, 186,288,136,75)
	end
	
	--add by WTT
	if GetNumText()== 6 then					--束河古镇		
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, x013005_g_ScriptId);			
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "#{QZDZCS_100721}");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)
		return
	end	
	
	
end

--**********************************
--接受此NPC的任务
--**********************************
function x013005_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x013005_g_eventList do
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
function x013005_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x013005_g_eventList do
		if missionScriptId == findId then
			x013005_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x013005_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x013005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x013005_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x013005_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x013005_OnDie( sceneId, selfId, killerId )
end

--add by WTT
function x013005_GotoShuHeGuZhen( sceneId, selfId, targetId )
	CallScriptFunction((400900), "TransferFuncFromNpc", sceneId, selfId, 420, 200, 211, 20 );
	return
end

