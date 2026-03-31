--MisDescBegin
x891277_g_ScriptId = 891277
x891277_g_MainScriptId = 891272--主脚本号
x891277_g_NpcScriptId = 891273--npc脚本号
x891277_g_KDZZID = 1006000536
x891277_g_KDZZSubID = 4

--任务号
x891277_g_MissionId = 2033
x891277_g_MissionKind = 7
x891277_g_MissionLevel = 60
x891277_g_IfMissionElite = 0

--任务名
x891277_g_MissionName="#{XLRW_210725_475}"
x891277_g_MissionTarget=""
x891277_g_Custom = {}

--任务参数
x891277_g_IsMissionOkFail = 0--是否完成
x891277_g_MissionLiuPai = 1-- 流派
x891277_g_MissionMenPai = 2-- 门派
x891277_g_Param_NpcIndex = 3--目标Npc组索引
x891277_g_Param_Custom1 = 4--完成情况
x891277_g_Param_Custom2 = 5--完成情况

--完成任务NPC
x891277_g_AccomplishNPC = {}

--副本入口NPC
x891277_g_NpcList = 
{
	[0] = { mpname="#{XLRW_210725_43}", namelink = "#{XLRW_210725_540}", },--少林
	[1] = { mpname="#{XLRW_210725_38}", namelink = "#{XLRW_210725_542}", },--明教
	[2] = { mpname="#{XLRW_210725_39}", namelink = "#{XLRW_210725_541}", },--丐帮
	[3] = { mpname="#{XLRW_210725_40}", namelink = "#{XLRW_210725_543}", },--武当
	[4] = { mpname="#{XLRW_210725_35}", namelink = "#{XLRW_210725_546}", },--峨嵋
	[5] = { mpname="#{XLRW_210725_41}", namelink = "#{XLRW_210725_547}", },--星宿
	[6] = { mpname="#{XLRW_210725_42}", namelink = "#{XLRW_210725_544}", },--天龙
	[7] = { mpname="#{XLRW_210725_36}", namelink = "#{XLRW_210725_548}", },--天山
	[8] = { mpname="#{XLRW_210725_37}", namelink = "#{XLRW_210725_545}", },--逍遥
	[10] = { mpname="#{XLRW_210725_741}", namelink = "#{XLRW_210725_753}", },--曼陀
}

--npc距离
x891277_g_NpcDist = 5
--背包空位
x891277_g_BagSpace = 1

--奖励
--x891277_g_MoneyJZBonus					=	30000
--x891277_g_ExpBonus						= 250000

--MisDescEnd
x891277_g_BossList = {		
	[1] =	{ 		MonsterName = "赤瞳小卒", BossName = "冶力行",},
	[2] =	{		MonsterName = "削面鬼人", BossName = "申屠",  },	
	[3] =	{		MonsterName = "细腰男俑", BossName = "虹七娘",  },
}
--目标NPC：接任务、交任务，都是这个
x891277_g_AcceptNpcInfo	= {
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
function x891277_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891277_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891277_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891277_g_NpcDist) ~= 1 then
		x891277_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891277_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891277_g_MissionLevel then
		x891277_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891277_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetTaskItemBagSpace( sceneId, selfId ) < x891277_g_BagSpace then
		x891277_NotifyTip( sceneId, selfId, "#{XLRW_210725_46}" )
		x891277_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891277_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891277_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891277_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891277_g_MissionId, x891277_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		x891277_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891277_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891277_g_MissionId)
	local nRandItemIndex = random(1,getn(x891277_g_BossList));

	SetMissionByIndex(sceneId,selfId,misIndex,x891277_g_IsMissionOkFail,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891277_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891277_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	SetMissionByIndex(sceneId,selfId,misIndex,x891277_g_Param_NpcIndex,nRandItemIndex)	
	SetMissionByIndex(sceneId,selfId,misIndex,x891277_g_Param_Custom1,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x891277_g_Param_Custom2,0)
	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891277_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--XLRW_210725_34	    近日我听闻有一批名号唬人的地痞，在地盘之争中失败，因此躲入#G%s0#W的洞天中避难。门派弟子掌事太多，无暇顾及。你若愿意帮忙，不仅做了一件好事，还能验证自己是否掌握了在此前武道修行中所学。#r    你快速速前往#G%s0#W%s1处告知意图，并击败来扰地痞，助你修行。#r    当前任务环数：#G%s2	

	x891277_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_34}",
		x891277_g_NpcList[nCurMenPai].mpname,
		x891277_g_NpcList[nCurMenPai].namelink,
		tostring(x891277_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891277_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891277_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891277_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891277_g_MissionId)
	local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891277_g_MissionMenPai)
	local misOk = GetMissionParam(sceneId,selfId,misIndex,x891277_g_IsMissionOkFail)
	
	if misOk ~= 1 then
		--赶走
		x891277_NotifyTip( sceneId, selfId,"#{XLRW_210725_169}")
		x891277_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_170}",x891277_g_NpcList[nMenPai].namelink) )
		return
	end

	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891277_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
		
	CallScriptFunction(x891277_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891277_g_MissionId)
