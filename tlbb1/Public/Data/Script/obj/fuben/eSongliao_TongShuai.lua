--怀旧兵行四象
--副本内将军

x502026_g_ScriptId = 502026
x502026_g_SceneData_TickCount = 2	
--提示词
x502026_g_TipsStr = {
	--宋军统帅
	[48267] = {
		[10000] = "#{XSLDZ_180521_114}",
		[10010] = "#{XSLDZ_180521_115}",
		[10015] = "#{XSLDZ_180521_116}",
		[10020] = "#{XSLDZ_180521_117}",
		[10030] = "#{XSLDZ_180521_118}",
	},
	--辽军统帅
	[48268] = {
		[10000] = "#{XSLDZ_180521_109}",
		[10010] = "#{XSLDZ_180521_110}",
		[10015] = "#{XSLDZ_180521_111}",
		[10020] = "#{XSLDZ_180521_112}",
		[10030] = "#{XSLDZ_180521_113}",
	}
}	
--**********************************
--事件交互入口
--**********************************
function x502026_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{XSLDZ_180424_41}")
		AddNumText( sceneId, x502026_g_ScriptId, "#{XSLDZ_180424_42}", 6, 1 ) 
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end
--**********************************
--事件列表选中一项
--**********************************
function x502026_OnEventRequest( sceneId, selfId, targetId, eventId)

	if IsInDist(sceneId,selfId,targetId,10) ~= 1 then
		x502026_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_210128_07}" )
		x502026_NotifyTips( sceneId, selfId, "#{XSLDZ_210128_06}" )
		return
	end
	
	local Operation = GetNumText()
	if Operation == 1 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{XSLDZ_180424_43}")
			AddNumText( sceneId, x502026_g_ScriptId, "#{XSLDZ_180424_42}", 6, 2 ) 
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)	
	end
	if Operation == 2 then
--		LuaFnNewSongLiaoMonsterTalk(sceneId, targetId, "四象天门阵",ScriptGlobal_Format("#{XSLDZ_180424_44}",GetName(sceneId,selfId)))
		CallScriptFunction(502011, "OnHumanAskLeave",sceneId, selfId)
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
--每1S回调一次
--**********************************
function x502026_OnCharacterTimer( sceneId, objId, dataId, uTime )
	if x502026_g_TipsStr[dataId] == nil then
		return
	end
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, x502026_g_SceneData_TickCount )
	if x502026_g_TipsStr[dataId][TickCount] == nil then
		return
	end
	LuaFnNewSongLiaoMonsterTalk(sceneId, objId, "四象天门阵",x502026_g_TipsStr[dataId][TickCount])
end
--**********************************
--提示所有副本内玩家
--**********************************
function x502026_TipAllHuman( sceneId, Str )
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanNum <= 0 then
		return
	end
	for i=0, nHumanNum-1  do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, nHumanId)
		end
	end
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x502026_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x502026_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end