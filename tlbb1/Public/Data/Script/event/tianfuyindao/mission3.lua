--MisDescBegin
--脚本号
x891220_g_ScriptId = 891220

--完成任务NPC属性
-- x891220_g_Position_X=160  --替代
-- x891220_g_Position_Z=157 --替代
-- x891220_g_SceneID=2
-- x891220_g_AccomplishNPC_Name="赵天师"

--任务号
x891220_g_MissionId = 2023

--前置任务
x891220_g_PreMissionId = 2022
x891220_g_PreMissionName = "#{TFYD_210729_28}"

--目标NPC
x891220_g_AcceptNpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name="玄难", posx=91, posz=71, script=9002},
	[MP_MINGJIAO] = {sceneId=11, name="庞万春", posx=109, posz=59, script=11005},
	[MP_GAIBANG] = {sceneId=10, name="奚三祁", posx=94, posz=99, script=10007},
	[MP_WUDANG] = {sceneId=12, name="俞远山", posx=82, posz=84, script=12010},
	[MP_EMEI] = {sceneId=15, name="崔绿华", posx=98, posz=51, script=15003},
	[MP_XINGSU] = {sceneId=16, name="施全", posx=87, posz=70, script=16007},
	[MP_DALI] = {sceneId=13, name="本观", posx=97, posz=67, script=13003},
	[MP_TIANSHAN] = {sceneId=17, name="兰剑", posx=88, posz=44, script=17002},
	[MP_XIAOYAO] = {sceneId=14, name="康广陵", posx=125, posz=142, script=14001},
	[MP_MANTUO] = {sceneId=1283, name="王和铃", posx=155, posz=114, script=893263}, --替代2022
	[MP_ERENGU] = {sceneId=504, name="岳老三", posx=122, posz=151, script=018039},
}

--目标NPC：接任务、交任务，都是这个
x891220_g_AcceptNpcInfo2	= {
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
	[MP_ERENGU] = {sceneId=504, name={[1]="山姥", [2]="山人木"}},
}

--任务归类
x891220_g_MissionKind = 9

--任务等级
x891220_g_MissionLevel = 60

--是否是精英任务
x891220_g_IfMissionElite = 0

--任务名
x891220_g_MissionName="#{TFYD_210729_91}"
x891220_g_MissionTarget=""
x891220_g_IsMissionOkFail=0
x891220_g_Custom = {}
x891220_g_ContinueInfo = ""
x891220_g_MissionComplete = ""

x891220_g_MoneyJZBonus = 50000
x891220_g_ExpBonus = 4500000

--MisDescEnd

x891220_g_AcceptInfo	= {
	[MP_SHAOLIN] = "#{TFYD_210729_92}",
	[MP_MINGJIAO] = "#{TFYD_210729_93}",
	[MP_GAIBANG] = "#{TFYD_210729_94}",
	[MP_WUDANG] = "#{TFYD_210729_95}",
	[MP_EMEI] = "#{TFYD_210729_96}",
	[MP_XINGSU] = "#{TFYD_210729_97}",
	[MP_DALI] = "#{TFYD_210729_98}",
	[MP_TIANSHAN] = "#{TFYD_210729_99}",
	[MP_XIAOYAO] = "#{TFYD_210729_100}",
	[MP_MANTUO] = "#{TFYD_220523_7}",
	[MP_ERENGU] = "#{ERMP_240620_09}",
}

x891220_g_CompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_102}", [2]="#{TFYD_210729_103}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_104}", [2]="#{TFYD_210729_105}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_106}", [2]="#{TFYD_210729_107}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_108}", [2]="#{TFYD_210729_109}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_110}", [2]="#{TFYD_210729_111}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_112}", [2]="#{TFYD_210729_113}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_114}", [2]="#{TFYD_210729_115}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_116}", [2]="#{TFYD_210729_117}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_118}", [2]="#{TFYD_210729_119}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_8}", [2]="#{TFYD_220523_9}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_10}", [2]="#{ERMP_240620_11}"}},
}
--雪顶寒梅
x891220_g_MissionItemID = 40005019
x891220_g_MissionItemNeed = 5

x891220_g_IsMissionOkFail			= 0	--0 任务完成标记
x891220_g_MissionParam_ItemNum		= 1	--1 已经获得的数量

