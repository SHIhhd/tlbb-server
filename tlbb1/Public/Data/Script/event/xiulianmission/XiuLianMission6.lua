--MisDescBegin
x891279_g_ScriptId = 891279
x891279_g_MainScriptId = 891272	--主脚本号
x891279_g_NpcScriptId = 891273	--npc脚本号
x891279_g_ShopScriptId = 891271	--shop脚本号

x891279_g_KDZZID = 1006000536
x891279_g_KDZZSubID = 6

--任务号
x891279_g_MissionId = 2035
x891279_g_MissionKind = 7
x891279_g_MissionLevel = 60
x891279_g_IfMissionElite = 0

--任务名
x891279_g_MissionName="#{XLRW_210725_477}"
x891279_g_MissionTarget=""
x891279_g_Custom = {}

--任务参数
x891279_g_IsMissionOkFail = 0	--是否完成
x891279_g_MissionLiuPai = 1		-- 本流派
x891279_g_MissionMenPai = 2		-- 本门派
x891279_g_MissionItemId = 3		-- 道具id
x891279_g_MissionNpcIdx = 4		-- 目标NPC
x891279_g_MissionGetItem = 5	-- 获得道具
x891279_g_MissionItemNum = 6	-- 道具数量

--npc距离
x891279_g_NpcDist = 5

--背包空位
x891279_g_BagSpace = 1

--奖励
--x891279_g_MoneyJZBonus					= 30000
--x891279_g_ExpBonus						= 250000

