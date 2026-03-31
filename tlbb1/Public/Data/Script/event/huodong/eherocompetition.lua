--英雄大会主界面

--脚本号
x891119_g_scriptId = 891119

x891119_g_ZLHeroMeetingBeginTime = 20210415
x891119_g_ZLHeroMeetingEndinTime = 20210428
x891119_g_MinLevel = 80
x891119_g_GiftMinLevel = 30
x891119_g_ZLheroMeeting_needyxz = 
{
    30,60,100,150, 220,300,400,550,
}
x891119_g_ZLHeroMeeting_item =
{    
    [1] = {30008027,1},
    [2] = {20800013,2},
    [3] = {39920091,60},
    [4] = {20310168,5},
    [5] = {20800013,3},
    [6] = {39920091,100},
    [7] = {20501003,1},
    [8] = {20502003,1},
} 
--**********************************
-- 客户端请求打开界面
--**********************************
function x891119_YXZ_Open( sceneId, selfId)
	if GetTime2Day() < x891119_g_ZLHeroMeetingBeginTime or GetTime2Day() > x891119_g_ZLHeroMeetingEndinTime then
		x891119_NotifyTips(sceneId,selfId,"#{YXDHGN_210222_05}")
		return
	end
	if GetLevel(sceneId,selfId) < x891119_g_MinLevel then
		x891119_NotifyTips(sceneId,selfId,"#{YXDHGN_210222_06}")
		return
	end
	local ZLHeroMeeting_yxz_total = GetMissionDataEx(sceneId,selfId,MDEX_ZLHEROYXZ_POTAL)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,ZLHeroMeeting_yxz_total)
		UICommand_AddInt( sceneId,0)
	EndUICommand( sceneId )
	DispatchUICommand(sceneId,selfId,89111901)
end
--**********************************
-- 客户端请求领取奖励
--**********************************
function x891119_GetGift_YXZ(sceneId,selfId,index)
	if index < 0 or index > 8 then
		return
	end
	if GetTime2Day() < x891119_g_ZLHeroMeetingBeginTime or GetTime2Day() > x891119_g_ZLHeroMeetingEndinTime then
		x891119_NotifyTips(sceneId,selfId,"#{YXDHGN_210222_11}")
		return
	end
	if GetLevel(sceneId,selfId) < x891119_g_GiftMinLevel then
		x891119_NotifyTips(sceneId,selfId,"#{YXDHGN_210222_12}")
		return
	end
	local nGiftData = GetMissionDataEx(sceneId,selfId,MDEX_ZLHEROYXZ_GIFT)
	local ZLHeroMeeting_yxz_total = GetMissionDataEx(sceneId,selfId,MDEX_ZLHEROYXZ_POTAL)
	if nGiftData >= index then
		x891119_NotifyTips(sceneId,selfId,"#{YXDHGN_210222_13}")
		return
	end
	if ZLHeroMeeting_yxz_total < x891119_g_ZLheroMeeting_needyxz[index] then
		x891119_NotifyTips(sceneId,selfId,"#{YXDHGN_210222_14}")
		return
	end
end

--**********************************
-- 信息提示
--**********************************
function x891119_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
	AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
