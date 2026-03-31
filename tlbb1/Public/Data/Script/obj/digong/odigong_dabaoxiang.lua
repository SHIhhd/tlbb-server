--秦皇宝箱

--脚本号
x893397_g_ScriptId	= 893397
--军功令
x893397_g_CostItem = 38002668
x893397_g_CostCount = 150
--必掉落物品
x893397_g_DropItemMust = {
	--玲珑晶石
	{itemid = 38002262,minNum = 10,maxNum = 20},
}
--随机掉落物品集 只掉一个
--x893397_g_DropItemOne = {
--	
--}
--10%概率掉落物品
x893397_g_DropItemPercent = {
	30309984,10141945,10124395
}
--**********************************
--入口函数
--**********************************
function x893397_OnDefaultEvent( sceneId, selfId, targetId )
	local MosDataID = GetMonsterDataID( sceneId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{MJXZ_210510_193}" )
		AddNumText( sceneId, x893397_g_ScriptId, "#{MJXZ_210510_194}", 6, 1 )
		AddNumText( sceneId, x893397_g_ScriptId, "#{MJXZ_210510_52}", 11, 2 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )	
end
--**********************************
--事件列表选中一项
--**********************************
function x893397_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		--使用技能开箱子
		if sceneId ~= SCENE_ID_DIGONG_4HD then
			x893397_NotifyTip( sceneId, selfId, "#{MJXZ_210510_183}" )
			return
		end
--		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
--			x893397_NotifyTip( sceneId, selfId, "#{MJXZ_210510_184}" )
--			return	
--		end
		if LuaFnGetAvailableItemCount(sceneId,selfId,x893397_g_CostItem) < x893397_g_CostCount then
			x893397_NotifyTip( sceneId, selfId, "#{MJXZ_210510_187}" )
			x893397_TipsBox( sceneId, selfId,targetId, "#{MJXZ_210510_186}" )
			return	
		end
		if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
			x893397_NotifyTip(sceneId,selfId,"#{MJXZ_210510_189}")
			return
		end
		if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
			x893397_NotifyTip(sceneId,selfId,"#{MJXZ_210510_189}")
			return
		end
		if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
			x893397_NotifyTip(sceneId,selfId,"#{MJXZ_210510_188}")
			return
		end
		if IsTeamFollow(sceneId,selfId) == 1 then
			x893397_NotifyTip(sceneId,selfId,"#{MJXZ_210510_203}")
			return
		end 
		--20:20后才可开启
		local curTime = GetHour() * 100 + GetMinute();
		if curTime < 2020 then
			x893397_NotifyTip( sceneId, selfId, "#{MJXZ_210510_40}" )
			x893397_TipsBox(sceneId,selfId,targetId,"#{MJXZ_210510_63}")
			return
		end
				
		local nCurPosX,nCurPosZ = GetWorldPos(sceneId,targetId)
		local nCurDir = GetObjDir(sceneId,targetId)

		LuaFnHumanScriptUseSkill(sceneId,selfId,3666,targetId,nCurPosX,nCurPosZ,nCurDir)
	elseif GetNumText() == 2 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{MJXZ_210510_53}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )	
	end
end
--**********************************
--产生掉落物品
--**********************************
function x893397_GenDropItem( sceneId, selfId,openHumanId )
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	
	local nTeamId = GetTeamId(sceneId,openHumanId)
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 
			and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1
			and LuaFnIsCharacterLiving(sceneId,PlayerId) == 1
			and ( PlayerId == openHumanId or (nTeamId ~= -1 and GetTeamId(sceneId,PlayerId) == nTeamId)) then
			
			--生成掉落箱子
			local nBoxId = DropBoxEnterSceneEx(nCurPosX,nCurPosZ,sceneId,LuaFnGetGUID(sceneId,PlayerId) )
			if nBoxId ~= -1 then
				--增加掉落物品
				for i = 1,getn(x893397_g_DropItemMust) do
					local tItem = x893397_g_DropItemMust[i]
					local nDropCount = random(tItem.minNum,tItem.maxNum)
					AddMutilItemToBox(sceneId,nBoxId,tItem.itemid,nDropCount,QUALITY_CREATE_BY_BOSS)
				end
--				if getn(x893397_g_DropItemOne) > 0 then
--					AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893397_g_DropItemOne[random(1,getn(x893397_g_DropItemOne))])
--				end
				--概率掉落物品
				for i = 1,getn(x893397_g_DropItemPercent) do
					if random(1,100) <= 10 then
						AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS, 1,x893397_g_DropItemPercent[i])
					end
				end
				SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
			end
		end
	end
end
--**********************************
--提示信息
--**********************************
function x893397_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--对话框提示
--**********************************
function x893397_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

