--MisDescBegin
--新版本引导任务设计
--脚本号
x998792_g_ScriptId = 998792

x998792_g_Position_X=150
x998792_g_Position_Z=208
x998792_g_SceneID=1
x998792_g_AccomplishNPC_Name="百晓生"

--任务号
x998792_g_MissionId = 2268
x998792_g_PreMissionId = 2267

--任务归类
x998792_g_MissionKind = 9

--任务等级
x998792_g_MissionLevel = 50

--是否是精英任务
x998792_g_IfMissionElite = 0

--任务名
x998792_g_MissionName = "#{QEYD_240402_30}"
x998792_g_MissionTarget = "#{QEYD_240402_31}"
x998792_g_IsMissionOkFail = 0
x998792_g_Custom = {{ id = "录入江湖志·龙塔篇", num = 1}}
x998792_g_ContinueInfo = "#{QEYD_240402_114}"
x998792_g_MissionComplete = "#{QEYD_240402_153}"

--MisDescEnd
x998792_g_PrizeItem = 20310174
x998792_g_TaskItem = 40005169
--**********************************
--任务入口函数
--**********************************
function x998792_OnDefaultEvent( sceneId, selfId, targetId )
	--补领任务道具
	if GetNumText() == 1000 then
		--QEYD_240402_101	#H您已拥有笔章纸墨，无需重复领取。	
		if LuaFnGetAvailableItemCount(sceneId,selfId,x998792_g_TaskItem) > 0 then
			x998792_NotifyTips( sceneId, selfId, "#{QEYD_240402_101}")
            return
		end
		if LuaFnGetTaskItemBagSpace(sceneId,selfId) < 1 then
			x998792_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{QEYD_240402_45}",tostring(1)))
			return
		end
		--添加特殊任务道具
		BeginAddItem(sceneId)
		AddItem( sceneId, x998792_g_TaskItem, 1 )
		EndAddItem(sceneId,selfId)
		AddItemListToHuman(sceneId,selfId)
		return
	end
	--任务部分
	if (IsMissionHaveDone(sceneId,selfId,x998792_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x998792_g_MissionId) > 0)  then
        local misIndex = GetMissionIndexByID(sceneId,selfId,x998792_g_MissionId)
	    local misOk = GetMissionParam(sceneId,selfId,misIndex,x998792_g_IsMissionOkFail)
		if GetName(sceneId,targetId) == x998792_g_AccomplishNPC_Name then
            --没有完成任务
            BeginEvent(sceneId)
                AddText(sceneId,"#{QEYD_240402_114}")
            EndEvent()
			if misOk == 0 then
                DispatchEventList(sceneId,selfId,targetId)
                --QEYD_240402_80	#H您尚未完成此任务，无法交付。	
                x998792_NotifyTips( sceneId, selfId, "#{QEYD_240402_80}")
                return
            else
				DispatchMissionContinueInfo(sceneId,selfId,targetId,x998792_g_ScriptId,x998792_g_MissionId)
			end
		end
	elseif x998792_CheckAccept( sceneId, selfId ) > 0 then
--		发送任务接受时显示的信息
		if GetName(sceneId,targetId) == x998792_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{QEYD_240402_82}")
			EndEvent()
			DispatchMissionInfo(sceneId,selfId,targetId,x998792_g_ScriptId,x998792_g_MissionId)
		end
	end
end
--**********************************
--列举事件
--**********************************
function x998792_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x998792_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x998792_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x998792_g_AccomplishNPC_Name then
			AddNumText(sceneId, x998792_g_ScriptId,x998792_g_MissionName,2,-1);
			--任务道具补领
			AddNumText(sceneId, x998792_g_ScriptId,"#{QEYD_240402_89}",6,1000);
		end
	--满足任务接收条件
	elseif x998792_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x998792_g_AccomplishNPC_Name then
			AddNumText(sceneId,x998792_g_ScriptId,x998792_g_MissionName,1,-1);
		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x998792_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x998792_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x998792_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x998792_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end
