--//////////////////////////
--时装镶嵌脚本
--//////////////////////////

--脚本号
x830013_g_scriptId = 830013
--时装配饰点缀符
x830013_g_MateridlId = 30503135
--消耗金钱
x830013_Dress_Gem_Cost = {5000,6000,7000,8000}

--**********************************
--时装点缀镶嵌
--**********************************
function x830013_OnDress_Enchase(sceneId,selfId,nPos,nGemPos,nMaterialPos)
	--安全时间
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		SendOResultToPlayer(sceneId,selfId,OR_PILFER_LOCK_FLAG)
		return
	end
	local nItemId = GetItemTableIndexByIndex(sceneId, selfId, nPos)
	local EquipPoint = LuaFnGetBagEquipType( sceneId, selfId, nPos )
	if EquipPoint ~= HEQUIP_DRESS then
		x830013_Tips( sceneId, selfId, "#{SZPR_091023_45}" )
		return
	end
	--没有打孔？
	local Bore_Count = GetBagGemCount( sceneId, selfId, nPos )
	if 	Bore_Count <= 0 then
		x830013_Tips( sceneId, selfId, "#{SZPR_091023_46}" )
		return
	end
	if LuaFnIsItemLocked(sceneId, selfId, nPos) ~= 0 then
--		x830013_Tips( sceneId, selfId, "#{SZZH_170111_56}" )
		return
	end
	--获取目前时装已有的配饰信息
	local nGem1,nGem2,nGem3,nGem4 = LuaFnGetGemInfoInEquip(sceneId,selfId,nPos)
	local nDressGemInfo = {nGem1,nGem2,nGem3,nGem4};
	local addGem={-1,-1,-1}
	for i = 1,3 do
		if nDressGemInfo[i] <= 0 then
			addGem[i] = nGemPos
			break
		end
	end
	local addcnt = 0
	for i=1,3 do
		if addGem[i] > 0 then
			addcnt = addcnt + 1
			if LuaFnIsItemAvailable(sceneId, selfId, addGem[i]) < 1 then
--				x830013_Tips( sceneId, selfId, "#{SZZH_170111_56}" )
				return
			end
			
		end 
	end	
	if addcnt < 1 then
		x830013_Tips( sceneId, selfId,"#{SZPR_091023_47}")
		return 
	end
	
	--获取目前所有已有的类型
	local curGemType={}
	for i = 1,3 do
		if nDressGemInfo[i] > 0 then
			curGemType[i] = LuaFnGetItemType(nDressGemInfo[i]);
		else
			curGemType[i] = -1;
		end
	end
	--首先检查要镶嵌的宝石和已有的有无相同类型的
	local addGemId={}
	local addGemType={}
	for i = 1,3 do
		if addGem[i] >= 0 then
			addGemId[i] = GetItemTableIndexByIndex(sceneId, selfId, addGem[i])
			addGemType[i] = LuaFnGetItemType(addGemId[i]);
		else
			addGemId[i] = -1;
			addGemType[i] = -1;
		end
	end
	for i = 1,3 do
		if addGemId[i] > -1 then
			for k = 1,3 do
				if curGemType[k] == addGemType[i] then
					--发现重复
					x830013_Tips( sceneId, selfId,"#{SZPR_091023_88}")
					return 
				end
			end
		end
	end
	--校验通过，检查有无替换宝石
	local replaceGemId = {}
	for i = 1,3 do
		if nDressGemInfo[i] > 0 and addGemId[i] > 0 then
			--该位置有宝石
			x830013_Tips( sceneId, selfId,"#{SZPR_091023_88}")
			return 
		end
		if addGemId[i] > 0 then
			nDressGemInfo[i] = addGemId[i]
		end
	end
	local equipEmbededGemCount = GetGemEmbededCount( sceneId, selfId, nPos )
	local needMoney = 0
	local isnewcnt = 0
	for i=1,3 do
		if addGem[i] >= 0 then
			isnewcnt = isnewcnt + 1
			local nLevel = GetItemQuality(addGemId[i])
			needMoney = needMoney + (equipEmbededGemCount + isnewcnt)*x830013_Dress_Gem_Cost[nLevel]
		end
	end
	local nMoneySelf =  GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	if nMoneySelf < needMoney then
		x830013_Tips( sceneId, selfId,"#{ZBQH_130521_24}" )
		return
	end
	
	if LuaFnDelAvailableItem(sceneId,selfId,x830013_g_MateridlId,addcnt) ~= 1 then
		x830013_Tips( sceneId, selfId, "时装配饰点缀符扣除失败，或者请检查你的背包其是否被加锁！" )
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId,selfId,needMoney);
	--先行扣除宝石
	for i = 1,3 do
		if addGem[i] >=0 then
			LuaFnEraseItem( sceneId, selfId, addGem[i] )
		end
	end
	--设定当前需要进行点缀的宝石
	LuaFnOnDress_Enchase(sceneId,selfId,nPos,nDressGemInfo[1],nDressGemInfo[2],nDressGemInfo[3]);
	--给予替换下的宝石
--	local bBind = false
--	if LuaFnGetItemBindStatus(sceneId,selfId,nPos) then
--		bBind = true
--	end
--	for i = 1,3 do
--		if replaceGemId[i] > -1 then
--			local nNewPos = TryRecieveItem(sceneId,selfId,replaceGemId[i],1)
--			if bBind then
--				LuaFnItemBind(sceneId,selfId,nNewPos)
--			end
--		end
--	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
--	SZZH_170111_66	#H恭喜您，成功将%s0个配饰点缀在时装：%s1上。
--	x830013_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZZH_170111_66}", addcnt,GetItemName(sceneId,nItemId)) )
	x830013_Tips( sceneId, selfId, "#{SZPR_091023_52}" )
	--更新下客户端界面
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, selfId ) --这里为target占位
		UICommand_AddInt( sceneId, 2 )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,  20091029)
	--发个世界公告
	--这里暂时不加了
	--local strGlobalNew = ""
end
--**********************************
--提示信息
--**********************************
function x830013_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end