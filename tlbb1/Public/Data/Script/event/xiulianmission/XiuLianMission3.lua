--MisDescBegin
x891276_g_ScriptId = 891276
x891276_g_MainScriptId = 891272--主脚本号
x891276_g_NpcScriptId = 891273--npc脚本号

x891276_g_KDZZID = 1006000536
x891276_g_KDZZSubID = 3

x891276_g_ItemId = 40005022

--任务号
x891276_g_MissionId = 2032
x891276_g_MissionKind = 7
x891276_g_MissionLevel = 60
x891276_g_IfMissionElite = 0

--任务名
x891276_g_MissionName="#{XLRW_210725_474}"
x891276_g_MissionTarget=""
x891276_g_Custom = {}

--任务参数
x891276_g_IsMissionOkFail = 0	--是否完成
x891276_g_MissionLiuPai = 1		-- 本流派
x891276_g_MissionMenPai = 2		-- 本门派
x891276_g_MissionAreaScene = 3	-- 场景
x891276_g_MissionAreaPosX = 4	-- X
x891276_g_MissionAreaPosZ = 5	-- Z
x891276_g_MissionAreaIdx = 6	-- Idx

--npc距离
x891276_g_NpcDist = 5

--背包空位
x891276_g_BagSpace = 1

--奖励
--x891276_g_MoneyJZBonus					= 30000
--x891276_g_ExpBonus						= 2500000

--MisDescEnd
x891276_g_ScenePosList = { 
	[0] = {menpaiid=0,	sceneid=9,	str = {"#{XLRW_210725_639}","#{XLRW_210725_640}","#{XLRW_210725_641}",} } ,
	[1] = {menpaiid=1,	sceneid=11,	str = {"#{XLRW_210725_645}","#{XLRW_210725_646}","#{XLRW_210725_647}",} },
	[2] = {menpaiid=2,	sceneid=10,	str = {"#{XLRW_210725_642}","#{XLRW_210725_643}","#{XLRW_210725_644}",} },
	[3] = {menpaiid=3,	sceneid=12,	str = {"#{XLRW_210725_648}","#{XLRW_210725_649}","#{XLRW_210725_650}",} },
	[4] = {menpaiid=4,	sceneid=15,	str = {"#{XLRW_210725_657}","#{XLRW_210725_658}","#{XLRW_210725_659}",} },
	[5] = {menpaiid=5,	sceneid=16,	str = {"#{XLRW_210725_660}","#{XLRW_210725_661}","#{XLRW_210725_662}",} },
	[6] = {menpaiid=6,	sceneid=13,	str = {"#{XLRW_210725_651}","#{XLRW_210725_652}","#{XLRW_210725_653}",} },
	[7] = {menpaiid=7,	sceneid=17,	str = {"#{XLRW_210725_663}","#{XLRW_210725_664}","#{XLRW_210725_665}",} },
	[8] = {menpaiid=8,	sceneid=14,	str = {"#{XLRW_210725_654}","#{XLRW_210725_655}","#{XLRW_210725_656}",} },
	[10] = {menpaiid=10,sceneid=1283,str = {"#{XLRW_210725_748}","#{XLRW_210725_749}","#{XLRW_210725_750}",} },
}
x891276_g_ScenePos = { 
	[0] = {menpaiid=0,	sceneid=9,	pos = {{41,56},{147,114},{57,131},} } ,
	[1] = {menpaiid=1,	sceneid=11,	pos = {{155,35},{161,139},{43,157},} },
	[2] = {menpaiid=2,	sceneid=10,	pos = {{144,33},{39,139},{150,158},} },
	[3] = {menpaiid=3,	sceneid=12,	pos = {{42,94},{100,87},{103,154},} },
	[4] = {menpaiid=4,	sceneid=15,	pos = {{45,35},{94,118},{71,109},} },
	[5] = {menpaiid=5,	sceneid=16,	pos = {{66,38},{111,115},{41,150},} },
	[6] = {menpaiid=6,	sceneid=13,	pos = {{64,145},{130,136},{154,61},} },
	[7] = {menpaiid=7,	sceneid=17,	pos = {{153,38},{72,63},{81,117},} },
	[8] = {menpaiid=8,	sceneid=14,	pos = {{88,60},{119,88},{130,119},} },
	[10] = {menpaiid=10,sceneid=1283,pos = {{180,70},{114,154},{63,118},} },
}
--目标NPC：接任务、交任务，都是这个
x891276_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}}, --替代2022
}
--**********************************
--接取任务
--**********************************
function x891276_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891276_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891276_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891276_g_NpcDist) ~= 1 then
		x891276_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891276_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891276_g_MissionLevel then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891276_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetTaskItemBagSpace( sceneId, selfId ) < x891276_g_BagSpace then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_46}" )
		x891276_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891276_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891276_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891276_g_MissionId, x891276_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891276_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891276_g_MissionId)
	local nRandItemIndex = random(1,getn(x891276_g_ScenePos[nCurMenPai].pos));

	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_IsMissionOkFail,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_MissionAreaScene,x891276_g_ScenePos[nCurMenPai].sceneid)	
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_MissionAreaPosX,x891276_g_ScenePos[nCurMenPai].pos[nRandItemIndex][1])
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_MissionAreaPosZ,x891276_g_ScenePos[nCurMenPai].pos[nRandItemIndex][2])
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_MissionAreaIdx,nRandItemIndex)
	
	--给任务道具
	BeginAddItem(sceneId)
		AddItem( sceneId, x891276_g_ItemId, 1 )
	EndAddItem(sceneId,selfId)
	AddItemListToHuman(sceneId,selfId)
	x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_695}" )
	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891276_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--修行也要讲究劳逸结合。%s0灵气充沛，你前去打坐调息的同时，可细思#Y武道秘籍#W之深奥，或许能获得新的感悟。这本#Y武道秘籍#W给你，你带上它，快去感受一番吧。#r    当前任务环数：#G%s1
	x891276_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_30}",
		x891276_g_ScenePosList[nCurMenPai].str[nRandItemIndex],
		tostring(x891276_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891276_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891276_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891276_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891276_g_MissionId)
	local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionMenPai)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891276_g_IsMissionOkFail)
	
	if misOk ~= 1 then
		--赶走
		x891276_NotifyTip( sceneId, selfId,"#{XLRW_210725_148}")
		x891276_NotifyBox( sceneId, selfId, targetId,  "#{XLRW_210725_149}" )
		return
	end

	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891276_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--删除任务道具
	DelItem( sceneId,selfId, x891276_g_ItemId, 1 )
		
	CallScriptFunction(x891276_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891276_g_MissionId)
