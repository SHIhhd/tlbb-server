--MisDescBegin
x250040_g_ScriptId 							= 250040
x250040_g_MissionId 						= 1165
-- 任务目标 NPC
x250040_g_Name 									= "诸葛孔亮"
--接受任务NPC
x250040_g_AccomplishNPC_Name 					= "桃夭夭"

--任务归类
x250040_g_MissionKind 					= 1
--任务等级
x250040_g_MissionLevel 					= 10000

x250040_g_MissionName 					= "#{QSJS_090602_005}"
x250040_g_MissionInfo 					= "    "														-- 任务描述
x250040_g_MissionTarget 				= "#{QSJS_090508_052}"						-- 任务目标
x250040_g_IsMissionOkFail 			= 0														-- 0 号索引：当前任务是否完成(0未完成；1完成；2失败)
x250040_g_IsReadSanshengshi 		= 1														-- 1 号索引：是否已经阅读三生石
x250040_g_Custom	= { {id="已阅读三生石:",num=1} }
--随机获得的奖励
x250040_g_RandomGift = {30008006,30008007,30008034,30900006,30900007,30008009,30008039}
--缘分证书
x250040_g_YuanFenItem = 
{
	30505249,
	30505249,
	30505249,
	30505250,
	30505250,
	30505250,
	30505251,
	30505251,
	30505251,
	30505252,
	30505252,
	30505252,
	30505253,
	30505253,
	30505253,
	30505243
}
x250040_g_SanShengShi = {40004472,40004473,40004474,40004475,40004476,40004477,40004478,40004479,40004480,40004481,40004482,40004483,40004484,40004485,40004486,40004487}
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x250040_OnDefaultEvent( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x250040_g_MissionId) > 0 and GetName(sceneId,targetId) == x250040_g_Name then
		if x250040_CheckSubmit(sceneId,selfId) == 0 then
			x250040_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_054}")
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_055}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x250040_g_ScriptId,x250040_g_MissionId)
	elseif GetName(sceneId,targetId) == x250040_g_AccomplishNPC_Name and x250040_CheckAccept(sceneId,selfId) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{QSJS_090508_047}")
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x250040_g_ScriptId,x250040_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x250040_OnEnumerate( sceneId, selfId, targetId )
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x250040_g_MissionId) > 0 and GetName(sceneId,targetId) == x250040_g_Name then
		AddNumText(sceneId,x250040_g_ScriptId,x250040_g_MissionName,4,-1)
	--满足任务接收条件
	elseif GetName(sceneId,targetId) == x250040_g_AccomplishNPC_Name and x250040_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x250040_g_ScriptId,x250040_g_MissionName,3,-1)
	end
end

--**********************************
--检测接受条件
--**********************************
function x250040_CheckAccept(sceneId,selfId)
	if GetTeamId(sceneId,selfId) < 0 then
		x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_048}")
		return 0
	end
	if GetTeamSize(sceneId,selfId) ~= GetNearTeamCount(sceneId,selfId) then
		x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_019}")
		return 0
	end
	if GetLevel(sceneId,selfId) < 20 then
		x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_007}")
		return 0
	end
	if GetNearTeamCount( sceneId, selfId) < 2 then
		x250040_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_048}")
		return 0
	end
	if GetNearTeamCount( sceneId, selfId) > 2 then
		x250040_MsgBox(sceneId,selfId,-1,"#{QSJS_090508_048}")
		return 0
	end
	if IsMissionHaveDone(sceneId,selfId,1164) <= 0 then
		return 0
	end
	return 1
end

