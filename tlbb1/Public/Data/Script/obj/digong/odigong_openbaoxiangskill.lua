--开启秦皇宝箱
x893389_g_ScriptId	= 893389
x893389_g_FuBenControlScript = 891070
--军功令
x893389_g_CostItem = 38002668
x893389_g_CostCountBig = 150
x893389_g_CostCountSmall = 75
--场景参数
x893389_g_ParamScene = {
	--秦皇宝箱
	[50610]	= {
		param = 0,
		scriptId = 893397,
	},
	--秦将宝箱
	[50605]	= {
		param = 1,
		scriptId = 893398,
	},
	--秦将宝箱
	[50606]	= {
		param = 2,
		scriptId = 893398,
	},
	--秦将宝箱
	[50607]	= {
		param = 3,
		scriptId = 893398,
	},
	--秦将宝箱
	[50608]	= {
		param = 4,
		scriptId = 893398,
	},
	--未上锁的秦将宝箱
	[50609]	= {
		param = -1,
		scriptId = 893398,
	},
}

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x893389_OnConditionCheck( sceneId, selfId )
	if GetLevel(sceneId,selfId) < 80 then
		return 0
	end
	--使用技能开箱子
	if sceneId ~= SCENE_ID_DIGONG_4HD then
		x893389_NotifyTip( sceneId, selfId, "#{MJXZ_210510_183}" )
		return 0
	end
	if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_189}")
		return 0
	end
	if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_189}")
		return 0
	end
	if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_188}")
		return 0
	end
	if IsTeamFollow(sceneId,selfId) == 1 then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_203}")
		return 0
	end 
		
	local nCurTarObj = LuaFnGetTargetObjID(sceneId,selfId)
	if IsInDist(sceneId,selfId,nCurTarObj,6) ~= 1 then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_184}")
		return 0
	end
	local MosDataID = GetMonsterDataID(sceneId,nCurTarObj)
	--秦将宝箱
	if MosDataID >= 50605 and MosDataID <= 50608 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,x893389_g_CostItem) < x893389_g_CostCountSmall then
			x893389_NotifyTip( sceneId, selfId, "#{MJXZ_210510_187}" )
			x893389_TipsBox( sceneId, selfId,nCurTarObj, "#{MJXZ_210510_186}" )
			return 0
		end
	elseif MosDataID == 50610 then
		--20:20后才可开启
		local curTime = GetHour() * 100 + GetMinute();
		if curTime < 2020 then
			x893389_NotifyTip( sceneId, selfId, "#{MJXZ_210510_40}" )
			x893389_TipsBox(sceneId,selfId,targetId,"#{MJXZ_210510_63}")
			return
		end
		if LuaFnGetAvailableItemCount(sceneId,selfId,x893389_g_CostItem) < x893389_g_CostCountBig then
			x893389_NotifyTip( sceneId, selfId, "#{MJXZ_210510_187}" )
			x893389_TipsBox( sceneId, selfId,nCurTarObj, "#{MJXZ_210510_186}" )
			return 0
		end
	--未上锁的秦将宝箱
	elseif MosDataID == 50609 then
		
	else
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_183}")
		return 0
	end
	if x893389_g_ParamScene[MosDataID] == nil then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_183}")
		return 0
	end
	local nMosParam = x893389_g_ParamScene[MosDataID].param
	if nMosParam == -1 then
		MosDataID = LuaFnGetNpcIntParameter(sceneId,nCurTarObj,0)
		nMosParam = x893389_g_ParamScene[MosDataID].param
	end
	--检查是否正在被开启
	if LuaFnGetSceneData_TempParam(sceneId,nMosParam) == 1 then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_185}")
		return 0
	end
	--检查是否已开启
	if LuaFnGetSceneData_TempParam(sceneId,nMosParam) == 2 then
		x893389_TipsBox( sceneId, selfId,targetId, "#{MJXZ_210510_182}" )
		return 0
	end
	--标记宝箱正在被开启
	LuaFnSetSceneData_TempParam(sceneId,nMosParam,1);
	--提起公告
	local monsterName = GetMonsterNamebyDataId(MosDataID)
	AddGlobalCountNews( sceneId, ScriptGlobal_Format("#{MJXZ_210510_190}",monsterName) )
	
	return 1;
