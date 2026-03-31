--MisDescBegin
x891278_g_ScriptId = 891278
x891278_g_MainScriptId = 891272--主脚本号
x891278_g_NpcScriptId = 891273--npc脚本号
x891278_g_KDZZID = 1006000536
x891278_g_KDZZSubID = 5

--任务号
x891278_g_MissionId = 2034
x891278_g_MissionKind = 7
x891278_g_MissionLevel = 60
x891278_g_IfMissionElite = 0

--任务名
x891278_g_MissionName="#{XLRW_210725_476}"
x891278_g_MissionTarget=""
x891278_g_Custom = {}

--任务参数
x891278_g_IsMissionOkFail = 0--是否完成
x891278_g_MissionLiuPai = 1-- 流派
x891278_g_MissionMenPai = 2-- 门派
x891278_g_Param_MPIndex = 3--目标门派索引
x891278_g_Param_Custom = 4--完成情况

--完成任务NPC
x891278_g_AccomplishNPC = {}

--副本入口NPC
x891278_g_MPList = 
{
	[MP_SHAOLIN] = { mpname="#{XLRW_210725_43}", NPCName = "#{XLRW_210725_76}", },--少林
	[MP_MINGJIAO] = { mpname="#{XLRW_210725_38}", NPCName = "#{XLRW_210725_80}", },--明教
	[MP_GAIBANG] = { mpname="#{XLRW_210725_39}", NPCName = "#{XLRW_210725_78}", },--丐帮
	[MP_WUDANG] = { mpname="#{XLRW_210725_40}", NPCName = "#{XLRW_210725_82}", },--武当
	[MP_EMEI] = { mpname="#{XLRW_210725_35}", NPCName = "#{XLRW_210725_88}", },--峨嵋
	[MP_XINGSU] = { mpname="#{XLRW_210725_41}", NPCName = "#{XLRW_210725_90}", },--星宿
	[MP_DALI] = { mpname="#{XLRW_210725_42}", NPCName = "#{XLRW_210725_84}", },--天龙
	[MP_TIANSHAN] = { mpname="#{XLRW_210725_36}", NPCName = "#{XLRW_210725_92}", },--天山
	[MP_XIAOYAO] = { mpname="#{XLRW_210725_37}", NPCName = "#{XLRW_210725_86}", },--逍遥
	[MP_MANTUO] = { mpname="#{XLRW_210725_741}", NPCName = "#{XLRW_210725_755}", },--曼陀
}

--npc距离
x891278_g_NpcDist = 5
--背包空位
x891278_g_BagSpace = 1

--奖励
--x891278_g_MoneyJZBonus					=	30000
--x891278_g_ExpBonus						= 250000

--MisDescEnd
x891278_g_mpList = {
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
x891278_g_npcList = {		
	[0] = { MonsterName = "少林残影", NPCName = "#{XLRW_210725_76}", mpname="#{XLRW_210725_43}", },--少林
	[1] = { MonsterName = "明教残影", NPCName = "#{XLRW_210725_80}", mpname="#{XLRW_210725_38}", },--明教
	[2] = { MonsterName = "丐帮残影", NPCName = "#{XLRW_210725_78}", mpname="#{XLRW_210725_39}", },--丐帮
	[3] = { MonsterName = "武当残影", NPCName = "#{XLRW_210725_82}", mpname="#{XLRW_210725_40}", },--武当
	[4] = { MonsterName = "峨嵋残影", NPCName = "#{XLRW_210725_88}", mpname="#{XLRW_210725_35}", },--峨嵋
	[5] = { MonsterName = "星宿残影", NPCName = "#{XLRW_210725_90}", mpname="#{XLRW_210725_41}", },--星宿
	[6] = { MonsterName = "天龙残影", NPCName = "#{XLRW_210725_84}", mpname="#{XLRW_210725_42}", },--天龙
	[7] = { MonsterName = "天山残影", NPCName = "#{XLRW_210725_92}", mpname="#{XLRW_210725_36}", },--天山
	[8] = { MonsterName = "逍遥残影", NPCName = "#{XLRW_210725_86}", mpname="#{XLRW_210725_37}", },--逍遥
	[10] = { MonsterName = "曼陀残影", NPCName = "#{XLRW_210725_755}", mpname="#{XLRW_210725_741}", },--曼陀
}
--目标NPC：接任务、交任务，都是这个
x891278_g_AcceptNpcInfo	= {
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
function x891278_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891278_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891278_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891278_g_NpcDist) ~= 1 then
		x891278_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891278_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891278_g_MissionLevel then
		x891278_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891278_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetTaskItemBagSpace( sceneId, selfId ) < x891278_g_BagSpace then
		x891278_NotifyTip( sceneId, selfId, "#{XLRW_210725_46}" )
		x891278_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891278_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891278_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891278_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891278_g_MissionId, x891278_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		x891278_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891278_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891278_g_MissionId)
	local nRandMPIndex = x891278_g_mpList[random(1,getn(x891278_g_mpList))];
	
	SetMissionByIndex(sceneId,selfId,misIndex,x891278_g_IsMissionOkFail,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891278_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891278_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	SetMissionByIndex(sceneId,selfId,misIndex,x891278_g_Param_MPIndex,nRandMPIndex)	
	SetMissionByIndex(sceneId,selfId,misIndex,x891278_g_Param_Custom,0)
	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891278_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--XLRW_210725_47	    修行武道之人，最忌坐井观天，故步自封。如能将#G%s0#W武学融会贯通致以己用，便能使你武道修行再进一步。你可前往副本内击败其残影来自我提升。#r    当前任务环数：#G%s1	
	
	x891278_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_47}",
		x891278_g_npcList[nRandMPIndex].mpname,
		tostring(x891278_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891278_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891278_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891278_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891278_g_MissionId)
	local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891278_g_MissionMenPai)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891278_g_IsMissionOkFail)
	
	if misOk ~= 1 then
		--赶走
		local misMPIndex = GetMissionParam(sceneId,selfId,misIndex,x891278_g_Param_MPIndex)
		
		x891278_NotifyTip( sceneId, selfId,"#{XLRW_210725_169}")
		x891278_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_677}",
			x891278_g_npcList[misMPIndex].mpname,x891278_g_npcList[misMPIndex].NPCName) )
		return
	end

	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891278_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
		
	CallScriptFunction(x891278_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891278_g_MissionId)
