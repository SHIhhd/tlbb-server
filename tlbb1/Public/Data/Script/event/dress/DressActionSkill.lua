--编号时装动作

--脚本号
x998527_g_scriptId = 998527
--24:怒雷 		特殊效果(队友或团员) 30分钟释放一次
x998527_g_NuLeiImpact = 91
x998527_g_NuLeiCDTime = 30 * 60
--25:天河落星	场景效果 8小时释放一次 效果id 38
x998527_g_SceneWeather = 38
x998527_g_SceneWeatherTime = 10 * 60 * 1000	--10分钟
x998527_g_SceneWeatherCD = 8 * 60 * 60
--**********************************
--【c++回调】编号时装发起动作
--**********************************
function x998527_OnDressSkillActive(sceneId,selfId,nActionId)
	
	if nActionId ~= 24 and nActionId ~= 25 
	and nActionId ~= 59 and nActionId ~= 60
	and nActionId ~= 86 and nActionId ~= 87 then
		x998527_Tips(sceneId,selfId,"未知动作,请联系雪舞!")
		return 0
	end
	
	local nDressTableId = LuaFnGetEquipedItemTableIndex(sceneId,selfId,HEQUIP_DRESS)
	if LuaFnGetNumberingFashionCode(nDressTableId) < 0 then
		--SZBH_231103_02	您当前未穿戴%s0，无法进行此操作。	
		x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_02}",LuaFnGetItemName(nDressTableId)) )
		return 0
	end

	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		x998527_Tips(sceneId,selfId,"#{SZBH_231103_05}")
		return 0
	elseif LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
		x998527_Tips(sceneId,selfId,"#{SZBH_231103_04}")
		return 0
	end
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x998527_Tips(sceneId,selfId,"#{SZBH_231103_07}")
		return 0
	elseif LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, 113) == 1 then
		x998527_Tips(sceneId,selfId,"#{SZBH_231103_07}")
		return 0
	end
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x998527_Tips(sceneId,selfId,"#{SZBH_231103_06}")
		return 0
	end
	if LuaFnIsStalling( sceneId, selfId ) == 1 then
		x998527_Tips( sceneId, selfId, "#{SZBH_231103_08}" )
		return 0
	end
	
	--怒雷 		特殊效果(队友或团员) 30分钟释放一次	
	if nActionId == 24 then
		local nLastTime = GetMissionDataEx(sceneId,selfId,MDEX_LAST_DRESS_SPECIALACTION_CD_24)
		if nLastTime > 0 and LuaFnGetCurrentTime() - nLastTime < x998527_g_NuLeiCDTime then
			local nLeftTime = x998527_g_NuLeiCDTime - (LuaFnGetCurrentTime() - nLastTime)
			if nLeftTime > 60 * 60 then
				x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_03}",tostring(floor(nLeftTime / 3600))) )
			elseif nLeftTime > 60 then
				x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_32}",tostring(floor(nLeftTime / 60))) )
			else
				x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_33}",tostring(nLeftTime)) )
			end
			
			return 0
		end
		SetMissionDataEx(sceneId,selfId,MDEX_LAST_DRESS_SPECIALACTION_CD_24,LuaFnGetCurrentTime())
		
		if LuaFnHasTeam( sceneId, selfId ) ~= 0 then
			local num = LuaFnGetTeamSceneMemberCount( sceneId, selfId )
			for	i=0, num-1 do
				local nTeamObjId = LuaFnGetTeamSceneMember( sceneId, selfId, i )
				if LuaFnIsObjValid( sceneId, nTeamObjId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId,nTeamObjId ) == 1 then
					if IsInDist(sceneId,selfId,nTeamObjId,10) == 1 then
						x998527_Tips( sceneId, nTeamObjId, ScriptGlobal_Format("#{SZBH_231103_26}",GetName(sceneId,selfId)) )
						--给予特殊buff
						LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,nTeamObjId,x998527_g_NuLeiImpact,10)
					end
				end
			end
		end
		if LuaFnHasRaid( sceneId, selfId ) ~= 0 then
			local num = LuaFnGetRaidSceneMemberCount( sceneId, selfId )
			for	i=0, num-1 do
				local nRaidObjId = LuaFnGetRaidSceneMember( sceneId, selfId, i )
				if LuaFnIsObjValid( sceneId, nRaidObjId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId,nRaidObjId ) == 1 then
					if IsInDist(sceneId,selfId,nRaidObjId,10) == 1 then
						x998527_Tips( sceneId, nRaidObjId, ScriptGlobal_Format("#{SZBH_231103_26}",GetName(sceneId,selfId)) )
						--给予特殊buff
						LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,nRaidObjId,x998527_g_NuLeiImpact,10)
					end
				end
			end
		end
	end
	
	if nActionId == 25 then
		local curWeather = LuaFnGetSceneWeather(sceneId);
		if not curWeather or curWeather ~= -1 then
			x998527_Tips(sceneId, selfId, "#{SZBH_231103_30}");
			return 0
		end
		
		local nLastTime = GetMissionDataEx(sceneId,selfId,MDEX_LAST_DRESS_SPECIALACTION_CD_25)
		if nLastTime > 0 and LuaFnGetCurrentTime() - nLastTime < x998527_g_SceneWeatherCD then
			local nLeftTime = x998527_g_SceneWeatherCD - (LuaFnGetCurrentTime() - nLastTime)
			if nLeftTime > 60 * 60 then
				x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_03}",tostring(floor(nLeftTime / 3600))) )
			elseif nLeftTime > 60 then
				x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_32}",tostring(floor(nLeftTime / 60))) )
			else
				x998527_Tips( sceneId, selfId, ScriptGlobal_Format("#{SZBH_231103_33}",tostring(nLeftTime)) )
			end
			
			return 0
		end
		SetMissionDataEx(sceneId,selfId,MDEX_LAST_DRESS_SPECIALACTION_CD_25,LuaFnGetCurrentTime())
		
		LuaFnSetSceneWeather(sceneId, x998527_g_SceneWeather, x998527_g_SceneWeatherTime );
		BroadMsgByChatPipe(sceneId,selfId, ScriptGlobal_Format("#{SZBH_231103_29}",GetName(sceneId, selfId)), 4)		
	end
	
	--SZBH_231103_34	仅可在大理、洛阳、苏州使用此外观动作。	
--	SZBH_231103_09	当前场景模型过多，无法播放外观动作。	
--	SZBH_231103_28	当前场景无法使用此外观动作。	
--	SZBH_231103_29	#P#{_INFOUSR%s0}使用了祝融仙铠的力量，霎时间星坠成雨，落野如昼，天上人间，一梦千年。	
--	SZBH_231103_31	当前场景烟花过多，无法播放外观动作。	

	
	--SZBH_231103_27	您释放了祝融仙铠的动作。
	--SZBH_241203_05	您释放了冰夷华裳的动作。
	--SZBH_251014_05	您释放了蚩尤血袍的动作。
	if nActionId == 24 or nActionId == 25 then
		x998527_Tips( sceneId, selfId, "#{SZBH_231103_27}" )
	elseif nActionId == 59 or nActionId == 60 then
		x998527_Tips( sceneId, selfId, "#{SZBH_241203_05}" )
	elseif nActionId == 86 or nActionId == 87 then
		x998527_Tips( sceneId, selfId, "#{SZBH_251014_05}" )
	end
	
	return 1
end

--**********************************
--提示信息
--**********************************
function x998527_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end