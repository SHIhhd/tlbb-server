--曼陀
--问路脚本
x893294_g_scriptId = 893294

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x893294_g_Signpost = {
	--MPSD_220622_23	拜见庄主
	{ type=2, name="#{MPSD_220622_23}", x=140, y=75, tip="#Y庄主王夫人", desc="#{MPSD_220622_24}", eventId=-1 },
	--MPSD_220622_26	加入曼陀山庄	
	{ type=2, name="#{MPSD_220622_26}", x=140, y=88, tip="#Y曼陀山庄拜师人王素商", desc="#{MPSD_220622_27}", eventId=-1 },
	--MPSD_220622_29	学习曼陀山庄战斗技能	
	{ type=2, name="#{MPSD_220622_29}", x=155, y=114, tip="#Y武功传授人王和铃", desc="#{MPSD_220622_30}", eventId=-1 },
	--MPSD_220622_32	学习曼陀山庄生活技能
	{ type=2, name="#{MPSD_220622_32}", x=210, y=158, tip="#Y生活技能关山月", desc="#{MPSD_220622_33}", eventId=-1 },
	--MPSD_220622_35	学习曼陀山庄生活辅助技能	
	{ type=2, name="#{MPSD_220622_35}", x=186, y=171, tip="#Y生活辅助技能王水风", desc="#{MPSD_220622_36}", eventId=-1 },
	--MPSD_220622_38	购买坐骑	
	{ type=2, name="#{MPSD_220622_38}", x=63, y=132, tip="#Y坐骑管理叶婆婆", desc="#{MPSD_220622_39}", eventId=-1 },
	--MPSD_220622_41	曼陀山庄任务	
	{ type=2, name="#{MPSD_220622_41}", x=129, y=106, tip="#Y师门任务王安歌", desc="#{MPSD_220622_42}", eventId=-1 },
	--MPSD_220622_44	曼陀山庄传送人	
	{ type=2, name="#{MPSD_220622_44}", x=93, y=118, tip="#Y曼陀山庄传送人幽草", desc="#{MPSD_220622_45}", eventId=-1 },
	--MPSD_220622_120	皓月洲
	{ type=2, name="#{MPSD_220622_120}", x=30, y=197, tip="#Y皓月洲", desc="#{MPSD_220622_121}", eventId=-1 },
	--MPSD_220622_123	学习曼陀山庄轻功	
	{ type=2, name="#{MPSD_220622_123}", x=151, y=36, tip="#Y轻功传授人王雁足", desc="#{MPSD_220622_47}", eventId=-1 },
}

--**********************************
--列举事件
--**********************************
function x893294_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x893294_g_Signpost do
		AddNumText(sceneId, x893294_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x893294_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x893294_g_Signpost[GetNumText()]

	if signpost.type == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, signpost.name .. "：")
			CallScriptFunction( signpost.eventId, "OnEnumerate", sceneId, selfId, targetId )
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif signpost.type == 2 then
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, signpost.x, signpost.y, signpost.tip )

		BeginEvent(sceneId)
			AddText(sceneId, signpost.desc)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	end

end