end
--**********************************
--技能被中断
--**********************************
function x893389_SkillOnInterrupt(sceneId,selfId, nSkillId )
	local nCurTarObj = LuaFnGetTargetObjID(sceneId,selfId)
	local MosDataID = GetMonsterDataID(sceneId,nCurTarObj)
	local nMosParam = x893389_g_ParamScene[MosDataID].param
	if nMosParam == -1 then
		MosDataID = LuaFnGetNpcIntParameter(sceneId,nCurTarObj,0)
		nMosParam = x893389_g_ParamScene[MosDataID].param
	end
	--标记宝箱未被开启
	LuaFnSetSceneData_TempParam(sceneId,nMosParam,0);
end
--**********************************
--技能被取消
--**********************************
function x893389_SkillOnCancel(sceneId,selfId, nSkillId )
	local nCurTarObj = LuaFnGetTargetObjID(sceneId,selfId)
	local MosDataID = GetMonsterDataID(sceneId,nCurTarObj)
	local nMosParam = x893389_g_ParamScene[MosDataID].param
	if nMosParam == -1 then
		MosDataID = LuaFnGetNpcIntParameter(sceneId,nCurTarObj,0)
		nMosParam = x893389_g_ParamScene[MosDataID].param
	end
	--标记宝箱未被开启
	LuaFnSetSceneData_TempParam(sceneId,nMosParam,0);
end
--**********************************
--技能释放完毕
--**********************************
function x893389_SkillOnUnitOne(sceneId,selfId, nSkillId,targetID )
	local nCurTarObj = LuaFnGetTargetObjID(sceneId,selfId)
	local MosDataID = GetMonsterDataID(sceneId,nCurTarObj)
	if x893389_g_ParamScene[MosDataID] == nil then
		return
	end
	--秦将宝箱
	if MosDataID >= 50605 and MosDataID <= 50608 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,x893389_g_CostItem) < x893389_g_CostCountSmall then
			x893389_NotifyTip( sceneId, selfId, "#{MJXZ_210510_187}" )
			x893389_TipsBox( sceneId, selfId,nCurTarObj, "#{MJXZ_210510_186}" )
			return
		end
		--扣除军功令
		LuaFnDelAvailableItem(sceneId,selfId,x893389_g_CostItem,x893389_g_CostCountSmall)
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_233}")
	elseif MosDataID == 50610 then
		if LuaFnGetAvailableItemCount(sceneId,selfId,x893389_g_CostItem) < x893389_g_CostCountBig then
			x893389_NotifyTip( sceneId, selfId, "#{MJXZ_210510_187}" )
			x893389_TipsBox( sceneId, selfId,nCurTarObj, "#{MJXZ_210510_186}" )
			return
		end
		--扣除军功令
		LuaFnDelAvailableItem(sceneId,selfId,x893389_g_CostItem,x893389_g_CostCountBig)
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_233}")
	--未上锁的秦将宝箱
	elseif MosDataID == 50609 then
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_236}")
	else
		x893389_NotifyTip(sceneId,selfId,"#{MJXZ_210510_183}")
		return
	end
	local nMosParam = x893389_g_ParamScene[MosDataID].param
	if nMosParam == -1 then
		MosDataID = LuaFnGetNpcIntParameter(sceneId,nCurTarObj,0)
		nMosParam = x893389_g_ParamScene[MosDataID].param
	end
	local monsterName = GetMonsterNamebyDataId(MosDataID)
	AddGlobalCountNews( sceneId, ScriptGlobal_Format("#{MJXZ_210510_192}",monsterName) )
	--标记宝箱被开启
	LuaFnSetSceneData_TempParam(sceneId,nMosParam,2);
	--产生掉落物品	
	CallScriptFunction(x893389_g_ParamScene[MosDataID].scriptId,"GenDropItem",sceneId,nCurTarObj,selfId)
	--删除宝箱
	LuaFnDeleteMonster(sceneId,nCurTarObj)
end
--**********************************
--提示信息
--**********************************
function x893389_TipsBox( sceneId, selfId,targetId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--对话框提示
--**********************************
function x893389_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

