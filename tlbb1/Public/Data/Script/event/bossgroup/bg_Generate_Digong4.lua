-- 地宫4BOSS活动
-- 脚本ID
x810112_g_scriptId	= 810112

--**********************************
--脚本入口函数
--**********************************
function x810112_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	--开启活动.... 间隔1分钟(60秒)，测试调成20秒即可。 十分钟：600*1000
	
	--1分钟心跳一次
	StartOneActivity( sceneId, actId, 60*1000, iNoticeType )
end

--**********************************
--心跳函数
--**********************************
function x810112_OnTimer( sceneId, actId, uTime )
    local nWeekDay = GetTodayWeek()
    local nHour = GetHour()
    local nMinute = GetMinute()
	-- 调试用
--	if sceneId == SCENE_DILING then
--	 	AddGlobalCountNews(sceneId, "分钟级活动计时器【"..actId.."】： nHour:"..nHour.." nMinute:"..nMinute)
--	end

	--帝陵4
	if sceneId == SCENE_DILING then
--		暂时不再使用
--		x810112_Generate_Dishitian( sceneId )
	end
	
	--检测活动是否过期
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity( sceneId, actId )
	end
end
--**********************************
--玄武岛镜 霓凰·灾厄
--**********************************
function x810112_Generate_Dishitian( sceneId )
	--//////////////////////////////////
	local BossMonsterId = 60003
--	local BOSS_CTUID = 1001000018
	--//////////////////////////////////
	local curTime = GetHour() * 100 + GetMinute();
	if curTime ~= 2100 then
		return
	end
--	if LuaFnCTUCheckIsShutDown(sceneId,-1,BOSS_CTUID) == 1 then
--		return
--	end
	--BOSS已存在
	if x810112_IsHaveMonster( sceneId, BossMonsterId ) == 1 then
		return
	end
	--创建BOSS
	local nMonId = CreateMonsterWithDir(sceneId,BossMonsterId , 214, 102, 19, -1, 810113,6.283)
	if nMonId ~= -1 then
		SetCharacterTitle(sceneId, nMonId, "“噩梦”")
		local str = "#P灾厄·嬴政已经出现在#G帝陵（214，102）#P！请天下英雄速去镇压灾厄！最后将其斩杀者及在场的大侠朝廷将给予获得丰厚奖励！"
		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:"..str)
	end
end
--**********************************
--Monster 是否存在
--**********************************
function x810112_IsHaveMonster( sceneId, nDataId )
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
function x810112_tips(sceneId, selfId, Tip)
	BeginEvent(sceneId)
		AddText(sceneId, Tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)
end