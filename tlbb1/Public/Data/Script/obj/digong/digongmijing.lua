--地宫秘境主逻辑脚本
x891147_g_ScriptId = 891147
--是否启用
x891147_g_IsOpen = 0
--可进入的最低等级
x891147_g_MinLevel = 60
--预备提示时间
x891147_g_TipsTime = 1955
--开始及终止时间
x891147_g_StartTime = 2000
x891147_g_EndTime = 2040
--生成轮次
x891147_g_Tick1 = 2010
x891147_g_Tick2 = 2020
--怪物分布
x891147_g_BossTab = {
	--秘境1 秦俑伍长
	[SCENE_ID_DIGONG_1HD] = {
		monsterDataId = 49254,	
		pos = {{159.0505, 145.6739},
				{168.5296, 149.1663},
				{161.6191, 127.7857},
				{176.8078, 136.2253},
				{178.2617, 149.5460},
				{204.1900, 152.3038},
				{206.3539, 219.7509},
				{175.3010, 210.7062},
				{184.9914, 178.7898},
				{159.8497, 176.2286},
				{114.2522, 168.2836},
				{104.3862, 179.9958},
				{98.2926, 197.3564},
				{111.0069, 139.4830},
				{112.5966, 121.2504},
				{86.2338, 122.5932},
				{76.5668, 155.6453},
				{52.2017, 161.7340},
				{68.1418, 208.9984},
				{32.3743, 214.2874},
				{54.2601, 223.8860},
				{27.6069, 182.5574},
				{28.6453, 115.5865},
				{37.1269, 98.9859},
				{25.9904, 84.7972},
				{43.8663, 78.2224},
				{62.6310, 82.1149},
				{78.1768, 86.2719},
				{114.9333, 84.7742},
				{150.5059, 82.5463},
				{173.1458, 81.1042},
				{225.3329, 66.8057},
				{215.5772, 28.8354},
				{184.9072, 61.1431},
				{180.1605, 50.6404},
				{192.5666, 36.1326},
				{160.7965, 31.8252},
				{151.2437, 45.0055},
				{146.9339, 40.7823},
				{122.8823, 34.5746},
				{82.7561, 45.7153},
				{69.7750, 43.8386},
				{66.7449, 32.7855},
				{89.0724, 52.6779},
				{115.7288, 33.8676}
		}
	},
	--秘境2 秦俑什长
	[SCENE_ID_DIGONG_2HD] = {
		monsterDataId = 49256,	
		pos = {{191.4214,226.1600},
				{142.4110,226.3405},
				{80.4425,219.8585},
				{85.4521,228.7091},
				{68.3058,212.8684},
				{47.9411,204.0051},
				{52.5547,194.5456},
				{41.8949,200.0641},
				{54.4654,229.0795},
				{87.7346,222.7932},
				{23.2778,214.2114},
				{25.9594,189.4117},
				{35.1975,196.4848},
				{43.1608,212.0952},
				{24.4642,171.2468},
				{32.6820,154.4439},
				{26.8953,141.3198},
				{68.7985,120.2825},
				{57.5702,113.4692},
				{45.6311,138.3445},
				{25.8296,112.9494},
				{30.8553,92.3361},
				{42.7718,29.6090},
				{24.9111,41.7967},
				{79.6126,44.4976},
				{53.5568,82.9138},
				{25.7699,55.5771},
				{168.6685,155.9853},
				{207.3437,143.6255},
				{185.5432,160.1953},
				{146.6611,143.1097},
				{152.5242,188.6612},
				{131.8094,166.1039},
				{121.4390,135.9901},
				{109.8203,105.9587},
				{136.0715,55.2296},
				{116.0172,74.8969},
				{150.5774,97.0291},
				{211.2910,118.1582},
				{214.7226,74.8633},
				{168.5667,65.6129},
				{154.3032,83.7444},
				{192.8390,74.1756},
				{227.7950,55.7712},
				{222.2964,35.8305},
				{187.9017,30.1632},
				{179.5012,38.6512},
				{203.6310,48.3233},
				{167.6395,43.5031},
				{157.8888,28.6740}
		}
	},
	--秘境3 秦俑什长
	[SCENE_ID_DIGONG_3HD] = {
		monsterDataId = 49256,	
		pos = {{209.8085,208.5057},
				{196.4497,216.1975},
				{193.8749,221.1439},
				{184.8562,219.3203},
				{176.3514,221.8912},
				{181.3945,215.1636},
				{225.3306,179.2907},
				{214.7948,196.298},
				{209.4691,175.7348},
				{209.1701,193.7947},
				{192.5302,187.8438},
				{187.3832,177.3928},
				{213.0419,87.9009},
				{212.5131,92.6711},
				{212.5731,98.4141},
				{206.8914,102.7119},
				{222.9678,105.876},
				{232.9047,112.1612},
				{215.6078,122.1246},
				{231.9706,84.2088},
				{227.5481,70.7979},
				{214.9513,65.9383},
				{209.6586,128.3418},
				{218.3848,145.3787},
				{230.7866,146.5949},
				{45.794,85.4119},
				{45.7986,88.9059},
				{46.5381,97.0987},
				{51.7054,92.8433},
				{42.699,79.5115},
				{43.0164,102.5648},
				{55.3664,78.0876},
				{53.0838,69.6224},
				{28.3903,65.7289},
				{38.5754,109.9135},
				{49.1859,116.9869},
				{45.0192,127.2429},
				{127.9849,86.0342},
				{120.2556,88.4539},
				{149.7218,65.0963},
				{156.9048,65.6898},
				{170.8611,74.4557},
				{172.3477,87.9727},
				{138.5016,98.3725},
				{121.2578,98.8434},
				{98.7966,93.0985},
				{114.2563,64.201},
				{94.5307,85.6822},
				{101.7146,60.7256},
				{87.2643,61.817}
		}
	},
}
--场景参数
x891147_g_Param_SceneState = 0	--场景状态
--**********************************
--场景计时器[tick 1s]
--**********************************
function x891147_OnSceneTimer( sceneId )
	if x891147_g_IsOpen == 0 then
		return
	end
	local curTime = GetHour() * 100 + GetMinute();
	if curTime == x891147_g_TipsTime and GetSecond() == 0 then
		if sceneId == SCENE_ID_DIGONG_1HD then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{MJXZ_210510_01}" )
		end
	end
	--生成第一批monster
	if curTime == x891147_g_StartTime and GetSecond() == 0 then
		if sceneId == SCENE_ID_DIGONG_1HD then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{MJXZ_210510_02}" )
		end
		x891147_CreateMonster( sceneId)
	end
	--其他轮次
	if (curTime == x891147_g_Tick1 or curTime == x891147_g_Tick2) and GetSecond() == 0 then
		x891147_CreateMonster( sceneId)
	end
	--结束
	if curTime == x891147_g_EndTime and GetSecond() == 0 then
		if sceneId == SCENE_ID_DIGONG_1HD then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{MJXZ_210510_06}" )
		end
		--传送所有玩家至随机的大理、苏州、洛阳
		CallScriptFunction( 893391, "TransPlayerToHome", sceneId )
	end
	--未在活动时间
	local nCurState = x891147_GetCurActivityState( sceneId)
	if nCurState == 0 or nCurState == 4 then
		--传送所有玩家至随机的大理、苏州、洛阳
		CallScriptFunction( 893391, "TransPlayerToHome", sceneId )
	end
	--更新面板信息
	x891147_UpdateQinHuangTime( sceneId )
