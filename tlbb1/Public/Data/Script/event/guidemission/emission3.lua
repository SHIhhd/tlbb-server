--MisDescBegin
--新版本引导任务设计
--脚本号
x998791_g_ScriptId = 998791

x998791_g_Position_X=150
x998791_g_Position_Z=208
x998791_g_SceneID=1
x998791_g_AccomplishNPC_Name="百晓生"

--任务号
x998791_g_MissionId = 2267
x998791_g_PreMissionId = 2266

--任务归类
x998791_g_MissionKind = 9

--任务等级
x998791_g_MissionLevel = 50

--是否是精英任务
x998791_g_IfMissionElite = 0

--任务名
x998791_g_MissionName = "#{QEYD_240402_27}"
x998791_g_MissionTarget = "#{QEYD_240402_28}"
x998791_g_IsMissionOkFail = 0
x998791_g_Custom = {{ id = "录入江湖志·苍山篇", num = 1}}
x998791_g_ContinueInfo = "#{QEYD_240402_98}"
x998791_g_MissionComplete = "#{QEYD_240402_153}"

--MisDescEnd
x998791_g_MissionHandleNpcName = "枯荣大师"
x998791_g_JiangHuZhiItemId = 38003155
--**********************************
--任务入口函数
--**********************************
function x998791_OnDefaultEvent( sceneId, selfId, targetId )
	if (IsMissionHaveDone(sceneId,selfId,x998791_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x998791_g_MissionId) > 0)  then
        local misIndex = GetMissionIndexByID(sceneId,selfId,x998791_g_MissionId)
	    local misOk = GetMissionParam(sceneId,selfId,misIndex,x998791_g_IsMissionOkFail)
		if GetName(sceneId,targetId) == x998791_g_MissionHandleNpcName then
            --检查有无江湖志
            if LuaFnGetAvailableItemCount(sceneId,selfId,x998791_g_JiangHuZhiItemId) < 1 then
                BeginEvent(sceneId)
                    AddText(sceneId,"#{QEYD_240402_68}")
                EndEvent()
                DispatchEventList(sceneId,selfId,targetId)
                return
            end
			if misOk == 0 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{QEYD_240402_96}")
				EndEvent()
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x998791_g_ScriptId,x998791_g_MissionId)
			end
        elseif GetName(sceneId,targetId) == x998791_g_AccomplishNPC_Name then
            --没有完成任务
            BeginEvent(sceneId)
                AddText(sceneId,"#{QEYD_240402_98}")
            EndEvent()
			if misOk == 0 then
                DispatchEventList(sceneId,selfId,targetId)
                --QEYD_240402_80	#H您尚未完成此任务，无法交付。	
                x998791_NotifyTips( sceneId, selfId, "#{QEYD_240402_80}")
                return
            else
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x998791_g_ScriptId,x998791_g_MissionId)
			end
		end
	elseif x998791_CheckAccept( sceneId, selfId ) > 0 then
--		发送任务接受时显示的信息
		if GetName(sceneId,targetId) == x998791_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{QEYD_240402_90}")
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x998791_g_ScriptId,x998791_g_MissionId)
		end
	end
end
--**********************************
--列举事件
--**********************************
function x998791_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998791_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998791_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x998791_g_MissionHandleNpcName then
			AddNumText(sceneId, x998791_g_ScriptId,"#{QEYD_240402_92}",2,-1);
		elseif GetName(sceneId,targetId) == x998791_g_AccomplishNPC_Name then
			AddNumText(sceneId, x998791_g_ScriptId,x998791_g_MissionName,2,-1);
		end
	--满足任务接收条件
	elseif x998791_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x998791_g_AccomplishNPC_Name then
			AddNumText(sceneId,x998791_g_ScriptId,x998791_g_MissionName,1,-1);
		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x998791_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x998791_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x998791_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x998791_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end
--**********************************
--客户端请求接收任务
--**********************************
function x998791_OnAccept(sceneId,selfId,targetId)
	if x998791_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
    --不允许处于组队跟随模式
    if IsTeamFollow(sceneId,selfId) == 1 then
        x998791_NotifyTips( sceneId, selfId, "#{QEYD_240402_65}")
        return
    end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x998791_g_MissionId, x998791_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x998791_NotifyTips(sceneId,selfId,"#{QEYD_240402_18}")
        BeginEvent(sceneId)
            AddText(sceneId,"#{QEYD_240402_86}");
        EndEvent(sceneId)
        DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--成功接取任务
    x998791_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{QEYD_240402_19}",x998791_g_MissionName))
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{QEYD_240402_87}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x998791_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	-- DelMission( sceneId, selfId, x998791_g_MissionId )
    --任务不允许放弃
	x998791_NotifyTips( sceneId, selfId, "#{QEYD_240402_36}")
end

--**********************************
--检测是否可以提交
--**********************************
function x998791_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998791_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998791_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x998791_g_IsMissionOkFail)
	if misOk ~= 1 then
		return 0
	end
		
	return 1
end

--**********************************
--提交
--**********************************
function x998791_OnSubmit( sceneId, selfId, targetId, selectRadioId )
    --枯荣大师处
    if GetName(sceneId,targetId) == x998791_g_MissionHandleNpcName then
        if IsHaveMission(sceneId,selfId,x998791_g_MissionId) < 1 then
            x998791_NotifyTips(sceneId,selfId,"#{QEYD_240402_94}")
            return
        else
            local misIndex = GetMissionIndexByID(sceneId,selfId,x998791_g_MissionId)
            SetMissionByIndex(sceneId,selfId,misIndex,x998791_g_IsMissionOkFail,1)
            --QEYD_240402_95	#H您已成功录入九州江湖志·苍山篇。	
            x998791_NotifyTips(sceneId,selfId,"#{QEYD_240402_95}")
			--弹出江湖志UI
    		CallScriptFunction(998797,"SetFlagOpenAndShowUI",sceneId,selfId,2)
        end
    elseif GetName(sceneId,targetId) == x998791_g_AccomplishNPC_Name then
		--其余是在百晓生处
        if x998791_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
            local misIndex = GetMissionIndexByID(sceneId,selfId,x998791_g_MissionId)
	        local misOk = GetMissionParam(sceneId,selfId,misIndex,x998791_g_IsMissionOkFail)
            if misOk == 0 then
                x998791_NotifyTips(sceneId,selfId,"#{QEYD_240402_80}")
                return
            end
            DelMission( sceneId, selfId, x998791_g_MissionId )
            MissionCom( sceneId, selfId, x998791_g_MissionId )
            
            BeginEvent(sceneId)
                AddText(sceneId, ScriptGlobal_Format("#{SFYD_231227_122}",x998791_g_MissionName))
            EndEvent(sceneId)
            DispatchMissionTips(sceneId,selfId)
            --调取下一个引导任务
			CallScriptFunction(998792,"OnDefaultEvent",sceneId,selfId,targetId)
        end
    end
end

--**********************************
--标记任务完成
--**********************************
function x998791_OnMissionFinish( sceneId, selfId )
	if IsMissionHaveDone(sceneId,selfId,x998791_g_MissionId) > 0 then
		return
	end
	if IsHaveMission(sceneId,selfId,x998791_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998791_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,x998791_g_IsMissionOkFail,1)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998791_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998791_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998791_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x998791_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
