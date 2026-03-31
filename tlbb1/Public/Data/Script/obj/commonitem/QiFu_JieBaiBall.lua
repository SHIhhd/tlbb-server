--金兰祈福包
x335111_g_scriptId = 335111
--远程调用的script
x335111_g_ballscript = 002107
--放飞总时间
x335111_g_BallReleasetime = 7200
--最大祝福次数
x335111_g_Blessingmaxcount = 66
--用于存储玩家guid
x335111_g_NPCParam_GUID = 0
--真心祈福包初始化气球数据
x335111_g_BallMonsterID = 14424
--祝福次数
x335111_g_NPCParam_Blessingcount = 1
--剩余放飞时间
x335111_g_NPCParam_Releasetime = 2
--祝福所选的str5个
x335111_g_NPCParam_stridx = 3
x335111_g_NPCParam_stridx2 = 4
x335111_g_NPCParam_stridx3 = 5
x335111_g_NPCParam_stridx4 = 6
x335111_g_NPCParam_stridx5 = 7
--祝福一次的基础经验值
x335111_g_BasicExp = 66
--祝福毛笔
x335111_g_ZhuFuMaoBi = 38000046
--祝福最低等级限制
x335111_g_Blessingminlevel = 15
--**********************************
--事件交互入口
--**********************************
function x335111_OnDefaultEvent( sceneId, selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x335111_OnEventRequest( sceneId, selfId, targetId, eventId )
end
--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x335111_IsSkillLikeScript( sceneId, selfId )
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x335111_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x335111_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if 1~=LuaFnVerifyUsedItem(sceneId, selfId) then
		return 0
	end
	--遍历队友是否和自己是夫妻关系
	local brotherGUID = LuaFnGetBrotherGuid(sceneId,selfId) --结拜
	local nearMemberCount = GetNearTeamCount(sceneId,selfId)
	local teamMemberCount = GetTeamMemberCount(sceneId,selfId)
	local memberID;
	local nMonsterNum = GetMonsterCount(sceneId)
	for i = 0,nearMemberCount - 1 do
		memberID = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,memberID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,memberID) == 1 and LuaFnIsCharacterLiving(sceneId,memberID) == 1 then
			if selfId ~= memberID then
				if LuaFnGetGUID(sceneId,memberID) ~= brotherGUID then
					x335111_ShowNotice(sceneId,selfId,"#{TGQF_100111_34}")
					return 0
				end
			end
		end
	end
	if sceneId ~= 2 then
		x335111_ShowNotice(sceneId,selfId,"#{TGQF_100111_35}")
		return 0
	end
	for i = 0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID(sceneId,MonsterId)
		if MosDataID >= 14410 and MosDataID <= 14437 then
			--所选择放置点是否在有效距离内存在其他气球
			if IsInDist(sceneId,selfId,MonsterId,32) == 1 then
				x335111_ShowNotice(sceneId,selfId,"#{TGQF_100111_36}")
				return 0
			end
			--是否其他气球正在祈福中
			if LuaFnGetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_GUID) == LuaFnGetGUID(sceneId,selfId) then
				x335111_ShowNotice(sceneId,selfId,"#{TGQF_100111_38}")
				return 0
			end
		end
	end
	--队友不在附近
	if not teamMemberCount or teamMemberCount ~= nearMemberCount then
		x335111_ShowNotice(sceneId,selfId,"#{TGQF_100111_37}")
		return 0
	end
	--我不是队长无法使用祈福包
	if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
		x335111_ShowNotice(sceneId,selfId,"#{TGQF_100111_39}")
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
function x335111_OnDeplete( sceneId, selfId )
	if 0<LuaFnDepletingUsedItem(sceneId, selfId) then
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
function x335111_OnActivateOnce (sceneId,selfId)
	local szName = GetName(sceneId,selfId)
	local PlayerGUID = LuaFnGetGUID(sceneId,selfId)
	local nPosX,nPosZ = GetWorldPos(sceneId,selfId)
	local MonsterId = LuaFnCreateMonster(sceneId,x335111_g_BallMonsterID,nPosX,nPosZ,3,-1,x335111_g_ballscript)
	if MonsterId > -1 then
		--加入计时器
		SetCharacterTimer(sceneId,MonsterId,1000)
		--设置怪物销毁时间
		SetCharacterDieTime(sceneId,MonsterId,x335111_g_BallReleasetime * 1000)
		--修改名称
		SetCharacterName(sceneId,MonsterId,"#{TGQF_100111_04}")
		--加入称号
		SetCharacterTitle(sceneId,MonsterId,format("%s的祈福气球",szName))
		--写入气球归属
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_GUID,PlayerGUID)
		--祝福次数默认数据
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_Blessingcount,0)
		--放飞时间记录
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_Releasetime,x335111_g_BallReleasetime)
		--设置祝福str数据默认情况
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_stridx,0)
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_stridx2,0)
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_stridx3,0)
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_stridx4,0)
		LuaFnSetNpcIntParameter(sceneId,MonsterId,x335111_g_NPCParam_stridx5,0)
	end
	return 1;
end
--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x335111_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x335111_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
