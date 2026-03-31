--少林云游武僧、和那个灯得lua，做到一起，所以硬性检测怪物名称哦。
--脚本号
x402108_g_ScriptId	= 402108
x402108_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
--**********************************
--入口函数
--**********************************
function x402108_OnDefaultEvent( sceneId,selfId,targetId )
	local szName = GetName(sceneId,targetId)
	local Startblock = LuaFnGetCopySceneData_Param(sceneId,18)
	BeginEvent(sceneId)
		if szName == "少林云游武僧" then
			AddText(sceneId,"#{CJG_090413_17}")
			if Startblock == 0 then
				AddNumText(sceneId,x402108_g_ScriptId,"#{CJG_090413_18}",6,-1)
			else
				AddNumText(sceneId,x402108_g_ScriptId,"#{CJG_090413_19}",9,-1)
			end
		elseif szName == "蓝色佛灯机关" then
			AddText(sceneId,"#{CJG_090413_12}")
			AddNumText(sceneId,x402108_g_ScriptId,"开启机关",0,-1)
		elseif szName == "绿色佛灯机关" then
			AddText(sceneId,"#{CJG_090413_13}")
			AddNumText(sceneId,x402108_g_ScriptId,"开启机关",0,-1)
		elseif szName == "红色佛灯机关" then
			AddText(sceneId,"#{CJG_090413_14}")
			AddNumText(sceneId,x402108_g_ScriptId,"开启机关",0,-1)
		end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x402108_OnEventRequest(sceneId,selfId,targetId)
	local szName = GetName(sceneId,targetId)
	local Startblock = LuaFnGetCopySceneData_Param(sceneId,18)
	local nNumText = GetNumText()
	if szName == "少林云游武僧" then
		if Startblock == 0 then
			LuaFnSetCopySceneData_Param(sceneId,18,1)
			--NPC发送一个对话
			LuaFnNpcChat(sceneId,targetId,0,"#{CJG_090413_20}")
		else
			CallScriptFunction(402107,"KickOut",sceneId,selfId) --离开藏经阁操作
		end
		DispatchUICommand(sceneId,selfId,1000) --关闭对话框
	elseif szName == "蓝色佛灯机关" then
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
				LuaFnSendSpecificImpactToUnit(sceneId,selfId,targetId,mems[i],10511,0)
			end
		end
		--全屏提示
		x402108_NotifyTip(sceneId,"蓝色#{CJG_090413_44}")
		LuaFnDeleteMonster(sceneId,targetId)
		DispatchUICommand(sceneId,selfId,1000) --关闭对话框
		--无论触发哪个机关，场景内给所有得机关灯都清除掉
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 550 and MosDataID <= 552 then
				LuaFnDeleteMonster(sceneId,MonsterId)
			end
		end
	elseif szName == "绿色佛灯机关" then
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 13583 and MosDataID <= 13591 then
				--上定身
				LuaFnSendSpecificImpactToUnit(sceneId,selfId,targetId,MonsterId,10513,0)
			end
		end
		--全屏提示
		x402108_NotifyTip(sceneId,"绿色#{CJG_090413_45}")
		LuaFnDeleteMonster(sceneId,targetId)
		DispatchUICommand(sceneId,selfId,1000) --关闭对话框
		--无论触发哪个机关，场景内给所有得机关灯都清除掉
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 550 and MosDataID <= 552 then
				LuaFnDeleteMonster(sceneId,MonsterId)
			end
		end
	elseif szName == "红色佛灯机关" then
		--给少林云游武僧上BUFF
		local nObjID = LuaFnGetCopySceneData_Param(sceneId,13)
		if nObjID > 0 then
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,targetId,nObjID,10512,0)
		end
		--全屏提示
		x402108_NotifyTip(sceneId,"红色#{CJG_090413_46}")
		LuaFnDeleteMonster(sceneId,targetId)
		DispatchUICommand(sceneId,selfId,1000) --关闭对话框
		--无论触发哪个机关，场景内给所有得机关灯都清除掉
		local nMonsterNum = GetMonsterCount(sceneId)
		for i = 0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID(sceneId,MonsterId)
			if MosDataID >= 550 and MosDataID <= 552 then
				LuaFnDeleteMonster(sceneId,MonsterId)
			end
		end
	end
end
--**********************************
--初始化....
--**********************************
function x402108_OnInit(sceneId, selfId)
	local szName = GetName(sceneId,selfId)
	if szName == "少林云游武僧" then
		MonsterAI_SetBoolParamByIndex(sceneId,selfId,x402108_IDX_CombatFlag,0)
	end
end

--**********************************
--心跳....
--**********************************
function x402108_OnHeartBeat(sceneId, selfId, nTick)
	local szName = GetName(sceneId,selfId)
	if szName == "少林云游武僧" then
		--检测是不是死了....
		if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
			return
		end
		--检测是否不在战斗状态....
		if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x402108_IDX_CombatFlag ) then
			return
		end
		--心跳检测如果一直被打就一直给提示
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		if CurPercent > 0.6 and CurPercent <= 0.9 then
			x402108_NotifyTip(sceneId,"#{CJG_090413_29}")
			return
		end
		if CurPercent > 0.3 and CurPercent <= 0.6 then
			x402108_NotifyTip(sceneId,"#{CJG_090413_30}")
			return
		end
		if CurPercent <= 0.3 then
			x402108_NotifyTip(sceneId,"#{CJG_090413_31}")
			return
		end
		x402108_NotifyTip(sceneId,"#{CJG_090413_28}")
	end
end

--**********************************
--进入战斗....
--**********************************
function x402108_OnEnterCombat(sceneId, selfId, enmeyId)
	local szName = GetName(sceneId,selfId)
	if szName == "少林云游武僧" then
		--设置进入战斗状态....
		MonsterAI_SetBoolParamByIndex(sceneId,selfId,x402108_IDX_CombatFlag,1)
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		if CurPercent > 0.6 and CurPercent <= 0.9 then
			MonsterTalk(sceneId,-1,"藏经阁","#{CJG_090413_40}")
			return
		end
		if CurPercent > 0.3 and CurPercent <= 0.6 then
			MonsterTalk(sceneId,-1,"藏经阁","#{CJG_090413_41}")
			return
		end
		if CurPercent <= 0.3 then
			MonsterTalk(sceneId,-1,"藏经阁","#{CJG_090413_42}")
			return
		end
		MonsterTalk(sceneId,-1,"藏经阁","#{CJG_090413_39}")
	end
end


--**********************************
--离开战斗....
--**********************************
function x402108_OnLeaveCombat(sceneId, selfId)
	local szName = GetName(sceneId,selfId)
	if szName == "少林云游武僧" then
		--设置进入战斗状态....
		MonsterAI_SetBoolParamByIndex(sceneId,selfId,x402108_IDX_CombatFlag,0)
	end
end


--**********************************
--死亡....
--**********************************
function x402108_OnDie( sceneId, selfId, killerId )
	--少林云游武僧都死了，还在这扯蛋呢？
	local szName = GetName(sceneId,selfId)
	if szName == "少林云游武僧" then
		LuaFnSetCopySceneData_Param(sceneId,4,1)
	end
end
--**********************************
--对话框提示
--**********************************
function x402108_NotifyTip(sceneId,Msg)
	local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
	local mems = {}
	for	i=0,membercount-1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		if LuaFnIsObjValid(sceneId,mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId,mems[i]) == 1 and LuaFnIsCharacterLiving(sceneId,mems[i]) == 1 then
			BeginEvent( sceneId )
				AddText( sceneId, Msg )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId,mems[i])
		end
	end
end
