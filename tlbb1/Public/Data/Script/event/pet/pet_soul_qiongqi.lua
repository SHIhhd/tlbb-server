-- 穷奇兽魂技能吞噬

-- 脚本号
x998522_g_ScriptId = 998522;
x998522_g_CostMoney = 500000

--**********************************
-- 穷奇融魂技能还原
--**********************************
function x998522_Restore(sceneId, selfId, targetId,nBagIndex,bOk)
	if sceneId ~= SCENE_SUZHOU then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_17}" )
		return
	end
	if GetLevel(sceneId,selfId) < 85 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_15}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_18}" )
		return
	end
	if LuaFnIsPetSoul(sceneId,selfId,nBagIndex) ~= 1 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_25}")
		return
	end
	local nPetSoulQual = LuaFnGetPetSoulDataInBag( sceneId,selfId,nBagIndex,  "QUAL")
	if nPetSoulQual ~= 3 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_25}"  )	
		return
	end
	--检查是否原始穷奇
	local nPetSoulIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nBagIndex )
	if nPetSoulIndex == 70600015 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_26}"  )	
		return
	end
	if bOk ~= 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, nBagIndex )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99852204 )
		return
	end
	
	LuaFnPetSoulSwallowRestore(sceneId,selfId,nBagIndex)
	x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_33}" )
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end

--**********************************
-- 穷奇融魂技能吞噬
--**********************************
function x998522_Swallow(sceneId, selfId, targetId,nQBagIndex,nSBagIndex,nSelectButton,bOk)
	if sceneId ~= SCENE_SUZHOU then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_17}" )
		return
	end
	if GetLevel(sceneId,selfId) < 85 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_15}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_18}" )
		return
	end
	if nSelectButton <= 0 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_35}" )
		return
	end
	if LuaFnIsPetSoul(sceneId,selfId,nQBagIndex) ~= 1 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_10}")
		return
	end
	if LuaFnIsPetSoul(sceneId,selfId,nSBagIndex) ~= 1 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_20}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_16}"  )	
			return
		end
	end
	local nPetSoulQual = LuaFnGetPetSoulDataInBag( sceneId,selfId,nQBagIndex,  "QUAL")
	if nPetSoulQual ~= 3 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_13}"  )	
		return
	end
	--检查是否原始穷奇
	local nPetSoulIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nQBagIndex )
	if nPetSoulIndex ~= 70600015 then
		x998522_ShowTips( sceneId, selfId,"#{QQJG_20230815_11}"  )	
		return
	end
	if LuaFnIsItemAvailable(sceneId, selfId, nQBagIndex) < 1  or LuaFnIsItemLocked(sceneId, selfId, nQBagIndex) ~= 0 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_12}" )
		return
	end
	--判定金钱是否足够
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < x998522_g_CostMoney then
        x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_32}" )
        return
	end
	local nBloodRank =LuaFnGetPetSoulDataInBag( sceneId,selfId,nSBagIndex, "BR")
	if nBloodRank > 0 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_14}" )
        return
	end
	local nBloodConcentrate =LuaFnGetPetSoulDataInBag( sceneId,selfId,nSBagIndex, "BC")
	if nBloodConcentrate > 0 then
		x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_14}" )
        return
	end
	if bOk ~= 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, nQBagIndex )
			UICommand_AddInt( sceneId, nSBagIndex )
			UICommand_AddInt( sceneId, nSelectButton )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99852202 )
		return
	end
	LuaFnCostMoneyWithPriority(sceneId, selfId, x998522_g_CostMoney)
	
	LuaFnPetSoulSwallow(sceneId,selfId,nQBagIndex,nSBagIndex,nSelectButton)
	
	x998522_ShowTips( sceneId, selfId, "#{QQJG_20230815_24}" )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
end
--**********************************
-- 提示信息
--**********************************
function x998522_ShowTips(sceneId, selfId, tipMsg)
	BeginEvent(sceneId);
		AddText(sceneId, tipMsg);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
