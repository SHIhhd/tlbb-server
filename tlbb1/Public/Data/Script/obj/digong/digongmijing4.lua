--地宫秘境主逻辑脚本
x893390_g_ScriptId = 893390
--是否启用
x893390_g_IsOpen = 0
--可进入的最低等级
x893390_g_MinLevel = 80
--进入要消耗的金钱
x893390_g_CostMoney = 200000
--开始及终止时间
x893390_g_StartTime = 2100
x893390_g_EndTime = 2300--2040
--生成轮次
x893390_g_tTickTable = {
	{tick = 2115, state = 1},
	{tick = 2130, state = 2},
	{tick = 2145, state = 5},
	{tick = 2200, state = 6},
	{tick = 2215, state = 7},
	{tick = 2230, state = 8},
	{tick = 2245, state = 9},
}
--军功令
x893390_g_JunGongLingItem = 38002668
--怪物分布
x893390_g_BoxTab = {
	--秦将宝箱·甲
	{
		dataId = 50605,
		pos = {
			{98,45}
		},
		scriptId = 893398,
		baseAi = 3,
	},
	--秦将宝箱·乙
	{
		dataId = 50606,
		pos = {
			{214,69}
		},
		scriptId = 893398,
		baseAi = 3,
	},
	--秦将宝箱·丙
	{
		dataId = 50607,
		pos = {
			{54,202}
		},
		scriptId = 893398,
		baseAi = 3,
	},
	--秦将宝箱·丁
	{
		dataId = 50608,
		pos = {
			{190,190}
		},
		scriptId = 893398,
		baseAi = 3,
	},
	--秦皇宝箱
	{
		dataId = 50610,
		pos = {
			{135,101}
		},
		scriptId = 893397,
		baseAi = 3,
	},
}
x893390_g_BossTab = {
	--秦将残识
	{
		dataId = 49262,
		pos = {
			{75,203},{75,147},{197,175},{209,90}
		},
		scriptId = -1,
		baseAi = 4,
	},
}
--小怪分布
x893390_g_MonsterTable = {
	dataId = 49259,
	pos = {
		{41.5057, 67.8085},
		{105.6435, 50.093},
		{90.8562, 60.3203},
		{46.1999, 126.7916},
		{50.1636, 150.3945},
		{155.9335, 45.8737},
		{65.6984, 159.6193},
		{35.7947, 165.1701},
		{33.6272, 174.6317},
		{193.0077, 41.7191},
		{208.9784, 78.895},
		{80.4949, 218.0774},
		{113.7915, 222.5145},
		{84.2088, 231.9706},
		{119.1396, 231.1676},
		{100.9071, 164.3503},
		{176.3036, 97.864},
		{138.5016, 98.3725},
		{121.2578, 98.8434},
		{59.4754, 119.838},
		{70.49, 175.9131},
		{50.49, 215.9131},
		{43.9131, 95.49},
		{50.9131, 175.49},
		{173.49, 169.9131},
	}
}
--魔改小怪分布
x893390_g_MonsterMagicTable = {
	dataId = 49256,
	pos = {
		{72,128},
		{70,135},
		{75,138},
		{80,134},
		{81,127},
		{87,13},
		{79,123},
		{73,121},
		{66,12},
		{65,125},
		{75,134},
		{80,134},
		{77,131},
		{74,128},
		{130,113},
		{134,112},
		{138,108},
		{138,103},
		{134,99},
		{128,1},
		{130,105},
		{132,107},
		{129,108},
		{135,112},
		{133,106},
		{205,99},
		{206,97},
		{213,95},
		{214,92},
		{216,89},
		{221,87},
		{227,88},
		{231,91},
		{226,95},
		{221,98},
		{215,1},
		{220,102},
		{222,106},
		{218,108},
		{225,104},
		{234,107},
		{234,105},
		{212,1},
		{210,107},
		{210,173},
		{209,166},
		{210,163},
		{214,165},
		{202,168},
		{199,163},
		{196,171},
		{167,164},
		{171,164},
		{174,164},
		{174,17},
		{168,173},
		{175,172},
		{178,169},
		{165,204},
		{168,203},
		{172,205},
		{174,209},
		{173,213},
		{168,215},
		{168,211},
		{215,211},
		{216,208},
		{213,206},
		{210,208},
		{206,208},
		{205,211},
		{209,211},
		{56,216},
		{54,224},
		{42,215},
		{32,221},
		{28,226},
		{33,227},
		{37,189},
		{35,18},
		{28,171},
		{45,18},
		{49,187},
		{59,187},
		{57,176},
		{50,197},
		{54,205},
		{46,202},
		{44,198},
		{38,2},
		{58,211},
		{68,196},
		{68,202},
		{70,209},
		{70,175},
		{66,178},
		{60,178},
		{70,191},
		{77,193},
		{73,196},
		{71,198},
		{80,2},
		{84,2},
		{83,208},
		{78,21},
		{76,205},
		{73,2},
		{76,197},
		{78,201},
		{80,219},
		{78,196},
		{73,199},
	}
}
--场景参数
x893390_g_Param_BoxBOSS = 0		--秦皇宝箱状态
x893390_g_Param_Box1 = 1		--宝箱1状态
x893390_g_Param_Box2 = 2		--宝箱2状态
x893390_g_Param_Box3 = 3		--宝箱3状态
x893390_g_Param_Box4 = 4		--宝箱4状态
--小宝箱特殊机制
x893390_g_SmallBoxSpecial = {
	{
		needTime = 2100,
		needUnLockCount = 1,
	},
	{
		needTime = 2130,
		needUnLockCount = 2,
	},
	{
		needTime = 2200,
		needUnLockCount = 3,
	},
	{
		needTime = 2230,
		needUnLockCount = 4,
	},
}
--**********************************
--场景计时器[tick 1s]
--**********************************
function x893390_OnSceneTimer( sceneId )
	if x893390_g_IsOpen == 0 then
		return
	end
	local curTime = GetHour() * 100 + GetMinute();
	--20:00整点生成一批
	if curTime == x893390_g_StartTime and GetSecond() == 0 then
		if sceneId == SCENE_ID_DIGONG_4HD then
			--创建秦俑百将
			x893390_CreateMonster( sceneId)
			--创建BOSS和箱子
			x893390_CreateBox( sceneId)
			x893390_CreateBoss( sceneId)
			--魔改需求小怪创建
			x893390_CreateMonster_Magic( sceneId)
		end
	end
	--其他轮次
	if GetSecond() == 0 then
		for i = 1,getn(x893390_g_tTickTable) do
			if curTime == x893390_g_tTickTable[i].tick then
				if sceneId == SCENE_ID_DIGONG_4HD then
					--创建秦俑百将
					x893390_CreateMonster( sceneId)
					--创建秦将残识
					x893390_CreateBoss( sceneId)
				end
				break
			end
		end
	end
	--小宝箱特殊机制
	for i = 1,getn(x893390_g_SmallBoxSpecial) do
		if curTime == x893390_g_SmallBoxSpecial[i].needTime and GetSecond() == 0 then
			x893390_TransRandBox( sceneId,x893390_g_SmallBoxSpecial[i].needUnLockCount)
		end
	end
	--结束
	if curTime == x893390_g_EndTime then
		--传送所有玩家至随机的大理、苏州、洛阳
		CallScriptFunction( 893391, "TransPlayerToHome", sceneId )
	end
	--未在活动时间
	local nCurState = x893390_GetCurActivityState( sceneId)
	if nCurState == 0 or nCurState == 4 then
		--传送所有玩家至随机的大理、苏州、洛阳
		CallScriptFunction( 893391, "TransPlayerToHome", sceneId )
	end
	--更新面板信息
	x893390_UpdateQinHuangTime( sceneId )
