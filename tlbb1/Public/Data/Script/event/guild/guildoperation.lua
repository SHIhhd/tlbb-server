--帮会相关UI 30，31,103

x600000_g_ScriptId = 600000;
x600000_g_Yinpiao = 40002000

--**********************************
-- 任务入口函数
--**********************************
function x600000_OnEnumerate( sceneId, selfId, targetId, sel )
	if( sel == 1 ) then
		GuildCreate(sceneId, selfId, targetId);
	elseif( sel == 2 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId) --调用城市入口组界面
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 103)
		--先让客户端记录NPC信息再显示窗口
		CityApply(sceneId, selfId)
		GuildList(sceneId, selfId, targetId);
	elseif( sel == 3 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 30)
	elseif( sel == 4 ) then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 31)
	elseif( sel == 5 )then
		local ret = CheckPlayerCanApplyCity(sceneId, selfId);
		if ret==1 then 
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,targetId) --调用城市入口组界面
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 101)
			--先让客户端记录NPC信息再显示窗口
			CityApply(sceneId, selfId)
		elseif ret==-1 then
			BeginEvent(sceneId)
				AddText(sceneId,"您的帮会已经占有城市了！")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
	elseif( sel == 6 ) then
		--是否在漕运
		local haveImpact = LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113)
		if haveImpact == 1 then
				BeginEvent(sceneId)
					strText = "对不起,您现在处于运输状态。"
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
		end
		-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
		if GetItemCount(sceneId, selfId, x600000_g_Yinpiao)>=1  then
			BeginEvent( sceneId )
				AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		
		CityMoveTo(sceneId, selfId)
	end
	
end
--**********************************
-- 帮会创建程序回调
--**********************************
function x600000_OnPlayerGuildApply( sceneId, selfId )
--	local nExchPoint = floor(BuyYuanBaoCount(sceneId,selfId,-1,3,0)/PRIZE_EXCHANGE_PARAM)
--	if nExchPoint < 1000 then
--		x600000_NotifyFailTips( sceneId, selfId, "少侠当前的贡献似乎不够，需要去兑换满1000元才可以来这里创建帮会。" )
--		return 0
--	end
	return 1
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x600000_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x600000_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end