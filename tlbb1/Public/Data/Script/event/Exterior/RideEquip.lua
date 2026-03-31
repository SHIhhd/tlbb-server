--坐骑装备在新外观中心里使用
x999801_g_ScriptId = 999801

--**********************************
--程序回调
--**********************************
function x999801_Exterior_UseRideEquip( sceneId, selfId, BagIndex,itemid,ExteriorID,oriTime,addTime )
--	g_msgFrameVar[1] = Get_XParam_INT(0) --BagIndex
--	g_msgFrameVar[2] = Get_XParam_INT(1) --itemid
--	g_msgFrameVar[3] = Get_XParam_INT(2) --ExteriorID
--	g_msgFrameVar[4] = Get_XParam_INT(3) --oriTime
--	g_msgFrameVar[5] = Get_XParam_INT(4) --addTime 
	--物品可用性
	if LuaFnIsItemAvailable( sceneId, selfId,BagIndex) ~= 1 then
		x999801_Tips( sceneId, selfId,"#{WGTJ_200617_62}")
		return
	end
	local nExteriorId,nItemLevel,nIsVisible,nMenpaiLimited = LuaFnGetExteriorRideInfo(sceneId,selfId,BagIndex);
	if nItemLevel > GetLevel(sceneId,selfId) then
		x999801_Tips( sceneId, selfId,"#{WGTJ_201222_31}")
		return
	end
	if nIsVisible ~= 1 then
	--坐骑暂时未开放
		x999801_Tips( sceneId, selfId,"#{WGTJ_200617_63}")
		return
	end
	if nMenpaiLimited ~= -1 and nMenpaiLimited ~= LuaFnGetMenPai(sceneId,selfId) then
		x999801_Tips(sceneId,selfId,ScriptGlobal_Format("#{WGTJ_200617_64}",format("#{_MENPAI%d}",nMenpaiLimited)))
		return
	end
	if oriTime == -1 then
		--已是永久使用的坐骑
--		WGTJ_201222_34	#H坐骑：%s0已可永久使用。
		x999801_Tips(sceneId,selfId,ScriptGlobal_Format("#{WGTJ_201222_34}", GetItemName(sceneId,itemid)))
		return
	end
	--oriTime接口给的是分钟
	if addTime ~= -1 then
		--oriTime:end unix time
		oriTime = oriTime - LuaFnGetCurrentTime()
		if oriTime >= 365*24*60*60 then		
			x999801_Tips(sceneId,selfId,"#{WGTJ_201222_35}")
			return
		end
	end
	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,BagIndex)
		UICommand_AddInt( sceneId,itemid)
		UICommand_AddInt( sceneId,ExteriorID)
		UICommand_AddInt( sceneId,oriTime)
		UICommand_AddInt( sceneId,addTime)
    EndUICommand( sceneId )
    DispatchUICommand( sceneId, selfId, 99980101 )   
end
--**********************************
--确认使用
--**********************************
function x999801_OnConfirm( sceneId, selfId, BagIndex,itemid )
	local nItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, BagIndex );
	if nItemID ~= itemid then
		return
	end
	--物品可用性
	if LuaFnIsItemAvailable( sceneId, selfId,BagIndex) ~= 1 then
		x999801_Tips( sceneId, selfId,"#{WGTJ_200617_62}")
		return
	end
	local nExteriorId,nItemLevel,nIsVisible,nMenpaiLimited,szMountName = LuaFnGetExteriorRideInfo(sceneId,selfId,BagIndex);
	if nItemLevel > GetLevel(sceneId,selfId) then
		x999801_Tips( sceneId, selfId,"#{WGTJ_201222_31}")
		return
	end
	if nIsVisible ~= 1 then
	--坐骑暂时未开放
		x999801_Tips( sceneId, selfId,"#{WGTJ_200617_63}")
		return
	end
	if nMenpaiLimited ~= -1 and nMenpaiLimited ~= LuaFnGetMenPai(sceneId,selfId) then
		x999801_Tips(sceneId,selfId,ScriptGlobal_Format("#{WGTJ_200617_64}",format("#{_MENPAI%d}",nMenpaiLimited)))
		return
	end	
	--等级、时间相关校验在程序进行，不再额外增加其他注册
	local nAddLimitTime = LuaFnExteriorUseRideEquip(sceneId,selfId,BagIndex)
	--使用成功了
	if nAddLimitTime == -1 then
		x999801_Tips(sceneId,selfId,ScriptGlobal_Format("#{WGTJ_200617_69}",szMountName))
	else
		local strAddTime = ""
		if nAddLimitTime >= 1440 then
			local nAddDay = floor(nAddLimitTime / 1440)
			strAddTime = ScriptGlobal_Format("#{WGTJ_201222_94}", tostring(nAddDay))
		elseif nAddLimitTime >= 60 then
			local nAddHour = floor(nAddLimitTime / 60)
			strAddTime = ScriptGlobal_Format("#{WGTJ_201222_95}", tostring(nAddHour))
		else
			strAddTime = "#{WGTJ_201222_96}"
		end
		x999801_Tips(sceneId,selfId,ScriptGlobal_Format("#{WGTJ_200617_70}",szMountName,strAddTime))
	end
	--效果
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 149, 0)
	--典藏坐骑弹窗特写
	local strMountName,iReverseItem = LuaFnGetExteriorRideInfoByExteriorID(nExteriorId);
	if iReverseItem ~= nil and iReverseItem == 10141945 then
		
	end
end

function x999801_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
