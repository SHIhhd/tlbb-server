-- 810102 宝箱

x810102_g_scriptId = 810102

--所拥有的事件ID列表用ID集合实现
x810102_g_LimitiBuffCollectionID = 75;

--100%掉落随机 1 件
x810102_g_LootItem = {
	--神魂檀箱
	{itemId = 38002499,itemCnt = 1},
	--魔尊魂武
	{itemId = 38000539,itemCnt = 1},
	--淬火玉
	{itemId = 38003055 ,itemCnt = 1},
	--灵级长春玉
	{itemId = 20600004,itemCnt = 1},
	--15朵玫瑰
	{itemId = 30509014,itemCnt = 1},
	--六合天缘匣
	{itemId = 38002986,itemCnt = 1},
	--奇闻小喇叭
	{itemId = 38003086,itemCnt = 1},
	--1W绑定元宝
	{itemId = 38002500,itemCnt = 1},
}

--**********************************
--事件列表
--**********************************
function x810102_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--特殊交互:条件判断
--**********************************
function x810102_OnActivateConditionCheck( sceneId, selfId, activatorId )
	-- 限制身上的buff
	local bOk = x810102_IsCanOpenBox( sceneId,activatorId )
	
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
function x810102_IsCanOpenBox( sceneId,activatorId )
	return 0==LuaFnHaveImpactInSpecificCollection(sceneId, activatorId, x810102_g_LimitiBuffCollectionID)
end

--**********************************
--特殊交互:消耗和扣除处理
--**********************************
function x810102_OnActivateDeplete( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:聚气类成功生效处理
--**********************************
function x810102_OnActivateEffectOnce( sceneId, selfId, activatorId )
	-- selfId == 宝箱Id
	-- activatorId == 开启人Id
	
	local x,z = GetWorldPos(sceneId, selfId)
	
	--kill大宝箱....大宝箱死亡动画为打开盖子....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 169, 0);
	LuaFnGmKillObj( sceneId, activatorId, selfId )
	
	-- 给开启成功的玩家一个掉落包
	local tItem = x810102_g_LootItem[random( getn(x810102_g_LootItem) )]
		
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
function x810102_OnActivateEffectEachTick( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互开始时的特殊处理
--**********************************
function x810102_OnActivateActionStart( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互撤消时的特殊处理
--**********************************
function x810102_OnActivateCancel( sceneId, selfId, activatorId )
	return 0
end

--**********************************
--特殊交互:交互中断时的特殊处理
--**********************************
function x810102_OnActivateInterrupt( sceneId, selfId, activatorId )
	
	return 0
end

function x810102_OnActivateInterrupt( sceneId, selfId, activatorId )

end

