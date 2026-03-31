--找人任务
--王素商寻找王安歌
--MisDescBegin
--脚本号
x893310_g_ScriptId = 893310

--任务号
x893310_g_MissionId = 2127

--上一个任务的ID
--g_MissionIdPre = 

--目标NPC
x893310_g_Name	="王安歌"

--任务归类
x893310_g_MissionKind = 61

--任务等级
x893310_g_MissionLevel = 10

--是否是精英任务
x893310_g_IfMissionElite = 0

--任务名
x893310_g_MissionName="为师门而战"
x893310_g_MissionInfo="#{event_mantuo_0001}"
x893310_g_MissionTarget="    在曼陀山庄找到王安歌#{_INFOAIM129,106,592,王安歌}。"
x893310_g_MissionComplete="  你是新来的同门吧，你来得太好了，我这里有很多事情需要你帮忙呢。"
x893310_g_MoneyJZBonus=800


--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x893310_OnDefaultEvent( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
    if (IsMissionHaveDone(sceneId,selfId,x893310_g_MissionId) > 0 ) then
    	return
	elseif( IsHaveMission(sceneId,selfId,x893310_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x893310_g_Name then
			x893310_OnContinue( sceneId, selfId, targetId )
		end
    --满足任务接收条件
    elseif x893310_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x893310_g_Name then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x893310_g_MissionName)
				AddText(sceneId,x893310_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x893310_g_MissionTarget)
				--( sceneId, x893310_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x893310_g_ScriptId,x893310_g_MissionId)
		end
    end
end

--**********************************
--列举事件
--**********************************
function x893310_OnEnumerate( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x893310_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x893310_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x893310_g_Name then
			AddNumText(sceneId, x893310_g_ScriptId,x893310_g_MissionName,2,-1);
		end
	--满足任务接收条件
	elseif x893310_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) ~= x893310_g_Name then
			AddNumText(sceneId,x893310_g_ScriptId,x893310_g_MissionName,1,-1);
		end
    end
end

--**********************************
--检测接受条件
--**********************************
function x893310_CheckAccept( sceneId, selfId )
	local  MenPai = GetMenPai( sceneId, selfId)
	if	MenPai ~= 8 then
		return 0
	else
		return 1
	end
end

--**********************************
--接受
--**********************************
function x893310_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x893310_g_MissionId, x893310_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：为师门而战",MSG2PLAYER_PARA )
end

--**********************************
--放弃
--**********************************
function x893310_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x893310_g_MissionId )
end

--**********************************
--继续
--**********************************
function x893310_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x893310_g_MissionName)
		AddText(sceneId,x893310_g_MissionComplete)
		--( sceneId, x893310_g_MoneyBonus )
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x893310_g_ScriptId,x893310_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x893310_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x893310_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x893310_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x893310_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		AddMoney(sceneId,selfId,x893310_g_MoneyBonus );
		LuaFnAddExp( sceneId, selfId, 800)
		ret = DelMission( sceneId, selfId, x893310_g_MissionId )
		if ret > 0 then
			MissionCom( sceneId, selfId, x893310_g_MissionId )
			Msg2Player(  sceneId, selfId,"#Y完成任务：为师门而战",MSG2PLAYER_PARA )
		end
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893310_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x893310_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893310_OnItemChanged( sceneId, selfId, itemdataId )
end