end
--**********************************
--随机转换一个秦将宝箱
--**********************************
function x893390_TransRandBox( sceneId,needUnLockCount)
	local nCurUnlockCount = 0
	for i = 0,4 do
		if LuaFnGetSceneData_TempParam(sceneId,i) == 2 then
			nCurUnlockCount = nCurUnlockCount + 1
		end
	end
	if nCurUnlockCount < needUnLockCount then
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID( sceneId, MonsterId )
			if MosDataID >= 50605 and MosDataID <= 50608 then
				--创建无需解锁的宝箱
				local nCurPosX,nCurPosZ = GetWorldPos(sceneId,MonsterId)
				local nCurDir = GetObjDir(sceneId,MonsterId)
				
				local nMonsterId = CreateMonsterWithDir( sceneId,
					50609,
					nCurPosX,
					nCurPosZ, 
					3, 
					-1, 
					893398,
					nCurDir
				);
				if nMonsterId ~= -1 then
					--记录原有id
					LuaFnSetNpcIntParameter(sceneId,nMonsterId,0,MosDataID)
					--MJXZ_210510_198 #P%s0无需军功令即可开启，大侠们速速前往！	
					--提起公告
					local monsterName = GetMonsterNamebyDataId(MosDataID)
					AddGlobalCountNews( sceneId, ScriptGlobal_Format("#{MJXZ_210510_198}",monsterName) )
					--删除现有宝箱
					LuaFnDeleteMonster(sceneId, MonsterId)
				end
				break
			end
		end
	end
