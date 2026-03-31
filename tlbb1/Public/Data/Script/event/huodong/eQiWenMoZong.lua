--MisDescBegin
--脚本号
x808134_g_ScriptId = 808134

--任务NPC
x808134_g_AccomplishNPC_Name="梁道士"

--上一个任务的ID
--g_MissionIdPre =

--任务号
x808134_g_MissionId = 1157

--目标NPC
x808134_g_Name	="许愿树"

--任务归类
x808134_g_MissionKind = 12

--任务等级
x808134_g_MissionLevel = 10000

--是否是精英任务
x808134_g_IfMissionElite = 0

--任务文本描述
x808134_g_MissionName="#{ZXCM_090602_07}"
x808134_g_MissionTarget="#{ZXCM_090602_10}"

x808134_g_Custom1	= { {id="已找许愿树",num=1} }
x808134_g_Custom2	= { {id="已得到线索",num=1} }
x808134_g_IsMissionOkFail = 1		--变量的第0位
x808134_g_Exp = 19369 --送个口信给个固定经验就行
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x808134_OnDefaultEvent( sceneId, selfId, targetId )
	local misIndex = GetMissionIndexByID(sceneId, selfId, x808134_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	local param_2 = GetMissionParam(sceneId,selfId,misIndex,x808134_g_IsMissionOkFail)
	local param_3 = GetMissionParam(sceneId,selfId,misIndex,2)
	if IsHaveMission(sceneId,selfId,x808134_g_MissionId) > 0 and GetName(sceneId,targetId) == x808134_g_AccomplishNPC_Name then
		local bDone = x808134_CheckSubmit(sceneId,selfId)
		if bDone == 1 then
			x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
			SetMissionByIndex(sceneId,selfId,misIndex,0,2)
			return
		end
		if bDone == 2 then
			x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
			SetMissionByIndex(sceneId,selfId,misIndex,0,2)
			return
		end
		if bDone == 3 then
			BeginEvent(sceneId)
				AddText( sceneId,"#{ZXCM_090602_14}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,x808134_g_MissionName)
			AddText(sceneId,"#{ZXCM_090602_14}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x808134_g_ScriptId,x808134_g_MissionId)
	elseif IsHaveMission(sceneId,selfId,x808134_g_MissionId) > 0 and GetName(sceneId,targetId) == x808134_g_Name and param == 0 and param_2 == 0 and param_3 == 0 then
			SetMissionByIndex(sceneId,selfId,misIndex,0,1)
			SetMissionByIndex(sceneId,selfId,misIndex,x808134_g_IsMissionOkFail,1)
			SetMissionByIndex(sceneId,selfId,misIndex,2,1)
			x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_11}1/1")
			x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_12}1/1")
			BeginEvent(sceneId)
				AddText( sceneId,"#{ZXCM_090602_13}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
	--满足任务接收条件
	elseif x808134_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x808134_g_AccomplishNPC_Name then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x808134_g_MissionName)
			AddText(sceneId,x808134_g_MissionTarget)
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x808134_g_ScriptId,x808134_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x808134_OnEnumerate( sceneId, selfId, targetId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x808134_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	local param_2 = GetMissionParam(sceneId,selfId,misIndex,x808134_g_IsMissionOkFail)
	local param_3 = GetMissionParam(sceneId,selfId,misIndex,2)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x808134_g_MissionId) > 0 and GetName(sceneId,targetId) == x808134_g_AccomplishNPC_Name then
	    AddNumText(sceneId, x808134_g_ScriptId, x808134_g_MissionName,4,-1);
	elseif IsHaveMission(sceneId,selfId,x808134_g_MissionId) > 0 and GetName(sceneId,targetId) == x808134_g_Name and param == 0 and param_2 == 0 and param_3 == 0 then
		AddNumText(sceneId, x808134_g_ScriptId, x808134_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x808134_CheckAccept(sceneId,selfId) > 0 and GetName(sceneId,targetId) == x808134_g_AccomplishNPC_Name then
		AddNumText(sceneId, x808134_g_ScriptId, x808134_g_MissionName, 3, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x808134_CheckAccept(sceneId,selfId)
	local nWeek = GetTodayWeek();
	local nTime = GetHour() * 100 + GetMinute()
	--需要一个判断，判断玩家当前任务到第几环了，防止其余人卡任务，每周只能完成一次。
	local nMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_ZHONGXIACHUMO)
	if nWeek ~= 3 then
		return 0
	end
	if nTime < 1900 or nTime > 2200 then
		return 0
	end
	--证明今天任务已经做满了
	if nMissionCount == 3 then
		return 0
	end
	return 1
end

--**********************************
--接受
--**********************************
function x808134_OnAccept( sceneId, selfId )
	if x808134_CheckAccept(sceneId,selfId) == 0 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x808134_g_MissionId, x808134_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_09}")
		return
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x808134_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808134_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808134_g_IsMissionOkFail+1,0)
end

--**********************************
--放弃
--**********************************
function x808134_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x808134_g_MissionId )
end

--**********************************
--继续
--**********************************
function x808134_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x808134_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x808134_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	local nWeek = GetTodayWeek();
	local nTime = GetHour() * 100 + GetMinute()
	if nWeek ~= 3 then
		return 1
	end
	if nTime > 2200 then
		return 2
	end
	if param == 0 or param == 2 then
		return 3
	end
	return 4
end

--**********************************
--提交
--**********************************
function x808134_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x808134_g_MissionId) <= 0 then
		return
	end
	-- 2、任务过期
	if x808134_CheckSubmit(sceneId, selfId) == 1 then
		x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
		return
	end
	-- 3、任务过期
	if x808134_CheckSubmit(sceneId, selfId) == 2 then
		x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
		return
	end
	-- 4、未完成
	if x808134_CheckSubmit(sceneId, selfId) == 3 then
		return
	end
	-- 3、任务过期情况检测，测试阶段暂时不加
	DelMission( sceneId,selfId, x808134_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x808134_g_MissionId)
	LuaFnAddExp(sceneId,selfId,x808134_g_Exp)
	--设置任务当前完成阶段
	SetMissionDataEx(sceneId,selfId,MDEX_ZHONGXIACHUMO,1)
	x808134_NotifyTips(sceneId,selfId,"#{ZXCM_090602_16}")
end

--**********************************
--杀死怪物或玩家
--**********************************
function x808134_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x808134_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x808134_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x808134_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end