--曼陀祈福技能
x893297_g_ScriptId = 893297
x893297_g_ZhuFuTips = {
	"#{MPSD_220622_125}",
	"#{MPSD_220622_126}",
	"#{MPSD_220622_127}",
	"#{MPSD_220622_128}",
	"#{MPSD_220622_129}"
}
x893297_g_ZhuFuImpact = 199
--**********************************
--条件检测
--**********************************
function x893297_OnConditionCheck( sceneId, selfId )
	
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId,selfId,x893297_g_ZhuFuImpact) == 1 then
		x893297_NotifyTip( sceneId, selfId, "#{MPSD_220622_130}" )
		return 0
	end
	--祈福中，请凝神虔心。
	x893297_NotifyTip( sceneId, selfId, "#{MPSD_220622_101}" )
	return 1
end
--**********************************
--技能释放完毕
--**********************************
function x893297_SkillOnUnitOne(sceneId,selfId, nSkillId)
	--祈福已毕，望心想事成！	
	x893297_NotifyTip( sceneId, selfId, "#{MPSD_220622_124}" )
	--发送附近对话
	BroadMsgByChatPipe(sceneId,selfId,x893297_g_ZhuFuTips[random(1,getn(x893297_g_ZhuFuTips))],0) 
	--给予特殊祝福BUFF
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x893297_g_ZhuFuImpact, 100 )
end

--**********************************
--醒目提示
--**********************************
function x893297_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end