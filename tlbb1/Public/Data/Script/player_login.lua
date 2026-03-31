-- 登录处理
--〖触发时机〗	玩家登录游戏后触发此脚本
--〖触发源〗		.\Scene.lua: OnScenePlayerLogin

--脚本号
x888890_g_ScriptId	= 888890
--**********************************
--新增玩家登录检测接口
--**********************************
function x888890_OnPlayerLogin( sceneId, selfId )
	--玩家登录天数数据处理
	local nTimeSign = GetMissionDataEx(sceneId,selfId,MDEX_SERVER_DAYTIME);
	local nNowTime = GetDayTime()
	local nLeftTime = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME)
	local HeroImpact = LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,10541)
	--英雄归来活动时间数据处理
	--登录之前先读取离线状态是否超过七天，如果超过七天，那要给一个回归的状态
	if nTimeSign ~= 0 then
		if nNowTime - nTimeSign >= 7 then
			if GetLevel(sceneId,selfId) >= 50 then
				if HeroImpact ~= 1 then
					SetMissionDataEx(sceneId,selfId,MDEX_HERO_LEFTTIME,LuaFnGetCurrentTime() + (12 * 24 - 1) * 60 * 60)
					LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,10541,0) --重返江湖
					CallScriptFunction(808110,"HeroReturns",sceneId,selfId) --呼出头顶得UI面板
					SetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS,1) --默认的登录数据为1，一定要写。
				end
			end
		end
	end
	if nTimeSign ~= nNowTime then
		--新手七日礼处理
		local Xinshou7Day = GetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME)
		if Xinshou7Day < 7 then
			SetMissionDataEx(sceneId,selfId,MDEX_SEVENDAYTIME,Xinshou7Day + 1)
		end
		--簪花饮茶迎春分处理
		local LandDay = GetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME)
		if LandDay < 15 then
			SetMissionDataEx(sceneId,selfId,MDEX_LANDREWARD_DAYTIME,LandDay + 1)
		end
		--功力丹每日更新
		SetMissionDataEx(sceneId,selfId,MDEX_GONGLIDAN_DATA,0)
		--除恶天劫楼每日更新
		SetMissionData(sceneId,selfId,MD_ROUNDMISSION_CHUE_DAYHUAN,0)
		--十二煞星每日数据更新
		SetMissionDataEx(sceneId,selfId,MDEX_SHAXING_COUNT,0)--接取任务次数
		SetMissionDataEx(sceneId,selfId,MDEX_SHAXING_YIRONGDAN_COUNT,0)--易容丹使用次数
		--祈福天宫每日数据处理
		SetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_MARRY,0)--夫妻祈福
		SetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_SHITU,0)--师徒祈福
		SetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_SWEAR,0)--结拜祈福
		--每日数据处理总记录。
		SetMissionDataEx(sceneId,selfId,MDEX_SERVER_DAYTIME,GetDayTime())
		--仲夏任务数据处理
		for i = 1157,1159 do
			if IsHaveMission(sceneId,selfId,i) > 0 then
				--任务过期了，直接设置失败数据。
				local misIndex = GetMissionIndexByID(sceneId,selfId,i)--得到任务在20个任务中的序列号
				local nWeek = GetTodayWeek();
				local nTime = GetHour() * 100 + GetMinute()
				if nWeek ~= 3 then
					SetMissionByIndex(sceneId,selfId,misIndex,0,2)
				end
				if nTime > 2200 then
					SetMissionByIndex(sceneId,selfId,misIndex,0,2)
				end
			end
		end
		--英雄归来登录数据处理
		if HeroImpact == 1 then
			local HeroLogin = GetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS)
			if HeroLogin < 7 then
				SetMissionDataEx(sceneId,selfId,MDEX_HERO_LOGINDAYS,HeroLogin + 1)
			end
		end
	end
end
--**********************************
-- 玩家所在场景的相关上线提示
--**********************************
function x888890_AcceptBox(sceneId,selfId)
	local pvpType = 0;
	local pvpRuler = LuaFnGetScenePvpRuler(sceneId)
	if pvpRuler == 1 or pvpRuler == 2 then
		pvpType = 2
	elseif pvpRuler == 6 then
		pvpType = 3
	end
	if pvpType ~= 0 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,pvpType)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,20100716)
	end
end
--**********************************
--脚本入口函数
--**********************************
function x888890_OnDefaultEvent( sceneId, selfId )
	--整理配方
	x888890_AdjustPrescription( sceneId, selfId )
	--检查帐号是否安全
	CheckAccountSafe( sceneId, selfId );
	--其它操作
	x888890_OnPlayerLogin( sceneId,selfId)--新增接口
end

--**********************************
--整理配方
--**********************************
--删除已经废弃的配方，添加没有自动添加的配方
function x888890_AdjustPrescription( sceneId, selfId )

	--需要删除的配方
	local	preOld	= { 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,
										176, 177, 178, 179, 180, 181, 182, 183, 184, 185,
										186, 187, 188, 189, 190, 191, 192, 193, 194, 195,
										196, 197, 198, 199, 200, 201, 202, 203, 204, 205,
										206, 207, 208, 209, 210, 211, 212, 213, 214, 215,
										216, 217, 218, 219, 220, 221, 222, 223, 224, 225,
										226, 227, 228, 229, 230, 231, 232, 233 }
	--需要添加的配方
	local	preNew	= { 558, 559, 560 }
	
	local	id
	--Del
	for _, id in preOld do
		if IsPrescrLearned( sceneId, selfId, id ) == 1 then
			SetPrescription( sceneId, selfId, id, 0 )
		end
	end
	--Add
	for _, id in preNew do
		if IsPrescrLearned( sceneId, selfId, id ) == 0 then
			SetPrescription( sceneId, selfId, id, 1 )
		end
	end

end
