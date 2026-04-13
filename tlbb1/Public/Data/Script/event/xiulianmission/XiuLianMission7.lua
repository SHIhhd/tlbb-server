--MisDescBegin
x891280_g_ScriptId = 891280
x891280_g_MainScriptId = 891272--主脚本号
x891280_g_NpcScriptId = 891273--npc脚本号

x891280_g_KDZZID = 1006000536
x891280_g_KDZZSubID = 7

x891280_g_ItemId = 40005021

--任务号
x891280_g_MissionId = 2036
x891280_g_MissionKind = 7
x891280_g_MissionLevel = 60
x891280_g_IfMissionElite = 0

--任务名
x891280_g_MissionName="#{XLRW_210725_478}"
x891280_g_MissionTarget=""
x891280_g_Custom = {}

--任务参数
x891280_g_IsMissionOkFail = 0	--是否完成
x891280_g_MissionLiuPai = 1		-- 本流派
x891280_g_MissionMenPai = 2		-- 本门派
x891280_g_Param_targetMP = 3	-- 目标门派

--npc距离
x891280_g_NpcDist = 5

--背包空位
x891280_g_BagSpace = 1

--奖励
--x891280_g_MoneyJZBonus					= 30000
--x891280_g_ExpBonus						= 2500000

--MisDescEnd
--目标NPC：接任务、交任务，都是这个
x891280_g_AcceptNpcInfo	= {
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
x891280_g_mpList = {
	MP_SHAOLIN,
	MP_MINGJIAO,
	MP_GAIBANG,
	MP_WUDANG,
	MP_EMEI,
	MP_XINGSU,
	MP_DALI,
	MP_TIANSHAN,
	MP_XIAOYAO,
}
--**********************************
--接取任务
--**********************************
function x891280_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891280_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891280_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891280_g_NpcDist) ~= 1 then
		x891280_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891280_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891280_g_MissionLevel then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891280_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetTaskItemBagSpace( sceneId, selfId ) < x891280_g_BagSpace then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_46}" )
		x891280_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891280_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891280_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891280_g_MissionId, x891280_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891280_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891280_g_MissionId)
	local nRandMPIndex = x891280_g_mpList[random(1,getn(x891280_g_mpList))];

	SetMissionByIndex(sceneId,selfId,misIndex,x891280_g_IsMissionOkFail,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891280_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891280_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	SetMissionByIndex(sceneId,selfId,misIndex,x891280_g_Param_targetMP,nRandMPIndex)	

	--给任务道具
	BeginAddItem(sceneId)
		AddItem( sceneId, x891280_g_ItemId, 1 )
	EndAddItem(sceneId,selfId)
	AddItemListToHuman(sceneId,selfId)
	x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_696}" )
	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891280_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--XLRW_210725_59	    武道修行，要做到融会贯通，实非易事。我这本#Y传功心经#W上详细记载了传功之奥妙，你学习后，寻得#G%s0#W弟子，与其传功，细细感受此过程中内息经络的调和。#r    当前任务环数：#G%s1	
	local _, targetmpname = x891280_GetXiuLianMission_NameStr( nRandMPIndex, 0 )
	x891280_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_59}",
		targetmpname,
		tostring(x891280_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891280_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891280_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891280_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891280_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891280_g_IsMissionOkFail)
	if misOk ~= 1 then
		local targetMP = GetMissionParam(sceneId,selfId,misIndex,x891280_g_Param_targetMP)
		--赶走
		x891280_NotifyTip( sceneId, selfId,"#{XLRW_210725_686}")
		local _, targetmpname = x891280_GetXiuLianMission_NameStr( targetMP, 0 )
		x891280_NotifyBox( sceneId, selfId, targetId,  ScriptGlobal_Format("#{XLRW_210725_687}",targetmpname) )
		return
	end

	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891280_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--删除任务道具
	DelItem( sceneId,selfId, x891280_g_ItemId, 1 )
		
	CallScriptFunction(x891280_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891280_g_MissionId)
end
--**********************************
--传功道具检查
--**********************************
function x891280_CanUseItemCheck(sceneId, selfId,targetId)
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891280_g_MissionLevel then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_126}" )
		return 0
	end
	if IsHaveMission(sceneId,selfId,x891280_g_MissionId) <= 0 then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_109}" )
		return 0
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891280_g_MissionId)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891280_g_IsMissionOkFail)
	if misOk ~= 0 then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_118}" )
		return 0
	end
	local targetMP = GetMissionParam(sceneId,selfId,misIndex,x891280_g_Param_targetMP)
	local _, targetmpname = x891280_GetXiuLianMission_NameStr( targetMP, 0 )
	--检测对象是否人类
	if LuaFnGetObjType(sceneId,targetId) ~= 1 then
		x891280_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_192}",targetmpname) )
		return 0
	end
	if GetMenPai(sceneId,targetId) ~= targetMP then
		x891280_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_192}",targetmpname) )
		return 0
	end
	local tarPlayerX = GetHumanWorldX(sceneId,targetId)
	local tarPlayerZ = GetHumanWorldZ(sceneId,targetId)
	--取得玩家当前坐标
	local PlayerX = GetHumanWorldX(sceneId,selfId)
	local PlayerY = GetHumanWorldZ(sceneId,selfId)
	--计算玩家与目标点的距离
	local Distance = floor(sqrt((tarPlayerX-PlayerX)*(tarPlayerX-PlayerX)+(tarPlayerZ-PlayerY)*(tarPlayerZ-PlayerY)))
	if Distance > x891280_g_NpcDist then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_193}" )
		return 0
	end
	
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_130}" )
		return 0
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_132}" )
		return 0
	end
	
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_131}" )
		return 0
	end
	
	return 1;
end
--**********************************
--传功完成
--**********************************
function x891280_UseItemFinish(sceneId, selfId)
	if IsHaveMission(sceneId,selfId,x891280_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891280_g_MissionId)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891280_g_IsMissionOkFail,1)		
	
	x891280_NotifyTip( sceneId, selfId, "#{XLRW_210725_194}" )
	
	local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891280_g_MissionMenPai)
	local nLiuPai = GetMissionParam(sceneId,selfId,misIndex,x891280_g_MissionLiuPai)
	
	local _, _,_,strlink = x891280_GetXiuLianMission_NameStr( nMenPai, nLiuPai )
	x891280_NotifyBox( sceneId, selfId, -1,  ScriptGlobal_Format("#{XLRW_210725_685}",strlink) )
end
--**********************************
--任务当前环数
--**********************************
function x891280_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end
--**********************************
--放弃
--**********************************
function x891280_OnAbandon( sceneId, selfId )
	--删除任务道具
	DelItem( sceneId,selfId, x891280_g_ItemId, 1 )
	
	CallScriptFunction(x891280_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891280_g_MissionId)
end

--**********************************
--获取门派流派长老名称
--**********************************
function x891280_GetXiuLianMission_NameStr( menpaiid, liupaiid )--流派名 门派名 流派npc名
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
function x891280_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891280_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
