--脚本号
--江湖盟会商店脚本

x998585_g_ScriptId = 998585
x998585_g_MinLevel = 50
x998585_g_NpcList = 
{
	[51911] = {	
		IdentityId=IDENTITY_COOKING_IDX,
		mainStr = "#{SZSW_231228_01}",
		yulanStr = "#{SZSW_231228_12}",
		shopId = 260,
	},		--烹饪NPC
	[51912] = {	
		IdentityId=IDENTITY_PHARMACY_IDX,
		mainStr = "#{SZSW_231228_02}",
		yulanStr = "#{SZSW_231228_13}",
		shopId = 261,
	},		--制药NPC
	[51913] = {	
		IdentityId=IDENTITY_ATTACKEQUIP_IDX,
		mainStr = "#{SZSW_231228_03}",
		yulanStr = "#{SZSW_231228_14}",
		shopId = 262,
	},	--攻具NPC
	[51915] = {	
		IdentityId=IDENTITY_ENGINEER_IDX,
		mainStr = "#{SZSW_231228_04}",
		yulanStr = "#{SZSW_231228_15}",
		shopId = 263,
	},		--工程NPC
}
x998585_g_CanBuyTips = {
	[IDENTITY_COOKING_IDX] = "#{SZSW_231228_56}",
	[IDENTITY_PHARMACY_IDX] = "#{SZSW_231228_57}",
	[IDENTITY_ATTACKEQUIP_IDX] = "#{SZSW_231228_58}",
	[IDENTITY_ENGINEER_IDX] = "#{SZSW_231228_60}",
}
--**********************************
--任务入口函数
--**********************************
function x998585_OnDefaultEvent( sceneId, selfId, targetId,opId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998585_g_NpcList[nMonsterDataId] == nil then
		return
	end
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	--盟会商店
	if opId == 2 then
		if GetLevel(sceneId,selfId) < x998585_g_MinLevel then
			x998585_NotifyTips( sceneId, selfId, "#{SZSW_231228_32}")
			return
		end
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			x998585_NotifyTips( sceneId, selfId, "#{SZSW_231228_33}")
			return
		end
		if nCurIdentityId == 0 then
			x998585_MsgBox( sceneId, selfId,targetId, "#{SZSW_231228_62}")
			return
		end
		--判定盟会身份是否符合
		if x998585_g_NpcList[nMonsterDataId].IdentityId ~= nCurIdentityId then
			x998585_MsgBox( sceneId, selfId, targetId, x998585_g_CanBuyTips[nCurIdentityId] )
			return
		end
--		LuaFnSendIdentityShopInfo(sceneId,selfId,targetId)
		DispatchShopItem( sceneId, selfId,targetId, x998585_g_NpcList[nMonsterDataId].shopId )
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x998585_OnEventRequest( sceneId, selfId, targetId, eventId )
	
end

--**********************************
--列举事件
--**********************************
function x998585_OnEnumerate( sceneId, selfId, targetId )
	local nMonsterDataId = GetMonsterDataID(sceneId,targetId)
	if x998585_g_NpcList[nMonsterDataId] == nil then
		return
	end
	AddText(sceneId,x998585_g_NpcList[nMonsterDataId].mainStr);
	--盟会商店
	AddNumText(sceneId, x998585_g_ScriptId, x998585_g_NpcList[nMonsterDataId].yulanStr, 7, 2)
end

--**********************************
-- 作废客户端调用
--**********************************
function x998585_OpenReputationShopMultiBuy(sceneId,selfId)
end

function x998585_ReputationShopBuyItem(sceneId,selfId)
end
--**********************************
-- 屏幕中间提示
--**********************************
function x998585_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x998585_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end