--怀旧兵行四象

x502019_g_ScriptId = 502019

x502019_g_StartHumanNum = 60 --开启人数
x502019_g_StartHumanNum_OverTimer = 20 --超时后开始的最少人数

x502019_g_NPC_Param_CurEndTime = 0	--记录10分钟时间的

--**********************************
--事件交互入口
--**********************************
function x502019_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{XSLDZ_180424_07}")
		AddNumText( sceneId, x502019_g_ScriptId, "#{XSLDZ_180424_08}", 9, 1 ) --退出
		AddNumText( sceneId, x502019_g_ScriptId, "#{XSLDZ_180424_09}", 11, 4 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end
--**********************************
--事件列表选中一项
--**********************************
function x502019_OnEventRequest( sceneId, selfId, targetId, eventId)
	local Operation = GetNumText()
	if Operation == 1 then
		BeginEvent(sceneId)	   
			AddText( sceneId, "#{XSLDZ_180424_10}")
			AddNumText( sceneId, x502019_g_ScriptId, "#{XSLDZ_180424_11}", 9, 100 )
			AddNumText( sceneId, x502019_g_ScriptId, "#{XSLDZ_180424_12}", 9, 101 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return 
	end
	if Operation == 4 then
		x502019_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_180424_13}" )
		return
	end
	if Operation == 100 then
		CallScriptFunction( (400900), "TransferFunc",sceneId, selfId,1,random(192,194),random(143,145))
		return 
	end
	if Operation == 101 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return 
	end
end
--**********************************
--休息室场景判断
--此处挂在休息室刘博OBJ，每1S回调一次
--**********************************
function x502019_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)  
	if nHumanCount <= 0 then
		return
	end
	
	local is_InTime,nOverTime = CallScriptFunction(502011, "GetCampaginTimer", sceneId) 
	if is_InTime ~= 1 then
		--超时做最后一次整合创建
		if nHumanCount >= x502019_g_StartHumanNum_OverTimer then
			--满足情况，执行进入逻辑
			x502019_StartSLDZ(sceneId)
			return
		end
		--然则踢出所有人
		x502019_GoAwayAllPeople(sceneId)
		return
	end
	
	local nSubEndTime = LuaFnGetNpcIntParameter( sceneId,objId,x502019_g_NPC_Param_CurEndTime);
	nSubEndTime = nSubEndTime + 1
	LuaFnSetNpcIntParameter( sceneId,objId,x502019_g_NPC_Param_CurEndTime,nSubEndTime);
	
	for i = 1,nHumanCount do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
	--		if GetMissionFlag(sceneId,nHumanId,MF_JoinNewSongLiao) == 1 then
	--			--送出去
	--			CallScriptFunction( (400900), "TransferFunc", sceneId, nHumanId,1,random(191,193),random(143,145)) 
	--			--这里逻辑强断
	--			return
	--		else
				BeginUICommand( sceneId )
					UICommand_AddInt( sceneId, 60 * 10 - nSubEndTime )
					UICommand_AddInt( sceneId, nHumanCount )
				EndUICommand( sceneId )
				DispatchUICommand( sceneId, nHumanId, 20180613 )
	--		end
		end
	end
	
	if nSubEndTime >= 10 * 60 then
		--十分钟到了
		LuaFnSetNpcIntParameter( sceneId,objId,x502019_g_NPC_Param_CurEndTime,0);
		if nHumanCount >= x502019_g_StartHumanNum_OverTimer then
			--满足情况，执行进入逻辑
			x502019_StartSLDZ(sceneId)
			return
		else
			x502019_TipsAllHuman(sceneId,"#{XSLDZ_180503_70}")
			MonsterTalk(sceneId, -1, "雁门关前哨","#{XSLDZ_180521_298}")
		end
	end
	if nHumanCount >= x502019_g_StartHumanNum then
		--满足情况，执行进入逻辑
		x502019_StartSLDZ(sceneId)
		return
	end
	
end
--*********************************
--全场消息
--*********************************
function x502019_TipsAllHuman(sceneId,strData)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			x502019_NotifyTips(sceneId,nHumanId,strData)
		end
    end
end
--*********************************
--休息室人员清空
--*********************************
function x502019_GoAwayAllPeople(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, nHumanId,SCENE_SUZHOU,random(191,193),random(143,145)) 
		end
    end
end
--**********************************
--开始宋辽战场
--这里默认是将全部的小朋友传到战场上去
--**********************************
function x502019_StartSLDZ(sceneId)
	--再清理一次不满足条件的
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i = 1,nHumanCount do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			if GetLevel(sceneId, nHumanId) < 80 
				or LuaFnHasTeam( sceneId, nHumanId ) ~= 0 
				or LuaFnGetDRideFlag(sceneId, nHumanId) ~= 0 then
				--这些是全部不知道怎么进来的
				CallScriptFunction( (400900), "TransferFunc",  sceneId, nHumanId,SCENE_SUZHOU,294,241)
			end
		end
	end
	--创建副本
	local nLederId = LuaFnGetCopyScene_HumanObjId(sceneId,0)
	CallScriptFunction(502011, "MakeCopyScene",sceneId,nLederId)
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x502019_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x502019_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end