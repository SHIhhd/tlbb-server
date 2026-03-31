--MisDescBegin
x891274_g_ScriptId = 891274
x891274_g_MainScriptId = 891272--主脚本号
x891274_g_NpcScriptId = 891273--npc脚本号
x891274_g_KDZZID = 1006000536
x891274_g_KDZZSubID = 1

--任务号
x891274_g_MissionId = 2030
x891274_g_MissionKind = 7
x891274_g_MissionLevel = 60
x891274_g_IfMissionElite = 0

--任务名 
x891274_g_MissionName="#{XLRW_210725_472}"
x891274_g_MissionTarget=""
x891274_g_Custom = {}

--任务参数
x891274_g_IsMissionOkFail = 0--是否完成
x891274_g_MissionLiuPai = 1-- 流派
x891274_g_MissionMenPai = 2-- 门派
x891274_g_Param_NpcIndex = 3--目标npc索引
x891274_g_Param_QuestionIndex = 4--题目索引
x891274_g_Param_Custom = 5--完成情况

--完成任务NPC
x891274_g_AccomplishNPC = 
{
	[1] = { sname = "#{XLRW_210725_263}", npcname = "#{XLRW_210725_267}", name = "裴宣", sceneid = 0, },
	[2] = { sname = "#{XLRW_210725_263}", npcname = "#{XLRW_210725_268}", name = "周邦彦", sceneid = 0, },
	[3] = { sname = "#{XLRW_210725_263}", npcname = "#{XLRW_210725_269}", name = "王积薪", sceneid = 0, },
	[4] = { sname = "#{XLRW_210725_263}", npcname = "#{XLRW_210725_270}", name = "怀丙", sceneid = 0, },
	[5] = { sname = "#{XLRW_210725_263}", npcname = "#{XLRW_210725_271}", name = "章惇", sceneid = 0, },
	[6] = { sname = "#{XLRW_210725_263}", npcname = "#{XLRW_210725_272}", name = "吕惠卿", sceneid = 0, },
	[7] = { sname = "#{XLRW_210725_264}", npcname = "#{XLRW_210725_273}", name = "枯荣大师", sceneid = 2, },
	[8] = { sname = "#{XLRW_210725_264}", npcname = "#{XLRW_210725_274}", name = "洪大贵", sceneid = 2, },
	[9] = { sname = "#{XLRW_210725_264}", npcname = "#{XLRW_210725_275}", name = "王韶", sceneid = 2, },
	[10] = { sname = "#{XLRW_210725_264}", npcname = "#{XLRW_210725_276}", name = "凤朝阳", sceneid = 2, },
	[11] = { sname = "#{XLRW_210725_264}", npcname = "#{XLRW_210725_277}", name = "木婉清", sceneid = 2, },
	[12] = { sname = "#{XLRW_210725_264}", npcname = "#{XLRW_210725_278}", name = "范骅", sceneid = 2, },
	[13] = { sname = "#{XLRW_210725_265}", npcname = "#{XLRW_210725_279}", name = "张择端", sceneid = 1, },
	[14] = { sname = "#{XLRW_210725_265}", npcname = "#{XLRW_210725_280}", name = "魏真", sceneid = 1, },
	[15] = { sname = "#{XLRW_210725_265}", npcname = "#{XLRW_210725_281}", name = "谢尚", sceneid = 1, },
	[16] = { sname = "#{XLRW_210725_265}", npcname = "#{XLRW_210725_282}", name = "邓百川", sceneid = 1, },
	[17] = { sname = "#{XLRW_210725_265}", npcname = "#{XLRW_210725_283}", name = "朱丹臣", sceneid = 1, },
	[18] = { sname = "#{XLRW_210725_265}", npcname = "#{XLRW_210725_284}", name = "花剑雨", sceneid = 1, },
}

