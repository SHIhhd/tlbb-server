--孙聚财
--元宝交易市场

x181005_g_scriptId 	= 181005

--**********************************
--事件交互入口
--**********************************
function x181005_OnDefaultEvent( sceneId, selfId, targetId )	
	BeginEvent( sceneId )
		AddText( sceneId, "#{YBSC_100111_41}" )
		--交易市场
		AddNumText( sceneId, x181005_g_scriptId, "#{YBSC_100111_43}", 7, 1)
		--管理我出售的商品
		AddNumText( sceneId, x181005_g_scriptId, "#{YBSC_100111_44}", 7, 2)
		--补收元宝
		AddNumText( sceneId, x181005_g_scriptId, "#{YBSC_100111_58}", 7, 3)
		
		AddNumText( sceneId, x181005_g_scriptId, "#{AUCTION_100108_5}", 11, 10)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x181005_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		--打开元宝交易市场
		CallScriptFunction(701900, "OpenYBMarket", sceneId, selfId, targetId )
	elseif GetNumText() == 2 then 
		--管理我出售的商品
		CallScriptFunction(701900, "OpenYBMarketSale", sceneId, selfId, targetId )
	elseif GetNumText() == 3 then 
		--补收元宝
		CallScriptFunction(701900, "TakeOutYuanbao", sceneId, selfId, targetId )
	elseif GetNumText() == 10 then    
		BeginEvent( sceneId )
			AddText( sceneId, "#{YBSC_100111_39}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
end

