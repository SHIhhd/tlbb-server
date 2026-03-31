--测试脚本 程序
x777779_g_scriptId=777779

--**********************************
--事件交互入口
--**********************************
function x777779_DebugBegin(sceneId,selfId)
		--8640
--	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURSTATE, 1)
--	LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_PETISLAND_CURTICK, 0)
	LuaFnSetSectPoint(sceneId,selfId,99999)
	LuaFnCancelSpecificImpact( sceneId, selfId, 8640 )
	--弹出江湖志UI
--	SetMissionDataEx(sceneId,selfId,MDEX_JIANGHUZHI_OPEN_FLAG,0)
--    CallScriptFunction(998797,"SetFlagOpenAndShowUI",sceneId,selfId,1)
--	CallScriptFunction(998797,"SetFlagOpenAndShowUI",sceneId,selfId,2)
	--SetMissionDataEx(sceneId,selfId,MDEX_PETSOUL_CUIHUNSUI,700)
--	SetPos(sceneId,selfId,43,41)
----	local nMonsterNum = GetMonsterCount(sceneId)
----	for i=0, nMonsterNum-1 do
----		local MonsterId = GetMonsterObjID(sceneId,i)
----		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
----		if MosDataID == 49576 then
----			LuaFnUnitUseSkill(sceneId,MonsterId,3585,selfId,-1,-1,-1,1)
------			设置自身死亡在3000ms后死亡
----			SetCharacterDieTime(sceneId, MonsterId,3000)
----		end
----		
----	end
--
--	BeginUICommand( sceneId )
--		UICommand_AddInt( sceneId, 1)---0是关闭1是显示
--		UICommand_AddInt( sceneId, 0 )
--	EndUICommand( sceneId )
--	DispatchUICommand( sceneId, selfId, 79101002 )
	--任务标记完成
--	CallScriptFunction(893046,"OnFinish",sceneId, selfId)
--	SetMissionDataEx(sceneId,selfId,MDEX_TOPCHONGZHI_DATA,0)
--	CallScriptFunction(808015,"OnDefaultEvent",sceneId,42)
--	LuaFnSetSectPoint(sceneId,selfId,10000)
--	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
--	print("totallevel",totallevel)
	--地宫1-3
--	BeginUICommand( sceneId )
--		UICommand_AddInt( sceneId, 1)
--		UICommand_AddInt( sceneId, sceneId )
--		UICommand_AddInt( sceneId, 1 )
--		UICommand_AddInt( sceneId, 123 )
--	EndUICommand( sceneId )
--	DispatchUICommand( sceneId, selfId, 20210510 )
	
--	BeginUICommand( sceneId )
--		UICommand_AddInt( sceneId, 1)
--		UICommand_AddInt( sceneId, sceneId )
--		UICommand_AddInt( sceneId, 1 )
--		UICommand_AddInt( sceneId, 12 )
--		UICommand_AddInt( sceneId, 34 )
--		for i=1,5 do
--			UICommand_AddInt( sceneId, 2 )
--		end
--	EndUICommand( sceneId )
--	DispatchUICommand( sceneId, selfId, 20210519 )
--	
--	for i = 1,9 do
--		CallScriptFunction(791010, "AddPointData", sceneId, selfId, 3);
--	end
	--武道引导任务状态更新
--	CallScriptFunction(893242,"UpdateMissionState",sceneId,selfId)

--	CallScriptFunction(893390,"CreateBossAndBox",sceneId)
	
--	CallScriptFunction(893390,"OnSceneHumanDie",sceneId,selfId,selfId)
--	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, SCENE_SHUNANZHUHAI, 126,222, 75 );
--	CallScriptFunction(SECKILL_SCRIPT,"OnFinish",sceneId, selfId,CAMPAIGN_QINGQIU_DIFF)
--	SetMissionData(sceneId,selfId,MD_EQUIP_MAKE_NEW_UNBIND_POINT,10000)
--	SetMissionData(sceneId,selfId,MD_TQSD_DATA,LuaFnGetCurrentDateTime());
--	print("LuaFnGetCurrentDateTime()",LuaFnGetCurrentDateTime());
--	SetMissionData(sceneId,selfId,854,LuaFnGetShengWangId(sceneId,selfId));
--	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
--	CallScriptFunction(890063,"LearnLifeAbility",sceneId,selfId,nCampId)
	--武道三重引导任务状态更新
--	CallScriptFunction(998352,"UpdateMissionState",sceneId,selfId)
	
--	LuaFnSetSectPoint(sceneId,selfId,9999)
	
