--彻地符篆
--脚本号 893252

x893252_g_scriptId = 893252

x300056_g_scriptId = 300056 --传送代码在 x300056_CallMe 这里
--普通场景限制，这些场景内无法传送
x893252_g_UselessScn=
{
	125,	-- 华山
	77,
	800,
}
--禁止传送到某些场景的等级限制....
x893252_g_LimitTransScene =
{
	{423,90},	--火焰山
	{519,90},	--火焰谷
	{424,90},	--高昌
	{520,90},	--高昌迷宫
	{425,90},	--塔里木
	{427,90},	--塔克拉玛干
	{186,75},	--楼兰
	{431,90}, 	--大宛
	{432,90}  	--汗血岭
}

x893252_g_ItemId = 30008121
x893252_g_ItemId01 = 30008125
--遁地符
x893252_g_BindCost = 30008123
x893252_g_NBindCost = 30008124
x893252_g_AddCount = 10

x893252_g_DJTS_MAX_DATA_NUM = 30
--符咒相关数据
x893252_g_DJTS_INIT_USETIMES =20
x893252_g_DJTS_MAX_USETIMES =50
--缺省场景
x893252_g_DefaultScn=
{
	{"#{DJTS_110509_34}", 401, 223, 225},	--秦皇地宫二层
	{"#{DJTS_110509_35}", 402, 131, 128},	--秦皇地宫三层
	{"#{DJTS_110509_36}", 161, 13, 25},		--燕王古墓三层
	{"#{DJTS_110509_37}", 165, 25, 108},	--燕王古墓七层
}
x893252_g_Yinpiao		= 40002000	--银票

-- 禁止传送的Impact
x893252_g_Impact_NotTransportList = { 
	5929, 
	43905,
	43906,
	43907,
	43908,
	43909,
	43910,
	113,
} 

--**********************************
--设置位置
--**********************************
function x893252_SetPosition( sceneId, selfId, bagIndex,nSelIndex )
	--基础检测
	if x893252_CheckItemBasic( sceneId, selfId, bagIndex ) ~= 1 then
		return
	end
	--数据位于错误范围
	if nSelIndex < 0 or nSelIndex >= x893252_g_DJTS_MAX_DATA_NUM then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_42}" )
		return
	end
	--副本或帮会城市内无法定位
	if LuaFnGetSceneType( sceneId ) == 1 or LuaFnGetSceneType( sceneId ) == 4 then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_43}" )
		return
	end
	--配置的指定场景不能定位
	for _, tmp in DINGWEI_SETPOSLIMITSCN do
		if tmp == sceneId then
			x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_44}" )
			return
		end
	end
	--获取玩家的当前坐标和场景ID....
	local opx, opy	= LuaFnGetUnitPosition( sceneId, selfId )
	opx	= floor( opx )
	opy	= floor( opy )
	--程序操作
	local nRet = LuaFnSetCheDiFuLuPosInfo(sceneId,selfId,nSelIndex,opx,opy)
	if nRet ~= 1 then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_42}" )
		return
	end
	--刷新Client端的背包物品信息
--	LuaFnRefreshItemInfo( sceneId, selfId, bagIndex )
	x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_45}" )
end
--**********************************
--向目标转送
--**********************************
function x893252_SetUISelIdx( sceneId, selfId, bagIndex,nSelIndex )
	--这里仅检查彻底符篆的逻辑
	--基础检测
	if x893252_CheckItemBasic( sceneId, selfId, bagIndex ) ~= 1 then
		--设置非法索引
		SetBagItemParam( sceneId, selfId, bagIndex, 6, 1, -1 )
		return
	end
	--数据位于错误范围
	if nSelIndex < 0 or nSelIndex >= x893252_g_DJTS_MAX_DATA_NUM then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_42}" )
		--设置非法索引
		SetBagItemParam( sceneId, selfId, bagIndex, 6, 1, -1 )
		return
	end
	--检测符箓是否足够
	if x893252_IsFuZhouEnough( sceneId, selfId, bagIndex ) ~= 1 then
		--设置非法索引
		SetBagItemParam( sceneId, selfId, bagIndex, 6, 1, -1 )
		return
	end
	local sceneid, posx, posy = LuaFnGetCheDiFuLuPosInfo(sceneId,selfId, nSelIndex)
