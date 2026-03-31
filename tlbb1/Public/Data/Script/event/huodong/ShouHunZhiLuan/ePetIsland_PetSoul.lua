--玄武岛兽魂活动

x893342_g_SceneID = 39;					
x893342_g_SceneExID = 41;	
--boss配置
--nType:1灵兽 2荒兽 3神兽
x893342_BossCfgTable = {
	--玄武岛
	[39] = {
		--灵兽
		{
			GenNum = 100,
			Type = 1,
			tMonster = {
				{
					dataId = 50620,
					pos = {
						{228,229},{233,217},{218,219},{214,231},{221,240},{210,240},{199,238},{202,228},{208,218},{215,210},
						{225,208},{236,204},{233,193},{222,193},{211,197},{201,204},{197,214},{188,227},{188,240},{176,239},
						{180,231},{170,233},{166,240},{186,218},{174,221},{163,223},{160,232},{152,239},{149,229},{151,216},
						{139,239},{137,231},{140,220},{131,223},{126,234},{113,239},{104,230},{113,224},{121,220},{121,228},
						{130,212},{135,203},{146,199},{143,210},{156,210},{172,210},{181,205},{191,200},{182,196},{185,187},
						{195,191},{205,184},{193,179},{184,172},{179,157},{167,155},{156,162},{151,169},{143,180},{142,163},
						{150,153},{161,145},{167,131},{170,144},{184,144},{192,159},{193,147},{193,133},{204,136},{209,146},
						{206,156},{213,165},{217,176},{229,180},{237,168},{226,164},{240,157},{228,152},{239,140},{224,138},
						{218,127},{236,128},{229,114},{228,103},{214,110},{202,119},{172,115},{177,100},{188,91},{197,84},
						{181,75},{198,72},{202,58},{213,67},{222,60},{232,58},{232,47},{224,38},{217,51},{213,35}
					}
				}
			}
		},
		--荒兽
		{
			GenNum = 15,
			Type = 2,
			tMonster = {
				{
					dataId = 50619,
					pos = {
						{228,229},{233,217},{218,219},{214,231},{221,240},{210,240},{199,238},{202,228},{208,218},{215,210},
						{225,208},{236,204},{233,193},{222,193},{211,197}					
					}
				}
			}
		},
	},  --SCENE_PETISLAND  --SCENE_PETISLANDPVP
	--玄武岛镜
	[41] = {
		--荒兽
		{
			GenNum = 15,
			Type = 2,
			tMonster = {
				{
					dataId = 50619,
					pos = {
						{103,87},{135,83},{172,95},{175,125},{163,166},{136,168},{183,164},{173,50},{199,65},{143,143},
						{165,113},{189,150},{186,168},{115,114},{128,122}										
					}
				}
			}
		},
		--神兽
		{
			GenNum = 5,
			Type = 3,
			tMonster = {
				{
					dataId = 50614,
					pos = {
						{250,100},										
					}
				},
				{
					dataId = 50615,
					pos = {
						{185,225},										
					}
				},
				{
					dataId = 50616,
					pos = {
						{65,115},										
					}
				},
				{
					dataId = 50617,
					pos = {
						{196,60},										
					}
				},
				{
					dataId = 50618,
					pos = {
						{235,160},										
					}
				},
			}
		},
	},
}
x893342_MonsterBaseAI = 22;
x893342_MonsterExtAIScript = 0;	
x893342_MonsterScriptID = 893343;	
--活动计时用参数
x893342_g_NoticeTick		=	0
--活动ID范围
--x893342_g_ActivityCfg = {
--	[347] = {stateStart = 1},
--	[348] = {stateStart = 5}
--}
--	XWDSSH_20220801_01	#P巫术又起，大量兽魂再次失控！#G玄武岛#P与#G玄武岛·镜#P即将遍布兽魂的心魔，请各位少侠速速前去平息#Y兽魂之乱#P！	
--	XWDSSH_20220801_02	#G玄武岛#P出现第一批大量的#Y兽魂心魔#P！陷入狂乱的#Y荒兽兽魂心魔#P和#Y灵兽兽魂心魔#P已经出现在#G玄武岛#P，而#G玄武岛·镜#P里则出现了陷入狂乱的#Y神兽兽魂心魔#P和#Y荒兽兽魂心魔#P，请速速赶往#G玄武岛#P和#G玄武岛·镜#P与其他侠士平息#Y兽魂之乱#P。	
--	XWDSSH_20220801_03	#G玄武岛#P出现第二批大量的#Y兽魂心魔#P！陷入狂乱的#Y荒兽兽魂心魔#P和#Y灵兽兽魂心魔#P已经出现在#G玄武岛#P，而#G玄武岛·镜#P里则出现了陷入狂乱的#Y神兽兽魂心魔#P和#Y荒兽兽魂心魔#P，请速速赶往#G玄武岛#P和#G玄武岛·镜#P与其他侠士平息#Y兽魂之乱#P。	
--	XWDSSH_20220801_04	#G玄武岛#P出现第三批大量的#Y兽魂心魔#P！陷入狂乱的#Y荒兽兽魂心魔#P和#Y灵兽兽魂心魔#P已经出现在#G玄武岛#P，而#G玄武岛·镜#P里则出现了陷入狂乱的#Y神兽兽魂心魔#P和#Y荒兽兽魂心魔#P，请速速赶往#G玄武岛#P和#G玄武岛·镜#P与其他侠士平息#Y兽魂之乱#P。	
--	XWDSSH_20220801_05	#P各位少侠齐心协力，暂时削减了巫术的影响，#Y兽魂心魔#P也消失了！但是仍不可放松警惕，#Y兽魂之乱#P随时有可能再次发生！	
--**********************************
--角色心跳计时器
--**********************************
function x893342_OnCharacterTimer( sceneId, selfId, dataId, uTime )
	if x893342_BossCfgTable[sceneId] == nil then
		return
	end
	local nCurHour = GetHour()
	if mod(nCurHour,2) == 0 and GetMinute() == 0 and GetSecond() == 0 then
		--到了2小时的周期
		if sceneId == x893342_g_SceneID then
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE, 1)--x893342_g_ActivityCfg[actId].stateStart)
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURTICK, 0)
		end
	end
	
	local curState = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE)
	if curState == 0 then
		return
	end
	local noticeTick = LuaFnGetWorldGlobalData( W_GIDX_LUAUSE_PETISLAND_CURTICK )	