--MisDescEnd
x891279_g_MenPaiTargetNpc = { 
		[0] = { 
				[1] = { npcname = "玄渡", namestr = "#{XLRW_210725_347}", strlink = "#{XLRW_210725_549}"}, 
				[2] = { npcname = "玄慈", namestr = "#{XLRW_210725_348}", strlink = "#{XLRW_210725_550}"}, 
				[3] = { npcname = "玄寂", namestr = "#{XLRW_210725_349}", strlink = "#{XLRW_210725_551}"}, 
				[4] = { npcname = "玄难", namestr = "#{XLRW_210725_350}", strlink = "#{XLRW_210725_552}"}, 
				[5] = { npcname = "玄灭", namestr = "#{XLRW_210725_352}", strlink = "#{XLRW_210725_554}"}, 
				[6] = { npcname = "玄鸣", namestr = "#{XLRW_210725_353}", strlink = "#{XLRW_210725_555}"}, 
				},
		[1] = {
				[1] = { npcname = "林岩", namestr = "#{XLRW_210725_361}", strlink = "#{XLRW_210741_563}"}, 
				[2] = { npcname = "方百花", namestr = "#{XLRW_210725_362}", strlink = "#{XLRW_210741_564}"}, 
				[3] = { npcname = "方腊", namestr = "#{XLRW_210725_363}", strlink = "#{XLRW_210741_565}"}, 
				[4] = { npcname = "玛拉", namestr = "#{XLRW_210725_364}", strlink = "#{XLRW_210741_566}"}, 
				[5] = { npcname = "方天定", namestr = "#{XLRW_210725_365}", strlink = "#{XLRW_210741_567}"}, 
				[6] = { npcname = "厉天佑", namestr = "#{XLRW_210725_366}", strlink = "#{XLRW_210741_568}"}, 
				},
		[2] = {
				[1] = { npcname = "奚三祁", namestr = "#{XLRW_210725_354}", strlink = "#{XLRW_210733_556}"}, 
				[2] = { npcname = "吴长风", namestr = "#{XLRW_210725_355}", strlink = "#{XLRW_210733_557}"}, 
				[3] = { npcname = "上官长雨", namestr = "#{XLRW_210725_356}", strlink = "#{XLRW_210733_558}"}, 
				[4] = { npcname = "张全祥", namestr = "#{XLRW_210725_358}", strlink = "#{XLRW_210733_560}"}, 
				[5] = { npcname = "宋慈", namestr = "#{XLRW_210725_359}", strlink = "#{XLRW_210733_561}"}, 
				[6] = { npcname = "白世镜", namestr = "#{XLRW_210725_360}", strlink = "#{XLRW_210733_562}"}, 
				},
		[3] = {
				[1] = { npcname = "张玄素", namestr = "#{XLRW_210725_368}", strlink = "#{XLRW_210749_570}"}, 
				[2] = { npcname = "俞远山", namestr = "#{XLRW_210725_369}", strlink = "#{XLRW_210749_571}"}, 
				[3] = { npcname = "鹤云道人", namestr = "#{XLRW_210725_370}", strlink = "#{XLRW_210749_572}"}, 
				[4] = { npcname = "莫太冲", namestr = "#{XLRW_210725_372}", strlink = "#{XLRW_210749_574}"}, 
				[5] = { npcname = "林灵素", namestr = "#{XLRW_210725_373}", strlink = "#{XLRW_210749_575}"}, 
				[6] = { npcname = "张中行", namestr = "#{XLRW_210725_374}", strlink = "#{XLRW_210749_576}"}, 
				},
		[4] = {
				[1] = { npcname = "崔绿华", namestr = "#{XLRW_210725_389}", strlink = "#{XLRW_210773_591}"}, 
				[2] = { npcname = "杨四娘", namestr = "#{XLRW_210725_390}", strlink = "#{XLRW_210773_592}"}, 
				[3] = { npcname = "孟青青", namestr = "#{XLRW_210725_392}", strlink = "#{XLRW_210773_594}"}, 
				[4] = { npcname = "孟龙", namestr = "#{XLRW_210725_393}", strlink = "#{XLRW_210773_595}"}, 
				[5] = { npcname = "孙二娘", namestr = "#{XLRW_210725_394}", strlink = "#{XLRW_210773_596}"}, 
				[6] = { npcname = "李十二娘", namestr = "#{XLRW_210725_395}", strlink = "#{XLRW_210773_597}"}, 
				},
		[5] = {
				[1] = { npcname = "丁春秋",  namestr = "#{XLRW_210725_396}", strlink = "#{XLRW_210781_598}"}, 
				[2] = { npcname = "韩世忠", namestr = "#{XLRW_210725_397}", strlink = "#{XLRW_210781_599}"}, 
				[3] = { npcname = "红玉", namestr = "#{XLRW_210725_398}", strlink = "#{XLRW_210781_600}"}, 
				[4] = { npcname = "出尘子", namestr = "#{XLRW_210725_399}", strlink = "#{XLRW_210781_601}"}, 
				[5] = { npcname = "施全", namestr = "#{XLRW_210725_400}", strlink = "#{XLRW_210781_602}"}, 
				[6] = { npcname = "王彦", namestr = "#{XLRW_210725_402}", strlink = "#{XLRW_210781_604}"}, 
				},
		[6] = {
				[1] = { npcname = "本因", namestr = "#{XLRW_210725_375}", strlink = "#{XLRW_210757_577}"}, 
				[2] = { npcname = "本观", namestr = "#{XLRW_210725_376}", strlink = "#{XLRW_210757_578}"}, 
				[3] = { npcname = "本相", namestr = "#{XLRW_210725_377}", strlink = "#{XLRW_210757_579}"}, 
				[4] = { npcname = "本凡", namestr = "#{XLRW_210725_378}", strlink = "#{XLRW_210757_580}"}, 
				[5] = { npcname = "破嗔", namestr = "#{XLRW_210725_380}", strlink = "#{XLRW_210757_582}"}, 
				[6] = { npcname = "盛如兰", namestr = "#{XLRW_210725_381}", strlink = "#{XLRW_210757_583}"}, 
				},
		[7] = {
				[1] = { npcname = "乌老大", namestr = "#{XLRW_210725_404}", strlink = "#{XLRW_210789_606}"}, 
				[2] = { npcname = "竹剑", namestr = "#{XLRW_210725_405}", strlink = "#{XLRW_210789_607}"}, 
				[3] = { npcname = "兰剑", namestr = "#{XLRW_210725_406}", strlink = "#{XLRW_210789_608}"}, 
				[4] = { npcname = "梅剑", namestr = "#{XLRW_210725_407}", strlink = "#{XLRW_210789_609}"}, 
				[5] = { npcname = "符敏仪", namestr = "#{XLRW_210725_408}", strlink = "#{XLRW_210789_610}"}, 
				[6] = { npcname = "菊剑",  namestr = "#{XLRW_210725_409}", strlink = "#{XLRW_210789_611}"}, 
				},
		[8] = {
				[1] = { npcname = "苏星河", namestr = "#{XLRW_210725_382}", strlink = "#{XLRW_210765_584}"}, 
				[2] = { npcname = "康广陵", namestr = "#{XLRW_210725_383}", strlink = "#{XLRW_210765_585}"}, 
				[3] = { npcname = "李傀儡", namestr = "#{XLRW_210725_384}", strlink = "#{XLRW_210765_586}"}, 
				[4] = { npcname = "秦观", namestr = "#{XLRW_210725_385}", strlink = "#{XLRW_210765_587}"}, 
				[5] = { npcname = "石甘霖", namestr = "#{XLRW_210725_386}", strlink = "#{XLRW_210765_588}"}, 
				[6] = { npcname = "冯阿三", namestr = "#{XLRW_210725_387}", strlink = "#{XLRW_210765_589}"}, 
				},
		[10] = {
				[1] = { npcname = "陶岭", namestr = "#{XLRW_210725_768}", strlink = "#{XLRW_210725_769}"},
				[2] = { npcname = "王水风", namestr = "#{XLRW_210725_758}", strlink = "#{XLRW_210725_759}"},
				[3] = { npcname = "白雪", namestr = "#{XLRW_210725_760}", strlink = "#{XLRW_210725_761}"},
				[4] = { npcname = "王语嫣", namestr = "#{XLRW_210725_762}", strlink = "#{XLRW_210725_763}"},
				[5] = { npcname = "王星浪", namestr = "#{XLRW_210725_764}", strlink = "#{XLRW_210725_765}"},
				[6] = { npcname = "阳春", namestr = "#{XLRW_210725_766}", strlink = "#{XLRW_210725_767}"},
				},
}

