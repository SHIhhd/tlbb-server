--盟会升阶任务核心

x998595_g_ScriptId = 998595

x998595_g_KDZZID = 1001000252
x998595_g_SubKDZZID_Mission = 5

--任务号
x998595_g_MissionId = 2250

--任务归类
x998595_g_MissionKind = 66

--任务等级
x998595_g_MissionLevel = 50

--对应的生活技能信息
x998595_g_IdentityAbilityId = {
	[IDENTITY_COOKING_IDX] = ABILITY_IDENTITY_ZHISHAN,
	[IDENTITY_PHARMACY_IDX] = ABILITY_IDENTITY_LIANYAO,
	[IDENTITY_ATTACKEQUIP_IDX] = ABILITY_IDENTITY_ZHUQI,
	[IDENTITY_ENGINEER_IDX] = ABILITY_IDENTITY_JIQIAO,
}

--任务名称
x998595_g_MissionName = {
	"#{YCGZ_231225_58}",
	"#{YCGZ_231225_59}",
	"#{YCGZ_231225_60}",
	"#{YCGZ_231225_61}",
	"#{YCGZ_231225_135}",
	"#{YCGZ_231225_136}",
	"#{YCGZ_231225_137}",
	"#{YCGZ_231225_138}",
	"#{YCGZ_231225_139}",
}
--**********************************
--任务入口函数
--**********************************
function x998595_OnDefaultEvent( sceneId, selfId, targetId,scriptId, needDoCount,needLevel )	
	if (IsMissionHaveDone(sceneId,selfId,x998595_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x998595_g_MissionId) > 0)  then
		if x998595_CheckSubmit( sceneId, selfId ) == 1 then
			--点击后直接提交
			x998595_OnSubmit( sceneId, selfId, targetId )
		else
			BeginEvent(sceneId)
				AddText(sceneId,"#{YCGZ_231225_145}")
			EndEvent()
			DispatchEventList(sceneId,selfId,targetId)
			
			BeginEvent(sceneId)
				AddText(sceneId,"#{YCGZ_231225_99}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			
		end
	elseif x998595_CheckAccept( sceneId, selfId,needLevel ) > 0 then
--		发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{YCGZ_231225_82}",tostring(needDoCount)))
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,scriptId,x998595_g_MissionId)
	end
end
--**********************************
--列举事件
--**********************************
function x998595_OnEnumerate( sceneId, selfId, targetId,scriptId,strMissionName,needLevel )
	-- 当前是否存在盟会
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId == 0 or x998595_g_IdentityAbilityId[nCurIdentityId] == nil then
		return
	end
	-- 是否已达到目前盟会的最高等级
	local AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x998595_g_IdentityAbilityId[nCurIdentityId])
	if AbilityLevel >= 10 or AbilityLevel ~= needLevel then
		return
	end
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998595_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998595_g_MissionId) > 0 then
		AddNumText(sceneId, scriptId,strMissionName,2,-1);
	--满足任务接收条件
	elseif x998595_CheckAccept(sceneId,selfId,needLevel) > 0 then
		AddNumText(sceneId,scriptId,strMissionName,1,-1);
	end
end
--**********************************
--检测接受条件
--**********************************
function x998595_CheckAccept( sceneId, selfId,needLevel )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x998595_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x998595_g_MissionLevel then
		return 0
	end
	
	-- 当前是否存在盟会
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId == 0 or x998595_g_IdentityAbilityId[nCurIdentityId] == nil then
		return 0
	end
	
	-- 是否已达到目前盟会的最高等级
	local AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x998595_g_IdentityAbilityId[nCurIdentityId])
	if AbilityLevel >= 10 or AbilityLevel ~= needLevel then
		return 0
	end
	
	local ExpLimit = nil
	local ret, _, _, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x998595_g_IdentityAbilityId[nCurIdentityId], AbilityLevel);
	if ret and ret == 1 then
		ExpLimit = currentLevelAbilityExpTop;
	end
	if ExpLimit == nil then
		return 0
	end
	
	if GetAbilityExp(sceneId, selfId, x998595_g_IdentityAbilityId[nCurIdentityId]) < ExpLimit then
		return 0
	end
	
	return 1
