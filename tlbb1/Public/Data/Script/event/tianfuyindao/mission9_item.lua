--武道引导任务用道具 
--参世心经

x893244_g_scriptId = 893244
x893244_g_MissionId = 2080
x893244_g_IsMissionOkFail = 0
x893244_g_MissionLiuPai = 1		-- 本流派
x893244_g_MissionMenPai = 2		-- 本门派
x893244_g_TipsIndex = 3

x893244_g_UsePos	= {
	[0] = {{270,226,3},{280,79,3}},	--少林
	[1] = {{240,197,4},{267,272,4}},	--明教
	[2] = {{209,39,4},{230,91,4}},	--丐帮
	[3] = {{116,273,5},{56,153,5}},	--武当
	[4] = {{259,138,7},{231,208,7}},	--峨嵋
	[5] = {{126,247,8},{94,208,8}},	--星宿
	[6] = {{52,269,6},{158,258,6}},	--天龙
	[7] = {{51,120,8},{120,48,8}},	--天山
	[8] = {{60,47,6},{181,47,6}},		--逍遥
	[10] = {{113,142,3},{153,92,3}},	--曼陀
	[11] = {{100,130,504},{140,110,504}},	--恶人谷
}
--目标NPC
x893244_g_NpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}},
	[MP_ERENGU] = {sceneId=504, name={[1]="山姥", [2]="山人木"}},
}

--**********************************
--事件交互入口
--**********************************
function x893244_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x893244_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x893244_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x893244_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	if GetLevel(sceneId,selfId) < 60 then
		x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_76}")
		return 0
	end
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel < 20 then
		x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_77}")
		return 0
	end
	if IsHaveMission(sceneId,selfId,x893244_g_MissionId) > 0 then
		local nMisIndex = GetMissionIndexByID(sceneId,selfId,x893244_g_MissionId)
		if GetMissionParam(sceneId,selfId,nMisIndex,x893244_g_IsMissionOkFail) >= 1 then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_78}")
			return 0
		end
		--组队跟随
		if IsTeamFollow( sceneId, selfId ) == 1 then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_80}")
			return 0
		end
		--双人坐骑状态下
		if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_81}")
			return 0
		end
		--坐骑状态下
		if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_81}")
			return 0
		end
		--变身状态下
		if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_82}")
			return 0
		end
		local nCurMenPai = GetMenPai(sceneId,selfId)
		local tLiuPai = x893244_g_UsePos[nCurMenPai]
		if tLiuPai == nil then
			return 0;
		end
		local nCurLiuPai = GetMissionParam(sceneId,selfId,nMisIndex,x893244_g_MissionLiuPai)
		if tLiuPai[nCurLiuPai + 1] == nil then
			return 0;
		end
		if tLiuPai[nCurLiuPai + 1][3] ~= sceneId then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_79}"..tLiuPai[nCurLiuPai + 1][3])
			return 0
		end
		--取得玩家当前坐标
		local PlayerX = GetHumanWorldX(sceneId,selfId)
		local PlayerZ = GetHumanWorldZ(sceneId,selfId)
		--计算玩家与宝藏的距离
		local Distance = floor(sqrt((tLiuPai[nCurLiuPai + 1][1]-PlayerX)*(tLiuPai[nCurLiuPai + 1][1]-PlayerX)+(tLiuPai[nCurLiuPai + 1][2]-PlayerZ)*(tLiuPai[nCurLiuPai + 1][2]-PlayerZ)))
		if Distance > 2 then
			x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_79}")
			return 0
		end
		
		SetMissionByIndex( sceneId, selfId, nMisIndex, x893244_g_TipsIndex,0 )
	else
		x893244_NotifyTips(sceneId,selfId,"#{WDEC_220425_78}")
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
function x893244_OnDeplete( sceneId, selfId )	
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
function x893244_OnActivateOnce(sceneId,selfId)
--	x893244_NotifyTips(sceneId,selfId,"#{TFYD_210729_253}")
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x893244_OnActivateEachTick( sceneId, selfId)
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x893244_g_MissionId)
	local nCurTips = GetMissionParam(sceneId,selfId,nMisIndex,x893244_g_TipsIndex)
	local nCurLiuPai = GetMissionParam(sceneId,selfId,nMisIndex,x893244_g_MissionLiuPai)
	local nCurMenPai = GetMenPai(sceneId,selfId)
--	print("nCurTips",nCurTips)
	if nCurTips == 2 then
		BroadMsgByChatPipe(sceneId,selfId,"#{WDEC_220425_129}",0)
	end
	SetMissionByIndex( sceneId, selfId, nMisIndex, x893244_g_TipsIndex,nCurTips + 1 )
	--标记完成
	if nCurTips + 1 >= 5 then
		BroadMsgByChatPipe(sceneId,selfId,"#{WDEC_220425_130}",0)
		x893244_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{WDEC_220425_84}",x893244_g_NpcInfo[nCurMenPai].name[nCurLiuPai + 1]))
		
		BeginEvent(sceneId)
			AddText( sceneId, "#{WDEC_220425_85}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,-1)
		
		SetMissionByIndex( sceneId, selfId, nMisIndex, x893244_g_IsMissionOkFail,1 )
	end
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x893244_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end