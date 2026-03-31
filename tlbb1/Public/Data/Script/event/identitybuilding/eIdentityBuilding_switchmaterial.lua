--脚本号
--盟会材料转化

x998783_g_ScriptId = 998783
x998783_g_MinLevel = 50
x998783_g_ShenFen_CaiLiaoZhuanHua_CommonPiece =
{
	21000000,
	21000001,
	21000002,
	21000003,
	21000004,
	21000005,
	21000006,
	21000007,
	21000008,
	21000009,
	21000010,
	21000011,
	21000016,
	21000017,
	21000018,
	21000019,
}
x998783_g_ShenFen_CaiLiaoZhuanHua_Quality =
{
	[21000000] = 1,
	[21000001] = 2,
	[21000002] = 3,
	[21000003] = 4,
	[21000004] = 1,
	[21000005] = 2,
	[21000006] = 3,
	[21000007] = 4,
	[21000008] = 1,
	[21000009] = 2,
	[21000010] = 3,
	[21000011] = 4,
	[21000016] = 1,
	[21000017] = 2,
	[21000018] = 3,
	[21000019] = 4,
}

x998783_g_ShenFen_CaiLiaoZhuanHua_Qual_Dest=
{
	[1] = {
		[1] =21000000,
		[2] =21000004,
		[3] =21000008,
		[4] =21000016,
	},
	[2] = {
		[1] =21000001,
		[2] =21000005,
		[3] =21000009,
		[4] =21000017,
	},
	[3] = {
		[1] =21000002,
		[2] =21000006,
		[3] =21000010,
		[4] =21000018,
	},
	[4] = {
		[1] =21000003,
		[2] =21000007,
		[3] =21000011,
		[4] =21000019,
	},
}
--**********************************
--任务入口函数
--**********************************
function x998783_OnDefaultEvent( sceneId, selfId, targetId,opId )
	--盟会材料转化
	if opId == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 2024040301 )
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x998783_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--列举事件
--**********************************
function x998783_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId, x998783_g_ScriptId,"#{SZSW_230402_01}", 6, 1)
end
--**********************************
--是否盟会材料
--**********************************
function x998783_IsCommonPiece(nItemTableIndex)
	local nCount = getn(x998783_g_ShenFen_CaiLiaoZhuanHua_CommonPiece)

	for i=1,nCount do
		if nItemTableIndex == x998783_g_ShenFen_CaiLiaoZhuanHua_CommonPiece[i] then
			return 1
		end
	end
	return 0
end
--**********************************
--材料转换操作
--**********************************
function x998783_OnCaiLiaoZhuanHua( sceneId, selfId, targetId, bagPos1,bagPos2,bagPos3,nSelID )
	if GetLevel(sceneId,selfId) < x998783_g_MinLevel then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_25}")
		return
	end
	if sceneId ~= SCENE_LUOYANG then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_26}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_27}")
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_28}"  )	
			return
		end
	end
	if nSelID <= 0 then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_30}"  )	
		return
	end
	local nTempQual = -1
	local tMatPos = {bagPos1,bagPos2,bagPos3}
	local tCaiLiaoQual = {-1,-1,-1}
	for i = 1,3 do
		if tMatPos[i] ~= -1 then
			--物品被上锁
			if LuaFnIsItemAvailable(sceneId,selfId,tMatPos[i]) ~= 1 then
				x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_24}"  )	
				return
			end
			local nItemIndex = LuaFnGetItemTableIndexByIndex(sceneId,selfId,tMatPos[i])
			-- 仅可放入盟会材料
			if x998783_IsCommonPiece(nItemIndex) <= 0 or x998783_g_ShenFen_CaiLiaoZhuanHua_Quality[nItemIndex] == nil then
				x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_22}"  )	
				return
			end
			tCaiLiaoQual[i] = x998783_g_ShenFen_CaiLiaoZhuanHua_Quality[nItemIndex]
			nTempQual = tCaiLiaoQual[i]
		end
	end
	--材料同等级检测
	for i = 1,3 do
		if tMatPos[i] ~= -1 then
			local nItemIndex = LuaFnGetItemTableIndexByIndex(sceneId,selfId,tMatPos[i])
			for j = 1,3 do
				if tMatPos[j] ~= -1 and x998783_g_ShenFen_CaiLiaoZhuanHua_Quality[nItemIndex] ~= tCaiLiaoQual[j] then
					x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_23}"  )	
					return
				end
			end
		end
	end
	if nTempQual == -1 then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_23}"  )	
		return
	end
	--检查背包空间
	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_35}"  )	
		return
	end
	--计算放入的材料数量是否大于4
	local nMaterialCount = 0
	for i = 1,3 do
		if tMatPos[i] ~= -1 then
			local nCount = LuaFnGetItemCountInBagPos(sceneId,selfId,tMatPos[i])
			nMaterialCount = nMaterialCount + nCount;
		end
	end
	if nMaterialCount < 4 then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_34}"  )	
		return
	end
	--开始转化
	--计算目标材料
	if x998783_g_ShenFen_CaiLiaoZhuanHua_Qual_Dest[nTempQual] == nil
		or x998783_g_ShenFen_CaiLiaoZhuanHua_Qual_Dest[nTempQual][nSelID] == nil then
		x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_30}"  )	
		return
	end
	--检测是否有重复的材料
	local nTargetMaterial = x998783_g_ShenFen_CaiLiaoZhuanHua_Qual_Dest[nTempQual][nSelID]
	for i = 1,3 do
		if tMatPos[i] ~= -1 then
			local nItemIndex = LuaFnGetItemTableIndexByIndex(sceneId,selfId,tMatPos[i])
			if nItemIndex == nTargetMaterial then
				x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_32}"  )	
				return
			end
		end
	end
	--开始添加材料
	BeginAddItem(sceneId)
	for i = 1,3 do
		if tMatPos[i] ~= -1 then
			local nCount = LuaFnGetItemCountInBagPos(sceneId,selfId,tMatPos[i])
			if LuaFnGetItemBindStatus(sceneId,selfId,tMatPos[i]) == 1 then
				AddBindItem(sceneId,nTargetMaterial,1)
			else
				AddItem(sceneId,nTargetMaterial,1)
			end
		end
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--扣除物品
	local nDecCount = 4
	for i = 1,3 do
		if tMatPos[i] ~= -1 then
			local nItemIndex = LuaFnGetItemTableIndexByIndex(sceneId,selfId,tMatPos[i])
			local nCount = LuaFnGetItemCountInBagPos(sceneId,selfId,tMatPos[i])
			if nCount >= nDecCount then
				LuaFnDelAvailableItem(sceneId,selfId,nItemIndex,nDecCount)
				break
			else
				LuaFnDelAvailableItem(sceneId,selfId,nItemIndex,nCount)
				nDecCount = nDecCount - nCount
			end
		end
	end
	--增加物品
	AddItemListToHuman(sceneId,selfId)
	x998783_NotifyTips( sceneId, selfId,"#{SZSW_230402_36}"  )	
	--给个效果
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
end

--**********************************
-- 屏幕中间提示
--**********************************
function x998783_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x998783_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end