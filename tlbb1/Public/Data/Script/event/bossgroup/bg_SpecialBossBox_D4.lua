-- 810114 宝箱

x810114_g_scriptId = 810114

--所拥有的事件ID列表用ID集合实现
x810114_g_LimitiBuffCollectionID = 75;

--100%掉落随机 1 件
x810114_g_LootItem = {
	--魔尊魂武
	{itemId = 38000540,itemCnt = 10},
	--淬火玉
	{itemId = 38003055 ,itemCnt = 20},
	--灵级长春玉
	{itemId = 20600004,itemCnt = 10},
	--15朵玫瑰
	{itemId = 30509014,itemCnt = 20},
	--3级秘银
	{itemId = 20502003,itemCnt = 30},
	--3级棉布
	{itemId = 20501003,itemCnt = 30},
}

--**********************************
--事件列表
--**********************************
function x810114_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--特殊交互:条件判断
--**********************************
function x810114_OnActivateConditionCheck( sceneId, selfId, activatorId )
	-- 限制身上的buff
	local bOk = x810114_IsCanOpenBox( sceneId,activatorId )
	
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
function x810114_IsCanOpenBox( sceneId,activatorId )
	return 0==LuaFnHaveImpactInSpecificCollection(sceneId, activatorId, x810114_g_LimitiBuffCollectionID)
end

--**********************************
--特殊交互:消耗和扣除处理
--**********************************
function x810114_OnActivateDeplete( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:聚气类成功生效处理
--**********************************
function x810114_OnActivateEffectOnce( sceneId, selfId, activatorId )
	-- selfId == 宝箱Id
	-- activatorId == 开启人Id
	
	local x,z = GetWorldPos(sceneId, selfId)
	
	--kill大宝箱....大宝箱死亡动画为打开盖子....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 169, 0);
	LuaFnGmKillObj( sceneId, activatorId, selfId )
	
	-- 给开启成功的玩家一个掉落包
	local tItem = x810114_g_LootItem[random( getn(x810114_g_LootItem) )]
		
	local nBoxId = DropBoxEnterSceneEx(	x,z,sceneId,LuaFnGetGUID(sceneId,activatorId))
	if nBoxId > -1  then
		for i = 1,tItem.itemCnt do
			AddMutilItemToBox(sceneId,nBoxId,tItem.itemId,1,QUALITY_CREATE_BY_BOSS)
		end
	end
	
	-- 在这里记录开启宝箱的日志
	LuaFnAuditPlayerBehavior(sceneId, activatorId, "开启D4BOSS宝箱");
	
	return 1
end

--**********************************
--特殊交互:引导类每时间间隔生效处理
--**********************************
function x810114_OnActivateEffectEachTick( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互开始时的特殊处理
--**********************************
function x810114_OnActivateActionStart( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互撤消时的特殊处理
--**********************************
function x810114_OnActivateCancel( sceneId, selfId, activatorId )
	return 0
end

--**********************************
--特殊交互:交互中断时的特殊处理
--**********************************
function x810114_OnActivateInterrupt( sceneId, selfId, activatorId )
	
	return 0
end

function x810114_OnActivateInterrupt( sceneId, selfId, activatorId )

end

