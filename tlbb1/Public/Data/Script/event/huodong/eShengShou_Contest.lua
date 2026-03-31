--圣兽山宝箱争夺

--脚本号
x808066_g_ScriptId	= 808066

--NPC大宝箱
x808066_g_BigBox = {

	Name			= "白蟒宝箱",
	MonsterID	= 5011,
	PosX			= 142,
	PosY			= 112,
	ScriptID	= 808067

}

--当前的大宝箱是否存在....1存在 0不存在
W_GIDX_LUAUSE_ISBIGBOXEXIST = 62
--当前是否有人在开启大宝箱....
W_GIDX_LUAUSE_ISBIGBOXOPENING = 63
--正在开启宝箱玩家的场景临时ID....
W_GIDX_LUAUSE_ISBIGBOXPLAYERID = 64
--正在开宝箱的人开始开宝箱的时间....
W_GIDX_LUAUSE_PLAYEROPENINGTIME = 65

--技能书ID
x808066_g_SkillBooks = {

			30402051,
			30402052,
			30402053,
			30402054,
			30402012,
			30402014,
			30402016,
			30402018,
			30402020,
			30402088,
			30402090,
			30402026,
			30402030,
			30402032,
			30402034,
			30402036,
			30402038,
			30402040,
			30402042,
			30402044,
			30402046,
			30402048,
			30402050,
			30402056,
			30402060,
			30402062,
			30402064,
			30402066,
			30402068,
			30402070,
			30402072,
			30402074
}

x808066_g_SkillBooksNormal = {

			30402051,
			30402052,
			30402053,
			30402054,
			30402012,
			30402014,
			30402016,
			--30402018,
			30402020,
			--30402088,
			--30402090,
			--30402026,
			30402030,
			30402032,
			30402034,
			30402036,
			30402038,
			--30402040,
			30402042,
			30402044,
			--30402046,
			30402048,
			30402050,
			--30402056,
			--30402060,
			30402062,
			30402064,
			30402066,
			--30402068,
			30402070,
			--30402072,
			30402074
}

--开出的BOSS的数据表....
x808066_g_BOSSData = {

	{ ID = 3845, PosX = 144, PosY = 112, BaseAI = 15, ExtAIScript = 0, ScriptID = -1, PatrolId = 0 },
	{ ID = 3846, PosX = 140, PosY = 112, BaseAI = 15, ExtAIScript = 0, ScriptID = -1, PatrolId = 1 },
	{ ID = 3847, PosX = 140, PosY = 113, BaseAI = 15, ExtAIScript = 0, ScriptID = -1, PatrolId = 2 },
	{ ID = 3848, PosX = 144, PosY = 113, BaseAI = 15, ExtAIScript = 0, ScriptID = -1, PatrolId = 3 },

}

--掉落包坐标....有多少坐标就掉多少掉落包....
x808066_g_DropBox = {

	{ PosX = 135, PosY = 108 },
	{ PosX = 136, PosY = 112 },
	{ PosX = 138, PosY = 108 },
	{ PosX = 143, PosY = 113 },
	{ PosX = 146, PosY = 109 },
	{ PosX = 147, PosY = 109 },

	{ PosX = 135, PosY = 113 },
	{ PosX = 137, PosY = 113 },
	{ PosX = 138, PosY = 114 },
	{ PosX = 143, PosY = 115 },
	{ PosX = 146, PosY = 112 },
	{ PosX = 147, PosY = 113 },

	{ PosX = 135, PosY = 115 },
	{ PosX = 137, PosY = 115 },
	{ PosX = 138, PosY = 116 },
	{ PosX = 143, PosY = 117 },
	{ PosX = 146, PosY = 114 },
	{ PosX = 147, PosY = 115 },

	{ PosX = 135, PosY = 117 },
	{ PosX = 147, PosY = 117 },

}

--掉落包的物品掉落表....
x808066_g_DropBoxItem = {
	--兔兔的书签
	{ odds = 100, itemId =38002809, itemNum = 5 },
}

--给开箱人的特殊奖励
x808066_g_SpecialToOpenBox = {
	--暴·穿冰属性书
	{ itemId =30700226, itemNum = 1 },
	--暴·暗火属性书
	{ itemId =30700227, itemNum = 1 },
	--暴·冲玄属性书
	{ itemId =30700228, itemNum = 1 },
	--暴·拔毒属性书
	{ itemId =30700229, itemNum = 1 },
	--兔兔的书签
	{ itemId =38002809, itemNum = 20 },
}

