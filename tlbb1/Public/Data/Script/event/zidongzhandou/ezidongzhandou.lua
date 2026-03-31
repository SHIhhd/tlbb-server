--**********************************
-- 自动战斗程序脚本
--**********************************
x891330_g_ScriptId	= 891330

-- 限制升级等级
function x891330_AutoLevelUpLimit( sceneId, selfId,  nLevel )
	if nLevel == nil then
		return
	end
	if nLevel ~= 0 then
		nLevel = 1
	end
	print(nLevel)
	SetMissionData(sceneId, selfId, MD_AUTO_LEVELUP_LIMIT, nLevel)
end

--**********************************
--信息提示
--**********************************
function x891330_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
