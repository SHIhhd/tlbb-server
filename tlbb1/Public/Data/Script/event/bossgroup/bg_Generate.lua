-- 自定义分钟级世界轮询BOSS
-- 脚本ID
x810111_g_scriptId	= 810111

--**********************************
--脚本入口函数
--**********************************
function x810111_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	--开启活动.... 间隔1分钟(60秒)，测试调成20秒即可。 十分钟：600*1000
	
	--九尾·灾厄2小时一刷新
	StartOneActivity( sceneId, actId, 2*60*60*1000, iNoticeType )
	
	--第一次启动系统要调用
	if sceneId == SCENE_PETISLANDPVP then
		x810111_Generate_Dishitian( sceneId )
	end
end

--**********************************
--心跳函数
--**********************************
function x810111_OnTimer( sceneId, actId, uTime )
    local nWeekDay = GetTodayWeek()
    local nHour = GetHour()
    local nMinute = GetMinute()
	-- 调试用
--	if sceneId == SCENE_PETISLANDPVP then
--	 	AddGlobalCountNews(sceneId, "分钟级活动计时器【"..actId.."】： nHour:"..nHour.." nMinute:"..nMinute)
--	end

	--玄武岛镜 九尾·灾厄
	if sceneId == SCENE_PETISLANDPVP then
--		暂不启用
--		x810111_Generate_Dishitian( sceneId )
	end
	
	--检测活动是否过期
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity( sceneId, actId )
	end
end
--**********************************
--玄武岛镜 九尾·灾厄
--**********************************
function x810111_Generate_Dishitian( sceneId )
	--//////////////////////////////////
	local BossMonsterId = 60002
	local BOSS_CTUID = 1001000018
	--//////////////////////////////////
--	local curTime = GetHour() * 100 + GetMinute();
--	if curTime ~= 2000 then
--		return
--	end
	if LuaFnCTUCheckIsShutDown(sceneId,-1,BOSS_CTUID) == 1 then
		return
	end
	--BOSS已存在
	if x810111_IsHaveMonster( sceneId, BossMonsterId ) == 1 then
		return
	end
	--创建BOSS
	local nMonId = CreateMonsterWithDir(sceneId,BossMonsterId , 53, 66, 19, -1, 810101,6.283)
	if nMonId ~= -1 then
		SetCharacterTitle(sceneId, nMonId, "“噩梦”")
		local str = "#P九尾·灾厄已经出现在#G玄武岛·镜（53，66）#P！请天下英雄速去拯救玄武岛的珍兽！最后将其斩杀者朝廷将给予获得丰厚奖励！"
		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:"..str)
	end
end
--**********************************
--Monster 是否存在
--**********************************
function x810111_IsHaveMonster( sceneId, nDataId )
	local nMonsterNum = GetMonsterCount(sceneId)
	local bHaveMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetMonsterDataID(sceneId, nMonsterId)  == nDataId  then
			bHaveMonster = 1
		end
	end
	return bHaveMonster
end
--**********************************
-- 提示函数
--**********************************
function x810111_tips(sceneId, selfId, Tip)
	BeginEvent(sceneId)
		AddText(sceneId, Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)
end