--**********************************
--事件交互入口
--**********************************
function x808066_OnDefaultEvent( sceneId, actId, param1, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	--不管是否创建新的大宝箱都发公告....
	local message = format("@*;SrvMsg;SCA:#{ShengShouBigBoxNotice}" )
	AddGlobalCountNews( sceneId, message )

	--雷电交加天气效果....
	local curWeather = LuaFnGetSceneWeather(sceneId)
	if not curWeather or curWeather ~= -1 then
		--已经有天气了则不改变天气....
	else
		LuaFnSetSceneWeather(sceneId, 3, 5*60*1000 )
	end
	
	--如果已经有了就不再创建新的大宝箱....
	if LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXEXIST) == 1 then
		--确实不存在宝箱 这里要考虑重启后W_GIDX_LUAUSE_ISBIGBOXEXIST的状态依然为1的情况
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID( sceneId, MonsterId )
			if MosDataID == x808066_g_BigBox.MonsterID then
				return
			end
		end
	end

	--没有则创建NPC大宝箱....
	local MstId = LuaFnCreateMonster(sceneId, x808066_g_BigBox.MonsterID, x808066_g_BigBox.PosX, x808066_g_BigBox.PosY, 3, 0, x808066_g_BigBox.ScriptID )
	SetCharacterName( sceneId, MstId, x808066_g_BigBox.Name )
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXEXIST,1)

end

--**********************************
--检测是否可以打开大宝箱....
--**********************************
function x808066_CheckOpenBigBox( sceneId, selfId )

	--宝箱是否存在....
	if LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXEXIST) == 0 then
		return 0, "(ERROR)"
	end

	--如果有人正在开大宝箱....
	if LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXOPENING) == 1 then

		--如果是自己在开....
		if LuaFnGetName(sceneId,LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXPLAYERID)) == LuaFnGetName( sceneId, selfId ) then
			return 1, "(ERROR)"
		end

		--如果是别人在开并且他已经超时了....则让位给我来开....
		local NowTime = LuaFnGetCurrentTime()
		if (NowTime - LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_PLAYEROPENINGTIME)) > 150 then
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PLAYEROPENINGTIME,NowTime)
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXPLAYERID,selfId)
			return 1, "(ERROR)"
		else
			return -1, LuaFnGetName(sceneId,LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXPLAYERID))
		end

	end

	--没有人在开大宝箱....
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXOPENING,1)
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PLAYEROPENINGTIME,LuaFnGetCurrentTime())
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXPLAYERID,selfId)
	return 1, "(ERROR)"

end

--**********************************
--玩家开大宝箱被打断事件(由大宝箱脚本调用)....
--**********************************
function x808066_OnCancelOpen( sceneId )

	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXOPENING,0)
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXPLAYERID,0)
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PLAYEROPENINGTIME,0)

end

--**********************************
--大宝箱被打开事件(由大宝箱脚本调用)....
--**********************************
function x808066_OnBigBoxOpen( sceneId, selfId, activatorId )

	local rand = random(100)
--	if rand <= 33 then
		--开出技能书....
		x808066_GiveSkillBook( sceneId, selfId, activatorId )
--	elseif rand <= 66 then
		--开出BOSS....
--		x808066_GiveBOSS( sceneId, selfId, activatorId )
--	else
		--开出一堆掉落包....
		x808066_GiveDropBox( sceneId, selfId, activatorId )
--	end

	--kill大宝箱....大宝箱死亡动画为打开盖子....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 169, 0);
	LuaFnGmKillObj( sceneId, activatorId, selfId )

	--统计....
	LuaFnAuditShengShouOpenBigBox(sceneId, activatorId)

	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXEXIST,0)
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXOPENING,0)
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_ISBIGBOXPLAYERID,0)
	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PLAYEROPENINGTIME,0)

end

--**********************************
--大宝箱被打开事件_给技能书....
--**********************************
function x808066_GiveSkillBook( sceneId, selfId, activatorId )

	--随机给玩家一本技能书....并公告....
	local rand = random(100)
	
	local numBooks
	local randBook
	local BookID
	
	if (rand < 80) then			--80%几率在所有可能掉落的书里随机
		numBooks = getn(x808066_g_SkillBooks)
		randBook = random(numBooks)
		BookID = x808066_g_SkillBooks[ randBook ]
	else										--20%不包括10本特定技能
		numBooks = getn(x808066_g_SkillBooksNormal)
		randBook = random(numBooks)
		BookID = x808066_g_SkillBooksNormal[ randBook ]
	end

	--给物品并公告....
