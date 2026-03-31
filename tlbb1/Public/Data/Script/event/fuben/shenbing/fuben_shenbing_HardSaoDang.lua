--往日梦境副本

--脚本号
x998487_g_ScriptId = 998487

--**********************************
-- 获取本副本的MonsterID
--**********************************
function x998487_GetFubenMonsterDataId(sceneId,selfId,nIndex)
	if nIndex == 1 then
		return 51244,0
	elseif nIndex == 2 then
		return 51250,0
	elseif nIndex == 3 then
		return 51256,0
	elseif nIndex == 4 then
		return 51262,1
	end
end
