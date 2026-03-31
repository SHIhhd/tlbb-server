--跨场景传送服务端处理脚本
--主要是程序实现，脚本仅用于NPC传送的合法性检测
--客户端发起到下一个场景的请求
function x889888_ClientQueryTrans( sceneId, selfId, nTransPos )
	local nScoreSceneID,nScorePosX,nScorePosZ,nTargetSceneID,nNeedLevel,nTarPosX,nTarPosZ = LuaFnGetTransportByIndex(nTransPos)
--	print("nScoreSceneID",nScoreSceneID,"sceneId",sceneId)
	--没有数据
	if nScoreSceneID == -1 then
		return
	end
	--不是同一场景，这种都是非法数据
	if nScoreSceneID ~= sceneId and nScoreSceneID < 100000 then
		return
	end
	--取得目前的位置是否足够
	local nCurPosX,nCurPosZ = GetWorldPos(sceneId,selfId)
	if nCurPosX == -1 or nCurPosZ == -1 
		or nScorePosX == -1 or nScorePosZ == -1 then
		return
	end
	local nDistance = floor(sqrt((nCurPosX-nScorePosX)*(nCurPosX-nScorePosX)+(nCurPosZ-nScorePosZ)*(nCurPosZ-nScorePosZ)))
	if nDistance > 6 then
		return
	end
	--等级不对
	if nNeedLevel > GetLevel(sceneId,selfId) then
		print("[debug]nNeedLevel > GetLevel(sceneId,selfId) %d,%d\n",nNeedLevel,GetLevel(sceneId,selfId))
		return
	end
	if nTargetSceneID == -1 or nTarPosX == -1 or nTarPosZ == -1 then
		return
	end
	--不能是当前场景
	if nTargetSceneID == sceneId then
		return
	end
--	print("nTargetSceneID",nTargetSceneID)
	--允许传送
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, nTargetSceneID,nTarPosX,nTarPosZ)
end

