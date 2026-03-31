--MisDescBegin
--脚本号
x891221_g_ScriptId = 891221

--完成任务NPC属性
-- x891221_g_Position_X=160  --替代
-- x891221_g_Position_Z=157 --替代
-- x891221_g_SceneID=2
-- x891221_g_AccomplishNPC_Name="赵天师"

--任务号
x891221_g_MissionId = 2024

--前置任务
x891221_g_PreMissionId = 2023
x891221_g_PreMissionName = "#{TFYD_210729_91}"

--目标NPC：接任务、交任务，都是这个
x891221_g_AcceptNpcInfo	= {
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
x891221_g_MissionKind = 9

--任务等级
x891221_g_MissionLevel = 60

--是否是精英任务
x891221_g_IfMissionElite = 0

--任务名
x891221_g_MissionName="#{TFYD_210729_163}"
x891221_g_MissionTarget=""
x891221_g_IsMissionOkFail=0
x891221_g_Custom = {}
x891221_g_ContinueInfo = ""
x891221_g_MissionComplete = ""

x891221_g_MoneyJZBonus = 16000
x891221_g_ExpBonus = 135000

--MisDescEnd

x891221_g_AcceptInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_164}", [2]="#{TFYD_210729_165}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_166}", [2]="#{TFYD_210729_167}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_168}", [2]="#{TFYD_210729_169}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_170}", [2]="#{TFYD_210729_171}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_172}", [2]="#{TFYD_210729_173}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_174}", [2]="#{TFYD_210729_175}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_176}", [2]="#{TFYD_210729_177}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_178}", [2]="#{TFYD_210729_179}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_180}", [2]="#{TFYD_210729_181}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_12}", [2]="#{TFYD_220523_13}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_12}", [2]="#{ERMP_240620_13}"}},
}

x891221_g_NotCompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_182}", [2]="#{TFYD_210729_183}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_184}", [2]="#{TFYD_210729_185}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_186}", [2]="#{TFYD_210729_187}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_188}", [2]="#{TFYD_210729_189}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_190}", [2]="#{TFYD_210729_191}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_192}", [2]="#{TFYD_210729_193}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_194}", [2]="#{TFYD_210729_195}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_196}", [2]="#{TFYD_210729_197}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_198}", [2]="#{TFYD_210729_199}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_14}", [2]="#{TFYD_220523_15}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_14}", [2]="#{ERMP_240620_15}"}},
}

x891221_g_CompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_200}", [2]="#{TFYD_210729_201}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_202}", [2]="#{TFYD_210729_203}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_204}", [2]="#{TFYD_210729_205}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_206}", [2]="#{TFYD_210729_207}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_208}", [2]="#{TFYD_210729_209}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_210}", [2]="#{TFYD_210729_211}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_212}", [2]="#{TFYD_210729_213}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_214}", [2]="#{TFYD_210729_215}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_216}", [2]="#{TFYD_210729_217}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_16}", [2]="#{TFYD_220523_17}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_16}", [2]="#{ERMP_240620_17}"}},
}

--梅花熏香
x891221_g_MissionItemID = 40005020
--**********************************
--任务入口函数
--**********************************
function x891221_OnDefaultEvent( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if IsMissionHaveDone(sceneId,selfId,x891221_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891221_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		if x891221_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891221_g_AcceptNpcInfo[nCurMenPai].name[i] then
					local misIndex = GetMissionIndexByID( sceneId, selfId, x891221_g_MissionId )	
					if GetMissionParam( sceneId, selfId, misIndex, x891221_g_IsMissionOkFail ) ~= 1 then
						BeginEvent(sceneId)
							AddText(sceneId,x891221_g_NotCompInfo[nCurMenPai].tips[i])
						EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)
					else
						BeginEvent(sceneId)
							AddText(sceneId,x891221_g_MissionName)
							if x891221_g_CompInfo[nCurMenPai] ~= nil then
								AddText(sceneId,x891221_g_CompInfo[nCurMenPai].tips[i])
							end
							AddMoneyJZBonus(sceneId,x891221_g_MoneyJZBonus)
						EndEvent()
						DispatchMissionContinueInfo(sceneId,selfId,targetId,x891221_g_ScriptId,x891221_g_MissionId)
					end
					break
				end
			end
		end

	elseif x891221_CheckAccept( sceneId, selfId ) > 0 then
		--在门派武道长老处
		if x891221_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891221_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--发送任务接受时显示的信息
					BeginEvent(sceneId)
						AddText(sceneId,x891221_g_MissionName)
						if x891221_g_AcceptInfo[nCurMenPai] ~= nil then
							AddText(sceneId,x891221_g_AcceptInfo[nCurMenPai].tips[i])
						end
						AddMoneyJZBonus( sceneId,x891221_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionInfo(sceneId,selfId,targetId,x891221_g_ScriptId,x891221_g_MissionId)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x891221_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x891221_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x891221_g_MissionId) > 0 then
		--在门派武道长老处
		if x891221_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891221_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId, x891221_g_ScriptId,"#G"..x891221_g_MissionName,2,-1);
					break
				end
			end
		end
	--满足任务接收条件
	elseif x891221_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x891221_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891221_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId,x891221_g_ScriptId,"#G"..x891221_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end
--**********************************
--接取任务
--**********************************
function x891221_OnAccept(sceneId,selfId)
	if x891221_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--给特殊任务道具
	BeginAddItem(sceneId)
	AddItem( sceneId,x891221_g_MissionItemID, 1 )
	ret = EndAddItem(sceneId,selfId)
	if ret > 0 then
		AddItemListToHuman(sceneId,selfId)
	else
		--背包不足
		BeginEvent(sceneId)
			AddText(sceneId,"#{TFYD_210729_160}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
						
		BeginEvent(sceneId)
			AddText(sceneId,"#{TFYD_210729_161}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891221_g_MissionId, x891221_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_04}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_90}",x891221_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--检测接受条件
--**********************************
function x891221_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891221_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891221_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x891221_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x891221_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891221_g_MissionId )
	--删除任务物品
	LuaFnDelAvailableItem( sceneId, selfId, x891221_g_MissionItemID, 1 )
end

--**********************************
--检测是否可以提交
--**********************************
function x891221_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x891221_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	local misIndex = GetMissionIndexByID( sceneId, selfId, x891221_g_MissionId )	
	if GetMissionParam( sceneId, selfId, misIndex, x891221_g_IsMissionOkFail ) ~= 1 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891221_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x891221_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x891221_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x891221_g_ExpBonus)
		DelMission( sceneId, selfId, x891221_g_MissionId )
		MissionCom( sceneId, selfId, x891221_g_MissionId )
		--删除任务物品
		LuaFnDelAvailableItem( sceneId, selfId, x891221_g_MissionItemID, 1 )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x891221_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x891221_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_27}",x891221_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(891222,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--道具使用完成的回调
--**********************************
function x891221_OnImpactFadeOut(sceneId,selfId,impactId)
	if IsHaveMission(sceneId,selfId,x891221_g_MissionId) <= 0 then
		return
	end
	
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x891221_g_IsMissionOkFail)
	SetMissionByIndex( sceneId, selfId, nMisIndex, x891221_g_IsMissionOkFail,1 )
	
	BeginEvent(sceneId)
		AddText(sceneId, "#{TFYD_210729_541}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891221_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--进入区域事件
--**********************************
function x891221_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891221_OnItemChanged( sceneId, selfId, itemdataId )

end