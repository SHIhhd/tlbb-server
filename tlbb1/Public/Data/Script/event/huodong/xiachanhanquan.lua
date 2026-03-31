--夏日寒泉
x808137_g_ScriptId = 808137
--兑换的奖励内容
x808137_g_ItemTbl = 
{	--奖励，所需物品，所需物品数量
	{itemid = 30005045,needitem = 20502011,neednum = 10},
	{itemid = 30303063,needitem = 20502011,neednum = 120}
}
x808137_g_FailNotifyTbl = 
{
	"#{XCHQ_90601_5}","#{XCHQ_90601_9}"
}
x808137_g_OKNotifyTbl = 
{
	"#{XCHQ_90601_8}","#{XCHQ_90601_10}"
}
--**********************************
-- 任务入口函数
--**********************************
function x808137_OnDefaultEvent( sceneId, selfId, targetId )	-- 点击该任务后执行此脚本
	local nNumText = GetNumText()
	--关于夏蝉寒泉
	if nNumText == 7 then
		x808137_NotifyFailBox( sceneId, selfId, targetId,"#{XCHQ_90601_12}")
		return
	end
	if nNumText == 6 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XCHQ_90609_5}")
			AddNumText( sceneId, x808137_g_ScriptId,"#{XCHQ_90601_2}",6,61)
			AddNumText( sceneId, x808137_g_ScriptId,"#{XCHQ_90601_3}",6,62)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if nNumText >= 61 and nNumText <= 62 then
		--判断背包空间
		local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
		if nBagSize < 1 then
			x808137_NotifyFailTips( sceneId, selfId,"#{XCHQ_90601_7}")
			return
		end
		BeginAddItem(sceneId)
			AddItem(sceneId,x808137_g_ItemTbl[mod(nNumText,10)].itemid,1)
		if EndAddItem(sceneId,selfId) <= 0 then
			x808137_NotifyFailTips( sceneId, selfId,"#{XCHQ_90601_7}")
			return
		end
		local nNeedNum = LuaFnGetAvailableItemCount(sceneId,selfId,x808137_g_ItemTbl[mod(nNumText,10)].needitem)
		if nNeedNum < x808137_g_ItemTbl[mod(nNumText,10)].neednum then
			x808137_NotifyFailTips( sceneId, selfId,x808137_g_FailNotifyTbl[mod(nNumText,10)])
			return
		end
		local nRet = LuaFnDelAvailableItem(sceneId,selfId,x808137_g_ItemTbl[mod(nNumText,10)].needitem,x808137_g_ItemTbl[mod(nNumText,10)].neednum)
		if nRet ~= 1 then
			x808137_NotifyFailTips( sceneId, selfId,"#{XCHQ_90601_6}")
			return
		end
		--上列判断都走完了，下来了，发放奖励物品
		local nPos = TryRecieveItem( sceneId,selfId,x808137_g_ItemTbl[mod(nNumText,10)].itemid, 1)
		if nPos == -1 then
			return
		end
		LuaFnItemBind(sceneId,selfId,nPos) --强制绑定兑换出来的物品，一定不能白嫖
		x808137_NotifyFailTips(sceneId,selfId,x808137_g_OKNotifyTbl[mod(nNumText,10)])
	end
end

--**********************************
-- 列举事件
--**********************************
function x808137_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x808137_g_ScriptId,"#{XCHQ_90609_2}",6,6)
	AddNumText( sceneId, x808137_g_ScriptId,"#{XCHQ_90609_4}",11,7)
end
--**********************************
-- 检测接受条件
--**********************************
function x808137_CheckAccept( sceneId, selfId )
end
--**********************************
--接受
--**********************************
function x808137_OnAccept( sceneId,selfId,targetId)
end
--**********************************
--继续
--**********************************
function x808137_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--放弃
--**********************************
function x808137_OnAbandon( sceneId, selfId )
end
--**********************************
--提交
--**********************************
function x808137_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x808137_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x808137_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
