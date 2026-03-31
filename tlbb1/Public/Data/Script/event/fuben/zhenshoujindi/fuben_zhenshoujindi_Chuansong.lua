--传送界碑
--这个NPC主要是为了快速支援用的
--lanna

--脚本号
x893021_g_ScriptId	= 893021

--副本逻辑脚本号....
x893021_g_FuBenScriptId = 893020

--AI Index....
x893021_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....
--**********************************
--入口函数
--**********************************
function x893021_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#{ZSFB_20220105_139}")
		AddNumText( sceneId, x893021_g_ScriptId, "#{ZSFB_20220105_156}", 6 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x893021_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1  then
		-- 检测当前是不是在相关副本，这里必须要做安全检查，现在现不做
		if GetName(sceneId, targetId) ~= "石碑"  then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_158}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if GetLevel(sceneId,selfId) < 85 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_157}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		--距离检测
		if IsInDist(sceneId,targetId,selfId,6) ~= 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_158}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_159}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		local nCurPos = LuaFnGetCopySceneData_Param(sceneId, 10) ;--当前完成击杀的BOSS数量
		if nCurPos <= 0 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{ZSFB_20220105_160}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			
			BeginEvent( sceneId )
				AddText( sceneId,  "#{ZSFB_20220105_159}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--传送
		if nCurPos == 1 then
			--传送至云卷舒
			SetPos(sceneId, selfId, 178, 123)
		end
		if nCurPos == 2 then
			--传送至逸
			SetPos(sceneId, selfId, 144, 200)
		end
		--最后一级
		if nCurPos >= 3 then
			--传送艾虎
			SetPos(sceneId, selfId, 62, 144)
		end
		return
	end
end

--**********************************
--对话框提示
--**********************************
function x893021_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

