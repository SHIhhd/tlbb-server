--白银马鞍
--脚本号
x998266_g_scriptId = 998266
x998266_g_ItemId = 30008115
x998266_g_BuffId = 90
x998266_g_Mutex = 336

--**********************************
--事件交互入口
--**********************************
function x998266_OnDefaultEvent( sceneId, selfId, nBagIndex )
	--1，检测玩家身上是不是有BUFF
	if LuaFnHaveImpactOfSpecificMutexID(sceneId, selfId, x998266_g_Mutex) == 1   then
		BeginEvent(sceneId)
			AddText(sceneId,"#{HJMAYH_230228_17}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 
	end
	-- 安全检测
	if LuaFnGetItemTableIndexByIndex(sceneId, selfId, nBagIndex) ~= x998266_g_ItemId then
		BeginEvent(sceneId)
			AddText(sceneId,"物品不能使用")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	if LuaFnDelAvailableItem(sceneId,selfId,x998266_g_ItemId , 1) == 1 then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x998266_g_BuffId, 100 )
		BeginEvent(sceneId)
			AddText(sceneId,"#{HJMAYH_230228_18}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
	else
		BeginEvent(sceneId)
			AddText(sceneId,"物品不能使用。")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

function x998266_IsSkillLikeScript( sceneId, selfId)
	return 0
end
