x260001_g_ScriptId = 260001
x260001_g_ObbpszCost = 2000000;
x260001_g_Mainitem = {10155003,10155005};
x260001_g_Othertem = {30008069,30008070};--20310115,20310116}; 
function x260001_AnqiConfirm( sceneId, selfId ,Bind_Item1,Bind_Item2)
	--先判断梅花镖修炼等级是否达到90级   暂时没有这个接口无法判断
	local DarkLevel = GetBagDarkLevel(sceneId,selfId,Bind_Item1)
	if DarkLevel < 90 then
		x260001_NotifyTips(sceneId,selfId,"#{AQSJ_090709_09}")
		return
	end
	--弹出提示框
	BeginUICommand( sceneId )
		UICommand_AddInt(sceneId,Bind_Item1)
		UICommand_AddInt(sceneId,Bind_Item2)
	EndUICommand(sceneId)
	DispatchUICommand( sceneId, selfId,260001)
end

function x260001_Anqi2Shenzhen( sceneId, selfId,Bind_Item1,Bind_Item2)
	if GetMoney(sceneId,selfId) + GetMoneyJZ(sceneId,selfId) < x260001_g_ObbpszCost then
		x260001_NotifyTips(sceneId,selfId,"#{AQSJ_090709_11}")
		return
	end
	local HaveEquipNum = LuaFnMtl_GetCostNum(sceneId,selfId,x260001_g_Mainitem[1],x260001_g_Mainitem[2])
	local HaveItemNum = LuaFnMtl_GetCostNum(sceneId,selfId,x260001_g_Othertem[1],x260001_g_Othertem[2])
	if HaveItemNum < 1 then
		x260001_NotifyTips(sceneId,selfId,"#{AQSJ_090709_28}")
		return
	end
	if HaveEquipNum < 1 then
		x260001_NotifyTips(sceneId,selfId,"#{AQSJ_090709_28}")
		return
	end
	--扣除寒冰星石、扣钱
	LuaFnCostMoneyWithPriority(sceneId,selfId,x260001_g_ObbpszCost)
	LuaFnMtl_CostMaterial(sceneId,selfId,1,x260001_g_Othertem[1],x260001_g_Othertem[2])
	--给提示，给神针
	LuaFnShenqiUpgrade(sceneId,selfId,Bind_Item1,10155002,5)
	x260001_NotifyTips(sceneId,selfId,"#{AQSJ_090709_12}")
	--发送系统公告
	local szEquipTrans = GetBagItemTransfer( sceneId, selfId, Bind_Item1 )
	AddGlobalCountNews(sceneId,
		format("#{_INFOUSR%s}#{AQSJ_090709_20}%s#{AQSJ_090709_21}#{_INFOMSG%s}#{AQSJ_090709_22}"
		,GetName(sceneId,selfId)
		,GetItemName(sceneId,30008069)
		,szEquipTrans
	))
end
--**********************************
-- 信息提示
--**********************************
function x260001_NotifyTips(sceneId, selfId, msg)
	BeginEvent( sceneId )
	AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
