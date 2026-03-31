--MisDescBegin
--脚本号
x808136_g_ScriptId = 808136

--任务NPC
x808136_g_AccomplishNPC_Name="梁道士"
--上一个任务的ID
--g_MissionIdPre =

--任务号
x808136_g_MissionId = 1159

--任务归类
x808136_g_MissionKind = 12

--任务等级
x808136_g_MissionLevel = 10000

--是否是精英任务
x808136_g_IfMissionElite = 0

--任务文本描述
x808136_g_MissionName="#{ZXCM_090602_21}"
x808136_g_MissionTarget="#{ZXCM_090602_33}"

x808136_g_Custom1	= { {id="在无量山安放",num=1} }
x808136_g_Custom2	= { {id="在剑阁安放",num=1} }
x808136_g_Custom3	= { {id="在敦煌安放",num=1} }
x808136_g_Custom4	= { {id="在太湖安放",num=1} }
x808136_g_Custom5	= { {id="在嵩山安放",num=1} }
x808136_g_Custom6	= { {id="在西湖安放",num=1} }
x808136_g_IsMissionOkFail = 1		--变量的第0位
x808136_MissionItem = 40004488
x808136_g_BonusEXP_List = {
0,0,0,0,0,0,0,0,0,0,                                              
0,0,0,0,0,0,0,0,0,0,          
0,0,0,0,0,0,0,0,0,
126150,130300,134474,138564,142784,147029,151297,155479,159795,164133,245746,
252138,258454,264914,271409,277827,284391,290989,297509,304176,310878,
317500,324270,331075,337914,344672,351580,358523,365383,372394,379440,
386403,393517,400666,407731,414948,422200,429367,436688,444043,451433,
458736,466195,473688,481093,488655,496251,503759,511424,519123,526733,
534501,542303,550140,557887,565792,573732,581581,589590,597633,605584,
613696,621842,629895,638110,646360,654515,662834,671187,679574,679574,
679574,679574,679574,679574,679574,679574,679574,679574,679574,679574,
679574,679574,679574,679574,679574,679574,679574,679574,679574,        
}
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x808136_OnDefaultEvent( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x808136_g_MissionId) > 0 then
		local misIndex = GetMissionIndexByID(sceneId, selfId, x808136_g_MissionId)--得到任务在20个任务中的序列号
		local bDone = x808136_CheckSubmit(sceneId,selfId)
		if bDone == 1 then
			x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
			SetMissionByIndex(sceneId,selfId,misIndex,0,2)
			return
		end
		if bDone == 2 then
			x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
			SetMissionByIndex(sceneId,selfId,misIndex,0,2)
			return
		end
		if bDone == 3 then
			BeginEvent(sceneId)
				AddText( sceneId,"#{ZXCM_090602_28}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,x808136_g_MissionName)
			AddText(sceneId,"#{ZXCM_090602_28}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x808136_g_ScriptId,x808136_g_MissionId)
	--满足任务接收条件
	elseif x808136_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x808136_g_MissionName)
			AddText(sceneId,"#{ZXCM_090602_22}")
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x808136_g_ScriptId,x808136_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x808136_OnEnumerate( sceneId, selfId, targetId)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x808136_g_MissionId) > 0 then
	    AddNumText(sceneId, x808136_g_ScriptId, x808136_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x808136_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId, x808136_g_ScriptId, x808136_g_MissionName, 3, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x808136_CheckAccept(sceneId,selfId)
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
function x808136_OnAccept( sceneId, selfId )
	if LuaFnGetTaskItemBagSpace(sceneId,selfId) < 1 then
		x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_23}")
		return
	end
	BeginAddItem(sceneId)
		AddItem( sceneId, x808136_MissionItem, 1 )
	if EndAddItem(sceneId,selfId) <= 0 then
		x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_23}")
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x808136_g_MissionId, x808136_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_09}")
		return
	end
	AddItemListToHuman(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x808136_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808136_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808136_g_IsMissionOkFail+1,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808136_g_IsMissionOkFail+2,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808136_g_IsMissionOkFail+3,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808136_g_IsMissionOkFail+4,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808136_g_IsMissionOkFail+5,0)
end

--**********************************
--放弃
--**********************************
function x808136_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x808136_g_MissionId )
	--删除任务道具
	LuaFnDelAvailableItem(sceneId,selfId,x808136_MissionItem,1)
end

--**********************************
--继续
--**********************************
function x808136_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x808136_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x808136_g_MissionId)--得到任务在20个任务中的序列号
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
function x808136_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x808136_g_MissionId) <= 0 then
		return
	end
	-- 2、过期了
	if x808136_CheckSubmit(sceneId, selfId) == 1 then
		x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
		return
	end
	-- 3、过期了
	if x808136_CheckSubmit(sceneId, selfId) == 2 then
		x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
		return
	end
	-- 4、未完成任务
	if x808136_CheckSubmit(sceneId, selfId) == 3 then
		return
	end
	-- 3、任务过期情况检测，测试阶段暂时不加
	DelMission( sceneId,selfId, x808136_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x808136_g_MissionId)
	local playerlv = GetLevel(sceneId,selfId)
	LuaFnAddExp(sceneId,selfId,x808136_g_BonusEXP_List[playerlv])
	--设置任务当前完成阶段
	SetMissionDataEx(sceneId,selfId,MDEX_ZHONGXIACHUMO,3)
	--删除任务道具
	LuaFnDelAvailableItem(sceneId,selfId,x808136_MissionItem,1)
	x808136_NotifyTips(sceneId,selfId,"#{ZXCM_090602_16}")
	AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}#{ZXCM_090602_29}",GetName(sceneId,selfId)))
end

--**********************************
--杀死怪物或玩家
--**********************************
function x808136_OnKillObject( sceneId, selfId, objdataId ,objId )
end

--**********************************
--进入区域事件
--**********************************
function x808136_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x808136_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x808136_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end