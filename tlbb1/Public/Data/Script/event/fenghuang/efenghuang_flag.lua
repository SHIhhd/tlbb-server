--凤凰古城 战旗

x403005_g_ScriptId	= 403005
--**********************************
--事件交互入口
--**********************************
function x403005_OnDefaultEvent( sceneId, selfId, targetId )
	if sceneId ~= SCENE_PHOENIXPLAIN then
		return
	end
	BeginEvent( sceneId )
	local bHaveWiner,leagueName, guildName1, guildName2, guildName3 = LuaFnGetPhoenixPlainWinerInfo(sceneId)
	if bHaveWiner == 1 then
		if strlen(guildName1)> 1 and strlen(guildName2)> 1 and strlen(guildName3)> 1 then
			AddText( sceneId, format("#{FHZD_090708_89}%s，%s，%s#{FHZD_090825_1}%s",guildName1,guildName2,guildName3,leagueName) )
		elseif strlen(guildName1)> 1 and strlen(guildName2)> 1 then
			AddText( sceneId, format("#{FHZD_090708_89}%s，%s#{FHZD_090825_1}%s",guildName1,guildName2,leagueName) )
		elseif strlen(guildName1)> 1 then
			AddText( sceneId, format("#{FHZD_090708_89}%s#{FHZD_090825_1}%s",guildName1,leagueName) )
		end
	else
		AddText( sceneId, "#{FHZD_090708_89}#{FHZD_090915_17}" )
	end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--屏幕中间信息提示
--**********************************
function x403005_NotifyTip(sceneId,selfId,msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框信息提示
--**********************************
function x403005_MsgBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


