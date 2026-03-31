--丫鬟

--脚本号
x020004_g_scriptId = 020004
x020004_g_HusongScript = 006671
x020004_g_HusongList = {1050000}
--**********************************
--事件列表
--**********************************
function x020004_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = "姑娘"
		else
			PlayerSex = "少侠"
		end
		AddText(sceneId,"  "..PlayerSex.."#{OBJ_caoyuan_0005}")
		for i, Husongidx in x020004_g_HusongList do
			CallScriptFunction( x020004_g_HusongScript, "OnEnumerate",sceneId, selfId, targetId ,Husongidx)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x020004_OnDefaultEvent( sceneId, selfId,targetId )
	x020004_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x020004_OnEventRequest( sceneId, selfId, targetId, eventId )
	--配表任务
	for i, Husongidx in x020004_g_HusongList do
		if eventId == x020004_g_HusongScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Husongidx)
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x020004_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i, Husongidx in x020004_g_HusongList do
		if missionScriptId == x020004_g_HusongScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Husongidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId ,Husongidx)
			end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x020004_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x020004_g_eventList do
		if missionScriptId == findId then
			x020004_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x020004_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i, Husongidx in x020004_g_HusongList do
		if missionScriptId == x020004_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Husongidx)
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x020004_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i, Husongidx in x020004_g_HusongList do
		if missionScriptId == x020004_g_HusongScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Husongidx)
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x020004_OnDie( sceneId, selfId, killerId )
end
