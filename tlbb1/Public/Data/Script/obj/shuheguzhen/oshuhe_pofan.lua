--脚本号
x001241_g_scriptId = 001241
--各煞星击杀次数MDEX声明
x001241_g_KillShaxingCount = 
{
	MDEX_SHAXING_SONGJIANG,
	MDEX_SHAXING_LUJUNYI,
	MDEX_SHAXING_WUYONG,
	MDEX_SHAXING_LIKUI,
	MDEX_SHAXING_GONGSUNSHENG,
	MDEX_SHAXING_GUANSHENG,
	MDEX_SHAXING_LINCHONG,
	MDEX_SHAXING_QINMING,
	MDEX_SHAXING_HUARONG,
	MDEX_SHAXING_WUSONG,
	MDEX_SHAXING_LUZHISHENG,
	MDEX_SHAXING_HUYANZHUO
}
x001241_g_PlayerCountData = {1,10,50,200}
--**********************************
--事件列表
--**********************************
function x001241_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{SXRW_090119_043}" )
		AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_044}", 6, 1 )
		AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_045}", 6, 6 )
		AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_046}", 11, 7 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001241_OnDefaultEvent( sceneId, selfId,targetId )
	x001241_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x001241_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumText = GetNumText()
	local Isok = 0; --这里用来记录是否达成条件。
	if nNumText == 1 then
		BeginEvent(sceneId)
			AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_047}", 3, 2 )
			AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_048}", 3, 3 )
			AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_098}", 3, 4 )
			AddNumText( sceneId, x001241_g_scriptId, "#{SXRW_090119_099}", 3, 5 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if nNumText >= 2 and nNumText <= 5 then
		for i = 1,getn(x001241_g_KillShaxingCount) do
			if x001241_g_KillShaxingCount[i] < x001241_g_PlayerCountData[nNumText - 1] then
				x001241_MsgBox( sceneId, selfId, targetId,"#{SXRW_090119_050}"..x001241_g_PlayerCountData[nNumText - 1].."#{SXRW_090119_051}")
				return
			end
			--先到这里，称号系统目前不完善，等完工再继续更新。
		end
	end
	--查询获胜次数
	if nNumText == 6 then
		BeginEvent( sceneId )
			AddText( sceneId,"#{SXRW_090119_055}")
			for i = 1,12 do
				AddText(sceneId,format("　#R#{SXRW_090119_0%d}",55 + i)..GetMissionDataEx(sceneId,selfId,x001241_g_KillShaxingCount[i]))
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--领取称号帮助
	if nNumText == 7 then
		x001241_MsgBox(sceneId,selfId,targetId,"#{SXRW_090119_109}")
		return
	end
end

--**************************************************************************
--对话
--**************************************************************************
function x001241_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
