--武道引导任务用道具 
--梅花熏香

x891225_g_scriptId = 891225
x891225_g_MissionId = 2024
x891225_g_IsMissionOkFail = 0
x891225_g_TipsIndex = 3

x891225_g_UsePos	= {
	[MP_SHAOLIN] = {sceneId=9, pos={95,107}},
	[MP_MINGJIAO] = {sceneId=11, pos={97,92}},
	[MP_GAIBANG] = {sceneId=10, pos={147,36}},
	[MP_WUDANG] = {sceneId=12, pos={45,94}},
	[MP_EMEI] = {sceneId=15, pos={95,107}},
	[MP_XINGSU] = {sceneId=16, pos={45,50}},
	[MP_DALI] = {sceneId=13, pos={95,39}},
	[MP_TIANSHAN] = {sceneId=17, pos={94,70}},
	[MP_XIAOYAO] = {sceneId=14, pos={118,88}},
	[MP_MANTUO] = {sceneId=SCENE_MANTUOSHANZHUANG, pos={176,75}},
}

x891225_g_UseTips	= {
	[MP_SHAOLIN] = "#{TFYD_210729_259}",
	[MP_MINGJIAO] = "#{TFYD_210729_260}",
	[MP_GAIBANG] = "#{TFYD_210729_261}",
	[MP_WUDANG] = "#{TFYD_210729_262}",
	[MP_EMEI] = "#{TFYD_210729_263}",
	[MP_XINGSU] = "#{TFYD_210729_264}",
	[MP_DALI] = "#{TFYD_210729_265}",
	[MP_TIANSHAN] = "#{TFYD_210729_266}",
	[MP_XIAOYAO] = "#{TFYD_210729_267}",
	[MP_MANTUO] = "#{TFYD_220523_22}",
}

x891225_g_TickTips	= {
	[MP_SHAOLIN] = {"#{TFYD_210729_271}","#{TFYD_210729_272}","#{TFYD_210729_273}"},
	[MP_MINGJIAO] = {"#{TFYD_210729_274}","#{TFYD_210729_275}","#{TFYD_210729_276}"},
	[MP_GAIBANG] = {"#{TFYD_210729_277}","#{TFYD_210729_278}","#{TFYD_210729_279}"},
	[MP_WUDANG] = {"#{TFYD_210729_280}","#{TFYD_210729_281}","#{TFYD_210729_282}"},
	[MP_EMEI] = {"#{TFYD_210729_283}","#{TFYD_210729_284}","#{TFYD_210729_285}"},
	[MP_XINGSU] = {"#{TFYD_210729_286}","#{TFYD_210729_287}","#{TFYD_210729_288}"},
	[MP_DALI] = {"#{TFYD_210729_289}","#{TFYD_210729_290}","#{TFYD_210729_291}"},
	[MP_TIANSHAN] = {"#{TFYD_210729_292}","#{TFYD_210729_293}","#{TFYD_210729_294}"},
	[MP_XIAOYAO] = {"#{TFYD_210729_295}","#{TFYD_210729_296}","#{TFYD_210729_297}"},
	[MP_MANTUO] = {"#{TFYD_220523_23}","#{TFYD_220523_24}","#{TFYD_220523_25}"},
}

--**********************************
--事件交互入口
--**********************************
function x891225_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x891225_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x891225_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x891225_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	if GetLevel(sceneId,selfId) < 60 then
		x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_255}")
		return 0
	end
	if IsHaveMission(sceneId,selfId,x891225_g_MissionId) > 0 then
		local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891225_g_MissionId)
		if GetMissionParam(sceneId,selfId,nMisIndex,x891225_g_IsMissionOkFail) >= 1 then
			x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_257}")
			return 0
		end
		--组队跟随
		if IsTeamFollow( sceneId, selfId ) == 1 then
			x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_270}")
			return 0
		end
		--双人坐骑状态下
		if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
			x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_269}")
			return 0
		end
		--坐骑状态下
		if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
			x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_269}")
			return 0
		end
		--变身状态下
		if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
			x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_268}")
			return 0
		end
		local nCurMenPai = GetMenPai(sceneId,selfId)
		if x891225_g_UsePos[nCurMenPai] == nil then
			return 0;
		end
		if x891225_g_UsePos[nCurMenPai].sceneId ~= sceneId then
			x891225_NotifyFailTips(sceneId,selfId,x891225_g_UseTips[nCurMenPai])
			return 0
		end
		--取得玩家当前坐标
		local PlayerX = GetHumanWorldX(sceneId,selfId)
		local PlayerZ = GetHumanWorldZ(sceneId,selfId)
		--计算玩家与宝藏的距离
		local Distance = floor(sqrt((x891225_g_UsePos[nCurMenPai].pos[1]-PlayerX)*(x891225_g_UsePos[nCurMenPai].pos[1]-PlayerX)+(x891225_g_UsePos[nCurMenPai].pos[2]-PlayerZ)*(x891225_g_UsePos[nCurMenPai].pos[2]-PlayerZ)))
		if Distance > 2 then
			x891225_NotifyFailTips(sceneId,selfId,x891225_g_UseTips[nCurMenPai])
			return 0
		end
		
		SetMissionByIndex( sceneId, selfId, nMisIndex, x891225_g_TipsIndex,0 )
	else
		x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_256}")
		return 0
	end
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x891225_OnDeplete( sceneId, selfId )	
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end
--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x891225_OnActivateOnce(sceneId,selfId)
	x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_253}")
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x891225_OnActivateEachTick( sceneId, selfId)
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891225_g_MissionId)
	local nCurTips = GetMissionParam(sceneId,selfId,nMisIndex,x891225_g_TipsIndex)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if nCurTips == 5 then
		BroadMsgByChatPipe(sceneId,selfId,x891225_g_TickTips[nCurMenPai][1],0)
	elseif nCurTips == 10 then
		BroadMsgByChatPipe(sceneId,selfId,x891225_g_TickTips[nCurMenPai][2],0)
	elseif nCurTips == 15 then
		BroadMsgByChatPipe(sceneId,selfId,x891225_g_TickTips[nCurMenPai][3],0)
	end
	SetMissionByIndex( sceneId, selfId, nMisIndex, x891225_g_TipsIndex,nCurTips + 1 )
	--标记完成
	if nCurTips + 1 == 20 then
		x891225_NotifyFailTips(sceneId,selfId,"#{TFYD_210729_541}")
		SetMissionByIndex( sceneId, selfId, nMisIndex, x891225_g_IsMissionOkFail,1 )
	end
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891225_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end