--目标NPC：接任务、交任务，都是这个
x891279_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}}, --替代2022
}
--**********************************
--任务入口函数
--**********************************
function x891279_OnDefaultEvent( sceneId, selfId, targetId,numText )
	
	if GetNumText() == 0 then
		--提交物品
		--不存在任务
		if IsHaveMission(sceneId,selfId,x891279_g_MissionId) <= 0 then
			return
		end
		--获取任务索引的信息
		local misIndex = GetMissionIndexByID(sceneId,selfId,x891279_g_MissionId)
		local nNpcIndex = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionNpcIdx)
		local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionMenPai)
		if x891279_g_MenPaiTargetNpc[nMenPai] == nil then
			return
		end
		if x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex] == nil then
			return
		end
		if GetName(sceneId,targetId) ~= x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex].npcname then
			return
		end
		if GetMissionParam(sceneId,selfId,misIndex,x891279_g_IsMissionOkFail) == 1 then
			return
		end
		if GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionGetItem) ~= 1 then
			--赶走
			local nItemNeed = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionItemId)			
			x891279_NotifyTip( sceneId, selfId, "#{XLRW_210725_681}" )
			
			x891279_NotifyBox( sceneId, selfId, targetId,  ScriptGlobal_Format("#{XLRW_210725_682}",GetItemName(sceneId,nItemNeed),x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex].namestr) )
			return
		end
		--标记提交
		SetMissionByIndex( sceneId, selfId, misIndex, x891279_g_IsMissionOkFail,1 )
		
		local nLiuPai = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionLiuPai)
		
		local lpname,mpname,mpnpcname,mpnpcnamelink = x891279_GetXiuLianMission_NameStr(nMenPai, nLiuPai)
		x891279_NotifyBox( sceneId, selfId, targetId,  ScriptGlobal_Format("#{XLRW_210725_680}",mpnpcnamelink) )
	elseif GetNumText() == 1 then
		--提交任务
		
	end
