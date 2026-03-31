--MisDescBegin
--脚本号
x891222_g_ScriptId = 891222

--完成任务NPC属性
-- x891222_g_Position_X=160  --替代
-- x891222_g_Position_Z=157 --替代
-- x891222_g_SceneID=2
-- x891222_g_AccomplishNPC_Name="赵天师"

--任务号
x891222_g_MissionId = 2025

--前置任务
x891222_g_PreMissionId = 2024
x891222_g_PreMissionName = "#{TFYD_210729_163}"

--目标NPC：接任务、交任务，都是这个
x891222_g_AcceptNpcInfo	= {
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
x891222_g_MissionKind = 9

--任务等级
x891222_g_MissionLevel = 60

--是否是精英任务
x891222_g_IfMissionElite = 0

--任务名
x891222_g_MissionName="#{TFYD_210729_308}"
x891222_g_MissionTarget=""
x891222_g_IsMissionOkFail=0
x891222_g_Custom = {}
x891222_g_ContinueInfo = ""
x891222_g_MissionComplete = ""

x891222_g_MoneyJZBonus = 60000
x891222_g_ExpBonus = 560000
x891222_g_ItemBouns = 38002405

--MisDescEnd
x891222_g_AcceptInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_309}", [2]="#{TFYD_210729_310}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_311}", [2]="#{TFYD_210729_312}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_313}", [2]="#{TFYD_210729_314}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_315}", [2]="#{TFYD_210729_316}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_317}", [2]="#{TFYD_210729_318}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_319}", [2]="#{TFYD_210729_320}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_321}", [2]="#{TFYD_210729_322}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_323}", [2]="#{TFYD_210729_324}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_325}", [2]="#{TFYD_210729_326}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_30}", [2]="#{TFYD_220523_31}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_30}", [2]="#{ERMP_240620_31}"}},
}

x891222_g_NotCompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_327}", [2]="#{TFYD_210729_328}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_329}", [2]="#{TFYD_210729_330}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_331}", [2]="#{TFYD_210729_332}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_333}", [2]="#{TFYD_210729_334}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_335}", [2]="#{TFYD_210729_336}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_337}", [2]="#{TFYD_210729_338}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_339}", [2]="#{TFYD_210729_340}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_341}", [2]="#{TFYD_210729_342}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_343}", [2]="#{TFYD_210729_344}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_34}", [2]="#{TFYD_220523_35}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_34}", [2]="#{ERMP_240620_35}"}},
}

x891222_g_CompInfo	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_345}", [2]="#{TFYD_210729_346}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_347}", [2]="#{TFYD_210729_348}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_349}", [2]="#{TFYD_210729_350}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_351}", [2]="#{TFYD_210729_352}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_353}", [2]="#{TFYD_210729_354}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_355}", [2]="#{TFYD_210729_356}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_357}", [2]="#{TFYD_210729_358}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_359}", [2]="#{TFYD_210729_360}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_361}", [2]="#{TFYD_210729_362}"}},
	[MP_MANTUO] = {tips={[1]="#{TFYD_220523_36}", [2]="#{TFYD_220523_37}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_36}", [2]="#{ERMP_240620_37}"}},
}
--**********************************
--任务入口函数
--**********************************
function x891222_OnDefaultEvent( sceneId, selfId, targetId,numText)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if numText ~= nil and numText == 100 then
		--流派浏览
		--在门派武道长老处
		if x891222_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891222_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--		local menpai = Get_XParam_INT(0);
					--		local secttype = Get_XParam_INT(1);
					--		local targetobjId = Get_XParam_INT(2);
					BeginUICommand(sceneId)
						UICommand_AddInt(sceneId, nCurMenPai);
						UICommand_AddInt(sceneId, i);
						UICommand_AddInt(sceneId, targetId);
					EndUICommand(sceneId)
					DispatchUICommand(sceneId,selfId, 20210801)
					break
				end
			end
		end
		return
	end
	if IsMissionHaveDone(sceneId,selfId,x891222_g_MissionId) > 0 then
		return
	elseif IsHaveMission(sceneId,selfId,x891222_g_MissionId) > 0 then
		--提交任务时的说明信息
		--在门派武道长老处
		if x891222_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891222_g_AcceptNpcInfo[nCurMenPai].name[i] then
					local nSectType = LuaFnGetSectType(sceneId,selfId)
					if nSectType == -1 then
						BeginEvent(sceneId)
							AddText(sceneId,x891222_g_NotCompInfo[nCurMenPai].tips[i])
							AddNumText(sceneId, x891222_g_ScriptId,"#{TFYD_210729_450}",6,100);
						EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)
					else
						BeginEvent(sceneId)
							AddText(sceneId,x891222_g_MissionName)
							if x891222_g_CompInfo[nCurMenPai] ~= nil then
								AddText(sceneId,x891222_g_CompInfo[nCurMenPai].tips[i])
							end
							AddMoneyJZBonus(sceneId,x891222_g_MoneyJZBonus)
						EndEvent()
						DispatchMissionContinueInfo(sceneId,selfId,targetId,x891222_g_ScriptId,x891222_g_MissionId)
					end
					break
				end
			end
		end

	elseif x891222_CheckAccept( sceneId, selfId ) > 0 then
		--在门派武道长老处
		if x891222_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891222_g_AcceptNpcInfo[nCurMenPai].name[i] then
					--发送任务接受时显示的信息
					BeginEvent(sceneId)
						AddText(sceneId,x891222_g_MissionName)
						if x891222_g_AcceptInfo[nCurMenPai] ~= nil then
							AddText(sceneId,x891222_g_AcceptInfo[nCurMenPai].tips[i])
						end
						AddMoneyJZBonus( sceneId,x891222_g_MoneyJZBonus)
					EndEvent()
					DispatchMissionInfo(sceneId,selfId,targetId,x891222_g_ScriptId,x891222_g_MissionId)
					break
				end
			end
		end
	end
