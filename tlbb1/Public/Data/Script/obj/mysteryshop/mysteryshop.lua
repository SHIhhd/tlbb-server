--神秘商店交互NPC
x044900_g_scriptId=044900

--W_GIDX_LUAUSE_MYSTERYSHOPID	= 60  	--当前的神秘商店商店ID
--W_GIDX_LUAUSE_MYSTERYDAYTIME = 61		--当前神秘商店的记录日期

--当前神秘商店的商店ID
x044900_g_ShopId = {239,240,241,242,243,244,245,246,249}
--**********************************
--事件交互入口
--**********************************
function x044900_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SMYBSD_091102_01}")
		AddNumText(sceneId,x044900_g_scriptId,"#{SMYBSD_091102_04}",7,0)
		AddNumText(sceneId,x044900_g_scriptId,"#{SMYBSD_091102_05}",11,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x044900_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		--打开神秘商店
		if GetLevel(sceneId,selfId) < 20 then
			x044900_NotifyBox( sceneId, selfId, "#{SMYBSD_091102_02}" )
			return
		end
		local nCurShopId = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_MYSTERYSHOPID)
		LuaFnDispatchNpcMysteryShopItem(sceneId,selfId,targetId,nCurShopId)
	end
	if GetNumText() == 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SMYBSD_091102_03}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--Monster Timer
--**********************************
function x044900_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nCurDayTime = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_MYSTERYDAYTIME)
	if nCurDayTime ~= GetTime2Day() then
		--换新的商店
		LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_MYSTERYDAYTIME,GetTime2Day())
		--随机一个新的商店
		local nRandShop = x044900_g_ShopId[random(1,getn(x044900_g_ShopId))]
		local nCurShopId = LuaFnGetWorldGlobalData(W_GIDX_LUAUSE_MYSTERYSHOPID)
		while nCurShopId == nRandShop do
			nRandShop = x044900_g_ShopId[random(1,getn(x044900_g_ShopId))]
		end
		--绑定新的商店
		LuaFnSetWorldGlobalData(W_GIDX_LUAUSE_MYSTERYSHOPID,nRandShop)
		--公告
		AddGlobalCountNews( sceneId,"@*;SrvMsg;SCA:#{SMYBSD_091216_1}")
	end
end

--**********************************
--信息提示
--**********************************
function x044900_NotifyBox( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