--答题列表
x891274_g_QuestionList = 
{
	[1] = { question = "#{XLRW_210725_225}", answer1 = "#{XLRW_210725_410}", answer2 = "#{XLRW_210725_411}", answer3 = "#{XLRW_210725_412}", answerid = 2, },
	[2] = { question = "#{XLRW_210725_226}", answer1 = "#{XLRW_210725_413}", answer2 = "#{XLRW_210725_414}", answer3 = "#{XLRW_210725_415}", answerid = 1, },
	[3] = { question = "#{XLRW_210725_227}", answer1 = "#{XLRW_210725_416}", answer2 = "#{XLRW_210725_417}", answer3 = "#{XLRW_210725_418}", answerid = 3, },
	[4] = { question = "#{XLRW_210725_228}", answer1 = "#{XLRW_210725_419}", answer2 = "#{XLRW_210725_420}", answer3 = "#{XLRW_210725_421}", answerid = 2, },
	[5] = { question = "#{XLRW_210725_229}", answer1 = "#{XLRW_210725_422}", answer2 = "#{XLRW_210725_423}", answer3 = "#{XLRW_210725_424}", answerid = 1, },
	[6] = { question = "#{XLRW_210725_230}", answer1 = "#{XLRW_210725_425}", answer2 = "#{XLRW_210725_426}", answer3 = "#{XLRW_210725_427}", answerid = 1, },
	[7] = { question = "#{XLRW_210725_231}", answer1 = "#{XLRW_210725_428}", answer2 = "#{XLRW_210725_429}", answer3 = "#{XLRW_210725_430}", answerid = 3, },
	[8] = { question = "#{XLRW_210725_232}", answer1 = "#{XLRW_210725_431}", answer2 = "#{XLRW_210725_432}", answer3 = "#{XLRW_210725_433}", answerid = 3, },
	[9] = { question = "#{XLRW_210725_233}", answer1 = "#{XLRW_210725_434}", answer2 = "#{XLRW_210725_435}", answer3 = "#{XLRW_210725_436}", answerid = 2, },
	[10] = { question = "#{XLRW_210725_234}", answer1 = "#{XLRW_210725_437}", answer2 = "#{XLRW_210725_438}", answer3 = "#{XLRW_210725_439}", answerid = 1, },
	[11] = { question = "#{XLRW_210725_235}", answer1 = "#{XLRW_210725_440}", answer2 = "#{XLRW_210725_441}", answer3 = "#{XLRW_210725_442}", answerid = 1, },
	[12] = { question = "#{XLRW_210725_236}", answer1 = "#{XLRW_210725_443}", answer2 = "#{XLRW_210725_444}", answer3 = "#{XLRW_210725_445}", answerid = 2, },
	[13] = { question = "#{XLRW_210725_237}", answer1 = "#{XLRW_210725_446}", answer2 = "#{XLRW_210725_447}", answer3 = "#{XLRW_210725_448}", answerid = 3, },
	[14] = { question = "#{XLRW_210725_238}", answer1 = "#{XLRW_210725_449}", answer2 = "#{XLRW_210725_450}", answer3 = "#{XLRW_210725_451}", answerid = 2, },
	[15] = { question = "#{XLRW_210725_239}", answer1 = "#{XLRW_210725_452}", answer2 = "#{XLRW_210725_453}", answer3 = "#{XLRW_210725_454}", answerid = 1, },
	[16] = { question = "#{XLRW_210725_240}", answer1 = "#{XLRW_210725_455}", answer2 = "#{XLRW_210725_456}", answer3 = "#{XLRW_210725_457}", answerid = 3, },
	[17] = { question = "#{XLRW_210725_241}", answer1 = "#{XLRW_210725_458}", answer2 = "#{XLRW_210725_459}", answer3 = "#{XLRW_210725_460}", answerid = 2, },
	[18] = { question = "#{XLRW_210725_242}", answer1 = "#{XLRW_210725_461}", answer2 = "#{XLRW_210725_462}", answer3 = "#{XLRW_210725_463}", answerid = 1, },
	[19] = { question = "#{XLRW_210725_243}", answer1 = "#{XLRW_210725_464}", answer2 = "#{XLRW_210725_465}", answer3 = "#{XLRW_210725_466}", answerid = 3, },
	[20] = { question = "#{XLRW_210725_244}", answer1 = "#{XLRW_210725_467}", answer2 = "#{XLRW_210725_468}", answer3 = "#{XLRW_210725_469}", answerid = 3, },
}

--npc距离
x891274_g_NpcDist = 5
--背包空位
x891274_g_BagSpace = 1

--奖励
--x891274_g_MoneyJZBonus					=	30000
--x891274_g_ExpBonus						= 250000

