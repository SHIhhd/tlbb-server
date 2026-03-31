--生长点
--鲜花
--脚本号890129

x890129_g_MissionId = 2148
x890129_g_PickNumber = 1
x890129_g_NeedPick = 5
x890129_g_MinLevel = 85
--生成函数开始************************************************************************
--每个ItemBox中最多10个物品
function	x890129_OnCreate(sceneId,growPointType,x,y)
	--天鉴任务不放入物品
	ItemBoxEnterScene(x,y,growPointType,sceneId,QUALITY_MUST_BE_CHANGE,0)
end
--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	x890129_OnOpen(sceneId,selfId,targetId)
	if GetLevel(sceneId,selfId) < x890129_g_MinLevel then
		x890129_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_60}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	if IsHaveMission(sceneId,selfId,x890129_g_MissionId) < 0 then
		x890129_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_196}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	--如果玩家处于骑乘或变身状态
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 2 then
		x890129_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_63}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	if IsTeamFollow(sceneId,selfId) == 1 then
		x890129_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_62}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x890129_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_64}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890129_g_MissionId )	
	local isFinish = GetMissionParam( sceneId, selfId,misIndex, 0 )
	if isFinish >= 1 then
		x890129_NotifyMsg( sceneId, selfId, "#{CCYR_221220_77}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	return OR_OK
end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	x890129_OnRecycle(sceneId,selfId,targetId)
	--返回1，生长点回收
	return 1
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x890129_OnProcOver(sceneId,selfId,targetId)
--BLCC_20221214_308	当前已获得西府海棠：%s0/5	
--BLCC_20221214_309	#H已采集5朵西府海棠，任务：天鉴·一花一念完成。	
	local misIndex = GetMissionIndexByID( sceneId, selfId, x890129_g_MissionId )	
	local nCurPick = GetMissionParam( sceneId, selfId,misIndex, x890129_g_PickNumber )
	x890129_NotifyMsg( sceneId, selfId, ScriptGlobal_Format("#{BLCC_20221214_308}",tostring(nCurPick + 1)))
	if nCurPick + 1 >= x890129_g_NeedPick then
		SetMissionByIndex( sceneId, selfId, misIndex, x890129_g_PickNumber,x890129_g_NeedPick )
		--标记完成
		SetMissionByIndex( sceneId, selfId, misIndex, 0,1 )
		x890129_NotifyMsg( sceneId, selfId, "#{BLCC_20221214_309}")
	else
		SetMissionByIndex( sceneId, selfId, misIndex, x890129_g_PickNumber,nCurPick + 1 )
	end
	return 0
end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

function x890129_OnTickCreateFinish( sceneId, growPointType, tickCount )
end
--**********************************
--信息提示
--**********************************
function x890129_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
