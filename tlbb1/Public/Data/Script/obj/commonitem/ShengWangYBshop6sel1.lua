--物品 6选1礼盒
--脚本号
x890064_g_scriptId = 890064
x890064_g_MinLevel = 85
x890064_g_ItemList =
{
	[38002799]={20600009,20600015,20600021,20600027,20600033,20600039},--明镜铸图礼盒
	[38002800]={20600010,20600016,20600022,20600028,20600034,20600040},--双刺铸图礼盒
	[38002801]={20600011,20600017,20600023,20600029,20600035,20600041},--锁甲铸图礼盒
	[38002802]={20600012,20600018,20600024,20600030,20600036,20600042},--玉钩铸图礼盒
	[38002803]={20600013,20600019,20600025,20600031,20600037,20600043},--锦带铸图礼盒
	[38002804]={20600014,20600020,20600026,20600032,20600038,20600044},--短匕铸图礼盒
	[38002806]={38002799,38002800,38002801,38002802,38002803,38002804},--天鉴铸图自选礼盒
}
x890064_g_MinCount = 1;
--**********************************
--事件交互入口
--**********************************
function x890064_OnDefaultEvent( sceneId, selfId, bagIndex )
	if GetLevel(sceneId,selfId) < x890064_g_MinLevel then
		x890064_NotifyTips(sceneId, selfId, "#{SWXT_221213_205}");
		return 0;
	end
	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagIndex, 0 ) < 0 then
		x890064_NotifyTips( sceneId, selfId, "#{SWXT_221213_206}" )	--物品已加锁
		return 0
	end
	local itemIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagIndex );
	local tItem = x890064_g_ItemList[itemIndex];
	if not tItem then
		return 0;
	end
	BeginUICommand(sceneId)
	UICommand_AddInt(sceneId,bagIndex)
	for i=1,6 do
		UICommand_AddInt(sceneId,tItem[i])	--id
		UICommand_AddInt(sceneId,1)			--count
	end
	UICommand_AddInt(sceneId,x890064_g_scriptId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,89006401)
	
end
--**********************************
--自选返回
--**********************************
function x890064_ClientActivateOnce( sceneId, selfId, g_UseItemPos,g_ItemIndexSel )
	if GetLevel(sceneId,selfId) < x890064_g_MinLevel then
		x890064_NotifyTips(sceneId, selfId, "#{SWXT_221213_205}");
		return
	end
	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, g_UseItemPos, 0 ) < 0 then
		x890064_NotifyTips( sceneId, selfId, "#{SWXT_221213_206}" )	--物品已加锁
		return
	end
	local itemTblIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId,g_UseItemPos );
	local tItem = x890064_g_ItemList[itemTblIndex];
	if not tItem then
		return  
	end
	
	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then 
	    x890064_NotifyTips(sceneId, selfId, ScriptGlobal_Format("#{SWXT_221213_222}",x890064_g_MinCount,x890064_g_MinCount));
		return  
    end
	if g_ItemIndexSel < 1 or  tItem[g_ItemIndexSel]==nil  then 
	    x890064_NotifyTips(sceneId, selfId, "#{SWXT_221213_207}");
		return 0;
	end
	local addItemID = tItem[g_ItemIndexSel]
	
	if LuaFnDelAvailableItem(sceneId,selfId,itemTblIndex,1) ==1 then 
	    TryRecieveItem(sceneId,selfId,addItemID,1)
		x890064_NotifyTips(sceneId, selfId, 
			ScriptGlobal_Format("#{SWXT_221213_208}",1,"#{_ITEM"..addItemID.."}"));
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
	end
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
    DispatchUICommand(sceneId,selfId,89006402)
end
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x890064_IsSkillLikeScript( sceneId, selfId )
	return 0
end
--**********************************
-- 醒目失败提示
--**********************************
function x890064_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