--	local BagIndex = TryRecieveItem( sceneId, activatorId, BookID, QUALITY_MUST_BE_CHANGE )
--	if BagIndex ~= -1 then
--
--		BeginEvent( sceneId )
--			AddText( sceneId, "你获得了一个#{_ITEM"..BookID.."}" )
--		EndEvent( sceneId )
--		DispatchMissionTips( sceneId, activatorId )
--
--		--公告....
--		local ItemTransfer = GetBagItemTransfer(sceneId,activatorId,BagIndex)
--		local PlayerName = GetName(sceneId, activatorId)
--		local str = format( "#W#{_INFOUSR%s}#P在#G圣兽山#P举烟放火不小心熏了眼睛，模糊之中撞在#Y大宝箱#P上，打开一看，竟然是一本#{_INFOMSG%s}。", PlayerName, ItemTransfer )
--		BroadMsgByChatPipe( sceneId, activatorId, str, 4 )
--
--	end
	--兔兔的书签
	local tRand = x808066_g_SpecialToOpenBox[random(1,getn(x808066_g_SpecialToOpenBox))]
	local nRet,strMutilTrans = LuaFnTryRecieveMultiItem( sceneId, activatorId, tRand.itemId, QUALITY_MUST_BE_CHANGE,tRand.itemNum,0 )
	if nRet == 1 then

		BeginEvent( sceneId )
			AddText( sceneId, "你获得了"..tostring(tRand.itemNum).."个#{_ITEM"..tRand.itemId.."}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, activatorId )

		--公告....
		local PlayerName = GetName(sceneId, activatorId)
		local str = format( "#W#{_INFOUSR%s}#P在#G圣兽山#P举烟放火不小心熏了眼睛，模糊之中撞在#Y大宝箱#P上，打开一看，竟然是%d个#{_INFOMSG%s}。", PlayerName, tRand.itemNum,strMutilTrans )
		BroadMsgByChatPipe( sceneId, activatorId, str, 4 )

	end

	--kill大宝箱....大宝箱死亡动画为打开盖子....
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 169, 0);
	LuaFnGmKillObj( sceneId, activatorId, selfId )

end

--**********************************
--大宝箱被打开事件_开出BOSS....
--**********************************
function x808066_GiveBOSS( sceneId, selfId, activatorId )

	--刷BOSS....
	local MstId
	for _, BOSSData in x808066_g_BOSSData do
		MstId = LuaFnCreateMonster(sceneId, BOSSData.ID, BOSSData.PosX, BOSSData.PosY, BOSSData.BaseAI, BOSSData.ExtAIScript, BOSSData.ScriptID )
		SetCharacterDieTime(sceneId, MstId, 2*60*60*1000 )
		SetPatrolId(sceneId, MstId, BOSSData.PatrolId)
	end

	--公告....
	local PlayerName = GetName(sceneId, activatorId)
	local str = format( "#G圣兽山#P上群英夺宝，唯#W#{_INFOUSR%s}#P技高一筹，混战之中一掌将#Y白蟒宝箱#P打翻，不料竟跳出四个#W宝箱童子#P！", PlayerName )
	BroadMsgByChatPipe( sceneId, activatorId, str, 4 )

end

--**********************************
--大宝箱被打开事件_掉落一堆掉落包....
--**********************************
function x808066_GiveDropBox( sceneId, selfId, activatorId )

	--计算总权重....
	local totalOdds = 0
	for _, item in x808066_g_DropBoxItem do
		totalOdds = totalOdds  + item.odds
	end
	if totalOdds < 1 then
		return
	end

	--给掉落包....
	local BoxId = -1
	local DropItemId = -1
	local DropItemCount = 0
	local randValue = 0
	local DropBoxCount = 0
	for _, box in x808066_g_DropBox do

		--计算本包掉落的物品....
		randValue = random(1, totalOdds);
		randValue = randValue - 1;
		for _, item in x808066_g_DropBoxItem do
			if item.odds >= randValue then
				DropItemId = item.itemId;
				DropItemCount = item.itemNum
				break;
			end
			randValue = randValue - item.odds;
		end

		--放掉落包到场景里....
		if DropItemId > 0 then
			BoxId = DropBoxEnterScene( box.PosX, box.PosY, sceneId )
			if BoxId > -1 then
				AddMutilItemToBox(sceneId,BoxId,DropItemId,DropItemCount,QUALITY_CREATE_BY_BOSS)
				
				DropBoxCount = DropBoxCount + 1
			end
		end
		--最多掉落10个
		if DropBoxCount >= 10 then
			break
		end
	end
	
	--公告....
	local PlayerName = GetName(sceneId, activatorId)
	local str = format( "#G圣兽山#P上#W#{_INFOUSR%s}#P在群豪推举之下打开#Y白蟒宝箱#P，只见金光闪过、遍地财宝、欢声一片。", PlayerName )
	BroadMsgByChatPipe( sceneId, activatorId, str, 4 )

end

function x808066_OnPlayerPickUpItemInBoar( sceneId, selfId, itemId, bagidx )

	--公告....
	if itemId == 40004429 then

		local playerName = GetName(sceneId, selfId)
		local transfer = GetBagItemTransfer(sceneId,selfId,bagidx)
		local str = format( "#{BoarItem_Info_001}#{_INFOUSR%s}#{BoarItem_Info_002}#{_INFOMSG%s}#{BoarItem_Info_003}", playerName, transfer)

		BroadMsgByChatPipe(sceneId, selfId, str, 4)

	end
	
end