end
--**********************************
--进行陶俑创建
--只创建一次
--**********************************
function x893390_CreateMonster_Magic( sceneId)
	local tPos = x893390_g_MonsterMagicTable.pos
	for i = 1,getn(tPos) do
		local nMonsterId = CreateMonsterWithDir( sceneId,
			x893390_g_MonsterMagicTable.dataId ,
			tPos[i][1],
			tPos[i][2], 
			3, 
			-1, 
			891158,
			(random(0,635) / 100)
		);
		
	end
end
--**********************************
--创建秦俑百将
--**********************************
function x893390_CreateMonster( sceneId)
	--遍历场景中所有的怪....更新BOSS重建状态....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		if MosDataID == x893390_g_MonsterTable.dataId then
			LuaFnDeleteMonster(sceneId, MonsterId)
		end
	end
	--建立新的小怪
	for i = 1,getn(x893390_g_MonsterTable.pos) do
		local nMonsterId = CreateMonsterWithDir( sceneId,
			x893390_g_MonsterTable.dataId,
			x893390_g_MonsterTable.pos[i][1],
			x893390_g_MonsterTable.pos[i][2], 
			3, 
			-1, 
			891158,
			(random(0,635) / 100)
		);
	end
end
--**********************************
--创建BOSS
--**********************************
function x893390_CreateBoss( sceneId)
	for i = 1,getn(x893390_g_BossTab) do
		local tMonster = x893390_g_BossTab[i]
		for j = 1,getn(tMonster.pos) do
			local nMonsterId = CreateMonsterWithDir( sceneId,
				tMonster.dataId,
				tMonster.pos[j][1],
				tMonster.pos[j][2], 
				tMonster.baseAi, 
				-1, 
				tMonster.scriptId,
				0
			);
		end
	end
end
--**********************************
--创建箱子
--**********************************
function x893390_CreateBox( sceneId)
	for i = 1,getn(x893390_g_BoxTab) do
		local tMonster = x893390_g_BoxTab[i]
		for j = 1,getn(tMonster.pos) do
			local nMonsterId = CreateMonsterWithDir( sceneId,
				tMonster.dataId,
				tMonster.pos[j][1],
				tMonster.pos[j][2], 
				tMonster.baseAi, 
				-1, 
				tMonster.scriptId,
				0
			);
		end
	end
end
--**********************************
--获取当前活动状态
--0、4:不在活动时间 1:20:10 2:20:20	3:秦俑已全部刷新
--**********************************
function x893390_GetCurActivityState( sceneId)
	local curTime = GetHour() * 100 + GetMinute();
	--结束
	if curTime < x893390_g_StartTime then
		return 0
	end
	if curTime >= x893390_g_EndTime then
		return 4
	end
	for i = 1,getn(x893390_g_tTickTable) do
		if curTime < x893390_g_tTickTable[i].tick then
			return x893390_g_tTickTable[i].state
		end
	end
	return 3
