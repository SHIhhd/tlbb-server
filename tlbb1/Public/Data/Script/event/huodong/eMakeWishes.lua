--许愿果兑换奖励
x808132_g_ScriptId = 808132
--兑换的奖励内容
x808132_g_ItemTbl = 
{	--奖励，所需物品，所需物品数量
	{itemid = 30900006,needitem = 20502010,neednum = 1},
	{itemid = 50413004,needitem = 20502010,neednum = 2}
}
--**********************************
-- 任务入口函数
--**********************************
function x808132_OnDefaultEvent( sceneId, selfId, targetId )	-- 点击该任务后执行此脚本
	local nNumText = GetNumText()
	if nNumText == 3 then
		BeginEvent(sceneId)
			for i,data in x808132_g_ItemTbl do
				AddNumText( sceneId, x808132_g_ScriptId,"#{SQXY_09061_22}"..GetItemName(sceneId,data.itemid),6,30 + i)
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--许愿果兑换天罡强化精华
	if nNumText >= 31 and nNumText <= 32 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SQXY_09061_22}"..GetItemName(sceneId,x808132_g_ItemTbl[mod(nNumText,10)].itemid).."#{SQXY_09061_23}"..x808132_g_ItemTbl[mod(nNumText,10)].neednum.."#{SQXY_09061_24}")
			AddNumText(sceneId,x808132_g_ScriptId,"#{SQXY_09061_25}",0,nNumText + 10)
			AddNumText(sceneId,x808132_g_ScriptId,"#{INTERFACE_XML_426}",0,1000)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--关闭界面
	if nNumText == 1000 then
		DispatchUICommand(sceneId,selfId,1000)
	end
	if nNumText >= 41 and nNumText <= 42 then
		--判断背包空间
		if mod(nNumText,10) == 1 then
			local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
			if nBagSize < 1 then
				x808132_NotifyFailBox( sceneId, selfId, targetId,"#{SQXY_09061_20}")
				return
			end
			BeginAddItem(sceneId)
				AddItem(sceneId,x808132_g_ItemTbl[mod(nNumText,10)].itemid,1)
			if EndAddItem(sceneId,selfId) <= 0 then
				x808132_NotifyFailBox( sceneId, selfId, targetId,"#{SQXY_09061_20}")
				return
			end
		else
			local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
			if nMaterialSize < 1 then
				x808132_NotifyFailBox( sceneId, selfId, targetId,"#{SQXY_09061_35}")
				return
			end
			BeginAddItem(sceneId)
				AddItem(sceneId,x808132_g_ItemTbl[mod(nNumText,10)].itemid,1)
			if EndAddItem(sceneId,selfId) <= 0 then
				x808132_NotifyFailBox( sceneId, selfId, targetId,"#{SQXY_09061_35}")
				return
			end
		end
		local nNeedNum = LuaFnGetAvailableItemCount(sceneId,selfId,x808132_g_ItemTbl[mod(nNumText,10)].needitem)
		if nNeedNum < x808132_g_ItemTbl[mod(nNumText,10)].neednum then
			x808132_NotifyFailBox( sceneId, selfId, targetId,"#{SQXY_09061_26}"..x808132_g_ItemTbl[mod(nNumText,10)].neednum.."#{SQXY_09061_27}")
			return
		end
		local nRet = LuaFnDelAvailableItem(sceneId,selfId,x808132_g_ItemTbl[mod(nNumText,10)].needitem,x808132_g_ItemTbl[mod(nNumText,10)].neednum)
		if nRet ~= 1 then
			x808132_NotifyFailBox( sceneId, selfId, targetId,"#{SQXY_09061_26}"..x808132_g_ItemTbl[mod(nNumText,10)].neednum.."#{SQXY_09061_27}")
			return
		end
		--上列判断都走完了，下来了，发放奖励物品
		local nPos = TryRecieveItem( sceneId,selfId,x808132_g_ItemTbl[mod(nNumText,10)].itemid, 1)
		if nPos == -1 then
			return
		end
		LuaFnItemBind(sceneId,selfId,nPos) --强制绑定兑换出来的物品，一定不能白嫖
		x808132_NotifyFailBox(sceneId,selfId,targetId,"#{SQXY_09061_28}")
		--好像有个系统提示呢。
		AddGlobalCountNews(sceneId,GetName(sceneId,selfId).."#{SQXY_09061_31}"..x808132_g_ItemTbl[mod(nNumText,10)].neednum.."#{SQXY_09061_32}"..GetItemName(sceneId,20502010).."#{SQXY_09061_33}"..GetItemName(sceneId,x808132_g_ItemTbl[mod(nNumText,10)].itemid).."#{SQXY_09061_34}")
	end
end

--**********************************
-- 列举事件
--**********************************
function x808132_OnEnumerate( sceneId, selfId, targetId )
end
--**********************************
-- 检测接受条件
--**********************************
function x808132_CheckAccept( sceneId, selfId )
end
--**********************************
--接受
--**********************************
function x808132_OnAccept( sceneId,selfId,targetId)
end
--**********************************
--继续
--**********************************
function x808132_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--放弃
--**********************************
function x808132_OnAbandon( sceneId, selfId )
end
--**********************************
--提交
--**********************************
function x808132_OnSubmit( sceneId, selfId, targetId, selectRadioId )
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x808132_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x808132_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