end
--**********************************
--打坐道具检查
--**********************************
function x891276_CanUseItemCheck(sceneId, selfId,targetId)
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891276_g_MissionLevel then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_126}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x891276_g_MissionId) <= 0 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_109}" )
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891276_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891276_g_IsMissionOkFail)
	if misOk ~= 0 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_118}" )
		return 0
	end
	local nCurMenPai = GetMenPai(sceneId,selfId)
	local misAreaIdx = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionAreaIdx)
	local misSceneId = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionAreaScene)
	if misSceneId ~= sceneId then
		x891276_NotifyBox( sceneId, selfId, -1, ScriptGlobal_Format("#{XLRW_210725_142}",x891276_g_ScenePosList[nCurMenPai].str[misAreaIdx]) )
		return 0
	end
	local misAreaX = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionAreaPosX)
	local misAreaZ = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionAreaPosZ)
	--取得玩家当前坐标
	local PlayerX = GetHumanWorldX(sceneId,selfId)
	local PlayerY = GetHumanWorldZ(sceneId,selfId)
	--计算玩家与目标点的距离
	local Distance = floor(sqrt((misAreaX-PlayerX)*(misAreaX-PlayerX)+(misAreaZ-PlayerY)*(misAreaZ-PlayerY)))
	if Distance > 2 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_129}" )
		return 0
	end
	
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_130}" )
		return 0
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_132}" )
		return 0
	end
	
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x891276_NotifyTip( sceneId, selfId, "#{XLRW_210725_131}" )
		return 0
	end
	
	return 1;
end
--**********************************
--打坐完成
--**********************************
function x891276_UseItemFinish(sceneId, selfId,targetId)
	if IsHaveMission(sceneId,selfId,x891276_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891276_g_MissionId)
	local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionMenPai)
	local nLiuPai = GetMissionParam(sceneId,selfId,misIndex,x891276_g_MissionLiuPai)
	
	local lpname,mpname,mpnpcname,mpnpcnamelink = x891276_GetXiuLianMission_NameStr(nMenPai, nLiuPai)
	x891276_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_145}",lpname) )
	x891276_NotifyBox( sceneId, selfId,-1, ScriptGlobal_Format("#{XLRW_210725_722}",mpnpcnamelink) )
	
	SetMissionByIndex(sceneId,selfId,misIndex,x891276_g_IsMissionOkFail,1)		
end


--**********************************
--任务当前环数
--**********************************
function x891276_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end
--**********************************
--放弃
--**********************************
function x891276_OnAbandon( sceneId, selfId )
	--删除任务道具
	DelItem( sceneId,selfId, x891276_g_ItemId, 1 )
	
	CallScriptFunction(x891276_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891276_g_MissionId)
end