end
--**********************************
--列举事件
--**********************************
function x891279_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
--    if IsMissionHaveDone(sceneId,selfId,x891279_g_MissionId) > 0 then
--    	return 
--	end
    --如果已接此任务
	if IsHaveMission(sceneId,selfId,x891279_g_MissionId) > 0 then
		local nCurMenPai = GetMenPai(sceneId,selfId)
		--在门派武道长老处
		local nTalentType = 0
		if x891279_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891279_g_AcceptNpcInfo[nCurMenPai].name[i] then
					nTalentType = i
					break
				end
			end
		end
		if nTalentType ~= 0 then
			AddNumText(sceneId,x891279_g_ScriptId,x891279_g_MissionName,4,1);
			return
		end
		--获取任务索引的信息
		local misIndex = GetMissionIndexByID(sceneId,selfId,x891279_g_MissionId)
		local nNpcIndex = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionNpcIdx)
		local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionMenPai)
		if x891279_g_MenPaiTargetNpc[nMenPai] == nil then
			return
		end
		if x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex] == nil then
			return
		end
		if GetName(sceneId,targetId) ~= x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex].npcname then
			return
		end
		if GetMissionParam(sceneId,selfId,misIndex,x891279_g_IsMissionOkFail) == 1 then
			return
		end
		AddNumText(sceneId,x891279_g_ScriptId,x891279_g_MissionName,4,0);
	end
end
--**********************************
--接取任务
--**********************************
function x891279_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891279_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891279_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891279_g_NpcDist) ~= 1 then
		x891279_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891279_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891279_g_MissionLevel then
		x891279_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891279_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < x891279_g_BagSpace then
		x891279_NotifyTip( sceneId, selfId, "#{XLRW_210725_16}" )
		x891279_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891279_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891279_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891279_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--任务数据有异常，不走了
	local nRandItemIndex = random(0,LuaFnGetQianWuShopItemNum() - 1);
	local nRet, itemid, itemnum, itemcost, strName, strUnit  = LuaFnGetQianWuShopItemByIdx(nRandItemIndex)
	if nRet == nil or nRet <= 0 then
		return
	end
	if x891279_g_MenPaiTargetNpc[nCurMenPai] == nil then
		return
	end
	local nRandNpcIndex = random(1,getn(x891279_g_MenPaiTargetNpc[nCurMenPai]))
	if x891279_g_MenPaiTargetNpc[nCurMenPai][nRandNpcIndex] == nil then
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891279_g_MissionId, x891279_g_ScriptId, 0, 0, 1 )
	if ret <= 0 then
		x891279_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891279_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891279_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_IsMissionOkFail,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_MissionItemId,itemid)	
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_MissionNpcIdx,nRandNpcIndex)	
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_MissionGetItem,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891279_g_MissionItemNum,0)	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891279_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--XLRW_210725_48	    武道修行重在自身，但有时也需要些珍品罕物用于辅修。你此环修行所需的#Y%s0#W，我这里已经所剩无几，无法供你辅修取用，你去#G洛阳#R吴三#{_INFONGAIM135,212,0,吴三}#W处购得%s1%s2回来吧。#r    当前任务环数：#G%s3	
	x891279_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_48}",
		strName,
		"1",strUnit,
		tostring(x891279_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891279_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891279_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891279_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891279_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionGetItem) ~= 1 
		or  GetMissionParam(sceneId,selfId,misIndex,x891279_g_IsMissionOkFail) ~= 1 then
		--赶走
		local nItemNeed = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionItemId)
		local nNpcIndex = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionNpcIdx)
		local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionMenPai)
		
		x891279_NotifyTip( sceneId, selfId, "#{XLRW_210725_670}" )
		
		x891279_NotifyBox( sceneId, selfId, targetId,  ScriptGlobal_Format("#{XLRW_210725_682}",GetItemName(sceneId,nItemNeed),x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex].namestr) )
		return
	end

	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891279_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	--扣除任务道具
	local nItemNeed = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionItemId)
	DelItem(sceneId,selfId,nItemNeed,1)
	
	CallScriptFunction(x891279_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891279_g_MissionId)
