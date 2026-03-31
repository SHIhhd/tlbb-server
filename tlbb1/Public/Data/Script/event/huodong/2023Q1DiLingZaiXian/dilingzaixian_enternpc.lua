--地宫四层传送人
--地宫游医

--脚本号
x998260_g_ScriptId = 998260
x998260_g_MinLevel = 60
x998260_g_BuyCount = 5
--补充驱毒时间消费
x998260_g_GetPrize = {
	[0] = 300,
	[1] = 600,
	[2] = 1000,
	[3] = 1500,
	[4] = 2000,
}

--**********************************
--事件列表
--**********************************
function x998260_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{DLZX_230314_10}" )
		AddNumText( sceneId, x998260_g_ScriptId, "#{DLZX_230314_11}", 6, 1 )	
		local nQuDuGetCount = GetMissionDataEx(sceneId,selfId,MDEX_DILING_QUDUTIME)
		AddNumText( sceneId, x998260_g_ScriptId, ScriptGlobal_Format("#{DLZX_230314_12}",nQuDuGetCount), 6, 2 )	
		--秦宫4层
		AddNumText( sceneId, x998260_g_ScriptId, "#{DLZX_230314_13}", 9, 3)		
		--帝陵深渊
--		AddNumText( sceneId, x998260_g_ScriptId, "#{DLZX_230518_148}", 9, 4 )		
		AddNumText( sceneId, x998260_g_ScriptId, "#{DLZX_230314_14}", 11, 100 )	
		AddNumText( sceneId, x998260_g_ScriptId, "#{DLZX_230518_112}", 11, 101 )	
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--Monster Timer
--**********************************
function x998260_OnCharacterTimer( sceneId, objId, dataId, uTime )
--	CallScriptFunction( 893390, "OnSceneTimer", sceneId )
end

--**********************************
--事件交互入口
--**********************************
function x998260_OnDefaultEvent( sceneId, selfId, targetId )
	x998260_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998260_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	--免费获得驱毒时间
	if GetNumText() == 1 then
		if GetLevel(sceneId,selfId) < x998260_g_MinLevel then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_15}" )
			return
		end
		if LuaFnHaveImpactOfSpecificMutexID(sceneId,selfId,5255) == 1 then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_18}" )
			return
		end
		if GetMissionFlagEx(sceneId,selfId,MFEX_DILING_QUDUT_FREE) == 1 then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_16}" )
			return
		end
		
		SetMissionFlagEx(sceneId,selfId,MFEX_DILING_QUDUT_FREE,1)
		--给自己免费的驱毒时间
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5971, 0);
		x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_17}" )
	elseif GetNumText() == 2 then
		--补充驱毒时间
		x998260_AddQuDuTime( sceneId, selfId, targetId,0 )
		
	elseif GetNumText() == 3 then
		if GetLevel(sceneId,selfId) < x998260_g_MinLevel then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_05}" )
			return
		end
		if LuaFnHaveImpactOfSpecificMutexID(sceneId,selfId,5255) == 0 then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_07}" )
			return
		end
		if CallScriptFunction(998262, "IsInActiveTime", sceneId, selfId) ~= 1 then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_06}" )
			return
		end
		local nHasRide_Two = LuaFnGetDRideFlag(sceneId, selfId);
		if nHasRide_Two and nHasRide_Two == 1 then
			x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_116}" )
			return
		end
		--【运行调整】限制最大血量
		if LuaFnGetMaxHp(sceneId,selfId) < 150000 then
			x998260_NotifyTip( sceneId, selfId, "当前血上限不足150,000，此行凶险，请先提高自身修为" )
			return
		end
		--如果存在队伍
		if GetTeamId( sceneId, selfId) >= 0 then
			--只有队长可以操作。
			if LuaFnIsTeamLeader( sceneId, selfId) == 0 then
				x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_119}" )
				return
			end
			local nNearTeamCount = GetNearTeamCount( sceneId, selfId) 
			if	nNearTeamCount < GetTeamSize(sceneId,selfId) then
				x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_122}" )
				return
			end
			for	i=0, nNearTeamCount - 1 do
				local nTeamMember = GetNearTeamMember( sceneId, selfId, i )
				if LuaFnIsObjValid(sceneId,nTeamMember) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nTeamMember) == 1 then
					if GetLevel(sceneId,nTeamMember) < x998260_g_MinLevel then
						x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_120}" )
						return
					end
					local nHasRide_Two = LuaFnGetDRideFlag(sceneId, nTeamMember);
					if nHasRide_Two and nHasRide_Two == 1 then
						x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_123}" )
						return
					end
					if LuaFnHaveImpactOfSpecificMutexID(sceneId,nTeamMember,5255) == 0 then
						x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_124}" )
						return
					end
					if LuaFnGetMaxHp(sceneId,nTeamMember) < 150000 then
						x998260_NotifyTip( sceneId, selfId, "有队员的血上限不足150000，此行凶险，请先提高其修为" )
						return
					end
				end
			end
		end
		CallScriptFunction( 400900, "TransferFunc", sceneId, selfId, 17012, 41,43, 75 );
