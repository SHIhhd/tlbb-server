--MisDescBegin
--脚本号
x050225_g_ScriptId = 050225
--接取祈福的最低等级
x050225_g_Accept_MiniLv = 15
--天官祈福限制人数
x050225_g_LimitMembers = 2
--祝福毛笔
x050225_g_MaobiItem = 38000046
--夫妻祈福包
x050225_g_FuQiBall = 38000042
--师徒祈福包
x050225_g_ShiTuBall = 38000043
--结拜祈福包
x050225_g_JieBaiBall = 38000044
--领取任务基础经验值
x050225_g_ExpData = 800
--**********************************
--任务入口函数
--**********************************
function x050225_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	local nNumText = GetNumText()
	local nLevel = GetLevel(sceneId,selfId)
	local teamMemberCount = GetTeamMemberCount(sceneId,selfId)
	local nearMemberCount = GetNearTeamCount(sceneId,selfId)
	local memberID
	if nNumText == 1 then --夫妻祈福
		if nLevel < x050225_g_Accept_MiniLv then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_07}")
			return
		end
		if LuaFnHasTeam(sceneId,selfId) == 0 then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_08}")
			return
		end
		if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_09}")
			return
		end
		if not teamMemberCount or teamMemberCount ~= nearMemberCount then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_24}")
			return
		end
		if GetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_MARRY) >= GetDayTime() then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_10}")
			return
		end
		if not nearMemberCount or nearMemberCount < x050225_g_LimitMembers then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_11}")
			return
		end
		if not nearMemberCount or nearMemberCount > x050225_g_LimitMembers then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_11}")
			return
		end
		--判断背包是否充足
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 2 then
			x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_17}")
			return
		end
		local spouseGuid = LuaFnGetSpouseGUID(sceneId,selfId) --伴侣的guid
		for i = 0,nearMemberCount - 1 do
			memberID = GetNearTeamMember(sceneId,selfId,i)
			if LuaFnIsObjValid(sceneId,memberID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,memberID) == 1 and LuaFnIsCharacterLiving(sceneId,memberID) == 1 then
				if selfId ~= memberID then
					if GetLevel(sceneId,memberID) < x050225_g_Accept_MiniLv then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_14}")
						return
					end
					if LuaFnGetGUID(sceneId,memberID) ~= spouseGuid then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_13}")
						return
					end
					if GetMissionDataEx(sceneId,memberID,MDEX_TGQF_DAY_MARRY) >= GetDayTime() then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_15}")
						return
					end
					--判断队友背包是否充足
					if LuaFnGetPropertyBagSpace(sceneId,memberID) < 1 then
						x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_16}")
						return
					end
					--队友也要给经验
					--给队友祝福毛笔
					LuaFnTryRecieveSingleItem(sceneId,memberID,x050225_g_MaobiItem,1,1)
					x050225_NotifyFailTips(sceneId,memberID,"#{TGQF_100111_21}")
					LuaFnAddExp(sceneId,memberID,x050225_g_ExpData * GetLevel(sceneId,memberID))
					SetMissionDataEx(sceneId,memberID,MDEX_TGQF_DAY_MARRY,GetDayTime())
				end
			end
		end
		--满足以上条件给一个祝福毛笔和祈福包
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_19}")
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_20}")
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_21}")
		LuaFnAddExp(sceneId,selfId,x050225_g_ExpData * GetLevel(sceneId,selfId))
		--给队长发放物品
		LuaFnTryRecieveSingleItem(sceneId,selfId,x050225_g_MaobiItem,1,1)
		LuaFnTryRecieveSingleItem(sceneId,selfId,x050225_g_FuQiBall,1,1)
		SetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_MARRY,GetDayTime())
		x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_18}")
	elseif nNumText == 2 then --师徒祈福
		if nLevel < x050225_g_Accept_MiniLv then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_07}")
			return
		end
		if LuaFnHasTeam(sceneId,selfId) == 0 then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_08}")
			return
		end
		if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_09}")
			return
		end
		if not teamMemberCount or teamMemberCount ~= nearMemberCount then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_24}")
			return
		end
		if GetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_SHITU) >= GetDayTime() then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_22}")
			return
		end
		if not nearMemberCount or nearMemberCount < x050225_g_LimitMembers then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_23}")
			return
		end
		--判断队友背包是否充足
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_17}")
			return
		end
		for i = 0,nearMemberCount - 1 do
			memberID = GetNearTeamMember(sceneId,selfId,i)
			if LuaFnIsObjValid(sceneId,memberID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,memberID) == 1 and LuaFnIsCharacterLiving(sceneId,memberID) == 1 then
				if selfId ~= memberID then
					if GetLevel(sceneId,memberID) < x050225_g_Accept_MiniLv then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_26}")
						return
					end
					if LuaFnIsPrentice(sceneId,selfId,memberID) ~= 1 then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_25}")
						return
					end
					if GetMissionDataEx(sceneId,memberID,MDEX_TGQF_DAY_SHITU) >= GetDayTime() then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_27}")
						return
					end
					--判断队友背包是否充足
					if LuaFnGetPropertyBagSpace(sceneId,memberID) < 1 then
						x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_28}")
						return
					end
					--队友也要给经验
					--给队友祝福毛笔
					LuaFnTryRecieveSingleItem(sceneId,memberID,x050225_g_MaobiItem,1,1)
					x050225_NotifyFailTips(sceneId,memberID,"#{TGQF_100111_21}")
					LuaFnAddExp(sceneId,memberID,x050225_g_ExpData * GetLevel(sceneId,memberID))
					SetMissionDataEx(sceneId,memberID,MDEX_TGQF_DAY_SHITU,GetDayTime())
				end
			end
		end
		--满足以上条件给一个祝福毛笔和祈福包
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_19}")
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_29}")
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_21}")
		LuaFnAddExp(sceneId,selfId,x050225_g_ExpData * GetLevel(sceneId,selfId))
		--给队长发放物品
		LuaFnTryRecieveSingleItem(sceneId,selfId,x050225_g_MaobiItem,1,1)
		LuaFnTryRecieveSingleItem(sceneId,selfId,x050225_g_ShiTuBall,1,1)
		SetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_SHITU,GetDayTime())
		x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_18}")
	elseif nNumText == 3 then --结拜关系祈福
		if nLevel < x050225_g_Accept_MiniLv then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_07}")
			return
		end
		if LuaFnHasTeam(sceneId,selfId) == 0 then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_08}")
			return
		end
		if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_09}")
			return
		end
		if not teamMemberCount or teamMemberCount ~= nearMemberCount then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_24}")
			return
		end
		if GetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_SWEAR) >= GetDayTime() then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_30}")
			return
		end
		if not nearMemberCount or nearMemberCount < x050225_g_LimitMembers then
			x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_31}")
			return
		end
		--判断队友背包是否充足
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
			x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_17}")
			return
		end
		local brotherGUID = LuaFnGetBrotherGuid(sceneId,selfId)
		for i = 0,nearMemberCount - 1 do
			memberID = GetNearTeamMember(sceneId,selfId,i)
			if LuaFnIsObjValid(sceneId,memberID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,memberID) == 1 and LuaFnIsCharacterLiving(sceneId,memberID) == 1 then
				if selfId ~= memberID then
					if GetLevel(sceneId,memberID) < x050225_g_Accept_MiniLv then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_26}")
						return
					end
					if LuaFnGetGUID(sceneId,memberID) ~= brotherGUID then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_31}")
						return
					end
					if GetMissionDataEx(sceneId,memberID,MDEX_TGQF_DAY_SWEAR) >= GetDayTime() then
						x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_32}")
						return
					end
					--判断队友背包是否充足
					if LuaFnGetPropertyBagSpace(sceneId,memberID) < 1 then
						x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_28}")
						return
					end
					--队友也要给经验
					--给队友祝福毛笔
					LuaFnTryRecieveSingleItem(sceneId,memberID,x050225_g_MaobiItem,1,1)
					x050225_NotifyFailTips(sceneId,memberID,"#{TGQF_100111_21}")
					LuaFnAddExp(sceneId,memberID,x050225_g_ExpData * GetLevel(sceneId,memberID))
					SetMissionDataEx(sceneId,memberID,MDEX_TGQF_DAY_SWEAR,GetDayTime())
				end
			end
		end
		--满足以上条件给一个祝福毛笔和祈福包
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_19}")
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_33}")
		x050225_NotifyFailTips(sceneId,selfId,"#{TGQF_100111_21}")
		LuaFnAddExp(sceneId,selfId,x050225_g_ExpData * GetLevel(sceneId,selfId))
		--给队长发放物品
		LuaFnTryRecieveSingleItem(sceneId,selfId,x050225_g_MaobiItem,1,1)
		LuaFnTryRecieveSingleItem(sceneId,selfId,x050225_g_JieBaiBall,1,1)
		SetMissionDataEx(sceneId,selfId,MDEX_TGQF_DAY_SWEAR,GetDayTime())
		x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_18}")
	elseif nNumText == 4 then
		x050225_NotifyFailBox(sceneId,selfId,targetId,"#{TGQF_100111_06}")
	end
end

--**********************************
--列举事件
--**********************************
function x050225_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x050225_g_ScriptId,"#{TGQF_100111_02}",6,1)
	AddNumText(sceneId,x050225_g_ScriptId,"#{TGQF_100111_03}",6,2)
	AddNumText(sceneId,x050225_g_ScriptId,"#{TGQF_100111_04}",6,3)
	AddNumText(sceneId,x050225_g_ScriptId,"#{TGQF_100111_05}",11,4)
end

--**********************************
--接受任务
--**********************************
function x050225_OnAccept( sceneId, selfId )
end

--**********************************
--放弃任务
--**********************************
function x050225_OnAbandon( sceneId, selfId )
end
--**********************************
--继续
--**********************************
function x050225_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x050225_CheckSubmit(sceneId,selfId)
end

--**********************************
--提交任务
--**********************************
function x050225_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end
--**********************************
-- 使用愿灵泉
--**********************************
function x050225_OnUseItem(sceneId,selfId)
end
--**********************************
--道具改变
--**********************************
function x050225_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x050225_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x050225_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end