-- odali_jianning

--脚本号
x002108_g_scriptId = 002108

--所拥有的事件ID列表
x002108_g_eventList = {210209}

--**********************************
--事件列表
--**********************************
function x002108_UpdateEventList(sceneId, selfId, targetId)

	Menpai = LuaFnGetMenPai(sceneId, selfId)
	PlayerSex = GetSex(sceneId, selfId)

	if PlayerSex == 0 then
		PlayerSex = "丫头"
	else
		PlayerSex = "兄弟"
	end

	BeginEvent(sceneId)

	if Menpai == 9 then
		AddText(sceneId, "#{XKDRZ_240619_01}")
	elseif Menpai == 11 then
		AddText(sceneId, "  " .. PlayerSex .. "，许久不见，你的武功又精进不少。怎样，俗话说云雀亦有归巢日，偶尔也回恶人谷露个面吧。")
	else
		AddText(sceneId, "#{XKDRZ_240619_05}")
	end

	-- 注意：这里保持你Lua5原逻辑：>=10 才给“去恶人谷看看”
	if GetLevel(sceneId, selfId) >= 10 then
		AddNumText(sceneId, x002108_g_scriptId, "去恶人谷看看", 9, 0)
	end

	for i, eventId in x002108_g_eventList do
		CallScriptFunction(eventId, "OnEnumerate", sceneId, selfId, targetId)
	end

	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002108_OnDefaultEvent(sceneId, selfId, targetId)
	x002108_UpdateEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x002108_OnEventRequest(sceneId, selfId, targetId, eventId)

	if GetNumText() == 0 then
		if IsHaveMission(sceneId, selfId, 4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId, "你有漕运货舱在身，我们驿站不能为你提供传送服务。")
			EndEvent(sceneId)
			DispatchEventList(sceneId, selfId, targetId)
		else
			CallScriptFunction((400900), "TransferFunc", sceneId, selfId, 504, 123, 151)
		end

	elseif GetNumText() == 10 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{XKDRZ_240619_47}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)

	elseif GetNumText() == 11 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{XKDRZ_240619_48}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)

	elseif GetNumText() == 12 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{XKDRZ_240619_49}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)

	elseif GetNumText() == 13 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{XKDRZ_240619_50}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)

	elseif GetNumText() == 14 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{XKDRZ_240626_1}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)

	else
		for i, findId in x002108_g_eventList do
			if eventId == findId then
				CallScriptFunction(eventId, "OnDefaultEvent", sceneId, selfId, targetId)
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002108_OnMissionAccept(sceneId, selfId, targetId, missionScriptId)
	for i, findId in x002108_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction(missionScriptId, "CheckAccept", sceneId, selfId)
			if ret > 0 then
				CallScriptFunction(missionScriptId, "OnAccept", sceneId, selfId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002108_OnMissionRefuse(sceneId, selfId, targetId, missionScriptId)
	for i, findId in x002108_g_eventList do
		if missionScriptId == findId then
			x002108_UpdateEventList(sceneId, selfId, targetId)
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002108_OnMissionContinue(sceneId, selfId, targetId, missionScriptId)
	for i, findId in x002108_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction(missionScriptId, "OnContinue", sceneId, selfId, targetId)
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002108_OnMissionSubmit(sceneId, selfId, targetId, missionScriptId, selectRadioId)
	for i, findId in x002108_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction(missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId)
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002108_OnDie(sceneId, selfId, killerId)
end
