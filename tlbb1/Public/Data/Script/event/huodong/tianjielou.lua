--MisDescBegin
--脚本号
x808138_g_ScriptId = 808138

--完成任务NPC属性
x808138_g_AccomplishNPC_Name="付劫生"
x808138_g_Position_X=50
x808138_g_Position_Z=175
x808138_g_SceneID=2

--任务号
x808138_g_MissionId = 1169

--目标NPC
x808138_g_Name	="付劫生"

--任务归类
x808138_g_MissionKind = 13

-- 每天最多领取次数
x808138_g_TakeTimes = 10 

--任务等级
x808138_g_MissionLevel = 10000

--是否是精英任务
x808138_g_IfMissionElite = 0
--任务文本描述
x808138_g_MissionName="#{GZRW_XML_9}"
x808138_g_MissionTarget="#{TJL_090714_04}"
x808138_g_MissionInfo="#{TJL_090714_03}"
x808138_g_ContinueInfo="#{TJL_090714_05}"	--未完成任务的npc对话
x808138_g_MissionRound = "#{TJL_xml_XX(05)}"
x808138_g_DemandTrueKill = {{name = "天劫楼恶人",num = 20}}
x808138_g_IsMissionOkFail = 1		--变量的第0位

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x808138_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
    local nRound = GetMissionData(sceneId,selfId,MD_ROUNDMISSION_CHUE_DAYHUAN)
    if nRound < 10 then 
		--如果已接此任务
		if IsHaveMission(sceneId,selfId,x808138_g_MissionId) > 0 then
		--发送任务需求的信息
			BeginEvent(sceneId)
				AddText(sceneId,x808138_g_MissionName)
				AddText(sceneId,x808138_g_ContinueInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x808138_g_MissionTarget)
			EndEvent()
			bDone = x808138_CheckSubmit( sceneId, selfId )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x808138_g_ScriptId ,x808138_g_MissionId,bDone)
        --满足任务接收条件
        elseif x808138_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x808138_g_MissionName)
				AddText(sceneId,x808138_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x808138_g_MissionTarget)
				AddText(sceneId,x808138_g_MissionRound.."#G"..(nRound + 1))
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x808138_g_ScriptId ,x808138_g_MissionId)
        end
    elseif nRound >= 10 then
        BeginEvent(sceneId)
			AddText(sceneId,x808138_g_MissionName)
			AddText(sceneId,"#{TJL_090714_02}")
        EndEvent(sceneId )
		DispatchEventList(sceneId,selfId,targetId)
    end
end

--**********************************
--列举事件
--**********************************
function x808138_OnEnumerate( sceneId, selfId, targetId )
    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x808138_g_MissionId) > 0 then
		AddNumText(sceneId,x808138_g_ScriptId ,x808138_g_MissionName,4,-1);
		--满足任务接收条件
	elseif x808138_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x808138_g_ScriptId ,x808138_g_MissionName,3,-1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x808138_CheckAccept( sceneId, selfId )
	if GetLevel( sceneId, selfId ) >= 30 then
		return 1
	else
		return 0
	end

end

--**********************************
--接受
--**********************************
function x808138_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x808138_g_MissionId, x808138_g_ScriptId , 1, 0, 0 )		--添加任务
	local misIndex = GetMissionIndexByID(sceneId,selfId,x808138_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
end

--**********************************
--放弃
--**********************************
function x808138_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x808138_g_MissionId )
end

