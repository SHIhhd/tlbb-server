--料理锅NPC

x998706_g_ScriptId	= 998706
x998709_g_aItemConfig = {
	--参翅玉脍宴
	[38003070] = {
		dataId = 51945,
		strName = "#{SFDJ_240117_157}",
		maxEatNum = 30,
		strDesc = "#{SFDJ_240117_16}",
		impactId = 47553,
	},
	--牛羊全炙宴
	[38003071] = {
		dataId = 51948,			
		strName = "#{SFDJ_240117_158}",
		maxEatNum = 30,
		strDesc = "#{SFDJ_240117_162}",
		impactId = 47554,
	},
}

--**********************************
--事件交互入口
--**********************************
function x998706_OnDefaultEvent( sceneId, selfId,targetId )
	local nConfigItem = LuaFnGetNpcIntParameter(sceneId,targetId,1)
	local tConfig = x998709_g_aItemConfig[nConfigItem]
	if tConfig == nil then
		x998706_MsgBox( sceneId, selfId, targetId, "    这里数据发生了错误，请联系客服。" )
		return
	end
	--剩余数量
	local nPreCount = LuaFnGetNpcIntParameter(sceneId,targetId,2)
	
	BeginEvent( sceneId )
--		local nLeftDieTime = GetCharacterDieTime(sceneId,targetId)
--		local nMin = floor((nLeftDieTime / 1000) / 60)
--		local nSec = floor((nLeftDieTime / 1000) - nMin * 60)
		--nMin.."分"..nSec.."秒"
		AddText(sceneId, ScriptGlobal_Format(tConfig.strDesc,tostring(nPreCount)));
		AddText(sceneId, "#{SFDJ_240117_18}");
		AddNumText( sceneId, x998706_g_ScriptId, "#{SFDJ_240117_17}", 6, 1 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x998706_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nConfigItem = LuaFnGetNpcIntParameter(sceneId,targetId,1)
	local tConfig = x998709_g_aItemConfig[nConfigItem]
	if tConfig == nil then
		x998706_MsgBox( sceneId, selfId, targetId, "    这里数据发生了错误，请联系客服。" )
		return
	end
	
	local nGuildId = LuaFnGetNpcIntParameter(sceneId,targetId,3);
	local nMyGuildId = GetHumanGuildID(sceneId,selfId)
	if nMyGuildId == -1 then
		x998706_NotifyTips(sceneId, selfId, "#{SFDJ_240117_36}")
		return
	end
	--SFDJ_240117_37	您不属于该服务器，无法进行此操作。	
	if nMyGuildId == -1 or nMyGuildId ~= nGuildId then
		x998706_NotifyTips(sceneId, selfId, "#{SFDJ_240117_46}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		return
	end
	--检查是否拥有对应效果
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,tConfig.impactId) > 0 then
		x998706_NotifyTips(sceneId, selfId, "#{SFDJ_240117_48}")
		return
	end
	--剩余数量
	local nPreCount = LuaFnGetNpcIntParameter(sceneId,targetId,2)
	if nPreCount <= 0 then
		x998706_NotifyTips(sceneId, selfId, "#{SFDJ_240117_47}")
		return
	end
	--更新剩余数量
	LuaFnSetNpcIntParameter(sceneId,targetId,2,nPreCount - 1)
	--给予效果
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,tConfig.impactId,0)
	--领取提示
	x998706_NotifyTips( sceneId, selfId,"#{SFDJ_240117_49}")
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
function x998706_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x998706_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
