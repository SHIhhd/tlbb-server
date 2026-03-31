--凤凰古城 传送组件

x403003_g_ScriptId	= 403003
--**********************************
--请求进入凤凰古城
--**********************************
function x403003_GoToPhoenixPlain(sceneId,selfId,targetId)
	--条件检测不通过
	if x403003_CheckGoToPhoenixPlain(sceneId,selfId,targetId) ~= 1 then
		return
	end
	--准许进入凤凰古城，后面的交给管理器
	CallScriptFunction(PHOENIXPLAIN_CONTROL_SCRIPT_ID, "GoToPhoenixPlain",sceneId, selfId, targetId)
end
--**********************************
--传送回凤凰古城入口
--**********************************
function x403003_GoToShuHe(sceneId,selfId,targetId)
	NewWorld(sceneId,selfId,420,150,149)
end
--**********************************
--检查是否可以进入凤凰古城
--**********************************
function x403003_CheckGoToPhoenixPlain(sceneId,selfId,targetId)
	local bIsInActivityTime = CallScriptFunction(PHOENIXPLAIN_CONTROL_SCRIPT_ID, "IsInActivityTime",sceneId)
	--城战阶段判断
	if bIsInActivityTime == 1 then
		local guildid = GetHumanGuildID(sceneId,selfId)
		if guildid == -1 then
			x403003_MsgBox(sceneId,selfId,targetId,"#{FHZD_090708_38}")
			return 0
		end
		local guildlevel = GetGuildLevel(sceneId,selfId)
		if guildlevel < 3 then
			x403003_MsgBox(sceneId,selfId,targetId,"#{FHZD_090708_39}")
			return 0
		end
		if GetLevel(sceneId,selfId) < 75 or x403003_CheckXinFaLevel(sceneId,selfId,45) == 0 then
			x403003_MsgBox(sceneId,selfId,targetId,"#{FHZD_090708_40}")
			return
		end
--		if nTime < 2000 or nTime > 2030 then
--			x403003_MsgBox(sceneId,selfId,targetId,"#{FHZD_090708_41}")
--			return 0
--		end
		--对不起，您的帮会正处于低维护状态，不能参加城战
		local idCity = CityGetSelfCityID( sceneId, selfId )
		if CityGetMaintainStatus(sceneId, selfId, idCity) == 1  then
			x403003_NotifyTip(sceneId,selfId,"#{FHZD_090708_57}")
			return 0
		end
		if LuaFnGetDRideFlag(sceneId,selfId) ~= 0  then
			x403003_NotifyTip(sceneId,selfId,"#{FHZD_090708_51}")
			return 0
		end
	else
		--非城战期间的检测
		if GetLevel(sceneId,selfId) < 30 then
			x403003_MsgBox(sceneId,selfId,targetId,"#{FHZD_090708_56}")
			return 0
		end
	end
	return 1
end
--**********************************
--玩家心法检测
--**********************************
function x403003_CheckXinFaLevel(sceneId,selfId,level)
	local nMenpai = GetMenPai(sceneId,selfId)
	if nMenpai < 0 or nMenpai > 8 then
		return 0
	end
	
	for i = 1,6 do
		local nXinfaLevel = LuaFnGetXinFaLevel(sceneId,selfId,nMenpai * 6 + i)
		if nXinfaLevel < level then
			return 0
		end
	end
	return 1
end
--**********************************
--屏幕中间信息提示
--**********************************
function x403003_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403003_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