--MisDescEnd
--目标NPC：接任务、交任务，都是这个
x891274_g_AcceptNpcInfo	= {
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
--任务入口函数
--**********************************
function x891274_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务（实际上如果完成了任务这里就不会显示，但是再检测一次比较安全）
--    if IsMissionHaveDone(sceneId,selfId,x891274_g_MissionId) > 0 then
--		return
--	end
	if IsHaveMission(sceneId,selfId,x891274_g_MissionId) <= 0 then
		return
	end
	--获取任务索引的信息
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891274_g_MissionId)
	local nNpcIndex = GetMissionParam(sceneId,selfId,misIndex,x891274_g_Param_NpcIndex)
	if x891274_g_AccomplishNPC[nNpcIndex] == nil then
		return
	end
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891274_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891274_g_AcceptNpcInfo[nCurMenPai].name[i] then
				--XLRW_210725_19	    #G%s0#W的%s1对#G%s2#W心法要髓颇有心得，你去拜访请教，必得增益。事不宜迟，即刻动身吧。#r    当前任务环数：#G%s3	
				
				return
			end
		end
	end
	if x891274_g_AccomplishNPC[nNpcIndex].sceneid ~= sceneId then
		return
	end
	if GetName(sceneId,targetId) ~= x891274_g_AccomplishNPC[nNpcIndex].name then
		return
	end
	local nComplate = GetMissionParam(sceneId,selfId,misIndex,x891274_g_Param_Custom)
	if nComplate == 1 then
		return
	end
	--显示题目
	local nQuestionIndex = GetMissionParam(sceneId,selfId,misIndex,x891274_g_Param_QuestionIndex)
	if x891274_g_QuestionList[nQuestionIndex] == nil then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891274_g_NpcDist) ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{XLRW_210725_156}",GetName(sceneId,targetId)))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	if GetNumText() == 0 then
		BeginEvent(sceneId)
			AddText(sceneId,x891274_g_QuestionList[nQuestionIndex].question)
			AddNumText(sceneId, x891274_g_ScriptId,x891274_g_QuestionList[nQuestionIndex].answer1,6,1);
			AddNumText(sceneId, x891274_g_ScriptId,x891274_g_QuestionList[nQuestionIndex].answer2,6,2);
			AddNumText(sceneId, x891274_g_ScriptId,x891274_g_QuestionList[nQuestionIndex].answer3,6,3);
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() >= 1 and GetNumText() <= 3 then
		--选择的答案
		if GetNumText() ~= x891274_g_QuestionList[nQuestionIndex].answerid then
			--不是正确答案
			x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_119}" )
			x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_137}" )
		else
			x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_668}" )
			--XLRW_210725_669	    想不到你这么快就已经参悟了要诀的玄妙，当真是可喜可贺。#r    既已取得成果，就快回%s0处复命吧。
			local nMenPai = GetMissionParam(sceneId,selfId,misIndex,x891274_g_MissionMenPai)
			local nLiuPai = GetMissionParam(sceneId,selfId,misIndex,x891274_g_MissionLiuPai)
			
			local lpname,mpname,mpnpcname,mpnpcnamelink = x891274_GetXiuLianMission_NameStr(nMenPai, nLiuPai)
			x891274_NotifyBox( sceneId, selfId, targetId,ScriptGlobal_Format("#{XLRW_210725_669}",mpnpcnamelink) )
			--标记任务完成
			MissionCom( sceneId, selfId, x891274_g_MissionId )
			SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_IsMissionOkFail,1)		
			SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_Param_Custom,1)		
			--特效
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
			
		end
	end
end
--**********************************
--列举事件
--**********************************
function x891274_OnEnumerate( sceneId, selfId, targetId )
    --如果玩家完成过这个任务
--    if IsMissionHaveDone(sceneId,selfId,x891274_g_MissionId) > 0 then
--    	return 
--	end
    --如果已接此任务
	if IsHaveMission(sceneId,selfId,x891274_g_MissionId) > 0 then
		--获取任务索引的信息
		local misIndex = GetMissionIndexByID(sceneId,selfId,x891274_g_MissionId)
		local nComplate = GetMissionParam(sceneId,selfId,misIndex,x891274_g_Param_Custom)
		if nComplate == 1 then
			return
		end
		local nNpcIndex = GetMissionParam(sceneId,selfId,misIndex,x891274_g_Param_NpcIndex)
		if x891274_g_AccomplishNPC[nNpcIndex] == nil then
			return
		end
		if x891274_g_AccomplishNPC[nNpcIndex].sceneid ~= sceneId then
			return
		end
		if GetName(sceneId,targetId) ~= x891274_g_AccomplishNPC[nNpcIndex].name then
			return
		end
		AddNumText(sceneId,x891274_g_ScriptId,x891274_g_MissionName,2,0);
	end
