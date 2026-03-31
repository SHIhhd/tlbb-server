--宋辽大战

x502010_g_PlayerCamp_Song = 156
x502010_g_PlayerCamp_Liao = 157
--**********************************
--脚本入口函数
--**********************************
function x502010_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	--参数说明：场景ID，活动ID，时间间隔，公告类型（可以不传，默认普通公告类型）
	StartOneActivity( sceneId, actId, floor(60*1000), iNoticeType )

end

--**********************************
--心跳函数
--**********************************
function x502010_OnTimer( sceneId, actId, uTime )

	--检测活动是否过期
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity( sceneId, actId )
	end

end
--**********************************
--玩家进入一个 area 时触发
--**********************************
function x502010_OnEnterArea( sceneId, selfId, areaId )
	local killHuman = 0
	if areaId == 0 then
		--辽营地
		if GetUnitCampID(sceneId, selfId, selfId) == x502010_g_PlayerCamp_Song then
			killHuman = 1
		end
	elseif areaId == 1 then
		--宋营地
		if GetUnitCampID(sceneId, selfId, selfId) == x502010_g_PlayerCamp_Liao then
			killHuman = 1
		end
	end
	if killHuman == 1 then
		LuaFnGmKillObj( sceneId, selfId, selfId )
	end
end
--**********************************
--玩家在一个 area 呆了一段时间没走则定时触发【注意，这个特性程序是不支持的】
--**********************************
function x502010_OnTimer( sceneId, selfId )
	
end

--**********************************
--玩家离开一个 area 时触发
--**********************************
function x502010_OnLeaveArea( sceneId, selfId )
end
--**********************************
--中心通知
--**********************************
function x502010_Tips(sceneId,selfId,Str)
	BeginEvent(sceneId)
		AddText(sceneId, Str)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)
end