end
--**********************************
--获取当前活动状态
--0、4:不在活动时间 1:20:10 2:20:20	3:秦俑已全部刷新
--**********************************
function x891147_GetCurActivityState( sceneId)
	local curTime = GetHour() * 100 + GetMinute();
	--结束
	if curTime < x891147_g_StartTime then
		return 0
	end
	if curTime >= x891147_g_EndTime then
		return 4
	end
	if curTime < x891147_g_Tick1 then
		return 1
	end
	if curTime < x891147_g_Tick2 then
		return 2
	end
	return 3
end
--**********************************
--玩家进入场景
--**********************************
function x891147_OnPlayerEnterScene( sceneId,selfId,isReconnect)
	if x891147_g_BossTab[sceneId] == nil then
		return
	end
	local curTime = GetHour() * 100 + GetMinute();
	if curTime >= x891147_g_StartTime and curTime < x891147_g_EndTime then
		--地宫1-3专用UI
		local nMonsterNum = GetMonsterCount(sceneId)
		local nHaveMonster = 0
		for i=0, nMonsterNum-1 do
			local nMonsterId = GetMonsterObjID(sceneId,i)
			local nMonsterDataId = GetMonsterDataID(sceneId,nMonsterId)
			if nMonsterDataId == x891147_g_BossTab[sceneId].monsterDataId then
				nHaveMonster = nHaveMonster + 1
			end
		end
		
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1)	--1:show 2:update 3:hide
			UICommand_AddInt( sceneId, sceneId )
			UICommand_AddInt( sceneId, x891147_GetCurActivityState( sceneId) )
			UICommand_AddInt( sceneId, nHaveMonster )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20210510 )
		
		--特殊保护效果
		if isReconnect == 0 then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5969, 100 )
			if sceneId == SCENE_ID_DIGONG_1HD then
				x891147_Tips( sceneId, selfId, "#{MJXZ_210510_160}" )
			end
			if sceneId == SCENE_ID_DIGONG_2HD then
				x891147_Tips( sceneId, selfId, "#{MJXZ_210510_161}" )
			end
			if sceneId == SCENE_ID_DIGONG_3HD then
				x891147_Tips( sceneId, selfId, "#{MJXZ_210510_162}" )
			end
		end
	else
		--传送所有玩家至随机的大理、苏州、洛阳
		CallScriptFunction( 893391, "TransPlayerToHome", sceneId )
	end