end

--**********************************
--列举事件
--**********************************
function x891222_OnEnumerate( sceneId, selfId, targetId )
	local nCurMenPai = GetMenPai(sceneId,selfId)
	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x891222_g_MissionId) > 0 then
		return 
	--如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x891222_g_MissionId) > 0 then
		--在门派武道长老处
		if x891222_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891222_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId, x891222_g_ScriptId,"#G"..x891222_g_MissionName,2,-1);
					break
				end
			end
		end
	--满足任务接收条件
	elseif x891222_CheckAccept(sceneId,selfId) > 0 then
		--在门派武道长老处
		if x891222_g_AcceptNpcInfo[nCurMenPai] ~= nil then
			for i = 1,2 do
				if GetName(sceneId,targetId) == x891222_g_AcceptNpcInfo[nCurMenPai].name[i] then
					AddNumText(sceneId,x891222_g_ScriptId,"#G"..x891222_g_MissionName,1,-1);
					break
				end
			end
		end
	end
end
--**********************************
--接取任务
--**********************************
function x891222_OnAccept(sceneId,selfId,targetId)
	if x891222_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	--加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x891222_g_MissionId, x891222_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_04}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_90}",x891222_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--刷新一次，没选就是浏览
	x891222_OnDefaultEvent( sceneId, selfId, targetId )
end

--**********************************
--检测接受条件
--**********************************
function x891222_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x891222_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x891222_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x891222_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end

--**********************************
--放弃
--**********************************
function x891222_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x891222_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x891222_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x891222_g_MissionId )
	if bRet ~= 1 then
		return 0
	end
	--检测是否加入了什么流派
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType == -1 then
		return 0;
	end
	--背包是否够装归元令
	BeginAddItem(sceneId)
	AddItem( sceneId, x891222_g_ItemBouns, 1 )
	if EndAddItem(sceneId,selfId) <= 0 then
		return 0
	end
	return 1
end

--**********************************
--提交
--**********************************
function x891222_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x891222_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		--添加任务奖励
		AddMoneyJZ(sceneId,selfId, x891222_g_MoneyJZBonus );
		LuaFnAddExp( sceneId, selfId, x891222_g_ExpBonus)
		DelMission( sceneId, selfId, x891222_g_MissionId )
		MissionCom( sceneId, selfId, x891222_g_MissionId )
		--
		BeginAddItem(sceneId)
		AddItem( sceneId, x891222_g_ItemBouns, 1 )
		EndAddItem(sceneId,selfId)
		AddItemListToHuman(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_25}",x891222_g_MoneyJZBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_26}",x891222_g_ExpBonus))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{TFYD_210729_27}",x891222_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务
		CallScriptFunction(891223,"OnDefaultEvent",sceneId,selfId,targetId)
	else
		BeginEvent(sceneId)
			AddText(sceneId, "#{TFYD_210729_375}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		BeginEvent(sceneId)
			AddText( sceneId, "#{TFYD_210729_374}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x891222_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--进入区域事件
--**********************************
function x891222_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x891222_OnItemChanged( sceneId, selfId, itemdataId )

end