end
--**********************************
--任务当前环数
--**********************************
function x891279_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end

--**********************************
--放弃
--**********************************
function x891279_OnAbandon( sceneId, selfId )
	--扣除任务道具
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891279_g_MissionId)
	local nItemNeed = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionItemId)
	DelItem(sceneId,selfId,nItemNeed,1)
	
	CallScriptFunction(x891279_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891279_g_MissionId)
end
--**********************************
--道具改变
--**********************************
function x891279_OnItemChanged( sceneId, selfId, itemdataId )
	if IsHaveMission( sceneId, selfId, x891279_g_MissionId ) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x891279_g_MissionId )	
	local nItemNeed = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionItemId)
	if nItemNeed ~= itemdataId then
		return
	end
--	XLRW_210725_181	#H已获得%s0(%s1/%s2)	
--	XLRW_210725_182	#H快去前往返回%s0处交付任务吧。	
	local nItemNum	= GetItemCount( sceneId, selfId, itemdataId )
	if nItemNum >= 1 then
		--设置已经获得道具
		SetMissionByIndex( sceneId, selfId, misIndex, x891279_g_MissionGetItem,1 )
		SetMissionByIndex( sceneId, selfId, misIndex, x891279_g_MissionItemNum,nItemNum )
		
		x891279_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_181}",GetItemName(sceneId,nItemNeed),tostring(nItemNum),"1") )
		local nNpcIndex = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionNpcIdx)
		local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891279_g_MissionMenPai)
		
		x891279_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_182}",x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex].namestr) )
		x891279_NotifyBox( sceneId, selfId,-1, ScriptGlobal_Format("#{XLRW_210725_727}",x891279_g_MenPaiTargetNpc[nMenPai][nNpcIndex].strlink) )
	end
