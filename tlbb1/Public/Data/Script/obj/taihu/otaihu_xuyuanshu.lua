--太湖许愿树
x004112_g_ScriptId = 004112
x004112_g_eventList = {808134}
--**********************************
--事件交互入口
--**********************************
function x004112_UpdateEventList( sceneId, selfId,targetId )
	local nWishcount = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_WISHES_1001Count)
	BeginEvent(sceneId)
		AddText(sceneId,"#{SQXY_09061_37}"..nWishcount.."#{SQXY_09061_38}")
		for _,eventId in x004112_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddNumText( sceneId, x004112_g_ScriptId,"#{SQXY_09061_6}",11,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x004112_OnEventRequest( sceneId, selfId, targetId, eventId )
end

--**********************************
--事件交互入口
--**********************************
function x004112_OnDefaultEvent( sceneId, selfId,targetId )
	x004112_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x004112_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumText = GetNumText()
	if nNumText == 1 then
		x004112_MsgBox(sceneId,selfId,targetId,"#{SQXY_09061_40}")
		return
	end
	for i, findId in x004112_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x004112_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x004112_g_eventList do
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
function x004112_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x004112_g_eventList do
		if missionScriptId == findId then
			x004112_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x004112_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x004112_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x004112_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x004112_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end
--**********************************
-- 许愿树达到次数变身发送动作
--**********************************
function x004112_CreateMonster( sceneId, selfId,nIndex)
	local nMonsterNum = GetMonsterCount(sceneId)
	local Isok = 0;
	for i = 0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID(sceneId,MonsterId)
		--只要一次达到1001就不再创建后续了，以重启为准，重启之后重置。
		if MosDataID == 13293 then
			return
		end
		if nIndex == 2 then
			if MosDataID == 13291 then
				LuaFnDeleteMonster(sceneId,MonsterId)
				break
			end
		elseif nIndex == 3 then
			if MosDataID == 13292 then
				LuaFnDeleteMonster(sceneId,MonsterId)
				break
			end
		end
	end
	if nIndex == 1 then
		CreateMonsterWithDir(sceneId, 13291, 159, 187, 3, -1, x004112_g_ScriptId,9.45)
	elseif nIndex == 2 then
		CreateMonsterWithDir(sceneId, 13292, 159, 187, 3, -1, x004112_g_ScriptId,9.45)
	elseif nIndex == 3 then
		CreateMonsterWithDir(sceneId, 13293, 159, 187, 3, -1, x004112_g_ScriptId,9.45)
	end
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x004112_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**************************************************************************
--对话
--**************************************************************************
function x004112_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
