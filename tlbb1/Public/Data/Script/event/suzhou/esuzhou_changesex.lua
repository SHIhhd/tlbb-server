--转性丹NPC 

--脚本号
x250557_g_scriptId = 250557


--所拥有的事件ID列表
x250557_g_eventList={0147000, 0147001, 0147002, 0147003, 0147004, 0147005, 0147006}
x250557_g_item_zhuanxingdan = 30900048


x250557_g_result_msg = {
	"#{ZXD_20080312_03}", --"您已成婚无法更改性别，请解除婚姻关系后再使用该物品"
	"#{ZXD_20080318_01}", --"距离太远，转性丹使用失败"
	"#{ZXD_20120406_06}", --"您的背包内没有转性丹或已被加锁。",
	"#{ZXD_20120406_03}", --"改变性别需要一个人进行，请离开队伍或团队后再使用此功能。",
	"#{ZXD_20120406_05}", --"摆摊状态不能进行此操作，请您收摊后再使用此功能。",
	"#{ZXD_20120406_04}"  --"改变性别的时候不能骑乘坐骑，请下坐骑后再使用此功能。"
}

--**********************************
--事件列表
--**********************************
function x250557_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{ZXD_20080312_01}" )
		AddNumText( sceneId, x250557_g_scriptId, "#{ZXD_20080318_06}", 6, 0147000)
		AddNumText( sceneId, x250557_g_scriptId, "#{ZXD_20120406_11}", 11, 0147001)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x250557_OnDefaultEvent( sceneId, selfId,targetId )
	x250557_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
-- 事件处理
--**********************************
function x250557_OnEventRequest( sceneId, selfId, targetId, eventId )
	local request_id = GetNumText()
--	print("function x250557_OnEventRequest")
	if request_id == 0147000 then
		local isMarried = LuaFnIsMarried(sceneId, selfId)
		if isMarried > 0 then
			BeginEvent(sceneId)
				AddText( sceneId, "#{ZXD_20080312_03}" )		
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		--通知客户端开始转性选择
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20120406)
		
	elseif request_id == 0147003 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 0147005)
		
	elseif request_id == 0147004 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 0147006) --关闭NPC对话框
		
	elseif request_id == 0147001 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{ZXD_20120406_08}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
--**********************************
-- 客户端调用函数
--**********************************
function x250557_ChangeSexSure( sceneId, selfId, targetId)
--	print("x250557_OnZhuanXingConfirm")
	local pre_condition = x250557_PreZhuanXingCondition( sceneId, selfId, targetId )
	if pre_condition == 0 then
		local nCurSex = LuaFnGetSex(sceneId,selfId)
		if nCurSex == 1 then
			nCurSex = 0
		else	
			nCurSex = 1
		end
		local is_suc = HumanZhuanXing(sceneId, selfId, nCurSex)
		if is_suc == 1 then
			LuaFnDelAvailableItem(sceneId, selfId, x250557_g_item_zhuanxingdan, 1)
			BeginEvent(sceneId)
				AddText(sceneId, "#{ZXD_20120406_07}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)

--			变性同时加一个升级特效
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 100 )
			return
		end
	elseif( pre_condition >= 1 and pre_condition <= 6 ) then
		BeginEvent(sceneId)
			AddText(sceneId, x250557_g_result_msg[pre_condition])
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end


--**********************************
-- 是否满足转性条件
--**********************************
function x250557_PreZhuanXingCondition( sceneId, selfId, targetId )
	
	--已经结婚
	local isMarried = LuaFnIsMarried(sceneId, selfId)
	if isMarried == 1 then
		return 1
	end
	
	--距离太远
--	local isValidDistance = IsInDist( sceneId, selfId, targetId, 10)
--	if isValidDistance <= 0 then
--		return 2
--	end
	
	--没有合法物品
	local itemCount = LuaFnGetAvailableItemCount(sceneId, selfId, x250557_g_item_zhuanxingdan)
	if itemCount <= 0 then
		return 3
	end
	
	--是否组队
	if LuaFnHasTeam(sceneId, selfId) > 0 then
		return 4
	end
	
	--是否组团
	if LuaFnHasRaid(sceneId, selfId) > 0 then
		return 4
	end
	
	--是否摆摊
	local isStall = LuaFnIsStalling(sceneId, selfId)
	if isStall > 0 then
		return 5
	end

	--是否骑乘
	local isRiding = LuaFnIsRiding(sceneId, selfId)
	if isRiding > 0 then
		return 6
	end
	
	--可以转性
	return 0
end