end
--**********************************
--更新面板信息
--**********************************
function x893390_UpdateQinHuangTime( sceneId )
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount <= 0 then
		return
	end
	
	local nMonsterNum = GetMonsterCount(sceneId)
	local nQinYongMonster = 0
	local nQinJiangMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		local nMonsterDataId = GetMonsterDataID(sceneId,nMonsterId)
		if nMonsterDataId == 49259 then
			nQinYongMonster = nQinYongMonster + 1
		end
		if nMonsterDataId == 49262 then
			nQinJiangMonster = nQinJiangMonster + 1
		end
	end

	for i = 0,nHumanCount - 1 do
		local nHumanID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanID) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanID) == 1 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 2)			--1:show 2:update 1000:hide
				UICommand_AddInt( sceneId, sceneId )
				UICommand_AddInt( sceneId, x893390_GetCurActivityState( sceneId) )
				UICommand_AddInt( sceneId, nQinYongMonster )
				UICommand_AddInt( sceneId, nQinJiangMonster )
				
				UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_BoxBOSS) )
				UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box1) )
				UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box2) )
				UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box3) )
				UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box4) )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, nHumanID, 20210519 )
			--军功令特殊显示
			x893390_UpdateJunGongLingState( sceneId,nHumanID)
		end
	end
end
--**********************************
--军功令特殊显示
--**********************************
function x893390_UpdateJunGongLingState( sceneId,selfId)
	local nItemCount = LuaFnGetAvailableItemCount(sceneId,selfId,x893390_g_JunGongLingItem)
	if nItemCount > 0 and nItemCount < 40 then
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,42751) == 0 then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 42751, 10 )
		end
		--拥有大量军功令
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,42752) == 1 then
			LuaFnCancelSpecificImpact(sceneId, selfId, 42752 )
		end
	elseif nItemCount >= 40 then
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,42752) == 0 then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 42752, 10 )
		end
	else
		--存在则清理两个Impact
		if LuaFnHaveImpactOfSpecificMutexID(sceneId,selfId,4964) then
			LuaFnCancelSpecificImpact(sceneId, selfId, 42751 )
			LuaFnCancelSpecificImpact(sceneId, selfId, 42752 )
		end
	end
end
--**********************************
--玩家死亡
--**********************************
function x893390_OnSceneHumanDie( sceneId,selfId,killerId)
	--标记死于地宫4
	SetMissionFlagEx(sceneId,selfId,MFEX_DIE_INDIGONG4_HD,1)
	
	local nItemCount = LuaFnGetAvailableItemCount(sceneId,selfId,x893390_g_JunGongLingItem)
	if nItemCount <= 1 then
		return
	end
	local nDropCount = ceil(nItemCount / 2);
	--扣除军功令
	LuaFnDelAvailableItem(sceneId,selfId,x893390_g_JunGongLingItem,nDropCount)
	--增加掉包
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	local nBoxId = DropBoxEnterSceneEx(nCurPosX,nCurPosZ,sceneId,LuaFnGetGUID(sceneId,killerId) )
	if nBoxId ~= -1 then
		--增加掉落物品
		AddMutilItemToBox(sceneId,nBoxId,x893390_g_JunGongLingItem,nDropCount,QUALITY_CREATE_BY_BOSS)
		SetItemBoxMaxGrowTime( sceneId, nBoxId, 5 * 60 * 1000 )	--5分钟生命期....	
	end
