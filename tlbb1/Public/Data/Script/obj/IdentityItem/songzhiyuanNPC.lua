--军资令NPC

x998710_g_ScriptId	= 998710
x998709_g_aItemConfig = {
	--仓吏令·土灵珠
	[38003063] = {
		strDesc = "#{SFDJ_240117_31}",
		strGetBtn = "#{SFDJ_240117_32}",
		prizeItem = 30505288
	},
	--仓吏令·润物露
	[38003085] = {
		strDesc = "#{SFDJ_240117_141}",
		strGetBtn = "#{SFDJ_240117_142}",
		prizeItem = 31000102
	},
}

--**********************************
--事件交互入口
--**********************************
function x998710_OnDefaultEvent( sceneId, selfId,targetId )
	local nConfigItem = LuaFnGetNpcIntParameter(sceneId,targetId,1)
	local tConfig = x998709_g_aItemConfig[nConfigItem]
	if tConfig == nil then
		x998710_MsgBox( sceneId, selfId, targetId, "    老夫这里数据发生了错误，请联系客服。" )
		return
	end
	--剩余数量
	local nPreCount = LuaFnGetNpcIntParameter(sceneId,targetId,2)
	
	BeginEvent( sceneId )
		local nLeftDieTime = GetCharacterDieTime(sceneId,targetId)
		local nMin = floor((nLeftDieTime / 1000) / 60)
		local nSec = floor((nLeftDieTime / 1000) - nMin * 60)
		
		AddText(sceneId, ScriptGlobal_Format(tConfig.strDesc,tostring(nPreCount),nMin.."分"..nSec.."秒"));
		AddNumText( sceneId, x998710_g_ScriptId, tConfig.strGetBtn, 6, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998710_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nConfigItem = LuaFnGetNpcIntParameter(sceneId,targetId,1)
	local tConfig = x998709_g_aItemConfig[nConfigItem]
	if tConfig == nil then
		x998710_MsgBox( sceneId, selfId, targetId, "    老夫这里数据发生了错误，请联系客服。" )
		return
	end
	
	local nGuildId = LuaFnGetNpcIntParameter(sceneId,targetId,3);
	local nMyGuildId = GetHumanGuildID(sceneId,selfId)
	if nMyGuildId == -1 then
		x998710_NotifyTips(sceneId, selfId, "#{SFDJ_240117_36}")
		return
	end
	--SFDJ_240117_37	您不属于该服务器，无法进行此操作。	
	if nMyGuildId == -1 or nMyGuildId ~= nGuildId then
		x998710_NotifyTips(sceneId, selfId, "#{SFDJ_240117_38}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		return
	end
	--检查是否拥有对应物资
	if LuaFnGetAvailableItemCount(sceneId,selfId,tConfig.prizeItem) > 0 then
		x998710_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SFDJ_240117_39}",GetItemName(sceneId,tConfig.prizeItem)))
		return
	end
	--剩余数量
	local nPreCount = LuaFnGetNpcIntParameter(sceneId,targetId,2)
	if nPreCount <= 0 then
		x998710_NotifyTips(sceneId, selfId, "#{SFDJ_240117_40}")
		return
	end
	--检查背包容量
	if LuaFnGetPropertyBagSpace( sceneId, selfId) < 1  then
		x998710_NotifyTips( sceneId, selfId,"#{SFDJ_240117_41}" )
		return 		 
	end
	--更新剩余数量
	LuaFnSetNpcIntParameter(sceneId,targetId,2,nPreCount - 1)
	--给予对应战备物资
	LuaFnTryRecieveSingleItem(sceneId,selfId,tConfig.prizeItem,1,1)
	--领取提示
	x998710_NotifyTips( sceneId, selfId,ScriptGlobal_Format("#{SFDJ_240117_42}",GetItemName(sceneId,tConfig.prizeItem) ))
	--发送帮会通报
	local sMessage = ScriptGlobal_Format("#{SFDJ_240117_43}", 
		GetName(sceneId,selfId),
		LuaFnGetNpcStrParameter(sceneId,targetId,0),
		GetItemName(sceneId,tConfig.prizeItem)
		);	
	BroadMsgByChatPipe(sceneId, selfId, sMessage, 6);
	--impact提示
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,149,0)
	--关闭对话框
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 1000 )
end
--**********************************
--屏幕中心信息提示
--**********************************
function x998710_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x998710_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