--	print(curState,noticeTick)
	if sceneId == x893342_g_SceneID and curState ~= 0 then
		LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURTICK, noticeTick + 1)
	end
	--刷新客户端UI
	if noticeTick > 0 then
		x893342_OnUpdateClient(sceneId)
	end
	--进入第一阶段
	if noticeTick == 1 then		
		x893342_CreateMonster(sceneId)
		--标记该场景未清理monster
		LuaFnSetNpcIntParameter(sceneId,selfId,0,1)
		if sceneId == x893342_g_SceneID then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{XWDSSH_20220801_01}" );
		end
	end	
	--进入10分阶段
	if noticeTick == 10 * 60 then
		x893342_CreateMonster(sceneId)
		if sceneId == x893342_g_SceneID then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{XWDSSH_20220801_02}" );
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE, curState + 1)
		end
	end
	--进入20分阶段
	if noticeTick == 20 * 60 then
		x893342_CreateMonster(sceneId)
		if sceneId == x893342_g_SceneID then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{XWDSSH_20220801_03}" );
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE, curState + 1)
		end
	end
	--进入30分阶段
	if noticeTick == 30 * 60 then
		x893342_CreateMonster(sceneId)
		if sceneId == x893342_g_SceneID then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{XWDSSH_20220801_04}" );
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE, curState + 1)
		end
	end
	--活动结束
	if noticeTick == 60 * 60 then
		if sceneId == x893342_g_SceneID then
			AddGlobalCountNews( sceneId, "@*;SrvMsg;SCA:#{XWDSSH_20220801_05}" );
			--重置阶段
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE, 0)
			LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURTICK, 0)
		end
		--自身未清理
		if LuaFnGetNpcIntParameter(sceneId,selfId,0) == 1 then
			x893342_DellMonster(sceneId)
			LuaFnSetNpcIntParameter(sceneId,selfId,0,0)
		end
		--关闭所有的客户端可能的UI
		x893342_OnCloseClientUI(sceneId)
	end