end
--**********************************
--更新面板信息
--**********************************
function x891147_UpdateQinHuangTime( sceneId )
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount <= 0 then
		return
	end
	
	local nMonsterNum = GetMonsterCount(sceneId)
	local nHaveMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		local nMonsterDataId = GetMonsterDataID(sceneId,nMonsterId)
		if nMonsterDataId == x891147_g_BossTab[sceneId].monsterDataId then
			nHaveMonster = nHaveMonster + 1
		end
	end

	for i = 0,nHumanCount - 1 do
		local nHumanID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanID) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanID) == 1 then
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, 2)	--1:show 2:update 3:hide
				UICommand_AddInt( sceneId, sceneId )
				UICommand_AddInt( sceneId, x891147_GetCurActivityState( sceneId) )
				UICommand_AddInt( sceneId, nHaveMonster )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, nHumanID, 20210510 )
		end
	end
end
--**********************************
--按场景进行陶俑创建
--**********************************
function x891147_CreateMonster( sceneId)
	if x891147_g_BossTab[sceneId] == nil then
		return
	end
	--单轮次最多50个
	local nMonsterNum = GetMonsterCount(sceneId)
	if nMonsterNum >= 50 then
		return
	end
	local tPos = x891147_g_BossTab[sceneId].pos
	local nGenNum = getn(tPos) - nMonsterNum;
	if nGenNum <= 0 then
		return
	end
	for i = 1,nGenNum do
		local nMonsterId = CreateMonsterWithDir( sceneId,
			x891147_g_BossTab[sceneId].monsterDataId ,
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
--是否可进入
--**********************************
function x891147_CanEnter( sceneId,selfId,showTips )
	if x891147_IsInActiveTime( sceneId ) ~= 1 then
		if showTips == 1 then
			x891147_Tips( sceneId, selfId,"#{MJXZ_210510_157}")
		end
		return 0
	end
	if GetLevel(sceneId,selfId) < x891147_g_MinLevel then
		if showTips == 1 then
			x891147_Tips( sceneId, selfId,"#{MJXZ_210510_158}")
		end
		return 0
	end
--	if sceneId ~= SCENE_LUOYANG and sceneId ~= SCENE_SUZHOU and sceneId ~= SCENE_DALI then
--		if showTips == 1 then
--			x891147_Tips( sceneId, selfId,"#{MJXZ_210510_159}")
--		end
--		return 0
--	end
	--【运营修改】暂时关闭地宫秘境1-3
	x891147_Tips( sceneId, selfId,"秦宫秘境一层、二层、三层暂时关闭，请少侠前往第四层参加活动。")
	return 0
--	return 1
end
--**********************************
--是否在活动时间
--**********************************
function x891147_IsInActiveTime( sceneId )
	local curTime = GetHour() * 100 + GetMinute();
	if curTime >= x891147_g_StartTime and curTime < x891147_g_EndTime then
		return 1
	end
	return 0
end
--**********************************
--提示信息
--**********************************
function x891147_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示信息
--**********************************
function x891147_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