--	print("sceneid",sceneid)
	if sceneid == -1 then
		--默认传送位置
		if nSelIndex < 4 then
			sceneid = x893252_g_DefaultScn[nSelIndex + 1][2]
			posx = x893252_g_DefaultScn[nSelIndex + 1][3]
			posy = x893252_g_DefaultScn[nSelIndex + 1][4]
		end
	end
	--DJTS_110509_40	请选择合适的地点定位后再使用传送功能
	if sceneid == -1 then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_40}" )
		--设置非法索引
		SetBagItemParam( sceneId, selfId, bagIndex, 6, 1, -1 )
		return
	end
	--DJTS_110509_39	不能传送到目标场景	
	if sceneid ~= sceneId then
		if IsCanNewWorld( sceneId, selfId, sceneid, posx, posy ) ~= 1 then
			x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_39}" )
			--设置非法索引
			SetBagItemParam( sceneId, selfId, bagIndex, 6, 1, -1 )
			return
		end
	end
	
	
	SetBagItemParam( sceneId, selfId, bagIndex, 6, 1, nSelIndex )
end
--**********************************
--关于索引的基础检测
--**********************************
function x893252_CheckItemBasic( sceneId, selfId, bagIndex )
	--因此这里要进行等级限制等检测....
	if GetLevel(sceneId, selfId)<10  then
		x893252_MsgBox( sceneId, selfId, "等级不够" )
		return 0
	end

	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagIndex, 0 ) < 0 then
		return 0
	end

	--检测是不是彻底符篆
	if GetItemTableIndexByIndex(sceneId, selfId, bagIndex) ~= x893252_g_ItemId 
		 and GetItemTableIndexByIndex(sceneId, selfId, bagIndex) ~= x893252_g_ItemId01  then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_41}" )
		return 0
	end
	
	return 1
end
--**********************************
--检测符箓是否足够
--**********************************
function x893252_IsFuZhouEnough( sceneId, selfId, bagIndex )
	local nUseCount = GetBagItemParam( sceneId, selfId, bagIndex, 3, 0 )
	local bInit = GetBagItemParam( sceneId, selfId, bagIndex, 4, 1 )
	if bInit ~= 0 and nUseCount == 0 then
		--符咒耗尽，请使用遁地符补充符咒
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_51}" )
		return 0
	end
	
	return 1
end
--**********************************
--符箓消耗
--**********************************
function x893252_CostFuZhou( sceneId, selfId, bagIndex )
	local nUseCount = GetBagItemParam( sceneId, selfId, bagIndex, 3, 0 )
	local bInit = GetBagItemParam( sceneId, selfId, bagIndex, 4, 1 )
	if bInit == 0 then
		--默认
		SetBagItemParam( sceneId, selfId, bagIndex, 4, 1, 1 )
		SetBagItemParam( sceneId, selfId, bagIndex, 3, 0,x893252_g_DJTS_INIT_USETIMES - 1 )
	else
		SetBagItemParam( sceneId, selfId, bagIndex, 3, 0,nUseCount - 1 )
	end
end
--**********************************
--增加符箓使用次数
--**********************************
function x893252_AddFuZhouCount( sceneId, selfId, bagIndex )
	local nUseCount = GetBagItemParam( sceneId, selfId, bagIndex, 3, 0 )
	local bInit = GetBagItemParam( sceneId, selfId, bagIndex, 4, 1 )
	if bInit == 0 then
		--默认
		SetBagItemParam( sceneId, selfId, bagIndex, 4, 1, 1 )
		SetBagItemParam( sceneId, selfId, bagIndex, 3, 0,x893252_g_DJTS_INIT_USETIMES + x893252_g_AddCount )
	else
		if nUseCount + x893252_g_AddCount > x893252_g_DJTS_MAX_USETIMES then
			SetBagItemParam( sceneId, selfId, bagIndex, 3, 0,x893252_g_DJTS_MAX_USETIMES )
		else
			SetBagItemParam( sceneId, selfId, bagIndex, 3, 0,nUseCount + x893252_g_AddCount )
		end
	end
	--刷新Client端的背包物品信息
	LuaFnRefreshItemInfo( sceneId, selfId, bagIndex )
	
	nUseCount = GetBagItemParam( sceneId, selfId, bagIndex, 3, 0 )
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nUseCount)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1122361)
end
--**********************************
--增加符咒[元宝]
--**********************************
function x893252_Yuanbao_AddFuZhou( sceneId, selfId, bagIndex )
	
	local nUseCount = GetBagItemParam( sceneId, selfId, bagIndex, 3, 0 )
	local bInit = GetBagItemParam( sceneId, selfId, bagIndex, 4, 1 )
	