end
--**********************************
-- 辅助函数，打乱数组顺序
--**********************************
function shuffle(tbl)
    for i = getn(tbl), 2, -1 do
        local j = random(1, i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end
--**********************************
--创建相关玄武岛BOSS
--**********************************
function x893342_CreateMonster(sceneId)
	if x893342_BossCfgTable[sceneId] == nil then
		return
	end
	for i = 1,getn(x893342_BossCfgTable[sceneId]) do
		local tMonsterGroup = x893342_BossCfgTable[sceneId][i]
		local nCurMonsterCount = x893342_GetMonsterNum(sceneId,tMonsterGroup.Type)
		if nCurMonsterCount < tMonsterGroup.GenNum then
			--场景内数量不满足需要，要创建相关的BOSS
			local nPerMonsterCount = tMonsterGroup.GenNum - nCurMonsterCount
--			print("场景内数量不满足需要，要创建相关的BOSS【类型:%d,预创建数量:%d】",tMonsterGroup.Type,nPerMonsterCount)
			local tMonster = tMonsterGroup.tMonster
			for iMonster = 1,getn(tMonster) do
				local tPos = tMonster[iMonster].pos         
				if getn(tPos) == 1 then
					--仅有一个属于专属坐标
					if x893342_IsMonsterExist(sceneId,tMonster[iMonster].dataId) == 0 and nPerMonsterCount  >0 then
						LuaFnCreateMonster(sceneId, tMonster[iMonster].dataId, tPos[1][1], tPos[1][2], x893342_MonsterBaseAI, x893342_MonsterExtAIScript, x893342_MonsterScriptID )
						nPerMonsterCount = nPerMonsterCount - 1
					end
				elseif getn(tPos) > 1 then
					if nPerMonsterCount >= getn(tPos) then
						--预留数量不够，全部创建
						for iGen = 1,getn(tPos) do
							LuaFnCreateMonster(sceneId, tMonster[iMonster].dataId, tPos[iGen][1], tPos[iGen][2], x893342_MonsterBaseAI, x893342_MonsterExtAIScript, x893342_MonsterScriptID )
							nPerMonsterCount = nPerMonsterCount - 1
						end
					else
						--预留数量多余需要数量，随机不重复创建 这里实现一个洗牌法
                        local idxArr = {}
                        for k = 1, getn(tPos) do idxArr[k] = k end
                        shuffle(idxArr)
                        for iGen = 1, nPerMonsterCount do
                            local nRandIdx = idxArr[iGen]
                            LuaFnCreateMonster(sceneId, tMonster[iMonster].dataId, tPos[nRandIdx][1], tPos[nRandIdx][2], x893342_MonsterBaseAI, x893342_MonsterExtAIScript, x893342_MonsterScriptID)
                        end
                        nPerMonsterCount = 0
					end
				end
			end
		end
	end
end
--**********************************
--获取当前不同类型的boss数量
--**********************************
function x893342_GetMonsterNum(sceneId,nType)
	if x893342_BossCfgTable[sceneId] == nil then
		return 0
	end
	local nMonsterNum = GetMonsterCount(sceneId)
	if nMonsterNum <= 0 then
		return 0
	end
	local nCalcMonsterNum = 0
	for i = 1,getn(x893342_BossCfgTable[sceneId]) do
		if x893342_BossCfgTable[sceneId][i].Type == nType then
			local tMonster = x893342_BossCfgTable[sceneId][i].tMonster
			for j = 0,nMonsterNum-1 do
				local nMonsterObjId = GetMonsterObjID(sceneId,j);
				local nMonsterDataId = GetMonsterDataID( sceneId, nMonsterObjId );
				if LuaFnIsCharacterLiving(sceneId, nMonsterObjId) == 1 then
					for j2 = 1,getn(tMonster) do
						if tMonster[j2].dataId == nMonsterDataId then
							nCalcMonsterNum = nCalcMonsterNum + 1
						end
					end
				end
			end
		end
	end
	return nCalcMonsterNum
end
--**********************************
--检查某个Dataid的boss是否存在
--**********************************
function x893342_IsMonsterExist(sceneId,nDataID)
	local nMonsterNum = GetMonsterCount(sceneId)
	if nMonsterNum <= 0 then
		return 0
	end
	for i = 0,nMonsterNum-1 do
		local nMonsterObjId = GetMonsterObjID(sceneId,i);
		local nMonsterDataId = GetMonsterDataID( sceneId, nMonsterObjId );
		if nDataID == nMonsterDataId then
			if LuaFnIsCharacterLiving(sceneId, nMonsterObjId) == 1 then
				return 1
			end	
		end
	end
	return 0
end
--**********************************
--客户端请求打开UI
--**********************************
function x893342_OnOpenXuanWuDaoUI(sceneId,selfId)
	local noticeTick = LuaFnGetWorldGlobalData( W_GIDX_LUAUSE_PETISLAND_CURTICK )
	if noticeTick > 0 then
		x893342_OnUpdateClient(sceneId)
	end
end
--**********************************
--更新客户端显示UI
--**********************************
function x893342_OnUpdateClient(sceneId)
	local nHumanNum = LuaFnGetCopyScene_HumanCount( sceneId )
	if nHumanNum <= 0 then
		return
	end 
	local nCurLingShou = x893342_GetMonsterNum(sceneId,1)
	local nCurHuangShou = x893342_GetMonsterNum(sceneId,2)
	local nCurShenShou = x893342_GetMonsterNum(sceneId,3)
	local noticeTick = LuaFnGetWorldGlobalData( W_GIDX_LUAUSE_PETISLAND_CURTICK )
	local nCurState = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE)
	for i = 0,nHumanNum - 1 do
		local  nPlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nPlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nPlayerId) == 1 then
			BeginUICommand(sceneId)
			if sceneId == SCENE_PETISLAND then
				UICommand_AddInt( sceneId, 1 )	-- 是玄武岛还是镜	
			else
				UICommand_AddInt( sceneId, 2 )	-- 是玄武岛还是镜	
			end
			UICommand_AddInt( sceneId, nCurLingShou )	 	-- 剩余灵兽
			UICommand_AddInt( sceneId, nCurHuangShou )		-- 剩余荒兽
			UICommand_AddInt( sceneId, nCurShenShou )		-- 剩余神兽	
			UICommand_AddInt( sceneId, GetMissionDataEx( sceneId, nPlayerId, MDEX_PETSOUL_LING) )	    -- 击杀灵兽
			UICommand_AddInt( sceneId, GetMissionDataEx( sceneId, nPlayerId, MDEX_PETSOUL_HUANG) )		-- 击杀荒兽
			UICommand_AddInt( sceneId, GetMissionDataEx( sceneId, nPlayerId, MDEX_PETSOUL_SHEN) )		-- 击杀神兽	
			UICommand_AddInt( sceneId, 60 * 60 - noticeTick  )	  	-- 时间
			UICommand_AddInt( sceneId, nCurState )					-- 阶段 			
			EndUICommand(sceneId)		
			DispatchUICommand(sceneId,nPlayerId,89334201)
		end
	end
