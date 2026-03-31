--万事阁势力NPC
--脚本号
x890062_g_ScriptId = 890062
x890062_g_MinLevel = 85
--势力ID
x890062_g_CampID = 3
--对应生活技能
x890062_g_Ability = ABILITY_TJZF_POZHEN
--**********************************
--任务入口函数
--**********************************
function x890062_OnDefaultEvent( sceneId, selfId, targetId,opId )
	if opId == 0 then
		if GetLevel(sceneId,selfId) < x890062_g_MinLevel then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_7}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_8}")
			return
		end
		local nCampId = LuaFnGetShengWangId(sceneId,selfId)
		if nCampId == x890062_g_CampID then
			return
		end
		if nCampId ~= 0 then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_108}")
			return
		end
		LuaFnOpenShengWangAllPage(sceneId,selfId,targetId,x890062_g_CampID,1)
	elseif opId == 1 then
		--学习对应生活技能
		if GetLevel(sceneId,selfId) < x890062_g_MinLevel then
			x890062_NotifyTips(sceneId,selfId,"#{SZXT_221216_70}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_8}")
			return
		end
		if QueryHumanAbilityLevel(sceneId, selfId, x890062_g_Ability) > 0 then
			x890062_NotifyTips(sceneId,selfId,"#{SZXT_221216_72}")
			return
		end
		local nCampId = LuaFnGetShengWangId(sceneId,selfId)
		if nCampId ~= x890062_g_CampID then
			x890062_NotifyTips(sceneId,selfId,"#{SZXT_221216_75}")
			return
		end
		CallScriptFunction(890063,"LearnLifeAbility",sceneId,selfId,nCampId)
	elseif opId == 2 then
		--打开主页面
		if GetLevel(sceneId,selfId) < x890062_g_MinLevel then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_7}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_8}")
			return
		end
		local nCampId = LuaFnGetShengWangId(sceneId,selfId)
		if nCampId ~= x890062_g_CampID then
			x890062_NotifyTips(sceneId,selfId,"#{SWXT_221213_104}")
			return
		end
		LuaFnOpenShengWangAllPage(sceneId,selfId,targetId,x890062_g_CampID,1)
		
	elseif opId == 100 then
		x890062_MsgBox( sceneId, selfId, targetId, "#{SWXT_221213_221}" )
	end
	
end

--**********************************
--列举事件
--**********************************
function x890062_OnEnumerate( sceneId, selfId, targetId )
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId ~= x890062_g_CampID then
		AddNumText(sceneId, x890062_g_ScriptId, "#{SWXT_221213_212}", 6, 0)
	else	
		AddNumText(sceneId, x890062_g_ScriptId, "#{SWXT_221213_240}", 6, 2)
	end
	if QueryHumanAbilityLevel(sceneId, selfId, x890062_g_Ability) <= 0 then
		AddNumText(sceneId, x890062_g_ScriptId, "#{SZXT_221216_67}", 6, 1)
	end
	
	AddNumText(sceneId, x890062_g_ScriptId, "#{SWXT_221213_3}", 11, 100)
end

--**********************************
-- 屏幕中间提示
--**********************************
function x890062_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x890062_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end