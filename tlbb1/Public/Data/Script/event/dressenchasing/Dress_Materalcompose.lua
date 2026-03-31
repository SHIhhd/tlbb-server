--//////////////////////////
--时装配饰摘除脚本
--//////////////////////////

--脚本号
x830015_g_scriptId = 830015
--配饰摘除符
x830015_g_OutMateridlId = 30503137
--消耗金钱
x830015_costMoneyArray = {5000,6000,7000}

--**********************************
--时装打孔
--**********************************
function x830015_Dress_GemCompose( sceneId, selfId, nPos1,nPos2,nPos3,nPos4,nPos5,nMaterialPos,nYuanbaoPay,nHave )
	local tGemPos = {}
	tGemPos[1] = nPos1
	tGemPos[2] = nPos2
	tGemPos[3] = nPos3
	tGemPos[4] = nPos4
	tGemPos[5] = nPos5
	--计算数量
	--对有效性进行排序
	local tempSort = {-1,-1,-1,-1,-1}
	local nCount = 0;
	for i = 1,5 do
		if (tGemPos[i] ~= nil and tGemPos[i] ~= -1) then
			if LuaFnIsItemAvailable(sceneId, selfId, tGemPos[i]) < 1 then
				--x830015_Tips( sceneId, selfId, "#{SZZH_170111_56}" )
				return
			end
			tempSort[nCount + 1] = tGemPos[i]
			nCount = nCount + 1;
		end
	end
	if nCount <= 2 then
		return
	end
	--拷贝数组
	tGemPos = tempSort

	local nSuccessRate = 0;
	if nCount == 3 then
		nSuccessRate = 50
	elseif nCount == 4 then
		nSuccessRate = 75
	elseif nCount == 5 then
		nSuccessRate = 100
	end
	local nMaterialId = GetItemTableIndexByIndex(sceneId, selfId, nMaterialPos)
	if nMaterialId ~=  x830015_g_OutMateridlId then
	--这里客户端应该是走过验证的，不提示了
		x830015_Tips( sceneId, selfId, "#{SZPR_091023_64}" )
		return
	end
	--
	local tGemId = {}
	for i = 1,5 do
		if tGemPos[i]~= nil and tGemPos[i] ~= -1 then
			tGemId[i] = GetItemTableIndexByIndex(sceneId, selfId, tGemPos[i]);
		else
			tGemId[i] = -1;
		end
	end
	local nGemType = LuaFnGetItemType(tGemId[1]);
	local nGemLevel = GetItemQuality(tGemId[1]);
	for i = 1,nCount do
		if tGemId[i] ~= -1 then
			if LuaFnGetItemType(tGemId[i]) == nGemType then
				nGemType = LuaFnGetItemType(tGemId[i]);
				if nGemType ~= 31 and nGemType ~= 32 and nGemType ~= 33 then
					--这里只能加工时装配饰
					x830015_Tips( sceneId, selfId, "#{SZPR_091023_60}" )
					return
				end
				
				if GetItemQuality(tGemId[i]) == nGemLevel then
					nGemLevel = GetItemQuality(tGemId[i]);
				else
					--等级不一样
					x830015_Tips( sceneId, selfId, "#{SZPR_091023_62}" )
					return
				end
				--发现最高等级
				if nGemLevel >= 4 then
					x830015_Tips( sceneId, selfId, "#{SZPR_091023_63}" )
					return
				end
			else
				--必须是同种的时装配饰才能进行加工
				x830015_Tips( sceneId, selfId, "#{SZPR_091023_61}" )
				return
			end
		end

	end
	local nMoneySelf =  GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	local needMoney = x830015_costMoneyArray[nGemLevel]
	if needMoney == nil then
		x830015_Tips( sceneId, selfId, "#{ZBQH_130521_24}")
		return
	end
	if nMoneySelf < needMoney then
		x830015_Tips( sceneId, selfId, "#{ZBQH_130521_24}")
		return
	end
	--扣除合成符
	LuaFnEraseItem( sceneId, selfId,nMaterialPos)
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId,selfId,needMoney);
	for i = 1,5 do
		if tGemPos[i] >=0 then
			LuaFnEraseItem( sceneId, selfId, tGemPos[i] )
		end
	end
	--这里底层逻辑只给生成后的宝石，扣除的逻辑lua处理即可
	local nRet,nGenName = LuaFn_Dress_GemCompose(sceneId,selfId,tGemId[1],nSuccessRate);
	if nRet ~= 1 then
	--失败了
		x830015_Tips( sceneId, selfId, "#{SZPR_091023_70}")
		return
	end
	x830015_Tips( sceneId, selfId, "#{SZPR_091023_71}"..nGenName)
end
--**********************************
--提示信息
--**********************************
function x830015_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end