end
--**********************************
--关闭客户端显示UI
--**********************************
function x893342_OnCloseClientUI(sceneId)
	local nHumanNum = LuaFnGetCopyScene_HumanCount( sceneId )
	if nHumanNum <= 0 then
		return
	end 
	for i = 0,nHumanNum - 1 do
		local  nPlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nPlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nPlayerId) == 1 then
			BeginUICommand(sceneId)
				UICommand_AddInt( sceneId, 0 )	
			EndUICommand(sceneId)		
			DispatchUICommand(sceneId,nPlayerId,89334201)
		end
	end
end
--**********************************
-- 删除场景活动怪物(玄武岛兽魂活动专用)
--**********************************
function x893342_DellMonster(sceneId)
    -- 获取场景全部怪物数量
    local nMonsterCount = GetMonsterCount(sceneId)
    if nMonsterCount <= 0 then
        return
    end

    -- 检查配置表是否存在
    if x893342_BossCfgTable[sceneId] == nil then
        return
    end

    -- 生成需要清理的dataId列表
    local tCleanDataIDs = {}
    for iGroup = 1, getn(x893342_BossCfgTable[sceneId]) do
        local tMonsterGroup = x893342_BossCfgTable[sceneId][iGroup]
        if tMonsterGroup.tMonster then
            for iMonster = 1, getn(tMonsterGroup.tMonster) do
                local tMonster = tMonsterGroup.tMonster[iMonster]
                if tMonster.dataId then
                    tCleanDataIDs[tMonster.dataId] = 1  -- 标记需要清理的dataId
                end
            end
        end
    end

    -- 遍历场景怪物，记录需要删除的ObjID
    local tRemoveList = {}
    for nIndex = 0, nMonsterCount - 1 do
        local nMonsterObjID = GetMonsterObjID(sceneId, nIndex)
        local nDataID = GetMonsterDataID(sceneId, nMonsterObjID)
        if tCleanDataIDs[nDataID] ~= nil then
            tinsert(tRemoveList, nMonsterObjID)  -- 将需要删除的ObjID加入列表
        end
    end

    -- 批量删除怪物
    for i = 1, getn(tRemoveList) do
        LuaFnDeleteMonster(sceneId, tRemoveList[i])  -- 删除怪物
    end

    -- 系统广播清理结果
--    AddGlobalCountNews(sceneId, "#G玄武岛兽魂活动怪物清理完成，共移除" .. getn(tRemoveList) .. "只心魔")
end

