--MisDescBegin
--脚本号
x808133_g_ScriptId = 808133
x808133_g_eventList = {808134}
--接受任务NPC属性
x808133_g_Position_X=184
x808133_g_Position_Z=180
x808133_g_SceneID=1
x808133_g_AccomplishNPC_Name="梁道士"

--任务归类
x808133_g_MissionKind = 13

--任务等级
x808133_g_MissionLevel = 10000

--是否是精英任务
x808133_g_IfMissionElite = 0

--任务文本描述
x808133_g_MissionName="#{ZXCM_090602_04}"
x808133_g_MissionInfo="#{ZXCM_090602_06}"
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x808133_OnDefaultEvent( sceneId, selfId, targetId ,eventId )	--点击该任务后执行此脚本
	local nNumText = GetNumText()
	if nNumText == 1000 then
		x808133_NotifyFailBox(sceneId,selfId,targetId,"#{ZXCM_090602_40}")
		return
	end
end

--**********************************
--列举事件
--**********************************
function x808133_OnEnumerate( sceneId, selfId, targetId )
	AddNumText(sceneId,x808133_g_ScriptId,"#{ZXCM_090602_05}",11,1000)
end

--**********************************
--检测是否满足接取任务条件
--**********************************
function x808133_CheckAccept(sceneId,selfId)
	
end
--**********************************
--接受任务
--**********************************
function x808133_OnAccept( sceneId, selfId )
end
--**********************************
--放弃任务
--**********************************
function x808133_OnAbandon( sceneId, selfId )

end
--**********************************
--继续
--**********************************
function x808133_OnContinue( sceneId, selfId, targetId )

end

--**********************************
--检测是否可以提交
--**********************************
function x808133_CheckSubmit(sceneId,selfId)

end

--**********************************
--提交任务
--**********************************
function x808133_OnSubmit( sceneId, selfId, targetId,selectRadioId )

end
--**********************************
--死亡事件
--**********************************
function x808133_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x808133_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x808133_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end