--**********************************
--获取门派流派长老名称
--**********************************
function x891276_GetXiuLianMission_NameStr( menpaiid, liupaiid )--流派名 门派名 流派npc名
	local g_MenPaiNpcA = {
		[0] = {str = "#{XLRW_210725_246}", strlink = "#{XLRW_210725_523}", liupainame = "#{XLRW_210725_481}", mpname = "#{XLRW_210725_43}"},--少林
		[1] = {str = "#{XLRW_210725_250}", strlink = "#{XLRW_210725_527}", liupainame = "#{XLRW_210725_485}", mpname = "#{XLRW_210725_38}"},--明教
		[2] = {str = "#{XLRW_210725_248}", strlink = "#{XLRW_210725_525}", liupainame = "#{XLRW_210725_483}", mpname = "#{XLRW_210725_39}"},--丐帮
		[3] = {str = "#{XLRW_210725_251}", strlink = "#{XLRW_210725_528}", liupainame = "#{XLRW_210725_486}", mpname = "#{XLRW_210725_40}"},--武当
		[4] = {str = "#{XLRW_210725_257}", strlink = "#{XLRW_210725_534}", liupainame = "#{XLRW_210725_492}", mpname = "#{XLRW_210725_35}"},--峨嵋
		[5] = {str = "#{XLRW_210725_259}", strlink = "#{XLRW_210725_536}", liupainame = "#{XLRW_210725_494}", mpname = "#{XLRW_210725_41}"},--星宿
		[6] = {str = "#{XLRW_210725_253}", strlink = "#{XLRW_210725_530}", liupainame = "#{XLRW_210725_488}", mpname = "#{XLRW_210725_42}"},--天龙
		[7] = {str = "#{XLRW_210725_261}", strlink = "#{XLRW_210725_538}", liupainame = "#{XLRW_210725_496}", mpname = "#{XLRW_210725_36}"},--天山
		[8] = {str = "#{XLRW_210725_255}", strlink = "#{XLRW_210725_532}", liupainame = "#{XLRW_210725_490}", mpname = "#{XLRW_210725_37}"},--逍遥
		[10] = {str = "#{XLRW_210725_770}", strlink = "#{XLRW_210725_735}", liupainame = "#{XLRW_210725_737}", mpname = "#{XLRW_210725_741}"},--曼陀山庄
	}
	
	local g_MenPaiNpcB = {
		[0] = {str = "#{XLRW_210725_245}", strlink = "#{XLRW_210725_522}", liupainame = "#{XLRW_210725_480}", mpname = "#{XLRW_210725_43}"},--少林
		[1] = {str = "#{XLRW_210725_249}", strlink = "#{XLRW_210725_526}", liupainame = "#{XLRW_210725_484}", mpname = "#{XLRW_210725_38}"},--明教
		[2] = {str = "#{XLRW_210725_247}", strlink = "#{XLRW_210725_524}", liupainame = "#{XLRW_210725_482}", mpname = "#{XLRW_210725_39}"},--丐帮
		[3] = {str = "#{XLRW_210725_252}", strlink = "#{XLRW_210725_529}", liupainame = "#{XLRW_210725_487}", mpname = "#{XLRW_210725_40}"},--武当
		[4] = {str = "#{XLRW_210725_258}", strlink = "#{XLRW_210725_535}", liupainame = "#{XLRW_210725_493}", mpname = "#{XLRW_210725_35}"},--峨嵋
		[5] = {str = "#{XLRW_210725_260}", strlink = "#{XLRW_210725_537}", liupainame = "#{XLRW_210725_495}", mpname = "#{XLRW_210725_41}"},--星宿
		[6] = {str = "#{XLRW_210725_254}", strlink = "#{XLRW_210725_531}", liupainame = "#{XLRW_210725_489}", mpname = "#{XLRW_210725_42}"},--天龙
		[7] = {str = "#{XLRW_210725_262}", strlink = "#{XLRW_210725_539}", liupainame = "#{XLRW_210725_497}", mpname = "#{XLRW_210725_36}"},--天山
		[8] = {str = "#{XLRW_210725_256}", strlink = "#{XLRW_210725_533}", liupainame = "#{XLRW_210725_491}", mpname = "#{XLRW_210725_37}"},--逍遥
		[10] = {str = "#{XLRW_210725_771}", strlink = "#{XLRW_210725_736}", liupainame = "#{XLRW_210725_738}", mpname = "#{XLRW_210725_741}"},--曼陀山庄
	}
	local g_LiuPaiA = 0
	local g_LiuPaiB = 1
	if liupaiid == g_LiuPaiA and g_MenPaiNpcA[menpaiid] ~= nil then
		return g_MenPaiNpcA[menpaiid].liupainame, g_MenPaiNpcA[menpaiid].mpname, g_MenPaiNpcA[menpaiid].str, g_MenPaiNpcA[menpaiid].strlink
	end
	if liupaiid == g_LiuPaiB and g_MenPaiNpcB[menpaiid] ~= nil then
		return g_MenPaiNpcB[menpaiid].liupainame, g_MenPaiNpcB[menpaiid].mpname, g_MenPaiNpcB[menpaiid].str , g_MenPaiNpcB[menpaiid].strlink
	end
	return "","",""
end

--**********************************
--对话窗口信息提示
--**********************************
function x891276_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891276_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
