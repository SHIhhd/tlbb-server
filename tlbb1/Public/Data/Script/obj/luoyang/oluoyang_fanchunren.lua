--洛阳NPC
--范纯仁
--建立帮会
--脚本号
x000030_g_scriptId = 000030

--所拥有的事件ID列表
x000030_g_eventList={600000}
x000030_g_DeliveryScript = 006668
x000030_g_DeliveryList = {1018714}
--**********************************
--事件交互入口
--**********************************
function x000030_OnDefaultEvent( sceneId, selfId,targetId )
	local MyGuildID = GetHumanGuildID(sceneId, selfId)
	BeginEvent(sceneId)
		AddText(sceneId,"  想要创建帮会就来找我吧！")
	AddNumText( sceneId, x000030_g_scriptId, "帮会与领地介绍", 11, 10 )
	AddNumText(sceneId,x000030_g_scriptId,"查看帮会列表",6,2)	
	if IsShutout( sceneId, selfId, ONOFF_T_GUILD ) == 0 and MyGuildID == -1 then
		AddNumText(sceneId,x000030_g_scriptId,"创建帮会",6,1)
	end
	AddNumText(sceneId,x000030_g_scriptId,"管理帮会会员信息",6,3)
	AddNumText(sceneId,x000030_g_scriptId,"查看本帮详细资讯",6,4)
	if(GetHumanGuildID(sceneId, selfId) ~= -1) then
		if IsShutout( sceneId, selfId, ONOFF_T_CITY ) == 0 then
			AddNumText(sceneId,x000030_g_scriptId,"申请城市",6,5)
		end
		if(CityGetSelfCityID(sceneId, selfId) ~= -1) then
			AddNumText(sceneId,x000030_g_scriptId,"进入本帮城市",9,6)
		end
		if GetGuildPos(sceneId, selfId) == 9 then
			AddNumText(sceneId,x000030_g_scriptId,"解散帮会",6,13)
		end
	end
	AddNumText(sceneId,x000030_g_scriptId,"关于帮派繁荣度",11,11)
	AddNumText(sceneId,x000030_g_scriptId,"同盟介绍",11,12)
	for i,Deliveryidx in x000030_g_DeliveryList do
		CallScriptFunction( x000030_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x000030_DestroyGuild( sceneId, selfId)
	--安全时间检查
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x000030_NotifyFailTips( sceneId, selfId, "#{HJYH_151202_36}" )   
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			return                        
		end
	end
	
	--帮主才有权限
	if GetGuildPos(sceneId, selfId) == 9 then
		--解散帮会
		LuaFnDestroyGuild(sceneId,selfId)
		x000030_CloseMe(sceneId, selfId)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	else
		x000030_NotifyFailTips( sceneId, selfId, "没有操作权限" )   
	end
end

function x000030_OnEventRequest( sceneId, selfId, targetId, eventId )

	--解散帮会(第一层警告) 雪舞 2025-02-26
	if GetNumText() == 13 or GetNumText() == 14 then
		--安全时间检查
		if IsPilferLockFlag(sceneId,selfId) <= 0 then
			x000030_NotifyFailTips( sceneId, selfId, "#{HJYH_151202_36}" )   
			return
		end
		--需要二级密码
		if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
			if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
				return                        
			end
		end
		if GetNumText() == 13  then
			BeginEvent(sceneId)	
				AddText( sceneId, "#Y【警告】您正在申请解散帮会！#r"
            .. "#r此操作#R不可撤销#W，执行后将会：#r"
            .. "#r#cfabf8f  ● 帮会从江湖中永久除名#r"
            .. "#cfabf8f  ● 所有成员将被遣散#r"
            .. "#cfabf8f  ● 帮会资金全部清空#r"
            .. "#cfabf8f  ● 帮会领地将被收回#r"
            .. "#r#Y确定要继续吗？" )
				AddNumText(sceneId, x000030_g_scriptId, "#R确认解散帮会", 6, 14)		
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
		--第二层弹窗通知
		if GetNumText() == 14  then
			BeginUICommand( sceneId )
				UICommand_AddString(sceneId, LuaFnGetGuildName( sceneId,selfId));
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20250829 )
		end
	end
	
	if GetNumText() == 10 then
		BeginEvent(sceneId)		
			AddText( sceneId, "#{function_help_069}" )				
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 11 then
		BeginEvent(sceneId)			
			AddText( sceneId, "#{Guild_Boom_Help}" )					
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 12 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{TM_20080331_07}".."#{TM_20080320_02}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	local sel = GetNumText();
	--配表任务
	for i,Deliveryidx in x000030_g_DeliveryList do
		if eventId == x000030_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, eventId in x000030_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId, sel)
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x000030_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x000030_g_DeliveryList do
		if missionScriptId == x000030_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000030_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000030_g_eventList do
		if missionScriptId == findId then
			x000030_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000030_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x000030_g_DeliveryList do
		if missionScriptId == x000030_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000030_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x000030_g_DeliveryList do
		if missionScriptId == x000030_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000030_OnDie( sceneId, selfId, killerId )
end

--**********************************
--关闭对话框
--**********************************
function x000030_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x000030_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end