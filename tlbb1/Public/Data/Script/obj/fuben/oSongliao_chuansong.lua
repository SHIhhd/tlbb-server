--怀旧兵行四象
--副本内治疗

x502021_g_ScriptId = 502021
x502021_g_SceneData_CloseFlag = 3		--设置副本关闭标志, 0开放，1关闭

--**********************************
--事件交互入口
--**********************************
function x502021_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{XSLDZ_180424_41}")
		AddNumText( sceneId, x502021_g_ScriptId, "#{XSLDZ_180521_344}", 6, 1 ) 
		AddNumText( sceneId, x502021_g_ScriptId, "#{XSLDZ_180521_345}", 6, 2 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end
--**********************************
--事件列表选中一项
--**********************************
function x502021_OnEventRequest( sceneId, selfId, targetId, eventId)
	--那么远治疗个吉尔。。
	if IsInDist(sceneId,selfId,targetId,10) ~= 1 then
		x502021_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_210128_07}" )
		x502021_NotifyTips( sceneId, selfId, "#{XSLDZ_210128_06}" )
		return
	end
	
	local Operation = GetNumText()
	if Operation == 1 then
		if GetHp( sceneId, selfId ) == GetMaxHp( sceneId, selfId ) and
			 GetMp( sceneId, selfId ) == GetMaxMp( sceneId, selfId ) then
			x502021_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_180521_348}" )
			x502021_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_347}" )
			return
		end
		RestoreHp( sceneId, selfId )
		RestoreMp( sceneId, selfId )
		RestoreRage( sceneId, selfId )
		x502021_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_180521_350}" )
		x502021_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_349}" )
		
		return 
	end
	if Operation == 2 then
		--治疗珍兽
		local nPetObjID = x502021_FightingPet( sceneId, selfId )
		if nPetObjID == -1 then
			x502021_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_180521_352}" )
			x502021_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_351}" )
			return
		end
		local PetNum = LuaFnGetPetCount( sceneId, selfId )
		--珍兽回血
		for i=0, PetNum-1, 1 do
			local Pet_MaxHP	= LuaFnGetPet_MaxHP( sceneId, selfId, i )

			--根据珍兽index得到珍兽guid
			local PetID_H, PetID_L = LuaFnGetPetGUID( sceneId, selfId, i )
			--提升HP
			LuaFnSetPetHP( sceneId, selfId, PetID_H, PetID_L, Pet_MaxHP )
		end
		x502021_NotifyBox( sceneId, selfId, targetId, "#{XSLDZ_180521_356}" )
		x502021_NotifyTips( sceneId, selfId, "#{XSLDZ_180521_355}" )
		return
	end
	
	if Operation == 101 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return 
	end
end

--**********************************
--离开战场
--**********************************
function x502021_Transfer( sceneId, selfId )
	local nCopySceneFlag = LuaFnGetCopySceneData_Param( sceneId, x502021_g_SceneData_CloseFlag )
	if nCopySceneFlag ~= 1 then
		return
	end
	SetPvpAuthorizationFlagByID(sceneId,selfId, 2, 0)--设定PVP状态
	SetUnitCampID(sceneId,selfId,selfId, -1) --重新设定阵营
    CallScriptFunction( (400900), "TransferFunc",sceneId, selfId,1,random(192,194),random(143,145))
end

--**********************************
--获取出战珍兽的ObjId
--**********************************
function x502021_FightingPet( sceneId, selfId )
	local	PetNum	= LuaFnGetPetCount( sceneId, selfId )
	local	i
	local	PetID_H, PetID_L
	local	objId
	if PetNum <= 0 then
		return -1
	end
	
	for i=0, PetNum-1, 1 do
		--根据珍兽index得到珍兽guid
		PetID_H, PetID_L = LuaFnGetPetGUID( sceneId, selfId, i )
		objId	= LuaFnGetPetObjIdByGUID( sceneId, selfId, PetID_H, PetID_L )
		
		if objId >= 0 then
			return objId
		end
	end
	return -1
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x502021_NotifyBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x502021_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end