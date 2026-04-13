--MisDescBegin
--脚本号
x893042_g_ScriptId = 893042

--完成任务NPC属性
x893042_g_Position_X=151
x893042_g_Position_Z=132
x893042_g_SceneID=40
x893042_g_AccomplishNPC_Name="狻猊"

--前置任务
x893042_g_PreMissionId = 2061
x893042_g_PreMissionName="#{SHYD_20211227_61}"

--任务号
x893042_g_MissionId = 2062

--任务归类
x893042_g_MissionKind = 9

--任务等级
x893042_g_MissionLevel = 85 --10000

--是否是精英任务
x893042_g_IfMissionElite = 0

--任务名
x893042_g_MissionName="#{SHYD_20211227_96}"
x893042_g_MissionTarget="#{SHYD_20211227_97}"
x893042_g_IsMissionOkFail=0
x893042_g_Custom = {{id = "完成第一处探索", num = 1}, {id = "完成第二处探索", num = 1}, {id = "完成第三处探索", num = 1}}
x893042_g_ContinueInfo = ""
x893042_g_MissionComplete = "#{SHYD_20211227_173}"

x893042_g_MoneyJZBonus = 20000
x893042_g_ExpBonus = 1200000

--MisDescEnd
x893042_g_AcceptNPC_Name="云决决"
x893042_g_AcceptNPCPosition_X=107
x893042_g_AcceptNPCPosition_Z=87
x893042_g_AcceptNPCSceneID=39

x893042_g_LuoPanItem = 40005033

x893042_g_LuoPanPosition = {
	[1] = {x = 237, z = 160,param = 1},
	[2] = {x = 154, z = 186,param = 2},
	[3] = {x = 107, z = 175,param = 3},
}
--**********************************
--任务入口函数
--**********************************
function x893042_OnDefaultEvent( sceneId, selfId, targetId )
	if IsMissionHaveDone(sceneId,selfId,x893042_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893042_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x893042_g_AccomplishNPC_Name then
--		提交任务时的说明信息
		BeginEvent(sceneId)
			AddText(sceneId,x893042_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_173}")
			AddMoneyJZBonus(sceneId,x893042_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x893042_g_ScriptId,x893042_g_MissionId)		
	elseif x893042_CheckAccept( sceneId, selfId ) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x893042_g_MissionName)
			AddText(sceneId,"#{SHYD_20211227_85}")
			AddMoneyJZBonus( sceneId,x893042_g_MoneyJZBonus)
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x893042_g_ScriptId,x893042_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x893042_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893042_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893042_g_MissionId) > 0 
		and GetName(sceneId,targetId) == x893042_g_AccomplishNPC_Name then
		
		AddNumText(sceneId, x893042_g_ScriptId,"#G"..x893042_g_MissionName,2,-1);
		--paopao 
		MonsterTalk(sceneId, targetId, "玄武岛·镜", "#{SHYD_20211227_172}")
	--满足任务接收条件
	elseif x893042_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x893042_g_AcceptNPC_Name then
			AddNumText(sceneId,x893042_g_ScriptId,"#G"..x893042_g_MissionName,1,-1);
		end
	end
end
--**********************************
--接取任务
--**********************************
function x893042_OnAccept(sceneId,selfId,targetId)
	if x893042_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	if sceneId ~= x893042_g_AcceptNPCSceneID then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_87}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	local playerX, playerZ = GetWorldPos(sceneId, selfId)
	local distance = floor(sqrt((playerX-x893042_g_AcceptNPCPosition_X)*(playerX-x893042_g_AcceptNPCPosition_X)+(playerZ-x893042_g_AcceptNPCPosition_Z)*(playerZ-x893042_g_AcceptNPCPosition_Z)))
	if distance > 6 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_88}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	-- 检查道具栏
	if LuaFnGetTaskItemBagSpace(sceneId, selfId) < 2 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SHYD_20211227_92}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
			
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_93}")
		EndEvent()
		DispatchEventList( sceneId, selfId, targetId )
		return	
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x893042_g_MissionId, x893042_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SHYD_20211227_94}")
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--给予云家罗盘
	BeginAddItem(sceneId)
		AddItem( sceneId, x893042_g_LuoPanItem, 1 )
	EndAddItem(sceneId,selfId)
	AddItemListToHuman(sceneId,selfId)
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHYD_20211227_466}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--检测接受条件
--**********************************
function x893042_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x893042_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893042_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x893042_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	-- 已经接取了任务
	if IsHaveMission(sceneId,selfId,x893042_g_MissionId) > 0 then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x893042_OnAbandon( sceneId, selfId )
	--删除任务道具
	DelItem( sceneId,selfId, x893042_g_LuoPanItem, 1 )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x893042_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893042_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893042_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	
	return 1
end

