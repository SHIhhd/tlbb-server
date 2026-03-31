-- 005113
-- 齐煞云

--脚本号
x005113_g_scriptId = 005113

--所拥有的事件ID列表
x005113_g_eventList={402030}

--**********************************
--事件列表
--**********************************
function x005113_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  我从朝廷哪里接下来了剿灭镜湖水贼的任务，特招募天下各帮派的有志之士进行剿匪。")
	for i, eventId in x005113_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x005113_OnDefaultEvent( sceneId, selfId,targetId )
	x005113_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x005113_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x005113_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x005113_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x005113_g_eventList do
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
function x005113_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x005113_g_eventList do
		if missionScriptId == findId then
			x005113_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x005113_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x005113_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x005113_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x005113_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x005113_OnDie( sceneId, selfId, killerId )
end

--**********************************
--Monster Timer
--**********************************
function x005113_OnCharacterTimer( sceneId, objId, dataId, uTime )
	if sceneId ~= SCENE_JINGHU_HUANJING then
		return
	end
	local curTime = GetHour() * 100 + GetMinute();
	if curTime ~= 2030 then
		return
	end
	--BOSS已存在
	if x005113_IsHaveMonster( sceneId, 60000 ) == 1 then
		return
	end
	--创建BOSS
	local nMonId = CreateMonsterWithDir(sceneId,60000 , 230, 46, 19, -1, 005120,6.283)
	if nMonId ~= -1 then
		SetCharacterTitle(sceneId, nMonId, "“能屈能伸”")
		local str = "#P帝释天已经出现在#G镜湖·幻境（230，46）#P！请天下英雄速去剿灭！最后将其斩杀者朝廷将给予获得丰厚奖励！"
		AddGlobalCountNews(sceneId, str)
	end
end

--**********************************
--Monster 是否存在
--**********************************
function x005113_IsHaveMonster( sceneId, nDataId )
	local nMonsterNum = GetMonsterCount(sceneId)
	local bHaveMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetMonsterDataID(sceneId, nMonsterId)  == nDataId  then
			bHaveMonster = 1
		end
	end
	return bHaveMonster
end