--**********************************
--客户端请求接收任务
--**********************************
function x998792_OnAccept(sceneId,selfId,targetId)
	if x998792_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
    --不允许处于组队跟随模式
    if IsTeamFollow(sceneId,selfId) == 1 then
        x998792_NotifyTips( sceneId, selfId, "#{QEYD_240402_65}")
        return
    end
    if LuaFnGetTaskItemBagSpace(sceneId,selfId) < 1 then
        x998792_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{QEYD_240402_45}",tostring(1)))
        return
    end
    --添加特殊任务道具
    BeginAddItem(sceneId)
    AddItem( sceneId, x998792_g_TaskItem, 1 )
    EndAddItem(sceneId,selfId)
    AddItemListToHuman(sceneId,selfId)
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x998792_g_MissionId, x998792_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x998792_NotifyTips(sceneId,selfId,"#{QEYD_240402_18}")
        BeginEvent(sceneId)
            AddText(sceneId,"#{QEYD_240402_86}");
        EndEvent(sceneId)
        DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--成功接取任务
    x998792_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{QEYD_240402_19}",x998792_g_MissionName))
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{QEYD_240402_100}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x998792_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	-- DelMission( sceneId, selfId, x998792_g_MissionId )
    --任务不允许放弃
	x998792_NotifyTips( sceneId, selfId, "#{QEYD_240402_36}")
end

--**********************************
--检测是否可以提交
--**********************************
function x998792_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x998792_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998792_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x998792_g_IsMissionOkFail)
	if misOk ~= 1 then
		return 0
	end
		
	return 1
end

--**********************************
--提交
--**********************************
function x998792_OnSubmit( sceneId, selfId, targetId, selectRadioId )
    --百晓生处
    if GetName(sceneId,targetId) == x998792_g_AccomplishNPC_Name then
        if x998792_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
            local misIndex = GetMissionIndexByID(sceneId,selfId,x998792_g_MissionId)
	        local misOk = GetMissionParam(sceneId,selfId,misIndex,x998792_g_IsMissionOkFail)
            if misOk == 0 then
                x998792_NotifyTips(sceneId,selfId,"#{QEYD_240402_80}")
                return
            end
			--给灵蚕丝
			--检测背包空间
            BeginAddItem(sceneId)
            AddItem(sceneId,x998792_g_PrizeItem,1)
            if EndAddItem(sceneId,selfId) <= 0 then
                local iBase,iMat = LuaFnCalcAddItemNeedBagSize(sceneId)
                if iBase ~= nil and iBase > 0 then
                    x998792_NotifyTips(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_115}",tostring(iBase)))
                end
                if iMat ~= nil and iMat > 0 then
                    x998792_NotifyTips(sceneId, selfId,ScriptGlobal_Format("#{QEYD_240402_116}",tostring(iMat)))
                end
                return
            end
            --给物品
	        AddItemListToHuman(sceneId,selfId)
			--物品获取提示
			x998792_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{QEYD_240402_49}",GetItemName(sceneId,x998792_g_PrizeItem)))

            DelMission( sceneId, selfId, x998792_g_MissionId )
            MissionCom( sceneId, selfId, x998792_g_MissionId )
            
			x998792_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{SFYD_231227_122}",x998792_g_MissionName))
            --调取下一个引导任务
			CallScriptFunction(998793,"OnDefaultEvent",sceneId,selfId,targetId)
        end
    end
end

--**********************************
--标记任务完成
--**********************************
function x998792_OnMissionFinish( sceneId, selfId )
	if IsMissionHaveDone(sceneId,selfId,x998792_g_MissionId) > 0 then
		return
	end
	if IsHaveMission(sceneId,selfId,x998792_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x998792_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,x998792_g_IsMissionOkFail,1)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x998792_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x998792_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x998792_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x998792_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