--**********************************
--任务入口函数
--**********************************
function x891220_OnDefaultEvent( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x891220_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891220_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		if x891220_g_AcceptNpcInfo2[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891220_g_AcceptNpcInfo2[nCurMenPai].name[i] then
					--有无足够的雪顶寒梅
					local nItemNum	= GetItemCount( sceneId, selfId, x891220_g_MissionItemID )
					if nItemNum >= x891220_g_MissionItemNeed then
						BeginEvent(sceneId)
							AddText(sceneId,x891220_g_MissionName)
							if x891220_g_CompInfo[nCurMenPai] ~= nil then
								AddText(sceneId,x891220_g_CompInfo[nCurMenPai].tips[i])
							end
							AddMoneyJZBonus(sceneId,x891220_g_MoneyJZBonus)
						EndEvent()
						DispatchMissionContinueInfo(sceneId,selfId,targetId,x891220_g_ScriptId,x891220_g_MissionId)
					else
						BeginEvent(sceneId)
							AddText(sceneId,"#{TFYD_210729_101}")
						EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)
					end
					break
				end
			end
		end

	elseif x891220_CheckAccept( sceneId, selfId ) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId,x891220_g_MissionName)
			if x891220_g_AcceptInfo[nCurMenPai] ~= nil then
				AddText(sceneId,x891220_g_AcceptInfo[nCurMenPai])
			end
			AddMoneyJZBonus( sceneId,x891220_g_MoneyJZBonus)
		EndEvent()

		--在上一个完成任务NPC处
		if GetName(sceneId,targetId) == x891220_g_AcceptNpcInfo[nCurMenPai].name then
			--发送任务接受时显示的信息
			DispatchMissionInfo(sceneId,selfId,targetId,x891220_g_ScriptId,x891220_g_MissionId)
		end
		--在门派武道长老处
		if x891220_g_AcceptNpcInfo2[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891220_g_AcceptNpcInfo2[nCurMenPai].name[i] then
					--发送任务接受时显示的信息
					DispatchMissionInfo(sceneId,selfId,targetId,x891220_g_ScriptId,x891220_g_MissionId)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x891220_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x891220_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x891220_g_MissionId) > 0 then
		--在门派武道长老处
		if x891220_g_AcceptNpcInfo2[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891220_g_AcceptNpcInfo2[nCurMenPai].name[i] then
					AddNumText(sceneId, x891220_g_ScriptId,"#G"..x891220_g_MissionName,2,-1);
					break
				end
			end
		end
	--满足任务接收条件
	elseif x891220_CheckAccept(sceneId,selfId) > 0 then
		--在上一个完成任务NPC处
		if GetName(sceneId,targetId) == x891220_g_AcceptNpcInfo[nCurMenPai].name then
			AddNumText(sceneId,x891220_g_ScriptId,"#G"..x891220_g_MissionName,1,-1);
		end
		--在门派武道长老处
		if x891220_g_AcceptNpcInfo2[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891220_g_AcceptNpcInfo2[nCurMenPai].name[i] then
					AddNumText(sceneId,x891220_g_ScriptId,"#G"..x891220_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end
--**********************************
--接取任务
--**********************************
function x891220_OnAccept(sceneId,selfId)
	if x891220_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891220_g_MissionId, x891220_g_ScriptId, 1, 0, 1 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_04}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_90}",x891220_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--检测接受条件
--**********************************
function x891220_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891220_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891220_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x891220_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x891220_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891220_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x891220_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x891220_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local nItemNum	= GetItemCount( sceneId, selfId, x891220_g_MissionItemID )
	if nItemNum < x891220_g_MissionItemNeed then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891220_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x891220_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x891220_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x891220_g_ExpBonus)
		DelMission( sceneId, selfId, x891220_g_MissionId )
		MissionCom( sceneId, selfId, x891220_g_MissionId )
		--清理所有任务物品
		LuaFnDelAvailableItem( sceneId, selfId, x891220_g_MissionItemID, x891220_g_MissionItemNeed )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x891220_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x891220_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_27}",x891220_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(891221,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891220_OnKillObject( sceneId, selfId, objdataId, objId )
	--取得这个怪物死后拥有分配权的人数
	for i = 0, GetMonsterOwnerCount( sceneId, objId ) - 1 do
		--取得拥有分配权的人的objId
		local curOwner = GetMonsterOwnerID( sceneId, objId, i )
		--如果这个人拥有任务
		if IsHaveMission( sceneId, curOwner, x891220_g_MissionId ) > 0 and
		   GetScriptIDByMissionID( sceneId, curOwner, x891220_g_MissionId ) == x891220_g_ScriptId then
			if GetName( sceneId, objId ) == "雪原狼" then
				--雪顶寒梅足够5个了
				if GetItemCount( sceneId, curOwner, x891220_g_MissionItemID ) >= x891220_g_MissionItemNeed then
					return
				end
				
				AddMonsterDropItem( sceneId, objId, curOwner, x891220_g_MissionItemID )
			end
		end
	end
	
end

--**********************************
--进入区域事件
--**********************************
function x891220_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891220_OnItemChanged( sceneId, selfId, itemdataId )
	if itemdataId ~= x891220_g_MissionItemID then
		return
	end
	if IsHaveMission( sceneId, selfId, x891220_g_MissionId ) <= 0 then
		return
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x891220_g_MissionId )	
	--TFYD_210729_156	#H已获得%s0（%s1/5）。	
	--TFYD_210729_157	#H您已获得足够雪顶寒梅，还请返回门派武道长老处交还任务：%s0。
	local nItemNum	= GetItemCount( sceneId, selfId, itemdataId )
	if nItemNum >= x891220_g_MissionItemNeed then
		SetMissionByIndex( sceneId, selfId, misIndex, x891220_g_MissionParam_ItemNum,x891220_g_MissionItemNeed )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_157}",x891220_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	else
		SetMissionByIndex( sceneId, selfId, misIndex, x891220_g_MissionParam_ItemNum,nItemNum )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_156}",GetItemName(sceneId,itemdataId),tostring(nItemNum)))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end