--**********************************
--提交
--**********************************
function x893042_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893042_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if sceneId ~= x893042_g_SceneID then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_176}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		if GetName(sceneId,targetId) ~= x893042_g_AccomplishNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_174}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local playerX, playerZ = GetWorldPos(sceneId, selfId)
		local distance = floor(sqrt((playerX-x893042_g_Position_X)*(playerX-x893042_g_Position_X)+(playerZ-x893042_g_Position_Z)*(playerZ-x893042_g_Position_Z)))
		if distance > 6 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SHYD_20211227_177}")
			EndEvent()
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local misIndex = GetMissionIndexByID(sceneId,selfId,x893042_g_MissionId)
		local misOk = GetMissionParam(sceneId,selfId,misIndex,x893042_g_IsMissionOkFail)
		if misOk ~= 1 then
			x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_183}" )
			return 0
		end
		--删除任务道具
		DelItem( sceneId,selfId, x893042_g_LuoPanItem, 1 )
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x893042_g_MoneyJZBonus );
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x893042_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		LuaFnAddExp( sceneId, selfId, x893042_g_ExpBonus)
		DelMission( sceneId, selfId, x893042_g_MissionId )
		MissionCom( sceneId, selfId, x893042_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SHYD_20211227_46}",x893042_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(893043,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893042_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x893042_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893042_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--任务入口函数
--**********************************
function x893042_OnPlayerEnterScene( sceneId, selfId )
	if IsMissionHaveDone(sceneId,selfId,x893042_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x893042_g_MissionId) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHYD_20211227_112}")
		EndEvent()
		DispatchEventList( sceneId, selfId, -1 )
	end
end
--**********************************
--打坐道具检查
--**********************************
function x893042_CanUseItemCheck(sceneId, selfId,targetId)
	-- 等级检测
	if GetLevel(sceneId, selfId) < x893042_g_MissionLevel then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_113}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x893042_g_MissionId) <= 0 then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_117}" )
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x893042_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x893042_g_IsMissionOkFail)
	if misOk ~= 0 then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_126}" )
		return 0
	end
	if x893042_g_SceneID ~= sceneId then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_119}" )
		return 0
	end
	local nMissionParam = -1
	for i = 1,getn(x893042_g_LuoPanPosition) do
		local misAreaX = x893042_g_LuoPanPosition[i].x
		local misAreaZ = x893042_g_LuoPanPosition[i].z
		--取得玩家当前坐标
		local PlayerX = GetHumanWorldX(sceneId,selfId)
		local PlayerY = GetHumanWorldZ(sceneId,selfId)
		--计算玩家与目标点的距离
		local Distance = floor(sqrt((misAreaX-PlayerX)*(misAreaX-PlayerX)+(misAreaZ-PlayerY)*(misAreaZ-PlayerY)))
		if Distance <= 2 then
			nMissionParam = x893042_g_LuoPanPosition[i].param
			break
		end
	end
	if nMissionParam == -1 then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_115}" )
		return 0
	end
	
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_122}" )
		return 0
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_124}" )
		return 0
	end
	
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_106}" )
		return 0
	end
	
	return 1;
end
--**********************************
--打坐完成
--**********************************
function x893042_UseItemFinish(sceneId, selfId,targetId)
	if IsHaveMission(sceneId,selfId,x893042_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x893042_g_MissionId)
	local nMissionParam = -1
	for i = 1,getn(x893042_g_LuoPanPosition) do
		local misAreaX = x893042_g_LuoPanPosition[i].x
		local misAreaZ = x893042_g_LuoPanPosition[i].z
		--取得玩家当前坐标
		local PlayerX = GetHumanWorldX(sceneId,selfId)
		local PlayerY = GetHumanWorldZ(sceneId,selfId)
		--计算玩家与目标点的距离
		local Distance = floor(sqrt((misAreaX-PlayerX)*(misAreaX-PlayerX)+(misAreaZ-PlayerY)*(misAreaZ-PlayerY)))
		if Distance <= 2 then
			nMissionParam = x893042_g_LuoPanPosition[i].param
			break
		end
	end
	if nMissionParam == -1 then
		return
	end
	--标记完成
	SetMissionByIndex(sceneId,selfId,misIndex,nMissionParam,1)	
	
	local nFinishedNum = 0
	for i = 1,getn(x893042_g_LuoPanPosition) do
		if GetMissionParam(sceneId,selfId,misIndex,x893042_g_LuoPanPosition[i].param) >= 1 then
			nFinishedNum = nFinishedNum + 1
		end
	end
	if nFinishedNum >= 3 then
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_465}" )
		x893042_NotifyBox( sceneId, selfId,-1, "#{SHYD_20211227_171}" )
		BroadMsgByChatPipe(sceneId,selfId,"#{SHYD_20211227_449}",0)
		--标记任务已完成
		SetMissionByIndex(sceneId,selfId,misIndex,x893042_g_IsMissionOkFail,1)
	else
		x893042_NotifyTip( sceneId, selfId, "#{SHYD_20211227_136}" )
		BroadMsgByChatPipe(sceneId,selfId,"#{SHYD_20211227_448}",0)
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x893042_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x893042_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
