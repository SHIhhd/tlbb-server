--南海NPC
--岳仲秋
--普通

--脚本号
x034003_g_ScriptId = 34003
x034003_g_eventList={}--211101}	
x034003_g_LootItemscript = 006667
x034003_g_LootItemList = {1030191}
--**********************************
--事件交互入口
--**********************************
function x034003_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  以前的时候，鳄鱼帮也挺好的，只是行为乖张一些罢了，没做过什么大的坏事。可是，渐渐的，不知道怎么回事，那些孩子开始总是惹祸，做错了事情还不认错，唉……真是造孽啊……")
		
		-- 如果玩家身上有“长白————天涯海角”，这个任务，可以在这里获得道具
		if IsHaveMission(sceneId,selfId,568) > 0 then
			-- 判定玩家身上是不是有物品了 
			local itemCount
			itemCount = GetItemCount( sceneId, selfId, 40001039 )
			if itemCount < 1   then
				AddNumText(sceneId,x034003_g_ScriptId,"得到一块异种树皮",7,666);
			end
		end
		for i, LootItemidx in x034003_g_LootItemList do
			CallScriptFunction( x034003_g_LootItemscript, "OnEnumerate",sceneId, selfId, targetId ,LootItemidx)
		end
		for i, eventId in x034003_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x034003_OnDefaultEvent( sceneId, selfId,targetId )
	x034003_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x034003_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==666	then
		local itemCount
		itemCount = GetItemCount( sceneId, selfId, 40001039 )
		if itemCount < 1   then
			BeginAddItem( sceneId )
				AddItem( sceneId, 40001039, 1 )
			local ret = EndAddItem( sceneId, selfId )
			if ret <= 0 then 
				--提示不能接任务了
				Msg2Player(  sceneId, selfId,"#Y你的任务背包已经满了。", MSG2PLAYER_PARA )
			else
				AddItemListToHuman(sceneId,selfId)
			end
		end
	end
	for i, LootItemidx in x034003_g_LootItemList do
		if eventId == x034003_g_LootItemscript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x034003_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x034003_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i, LootItemidx in x034003_g_LootItemList do
		if missionScriptId == x034003_g_LootItemscript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId ,LootItemidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept",sceneId, selfId,LootItemidx)
			end
		end
	end
	for i, findId in x034003_g_eventList do
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
function x034003_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x034003_g_eventList do
		if missionScriptId == findId then
			x034003_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x034003_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, LootItemidx in x034003_g_LootItemList do
		if missionScriptId == x034003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId, targetId ,LootItemidx)
		end
	end
	for i, findId in x034003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x034003_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, LootItemidx in x034003_g_LootItemList do
		if missionScriptId == x034003_g_LootItemscript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId, targetId ,selectRadioId,LootItemidx)
		end
	end
	for i, findId in x034003_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x034003_OnDie( sceneId, selfId, killerId )
end