--	elseif GetNumText() == 4 then
--		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 17112, 41,43, 75 );
	elseif GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{DLZX_230314_112}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 101 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{DLZX_230518_113}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

--**********************************
--补充驱毒时间确认
--**********************************
function x998260_CallBack_BuyPermision_Confirm( sceneId, selfId, targetId,bConfrim )
	if bConfrim ~= 1 then
		return
	end
	if x998260_AddQuDuTime( sceneId, selfId, targetId,bConfrim ) == 0 then
		return
	end
	--您今日驱毒时间（含可补充驱毒时间）已全部消耗完毕，无法进入秦皇地宫四层。	
	local nQuDuGetCount = GetMissionDataEx(sceneId,selfId,MDEX_DILING_QUDUTIME)
	if nQuDuGetCount >= x998260_g_BuyCount then
		x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_20}" )
		return
	end
	local nNeedYuanbao = x998260_g_GetPrize[nQuDuGetCount]
	if nNeedYuanbao == nil then
		return
	end
	--	探测元宝是否足够
	local nCurYB = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYB < nNeedYuanbao then
		x998260_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{DLZX_230314_133}",tostring(nNeedYuanbao)))
		return
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x998260_NotifyTip( sceneId, selfId,"#{DLZX_230314_134}")
		return
	end
	LuaFnCostYuanBao(sceneId,selfId,nNeedYuanbao,998260,"CallBack_BuyPermision_Confirm",0,-1);
	--补充时间
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5970, 0);
end
--**********************************
--补充驱毒时间
--**********************************
function x998260_AddQuDuTime( sceneId, selfId, targetId,bConfrim )
	if GetLevel(sceneId,selfId) < x998260_g_MinLevel then
		x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_15}" )
		return 0
	end
	if LuaFnHaveImpactOfSpecificMutexID(sceneId,selfId,5255) == 1 then
		x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_18}" )
		return 0
	end
	--您今日尚未领取过免费驱毒时间，请先领取免费驱毒时间。	
	if GetMissionFlagEx(sceneId,selfId,MFEX_DILING_QUDUT_FREE) == 0 then
		x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_19}" )
		return 0
	end
	--您今日驱毒时间（含可补充驱毒时间）已全部消耗完毕，无法进入秦皇地宫四层。	
	local nQuDuGetCount = GetMissionDataEx(sceneId,selfId,MDEX_DILING_QUDUTIME)
	if nQuDuGetCount >= x998260_g_BuyCount then
		x998260_NotifyTip( sceneId, selfId, "#{DLZX_230314_20}" )
		return 0
	end
	local nNeedYuanbao = x998260_g_GetPrize[nQuDuGetCount]
	if nNeedYuanbao == nil then
		return 0
	end
	--	探测元宝是否足够
	local nCurYB = YuanBao(sceneId,selfId,selfId,3,0)
	if nCurYB < nNeedYuanbao then
		x998260_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{DLZX_230314_133}",tostring(nNeedYuanbao)))
		return 0
	end
	if LuaFnIsCanYuanBaoCost(sceneId,selfId,nNeedYuanbao) ~= 1 then
		x998260_NotifyTip( sceneId, selfId,"#{DLZX_230314_134}")
		return 0
	end
	if bConfrim == 0 then
		--二次确认
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1)				--帝陵再现PVP活动
			UICommand_AddInt( sceneId, targetId)
			UICommand_AddInt( sceneId, nNeedYuanbao)
			UICommand_AddInt( sceneId, nQuDuGetCount + 1)
			UICommand_AddInt( sceneId, x998260_g_BuyCount + -nQuDuGetCount)
			UICommand_AddInt( sceneId, 1)
			UICommand_AddInt( sceneId, 0)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99826001 )
		return 0
	end
	return 1
end

--**********************************
--接受此NPC的任务
--**********************************
function x998260_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--拒绝此NPC的任务
--**********************************
function x998260_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--继续（已经接了任务）
--**********************************
function x998260_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )

end

--**********************************
--提交已做完的任务
--**********************************
function x998260_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )

end

--**********************************
--死亡事件
--**********************************
function x998260_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x998260_NotifyBox( sceneId, selfId,targetId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x998260_NotifyTip( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
