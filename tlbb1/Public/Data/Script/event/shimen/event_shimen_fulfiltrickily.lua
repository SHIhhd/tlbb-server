--投机取巧
--消耗活力值来直接完成一环师门任务....

x229013_g_scriptId = 229013

--**********************************
--任务入口函数
--**********************************
function x229013_OnDefaultEvent( sceneId, selfId, targetId, menpaiId, numTextId )

	if numTextId == 1 then
		BeginEvent( sceneId )
			if IsHaveMission(sceneId,selfId,MENPAI_SHIMEN_MISID[menpaiId+1]) <= 0 then
				AddText( sceneId, "#{TJQQ_90428_4}")
			else
				local strText = "#{TJQQ_90428_2}%d#{TJQQ_90428_3}%d#{TJQQ_90428_10}"
				strText = format( strText, x229013_GetHelpFinishNeed( sceneId, selfId ),GetMissionDataEx(sceneId,selfId,MDEX_TOUJI_COUNT) )
				AddText( sceneId, strText )
				AddNumText( sceneId, x229013_g_scriptId, "确定", 6, 2 )
				AddNumText( sceneId, x229013_g_scriptId, "离开", 8, 3 )
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

	elseif numTextId == 2 then
		if GetLevel(sceneId,selfId) < 10 then
			BeginEvent(sceneId)
				AddText( sceneId, "#{TJQQ_90428_9}" )
			EndEvent(sceneId)
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		--今天用完了
		if GetMissionDataEx(sceneId,selfId,MDEX_TOUJI_COUNT) > 0 then
			BeginEvent(sceneId)
				AddText( sceneId, "#{TJQQ_90428_8}" )
			EndEvent(sceneId)
			DispatchEventList( sceneId, selfId, targetId )
			return
		end
		CallScriptFunction( MENPAI_SHIMEN_SCRIPTID[menpaiId+1], "HelpFinishOneHuan", sceneId, selfId, targetId,2 )

	elseif numTextId == 3 then

		--关闭对话窗口....
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		
	end

end

--**********************************
--列举事件
--**********************************
function x229013_OnEnumerate( sceneId, selfId, targetId, menpaiId )

	--如果玩家不是该本门派的就不显示....
	if menpaiId == GetMenPai( sceneId, selfId ) then
		AddNumText( sceneId, x229013_g_scriptId, "#{TJQQ_90428_1}", 6, 1 );
	end

end

--**********************************
--计算投机取巧需要的活力值....
--**********************************
function x229013_GetHelpFinishNeed( sceneId, selfId )
	return 30
end

--**********************************
--检测并扣除投机取巧所需的活力....
--**********************************
function x229013_CheckAndDepleteHelpFinishVigor( sceneId, selfId, targetId )

	local needPoint = x229013_GetHelpFinishNeed( sceneId, selfId )
	local nVigor = GetHumanVigor( sceneId, selfId )

	if nVigor < needPoint then
		BeginEvent(sceneId)
			AddText( sceneId, "#{TJQQ_90428_5}" )
		EndEvent(sceneId)
		DispatchEventList( sceneId, selfId, targetId )
		return 0
	else
		SetHumanVigor( sceneId, selfId, nVigor-needPoint )
		--设置今日投机取巧次数
		local nDayCount = GetMissionDataEx(sceneId,selfId,MDEX_TOUJI_COUNT)
		SetMissionDataEx(sceneId,selfId,MDEX_TOUJI_COUNT,nDayCount + 1)
		return 1
	end

end
