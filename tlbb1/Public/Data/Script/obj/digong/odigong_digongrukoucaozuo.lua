-- 地宫入口操作

-- 脚本号
x893379_g_ScriptId = 893379
--可进入的最低等级
x893379_g_MinLevel = 60
--进入的索引数据
x893379_g_EnterData = {
	--一层位置
	[1] = {
		sceneId = 1286,
		posx = 31,
		posz = 82,
	},
	[2] = {
		sceneId = 1286,
		posx = 35,
		posz = 221,
	},
	[3] = {
		sceneId = 1286,
		posx = 195,
		posz = 28,
	},
	[4] = {
		sceneId = 1286,
		posx = 226,
		posz = 236,
	},
	--二层位置
	[5] = {
		sceneId = 1287,
		posx = 64,
		posz = 50,
	},
	[6] = {
		sceneId = 1287,
		posx = 31,
		posz = 215,
	},
	[7] = {
		sceneId = 1287,
		posx = 226,
		posz = 77,
	},
	[8] = {
		sceneId = 1287,
		posx = 197,
		posz = 225,
	},
	--三层位置
	[9] = {
		sceneId = 1288,
		posx = 36,
		posz = 62,
	},
	[10] = {
		sceneId = 1288,
		posx = 44,
		posz = 214,
	},
	[11] = {
		sceneId = 1288,
		posx = 219,
		posz = 68,
	},
	[12] = {
		sceneId = 1288,
		posx = 183,
		posz = 214,
	},
	--四层位置
	[13] = {
		sceneId = SCENE_ID_DIGONG_4HD,
		posx = 43,
		posz = 41,
	},
	[14] = {
		sceneId = SCENE_ID_DIGONG_4HD,
		posx = 80,
		posz = 203,
	},
	[15] = {
		sceneId = SCENE_ID_DIGONG_4HD,
		posx = 215,
		posz = 86,
	},
	[16] = {
		sceneId = SCENE_ID_DIGONG_4HD,
		posx = 208,
		posz = 168,
	},
	[17] = {
		sceneId = SCENE_ID_DIGONG_4HD,
		posx = 88,
		posz = 128,
	},
}
--**********************************
--任务入口函数
--**********************************
function x893379_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	if x893379_IsTransNPC( sceneId, selfId, targetId ) == 1 then
		if GetNumText() == 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_248}" )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_145}" ,9,11 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_146}" ,9,12 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_147}" ,9,13 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_148}" ,9,14 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		elseif GetNumText() == 2 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_248}" )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_149}" ,9,21 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_150}" ,9,22 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_151}" ,9,23 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_152}" ,9,24 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		elseif GetNumText() == 3 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_248}" )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_153}" ,9,31 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_154}" ,9,32 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_155}" ,9,33 )
				AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_156}" ,9,34 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		elseif GetNumText() == 4 then
			if x893379_IsCityTransNPC( sceneId, selfId, targetId ) == 1 then
				BeginEvent( sceneId )
					AddText( sceneId, "#{MJXZ_210510_246}" )
					AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_47}" ,9,41 )
					AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_48}" ,9,42 )
					AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_49}" ,9,43 )
					AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_50}" ,9,44 )
					AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_51}" ,9,45 )
				EndEvent( sceneId )
				DispatchEventList( sceneId, selfId, targetId )
			end
			return
		elseif GetNumText() == 5 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{MJXZ_210510_53}" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		elseif GetNumText() == 6 then
			if x893379_IsTransDiGongNPC( sceneId, selfId, targetId ) == 1 then
				CallScriptFunction( 893391, "TransPlayerObjToHome", sceneId ,selfId)
			end
			return
		--一层位置
		elseif GetNumText() == 11 then	--西北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[1].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[1].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[1].posz)
				UICommand_AddInt(sceneId,1)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 12 then	--西南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[2].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[2].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[2].posz)
				UICommand_AddInt(sceneId,2)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 13 then	--东北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[3].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[3].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[3].posz)
				UICommand_AddInt(sceneId,3)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 14 then	--东南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[4].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[4].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[4].posz)
				UICommand_AddInt(sceneId,4)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		--二层位置
		elseif GetNumText() == 21 then	--西北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[5].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[5].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[5].posz)
				UICommand_AddInt(sceneId,5)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 22 then	--西南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[6].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[6].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[6].posz)
				UICommand_AddInt(sceneId,6)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 23 then	--东北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[7].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[7].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[7].posz)
				UICommand_AddInt(sceneId,7)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 24 then	--东南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[8].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[8].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[8].posz)
				UICommand_AddInt(sceneId,8)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		--三层位置
		elseif GetNumText() == 31 then	--西北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[9].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[9].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[9].posz)
				UICommand_AddInt(sceneId,9)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 32 then	--西南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[10].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[10].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[10].posz)
				UICommand_AddInt(sceneId,10)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 33 then	--东北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[11].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[11].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[11].posz)
				UICommand_AddInt(sceneId,11)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 34 then	--东南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,1)
				UICommand_AddInt(sceneId,x893379_g_EnterData[12].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[12].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[12].posz)
				UICommand_AddInt(sceneId,12)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		--四层位置
		elseif GetNumText() == 41 then	--西北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,2)
				UICommand_AddInt(sceneId,x893379_g_EnterData[13].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[13].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[13].posz)
				UICommand_AddInt(sceneId,13)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 42 then	--西南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,2)
				UICommand_AddInt(sceneId,x893379_g_EnterData[14].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[14].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[14].posz)
				UICommand_AddInt(sceneId,14)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 43 then	--东北
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,2)
				UICommand_AddInt(sceneId,x893379_g_EnterData[15].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[15].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[15].posz)
				UICommand_AddInt(sceneId,15)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 44 then	--东南
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,2)
				UICommand_AddInt(sceneId,x893379_g_EnterData[16].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[16].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[16].posz)
				UICommand_AddInt(sceneId,16)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		elseif GetNumText() == 45 then	--中部
			BeginUICommand( sceneId )
				UICommand_AddInt(sceneId,2)
				UICommand_AddInt(sceneId,x893379_g_EnterData[17].sceneId)
				UICommand_AddInt(sceneId,x893379_g_EnterData[17].posx)
				UICommand_AddInt(sceneId,x893379_g_EnterData[17].posz)
				UICommand_AddInt(sceneId,17)
			EndUICommand( sceneId)
			DispatchUICommand(sceneId,selfId,89337901)
			return
		end
	end
