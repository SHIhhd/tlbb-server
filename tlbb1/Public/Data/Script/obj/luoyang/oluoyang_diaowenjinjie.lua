--脚本号
x890305_g_scriptId = 890305
--所拥有的事件ID列表
x890305_g_eventList={
	--新版本引导任务
	998793
}
--**********************************
--事件交互入口
--**********************************
function x890305_UpdateEventList( sceneId, selfId, targetId)
	local targetName = GetName(sceneId,targetId)
	BeginEvent(sceneId)  
		if targetName == "张伏虎" then
			AddText(sceneId, "#{DWJJ_240329_04}")
			--关于雕纹精绘
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_11}", 11, 0)
			--雕纹精绘
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_05}", 6, 1)
			--雕纹精绘升级
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_06}", 6, 2)
			--雕纹精绘复旧
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_08}", 6, 4)
		elseif targetName == "张笑狮" then
			AddText(sceneId, "#{DWJJ_240329_195}")
			--关于雕纹纹刻
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_193}", 11, 8)
			--关于如何获取纹刻玉版
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_355}", 11, 9)
			--雕纹纹刻升级
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_67}", 6, 5)
			--雕纹纹刻更换
			AddNumText(sceneId, x890305_g_scriptId,"#{DWJJ_240329_196}", 6, 6)
		end
		for i, eventId in x890305_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x890305_OnDefaultEvent( sceneId, selfId,targetId )
	x890305_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x890305_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key=GetNumText()
	if key==1 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89030501)
	elseif key==2 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89030502)
	elseif key==4 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89030504)
	elseif key==5 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)			--open
			UICommand_AddInt(sceneId,targetId)	--targetId
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89030506)
	elseif key==6 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 89030505)	
	elseif key==0 then
		BeginEvent(sceneId)     
			AddText(sceneId, "#{DWJJ_240329_351}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif key==8 then
		BeginEvent(sceneId)     
			AddText(sceneId, "#{DWJJ_240329_194}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif key==9 then
		BeginEvent(sceneId)     
			AddText(sceneId, "#{DWJJ_240329_356}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	for i, findId in x890305_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x890305_g_scriptId )
		return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x890305_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890305_g_eventList do
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
function x890305_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x890305_g_eventList do
		if missionScriptId == findId then
			x890305_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x890305_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x890305_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x890305_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x890305_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end
--**********************************
--醒目提示
--**********************************
function x890305_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--关闭对话框
--**********************************
function x890305_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end