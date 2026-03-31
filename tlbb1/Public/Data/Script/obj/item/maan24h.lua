--300265

--脚本号
x300265_g_scriptId = 300265
x300265_g_ItemId = 30008114
x300265_g_BuffId = 86

--**********************************
--事件交互入口
--**********************************
function x300265_OnDefaultEvent( sceneId, selfId, nBagIndex )
	--1，检测玩家身上是不是有BUFF
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, x300265_g_BuffId) == 1   then
		BeginEvent(sceneId)
			AddText(sceneId,"只有等加速效果消失之后才能使用。")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return 
	end
	
	local nCurCount = GetBagItemParam(sceneId, selfId, nBagIndex, 4, 2)
	SetBagItemParam(sceneId, selfId, nBagIndex, 8, 2, 5)
	-- 安全检测
	if LuaFnGetItemTableIndexByIndex(sceneId, selfId, nBagIndex) ~= x300265_g_ItemId then
		BeginEvent(sceneId)
			AddText(sceneId,"物品不能使用")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	local ret = 1
	if nCurCount >= 4  then
		-- 判断下这个物品的ID是不是正确先
		ret = EraseItem(sceneId, selfId, nBagIndex)
	else
		SetBagItemParam(sceneId, selfId, nBagIndex, 4, 2, nCurCount+1)
	end

	if ret == 1   then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x300265_g_BuffId, 100 )
		BeginEvent(sceneId)
			AddText(sceneId,"你获得了黄金马鞍的加速效果。")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
	else
		BeginEvent(sceneId)
			AddText(sceneId,"物品不能使用。")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
	end
	
	LuaFnRefreshItemInfo(sceneId, selfId, nBagIndex)
	
end

function x300265_IsSkillLikeScript( sceneId, selfId)
	return 0
end
