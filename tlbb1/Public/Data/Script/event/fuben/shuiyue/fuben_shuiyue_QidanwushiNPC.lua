--水月山庄 契丹武士耶律鸿右NPC
--脚本号
x891074_g_ScriptId	= 891074
x891074_g_FuBenControlScript = 891070
--**********************************
--入口函数
--**********************************
function x891074_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText( sceneId,"#{SYSZ_20210203_63}")
		AddNumText(sceneId,x891074_g_ScriptId,"#{SYSZ_20210203_26}",10,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x891074_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nearteammembercount = GetNearTeamCount(sceneId,selfId)
	if GetLevel(sceneId,selfId) < 80 then
		x891074_NotifyTip(sceneId,selfId,"#{SYSZ_20210203_27}")
		return
	end
	if LuaFnIsTeamLeader(sceneId,selfId) == 0 then
		x891074_NotifyTip(sceneId,selfId,"#{SYSZ_20210203_32}")
		x891074_MsgBox(sceneId,selfId,targetId,"#{SYSZ_20210203_33}")
		return
	end
	if GetTeamId(sceneId,selfId) < 0 then
		x891074_NotifyTip(sceneId,selfId,"#{SYSZ_20210203_28}")
		x891074_MsgBox(sceneId,selfId,targetId,"#{SYSZ_20210203_29}")
		return
	end
	if GetTeamSize(sceneId,selfId) ~= nearteammembercount then
		x891074_MsgBox(sceneId,selfId,targetId,"#{SYSZ_20210203_34}")
		return
	end
	CallScriptFunction(x891074_g_FuBenControlScript,"CreateMonsterData",sceneId,"QiDanWuShi_Boss")
	LuaFnDeleteMonster(sceneId,targetId)
	--发送talk
	LuaFnNpcTalk(sceneId,113)
	--发送一个全屏提示
	CallScriptFunction(x891074_g_FuBenControlScript,"NotifyTips",sceneId,"#{SYSZ_20210203_83}")
	--创建动态阻挡
	for i = 1,10 do
		CallScriptFunction(x891071_g_FuBenControlScript,"CreateDynamicBlock",sceneId,i)
	end
end
--**********************************
--屏幕中央提示
--**********************************
function x891074_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话框提示
--**********************************
function x891074_MsgBox( sceneId, selfId,targetId,Msg )
	BeginEvent(sceneId)
		AddText(sceneId,Msg)
	EndEvent()
	DispatchEventList(sceneId, selfId, targetId)
end

