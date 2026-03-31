--学习技能
--九大门派技能传授

--MisDescBegin
--脚本号
x210209_g_ScriptId = 210209

--任务号
x210209_g_MissionId = 449
--补充内容学习技能这块的内容补充
x210209_g_MissionData = 1405
--任务归类
x210209_g_MissionKind = 13

--任务道具编号
x210209_g_ItemId = 40002108

--任务等级
x210209_g_MissionLevel = 1

--是否是精英任务
x210209_g_IfMissionElite = 0

--任务名
x210209_g_MissionName="学习技能"
x210209_g_MissionInfo="  去找九大门派的弟子学习一项技能"
x210209_g_MissionTarget="学习技能。"
x210209_g_MissionComplete="  既然你拿来了推荐信，那我就教给你一项新手技能，要好好学习，多多练习才可以。"
x210209_g_Name_0="赵天师"

x210209_g_XinShouJiNeng = {
{name="慧易",			skill="学习外功护体"},
{name="石宝",			skill="学习奋力打击"},
{name="简宁",			skill="学习要害攻击"},
{name="张获",			skill="学习内劲攻击"},
{name="路三娘",		skill="学习初级治疗"},
{name="海风子",		skill="学习内功护体"},
{name="破贪",			skill="学习破绽攻击"},
{name="程青霜",		skill="学习初级隐遁"},
{name="澹台子羽",	skill="学习燃烧陷阱"},
{name="王溪云",	  skill="学习命魂护体"},
}
--我想加入门派
x210209_g_JiaRuMenPai = {
{name="慧易",	Numtext="#{XSRW_200909_13}",	Desc="#{XSRW_200909_14}"},
{name="石宝",	Numtext="#{XSRW_200909_01}",	Desc="#{XSRW_200909_02}"},
{name="简宁",	Numtext="#{XSRW_200909_16}",	Desc="#{XSRW_200909_17}"},
{name="张获",	Numtext="#{XSRW_200909_25}",	Desc="#{XSRW_200909_26}"},
{name="路三娘",	Numtext="#{XSRW_200909_19}",	Desc="#{XSRW_200909_20}"},
{name="海风子",	Numtext="#{XSRW_200909_10}",	Desc="#{XSRW_200909_11}"},
{name="破贪",	Numtext="#{XSRW_200909_22}",	Desc="#{XSRW_200909_23}"},
{name="程青霜",	Numtext="#{XSRW_200909_04}",	Desc="#{XSRW_200909_05}"},
{name="澹台子羽",	Numtext="#{XSRW_200909_07}",	Desc="#{XSRW_200909_08}"},
{name="王溪云",	Numtext="#{MPXR_220623_07}",	Desc="#{MPXR_220623_36}"},
}
-->>end
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x210209_OnDefaultEvent( sceneId, selfId, targetId )
	local nNumText = GetNumText()
	if nNumText >= 101 and nNumText <= 110 then
		BeginEvent(sceneId);
			AddText(sceneId,x210209_g_JiaRuMenPai[nNumText - 100].Desc)
		EndEvent()
		DispatchEventList(sceneId, selfId, targetId);
		return
	end
	if GetName(sceneId,targetId) ~= x210209_g_Name_0 then
		x210209_OnContinue( sceneId, selfId, targetId )
	end
end

--**********************************
--列举事件
--**********************************
function x210209_OnEnumerate( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId,selfId)
	local nLevel = GetLevel(sceneId,selfId)
	if GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[1].name then
		if	HaveSkill(  sceneId, selfId, 241)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[1].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[1].Numtext,6,101);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[2].name	 then
		if	HaveSkill(  sceneId, selfId, 242)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[2].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[2].Numtext,6,102);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[3].name	 then
		if	HaveSkill(  sceneId, selfId, 243)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[3].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[3].Numtext,6,103);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[4].name	then
		if	HaveSkill(  sceneId, selfId, 244)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[4].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[4].Numtext,6,104);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[5].name then
		if	HaveSkill(  sceneId, selfId, 245)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[5].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[5].Numtext,6,105);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[6].name then
		if	HaveSkill(  sceneId, selfId, 246)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[6].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[6].Numtext,6,106);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[7].name then
		if	HaveSkill(  sceneId, selfId, 247)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[7].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[7].Numtext,6,107);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[8].name then
		if	HaveSkill(  sceneId, selfId, 248)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[8].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[8].Numtext,6,108);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[9].name then
		if	HaveSkill(  sceneId, selfId, 249)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[9].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[9].Numtext,6,109);
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[10].name then
		if	HaveSkill(  sceneId, selfId, 277)<0	then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_XinShouJiNeng[10].skill,6,-1);
		end
		if nMenPai == 9 and nLevel >= 10 then
			AddNumText(sceneId, x210209_g_ScriptId,x210209_g_JiaRuMenPai[10].Numtext,6,110);
		end
	end
	
	if GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[1].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"少林派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"少林派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"少林派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"少林古刹",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[2].name	 then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"明教来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"明教战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"明教生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"大光明殿",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[3].name	 then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"丐帮来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"丐帮战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"丐帮生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"丐帮总舵",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[4].name	then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"武当派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"武当派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"武当派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"武当仙风",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[5].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"峨嵋派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"峨嵋派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"峨嵋派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"峨嵋天下秀",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[6].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"星宿派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"星宿派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"星宿派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"星宿春秋",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[7].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"天龙派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"天龙派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"天龙派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"天龙风情",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[8].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"天山派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"天山派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"天山派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"缥缈天山",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[9].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"逍遥派来由",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"逍遥派战斗特色",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"逍遥派生活特色",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"淩波逍遥",11,13);
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[10].name then
		--添加门派介绍
		AddNumText(sceneId, x210209_g_ScriptId,"#{MPXR_220623_41}",11,10);
		AddNumText(sceneId, x210209_g_ScriptId,"#{MPXR_220623_10}",11,11);
		AddNumText(sceneId, x210209_g_ScriptId,"#{MPXR_220623_11}",11,12);
		AddNumText(sceneId, x210209_g_ScriptId,"#{MPXR_220623_12}",11,13);
	end

