--//////////////////////////
--时装裁剪脚本
--//////////////////////////

--脚本号
x830011_g_scriptId = 830011
--金梭
x830011_g_JinsuoMateridlId = 30503134
--配饰清除符
x830011_g_DressRemoveMateridlId = 30503136
--消耗金钱
x830011_costMoneyArray = {3000, 3600, 4200}

--**********************************
--点缀摘除--程序接口，客户端或其他区域不要调用
--**********************************
function x830011_OnDress_Remove( sceneId, selfId, nPos,nSelect )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return 0
	end
	if nSelect < 0 or nSelect > 3 then
	    return 0
	end
	
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nPos )
	if EquipPoint ~= HEQUIP_DRESS then
		x830011_Tips( sceneId, selfId, "#{SZPR_091023_45}" )
		return 0
	end
	local Available1 = LuaFnIsItemAvailable(sceneId, selfId, nPos)
	if Available1 < 1 then
		x830011_Tips( sceneId, selfId, "#{SZPR_091023_45}" )
	    return 0
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId,x830011_g_DressRemoveMateridlId) < 1 then
	    x830011_Tips( sceneId, selfId, "#{SZPR_091023_80}" )
	    return 0
	end
	if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 1 then
	    x830011_Tips( sceneId, selfId, "#H背包材料栏空位不足1个，无法进行配饰清除。" )
	    return 0
	end
	--材料扣除
	LuaFnDelAvailableItem(sceneId, selfId,x830011_g_DressRemoveMateridlId,1)
	--可以摘除
	return 1
end
--**********************************
--时装打孔
--**********************************
function x830011_OnDress_Stiletto( sceneId, selfId, nPos )
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	local nItemId = GetItemTableIndexByIndex(sceneId, selfId, nPos)
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nPos )
	if EquipPoint ~= HEQUIP_DRESS then
		x830011_Tips( sceneId, selfId, "#{SZPR_091023_34}" )
		return
	end
	local Bore_Count = GetBagGemCount( sceneId, selfId, nPos )
	if 	Bore_Count >= 3 then
		x830011_Tips( sceneId, selfId, "#{SZPR_091023_35}" )
		return
	end
	local nRet = LuaFnGetAvailableItemCount(sceneId, selfId, x830011_g_JinsuoMateridlId)
	if nRet < 1 then
		x830011_Tips( sceneId, selfId, "#{SZPR_091023_36}" )
		return
	end
	LuaFnDelAvailableItem(sceneId,selfId,x830011_g_JinsuoMateridlId,1)
	local nMoneySelf = GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId)
	if nMoneySelf < x830011_costMoneyArray[Bore_Count+1] then
		x830011_Tips( sceneId, selfId,  "#{GCPlayerShopErrorHandler_Info_Moeny_Not_Enough}" )
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId,selfId,x830011_costMoneyArray[Bore_Count+1]);
	--加一个配饰孔位
	LuaFnOnDress_Stiletto(sceneId,selfId,nPos)
	
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
	x830011_Tips( sceneId, selfId, "#{SZPR_091023_37}"  )
	--更新下客户端界面
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, selfId ) --这里为target占位
		UICommand_AddInt( sceneId, 1 )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,  20091027)
end
--**********************************
--提示信息
--**********************************
function x830011_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end