--**********************************
--继续
--**********************************
function x808138_OnContinue( sceneId, selfId, targetId )
    if x808138_CheckSubmit( sceneId, selfId) > 0 then
		local nWanLingShi = {20309018,20309019,20309020,20309021,20309022,20309023,20309024} --做满十环额外奖励。
		local nWanLingShiNum = {6,10,10,10,10,10,10} --做满十环额外奖励数量。
        local nRound = GetMissionData(sceneId,selfId,MD_ROUNDMISSION_CHUE_DAYHUAN)
		local nLevel = GetLevel( sceneId, selfId)
		local iniLevel = floor(nLevel / 10) - 2  --30级才能刷呢。
		local ExpJiangLi = 0
		if nLevel >= 30 and nLevel <= 39 then
			local nExpStart = 700
			local nMoneyStart = 4000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=40 and nLevel<=49 then
			local nExpStart = 900
			local nMoneyStart = 5000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=50 and nLevel<=59 then
			local nExpStart = 3000
			local nMoneyStart = 6000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=60 and nLevel<=69 then
			local nExpStart = 3500
			local nMoneyStart = 7000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=70 and nLevel<=79 then
			local nExpStart = 6900
			local nMoneyStart = 8000
			local nAdd_Level = 6000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=80 and nLevel<=89 then
			local nExpStart = 9900
			local nMoneyStart = 9000
			local nAdd_Level = 7000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=90 and nLevel<=99 then
			local nExpStart = 11200
			local nMoneyStart = 9000
			local nAdd_Level = 8000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=100 and nLevel<=109 then
			local nExpStart = 25000
			local nMoneyStart = 10000
			local nAdd_Level = 9000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		elseif nLevel>=110 and nLevel<=119 then
			local nExpStart = 30000
			local nMoneyStart = 20000
			local nAdd_Level = 10000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
		end
		if nRound + 1 == 10 then --最后一环之奖励
			if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 1 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{TJL_090731_03}1#{TJL_090731_04}");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			BeginAddItem(sceneId)
				AddItem(sceneId,nWanLingShi[iniLevel],nWanLingShiNum[iniLevel])
			if EndAddItem(sceneId,selfId) <= 0 then
				BeginEvent(sceneId)
					AddText(sceneId,"#{TJL_090731_03}1#{TJL_090731_04}");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			for i = 1,nWanLingShiNum[iniLevel] do
				TryRecieveItem( sceneId, selfId, nWanLingShi[iniLevel],1)
			end
			BeginEvent(sceneId)
				AddText(sceneId,"#{TJL_090814_03}"..ExpJiangLi.."#{TJL_090814_04}"..nWanLingShiNum[iniLevel].."#{TJL_090814_05}"..GetItemName(sceneId,nWanLingShi[iniLevel]))
			EndEvent()
			DispatchEventList(sceneId, selfId,targetId)
			else
			BeginEvent(sceneId)
				AddText(sceneId,"#{TJL_090814_01}"..ExpJiangLi.."#{TJL_090814_02}")
				AddNumText(sceneId,x808138_g_ScriptId ,"#{TJL_xml_XX(04)}",4,-1) --继续下一环
			EndEvent()
			DispatchEventList(sceneId, selfId,targetId)
		end
		LuaFnAddExp( sceneId, selfId,ExpJiangLi)
		local ret = DelMission( sceneId, selfId, x808138_g_MissionId )
		if ret > 0 then
			MissionCom(sceneId,selfId,x808138_g_MissionId )
			SetMissionData(sceneId,selfId,MD_ROUNDMISSION_CHUE_DAYHUAN,nRound + 1)
		end
    end
end

--**********************************
--检测是否可以提交
--**********************************
function x808138_CheckSubmit( sceneId, selfId )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x808138_g_MissionId)
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
    local num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x808138_g_DemandTrueKill[1].num and param == 1 then
		return 1
	end
	return 0
end

--**********************************
--提交
--**********************************
function x808138_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x808138_OnKillObject( sceneId, selfId, objdataId ,objId)
	if GetName(sceneId,objId) == x808138_g_DemandTrueKill[1].name then
		-- 看有没有这个任务
		if IsHaveMission(sceneId, selfId, x808138_g_MissionId) > 0 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x808138_g_MissionId)
			local nKillNum = GetMissionParam(sceneId,selfId,misIndex,1)
			if nKillNum < x808138_g_DemandTrueKill[1].num then
				if nKillNum == x808138_g_DemandTrueKill[1].num - 1 then
					SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				end
				SetMissionByIndex(sceneId,selfId,misIndex,1,nKillNum+1)
				BeginEvent(sceneId)
					strText = "#{TJL_090714_10} "..GetMissionParam(sceneId,selfId,misIndex,1).."/"..x808138_g_DemandTrueKill[1].num
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x808138_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x808138_OnItemChanged( sceneId, selfId, itemdataId )
end
