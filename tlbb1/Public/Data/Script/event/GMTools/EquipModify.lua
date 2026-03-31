-- 装备修改器 
-- 雪舞

-- 脚本ID
x666660_g_scriptId	= 666660

--客户端操作修改装备
function x666660_ModifyEquip(sceneId, selfId,Type,arg1,arg2,arg3,arg4,arg5)

	
	--先判断管理员权限
    if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	
	Type = tonumber(Type)
	local itemIndex = tonumber(arg1)
	local isLegal = x666660_LuaFnCheckEquipLegality(sceneId, selfId, itemIndex)
	if isLegal < 0 then
		return isLegal 
	end
	
	if Type == 1 then --//属性类型
		if arg4 == 9999 then
			local arg2,_ =LuaFnU32Normalize(arg2)
		end
		--获取老的浮动值
		local nFuDong = LuaFnGetEquipAttrHidden( sceneId, selfId, itemIndex) 		
		LuaFnSetEquipAttr(sceneId,selfId,itemIndex,arg2,arg3,nFuDong)
	elseif Type == 2 then --//星级
		LuaFnSetItemQual(sceneId,selfId,itemIndex,arg2)
	elseif Type == 3 then --//强化
		LuaFnSetEquipEnhanceLevel(sceneId,selfId,itemIndex,arg2)
	elseif Type == 4 then --//孔数
		LuaFnSetEquipSlot(sceneId,selfId,itemIndex,arg2) 
	elseif Type == 5 then --//资质品质
		local a,b = x666660_split_number(arg2)
		local c,d = x666660_split_number(arg3)
		local e,f = x666660_split_number(arg4)
		LuaFnSetEquipAptitude( sceneId, selfId, itemIndex,0,a )
		LuaFnSetEquipAptitude( sceneId, selfId, itemIndex,1,b )
		LuaFnSetEquipAptitude( sceneId, selfId, itemIndex,2,c )
		LuaFnSetEquipAptitude( sceneId, selfId, itemIndex,3,d )
		LuaFnSetEquipAptitude( sceneId, selfId, itemIndex,4,e )
		LuaFnSetEquipAptitude( sceneId, selfId, itemIndex,5,f )
	elseif Type == 6 then --//外观ID
		LuaFnSetEquipVisual(sceneId, selfId,itemIndex,arg2,0) 
	elseif Type == 7 then --//创建者信息
		print("cccccc")
		if arg2 == nil then
			PushDebugMessage(sceneId, selfId,"创建者信息异常")
			return
		end
		local size = strlen(arg2)
		if size > 31 then
			PushDebugMessage(sceneId, selfId,"创建者信息超过最大长度31,请修改后重试,当前大小:"..size)
			return
		end
		
		LuaFnSetItemCreator( sceneId, selfId, tonumber(itemIndex) ,arg2 )
		PushDebugMessage(sceneId, selfId,"创建者信息修改成功")
	elseif Type == 8 then --//浮动值
		LuaFnSetEquipAttrHidden( sceneId, selfId, itemIndex,arg2) 
	elseif Type == 9 then --//修改状态
		LuaFnSetItemStatus( sceneId, selfId, itemIndex ,arg2,0 ) --装备鉴定/绑定/锁定状态
		LuaFnSetItemStatus(sceneId,selfId,itemIndex,arg3,1) -- 设置 铭刻/已鉴定资质 状态 
	elseif Type == 10 then --//修改装备ID
		if LuaFnCheckBlueItemTB(sceneId,selfId,arg2) ~= 1 then
			PushDebugMessage(sceneId,selfId,"装备ID错误,请检查是否为合法装备ID")
			return
		end
		LuaFnEquipTransToNew(sceneId,selfId,itemIndex,arg2,0)
	elseif Type == 11 then --//修改装备中的宝石
		LuaFnSetEquipGemInfo(sceneId,selfId,itemIndex,arg2-1,arg3)
		--单独刷新宝石信息
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 202402112 )
	elseif Type == 12 then --//修改耐久度
		SetBagItemDur( sceneId, selfId,itemIndex,arg2) 
	elseif Type == 13 then --//剩余可修理次数
		LuaFnSetEquipFaileTimes( sceneId, selfId, itemIndex, arg2)
	elseif Type == 14 then --//耐久上限
		LuaFnSetEquipMaxDurValue( sceneId, selfId, itemIndex, arg2)
	elseif Type == 15 then --//克隆装备
		x666660_LuaFnCloneEquipEx(sceneId, selfId, itemIndex)
	elseif Type == 16 then --//不改变属性条数的情况下重洗装备
		local H,L,F = LuaFnGetNewEquipAttr(sceneId,selfId,itemIndex,2)
		LuaFnSetEquipAttr(sceneId,selfId,itemIndex,H,L,F)
		PushDebugMessage(sceneId,selfId,"属性条数"..arg2.."条，只洗属性类型成功")
	elseif Type == 17 then --//纯随机属性条	
		LuaFnRewashEquipAttr(sceneId,selfId,itemIndex,0)
		PushDebugMessage(sceneId,selfId,"随机属性、随机属性条数重置成功")
	elseif Type == 18 then
		local dwId = arg2
		if dwId < 30110001 or dwId > 30111430 then
			PushDebugMessage(sceneId,selfId,"雕纹ID错误")
			return
		end
		local dwId = mod(dwId,10000)
		if dwId < 1 or dwId > 1430 then
			PushDebugMessage(sceneId,selfId,"雕纹ID错误")
			return
		end
		LuaFnSetEquitDiaowenIndex( sceneId, selfId, itemIndex , dwId )		
		
		PushDebugMessage(sceneId,selfId,"雕纹信息修改成功")
	elseif Type == 19 then
		if arg2 < 0 or arg2 > 10000 then
			PushDebugMessage(sceneId,selfId,"雕纹所需材料数错误,范围1~10000")
			return
		end
		LuaFnSetEquitDiaowenExp( sceneId, selfId, itemIndex , arg2 )		
	end
	x666660_ReadiEquip(sceneId, selfId,itemIndex)