end
--**********************************
--增加符咒[绑定元宝]
--**********************************
function x893252_YuanbaoBind_AddFuZhou( sceneId, selfId, bagIndex )

end
--**********************************
--增加符咒
--**********************************
function x893252_AddFuZhou( sceneId, selfId, bagIndex,bItemNotBind )
	--基础检测
	if x893252_CheckItemBasic( sceneId, selfId, bagIndex ) ~= 1 then
		return
	end
	--DJTS_110509_29	当前符咒充盈，无需补充。	
	local nUseCount = GetBagItemParam( sceneId, selfId, bagIndex, 3, 0 )
	if nUseCount >= x893252_g_DJTS_MAX_USETIMES then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_29}" )
		return
	end
	-- 绑定的材料数量
	local nBindNum = LuaFnGetAvailableItemCount(sceneId,selfId,x893252_g_BindCost)
	-- 未绑的材料数量
	local nNBindNum = LuaFnGetAvailableItemCount(sceneId,selfId,x893252_g_NBindCost)
	
	if nBindNum <= 0 and nNBindNum <= 0 then
		--DJTS_110509_28	#H您的背包内没有遁地符或遁地符已经加锁。	
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_28}" )
		return
	end
	
	--获取符录本身绑定情况
	local itemIsBound = (LuaFnGetItemBindStatus(sceneId, selfId, bagIndex) == 1)
	--===============================
	-- 情况一：符篆本身已绑定
	--===============================
	if itemIsBound == 1 then
		if nBindNum > 0 then
			-- 1.1 优先扣绑定材料
			LuaFnDelAvailableItem(sceneId, selfId, x893252_g_BindCost, 1)
		elseif nNBindNum > 0 then
			-- 1.2 没有绑定材料，用非绑定材料
			LuaFnDelAvailableItem(sceneId, selfId, x893252_g_NBindCost, 1)
		else
			x893252_MsgBox(sceneId, selfId, "#{DJTS_110509_28}")
			return
		end
	else
	--===============================
	-- 情况二：符篆本身未绑定
	--===============================
		if nNBindNum > 0 then
			-- 2.1 有非绑定材料 → 优先用非绑定材料
			LuaFnDelAvailableItem(sceneId, selfId, x893252_g_NBindCost, 1)
		elseif nBindNum > 0 then
			-- 2.2 只有绑定材料 → 弹确认框
			if bItemNotBind == 1 then
				-- 通知客户端（绑定材料补充未绑定符篆）
				BeginUICommand(sceneId)
					UICommand_AddInt(sceneId, 3)        -- g_Item_DJS_msgFrameVar[1] = 3
					UICommand_AddInt(sceneId, bagIndex) -- 客户端保存道具索引
				EndUICommand(sceneId)
				DispatchUICommand(sceneId, selfId, 20141106)
				return
			else
				-- 玩家已确认 → 强制绑定符篆后扣绑定材料
				LuaFnItemBind(sceneId, selfId, bagIndex)
				LuaFnDelAvailableItem(sceneId, selfId, x893252_g_BindCost, 1)
			end
		else
			-- 2.3 没有任何材料
			x893252_MsgBox(sceneId, selfId, "#{DJTS_110509_28}")
			return
		end
	end
	
	x893252_AddFuZhouCount( sceneId, selfId, bagIndex )
	
	x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_30}" )
