--恶人谷NPC
--云中鹤
--普通

x018038_g_ScriptId = 018038

--**********************************
--事件交互入口
--**********************************
function x018038_OnDefaultEvent( sceneId, selfId, targetId )
	local nMenPai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
	if nMenPai == 11 then
		AddText(sceneId, "#{ERMP_240620_04}")
		AddNumText(sceneId, x018038_g_ScriptId, "#{ERMP_240620_131}", 12, 0)
	else
		AddText(sceneId, "#{ERMP_240620_26}")
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x018038_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nIndex = GetNumText()
	local nMenPai = GetMenPai(sceneId, selfId)
	if nIndex == 0 then
		if HaveSkill(sceneId, selfId, 111) then
			x018038_MsgBox(sceneId, selfId, targetId, "你不是已经学会了吗？")
			return
		end
		if nMenPai ~= 11 then
			x018038_MsgBox(sceneId, selfId, targetId, "#{XMPSH_220628_4}")
			return
		end
		if GetMoney(sceneId, selfId) + GetMoneyJZ(sceneId, selfId) < 100 then
			x018038_MsgBox(sceneId, selfId, targetId, "   少侠，所携带金钱不足，无法学习本门派轻功。")
			return
		end
		LuaFnCostMoneyWithPriority(sceneId, selfId, 100)
		AddSkill(sceneId, selfId, 111)
		DelSkill(sceneId, selfId, 34)
		x018038_MsgBox(sceneId, selfId, targetId, "    少侠已成功学会#Y恶人谷轻功#W，恭喜少侠！")
	end
end

--**********************************
--消息框
--**********************************
function x018038_MsgBox( sceneId, selfId, targetId, Msg )
	BeginEvent(sceneId)
	AddText(sceneId, Msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