--	CallScriptFunction(890063,"JoinCamp",sceneId,selfId,selfId,1)
--	LuaFnSetShengWangId(sceneId,selfId,0)
--	for i = 1,3 do	
--		LuaFnSetShengWangMissionIndex(sceneId,selfId,i - 1,0)
--		LuaFnSetShengWangMissionDoneFlag(sceneId,selfId,i - 1,0)
--	end
--	LuaFnSetShengWangMissionIndex(sceneId,selfId,0,6)
--	LuaFnSetShengWangMissionIndex(sceneId,selfId,1,7)
--	LuaFnSetShengWangMissionIndex(sceneId,selfId,2,8)
--	LuaFnUpdateClientMainMenubarSkillList(sceneId,selfId,322,-1,-1,1,1)
	print("test2!!!")
--	CallScriptFunction(890215, "OnFinishMission",sceneId, selfId, 1)
--	CallScriptFunction(400900, "TransferFuncFromNpc",sceneId, selfId, SCENE_CHANGCHUNGU_BLD,264,127, 85)
--	LuaFnTJCPVPSetDaiBiCount(sceneId,selfId,11111)
--	LuaFnSongLiaoTest(sceneId,selfId,1)
--	LuaFnSongLiaoTest(sceneId,selfId,2)
--	LuaFnSongLiaoTest(sceneId,selfId,3)
--	CallScriptFunction(502011, "MakeCopyScene",sceneId,selfId)
	--x893342_OnDefaultEvent
--	CallScriptFunction(893342, "OnDefaultEvent",sceneId,348)
--	CallScriptFunction(998445, "CreateMonsterXiaoFengBoss",sceneId)
--	SetPos(sceneId,selfId,159,61)
--	CallScriptFunction(998445, "ReleaseDynamicRegion",sceneId,6)
--	x893342_CreateMonster(sceneId)
--	DispatchUICommand( sceneId, selfId, 502011 )
--	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURCAMP,156)
--	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURSTATE,156)
--	SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_CURINDEX,1)
--	SetMissionFlagEx(sceneId,selfId,MFEX_NEWSONGLIAO_CURGETPRIZE,0)
--	LuaFnSendScriptMail( sceneId, GetName(sceneId,selfId), MAIL_BINGXINGSIXIANG, 157, 1, 2)
	--新宋辽商店限量清空
--	for i = 1,8 do
--		SetMissionDataEx(sceneId,selfId,MDEX_NEWSONGLIAO_RY_1 + i - 1,0)
--	end
--	ChangeSongLiaoTest(sceneId,selfId,7,2)
	--502011
--	LuaFnNewSongLiaoMonsterTalk(sceneId, -1, "四象天门阵","天门阵消息")
--	BroadMsgByChatPipe(sceneId, selfId, "四象天门阵消息", 0);
	SetMissionFlagEx(sceneId,selfId,MFEX_TopChongZhiFlag_8,0)
--	print("teamid",GetTeamId(sceneId,selfId))
	--清理领取状态
	--x893397_GenDropItem( sceneId, selfId,openHumanId )
--	local lastDayCount = GetCampaignCountNum(sceneId,selfId,CAMPAIGN_QINGQIU)
--	print("lastDayCount",lastDayCount)
--	AddCampaignCountNum(sceneId,selfId,CAMPAIGN_QINGQIU)
--	SendOResultToPlayer(sceneId,selfId,-372)
--	1165]={Product=10157011
	
--	LuaFnTryRecieveSingleItem( sceneId, selfId, 10157006, 1160 * 10 + 4,1 )	
--	LuaFnTryRecieveSingleItem( sceneId, selfId, 10157007, 1161 * 10 + 4,1 )	
--	LuaFnTryRecieveSingleItem( sceneId, selfId, 10157008, 1162 * 10 + 4,1 )	
--	LuaFnTryRecieveSingleItem( sceneId, selfId, 10157009, 1163 * 10 + 4,1 )	
--	LuaFnTryRecieveSingleItem( sceneId, selfId, 10157010, 1164 * 10 + 4,1 )	
--	LuaFnTryRecieveSingleItem( sceneId, selfId, 10157011, 1165 * 10 + 4,1 )	
	--梦魇积累
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1)			--nNightmare
		UICommand_AddInt( sceneId, 1000 )		--nNightmareMax
		UICommand_AddInt( sceneId, 0 )			--nNightTick
	EndUICommand( sceneId )
--	DispatchUICommand( sceneId, selfId, 99844501 )

	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 1)
	EndUICommand( sceneId )
--	DispatchUICommand( sceneId, selfId, 99869401 )

	--屏幕闪烁特效
--	DispatchUICommand( sceneId, selfId, 99844502 )
	
--	LuaFnClientPlayerMovie(sceneId,selfId,5)
	
--	SetMissionData(sceneId,selfId,MD_BaiBingJingTong,1)
--	print(GetMissionData(sceneId,selfId,MD_BaiBingJingTong))
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x777779_NotifyFailTip( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end