--**********************************
--接受
--**********************************
function x250040_OnAccept( sceneId, selfId )
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x250040_g_MissionId) > 0 then
		return 
	end
	if x250040_CheckAccept(sceneId,selfId) == 0 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission(sceneId,selfId,x250040_g_MissionId,x250040_g_ScriptId,0,0,0)
	if ret <= 0 then
		x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_009}")
		return
	end
	x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_049}")
	x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_050}")
	x250040_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_051}")
	--删除没有故事的三生石
	LuaFnDelAvailableItem(sceneId,selfId,40004471,1)
	--给队伍中的玩家赋予三生石
	local nearteammembercount = GetNearTeamCount(sceneId,selfId)
	local teamId;
	local DestName = ""
	for i = 0,nearteammembercount - 1 do
		teamId = GetNearTeamMember(sceneId,selfId,i)
		if LuaFnIsObjValid(sceneId,teamId) == 1 and LuaFnIsCanDoScriptLogic(sceneId,teamId) == 1 and LuaFnIsCharacterLiving(sceneId,teamId) == 1 then
			--取有缘人名字
			if selfId ~= teamId then
				DestName = GetName(sceneId,teamId)
			end
		end
	end
	local nRandom = random(72,87)
	if DestName ~= "" then
		local nPos = TryRecieveItem(sceneId,selfId,40004470 + nRandom,1)
		if nPos ~= -1 then
			--写入有缘人姓名
			LuaFnSetItemCreator(sceneId,selfId,nPos,DestName)
			LuaFnRefreshItemInfo(sceneId,selfId,nPos)
		end
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x250040_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x250040_g_IsMissionOkFail,0)
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)
end

--**********************************
--放弃
--**********************************
function x250040_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x250040_g_MissionId )
end

--**********************************
--继续
--**********************************
function x250040_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x250040_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x250040_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x250040_g_IsMissionOkFail)
	if param == 0 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x250040_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x250040_g_MissionId) <= 0 then
		return
	end
	-- 2、完成任务的情况检测
	if x250040_CheckSubmit(sceneId, selfId) <= 0 then
		return
	end
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 2 then
		x250040_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_056}")
		return
	end
	local nRandom = random(1,getn(x250040_g_RandomGift))
	local idx = -1;
	for i = 1,getn(x250040_g_SanShengShi) do
		if LuaFnGetAvailableItemCount(sceneId,selfId,x250040_g_SanShengShi[i]) > 0 then
			idx = i
			break
		end
	end
	--不会出现这个情况，防止别人搞事
	if idx == -1 then
		return
	end
	--随机发放
	BeginAddItem(sceneId)
		AddBindItem(sceneId,x250040_g_RandomGift[nRandom],1)
		AddBindItem(sceneId,x250040_g_YuanFenItem[idx],1)
	if EndAddItem(sceneId,selfId) <= 0 then
		x250040_MsgBox(sceneId,selfId,targetId,"#{QSJS_090508_056}")
		return
	end
	local nBagPos = LuaFnTryRecieveSingleItem(sceneId,selfId,x250040_g_RandomGift[nRandom],1,1)
	local nBagPos_2 = LuaFnTryRecieveSingleItem(sceneId,selfId,x250040_g_YuanFenItem[idx],1,1)
	if nBagPos == -1 or nBagPos_2 == -1 then
		return
	end
	local szTransfer = GetBagItemTransfer(sceneId,selfId,nBagPos_2)
	--删除三生石
	LuaFnDelAvailableItem(sceneId,selfId,x250040_g_SanShengShi[idx],1)
	x250040_NotifyTips(sceneId,selfId,"#{QSJS_090508_059}"..GetItemName(sceneId,x250040_g_RandomGift[nRandom]))
	--发送公告
	AddGlobalCountNews(sceneId,format("#{_INFOUSR%s}#{QSJS_090508_057}#{_INFOMSG%s}#{QSJS_090508_058}",GetName(sceneId,selfId),szTransfer))
	DelMission( sceneId,selfId, x250040_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x250040_g_MissionId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x250040_OnKillObject( sceneId, selfId, objdataId ,objId )

end

--**********************************
--进入区域事件
--**********************************
function x250040_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x250040_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x250040_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

function x250040_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
	AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