end

--拆分数字 
--传入最大6位数，案例:15035 >> 15,35  152242 >> 152,242
function x666660_split_number(merged_number)
    local merged_str = tostring(merged_number)
    local len = strlen(merged_str)
    
    if len < 2 then
        return 0, tonumber(merged_str) -- 如果长度不足2位，设置a为0，b为merged_number
    elseif len > 6 then
        return "合并后的数字长度超出范围" -- 如果长度超出了6位，则返回错误信息
    else
        local a_str, b_str
        if len <= 3 then
            a_str = "0" -- 如果长度小于等于3，设置a为0
            b_str = merged_str -- 如果长度小于等于3，取整个数字作为b
        else
            a_str = strsub(merged_str, 1, -4) -- 如果长度大于3，取前面的作为a
            b_str = strsub(merged_str, -3) -- 如果长度大于3，取后三位作为b
        end
        
        local a = tonumber(a_str) or 0
        local b = tonumber(b_str) or 0
        return a, b -- 返回拆分后的两个数字
    end
end

--客户端读取装备
function x666660_ReadiEquip(sceneId, selfId,arg1)
	local itemIndex = arg1
	local isLegal = x666660_LuaFnCheckEquipLegality(sceneId, selfId, itemIndex)
	if isLegal < 0 then
		return isLegal 
	end
	
	--获取装备 属性类型组A 和 属性类型组B 
	-- local nDataValueA,nDataValueB = LuaFnGetOldEquipAttr(sceneId,selfId,itemIndex) 

	-- local _,_,AllValueA = LuaFnCalculateAttributesAEx(nDataValueA)
	
	-- local _,_,AllValueB = LuaFnCalculateAttributesBEx(nDataValueB)
	-- local ToClientString = ""
	-- for i=1,26 do 
		-- if AllValueA[i] ~= nil then
			-- ToClientString = ToClientString.."1,"
		-- else
			-- ToClientString = ToClientString.."0,"
		-- end
	-- end
	-- for i=1,15 do 
		-- if AllValueB[i] ~= nil then
			-- ToClientString = ToClientString.."1,"
		-- else
			-- ToClientString = ToClientString.."0,"
		-- end
	-- end

	-- local nQual = LuaFnGetItemQual(sceneId,selfId,itemIndex)
	-- local nEnhanceLevel = LuaFnGetEquipEnhanceLevel( sceneId, selfId, itemIndex) 
	-- local nVisual = LuaFnGetEquipVisual(sceneId, selfId,itemIndex) 
	
	--浮动值
	local nFuDong = LuaFnGetEquipAttrHidden( sceneId, selfId, itemIndex) 
	
	-- local nID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemIndex )
	
	-- local ZhuangTaiA = LuaFnGetItemStatus( sceneId, selfId, itemIndex ) --装备鉴定/绑定/锁定/铭刻/已鉴定资质

	-- local ZiZhiPinZhiStr = ""
	-- for i=0,5 do
		-- ZiZhiPinZhiStr = ZiZhiPinZhiStr .. LuaFnGetEquipAptitude(sceneId,selfId,itemIndex,i)..","
	-- end
	
	--创建者信息
	-- local _,nCreator = LuaFnGetItemCreator( sceneId, selfId,itemIndex) 
	
	-- local nEquipGem_1,nEquipGem_2,nEquipGem_3,nEquipGem_4 = LuaFnGetEquipGemInfo(sceneId,selfId,itemIndex,0)
	-- local GemStr = nEquipGem_1..","..nEquipGem_2..","..nEquipGem_3..","..nEquipGem_4
	
	--耐久度
	-- local nDurValue = GetBagItemDur(sceneId,selfId,itemIndex) --剩余耐久
	-- local nDurMaxValue = LuaFnGetEquipDurMaxValue( sceneId, selfId,itemIndex)  --耐久上限
	
	--获取剩余可修理次数
	-- local nXiuLi = LuaFnGetEquipFaileTimes( sceneId, selfId, itemIndex)
	
	-- local nTiaoShu = LuaFnGetEquipAttrCount(sceneId,selfId,itemIndex)
	
	--是否贵重
	local Goods = IsGoodsProtect_Goods(sceneId,selfId,itemIndex)
	
	
	--雕纹满级
	local dwNumInfo = 0
	local nCan = LuaFnCanEquipDiaowen_Enchase(sceneId,selfId,itemIndex);
	if nCan ~= -3 then
		local dwId = LuaFnGetEquitDiaowenIndex(sceneId,selfId,itemIndex)
		local dwlevel,dwName = LuaFnGetDiaowenInfoByDWId(dwId)
		-- 升级所需材料数Max
		local requireJCS,newDWID1 = LuaFnGetReqMatforEquipDWLevelUp(sceneId,selfId,itemIndex,dwlevel + 1)
		local NeedNum = LuaFnGetEquitDiaowenExp(sceneId,selfId,itemIndex)
		dwNumInfo = requireJCS * 10000 + NeedNum
	end 
	
	
	--字符串传输给客户端
	BeginUICommand( sceneId )
		UICommand_AddInt(sceneId,dwNumInfo) --雕纹材料数量
		UICommand_AddInt(sceneId,Goods) --是否贵重
		UICommand_AddInt(sceneId,nFuDong)-- 浮动值
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 202402111 )
end

