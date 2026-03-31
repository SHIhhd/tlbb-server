-- 005121 宝箱

x005121_g_scriptId = 005121

--所拥有的事件ID列表用ID集合实现
x005121_g_LimitiBuffCollectionID = 75;

--100%掉落随机 1 件
x005121_g_LootItem = {
	--兔兔的书签
	{itemId = 38002809,itemCnt = 5},
	--沉木纹艺匣
	{itemId = 38003165,itemCnt = 10},
}

--**********************************
--事件列表
--**********************************
function x005121_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--特殊交互:条件判断
--**********************************
function x005121_OnActivateConditionCheck( sceneId, selfId, activatorId )
	-- 限制身上的buff
	local bOk = x005121_IsCanOpenBox( sceneId,activatorId )
	
	if bOk == 0  then
		BeginEvent(sceneId)
		  AddText(sceneId,"你现在不能开启这个宝箱。");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,activatorId,selfId)
	end
	
	return bOk
end

--**********************************
-- 检测当前玩家身上的buff，能不能开启宝箱
--**********************************
function x005121_IsCanOpenBox( sceneId,activatorId )
	return 0==LuaFnHaveImpactInSpecificCollection(sceneId, activatorId, x005121_g_LimitiBuffCollectionID)
end

--**********************************
--特殊交互:消耗和扣除处理
--**********************************
function x005121_OnActivateDeplete( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:聚气类成功生效处理
--**********************************
function x005121_OnActivateEffectOnce( sceneId, selfId, activatorId )
	-- selfId == 宝箱Id
	-- activatorId == 开启人Id
	
	local x,z = GetWorldPos(sceneId, selfId)
	
	--kill大宝箱....大宝箱死亡动画为打开盖子....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 169, 0);
	LuaFnGmKillObj( sceneId, activatorId, selfId )
	
	-- 给开启成功的玩家一个掉落包
	local tItem = x005121_g_LootItem[random( getn(x005121_g_LootItem) )]
		
	local nBoxId = DropBoxEnterSceneEx(	x,z,sceneId,LuaFnGetGUID(sceneId,activatorId))
	if nBoxId > -1  then
		for i = 1,tItem.itemCnt do
			AddMutilItemToBox(sceneId,nBoxId,tItem.itemId,1,QUALITY_CREATE_BY_BOSS)
		end
	end
	
	-- 在这里记录开启宝箱的日志
	LuaFnAuditPlayerBehavior(sceneId, activatorId, "开启特殊BOSS宝箱");
	
	return 1
end

--**********************************
--特殊交互:引导类每时间间隔生效处理
--**********************************
function x005121_OnActivateEffectEachTick( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互开始时的特殊处理
--**********************************
function x005121_OnActivateActionStart( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互撤消时的特殊处理
--**********************************
function x005121_OnActivateCancel( sceneId, selfId, activatorId )
	return 0
end

--**********************************
--特殊交互:交互中断时的特殊处理
--**********************************
function x005121_OnActivateInterrupt( sceneId, selfId, activatorId )
	
	return 0
end

function x005121_OnActivateInterrupt( sceneId, selfId, activatorId )

end