end

--**********************************
--列举事件
--**********************************
function x893379_OnEnumerate( sceneId, selfId, targetId )
	if x893379_IsTransNPC( sceneId, selfId, targetId ) == 1 then
		AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_142}" ,9,1 )
		AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_143}" ,9,2 )
		AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_129}" ,9,3 )
		if x893379_IsCityTransNPC( sceneId, selfId, targetId ) == 1 then
			AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_144}" ,9,4 )
		else
			AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_249}" ,9,6 )
		end
		AddNumText( sceneId, x893379_g_ScriptId, "#{MJXZ_210510_52}" ,11,5 )
	end
end

--**********************************
--是否是主城传送NPC
--**********************************
function x893379_IsCityTransNPC( sceneId, selfId, targetId )
	local strNpcName = GetName( sceneId, targetId )
	if strNpcName == "龙戟" or strNpcName == "龙戈" or strNpcName == "秦剑" then
		return 1
	end
	return 0
end

--**********************************
--是否是传送NPC
--**********************************
function x893379_IsTransNPC( sceneId, selfId, targetId )
	local strNpcName = GetName( sceneId, targetId )
	if strNpcName == "龙戟" or strNpcName == "龙戈" or strNpcName == "秦剑" or strNpcName == "秦龙" then
		return 1
	end
	return 0
end

--**********************************
--是否地宫内部传送NPC
--**********************************
function x893379_IsTransDiGongNPC( sceneId, selfId, targetId )
	local strNpcName = GetName( sceneId, targetId )
	if strNpcName == "秦龙" then
		return 1
	end
	return 0
end

--**********************************
--进入场景
--**********************************
function x893379_EnterScene( sceneId, selfId,tarSceneId,tarPosX,tarPosZ,dataIdx )
	if x893379_g_EnterData[dataIdx] == nil then
		return
	end
	if x893379_g_EnterData[dataIdx].sceneId ~= tarSceneId then
		return
	end
	if x893379_g_EnterData[dataIdx].posx ~= tarPosX then
		return
	end
	if x893379_g_EnterData[dataIdx].posz ~= tarPosZ then
		return
	end
	local nCanEnter = CallScriptFunction(891147, "CanEnter", sceneId, selfId, 1 )
	if nCanEnter == 0 then
		return
	end
	CallScriptFunction(400900, "TransferFunc", sceneId, selfId, tarSceneId,tarPosX,tarPosZ,x893379_g_MinLevel )
end

--**********************************
--进入地宫4
--**********************************
function x893379_EnterSceneSiCeng( sceneId, selfId,tarSceneId,tarPosX,tarPosZ,dataIdx )
	if x893379_g_EnterData[dataIdx] == nil then
		return
	end
	if x893379_g_EnterData[dataIdx].sceneId ~= tarSceneId then
		return
	end
	if x893379_g_EnterData[dataIdx].posx ~= tarPosX then
		return
	end
	if x893379_g_EnterData[dataIdx].posz ~= tarPosZ then
		return
	end
	
	local nCanEnter = CallScriptFunction(893390, "CanEnter", sceneId, selfId, 1 )
	if nCanEnter == 0 then
		return
	end
	
	CallScriptFunction(400900, "TransferFunc", sceneId, selfId, tarSceneId,tarPosX,tarPosZ,x893379_g_MinLevel )
end

--**********************************
--随机进入地宫4一个位置
--**********************************
function x893379_EnterSceneSiCengRand( sceneId, selfId,dataIdx )

	local nCanEnter = CallScriptFunction(893390, "CanEnter", sceneId, selfId, 1 )
	if nCanEnter == 0 then
		return
	end
	--没有需要的传送效果
	if GetMissionFlagEx(sceneId,selfId,MFEX_DIE_INDIGONG4_HD) ~= 1 then
		return
	end
	
	if x893379_g_EnterData[dataIdx] == nil then
		return
	end

	CallScriptFunction(400900, "TransferFunc", sceneId, selfId, 
		x893379_g_EnterData[dataIdx].sceneId,
		x893379_g_EnterData[dataIdx].posx,
		x893379_g_EnterData[dataIdx].posz,
		x893379_g_MinLevel )
end

--**********************************
--检测接受条件，也供子任务调用
--**********************************
function x893379_CheckAccept( sceneId, selfId )
end

--**********************************
--接受，仅供子任务调用设置公共参数
--**********************************
function x893379_OnAccept( sceneId, selfId, targetId, scriptId )
end

--**********************************
--放弃，仅供子任务调用
--**********************************
function x893379_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x893379_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893379_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交，仅供子任务调用
--**********************************
function x893379_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end