end
--**********************************
--事件交互入口
--**********************************
function x893252_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x893252_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x893252_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x893252_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	--背包中的位置
	local bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	if bagId < 0 then
		return 0
	end
	local nSelIndex = GetBagItemParam( sceneId, selfId, bagId, 6, 1 )
	--数据位于错误范围
	if nSelIndex < 0 or nSelIndex >= x893252_g_DJTS_MAX_DATA_NUM then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_42}" )
		return 0
	end
	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagId, 0 ) < 0 then
		return 0
	end
	--DJTS_110509_48	您处于无法使用传送的情况下，无法使用传送道具	
	-- 处于组队跟随状态下，不能传送
	if IsTeamFollow(sceneId, selfId) == 1  then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_48}" )
		return 0
	end

	-- 检测玩家是不是处于摆摊状态，
	if LuaFnIsStalling(sceneId, selfId) == 1  then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_48}" )
		return 0
	end

	--判断当前状态是否可使用(漕运)
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_48}" )
		return 0
	end

	--检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x893252_g_Yinpiao) >= 1  then
		x893252_MsgBox(sceneId, selfId, "#{DJTS_110509_48}" )
		return 0
	end
	
	--检测Impact状态驻留效果
	for i, ImpactId in x893252_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			x893252_MsgBox(sceneId, selfId, "#{DJTS_110509_48}" )
			return 0
		end
	end
	
	-- 处于使用交通工具状态下，不能传送
	if LuaFnGetBusPassengerIDIsInBus(sceneId, selfId) == 1 then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_44}" )
		return 0
	end
	
	--配置的指定场景不能往定位点传送
	for _, tmp in x893252_g_UselessScn do
		if tmp == sceneId then
			x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_44}" )
			return 0
		end
	end
	
	local sceneid, posx, posy = LuaFnGetCheDiFuLuPosInfo(sceneId,selfId, nSelIndex)
	if sceneid == -1 then
		--默认传送位置
		if nSelIndex < 4 then
			sceneid = x893252_g_DefaultScn[nSelIndex + 1][2]
			posx = x893252_g_DefaultScn[nSelIndex + 1][3]
			posy = x893252_g_DefaultScn[nSelIndex + 1][4]
		end
	end
	--DJTS_110509_40	请选择合适的地点定位后再使用传送功能
	if sceneid == -1 then
		x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_40}" )
		return 0
	end
	--DJTS_110509_39	不能传送到目标场景	
	if sceneid ~= sceneId then
		if IsCanNewWorld( sceneId, selfId, sceneid, posx, posy ) ~= 1 then
			x893252_MsgBox( sceneId, selfId, "#{DJTS_110509_39}" )
			return 0
		end
	end
	--检测符箓是否足够
	if x893252_IsFuZhouEnough( sceneId, selfId, bagId ) ~= 1 then
		return 0
	end
	
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x893252_OnDeplete( sceneId, selfId )
--	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
--		return 1;
--	end
	return 1;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x893252_OnActivateOnce( sceneId, selfId )
--	背包中的位置
	local bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	if bagId < 0 then
		return 0
	end
--	启动传送
	local nSelIndex = GetBagItemParam( sceneId, selfId, bagId, 6, 1 )
--	数据位于错误范围
	if nSelIndex < 0 or nSelIndex >= x893252_g_DJTS_MAX_DATA_NUM then
		return 0
	end
	local destsceneId, posx, posy = LuaFnGetCheDiFuLuPosInfo(sceneId,selfId, nSelIndex)
	if destsceneId == -1 then
--		默认传送位置
		if nSelIndex < 4 then
			destsceneId = x893252_g_DefaultScn[nSelIndex + 1][2]
			posx = x893252_g_DefaultScn[nSelIndex + 1][3]
			posy = x893252_g_DefaultScn[nSelIndex + 1][4]
		end
	end
--	DJTS_110509_40	请选择合适的地点定位后再使用传送功能
	if destsceneId == -1 then
		return 0
	end
--	执行消耗
	x893252_CostFuZhou( sceneId, selfId, bagId )
--	设置为空属性
	SetBagItemParam( sceneId, selfId, bagId, 6, 1, -1 )
--	刷新Client端的背包物品信息
	LuaFnRefreshItemInfo( sceneId, selfId, bagId )
	
	if sceneId == destsceneId then
--		同一场景传送
		SetPos( sceneId, selfId, posx, posy )
	else
--		不同场景传送
		NewWorld( sceneId, selfId, destsceneId, posx, posy )
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x893252_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
--**********************************
--检查Obj的可传送性
--**********************************
function x893252_CheckCanNewWorld( sceneId, selfId, bagIndex )
	
end
--**********************************
--屏幕中心通知
--**********************************
function x893252_MsgBox( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
