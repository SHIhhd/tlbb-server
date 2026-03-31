--脚本号
x891273_g_ScriptId = 891273

--目标NPC：接任务、交任务，都是这个
x891273_g_AcceptNpcInfo	= {
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
--接受任务距离
x891273_g_AcceptDist = 5
--目前可枚举的子任务
x891273_g_MissionList = {
	--答题任务 ok
	[1] = {missionId = 2030,scriptId = 891274,name="#{XLRW_210725_472}"},
	--天材地宝 ok
	[2] = {missionId = 2031,scriptId = 891275,name="#{XLRW_210725_473}"},
	--养神调息 打坐任务 ok
	[3] = {missionId = 2032,scriptId = 891276,name="#{XLRW_210725_474}"},
	--清理恶痞 ok
	[4] = {missionId = 2033,scriptId = 891277,name="#{XLRW_210725_475}"},
	--参武切磋 ok 
	[5] = {missionId = 2034,scriptId = 891278,name="#{XLRW_210725_476}"},
	--珍物秘宝 ok
	[6] = {missionId = 2035,scriptId = 891279,name="#{XLRW_210725_477}"},
	--通达各派
	[7] = {missionId = 2036,scriptId = 891280,name="#{XLRW_210725_478}"},
	--复命
	[8] = {missionId = 2037,scriptId = 891281,name="#{XLRW_210725_479}"},
}
--**********************************
--任务入口函数
--**********************************
function x891273_OnDefaultEvent( sceneId, selfId, targetId,numText)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if numText == 10 then
		BeginEvent(sceneId);
			AddText( sceneId, "#{WDEC_220425_50}" );
			AddNumText( sceneId, x891273_g_ScriptId, "#{WDEC_220425_51}", 6, 13);
			AddNumText( sceneId, x891273_g_ScriptId, "#{WDEC_220425_52}", 6, 14);
			
			AddNumText( sceneId, x891273_g_ScriptId, "#{WDZD_221208_03}", 6, 15);
			AddNumText( sceneId, x891273_g_ScriptId, "#{WDZD_221208_04}", 6, 16);
		EndEvent(sceneId);
		DispatchEventList(sceneId, selfId, targetId);
	elseif numText == 1 then
		CallScriptFunction(891272, "OnDefaultEvent",sceneId, selfId, targetId,numText)
	elseif numText == 13 then
		--寻常修行·单轮
		CallScriptFunction(891272, "OnAcceptMission",sceneId, selfId,targetId,0,0)
	elseif numText == 14 then
		--双倍修行·单轮	
		CallScriptFunction(891272, "OnAcceptMission",sceneId, selfId,targetId,1,0)
	elseif numText == 15 then
		--持续修行·单轮
		CallScriptFunction(891272, "OnAcceptMission",sceneId, selfId,targetId,0,1)
	elseif numText == 16 then
		--持续修行·单轮	
		CallScriptFunction(891272, "OnAcceptMission",sceneId, selfId,targetId,1,1)
	elseif numText == 300 then
		local nCanAcceptNum = CallScriptFunction(891272, "GetWeekMissionCount",sceneId, selfId)
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{XLRW_210725_731}",tostring(45 - nCanAcceptNum)))
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--列举事件
--**********************************
function x891273_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--在门派武道长老处
	local nTalentType = 0
	if x891273_g_AcceptNpcInfo[nCurMenPai] ~= nil then
		for i = 1,2 do
			if GetName(sceneId,targetId) == x891273_g_AcceptNpcInfo[nCurMenPai].name[i] then
				nTalentType = i
				break
			end
		end
	end
	if nTalentType == 0 then
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nTalentType - 1 ~= nSectType then
		return
	end
	--距离检测
	if IsInDist(sceneId,selfId,targetId,x891273_g_AcceptDist) ~= 1 then
		return
	end
	--目前没有接受武道任务
	if CallScriptFunction(891272, "CheckAccept",sceneId, selfId) > 0 then
		AddNumText(sceneId,x891273_g_ScriptId,"#{XLRW_210725_01}",3,10);
	end
	--列举出当前的武道任务名称
	for i = 1,getn(x891273_g_MissionList) do
		if (IsHaveMission(sceneId,selfId,x891273_g_MissionList[i].missionId) > 0 ) then
			AddNumText(sceneId,x891273_g_ScriptId,x891273_g_MissionList[i].name,4,1);
			break
		end
	end
	--查看任务次数
	AddNumText(sceneId,x891273_g_ScriptId,"#{XLRW_210725_730}",6,300);
	
end
--**********************************
--接取任务
--**********************************
function x891273_OnAccept(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x891273_OnAbandon( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x891273_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end
