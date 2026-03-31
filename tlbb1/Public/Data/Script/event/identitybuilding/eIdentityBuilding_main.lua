--脚本号
--江湖盟会主脚本

x998583_g_ScriptId = 998583
x998583_g_MinLevel = 50
x998583_g_NpcList = 
{
	[51905] = {	
		IdentityId=IDENTITY_COOKING_IDX,
		PrescrAbilityId = 59,
		mainStr = "#{YCGZ_231225_27}",
		yulanStr = "#{YCGZ_231225_66}",
		joinBtn = "#{YCGZ_231225_33}",
		titleStr = {
			"#{YCGZ_231225_102}",
			"#{YCGZ_231225_103}",
			"#{YCGZ_231225_104}",
		},
		titleInfo = {
			id = {1317,1318,1319},
			needLv = {4,7,10}
		}
	},		--烹饪NPC
	[51906] = {	
		IdentityId=IDENTITY_PHARMACY_IDX,
		PrescrAbilityId = 60,
		mainStr = "#{YCGZ_231225_28}",
		yulanStr = "#{YCGZ_231225_67}",
		joinBtn = "#{YCGZ_231225_04}",
		titleStr = {
			"#{YCGZ_231225_105}",
			"#{YCGZ_231225_106}",
			"#{YCGZ_231225_107}",
		},
		titleInfo = {
			id = {1320,1321,1322},
			needLv = {4,7,10}
		}
	},		--制药NPC
	[51907] = {	
		IdentityId=IDENTITY_ATTACKEQUIP_IDX,
		PrescrAbilityId = 61,
		mainStr = "#{YCGZ_231225_29}",
		yulanStr = "#{YCGZ_231225_68}",
		joinBtn = "#{YCGZ_231225_05}",
		titleStr = {
			"#{YCGZ_231225_108}",
			"#{YCGZ_231225_109}",
			"#{YCGZ_231225_110}",
		},
		titleInfo = {
			id = {1323,1324,1325},
			needLv = {4,7,10}
		}
	},	--攻具NPC
	[51909] = {	
		IdentityId=IDENTITY_ENGINEER_IDX,
		PrescrAbilityId = 62,
		mainStr = "#{YCGZ_231225_30}",
		yulanStr = "#{YCGZ_231225_69}",
		joinBtn = "#{YCGZ_231225_06}",
		titleStr = {
			"#{YCGZ_231225_111}",
			"#{YCGZ_231225_112}",
			"#{YCGZ_231225_113}",
		},
		titleInfo = {
			id = {1326,1327,1328},
			needLv = {4,7,10}
		}
	},		--工程NPC
}
x998583_g_IdentityName = {
	[IDENTITY_COOKING_IDX] = "#{YCGZ_231225_64}",
	[IDENTITY_PHARMACY_IDX] = "#{YCGZ_231225_65}",
	[IDENTITY_ATTACKEQUIP_IDX] = "#{YCGZ_231225_63}",
	[IDENTITY_ENGINEER_IDX] = "#{YCGZ_231225_62}",
}
x998583_g_IdentityAbilityId = {
	[IDENTITY_COOKING_IDX] = ABILITY_IDENTITY_ZHISHAN,
	[IDENTITY_PHARMACY_IDX] = ABILITY_IDENTITY_LIANYAO,
	[IDENTITY_ATTACKEQUIP_IDX] = ABILITY_IDENTITY_ZHUQI,
	[IDENTITY_ENGINEER_IDX] = ABILITY_IDENTITY_JIQIAO,
}
--首次加入给予的特殊称号
x998583_g_IdentityNewAgname = {
	[IDENTITY_COOKING_IDX] = 1329,
	[IDENTITY_PHARMACY_IDX] = 1330,
	[IDENTITY_ATTACKEQUIP_IDX] = 1331,
	[IDENTITY_ENGINEER_IDX] = 1332,
}
--盟会更易令
x998583_g_ChangeIdentityItem = 38003028
--盟会变更冷却时间
x998583_g_ChangeIdentityCTime = 3 * 24 * 60 * 60
--盟会引导任务
x998583_g_GuildMission = {
	2251,2252,2253,2254,2255
}
--盟会等级进阶任务
x998583_g_LevelUpMission = 2250

