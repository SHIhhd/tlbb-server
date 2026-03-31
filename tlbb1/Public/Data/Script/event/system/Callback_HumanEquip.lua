--装备变动回调
x888892_g_scriptId = 888892

--**********************************
--装备完成穿戴前回调 0放行,其他值拦截
--**********************************
function x888892_OnUesEquipCallback(sceneId,selfId,nEquipPointn,BagPos)
	return 0;
end

--**********************************
--装备完成穿戴后回调
--**********************************
function x888892_OnEquipUseFinishCallback(sceneId,selfId,nEquipPointn,BagPos)

	CallScriptFunction(866010, "StartComputeHumanData", sceneId,selfId,1);
end


--**********************************
--装备卸下 0放行,其他值拦截
--**********************************
function x888892_UnEquipCallback(sceneId,selfId,nEquipPoint,nBagPos)
	return 0;
end

--**********************************
-- 装备完成摘除后回调
-- nEquipPoint:发生脱下的装备点
-- nBagPos:装备回到的背包位置
--**********************************
function x888892_OnEquipUnFinishCallback(sceneId,selfId,nEquipPoint,nBagPos)
	
	CallScriptFunction(866010, "StartComputeHumanData", sceneId,selfId,1);
end

--**********************************
-- 屏幕中间提示
--**********************************
function x888892_Tips(sceneId,selfId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end