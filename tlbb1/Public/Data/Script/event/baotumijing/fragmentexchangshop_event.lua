--兽魂小游戏

--脚本号
x893078_g_scriptId = 893078
--可操作最低等级
x893078_g_MinLevel = 85

--兽魂碎片
x893078_g_PSC_MatriID_High ={
38002515,
38002516,
38002517,
38002518,
38002519
}
x893078_g_PSC_SHDNum_High = 8

x893078_g_PSC_MatriID_Mid ={
38002520,
38002521,
38002522,
38002523,
38002524
}
x893078_g_PSC_SHDNum_Mid = 3

x893078_g_PSC_MatriID_Low ={
38002525,
38002526,
38002527,
38002528,
38002529
}
x893078_g_PSC_SHDNum_Low = 1

x893078_g_PSC_MatriID_High2 ={ --特殊兽魂 超神兽魂 属于神兽魂 但不能被化尘
	38002732,
}

x893078_g_PSC_CommonPiece ={
	38002741,
	38002742,
}

x893078_g_PSM_ItemList = {
[1] ={id=38002515, radnum=5},--青龙魂玉
[2] ={id=38002516, radnum=10},--玄武魂玉
[3] ={id=38002517, radnum=15},--白虎魂玉
[4] ={id=38002518, radnum=20},--朱雀魂玉
[5] ={id=38002519, radnum=28},--九尾魂玉

[6] ={id=38002520, radnum=41},--锦鳞魂玉
[7] ={id=38002521, radnum=54},--幻蝶魂玉
[8] ={id=38002522, radnum=67},--霜鹤魂玉
[9] ={id=38002523, radnum=80},--金乌魂玉
[10]={id=38002524, radnum=100},--鹿蜀魂玉

}

x893078_g_GameMaxTime = 5 --每日最大次数
x893078_g_HuanHunCostOnce = 8 --幻魂的每次消耗
--**********************************
--小游戏UI提交
--**********************************
function x893078_OnPetSoulPrizeDraw( sceneId, selfId, targetId)
	if sceneId ~= SCENE_SUZHOU then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_28}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_93}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_39}"  )	
			return
		end
	end
	--等级检查
	if GetLevel(sceneId,selfId) < x893078_g_MinLevel then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_27}")
		return
	end
	--单此消耗检测
	if GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN) < x893078_g_HuanHunCostOnce then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_88}")
		return
	end
	--唤玉次数检查
	if x893078_g_GameMaxTime - GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHENGAMETIME) <= 0 then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_82}")
		return
	end
	--神魂的概率是20%
	local nResultIdx = 0
	if random(1,100) < 20 then
		nResultIdx = random(1,5)
	else
		nResultIdx = random(6,10)
	end
	--检测背包空间
	BeginAddItem(sceneId)
	AddItem( sceneId,x893078_g_PSM_ItemList[nResultIdx].id,1)	
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--消耗扣除
	SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN,GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN) - x893078_g_HuanHunCostOnce)
	SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHENGAMETIME,GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHENGAMETIME) + 1)
	--给东西
	AddItemListToHuman(sceneId,selfId)
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, -2 )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN) )
		UICommand_AddInt( sceneId, x893078_g_GameMaxTime - GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHENGAMETIME) )
		UICommand_AddInt( sceneId, nResultIdx)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89307802 )
end

