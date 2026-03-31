--王溪云

--脚本号
x893309_g_scriptId = 893309


--所拥有的事件ID列表
x893309_g_eventList={210209,210287}	
--210209 初级技能指导
--210287 引荐加入门派

--**********************************
--事件列表
--**********************************
function x893309_UpdateEventList( sceneId, selfId,targetId )
	local  Menpai=LuaFnGetMenPai(sceneId,selfId)
	BeginEvent(sceneId)	
	if Menpai == MP_WUMENPAI then
		AddText(sceneId,"#{MPXR_220623_01}")
	elseif Menpai == MP_MANTUO then
		AddText(sceneId,ScriptGlobal_Format("#{MPXR_220623_02}",GetName(sceneId,selfId)))
	else
		AddText(sceneId,"#{MPXR_220623_05}")
	end
	
	if	GetLevel( sceneId, selfId)<=10	then
		AddNumText(sceneId,x893309_g_scriptId,"#{MPXR_220623_09}",9,0)
	end
--	misIndex = GetMissionIndexByID(sceneId,selfId,1060)			--得到任务的序列号
--	if	IsHaveMission(sceneId,selfId,1060) > 0	 then
--		if	GetMissionParam( sceneId, selfId, misIndex,0) < 1  and	 GetMissionParam( sceneId, selfId, misIndex,2) == 2   then
--			AddNumText(sceneId,x893309_g_scriptId,"这是我师兄给你的信",4,1)
--		end
--	end
	for i, eventId in x893309_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x893309_OnDefaultEvent( sceneId, selfId,targetId )
	x893309_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x893309_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if IsHaveMission(sceneId,selfId,4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else	
			BeginEvent(sceneId)
	  			AddText(sceneId,"#{MPXR_220623_20}");
	  		EndEvent(sceneId)
	  		DispatchMissionTips(sceneId,selfId)
			
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, SCENE_MANTUOSHANZHUANG,137,152)
		end
--	elseif	GetNumText()==1	then
--		misIndex = GetMissionIndexByID(sceneId,selfId,1060)			--得到任务的序列号
--		DelItem (  sceneId, selfId, 40002115, 1)	
--		SetMissionByIndex( sceneId, selfId, misIndex, 0, 1)
--		BeginEvent(sceneId)
--			AddText(sceneId,"请回去告诉慧方师兄，他的信我已经收到了，谢谢你")
--		EndEvent( )
--		DispatchEventList(sceneId,selfId,targetId)
--		BeginEvent(sceneId)
--			AddText(sceneId,"任务完成！")
--		EndEvent( )
--		DispatchMissionTips(sceneId,selfId)
--
	elseif   GetNumText()==10	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{MPXR_220623_30}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==11	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{OBJ_mantuo_0002}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==12	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{MPXR_220623_48}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==13	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{MPXR_220623_43}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

	else
		for i, findId in x893309_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x893309_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893309_g_eventList do
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
function x893309_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x893309_g_eventList do
		if missionScriptId == findId then
			x893309_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x893309_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x893309_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x893309_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x893309_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x893309_OnDie( sceneId, selfId, killerId )
end