end
--**********************************
--玩家进入场景
--**********************************
function x893390_OnPlayerEnterScene( sceneId,selfId,isReconnect)
	if sceneId ~= SCENE_ID_DIGONG_4HD then
		return
	end
	local curTime = GetHour() * 100 + GetMinute();
	if curTime >= x893390_g_StartTime and curTime < x893390_g_EndTime then
		--地宫4专用UI
		local nMonsterNum = GetMonsterCount(sceneId)
		local nQinYongMonster = 0
		local nQinJiangMonster = 0
		for i=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,i)
			local nMonsterDataId = GetMonsterDataID(sceneId,nMonsterId)
			if nMonsterDataId == 49259 then
				nQinYongMonster = nQinYongMonster + 1
			end
			if nMonsterDataId == 49262 then
				nQinJiangMonster = nQinJiangMonster + 1
			end
		end
		
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1)			--1:show 2:update 1000:hide
			UICommand_AddInt( sceneId, sceneId )
			UICommand_AddInt( sceneId, x893390_GetCurActivityState( sceneId) )
			UICommand_AddInt( sceneId, nQinYongMonster )
			UICommand_AddInt( sceneId, nQinJiangMonster )
			
			UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_BoxBOSS) )
			UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box1) )
			UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box2) )
			UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box3) )
			UICommand_AddInt( sceneId, LuaFnGetSceneData_TempParam(sceneId,x893390_g_Param_Box4) )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20210519 )
		
		--特殊保护效果
		if isReconnect == 0 then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5969, 100 )
			x893390_Tips( sceneId, selfId, "#{MJXZ_210510_176}" )			
		end
		--设置今日进入时间
		SetMissionDataEx(sceneId,selfId,MDEX_ENTER_DIGONG_4HD_LASTTIME,GetTime2Day())
		--设置复活点
		SetPlayerDefaultReliveInfo( sceneId, selfId, "%80", -1, "0", SCENE_DIFU, 20, 38 );
		--清除特殊的复活效果
		SetMissionFlagEx(sceneId,selfId,MFEX_DIE_INDIGONG4_HD,0)
	else
		--传送所有玩家至随机的大理、苏州、洛阳
		CallScriptFunction( 893391, "TransPlayerToHome", sceneId )
	end
end
--**********************************
--是否可进入
--**********************************
function x893390_CanEnter( sceneId,selfId,showTips )
	if x893390_IsInActiveTime( sceneId ) ~= 1 then
		if showTips == 1 then
			x893390_Tips( sceneId, selfId,"#{MJXZ_210510_126}")
		end
		return 0
	end
	if GetLevel(sceneId,selfId) < x893390_g_MinLevel then
		if showTips == 1 then
			x893390_Tips( sceneId, selfId,"#{MJXZ_210510_125}")
		end
		return 0
	end
	if sceneId ~= SCENE_LUOYANG and sceneId ~= SCENE_SUZHOU and sceneId ~= SCENE_DALI and sceneId ~= SCENE_DIFU then
		if showTips == 1 then
			x893390_Tips( sceneId, selfId,"#{MJXZ_210510_165}")
		end
		return 0
	end
	if GetMissionDataEx(sceneId,selfId,MDEX_ENTER_DIGONG_4HD_LASTTIME) == GetTime2Day()
		and sceneId ~= SCENE_DIFU then
		if showTips == 1 then
			x893390_Tips( sceneId, selfId,"#{MJXZ_210510_200}")
		end
		return 0
	end
	
	if sceneId ~= SCENE_DIFU then
		local selfMoney = GetMoney( sceneId, selfId )  +  GetMoneyJZ(sceneId, selfId)
		if selfMoney < x893390_g_CostMoney then
			if showTips == 1 then
				x893390_Tips( sceneId, selfId,"#{MJXZ_210510_242}")
			end
			return 0
		end
		--扣钱
		LuaFnCostMoneyWithPriority( sceneId, selfId, x893390_g_CostMoney)
	end
	
	return 1
end
--**********************************
--是否在活动时间
--**********************************
function x893390_IsInActiveTime( sceneId )
	local curTime = GetHour() * 100 + GetMinute();
	if curTime >= x893390_g_StartTime and curTime < x893390_g_EndTime then
		return 1
	end
	return 0
end
--**********************************
--提示信息
--**********************************
function x893390_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x893390_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