--**********************************
--交换UI
--**********************************
function x893078_OnPetSoulExchange( sceneId, selfId,targetId, nPos1,nPos2,nPos3,nPos4,nPos5,nPos6,nPos7,nPos8)
	if sceneId ~= SCENE_SUZHOU then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_28}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_93}")
		return
	end
	--等级检查
	if GetLevel(sceneId,selfId) < x893078_g_MinLevel then
		x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_38}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_39}"  )	
			return
		end
	end
	
	local tPSC_BagIdx = {-1,-1,-1,-1,-1,-1,-1,-1}
	tPSC_BagIdx[1] = nPos1
	tPSC_BagIdx[2] = nPos2
	
	tPSC_BagIdx[3] = nPos3
	tPSC_BagIdx[4] = nPos4
	
	tPSC_BagIdx[5] = nPos5
	tPSC_BagIdx[6] = nPos6
	
	tPSC_BagIdx[7] = nPos7
	tPSC_BagIdx[8] = nPos8
	
	local nCurHunChen = GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN)
	local shz = 0
	for i = 1,8 do
		if tPSC_BagIdx[i] ~= -1 then
			local nPetSoulItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, tPSC_BagIdx[i] )
			
			if IsHigh2Matri(nItemTableIndex)==1 then
				--超神品质
				x893078_NotifyTip( sceneId, selfId,"#{SHXT_221104_1}")
				return
			end
			
			if IsCommonPiece(nItemTableIndex)==1 then
				--超神品质
				x893078_NotifyTip( sceneId, selfId,"#{SHXT_221104_14}")
				return
			end
			if IsHighMatri(nPetSoulItemID)==0 and
					IsMidMatri(nPetSoulItemID)==0 and
					IsLowMatri(nPetSoulItemID)==0 then
				x893078_NotifyTip( sceneId, selfId,"#{ZSPVP_211231_32}")
				return
			end
			local nNum = LuaFnGetItemCountInBagPos(sceneId,selfId,tPSC_BagIdx[i])
			
			
			if IsLowMatri(nPetSoulItemID)==1 then
				shz = shz + x893078_g_PSC_SHDNum_Low*nNum
--				print("nPetSoulItemID "..nPetSoulItemID.." nNum "..nNum);
				nCurHunChen = nCurHunChen + shz
			elseif IsMidMatri(nPetSoulItemID)==1 then
				shz = shz + x893078_g_PSC_SHDNum_Mid*nNum
--				print("nPetSoulItemID "..nPetSoulItemID.." nNum "..nNum);
				nCurHunChen = nCurHunChen + shz
			elseif IsHighMatri(nPetSoulItemID)==1 then
				shz = shz + x893078_g_PSC_SHDNum_High*nNum
--				print("nPetSoulItemID "..nPetSoulItemID.." nNum "..nNum);
				nCurHunChen = nCurHunChen + shz
			end
			if LuaFnIsItemAvailable(sceneId, selfId,  tPSC_BagIdx[i]) < 1  or LuaFnIsItemLocked(sceneId, selfId,  tPSC_BagIdx[i]) ~= 0 then
				x893078_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_33}" )
				return
			end
			if nCurHunChen > 1000000000 then
				x893078_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_41}" )
				return
			end
			
			--销毁位置上的物品
			EraseItem( sceneId, selfId, tPSC_BagIdx[i] )
		end
	end
	if shz <= 0 then
		x893078_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_40}" )
		return
	end
	
	SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN,GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN) + shz)
	
	x893078_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{ZSPVP_211231_52}",shz))
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,49,0)
	
	--更新UI
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, -2 )
		UICommand_AddInt( sceneId, GetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_HUNCHEN) )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89307801 )
end
--**********************************
--工具函数
--**********************************
function IsHighMatri(nItemTableIndex)
	local nCount=getn(x893078_g_PSC_MatriID_High)
	for i=1,nCount do
		if nItemTableIndex == x893078_g_PSC_MatriID_High[i] then
			return 1
		end
	end
	return 0
end
function IsMidMatri(nItemTableIndex)
	local nCount=getn(x893078_g_PSC_MatriID_Mid)
	for i=1,nCount do
		if nItemTableIndex == x893078_g_PSC_MatriID_Mid[i] then
			return 1
		end
	end
	return 0
end
function IsLowMatri(nItemTableIndex)
	local nCount=getn(x893078_g_PSC_MatriID_Low)
	for i=1,nCount do
		if nItemTableIndex == x893078_g_PSC_MatriID_Low[i] then
			return 1
		end
	end
	return 0
end
function IsHigh2Matri(nItemTableIndex)
	local nCount=getn(x893078_g_PSC_MatriID_High2)
	for i=1,nCount do
		if nItemTableIndex == x893078_g_PSC_MatriID_High2[i] then
			return 1
		end
	end
	return 0
end

function IsCommonPiece(nItemTableIndex)
	local nCount=getn(x893078_g_PSC_CommonPiece)
	for i=1,nCount do
		if nItemTableIndex == x893078_g_PSC_CommonPiece[i] then
			return 1
		end
	end
	return 0
end
--**********************************
--屏幕中间提示：
--**********************************
function x893078_NotifyTip( sceneId, selfId, Tips)
	BeginEvent( sceneId )
		AddText( sceneId, Tips )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end