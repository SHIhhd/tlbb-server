--坐骑商店
--叶婆婆
x893269_g_shoptableindex=258

--**********************************
--事件交互入口
--**********************************
function x893269_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x893269_g_shoptableindex )
end
