--元宝交易市场

-- 脚本号
x701900_g_ScriptId = 701900
x701900_g_YbMarket_UICommand_Id = 701900
x701900_g_YbMarket_UICommand_SubId = 1
x701900_g_YbMarketSale_UICommand_SubId = 2
--**********************************
-- 玩家登陆
--**********************************
function x701900_OnPlayerLogin(sceneId, selfId)
	if IsShutout(sceneId, selfId,ONOFF_T_YBMARKET) == 1 then
		--由于本服务器即将进行合服，请各位玩家速将自己存放在元宝交易市场中的商品取回
		LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{YBSC_100111_82}")
	end
end
--**********************************
-- 补收元宝
--**********************************
function x701900_TakeOutYuanbao(sceneId, selfId, targetId)
	local nCanGetYuanBao = GetMissionDataEx(sceneId,selfId,MDEX_YBMARKET_CANBUSHOUCOUNT)
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		return
	end
	--您没有可以补收的元宝
	if nCanGetYuanBao <= 0 then
		x701900_ShowTips(sceneId, selfId, "#{YBSC_100111_62}")
		return
	end
	local nCurYuanBao = YuanBao(sceneId,selfId,targetId,3)
	--200000000这个极限是程序限制死的，不能更改
	if nCurYuanBao + nCanGetYuanBao > 200000000 then
		x701900_ShowTips(sceneId, selfId, "#{YBSC_100111_61}")
		return
	end
	--补收
	YuanBao(sceneId,selfId,targetId,1,nCurYuanBao + nCanGetYuanBao)
	SetMissionDataEx(sceneId,selfId,MDEX_YBMARKET_CANBUSHOUCOUNT,0)
	
	x701900_ShowTips(sceneId, selfId, ScriptGlobal_Format("#{YBSC_100111_63}",tostring(nCanGetYuanBao)))
	
	BeginEvent( sceneId )
		AddText( sceneId,ScriptGlobal_Format("#{YBSC_100111_64}",tostring(nCanGetYuanBao)) )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
-- 打开元宝交易市场
--**********************************
function x701900_OpenYBMarket(sceneId, selfId, targetId)
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		return
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		UICommand_AddInt( sceneId, x701900_g_YbMarket_UICommand_SubId)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, x701900_g_YbMarket_UICommand_Id )
end
--**********************************
-- 打开元宝交易市场上架物品管理
--**********************************
function x701900_OpenYBMarketSale(sceneId, selfId, targetId)
	if IsInDist(sceneId,selfId,targetId,6) == 0 then
		return
	end
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		UICommand_AddInt( sceneId, x701900_g_YbMarketSale_UICommand_SubId)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, x701900_g_YbMarket_UICommand_Id )
end
--**********************************
-- 提示信息
--**********************************
function x701900_ShowTips(sceneId, selfId, tipMsg)
	BeginEvent(sceneId);
		AddText(sceneId, tipMsg);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
