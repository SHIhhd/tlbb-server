--巧手木甲NPC

x998724_g_ScriptId	= 998724
--**********************************
--事件交互入口
--**********************************
function x998724_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		local nLeftDieTime = GetCharacterDieTime(sceneId,targetId)
		local nMin = floor((nLeftDieTime / 1000) / 60)
		local nSec = floor((nLeftDieTime / 1000) - nMin * 60)
		
		AddText(sceneId, ScriptGlobal_Format("#{SFDJ_240117_120}",nMin.."分"..nSec.."秒"));
		AddNumText( sceneId, x998724_g_ScriptId, "#{SFDJ_240117_121}", 6, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998724_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nGuildId = LuaFnGetNpcIntParameter(sceneId,targetId,1);
	local nMyGuildId = GetHumanGuildID(sceneId,selfId)
	if nMyGuildId == -1 or nMyGuildId ~= nGuildId then
		x998724_NotifyTips(sceneId, selfId, "#{SFDJ_240117_46}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		return
	end
	local nLeftDieTime = GetCharacterDieTime(sceneId,targetId)
	
	local key = GetNumText()
	if key == 1 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, floor(nLeftDieTime / 1000) )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 99872401 )
	end
end
--**********************************
--屏幕中心信息提示
--**********************************
function x998724_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x998724_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