--克隆完整一件装备
function x666660_LuaFnCloneEquipEx(sceneId, selfId, itemIndex)
	local isLegal = x666660_LuaFnCheckEquipLegality(sceneId, selfId, itemIndex)
	if isLegal < 0 then
		return isLegal 
	end
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 1 then
        PushDebugMessage(sceneId, selfId, "背包空间不足")
        return -1
	end
	--先发个一模一样的装备
	local ItemId = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemIndex )
	local nNewPos = TryRecieveItem( sceneId, selfId, ItemId, 1)
	if nNewPos == -1 then
		return -2
	end
	--克隆属性类型/浮动值
	local H,L = LuaFnGetOldEquipAttr(sceneId,selfId,itemIndex)
	local F = LuaFnGetEquipAttrHidden( sceneId, selfId, itemIndex) 
	LuaFnSetEquipAttr(sceneId,selfId,nNewPos,H,L,F)
	
	local Status = LuaFnGetItemStatus( sceneId, selfId, itemIndex ) 
	LuaFnSetItemStatus( sceneId, selfId, nNewPos,Status ) 
end


--属性A:计算十六进制对应的装备属性 
function LuaFnCalculateAttributesAEx(hexInputA)
	-- 属性类型位数:225-232 
    -- 属性对应的十六进制值
    local attributesA = {
        {name = "血上限", value = 1},
        {name = "百分比血上限", value = 2},
        {name = "气上限", value = 8},
        {name = "百分比气上限", value = 22},
        {name = "冰攻击", value = 64},
        {name = "冰抗", value = 128},
        {name = "火攻击", value = 512},
        {name = "火抗", value = 1024},
        {name = "玄攻", value = 4096},
        {name = "玄抗", value = 8192},
        {name = "毒攻", value = 32768},
        {name = "毒抗", value = 65536},
        {name = "所有抗性", value = 262144},
        {name = "外功攻击", value = 524288},
        {name = "基础外功攻击百分比", value = 1048576},
        {name = "武器基础外功攻击百分比", value = 2097152},
        {name = "外功防御", value = 4194304},
        {name = "基础外功防御百分比", value = 8388608},
        {name = "防具基础外功防御百分比", value = 16777216},
        {name = "抵消外功伤害百分比", value = 33554432},
        {name = "内功攻击", value = 67108864},
        {name = "基础内功攻击百分比", value = 134217728},
        {name = "武器基础内功攻击百分比", value = 268435456},
        {name = "内功防御", value = 536870912},
        {name = "基础内功防御百分比", value = 1073741824},
        {name = "防具基础内功防御百分比", value = 2147483648},
    }

    local num = hexInputA
    local count = 0 -- 用于计数包含的属性
	local ReturnValue = {}
	local AllValue = {}
    for i = 1, getn(attributesA) do
        local attr = attributesA[i]
        if LuaFnBitAnd(num, attr.value) ~= 0 then
            count = count + 1
			ReturnValue[count] = attr.name
			AllValue[i] = attr.name
		else
			AllValue[i] = nil
        end
		
    end
	return ReturnValue,count,AllValue
