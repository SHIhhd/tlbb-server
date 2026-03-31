--曼陀山庄拜师人
--王素商

x893262_g_scriptId = 893262
x893262_g_eventList={222900,808004}
--**********************************
--事件交互入口
--**********************************
function x893262_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{MPSD_220622_04}")
		local mp = GetMenPai(sceneId, selfId)
		if mp == 9 then 
			AddNumText(sceneId, x893262_g_scriptId, "#{MPXR_220623_45}",6,0)
		end
		AddNumText(sceneId, x893262_g_scriptId, "#{MPXR_220623_46}",8,1)
		AddNumText(sceneId, x893262_g_scriptId, "#{MPXR_220623_47}",8,6)		--指路到技能学习人
		for i, eventId in x893262_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x893262_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText()==0	then

		local nCurMenPai = GetMenPai(sceneId, selfId)
		if nCurMenPai == MP_MANTUO then
			return
		end
		
		if nCurMenPai ~= 9 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{MPXR_220623_27}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		BeginEvent(sceneId)
			AddText(sceneId, "#{MPSD_220622_05}")
			AddNumText(sceneId, x893262_g_scriptId, "#{MPXR_220623_49}",6,3)
			AddNumText(sceneId, x893262_g_scriptId, "#{MPXR_220623_50}",8,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		 
		return
	end
	
	if GetNumText()==4	then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
	
	if GetNumText()==3	then
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{MPXR_220623_29}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif GetLevel( sceneId, selfId ) < 10 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{MPXR_220623_28}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			local nCurMenPai = GetMenPai(sceneId, selfId)
			if nCurMenPai == MP_MANTUO then
				return
			--返回值为9表示无门派
			elseif nCurMenPai==9	then
				LuaFnJoinMenpai(sceneId, selfId, targetId, MP_MANTUO)

				-- 设置初始的Npc关系值
				CallScriptFunction( 200099, "InitRelation", sceneId, selfId )

				-- 把相关的心法设置为10级别  64,65,66
				LuaFnSetXinFaLevel(sceneId,selfId,64,10)
				LuaFnSetXinFaLevel(sceneId,selfId,65,10)
				LuaFnSetXinFaLevel(sceneId,selfId,66,10)

				BeginEvent(sceneId)
	  				AddText(sceneId,"#{MPXR_220623_32}");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,selfId)
	  			--门派时装
	  			if TryRecieveItem( sceneId, selfId, 10124791, 1 ) >= 0 then
					x893262_MsgBox( sceneId, selfId, "#{MPXR_220623_35}" )				
				end
				--门派初级武器
	  			if TryRecieveItem( sceneId, selfId, 10106100, 1 ) >= 0 then
					x893262_MsgBox( sceneId, selfId, "#{MPXR_220623_34}" )				
				end
				
				--给玩家发信,告诉他到哪里打怪,怎样赚钱
				LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LevelMail_menpai_10}" )
				--LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{OBJ_mingjiao_0001}" )
				
				--门派奖励召集令
				for i=1, 20 do
					TryRecieveItem( sceneId, selfId, 30501001, 1 )
				end
				x893262_MsgBox( sceneId, selfId, "得到20枚门派召集令。" )
				--你已经加入曼陀山庄！	
				LuaFnMsg2Player( sceneId, selfId,"#{MPXR_220623_32}",MSG2PLAYER_PARA)
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 161, 0)
				--安排任务找任务发布人
				CallScriptFunction( 893310, "OnDefaultEvent",sceneId, selfId, targetId )
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{MPXR_220623_27}")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
		end
	elseif	GetNumText()==1	then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPXR_220623_30}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		for i, findId in x893262_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_MANTUO )
				return
			end
		end
	end
	--指路
	if GetNumText()==6 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{MPJN_090728_10}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, 155, 114, "王和铃" )
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893262_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893262_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x893262_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
--for i, findId in x893262_g_eventList do
--	if missionScriptId == findId then
--		UpdateEventList( sceneId, selfId, targetId )
--		return
--	end
--end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x893262_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893262_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x893262_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x893262_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x893262_OnDie( sceneId, selfId, killerId )
end

--**********************************
--消息提示
--**********************************
function x893262_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