end
--**********************************
--接取任务
--**********************************
function x891274_OnAccept(sceneId,selfId,targetId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891274_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891274_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891274_g_NpcDist) ~= 1 then
		x891274_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{XLRW_210725_07}",GetName(sceneId,targetId)) )
		x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_08}" )
		return
	end
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891274_g_MissionLevel then
		x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_05}" )
		x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_06}" )
		return
	end
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < x891274_g_BagSpace then
		x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_16}" )
		x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_17}" )
		return
	end
	--已经接了任务了
	if CallScriptFunction(x891274_g_MainScriptId, "CheckAccept",sceneId, selfId) ~= 1 then
		x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_12}" )
		x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_13}" )
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891274_g_MissionId, x891274_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_14}" )
		x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_15}" )
		return
	end
	--随机任务的数据
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891274_g_MissionId)
	SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_IsMissionOkFail,0)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_MissionLiuPai,LuaFnGetSectType(sceneId,selfId))
	SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_MissionMenPai,GetMenPai(sceneId,selfId))	
	local nRandNpcIndex = random(1,getn(x891274_g_AccomplishNPC))
	SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_Param_NpcIndex,nRandNpcIndex)		
	SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_Param_QuestionIndex,random(1,getn(x891274_g_QuestionList)))		
	SetMissionByIndex(sceneId,selfId,misIndex,x891274_g_Param_Custom,0)		
	
--	成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_18}",x891274_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--显示任务的介绍信息
	--XLRW_210725_19	    #G%s0#W的%s1对#G%s2#W心法要髓颇有心得，你去拜访请教，必得增益。事不宜迟，即刻动身吧。#r    当前任务环数：#G%s3	
	x891274_NotifyBox( sceneId, selfId, targetId, ScriptGlobal_Format("#{XLRW_210725_19}",
		x891274_g_AccomplishNPC[nRandNpcIndex].sname,
		x891274_g_AccomplishNPC[nRandNpcIndex].npcname,
		format("#{_MENPAI%d}",GetMenPai(sceneId,selfId)),
		tostring(x891274_GetXiuLianMissionNum(sceneId, selfId))
	))
end
--**********************************
--提交
--**********************************
function x891274_OnSubmit( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
--  if IsMissionHaveDone(sceneId,selfId,x891274_g_MissionId) > 0 then
--    	return 
--	end
	--不存在任务
	if IsHaveMission(sceneId,selfId,x891274_g_MissionId) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID(sceneId,selfId,x891274_g_MissionId)
	local nIsFinish = GetMissionParam(sceneId,selfId,misIndex,x891274_g_Param_Custom)
	if nIsFinish ~= 1 then
		--赶走
		x891274_NotifyTip( sceneId, selfId, "#{XLRW_210725_670}" )
		x891274_NotifyBox( sceneId, selfId, targetId, "#{XLRW_210725_671}" )
		return
	end

	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{XLRW_210725_121}",x891274_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	
	CallScriptFunction(x891274_g_MainScriptId, "OnFinishMission",sceneId, selfId, targetId,x891274_g_MissionId)
end
--**********************************
--任务当前环数
--**********************************
function x891274_GetXiuLianMissionNum(sceneId, selfId)
	local nData = GetMissionData(sceneId, selfId,MD_XIULIAN_MISSION_NUM)
	return mod(nData,1000) + 1
end

--**********************************
--放弃
--**********************************
function x891274_OnAbandon( sceneId, selfId )
	CallScriptFunction(x891274_g_MainScriptId, "OnAbandonMission",sceneId, selfId, x891274_g_MissionId)
end
--**********************************
--获取门派流派长老名称
--**********************************
function x891274_GetXiuLianMission_NameStr( menpaiid, liupaiid )--流派名 门派名 流派npc名
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
function x891274_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x891274_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
