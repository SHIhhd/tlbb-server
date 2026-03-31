--云深深

--脚本号
x001096_g_ScriptId = 001096

--**********************************
--事件列表
--**********************************
function x001096_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SHXT_20211230_237}")
		AddNumText(sceneId,x001096_g_ScriptId,"#{SHXT_20211230_246}",6,1)
		AddNumText(sceneId,x001096_g_ScriptId,"#{SHXT_20211230_53}",6,2)	
		AddNumText(sceneId,x001096_g_ScriptId,"#{SHXT_20211230_52}",6,3)	
		AddNumText(sceneId,x001096_g_ScriptId,"#{SHXT_20211230_54}",6,4)	
		--穷奇兽魂
		AddNumText(sceneId,x001096_g_ScriptId,"#{QQJG_20230815_1}",6,6)	
		AddNumText(sceneId,x001096_g_ScriptId,"#{QQJG_20230815_2}",6,7)	
		
		AddNumText(sceneId,x001096_g_ScriptId,"#{SHXT_20211230_55}",11,5)	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001096_OnDefaultEvent( sceneId, selfId,targetId )
	x001096_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001096_OnEventRequest( sceneId, selfId, targetId, eventId )
	--GetNumText()
	if GetNumText() == 1 then
		if sceneId ~= SCENE_SUZHOU then
			x001096_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001096_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012801 )
		return
	end
	
	if GetNumText() == 2 then
		if sceneId ~= SCENE_SUZHOU then
			x001096_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001096_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012705 )
		return
	end
	if GetNumText() == 3 then
		if sceneId ~= SCENE_SUZHOU then
			x001096_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001096_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012704 )
		return
	end
	if GetNumText() == 4 then
		if sceneId ~= SCENE_SUZHOU then
			x001096_NotifyTip( sceneId, selfId, "#{ZSPVP_211231_28}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001096_NotifyBox( sceneId, selfId,targetId, "#{SHXT_20211230_189}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 1 )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 80012706 )
		return
	end
	--介绍信息
	if GetNumText() == 5 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_238}",11,100)	
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_150}",11,101)	
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_217}",8,300)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--穷奇融魂技能吞噬
	if GetNumText() == 6 then
		if sceneId ~= SCENE_SUZHOU then
			x001096_NotifyTip( sceneId, selfId, "#{QQJG_20230815_17}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001096_NotifyTip( sceneId, selfId, "#{QQJG_20230815_15}" )
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x001096_NotifyTip( sceneId, selfId, "#{QQJG_20230815_18}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99852201 )
		return
	end
	--穷奇融魂技能还原
	if GetNumText() == 7 then
		if sceneId ~= SCENE_SUZHOU then
			x001096_NotifyTip( sceneId, selfId, "#{QQJG_20230815_17}" )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			x001096_NotifyTip( sceneId, selfId, "#{QQJG_20230815_15}" )
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x001096_NotifyTip( sceneId, selfId, "#{QQJG_20230815_18}" )
			return
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99852203 )
		return
	end
	--********************************************************************
	--介绍详情
	--********************************************************************
	if GetNumText() == 100 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_239}")
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if GetNumText() == 101 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SHXT_20211230_158}")
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_217}",8,301)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetNumText() == 300 then
		x001096_UpdateEventList( sceneId, selfId,targetId )
		return
	end
	if GetNumText() == 301 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_238}",11,100)	
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_150}",11,101)	
			AddNumText(sceneId,x001085_g_ScriptId,"#{SHXT_20211230_217}",8,300)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end
--**********************************
--醒目提示
--**********************************
function x001096_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话提示
--**********************************
function x001096_NotifyBox( sceneId, selfId,targetId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchEventList(sceneId,selfId,targetId)
end