end
--**********************************
--客户端请求接收任务
--**********************************
function x998595_OnAccept(sceneId,selfId,targetId,scriptId,needDoCount,strMissionName,needLevel)
	if x998595_CheckAccept(sceneId,selfId,needLevel) ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{YCGZ_231225_93}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	if GetLevel(sceneId,selfId) < x998595_g_MissionLevel then
		BeginEvent(sceneId)
			AddText(sceneId,"#{YCGZ_231225_91}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId,"#{YCGZ_231225_140}")
		EndEvent()
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	-- 当前是否存在盟会
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId == 0 or x998595_g_IdentityAbilityId[nCurIdentityId] == nil then
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x998595_g_MissionId, scriptId, 0, 0, 1 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{YCGZ_231225_94}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId,"#{YCGZ_231225_142}")
		EndEvent()
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{YCGZ_231225_81}",strMissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--设置任务的跟踪参数
	--1:当前已制作数量 2:预留 3:需要制作数量
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998595_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
	SetMissionByIndex(sceneId,selfId,misIndex,3,needDoCount)
end

--**********************************
--放弃
--**********************************
function x998595_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x998595_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x998595_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998595_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998595_g_MissionId)
	local curDoCount = GetMissionParam(sceneId,selfId,misIndex,1)
	local needDoCount = GetMissionParam(sceneId,selfId,misIndex,3)
	if curDoCount < needDoCount then
		return 0
	end
		
	return 1
end

--**********************************
--提交
--**********************************
function x998595_OnSubmit( sceneId, selfId,targetId )
	if x998595_CheckSubmit( sceneId, selfId ) == 1 then
		--删除任务		
		DelMission( sceneId, selfId, x998595_g_MissionId )
		
		--提升对应生活技能等级
		local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
		if x998595_g_IdentityAbilityId[nCurIdentityId] ~= nil then
			local AbilityId = x998595_g_IdentityAbilityId[nCurIdentityId]
			local AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, AbilityId)
			if AbilityLevel >= 10 then
				return
			end
			local ret, _, _, _, _, currentLevelAbilityExpTop = LuaFnGetAbilityLevelUpConfig(AbilityId, AbilityLevel);
			if ret and ret == 1 then
				if GetAbilityExp(sceneId, selfId, AbilityId) >= currentLevelAbilityExpTop then
					SetHumanAbilityLevel(sceneId, selfId, AbilityId, AbilityLevel+1)
					
					BeginEvent(sceneId)
						AddText(sceneId, ScriptGlobal_Format("#{YCGZ_231225_100}",x998595_g_MissionName[AbilityLevel]))
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				end
			end
		end
		--给个效果
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
		--关闭当前对话框
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )	
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998595_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998595_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998595_OnItemChanged( sceneId, selfId, itemdataId )
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId == 0 or x998595_g_IdentityAbilityId[nCurIdentityId] == nil then
		return
	end
	local AbilityId = x998595_g_IdentityAbilityId[nCurIdentityId]
	local AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, AbilityId)

	local nPerscriptId = LuaFnGetItemCompoundHelperFromResultId(itemdataId,GetMenPai(sceneId,selfId))
	if nPerscriptId ~= -1 then
		local tRecipe = LuaFnGetPrescriptionInfo(nPerscriptId)
		if tRecipe == nil then
			return
		end
		if tRecipe.AbilityID == AbilityId and tRecipe.AbilityLevel == AbilityLevel then
			--记录完成了一次
			local misIndex = GetMissionIndexByID(sceneId,selfId,x998595_g_MissionId)
			local curDoCount = GetMissionParam(sceneId,selfId,misIndex,1)
			SetMissionByIndex(sceneId,selfId,misIndex,1,curDoCount + 1)
			return
		end
	else
		local tPrescription = LuaFnGetPrescriptionInfoOfProductId(itemdataId)
		if tPrescription == nil then
			return
		end
		for i, v in tPrescription do
			print(v.PrescriptionID, v.AbilityID, v.AbilityLevel)
			if v.AbilityID == AbilityId and v.AbilityLevel == AbilityLevel then
				--记录完成了一次
				local misIndex = GetMissionIndexByID(sceneId,selfId,x998595_g_MissionId)
				local curDoCount = GetMissionParam(sceneId,selfId,misIndex,1)
				SetMissionByIndex(sceneId,selfId,misIndex,1,curDoCount + 1)
				
				return
			end
		end
	end
end
--**********************************
-- 屏幕中间提示
--**********************************
function x998595_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