end
--**********************************
--杀死怪物或玩家
--**********************************
function x891278_OnKillObject( sceneId, selfId, objdataId, objId )
	local allOwnersCount = GetMonsterOwnerCount( sceneId, objId )		--取得这个怪物死后拥有分配权的人数
	local curOwner, misIndex
	local nMPIndex, strNpcName, nKilled
	local MonsterName = GetName( sceneId, objId )

	for i = 0, allOwnersCount - 1 do
		curOwner = GetMonsterOwnerID( sceneId, objId, i )				--取得拥有分配权的人的objId
		if IsHaveMission( sceneId, curOwner, x891278_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x891278_g_MissionId ) == x891278_g_ScriptId then		--如果这个人拥有任务
			misIndex = GetMissionIndexByID( sceneId, curOwner, x891278_g_MissionId )
			nMPIndex = GetMissionParam( sceneId, curOwner, misIndex, x891278_g_Param_MPIndex )
			if x891278_g_npcList[nMPIndex] == nil then
				return
			end

			if MonsterName == x891278_g_npcList[nMPIndex].MonsterName then
				nKilled = GetMissionParam( sceneId, curOwner, misIndex, x891278_g_Param_Custom )
				nKilled = nKilled + 1

				SetMissionByIndex( sceneId, curOwner, misIndex, x891278_g_Param_Custom, nKilled )
				--
				local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
				local mems = {};
				for	i=0,membercount-1 do
					mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
					x891278_NotifyTip(sceneId, mems[i], ScriptGlobal_Format("#{XLRW_210725_176}",MonsterName,tostring(nKilled)));
				end
			end
			
			if GetMissionParam( sceneId, curOwner, misIndex, x891278_g_Param_Custom ) >= 6 then
				--标记任务结束
				SetMissionByIndex( sceneId, curOwner, misIndex, x891278_g_IsMissionOkFail, 1 )
				--不再关心杀怪
				ResetMissionEvent( sceneId, curOwner, x891278_g_MissionId, 0 )	
				--标记副本结束
				if LuaFnGetSceneType(sceneId) == 1 then
					LuaFnSetCopySceneData_Param(sceneId, 4, 1);
				end
				--XLRW_210725_168	#H返回%s0交付任务	
				local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891278_g_MissionMenPai)
				local nLiuPai = GetMissionParam(sceneId,selfId,misIndex,x891278_g_MissionLiuPai)
				local lpname,mpname,mpnpcname,mpnpcnamelink = x891278_GetXiuLianMission_NameStr(nMenPai, nLiuPai)
				x891278_NotifyTip(sceneId, curOwner, ScriptGlobal_Format("#{XLRW_210725_168}",mpnpcname));
			end
		end
	end
end
--**********************************
--任务当前环数
--**********************************
function x891278_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end
--**********************************
--放弃
--**********************************
function x891278_OnAbandon( sceneId, selfId )
	CallScriptFunction(x891278_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891278_g_MissionId)
end

--**********************************
--获取门派流派长老名称
--**********************************
function x891278_GetXiuLianMission_NameStr( menpaiid, liupaiid )--流派名 门派名 流派npc名
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
function x891278_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891278_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
