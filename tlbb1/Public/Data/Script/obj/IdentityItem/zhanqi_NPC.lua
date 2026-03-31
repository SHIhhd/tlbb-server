--战旗npc

x998713_g_ScriptId	= 998713
x998713_g_aItemConfig = {
	--青龙令旗
	[38003076] = {
		dataId = 52183,				--待确认
		strTitle = "#{SFDJ_240117_112}",
		impactId = 47568,
	},
	--白虎令旗
	[38003077] = {
		dataId = 52184,				--待确认
		strTitle = "#{SFDJ_240117_113}",
		impactId = 47569,
	},
	--朱雀令旗
	[38003079] = {
		dataId = 52189,				--待确认
		strTitle = "#{SFDJ_240117_114}",
		impactId = 47570,
	},
	--玄武令旗
	[38003080] = {
		dataId = 52190,				--待确认
		strTitle = "#{SFDJ_240117_115}",
		impactId = 47571,
	},
}
x998713_g_MaxScanDist = 10

--**********************************
--事件交互入口
--**********************************
function x998713_OnDefaultEvent( sceneId, selfId,targetId )

end

--**********************************
--事件列表选中一项
--**********************************
function x998713_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--Monster Timer
--**********************************
function x998713_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nConfigItem = LuaFnGetNpcIntParameter(sceneId,objId,1)
	local tConfig = x998713_g_aItemConfig[nConfigItem]
	if tConfig == nil then
		return
	end
	local nTeamId = LuaFnGetNpcIntParameter(sceneId,objId,2)
	if nTeamId == -1 then
		return
	end
	--遍历周边小队成员
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount <= 0 then
		return
	end
	for i = 0,nHumanCount - 1 do
		local nHumanID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,nHumanID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanID) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanID) == 1 then
			if IsInDist(sceneId,objId,nHumanID,x998713_g_MaxScanDist) == 1 then
				local nHumanTeamId = GetTeamId(sceneId,nHumanID)
				if nHumanTeamId ~= -1 and nHumanTeamId == nTeamId then
					LuaFnSendSpecificImpactToUnit(sceneId, objId, objId, nHumanID, tConfig.impactId, 0);
				end
			end
		end
	end
end

--**********************************
--屏幕中心信息提示
--**********************************
function x998713_NotifyTips(sceneId, selfId, tipText)
	BeginEvent(sceneId);
		AddText(sceneId, tipText);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
--**********************************
--对话窗口信息提示
--**********************************
function x998713_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
