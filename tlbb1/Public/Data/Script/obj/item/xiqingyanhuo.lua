--传讯焰火

--脚本号
x300112_g_scriptId = 300112

x300112_g_event = 210266
--**********************************
--刷新事件
--**********************************
function x300112_OnDefaultEvent( sceneId, selfId, BagIndex )
	CallScriptFunction(x300112_g_event,"OnUseItem",sceneId, selfId, BagIndex)
end

function x300112_IsSkillLikeScript( sceneId, selfId)
	return 0;
end
