--曼陀商店

--脚本号
x893351_g_ScriptId = 893351

--商店号
x893351_g_shoptableindex=259

--商店名称
x893351_g_ShopName = "#{XMPSH_220628_1}"

--**********************************
--任务入口函数
--**********************************
function x893351_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId,targetId, x893351_g_shoptableindex )
end

--**********************************
--列举事件
--**********************************
function x893351_OnEnumerate( sceneId, selfId, targetId )
	--判断是否是本派弟子
	if GetMenPai(sceneId,selfId) == MP_MANTUO then
		AddNumText(sceneId,x893351_g_ScriptId,x893351_g_ShopName,7,-1)
    end
	return
end

--**********************************
--检测接受条件
--**********************************
function x893351_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x893351_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x893351_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x893351_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x893351_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x893351_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x893351_OnKillObject( sceneId, selfId, objdataId,objId)
end

--**********************************
--进入区域事件
--**********************************
function x893351_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x893351_OnItemChanged( sceneId, selfId, itemdataId )
end