--**********************************
--任务入口函数
--**********************************
function x998583_OnDefaultEvent( sceneId, selfId, targetId,opId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998583_g_NpcList[nMonsterDataId] == nil then
		return
	end
	--加入盟会
	if opId == 1 then
		x998583_TryJoinIdentity( sceneId, selfId, targetId )
		return
	end
	--产物预览
	if opId == 2 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)	--1:open
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,x998583_g_NpcList[nMonsterDataId].IdentityId)
			UICommand_AddInt(sceneId,x998583_g_NpcList[nMonsterDataId].PrescrAbilityId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,99858301)
	end
	--确定加入盟会
	if opId == 3 then
		x998583_JoinIdentity( sceneId, selfId, targetId )
		return
	end
	if opId == 4 then
		--关闭UI
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
	--领取称号
	if opId == 5 then
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{YCGZ_231225_101}",
				x998583_g_NpcList[nMonsterDataId].titleStr[1],
				x998583_g_NpcList[nMonsterDataId].titleStr[2],
				x998583_g_NpcList[nMonsterDataId].titleStr[3]));
			
			AddNumText( sceneId, x998583_g_ScriptId, x998583_g_NpcList[nMonsterDataId].titleStr[1], 6, 10 )
			AddNumText( sceneId, x998583_g_ScriptId, x998583_g_NpcList[nMonsterDataId].titleStr[2], 6, 11 )
			AddNumText( sceneId, x998583_g_ScriptId, x998583_g_NpcList[nMonsterDataId].titleStr[3], 6, 12 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if opId >= 10 and opId <= 12 then
		local nOpIndex = opId - 10 + 1
		local nNeedLevel = x998583_g_NpcList[nMonsterDataId].titleInfo.needLv[nOpIndex]
		local nTitleId = x998583_g_NpcList[nMonsterDataId].titleInfo.id[nOpIndex]
		if QueryHumanAbilityLevel(sceneId,selfId,x998583_g_NpcList[nMonsterDataId].PrescrAbilityId) < nNeedLevel then
			x998583_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{YCGZ_231225_121}",tostring(nNeedLevel)))
			return
		end
		local retCanAddTitle = LuaFnCanAddTitle( sceneId, selfId, nTitleId )
		if ( retCanAddTitle ~= 1 ) then
			x998583_NotifyTips(sceneId,selfId,"#{YCGZ_231225_123}")
			return
		end
		LuaFnAwardCharTitle( sceneId, selfId, nTitleId )
		LuaFnSetCurTitleById( sceneId, selfId, nTitleId )
		LuaFnDispatchAllTitle(sceneId, selfId)
		
		x998583_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{TCGJ_240111_05}",LuaFnGetTitleNameById(nTitleId)))
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x998583_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--列举事件
--**********************************
function x998583_OnEnumerate( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998583_g_NpcList[nMonsterDataId] == nil then
		return
	end
	AddText(sceneId,x998583_g_NpcList[nMonsterDataId].mainStr);
	--加入盟会
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if x998583_g_NpcList[nMonsterDataId].IdentityId ~= nCurIdentityId then
		AddNumText(sceneId, x998583_g_ScriptId, x998583_g_NpcList[nMonsterDataId].joinBtn, 6, 1)
	else
		AddNumText(sceneId, x998583_g_ScriptId, "#{YCGZ_231225_36}", 6, 5)
	end
	--产物预览
	AddNumText(sceneId, x998583_g_ScriptId, x998583_g_NpcList[nMonsterDataId].yulanStr, 6, 2)
end
--**********************************
--确定加入盟会
--**********************************
function x998583_JoinIdentity( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998583_g_NpcList[nMonsterDataId] == nil then
		return
	end
	local nPreJoinIBId = x998583_g_NpcList[nMonsterDataId].IdentityId
	
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId ~= 0 then
		--检查有无引导任务
		for i = 1,getn(x998583_g_GuildMission) do
			if IsHaveMission(sceneId,selfId,x998583_g_GuildMission[i]) > 0 then
				x998583_NotifyTips( sceneId, selfId,"#{SFYD_231227_291}")
				return
			end
		end
		--检查有无进阶任务
		if IsHaveMission(sceneId,selfId,x998583_g_LevelUpMission) > 0 then
			x998583_NotifyTips( sceneId, selfId,"#{YCGZ_231225_49}")
			return
		end
		--已有盟会
		local nLastJoinTime = GetMissionDataEx(sceneId,selfId,MDEX_LAST_JOIN_IB_TIME)
		if nLastJoinTime > 0 then
			if LuaFnGetCurrentTime() - nLastJoinTime < x998583_g_ChangeIdentityCTime then
				local nRemainTime = x998583_g_ChangeIdentityCTime - (LuaFnGetCurrentTime() - nLastJoinTime)
				x998583_NotifyTips( sceneId, selfId,  
					ScriptGlobal_Format("#{YCGZ_231225_50}",tostring(ceil((nRemainTime / (60 * 60)) / 24))) )
--				return
			end
		end
		--您需持有盟会更易令才可进行盟会的转换。	
		if LuaFnGetAvailableItemCount(sceneId,selfId,x998583_g_ChangeIdentityItem) < 1 then
			x998583_NotifyTips( sceneId, selfId, "#{YCGZ_231225_51}" )
			return
		end
		--扣除更易令
		LuaFnDelAvailableItem(sceneId,selfId,x998583_g_ChangeIdentityItem,1)
	end
	--调整加入的盟会
	LuaFnJoinNewIBIdentity(sceneId,selfId,nPreJoinIBId)
	SetMissionDataEx(sceneId,selfId,MDEX_LAST_JOIN_IB_TIME,LuaFnGetCurrentTime())
	--激活对应生活技能
	local nAbilityId = x998583_g_IdentityAbilityId[nPreJoinIBId]
	local nAbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, nAbilityId)
	if nAbilityLevel <= 0 then
--		SetHumanAbilityLevel(sceneId,selfId,nAbilityId,1)
		--【运行修改】默认直接10级
		SetHumanAbilityLevel(sceneId,selfId,nAbilityId,10)
		--第一次加入，给予特殊称号
		local nTitleId = x998583_g_IdentityNewAgname[nPreJoinIBId]
		local retCanAddTitle = LuaFnCanAddTitle( sceneId, selfId, nTitleId )
		if ( retCanAddTitle == 1 ) then
			LuaFnAwardCharTitle( sceneId, selfId, nTitleId )
			LuaFnSetCurTitleById( sceneId, selfId, nTitleId )
			LuaFnDispatchAllTitle(sceneId, selfId)
		end
	end
	--激活成功提示
	if nCurIdentityId == 0 then
		x998583_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{YCGZ_231225_45}",x998583_g_IdentityName[nPreJoinIBId]) )
	else
		x998583_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{YCGZ_231225_52}",x998583_g_IdentityName[nPreJoinIBId]) )
	end
	x998583_MsgBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{YCGZ_231225_46}",x998583_g_IdentityName[nPreJoinIBId]) )
	--给个效果
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	--更新UI
--	BeginUICommand(sceneId)
--	EndUICommand(sceneId)
--	DispatchUICommand(sceneId,selfId,99858302)
end

--**********************************
--加入盟会选择
--**********************************
function x998583_TryJoinIdentity( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998583_g_NpcList[nMonsterDataId] == nil then
		return
	end
	local nPreJoinIBId = x998583_g_NpcList[nMonsterDataId].IdentityId
	
	BeginEvent( sceneId )
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId == 0 then
		--没有盟会
		AddText( sceneId, ScriptGlobal_Format("#{YCGZ_231225_42}",x998583_g_IdentityName[nPreJoinIBId]) )
	else
		--已有盟会
		AddText( sceneId, ScriptGlobal_Format("#{YCGZ_231225_48}",x998583_g_IdentityName[nCurIdentityId],x998583_g_IdentityName[nPreJoinIBId]) )
	end
	AddNumText(sceneId, x998583_g_ScriptId,"#{YCGZ_231225_43}", 6, 3)
	AddNumText(sceneId, x998583_g_ScriptId,"#{YCGZ_231225_44}", 6, 4)
	
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 玩家登录
--**********************************
function x998583_OnHumanLogin(sceneId,selfId)
	if GetLevel(sceneId,selfId) < x998583_g_MinLevel then
		return
	end
	if GetMissionFlagEx(sceneId,selfId,MFEX_IDENTITY_FIRST_MAIL) == 1 then
		return
	end
	LuaFnSendSystemMail(sceneId, GetName(sceneId, selfId), "#{SFYD_231227_01}")
	SetMissionFlagEx(sceneId,selfId,MFEX_IDENTITY_FIRST_MAIL,1)
end

--**********************************
-- 屏幕中间提示
--**********************************
function x998583_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x998583_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end