end
--**********************************
--杀死怪物或玩家
--**********************************
function x891277_OnKillObject( sceneId, selfId, objdataId, objId )
	local allOwnersCount = GetMonsterOwnerCount( sceneId, objId )		--取得这个怪物死后拥有分配权的人数
	local curOwner, misIndex
	local nNpcIdx, strNpcName, nKilled
	local MonsterName = GetName( sceneId, objId )

	for i = 0, allOwnersCount - 1 do
		curOwner = GetMonsterOwnerID( sceneId, objId, i )				--取得拥有分配权的人的objId
		if IsHaveMission( sceneId, curOwner, x891277_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x891277_g_MissionId ) == x891277_g_ScriptId then		--如果这个人拥有任务
			misIndex = GetMissionIndexByID( sceneId, curOwner, x891277_g_MissionId )
			nNpcIdx = GetMissionParam( sceneId, curOwner, misIndex, x891277_g_Param_NpcIndex )
			if x891277_g_BossList[nNpcIdx] == nil then
				return
			end

			if MonsterName == x891277_g_BossList[nNpcIdx].MonsterName then
				nKilled = GetMissionParam( sceneId, curOwner, misIndex, x891277_g_Param_Custom1 )
				nKilled = nKilled + 1

				SetMissionByIndex( sceneId, curOwner, misIndex, x891277_g_Param_Custom1, nKilled )
				--
				local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
				local mems = {};
				for	i=0,membercount-1 do
					mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
					x891277_NotifyTip(sceneId, mems[i], ScriptGlobal_Format("#{XLRW_210725_166}",MonsterName,tostring(nKilled)));
				end
			end

			if MonsterName == x891277_g_BossList[nNpcIdx].BossName then
				nKilled = GetMissionParam( sceneId, curOwner, misIndex, x891277_g_Param_Custom2 )
				nKilled = nKilled + 1

				SetMissionByIndex( sceneId, curOwner, misIndex, x891277_g_Param_Custom2, nKilled )
				--
				local membercount = LuaFnGetCopyScene_HumanCount(sceneId);
				local mems = {};
				for	i=0,membercount-1 do
					mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId, i);
					x891277_NotifyTip(sceneId, mems[i], ScriptGlobal_Format("#{XLRW_210725_165}",MonsterName));
				end
			end
			
			if GetMissionParam( sceneId, curOwner, misIndex, x891277_g_Param_Custom1 ) >= 5 and GetMissionParam( sceneId, curOwner, misIndex, x891277_g_Param_Custom2 ) >= 1 then
				--标记任务结束
				SetMissionByIndex( sceneId, curOwner, misIndex, x891277_g_IsMissionOkFail, 1 )
				--不再关心杀怪
				ResetMissionEvent( sceneId, curOwner, x891277_g_MissionId, 0 )	
				--标记副本结束
				if LuaFnGetSceneType(sceneId) == 1 then
					LuaFnSetCopySceneData_Param(sceneId, 4, 1);
				end
				--提示
				--XLRW_210725_168	#H返回%s0交付任务	
				local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891277_g_MissionMenPai)
				local nLiuPai = GetMissionParam(sceneId,selfId,misIndex,x891277_g_MissionLiuPai)
				local lpname,mpname,mpnpcname,mpnpcnamelink = x891277_GetXiuLianMission_NameStr(nMenPai, nLiuPai)
				x891277_NotifyTip(sceneId, curOwner, ScriptGlobal_Format("#{XLRW_210725_168}",mpnpcname));
			end
		end
	end
end
--**********************************
--任务当前环数
--**********************************
function x891277_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end
--**********************************
--放弃
--**********************************
function x891277_OnAbandon( sceneId, selfId )
	CallScriptFunction(x891277_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891277_g_MissionId)
end

--**********************************
--获取门派流派长老名称
--**********************************
function x891277_GetXiuLianMission_NameStr( menpaiid, liupaiid )--流派名 门派名 流派npc名
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
function x891277_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891277_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end