end

--**********************************
--检测接受条件
--**********************************
function x210209_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x210209_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	AddMission( sceneId,selfId, x210209_g_MissionId, x210209_g_ScriptId, 0, 0, 0 )
	Msg2Player(  sceneId, selfId,"#Y接受任务：学习技能",MSG2PLAYER_PARA )
end

--**********************************
--放弃
--**********************************
function x210209_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x210209_g_MissionId )
--	CallScriptFunction( SCENE_SCRIPT_ID, "DelSignpost", sceneId, selfId, sceneId, g_SignPost.tip )
end

--**********************************
--继续
--**********************************
function x210209_OnContinue( sceneId, selfId, targetId )
    --提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,"#{XSRW_100111_106}")
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x210209_g_ScriptId,x210209_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x210209_CheckSubmit( sceneId, selfId, selectRadioId )
	if	HaveItemInBag (  sceneId, selfId, x210209_g_ItemId)==1	then
		return 1
	else
		return 0
	end
end

--**********************************
--提交
--**********************************
function x210209_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	local strText = ""
	if  GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[1].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 241) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 241)
		BeginEvent(sceneId)
			strText = "你学到新的技能：少林新手技能：外功护体"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[2].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 242) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 242)
		BeginEvent(sceneId)
			strText = "你学到新的技能：明教新手技能：奋力打击"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[3].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 243) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 243)
		BeginEvent(sceneId)
			strText = "你学到新的技能：丐帮新手技能：要害攻击"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[4].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 244) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 244)
		BeginEvent(sceneId)
			strText = "你学到新的技能：武当新手技能：内劲攻击"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		if IsHaveMission(sceneId,selfId,x210209_g_MissionData) > 0 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x210209_g_MissionData)
			local param = GetMissionParam(sceneId,selfId,misIndex,0)
			local param1 = GetMissionParam(sceneId,selfId,misIndex,1)
			local param2 = GetMissionParam(sceneId,selfId,misIndex,2)
			if param == 0 then
				if param1 == 0 then
					SetMissionByIndex(sceneId,selfId,misIndex,1,1) --设置任务完成
					BeginEvent(sceneId)
						strText = "在武当接引道长处学习内劲攻击：1/1"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				end
			end
			--设置任务完成情况 因为走到这里的情况下，已经学习完毕了。
			if param2 > 0 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1) --设置任务完成
			end
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[5].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 245) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 245)
		BeginEvent(sceneId)
			strText = "你学到新的技能：峨嵋新手技能：初级治疗"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[6].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 246) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 246)
		BeginEvent(sceneId)
			strText = "你学到新的技能：星宿新手技能：内功护体"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[7].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 247) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 247)
		BeginEvent(sceneId)
			strText = "你学到新的技能：天龙派新手技能：破绽攻击"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[8].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 248) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 248)
		BeginEvent(sceneId)
			strText = "你学到新的技能：天山新手技能：初级隐遁"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		if IsHaveMission(sceneId,selfId,x210209_g_MissionData) > 0 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x210209_g_MissionData)
			local param = GetMissionParam(sceneId,selfId,misIndex,0)
			local param1 = GetMissionParam(sceneId,selfId,misIndex,1)
			local param2 = GetMissionParam(sceneId,selfId,misIndex,2)
			if param == 0 then
				if param2 == 0 then
					SetMissionByIndex(sceneId,selfId,misIndex,2,1) --设置任务完成
					BeginEvent(sceneId)
						strText = "在天山接引使处学习初级隐遁：1/1"
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
				end
			end
			--设置任务完成情况 因为走到这里的情况下，已经学习完毕了。
			if param1 > 0 then
				SetMissionByIndex(sceneId,selfId,misIndex,0,1) --设置任务完成
			end
		end
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[9].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 249) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 249)
		BeginEvent(sceneId)
			strText = "你学到新的技能：逍遥新手技能：燃烧陷阱"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	elseif	GetName(sceneId,targetId) == x210209_g_XinShouJiNeng[10].name	then
		--判定玩家是不是已经学会了这个技能，会了就不让在学习了
		if  HaveSkill(sceneId, selfId, 277) > 0  then
			return
		end
		AddSkill(  sceneId, selfId, 277)
		BeginEvent(sceneId)
			AddText(sceneId,"#{MPXR_220623_38}");
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
	--学习成功播放特效
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

--**********************************
--杀死怪物或玩家
--**********************************
function x210209_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x210209_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x210209_OnItemChanged( sceneId, selfId, itemdataId )
end
