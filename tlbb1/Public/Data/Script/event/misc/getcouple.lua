--夫妻称号脚本

x888906_g_ScriptId	= 888906
--**********************************
--事件交互入口
--**********************************
function x888906_OnDefaultEvent( sceneId, selfId,targetId )

	BeginEvent( sceneId )
		AddText( sceneId, "#{FQCH_20230330_53}" )
		AddNumText( sceneId, x888906_g_ScriptId, "#{FQCH_20230330_13}", 6, 1 )
		AddNumText( sceneId, x888906_g_ScriptId, "#{FQCH_20230330_14}", 6, 2 )
		AddNumText( sceneId, x888906_g_ScriptId, "#{FQCH_20230330_15}", 11, 3 )

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x888906_OnEventRequest( sceneId, selfId, targetId, eventId )
	local op = GetNumText()
	if op == 1 then
		--印刻专属伴侣称号
--		if LuaFnIsMarried(sceneId, selfId) <= 0 then
--			x888906_Tips( sceneId, selfId, "#{FQCH_20230330_17}" )
--			return
--		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId)
			UICommand_AddInt( sceneId, 1 )--领取称号
			UICommand_AddString(sceneId, GetName(sceneId,selfId))
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20230406 )
		return
	end
	if op == 2 then
		--修改专属伴侣称号
--		if LuaFnIsMarried(sceneId, selfId) <= 0 then
--			x888906_Tips( sceneId, selfId, "#{FQCH_20230330_17}" )
--			return
--		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId)
			UICommand_AddInt( sceneId, 2 )--修改称号
			UICommand_AddString(sceneId, GetName(sceneId,selfId))
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20230407 )
		return
	end
	if op == 3 then
		x888906_MsgBox( sceneId, selfId, targetId, "#{FQCH_20230330_16}" )
		return
	end
end
--**********************************
--提示信息
--**********************************
function x888906_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话窗口信息提示
--**********************************
function x888906_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