end
--**********************************
--获取门派流派长老名称
--**********************************
function x891279_GetXiuLianMission_NameStr( menpaiid, liupaiid )--流派名 门派名 流派npc名
	local g_MenPaiNpcA = {
		[0] = {str = "#{XLRW_210725_246}", strlink = "#{XLRW_210725_523}", liupainame = "#{XLRW_210725_481}", mpname = "#{XLRW_210725_43}"},--少林
		[1] = {str = "#{XLRW_210725_250}", strlink = "#{XLRW_210725_527}", liupainame = "#{XLRW_210725_485}", mpname = "#{XLRW_210725_38}"},--明教
		[2] = {str = "#{XLRW_210725_248}", strlink = "#{XLRW_210725_525}", liupainame = "#{XLRW_210725_483}", mpname = "#{XLRW_210725_39}"},--丐帮
		[3] = {str = "#{XLRW_210725_251}", strlink = "#{XLRW_210725_528}", liupainame = "#{XLRW_210725_486}", mpname = "#{XLRW_210725_40}"},--武当
		[4] = {str = "#{XLRW_210725_257}", strlink = "#{XLRW_210725_534}", liupainame = "#{XLRW_210725_492}", mpname = "#{XLRW_210725_35}"},--峨嵋
		[5] = {str = "#{XLRW_210725_259}", strlink = "#{XLRW_210725_536}", liupainame = "#{XLRW_210725_494}", mpname = "#{XLRW_210725_41}"},--星宿
		[6] = {str = "#{XLRW_210725_253}", strlink = "#{XLRW_210725_530}", liupainame = "#{XLRW_210725_488}", mpname = "#{XLRW_210725_42}"},--天龙
		[7] = {str = "#{XLRW_210725_261}", strlink = "#{XLRW_210725_538}", liupainame = "#{XLRW_210725_496}", mpname = "#{XLRW_210725_36}"},--天山
		[8] = {str = "#{XLRW_210725_255}", strlink = "#{XLRW_210725_532}", liupainame = "#{XLRW_210725_490}", mpname = "#{XLRW_210725_37}"},--逍遥
		[10] = {str = "#{XLRW_210725_770}", strlink = "#{XLRW_210725_735}", liupainame = "#{XLRW_210725_737}", mpname = "#{XLRW_210725_741}"},--曼陀山庄
	}

	local g_MenPaiNpcB = {
		[0] = {str = "#{XLRW_210725_245}", strlink = "#{XLRW_210725_522}", liupainame = "#{XLRW_210725_480}", mpname = "#{XLRW_210725_43}"},--少林
		[1] = {str = "#{XLRW_210725_249}", strlink = "#{XLRW_210725_526}", liupainame = "#{XLRW_210725_484}", mpname = "#{XLRW_210725_38}"},--明教
		[2] = {str = "#{XLRW_210725_247}", strlink = "#{XLRW_210725_524}", liupainame = "#{XLRW_210725_482}", mpname = "#{XLRW_210725_39}"},--丐帮
		[3] = {str = "#{XLRW_210725_252}", strlink = "#{XLRW_210725_529}", liupainame = "#{XLRW_210725_487}", mpname = "#{XLRW_210725_40}"},--武当
		[4] = {str = "#{XLRW_210725_258}", strlink = "#{XLRW_210725_535}", liupainame = "#{XLRW_210725_493}", mpname = "#{XLRW_210725_35}"},--峨嵋
		[5] = {str = "#{XLRW_210725_260}", strlink = "#{XLRW_210725_537}", liupainame = "#{XLRW_210725_495}", mpname = "#{XLRW_210725_41}"},--星宿
		[6] = {str = "#{XLRW_210725_254}", strlink = "#{XLRW_210725_531}", liupainame = "#{XLRW_210725_489}", mpname = "#{XLRW_210725_42}"},--天龙
		[7] = {str = "#{XLRW_210725_262}", strlink = "#{XLRW_210725_539}", liupainame = "#{XLRW_210725_497}", mpname = "#{XLRW_210725_36}"},--天山
		[8] = {str = "#{XLRW_210725_256}", strlink = "#{XLRW_210725_533}", liupainame = "#{XLRW_210725_491}", mpname = "#{XLRW_210725_37}"},--逍遥
		[10] = {str = "#{XLRW_210725_771}", strlink = "#{XLRW_210725_736}", liupainame = "#{XLRW_210725_738}", mpname = "#{XLRW_210725_741}"},--曼陀山庄
	}
	local g_LiuPaiA = 0
	local g_LiuPaiB = 1
	if liupaiid == g_LiuPaiA and g_MenPaiNpcA[menpaiid] ~= nil then
		return g_MenPaiNpcA[menpaiid].liupainame, g_MenPaiNpcA[menpaiid].mpname, g_MenPaiNpcA[menpaiid].str, g_MenPaiNpcA[menpaiid].strlink
	end
	if liupaiid == g_LiuPaiB and g_MenPaiNpcB[menpaiid] ~= nil then
		return g_MenPaiNpcB[menpaiid].liupainame, g_MenPaiNpcB[menpaiid].mpname, g_MenPaiNpcB[menpaiid].str , g_MenPaiNpcB[menpaiid].strlink
	end
	return "","",""
end

--**********************************
--对话窗口信息提示
--**********************************
function x891279_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891279_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