end

--属性B:计算十六进制对应的装备属性 
--注意属性类型、属性条数必须一一对应
function LuaFnCalculateAttributesBEx(hexInputB)
	-- 属性类型位数:225-232 
    -- 属性对应的十六进制值
	local attributesB = {
        {name = "抵消内功伤害", value = 1},
        {name = "命中", value = 8},
        {name = "闪避", value = 16},
        {name = "会心", value = 32},
        {name = "力量", value = 1024},
        {name = "灵气", value = 2048},
        {name = "体力", value = 4096},
        {name = "定力", value = 8192},
        {name = "身法", value = 16384},
        {name = "会心防御", value = 32768},
        {name = "所有属性", value = 65536},
        {name = "忽略目标冰抗", value = 4194304},
        {name = "忽略目标火抗", value = 8388608},
        {name = "忽略目标玄抗", value = 16777216},
        {name = "忽略目标毒抗", value = 33554432},
       
    }

    local num = hexInputB--tonumber(hexInputB, 16) -- 将输入的十六进制字符串转换为数字
    local count = 0 -- 用于计数包含的属性
	local ReturnValue = {}
	local AllValue = {}
    for i = 1, getn(attributesB) do
        local attr = attributesB[i]
        if LuaFnBitAnd(num, attr.value) ~= 0 then
            count = count + 1
			ReturnValue[count] = attr.name
			AllValue[i] = attr.name
		else
			AllValue[i] = nil	
        end
    end
	return ReturnValue,count,AllValue
end

--检查某位置的装备合法性
function x666660_LuaFnCheckEquipLegality(sceneId, selfId, itemIndex)
	--0~99 背包道具位
	local nLegality = 0
	if itemIndex >= 0 and itemIndex <= 99 then
		nLegality = 1
	end
	if nLegality == 0 then
		return -1 --终止，位置不合法
	end
	--检查装备是否合法
	local nEquipID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, itemIndex )
	if nEquipID < 10100000 or nEquipID > 10999999 then
		PushDebugMessage(sceneId,selfId,"装备ID不合法！")
		return -2
	end
	return 1
end

